From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: remove the ugly pointer conversion
Date: Mon, 03 Feb 2014 15:04:25 +0900
Message-ID: <1391407465-8377-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch modifies the use of bi_private to remove pointer chasing for sbi.
Previously, we had a bi_private structure, but it needs memory allocation.
So this patch uses bi_private by the sbi pointer and adds a completion pointer
into the sbi.
This can achieve no memory allocation and nice use of the bi_private.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c | 11 +++++++----
 fs/f2fs/f2fs.h |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 20c3c64..d175ae3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -45,7 +45,7 @@ static void f2fs_read_end_io(struct bio *bio, int err)
 
 static void f2fs_write_end_io(struct bio *bio, int err)
 {
-	struct f2fs_sb_info *sbi = F2FS_SB(bio->bi_io_vec->bv_page->mapping->host->i_sb);
+	struct f2fs_sb_info *sbi = bio->bi_private;
 	struct bio_vec *bvec;
 	int i;
 
@@ -61,8 +61,10 @@ static void f2fs_write_end_io(struct bio *bio, int err)
 		dec_page_count(sbi, F2FS_WRITEBACK);
 	}
 
-	if (bio->bi_private)
-		complete(bio->bi_private);
+	if (sbi->wait_io) {
+		complete(sbi->wait_io);
+		sbi->wait_io = NULL;
+	}
 
 	if (!get_pages(sbi, F2FS_WRITEBACK) &&
 			!list_empty(&sbi->cp_wait.task_list))
@@ -85,6 +87,7 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
 	bio->bi_bdev = sbi->sb->s_bdev;
 	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(sbi, blk_addr);
 	bio->bi_end_io = is_read ? f2fs_read_end_io : f2fs_write_end_io;
+	bio->bi_private = sbi;
 
 	return bio;
 }
@@ -112,7 +115,7 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 		 */
 		if (fio->type == META_FLUSH) {
 			DECLARE_COMPLETION_ONSTACK(wait);
-			io->bio->bi_private = &wait;
+			io->sbi->wait_io = &wait;
 			submit_bio(rw, io->bio);
 			wait_for_completion(&wait);
 		} else {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 55288d2..aeff132 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -398,6 +398,7 @@ struct f2fs_sb_info {
 	/* for bio operations */
 	struct f2fs_bio_info read_io;			/* for read bios */
 	struct f2fs_bio_info write_io[NR_PAGE_TYPE];	/* for write bios */
+	struct completion *wait_io;		/* for completion bios */
 
 	/* for checkpoint */
 	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
-- 
1.8.4.474.g128a96c

