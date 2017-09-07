From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: make get_lock_data_page to handle encrypted inode
Date: Wed,  6 Sep 2017 21:46:09 -0700
Message-ID: <20170907044609.5533-1-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch refactors get_lock_data_page() to handle encryption case directly.
In order to do that, it introduces common f2fs_submit_page_read().

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 109 +++++++++++++++++++++++++++------------------------------
 1 file changed, 51 insertions(+), 58 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ee6801fdbdec..95f30f0000b6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -456,6 +456,53 @@ int f2fs_submit_page_write(struct f2fs_io_info *fio)
 	return err;
 }
 
+static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
+							 unsigned nr_pages)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct fscrypt_ctx *ctx = NULL;
+	struct bio *bio;
+
+	if (f2fs_encrypted_file(inode)) {
+		ctx = fscrypt_get_ctx(inode, GFP_NOFS);
+		if (IS_ERR(ctx))
+			return ERR_CAST(ctx);
+
+		/* wait the page to be moved by cleaning */
+		f2fs_wait_on_block_writeback(sbi, blkaddr);
+	}
+
+	bio = bio_alloc(GFP_KERNEL, min_t(int, nr_pages, BIO_MAX_PAGES));
+	if (!bio) {
+		if (ctx)
+			fscrypt_release_ctx(ctx);
+		return ERR_PTR(-ENOMEM);
+	}
+	f2fs_target_device(sbi, blkaddr, bio);
+	bio->bi_end_io = f2fs_read_end_io;
+	bio->bi_private = ctx;
+	bio_set_op_attrs(bio, REQ_OP_READ, 0);
+
+	return bio;
+}
+
+/* This can handle encryption stuffs */
+static int f2fs_submit_page_read(struct inode *inode, struct page *page,
+							block_t blkaddr)
+{
+	struct bio *bio = f2fs_grab_read_bio(inode, blkaddr, 1);
+
+	if (IS_ERR(bio))
+		return PTR_ERR(bio);
+
+	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
+		bio_put(bio);
+		return -EFAULT;
+	}
+	__submit_bio(F2FS_I_SB(inode), bio, DATA);
+	return 0;
+}
+
 static void __set_data_blkaddr(struct dnode_of_data *dn)
 {
 	struct f2fs_node *rn = F2FS_NODE(dn->node_page);
@@ -573,16 +620,6 @@ struct page *get_read_data_page(struct inode *inode, pgoff_t index,
 	struct page *page;
 	struct extent_info ei = {0,0,0};
 	int err;
-	struct f2fs_io_info fio = {
-		.sbi = F2FS_I_SB(inode),
-		.type = DATA,
-		.op = REQ_OP_READ,
-		.op_flags = op_flags,
-		.encrypted_page = NULL,
-	};
-
-	if (f2fs_encrypted_file(inode))
-		return read_mapping_page(mapping, index, NULL);
 
 	page = f2fs_grab_cache_page(mapping, index, for_write);
 	if (!page)
@@ -623,9 +660,7 @@ struct page *get_read_data_page(struct inode *inode, pgoff_t index,
 		return page;
 	}
 
-	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
-	fio.page = page;
-	err = f2fs_submit_page_bio(&fio);
+	err = f2fs_submit_page_read(inode, page, dn.data_blkaddr);
 	if (err)
 		goto put_err;
 	return page;
@@ -1150,35 +1185,6 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	return ret;
 }
 
-static struct bio *f2fs_grab_bio(struct inode *inode, block_t blkaddr,
-				 unsigned nr_pages)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct fscrypt_ctx *ctx = NULL;
-	struct bio *bio;
-
-	if (f2fs_encrypted_file(inode)) {
-		ctx = fscrypt_get_ctx(inode, GFP_NOFS);
-		if (IS_ERR(ctx))
-			return ERR_CAST(ctx);
-
-		/* wait the page to be moved by cleaning */
-		f2fs_wait_on_block_writeback(sbi, blkaddr);
-	}
-
-	bio = bio_alloc(GFP_KERNEL, min_t(int, nr_pages, BIO_MAX_PAGES));
-	if (!bio) {
-		if (ctx)
-			fscrypt_release_ctx(ctx);
-		return ERR_PTR(-ENOMEM);
-	}
-	f2fs_target_device(sbi, blkaddr, bio);
-	bio->bi_end_io = f2fs_read_end_io;
-	bio->bi_private = ctx;
-
-	return bio;
-}
-
 /*
  * This function was originally taken from fs/mpage.c, and customized for f2fs.
  * Major change was from block_size == page_size in f2fs by default.
@@ -1275,12 +1281,11 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 			bio = NULL;
 		}
 		if (bio == NULL) {
-			bio = f2fs_grab_bio(inode, block_nr, nr_pages);
+			bio = f2fs_grab_read_bio(inode, block_nr, nr_pages);
 			if (IS_ERR(bio)) {
 				bio = NULL;
 				goto set_error_page;
 			}
-			bio_set_op_attrs(bio, REQ_OP_READ, 0);
 		}
 
 		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
@@ -1989,21 +1994,9 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 		zero_user_segment(page, 0, PAGE_SIZE);
 		SetPageUptodate(page);
 	} else {
-		struct bio *bio;
-
-		bio = f2fs_grab_bio(inode, blkaddr, 1);
-		if (IS_ERR(bio)) {
-			err = PTR_ERR(bio);
-			goto fail;
-		}
-		bio->bi_opf = REQ_OP_READ;
-		if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
-			bio_put(bio);
-			err = -EFAULT;
+		err = f2fs_submit_page_read(inode, page, blkaddr);
+		if (err)
 			goto fail;
-		}
-
-		__submit_bio(sbi, bio, DATA);
 
 		lock_page(page);
 		if (unlikely(page->mapping != mapping)) {
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
