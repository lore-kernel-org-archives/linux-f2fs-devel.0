From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH] f2fs: cleanup parameters for
 trace_f2fs_submit_{read_,write_,page_,page_m}bio with fio
Date: Wed, 24 Dec 2014 16:08:14 +0800
Message-ID: <007001d01f50$df496bc0$9ddc4340$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Cleanup parameters for trace_f2fs_submit_{read_,write_,page_,page_m}bio with fio
as one parameter.

Suggested-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c              | 10 ++++------
 include/trace/events/f2fs.h | 37 ++++++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7953bc2..6308435 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -96,11 +96,9 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 		return;
 
 	if (is_read_io(fio->rw))
-		trace_f2fs_submit_read_bio(io->sbi->sb, fio->rw,
-							fio->type, io->bio);
+		trace_f2fs_submit_read_bio(io->sbi->sb, fio, io->bio);
 	else
-		trace_f2fs_submit_write_bio(io->sbi->sb, fio->rw,
-							fio->type, io->bio);
+		trace_f2fs_submit_write_bio(io->sbi->sb, fio, io->bio);
 
 	submit_bio(fio->rw, io->bio);
 	io->bio = NULL;
@@ -137,7 +135,7 @@ int f2fs_submit_page_bio(struct f2fs_sb_info *sbi, struct page *page,
 {
 	struct bio *bio;
 
-	trace_f2fs_submit_page_bio(page, fio->blk_addr, fio->rw, fio->type);
+	trace_f2fs_submit_page_bio(page, fio);
 	f2fs_trace_ios(page, fio, 0);
 
 	/* Allocate a new bio */
@@ -190,7 +188,7 @@ alloc_new:
 	f2fs_trace_ios(page, fio, 0);
 
 	up_write(&io->io_rwsem);
-	trace_f2fs_submit_page_mbio(page, fio->blk_addr, fio->rw, fio->type);
+	trace_f2fs_submit_page_mbio(page, fio);
 }
 
 /*
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 553311f..13992f3 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -650,9 +650,9 @@ TRACE_EVENT(f2fs_reserve_new_block,
 
 DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
 
-	TP_PROTO(struct page *page, block_t blkaddr, int rw, int type),
+	TP_PROTO(struct page *page, struct f2fs_io_info *fio),
 
-	TP_ARGS(page, blkaddr, rw, type),
+	TP_ARGS(page, fio),
 
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
@@ -667,9 +667,9 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
 		__entry->dev		= page->mapping->host->i_sb->s_dev;
 		__entry->ino		= page->mapping->host->i_ino;
 		__entry->index		= page->index;
-		__entry->blkaddr	= blkaddr;
-		__entry->rw		= rw;
-		__entry->type		= type;
+		__entry->blkaddr	= fio->blk_addr;
+		__entry->rw		= fio->rw;
+		__entry->type		= fio->type;
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu, page_index = 0x%lx, "
@@ -683,27 +683,28 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
 
 DEFINE_EVENT_CONDITION(f2fs__submit_page_bio, f2fs_submit_page_bio,
 
-	TP_PROTO(struct page *page, block_t blkaddr, int rw, int type),
+	TP_PROTO(struct page *page, struct f2fs_io_info *fio),
 
-	TP_ARGS(page, blkaddr, rw, type),
+	TP_ARGS(page, fio),
 
 	TP_CONDITION(page->mapping)
 );
 
 DEFINE_EVENT_CONDITION(f2fs__submit_page_bio, f2fs_submit_page_mbio,
 
-	TP_PROTO(struct page *page, block_t blkaddr, int rw, int type),
+	TP_PROTO(struct page *page, struct f2fs_io_info *fio),
 
-	TP_ARGS(page, blkaddr, rw, type),
+	TP_ARGS(page, fio),
 
 	TP_CONDITION(page->mapping)
 );
 
 DECLARE_EVENT_CLASS(f2fs__submit_bio,
 
-	TP_PROTO(struct super_block *sb, int rw, int type, struct bio *bio),
+	TP_PROTO(struct super_block *sb, struct f2fs_io_info *fio,
+						struct bio *bio),
 
-	TP_ARGS(sb, rw, type, bio),
+	TP_ARGS(sb, fio, bio),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
@@ -715,8 +716,8 @@ DECLARE_EVENT_CLASS(f2fs__submit_bio,
 
 	TP_fast_assign(
 		__entry->dev		= sb->s_dev;
-		__entry->rw		= rw;
-		__entry->type		= type;
+		__entry->rw		= fio->rw;
+		__entry->type		= fio->type;
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->size		= bio->bi_iter.bi_size;
 	),
@@ -731,18 +732,20 @@ DECLARE_EVENT_CLASS(f2fs__submit_bio,
 
 DEFINE_EVENT_CONDITION(f2fs__submit_bio, f2fs_submit_write_bio,
 
-	TP_PROTO(struct super_block *sb, int rw, int type, struct bio *bio),
+	TP_PROTO(struct super_block *sb, struct f2fs_io_info *fio,
+							struct bio *bio),
 
-	TP_ARGS(sb, rw, type, bio),
+	TP_ARGS(sb, fio, bio),
 
 	TP_CONDITION(bio)
 );
 
 DEFINE_EVENT_CONDITION(f2fs__submit_bio, f2fs_submit_read_bio,
 
-	TP_PROTO(struct super_block *sb, int rw, int type, struct bio *bio),
+	TP_PROTO(struct super_block *sb, struct f2fs_io_info *fio,
+							struct bio *bio),
 
-	TP_ARGS(sb, rw, type, bio),
+	TP_ARGS(sb, fio, bio),
 
 	TP_CONDITION(bio)
 );
-- 
2.2.1
