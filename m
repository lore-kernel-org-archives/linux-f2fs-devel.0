From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: add to account skip count of background GC
Date: Sat, 29 Sep 2018 18:31:28 +0800
Message-ID: <20180929103128.31307-2-yuchao0@huawei.com>
References: <20180929103128.31307-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180929103128.31307-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds to account skip count of background GC, and show stat
info via 'status' debugfs entry.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/debug.c |  4 ++++
 fs/f2fs/f2fs.h  |  7 +++++++
 fs/f2fs/gc.c    | 14 +++++++++++---
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index da1cabbc4973..75bc62edc4c1 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -101,6 +101,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->avail_nids = NM_I(sbi)->available_nids;
 	si->alloc_nids = NM_I(sbi)->nid_cnt[PREALLOC_NID];
 	si->bg_gc = sbi->bg_gc;
+	si->io_skip_bggc = sbi->io_skip_bggc;
+	si->other_skip_bggc = sbi->other_skip_bggc;
 	si->skipped_atomic_files[BG_GC] = sbi->skipped_atomic_files[BG_GC];
 	si->skipped_atomic_files[FG_GC] = sbi->skipped_atomic_files[FG_GC];
 	si->util_free = (int)(free_user_blocks(sbi) >> sbi->log_blocks_per_seg)
@@ -355,6 +357,8 @@ static int stat_show(struct seq_file *s, void *v)
 				si->skipped_atomic_files[BG_GC] +
 				si->skipped_atomic_files[FG_GC],
 				si->skipped_atomic_files[BG_GC]);
+		seq_printf(s, "BG skip : IO: %u, Other: %u\n",
+				si->io_skip_bggc, si->other_skip_bggc);
 		seq_puts(s, "\nExtent Cache:\n");
 		seq_printf(s, "  - Hit Count: L1-1:%llu L1-2:%llu L2:%llu\n",
 				si->hit_largest, si->hit_cached,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0f82f342e514..807a2e34543c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1284,6 +1284,8 @@ struct f2fs_sb_info {
 	atomic_t max_aw_cnt;			/* max # of atomic writes */
 	atomic_t max_vw_cnt;			/* max # of volatile writes */
 	int bg_gc;				/* background gc calls */
+	unsigned int io_skip_bggc;		/* skip background gc for in-flight IO */
+	unsigned int other_skip_bggc;		/* skip background gc for other reasons */
 	unsigned int ndirty_inode[NR_INODE_TYPE];	/* # of dirty inodes */
 #endif
 	spinlock_t stat_lock;			/* lock for stat operations */
@@ -3127,6 +3129,7 @@ struct f2fs_stat_info {
 	int free_nids, avail_nids, alloc_nids;
 	int total_count, utilization;
 	int bg_gc, nr_wb_cp_data, nr_wb_data;
+	unsigned int io_skip_bggc, other_skip_bggc;
 	int nr_flushing, nr_flushed, flush_list_empty;
 	int nr_discarding, nr_discarded;
 	int nr_discard_cmd;
@@ -3164,6 +3167,8 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 #define stat_inc_bg_cp_count(si)	((si)->bg_cp_count++)
 #define stat_inc_call_count(si)		((si)->call_count++)
 #define stat_inc_bggc_count(sbi)	((sbi)->bg_gc++)
+#define stat_io_skip_bggc_count(sbi)	((sbi)->io_skip_bggc++)
+#define stat_other_skip_bggc_count(sbi)	((sbi)->other_skip_bggc++)
 #define stat_inc_dirty_inode(sbi, type)	((sbi)->ndirty_inode[type]++)
 #define stat_dec_dirty_inode(sbi, type)	((sbi)->ndirty_inode[type]--)
 #define stat_inc_total_hit(sbi)		(atomic64_inc(&(sbi)->total_hit_ext))
@@ -3280,6 +3285,8 @@ void f2fs_destroy_root_stats(void);
 #define stat_inc_bg_cp_count(si)			do { } while (0)
 #define stat_inc_call_count(si)				do { } while (0)
 #define stat_inc_bggc_count(si)				do { } while (0)
+#define stat_io_skip_bggc_count(sbi)			do { } while (0)
+#define stat_other_skip_bggc_count(sbi)			do { } while (0)
 #define stat_inc_dirty_inode(sbi, type)			do { } while (0)
 #define stat_dec_dirty_inode(sbi, type)			do { } while (0)
 #define stat_inc_total_hit(sb)				do { } while (0)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 91896d979972..21e42554bdb8 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -40,13 +40,16 @@ static int gc_thread_func(void *data)
 		if (gc_th->gc_wake)
 			gc_th->gc_wake = 0;
 
-		if (try_to_freeze())
+		if (try_to_freeze()) {
+			stat_other_skip_bggc_count(sbi);
 			continue;
+		}
 		if (kthread_should_stop())
 			break;
 
 		if (sbi->sb->s_writers.frozen >= SB_FREEZE_WRITE) {
 			increase_sleep_time(gc_th, &wait_ms);
+			stat_other_skip_bggc_count(sbi);
 			continue;
 		}
 
@@ -55,8 +58,10 @@ static int gc_thread_func(void *data)
 			f2fs_stop_checkpoint(sbi, false);
 		}
 
-		if (!sb_start_write_trylock(sbi->sb))
+		if (!sb_start_write_trylock(sbi->sb)) {
+			stat_other_skip_bggc_count(sbi);
 			continue;
+		}
 
 		/*
 		 * [GC triggering condition]
@@ -77,12 +82,15 @@ static int gc_thread_func(void *data)
 			goto do_gc;
 		}
 
-		if (!mutex_trylock(&sbi->gc_mutex))
+		if (!mutex_trylock(&sbi->gc_mutex)) {
+			stat_other_skip_bggc_count(sbi);
 			goto next;
+		}
 
 		if (!is_idle(sbi, GC_TIME)) {
 			increase_sleep_time(gc_th, &wait_ms);
 			mutex_unlock(&sbi->gc_mutex);
+			stat_io_skip_bggc_count(sbi);
 			goto next;
 		}
 
-- 
2.18.0.rc1
