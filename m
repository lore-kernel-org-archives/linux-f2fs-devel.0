From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH v2] f2fs: move all the bio initialization into
	__bio_alloc
Date: Thu, 19 Dec 2013 17:30:47 +0800
Message-ID: <52B2BCC7.7060303@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1Vta3P-0001Jd-HM
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Dec 2013 09:38:03 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vta3N-00031V-DI for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Dec 2013 09:38:03 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kim <jaegeuk.kim@samsung.com>
Cc: fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

Move all the bio initialization into __bio_alloc, and some minor cleanups are
also added.

v2:
  Use 'is_read' rather than 'rw' as Yu Chao suggested.
  Remove the needless initialization of bio->bi_private.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/data.c |   92 +++++++++++++++++++++++++------------------------------
 1 files changed, 42 insertions(+), 50 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9bdacc6..701e6fc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -24,20 +24,6 @@
 #include "segment.h"
 #include <trace/events/f2fs.h>
 
-/*
- * Low-level block read/write IO operations.
- */
-static struct bio *__bio_alloc(struct block_device *bdev, int npages)
-{
-	struct bio *bio;
-
-	/* No failure on bio allocation */
-	bio = bio_alloc(GFP_NOIO, npages);
-	bio->bi_bdev = bdev;
-	bio->bi_private = NULL;
-	return bio;
-}
-
 static void f2fs_read_end_io(struct bio *bio, int err)
 {
 	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
@@ -93,6 +79,24 @@ static void f2fs_write_end_io(struct bio *bio, int err)
 	bio_put(bio);
 }
 
+/*
+ * Low-level block read/write IO operations.
+ */
+static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
+				int npages, int rw)
+{
+	struct bio *bio;
+
+	/* No failure on bio allocation */
+	bio = bio_alloc(GFP_NOIO, npages);
+
+	bio->bi_bdev = sbi->sb->s_bdev;
+	bio->bi_sector = SECTOR_FROM_BLOCK(sbi, blk_addr);
+	bio->bi_end_io = rw ? f2fs_read_end_io : f2fs_write_end_io;
+
+	return bio;
+}
+
 static void __submit_merged_bio(struct f2fs_bio_info *io)
 {
 	struct f2fs_io_info *fio = &io->fio;
@@ -104,25 +108,26 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 	rw = fio->rw | fio->rw_flag;
 
 	if (is_read_io(rw)) {
-		trace_f2fs_submit_read_bio(io->sbi->sb, rw, fio->type, io->bio);
+		trace_f2fs_submit_read_bio(io->sbi->sb, rw,
+						fio->type, io->bio);
 		submit_bio(rw, io->bio);
-		io->bio = NULL;
-		return;
-	}
-	trace_f2fs_submit_write_bio(io->sbi->sb, rw, fio->type, io->bio);
-
-	/*
-	 * META_FLUSH is only from the checkpoint procedure, and we should wait
-	 * this metadata bio for FS consistency.
-	 */
-	if (fio->type == META_FLUSH) {
-		DECLARE_COMPLETION_ONSTACK(wait);
-		io->bio->bi_private = &wait;
-		submit_bio(rw, io->bio);
-		wait_for_completion(&wait);
 	} else {
-		submit_bio(rw, io->bio);
+		trace_f2fs_submit_write_bio(io->sbi->sb, rw,
+						fio->type, io->bio);
+		/*
+		 * META_FLUSH is only from the checkpoint procedure, and we
+		 * should wait this metadata bio for FS consistency.
+		 */
+		if (fio->type == META_FLUSH) {
+			DECLARE_COMPLETION_ONSTACK(wait);
+			io->bio->bi_private = &wait;
+			submit_bio(rw, io->bio);
+			wait_for_completion(&wait);
+		} else {
+			submit_bio(rw, io->bio);
+		}
 	}
+
 	io->bio = NULL;
 }
 
@@ -152,17 +157,12 @@ void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
 int f2fs_submit_page_bio(struct f2fs_sb_info *sbi, struct page *page,
 					block_t blk_addr, int rw)
 {
-	struct block_device *bdev = sbi->sb->s_bdev;
 	struct bio *bio;
 
 	trace_f2fs_submit_page_bio(page, blk_addr, rw);
 
 	/* Allocate a new bio */
-	bio = __bio_alloc(bdev, 1);
-
-	/* Initialize the bio */
-	bio->bi_sector = SECTOR_FROM_BLOCK(sbi, blk_addr);
-	bio->bi_end_io = is_read_io(rw) ? f2fs_read_end_io : f2fs_write_end_io;
+	bio = __bio_alloc(sbi, blk_addr, 1, is_read_io(rw));
 
 	if (bio_add_page(bio, page, PAGE_CACHE_SIZE, 0) < PAGE_CACHE_SIZE) {
 		bio_put(bio);
@@ -178,17 +178,16 @@ void f2fs_submit_page_mbio(struct f2fs_sb_info *sbi, struct page *page,
 			block_t blk_addr, struct f2fs_io_info *fio)
 {
 	enum page_type btype = PAGE_TYPE_OF_BIO(fio->type);
-	struct block_device *bdev = sbi->sb->s_bdev;
 	struct f2fs_bio_info *io;
-	int bio_blocks;
+	int is_read = is_read_io(fio->rw);
 
-	io = is_read_io(fio->rw) ? &sbi->read_io : &sbi->write_io[btype];
+	io = is_read ? &sbi->read_io : &sbi->write_io[btype];
 
 	verify_block_addr(sbi, blk_addr);
 
 	mutex_lock(&io->io_mutex);
 
-	if (!is_read_io(fio->rw))
+	if (!is_read)
 		inc_page_count(sbi, F2FS_WRITEBACK);
 
 	if (io->bio && (io->last_block_in_bio != blk_addr - 1 ||
@@ -196,17 +195,10 @@ void f2fs_submit_page_mbio(struct f2fs_sb_info *sbi, struct page *page,
 		__submit_merged_bio(io);
 alloc_new:
 	if (io->bio == NULL) {
-		bio_blocks = MAX_BIO_BLOCKS(max_hw_blocks(sbi));
-		io->bio = __bio_alloc(bdev, bio_blocks);
-		io->bio->bi_sector = SECTOR_FROM_BLOCK(sbi, blk_addr);
-		io->bio->bi_end_io = is_read_io(fio->rw) ? f2fs_read_end_io :
-							f2fs_write_end_io;
+		int bio_blocks = MAX_BIO_BLOCKS(max_hw_blocks(sbi));
+
+		io->bio = __bio_alloc(sbi, blk_addr, bio_blocks, is_read);
 		io->fio = *fio;
-		/*
-		 * The end_io will be assigned at the sumbission phase.
-		 * Until then, let bio_add_page() merge consecutive IOs as much
-		 * as possible.
-		 */
 	}
 
 	if (bio_add_page(io->bio, page, PAGE_CACHE_SIZE, 0) <
-- 
1.7.7



------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
