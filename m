From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: assign REQ_RAHEAD to bio for ->readpages
Date: Thu, 21 Jun 2018 12:32:13 -0700
Message-ID: <20180621193213.86850-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>
List-Id: linux-f2fs-devel.lists.sourceforge.net

As Jens reported, we'd better assign REQ_RAHEAD to bio by the fact that
->readpages is called only from read-ahead.

In Documentation/filesystems/vfs.txt,

readpages: called by the VM to read pages associated with the address_space
  	object. This is essentially just a vector version of
  	readpage.  Instead of just one page, several pages are
  	requested.
	readpages is only used for read-ahead, so read errors are
  	ignored.  If anything goes wrong, feel free to give up.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8f931d699287..bc28ae5ae1ad 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -534,7 +534,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 }
 
 static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
-							 unsigned nr_pages)
+					unsigned nr_pages, unsigned op_flag)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct bio *bio;
@@ -546,7 +546,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 		return ERR_PTR(-ENOMEM);
 	f2fs_target_device(sbi, blkaddr, bio);
 	bio->bi_end_io = f2fs_read_end_io;
-	bio_set_op_attrs(bio, REQ_OP_READ, 0);
+	bio_set_op_attrs(bio, REQ_OP_READ, op_flag);
 
 	if (f2fs_encrypted_file(inode))
 		post_read_steps |= 1 << STEP_DECRYPT;
@@ -571,7 +571,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 							block_t blkaddr)
 {
-	struct bio *bio = f2fs_grab_read_bio(inode, blkaddr, 1);
+	struct bio *bio = f2fs_grab_read_bio(inode, blkaddr, 1, 0);
 
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
@@ -1421,10 +1421,15 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 /*
  * This function was originally taken from fs/mpage.c, and customized for f2fs.
  * Major change was from block_size == page_size in f2fs by default.
+ *
+ * Note that the aops->readpages() function is ONLY used for read-ahead. If
+ * this function ever deviates from doing just read-ahead, it should either
+ * use ->readpage() or do the necessary surgery to decouple ->readpages()
+ * from read-ahead.
  */
 static int f2fs_mpage_readpages(struct address_space *mapping,
 			struct list_head *pages, struct page *page,
-			unsigned nr_pages)
+			unsigned nr_pages, bool is_readahead)
 {
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
@@ -1514,7 +1519,8 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 			bio = NULL;
 		}
 		if (bio == NULL) {
-			bio = f2fs_grab_read_bio(inode, block_nr, nr_pages);
+			bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
+					is_readahead ? REQ_RAHEAD : 0);
 			if (IS_ERR(bio)) {
 				bio = NULL;
 				goto set_error_page;
@@ -1558,7 +1564,7 @@ static int f2fs_read_data_page(struct file *file, struct page *page)
 	if (f2fs_has_inline_data(inode))
 		ret = f2fs_read_inline_data(inode, page);
 	if (ret == -EAGAIN)
-		ret = f2fs_mpage_readpages(page->mapping, NULL, page, 1);
+		ret = f2fs_mpage_readpages(page->mapping, NULL, page, 1, false);
 	return ret;
 }
 
@@ -1575,7 +1581,7 @@ static int f2fs_read_data_pages(struct file *file,
 	if (f2fs_has_inline_data(inode))
 		return 0;
 
-	return f2fs_mpage_readpages(mapping, pages, NULL, nr_pages);
+	return f2fs_mpage_readpages(mapping, pages, NULL, nr_pages, true);
 }
 
 static int encrypt_one_page(struct f2fs_io_info *fio)
-- 
2.17.0.441.gb46fe60e1d-goog
