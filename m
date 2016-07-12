From: Chao Yu <chao@kernel.org>
Subject: [PATCH v2 1/4] f2fs: fix to avoid reading out encrypted data in page cache
Date: Tue, 12 Jul 2016 23:15:55 +0800
Message-ID: <1468336555-4844-1-git-send-email-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

For encrypted inode, if user overwrites data of the inode, f2fs will read
encrypted data into page cache, and then do the decryption.

However reader can race with overwriter, and it will see encrypted data
which has not been decrypted by overwriter yet. Fix it by moving decrypting
work to background and keep page non-uptodated until data is decrypted.

Thread A				Thread B
- f2fs_file_write_iter
 - __generic_file_write_iter
  - generic_perform_write
   - f2fs_write_begin
    - f2fs_submit_page_bio
					- generic_file_read_iter
					 - do_generic_file_read
					  - lock_page_killable
					  - unlock_page
					  - copy_page_to_iter
					  hit the encrypted data in updated page
    - lock_page
    - fscrypt_decrypt_page

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v2: fix a bug of handling error number of f2fs_grab_bio reported by Dan Carpenter.
 fs/f2fs/data.c | 90 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 48 insertions(+), 42 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ba4963f..f2b1249 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -955,6 +955,37 @@ out:
 	return ret;
 }
 
+struct bio *f2fs_grab_bio(struct inode *inode, block_t blkaddr,
+							unsigned nr_pages)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct fscrypt_ctx *ctx = NULL;
+	struct block_device *bdev = sbi->sb->s_bdev;
+	struct bio *bio;
+
+	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode)) {
+		ctx = fscrypt_get_ctx(inode, GFP_NOFS);
+		if (IS_ERR(ctx))
+			return ERR_CAST(ctx);
+
+		/* wait the page to be moved by cleaning */
+		f2fs_wait_on_encrypted_page_writeback(sbi, blkaddr);
+	}
+
+	bio = bio_alloc(GFP_KERNEL, min_t(int, nr_pages, BIO_MAX_PAGES));
+	if (!bio) {
+		if (ctx)
+			fscrypt_release_ctx(ctx);
+		return ERR_PTR(-ENOMEM);
+	}
+	bio->bi_bdev = bdev;
+	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(blkaddr);
+	bio->bi_end_io = f2fs_read_end_io;
+	bio->bi_private = ctx;
+
+	return bio;
+}
+
 /*
  * This function was originally taken from fs/mpage.c, and customized for f2fs.
  * Major change was from block_size == page_size in f2fs by default.
@@ -973,7 +1004,6 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 	sector_t last_block;
 	sector_t last_block_in_file;
 	sector_t block_nr;
-	struct block_device *bdev = inode->i_sb->s_bdev;
 	struct f2fs_map_blocks map;
 
 	map.m_pblk = 0;
@@ -1048,31 +1078,11 @@ submit_and_realloc:
 			bio = NULL;
 		}
 		if (bio == NULL) {
-			struct fscrypt_ctx *ctx = NULL;
-
-			if (f2fs_encrypted_inode(inode) &&
-					S_ISREG(inode->i_mode)) {
-
-				ctx = fscrypt_get_ctx(inode, GFP_NOFS);
-				if (IS_ERR(ctx))
-					goto set_error_page;
-
-				/* wait the page to be moved by cleaning */
-				f2fs_wait_on_encrypted_page_writeback(
-						F2FS_I_SB(inode), block_nr);
-			}
-
-			bio = bio_alloc(GFP_KERNEL,
-				min_t(int, nr_pages, BIO_MAX_PAGES));
-			if (!bio) {
-				if (ctx)
-					fscrypt_release_ctx(ctx);
+			bio = f2fs_grab_bio(inode, block_nr, nr_pages);
+			if (IS_ERR(bio)) {
+				bio = NULL;
 				goto set_error_page;
 			}
-			bio->bi_bdev = bdev;
-			bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(block_nr);
-			bio->bi_end_io = f2fs_read_end_io;
-			bio->bi_private = ctx;
 		}
 
 		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
@@ -1622,18 +1632,21 @@ repeat:
 	if (blkaddr == NEW_ADDR) {
 		zero_user_segment(page, 0, PAGE_SIZE);
 	} else {
-		struct f2fs_io_info fio = {
-			.sbi = sbi,
-			.type = DATA,
-			.rw = READ_SYNC,
-			.old_blkaddr = blkaddr,
-			.new_blkaddr = blkaddr,
-			.page = page,
-			.encrypted_page = NULL,
-		};
-		err = f2fs_submit_page_bio(&fio);
-		if (err)
+		struct bio *bio;
+
+		bio = f2fs_grab_bio(inode, blkaddr, 1);
+		if (IS_ERR(bio)) {
+			err = PTR_ERR(bio);
 			goto fail;
+		}
+
+		if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
+			bio_put(bio);
+			err = -EFAULT;
+			goto fail;
+		}
+
+		__submit_bio(sbi, READ_SYNC, bio, DATA);
 
 		lock_page(page);
 		if (unlikely(!PageUptodate(page))) {
@@ -1644,13 +1657,6 @@ repeat:
 			f2fs_put_page(page, 1);
 			goto repeat;
 		}
-
-		/* avoid symlink page */
-		if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode)) {
-			err = fscrypt_decrypt_page(page);
-			if (err)
-				goto fail;
-		}
 	}
 out_update:
 	SetPageUptodate(page);
-- 
2.7.2
