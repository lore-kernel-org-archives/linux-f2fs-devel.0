From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2 1/2] f2fs: avoid duplicated code by reusing f2fs_read_end_io
Date: Mon, 25 May 2015 18:03:38 +0800
Message-ID: <00d301d096d2$2b7a2c70$826e8550$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch tries to clean up code because part code of f2fs_read_end_io
and mpage_end_io are the same, so it's better to merge and reuse them.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
v2:
 * do not merge 'f2fs_end_io_crypto_work' and 'return' to indicate
   f2fs_end_io_crypto_work is defined to be a void returned function.

 fs/f2fs/data.c | 32 ++++----------------------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8d04e24..9bedfa8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -34,29 +34,6 @@ static void f2fs_read_end_io(struct bio *bio, int err)
 	struct bio_vec *bvec;
 	int i;
 
-	bio_for_each_segment_all(bvec, bio, i) {
-		struct page *page = bvec->bv_page;
-
-		if (!err) {
-			SetPageUptodate(page);
-		} else {
-			ClearPageUptodate(page);
-			SetPageError(page);
-		}
-		unlock_page(page);
-	}
-	bio_put(bio);
-}
-
-/*
- * I/O completion handler for multipage BIOs.
- * copied from fs/mpage.c
- */
-static void mpage_end_io(struct bio *bio, int err)
-{
-	struct bio_vec *bv;
-	int i;
-
 	if (f2fs_bio_encrypted(bio)) {
 		if (err) {
 			f2fs_release_crypto_ctx(bio->bi_private);
@@ -66,8 +43,8 @@ static void mpage_end_io(struct bio *bio, int err)
 		}
 	}
 
-	bio_for_each_segment_all(bv, bio, i) {
-		struct page *page = bv->bv_page;
+	bio_for_each_segment_all(bvec, bio, i) {
+		struct page *page = bvec->bv_page;
 
 		if (!err) {
 			SetPageUptodate(page);
@@ -77,7 +54,6 @@ static void mpage_end_io(struct bio *bio, int err)
 		}
 		unlock_page(page);
 	}
-
 	bio_put(bio);
 }
 
@@ -122,7 +98,7 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
 	bio->bi_bdev = sbi->sb->s_bdev;
 	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(blk_addr);
 	bio->bi_end_io = is_read ? f2fs_read_end_io : f2fs_write_end_io;
-	bio->bi_private = sbi;
+	bio->bi_private = is_read ? NULL : sbi;
 
 	return bio;
 }
@@ -1584,7 +1560,7 @@ submit_and_realloc:
 			}
 			bio->bi_bdev = bdev;
 			bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(block_nr);
-			bio->bi_end_io = mpage_end_io;
+			bio->bi_end_io = f2fs_read_end_io;
 			bio->bi_private = ctx;
 		}
 
-- 
2.3.0
