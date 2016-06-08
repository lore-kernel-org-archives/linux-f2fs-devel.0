From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/7] f2fs: drop any block plugging
Date: Wed,  8 Jun 2016 10:24:40 -0700
Message-ID: <20160608172444.60371-3-jaegeuk@kernel.org>
References: <20160608172444.60371-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bAhDt-0004hJ-KG
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jun 2016 17:24:57 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bAhDs-0006bt-Lg
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jun 2016 17:24:57 +0000
In-Reply-To: <20160608172444.60371-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

In f2fs, we don't need to keep block plugging for NODE and DATA writes, since
we already merged bios as much as possible.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  4 ----
 fs/f2fs/data.c       | 17 ++++++++++-------
 fs/f2fs/gc.c         |  5 -----
 fs/f2fs/segment.c    |  7 +------
 4 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 5ddd15c..4179c7b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -897,11 +897,8 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		.nr_to_write = LONG_MAX,
 		.for_reclaim = 0,
 	};
-	struct blk_plug plug;
 	int err = 0;
 
-	blk_start_plug(&plug);
-
 retry_flush_dents:
 	f2fs_lock_all(sbi);
 	/* write all the dirty dentry pages */
@@ -938,7 +935,6 @@ retry_flush_nodes:
 		goto retry_flush_nodes;
 	}
 out:
-	blk_finish_plug(&plug);
 	return err;
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 30dc448..5f655d0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -98,10 +98,13 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
 }
 
 static inline void __submit_bio(struct f2fs_sb_info *sbi, int rw,
-						struct bio *bio)
+			struct bio *bio, enum page_type type)
 {
-	if (!is_read_io(rw))
+	if (!is_read_io(rw)) {
 		atomic_inc(&sbi->nr_wb_bios);
+		if (current->plug && (type == DATA || type == NODE))
+			blk_finish_plug(current->plug);
+	}
 	submit_bio(rw, bio);
 }
 
@@ -117,7 +120,7 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 	else
 		trace_f2fs_submit_write_bio(io->sbi->sb, fio, io->bio);
 
-	__submit_bio(io->sbi, fio->rw, io->bio);
+	__submit_bio(io->sbi, fio->rw, io->bio, fio->type);
 	io->bio = NULL;
 }
 
@@ -235,7 +238,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 		return -EFAULT;
 	}
 
-	__submit_bio(fio->sbi, fio->rw, bio);
+	__submit_bio(fio->sbi, fio->rw, bio, fio->type);
 	return 0;
 }
 
@@ -1040,7 +1043,7 @@ got_it:
 		 */
 		if (bio && (last_block_in_bio != block_nr - 1)) {
 submit_and_realloc:
-			__submit_bio(F2FS_I_SB(inode), READ, bio);
+			__submit_bio(F2FS_I_SB(inode), READ, bio, DATA);
 			bio = NULL;
 		}
 		if (bio == NULL) {
@@ -1083,7 +1086,7 @@ set_error_page:
 		goto next_page;
 confused:
 		if (bio) {
-			__submit_bio(F2FS_I_SB(inode), READ, bio);
+			__submit_bio(F2FS_I_SB(inode), READ, bio, DATA);
 			bio = NULL;
 		}
 		unlock_page(page);
@@ -1093,7 +1096,7 @@ next_page:
 	}
 	BUG_ON(pages && !list_empty(pages));
 	if (bio)
-		__submit_bio(F2FS_I_SB(inode), READ, bio);
+		__submit_bio(F2FS_I_SB(inode), READ, bio, DATA);
 	return 0;
 }
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 4a03076..67fd285 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -777,7 +777,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 {
 	struct page *sum_page;
 	struct f2fs_summary_block *sum;
-	struct blk_plug plug;
 	unsigned int segno = start_segno;
 	unsigned int end_segno = start_segno + sbi->segs_per_sec;
 	int seg_freed = 0;
@@ -795,8 +794,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		unlock_page(sum_page);
 	}
 
-	blk_start_plug(&plug);
-
 	for (segno = start_segno; segno < end_segno; segno++) {
 		/* find segment summary of victim */
 		sum_page = find_get_page(META_MAPPING(sbi),
@@ -830,8 +827,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		f2fs_submit_merged_bio(sbi,
 				(type == SUM_TYPE_NODE) ? NODE : DATA, WRITE);
 
-	blk_finish_plug(&plug);
-
 	if (gc_type == FG_GC) {
 		while (start_segno < end_segno)
 			if (get_valid_blocks(sbi, start_segno++, 1) == 0)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7b58bfb..eff046a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -379,13 +379,8 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 			excess_prefree_segs(sbi) ||
 			excess_dirty_nats(sbi) ||
 			(is_idle(sbi) && f2fs_time_over(sbi, CP_TIME))) {
-		if (test_opt(sbi, DATA_FLUSH)) {
-			struct blk_plug plug;
-
-			blk_start_plug(&plug);
+		if (test_opt(sbi, DATA_FLUSH))
 			sync_dirty_inodes(sbi, FILE_INODE);
-			blk_finish_plug(&plug);
-		}
 		f2fs_sync_fs(sbi->sb, true);
 		stat_inc_bg_cp_count(sbi->stat_info);
 	}
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
