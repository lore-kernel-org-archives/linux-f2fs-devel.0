From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix potential overflow when adjusting GC cycle
Date: Mon,  7 Aug 2017 23:12:46 +0800
Message-ID: <20170807151246.9545-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

While comparing signed and unsigned variables, compiler will converts the
signed value to unsigned one, due to this reason, {in,de}crease_sleep_time
may return overflowed result.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c                |  2 +-
 fs/f2fs/gc.h                | 23 +++++++++++++++--------
 include/trace/events/f2fs.h |  6 +++---
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 620dca443b29..acbb7eb45e81 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -28,7 +28,7 @@ static int gc_thread_func(void *data)
 	struct f2fs_sb_info *sbi = data;
 	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
 	wait_queue_head_t *wq = &sbi->gc_thread->gc_wait_queue_head;
-	long wait_ms;
+	unsigned int wait_ms;
 
 	wait_ms = gc_th->min_sleep_time;
 
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index a993967dcdb9..64fb44772257 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -65,25 +65,32 @@ static inline block_t limit_free_user_blocks(struct f2fs_sb_info *sbi)
 }
 
 static inline void increase_sleep_time(struct f2fs_gc_kthread *gc_th,
-								long *wait)
+							unsigned int *wait)
 {
+	unsigned int min_time = gc_th->min_sleep_time;
+	unsigned int max_time = gc_th->max_sleep_time;
+
 	if (*wait == gc_th->no_gc_sleep_time)
 		return;
 
-	*wait += gc_th->min_sleep_time;
-	if (*wait > gc_th->max_sleep_time)
-		*wait = gc_th->max_sleep_time;
+	if ((long long)*wait + (long long)min_time > (long long)max_time)
+		*wait = max_time;
+	else
+		*wait += min_time;
 }
 
 static inline void decrease_sleep_time(struct f2fs_gc_kthread *gc_th,
-								long *wait)
+							unsigned int *wait)
 {
+	unsigned int min_time = gc_th->min_sleep_time;
+
 	if (*wait == gc_th->no_gc_sleep_time)
 		*wait = gc_th->max_sleep_time;
 
-	*wait -= gc_th->min_sleep_time;
-	if (*wait <= gc_th->min_sleep_time)
-		*wait = gc_th->min_sleep_time;
+	if ((long long)*wait - (long long)min_time < (long long)min_time)
+		*wait = min_time;
+	else
+		*wait -= min_time;
 }
 
 static inline bool has_enough_invalid_blocks(struct f2fs_sb_info *sbi)
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 6f77a2755abb..db5c98256147 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -543,14 +543,14 @@ TRACE_EVENT(f2fs_map_blocks,
 
 TRACE_EVENT(f2fs_background_gc,
 
-	TP_PROTO(struct super_block *sb, long wait_ms,
+	TP_PROTO(struct super_block *sb, unsigned int wait_ms,
 			unsigned int prefree, unsigned int free),
 
 	TP_ARGS(sb, wait_ms, prefree, free),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
-		__field(long,	wait_ms)
+		__field(unsigned int,	wait_ms)
 		__field(unsigned int,	prefree)
 		__field(unsigned int,	free)
 	),
@@ -562,7 +562,7 @@ TRACE_EVENT(f2fs_background_gc,
 		__entry->free		= free;
 	),
 
-	TP_printk("dev = (%d,%d), wait_ms = %ld, prefree = %u, free = %u",
+	TP_printk("dev = (%d,%d), wait_ms = %u, prefree = %u, free = %u",
 		show_dev(__entry->dev),
 		__entry->wait_ms,
 		__entry->prefree,
-- 
2.14.0
