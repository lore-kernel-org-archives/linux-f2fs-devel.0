From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH V2 2/4] f2fs: remove the needless point-cast
Date: Fri, 27 Jun 2014 17:57:04 +0800
Message-ID: <53AD3FF0.6080909@cn.fujitsu.com>
References: <53A950BB.2030703@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <53A950BB.2030703@cn.fujitsu.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, fsdevel <linux-fsdevel@vger.kernel.org>, =?UTF-8?B?7J207LC966eM?= <cm224.lee@samsung.com>, =?UTF-8?B?5L+e6LaF?= <chao2.yu@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
v2: fix the same issue in f2fs_delete_entry suggested by Yu Chao.
---
---
 fs/f2fs/dir.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 087b03d..bcbfbc4 100644
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
@@ -570,14 +569,13 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	struct address_space *mapping = page->mapping;
 	struct inode *dir = mapping->host;
 	int slots = GET_DENTRY_SLOTS(le16_to_cpu(dentry->name_len));
-	void *kaddr = page_address(page);
 	int i;
 
 	lock_page(page);
 	f2fs_wait_on_page_writeback(page, DATA);
 
-	dentry_blk = (struct f2fs_dentry_block *)kaddr;
-	bit_pos = dentry - (struct f2fs_dir_entry *)dentry_blk->dentry;
+	dentry_blk = page_address(page);
+	bit_pos = dentry - dentry_blk->dentry;
 	for (i = 0; i < slots; i++)
 		test_and_clear_bit_le(bit_pos + i, &dentry_blk->dentry_bitmap);
 
@@ -632,7 +630,6 @@ bool f2fs_empty_dir(struct inode *dir)
 	unsigned long nblock = dir_blocks(dir);
 
 	for (bidx = 0; bidx < nblock; bidx++) {
-		void *kaddr;
 		dentry_page = get_lock_data_page(dir, bidx);
 		if (IS_ERR(dentry_page)) {
 			if (PTR_ERR(dentry_page) == -ENOENT)
@@ -641,8 +638,8 @@ bool f2fs_empty_dir(struct inode *dir)
 				return false;
 		}
 
-		kaddr = kmap_atomic(dentry_page);
-		dentry_blk = (struct f2fs_dentry_block *)kaddr;
+
+		dentry_blk = kmap_atomic(dentry_page);
 		if (bidx == 0)
 			bit_pos = 2;
 		else
@@ -650,7 +647,7 @@ bool f2fs_empty_dir(struct inode *dir)
 		bit_pos = find_next_bit_le(&dentry_blk->dentry_bitmap,
 						NR_DENTRY_IN_BLOCK,
 						bit_pos);
-		kunmap_atomic(kaddr);
+		kunmap_atomic(dentry_blk);
 
 		f2fs_put_page(dentry_page, 1);
 
-- 
1.7.7


