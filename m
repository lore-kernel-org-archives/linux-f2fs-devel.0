From: Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: make background threads of f2fs being aware of freezing
Date: Sat, 22 Jul 2017 08:52:23 +0800
Message-ID: <20170722005223.8628-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

When ->freeze_fs is called from lvm for doing snapshot, it needs to
make sure there will be no more changes in filesystem's data, however,
previously, background threads like GC thread wasn't aware of freezing,
so in environment with active background threads, data of snapshot
becomes unstable.

This patch fixes this issue by adding sb_{start,end}_intwrite in
below background threads:
- GC thread
- flush thread
- discard thread

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c      | 8 ++++++--
 fs/f2fs/segment.c | 8 ++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 29f412d7cbf1..7aa17f80fdf1 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -55,6 +55,8 @@ static int gc_thread_func(void *data)
 		}
 #endif
 
+		sb_start_intwrite(sbi->sb);
+
 		/*
 		 * [GC triggering condition]
 		 * 0. GC is not conducted currently.
@@ -69,12 +71,12 @@ static int gc_thread_func(void *data)
 		 * So, I'd like to wait some time to collect dirty segments.
 		 */
 		if (!mutex_trylock(&sbi->gc_mutex))
-			continue;
+			goto next;
 
 		if (!is_idle(sbi)) {
 			increase_sleep_time(gc_th, &wait_ms);
 			mutex_unlock(&sbi->gc_mutex);
-			continue;
+			goto next;
 		}
 
 		if (has_enough_invalid_blocks(sbi))
@@ -93,6 +95,8 @@ static int gc_thread_func(void *data)
 
 		/* balancing f2fs's metadata periodically */
 		f2fs_balance_fs_bg(sbi);
+next:
+		sb_end_intwrite(sbi->sb);
 
 	} while (!kthread_should_stop());
 	return 0;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6d091c75aa59..df1bb0c144f1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -485,6 +485,8 @@ static int issue_flush_thread(void *data)
 	if (kthread_should_stop())
 		return 0;
 
+	sb_start_intwrite(sbi->sb);
+
 	if (!llist_empty(&fcc->issue_list)) {
 		struct flush_cmd *cmd, *next;
 		int ret;
@@ -503,6 +505,8 @@ static int issue_flush_thread(void *data)
 		fcc->dispatch_list = NULL;
 	}
 
+	sb_end_intwrite(sbi->sb);
+
 	wait_event_interruptible(*q,
 		kthread_should_stop() || !llist_empty(&fcc->issue_list));
 	goto repeat;
@@ -1130,9 +1134,13 @@ static int issue_discard_thread(void *data)
 		if (kthread_should_stop())
 			return 0;
 
+		sb_start_intwrite(sbi->sb);
+
 		__issue_discard_cmd(sbi, true);
 		__wait_discard_cmd(sbi, true);
 
+		sb_end_intwrite(sbi->sb);
+
 		congestion_wait(BLK_RW_SYNC, HZ/50);
 	} while (!kthread_should_stop());
 	return 0;
-- 
2.13.0.90.g1eb437020
