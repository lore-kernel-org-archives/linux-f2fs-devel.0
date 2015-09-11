From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/7] f2fs: do in batches truncation in truncate_hole
Date: Fri, 11 Sep 2015 14:38:05 +0800
Message-ID: <00f201d0ec5c$8274e670$875eb350$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

truncate_data_blocks_range can do in batches truncation which makes all
changes in dnode page content, dnode page status, extent cache, block
count updating together.

But previously, truncate_hole() always truncates one block in dnode page
at a time by invoking truncate_data_blocks_range(,1), which make thing
slow.

This patch changes truncate_hole() to do in batches truncation for all
target blocks in one direct node inside truncate_data_blocks_range, which
can make our punch hole operation in ->fallocate more efficent.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b2fab9e..ac97f78 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -738,23 +738,33 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 
 int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end)
 {
-	pgoff_t index;
+	pgoff_t count, index = pg_start;
 	int err;
 
-	for (index = pg_start; index < pg_end; index++) {
+	while (index < pg_end) {
 		struct dnode_of_data dn;
+		pgoff_t end_offset;
 
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		err = get_dnode_of_data(&dn, index, LOOKUP_NODE);
 		if (err) {
-			if (err == -ENOENT)
+			if (err == -ENOENT) {
+				index = PGOFS_OF_NEXT_DNODE(index,
+							F2FS_I(inode));
 				continue;
+			}
 			return err;
 		}
 
-		if (dn.data_blkaddr != NULL_ADDR)
-			truncate_data_blocks_range(&dn, 1);
+		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
+		count = min(end_offset - dn.ofs_in_node, pg_end - index);
+
+		f2fs_bug_on(F2FS_I_SB(inode), count == 0 || count > end_offset);
+
+		truncate_data_blocks_range(&dn, count);
 		f2fs_put_dnode(&dn);
+
+		index += count;
 	}
 	return 0;
 }
-- 
2.4.2
