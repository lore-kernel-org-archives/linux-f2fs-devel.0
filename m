From: Park Ju Hyung <qkrwngud825@gmail.com>
Subject: [PATCH 1/3] f2fs: remove sleep_time under gc_urgent
Date: Tue, 14 May 2019 15:36:21 +0900
Message-ID: <20190514063623.57162-1-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hQR3K-0002SF-Ov
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 May 2019 06:36:42 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hQR3J-00FmwV-FS
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 May 2019 06:36:42 +0000
Received: by mail-pg1-f193.google.com with SMTP id w22so8076600pgi.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 13 May 2019 23:36:41 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

gc_urgent is meant to be a hint from the user to force f2fs to run GC
aggressively, which means they are willing to take the hit on increased
latency during gc_urgent. It's meaningless to sleep between each GC under
gc_urgent, Not to mention that the default value of 500 ms makes gc_urgent
super ineffective.

Remove urgent_sleep_time entirely and allow GC to be finished much faster.

Use 1 for wait_ms instead of 0 to prevent possible CPU hoggings.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
---
 fs/f2fs/gc.c    | 3 +--
 fs/f2fs/gc.h    | 2 --
 fs/f2fs/sysfs.c | 3 ---
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 963fb4571fd9..9c3ed89c8c5b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -77,7 +77,7 @@ static int gc_thread_func(void *data)
 		 * So, I'd like to wait some time to collect dirty segments.
 		 */
 		if (sbi->gc_mode == GC_URGENT) {
-			wait_ms = gc_th->urgent_sleep_time;
+			wait_ms = 1;
 			mutex_lock(&sbi->gc_mutex);
 			goto do_gc;
 		}
@@ -129,7 +129,6 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 		goto out;
 	}
 
-	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
 	gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
 	gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME;
 	gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME;
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index bbac9d3787bd..de79a867837e 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -10,7 +10,6 @@
 						 * whether IO subsystem is idle
 						 * or not
 						 */
-#define DEF_GC_THREAD_URGENT_SLEEP_TIME	500	/* 500 ms */
 #define DEF_GC_THREAD_MIN_SLEEP_TIME	30000	/* milliseconds */
 #define DEF_GC_THREAD_MAX_SLEEP_TIME	60000
 #define DEF_GC_THREAD_NOGC_SLEEP_TIME	300000	/* wait 5 min */
@@ -27,7 +26,6 @@ struct f2fs_gc_kthread {
 	wait_queue_head_t gc_wait_queue_head;
 
 	/* for gc sleep time */
-	unsigned int urgent_sleep_time;
 	unsigned int min_sleep_time;
 	unsigned int max_sleep_time;
 	unsigned int no_gc_sleep_time;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 729f46a3c9ee..0165431e83e5 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -397,8 +397,6 @@ static struct f2fs_attr f2fs_attr_##_name = {			\
 	.id	= _id,						\
 }
 
-F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_urgent_sleep_time,
-							urgent_sleep_time);
 F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_min_sleep_time, min_sleep_time);
 F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_max_sleep_time, max_sleep_time);
 F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_no_gc_sleep_time, no_gc_sleep_time);
@@ -459,7 +457,6 @@ F2FS_FEATURE_RO_ATTR(sb_checksum, FEAT_SB_CHECKSUM);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
-	ATTR_LIST(gc_urgent_sleep_time),
 	ATTR_LIST(gc_min_sleep_time),
 	ATTR_LIST(gc_max_sleep_time),
 	ATTR_LIST(gc_no_gc_sleep_time),
-- 
2.21.0
