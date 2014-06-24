From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 2/4] f2fs: remove the needless point-cast
Date: Tue, 24 Jun 2014 18:19:39 +0800
Message-ID: <53A950BB.2030703@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, fsdevel <linux-fsdevel@vger.kernel.org>, =?UTF-8?B?7J207LC966eM?= <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/dir.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 087b03d..3edd561 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -298,14 +298,13 @@ static int make_empty_dir(struct inode *inode,
 	struct page *dentry_page;
 	struct f2fs_dentry_block *dentry_blk;
 	struct f2fs_dir_entry *de;
-	void *kaddr;
 
 	dentry_page = get_new_data_page(inode, page, 0, true);
 	if (IS_ERR(dentry_page))
 		return PTR_ERR(dentry_page);
 
-	kaddr = kmap_atomic(dentry_page);
-	dentry_blk = (struct f2fs_dentry_block *)kaddr;
+
+	dentry_blk = kmap_atomic(dentry_page);
 
 	de = &dentry_blk->dentry[0];
 	de->name_len = cpu_to_le16(1);
@@ -323,7 +322,7 @@ static int make_empty_dir(struct inode *inode,
 
 	test_and_set_bit_le(0, &dentry_blk->dentry_bitmap);
 	test_and_set_bit_le(1, &dentry_blk->dentry_bitmap);
-	kunmap_atomic(kaddr);
+	kunmap_atomic(dentry_blk);
 
 	set_page_dirty(dentry_page);
 	f2fs_put_page(dentry_page, 1);
@@ -632,7 +631,6 @@ bool f2fs_empty_dir(struct inode *dir)
 	unsigned long nblock = dir_blocks(dir);
 
 	for (bidx = 0; bidx < nblock; bidx++) {
-		void *kaddr;
 		dentry_page = get_lock_data_page(dir, bidx);
 		if (IS_ERR(dentry_page)) {
 			if (PTR_ERR(dentry_page) == -ENOENT)
@@ -641,8 +639,8 @@ bool f2fs_empty_dir(struct inode *dir)
 				return false;
 		}
 
-		kaddr = kmap_atomic(dentry_page);
-		dentry_blk = (struct f2fs_dentry_block *)kaddr;
+
+		dentry_blk = kmap_atomic(dentry_page);
 		if (bidx == 0)
 			bit_pos = 2;
 		else
@@ -650,7 +648,7 @@ bool f2fs_empty_dir(struct inode *dir)
 		bit_pos = find_next_bit_le(&dentry_blk->dentry_bitmap,
 						NR_DENTRY_IN_BLOCK,
 						bit_pos);
-		kunmap_atomic(kaddr);
+		kunmap_atomic(dentry_blk);
 
 		f2fs_put_page(dentry_page, 1);
 
-- 
1.7.7

