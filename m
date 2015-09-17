From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2 2/7] f2fs: do in batches truncation in truncate_hole
Date: Thu, 17 Sep 2015 20:22:44 +0800
Message-ID: <009b01d0f143$a68066c0$f3813440$@samsung.com>
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
v2:
 changing slightly like below which is suggested by Jaegeuk:
 o don't have to use index variable
 o should not skip the entire dnode indices, when one of them is -ENOENT
 fs/f2fs/file.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 27a789c..6702157 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -739,23 +739,31 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 
 int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end)
 {
-	pgoff_t index;
 	int err;
 
-	for (index = pg_start; index < pg_end; index++) {
+	while (pg_start < pg_end) {
 		struct dnode_of_data dn;
+		pgoff_t end_offset, count;
 
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
-		err = get_dnode_of_data(&dn, index, LOOKUP_NODE);
+		err = get_dnode_of_data(&dn, pg_start, LOOKUP_NODE);
 		if (err) {
-			if (err == -ENOENT)
+			if (err == -ENOENT) {
+				pg_start++;
 				continue;
+			}
 			return err;
 		}
 
-		if (dn.data_blkaddr != NULL_ADDR)
-			truncate_data_blocks_range(&dn, 1);
+		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
+		count = min(end_offset - dn.ofs_in_node, pg_end - pg_start);
+
+		f2fs_bug_on(F2FS_I_SB(inode), count == 0 || count > end_offset);
+
+		truncate_data_blocks_range(&dn, count);
 		f2fs_put_dnode(&dn);
+
+		pg_start += count;
 	}
 	return 0;
 }
-- 
2.5.2
