From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 2/2] f2fs: remove the orphan block page array
Date: Mon, 20 Jan 2014 18:37:30 +0800
Message-ID: <52DCFC6A.8060200@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim <jaegeuk.kim@samsung.com>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

As the orphan_blocks may be max to 504, so it is not security
and rigorous to store such a large array in the kernel stack
as Dan Carpenter said.
In fact, grab_meta_page has locked the page in the page cache,
and we can use find_get_page() to fetch the page safely in the
downstream, so we can remove the page array directly.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/checkpoint.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f9d4f7d..ed82de6 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -311,11 +311,10 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 	unsigned short orphan_blocks = (unsigned short)((sbi->n_orphans +
 		(F2FS_ORPHANS_PER_BLOCK - 1)) / F2FS_ORPHANS_PER_BLOCK);
 	struct page *page = NULL;
-	struct page *pages[orphan_blocks];
 	struct orphan_inode_entry *orphan = NULL;
 
 	for (index = 0; index < orphan_blocks; index++)
-		pages[index] = grab_meta_page(sbi, start_blk + index);
+		grab_meta_page(sbi, start_blk + index);
 
 	index = 1;
 	spin_lock(&sbi->orphan_inode_lock);
@@ -324,10 +323,12 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 	/* loop for each orphan inode entry and write them in Jornal block */
 	list_for_each_entry(orphan, head, list) {
 		if (!page) {
-			page = pages[index - 1];
+			page = find_get_page(META_MAPPING(sbi), start_blk++);
+			f2fs_bug_on(!page);
 			orphan_blk =
 				(struct f2fs_orphan_block *)page_address(page);
 			memset(orphan_blk, 0, sizeof(*orphan_blk));
+			f2fs_put_page(page, 0);
 		}
 
 		orphan_blk->ino[nentries++] = cpu_to_le32(orphan->ino);
-- 
1.7.7
