From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/2] f2fs: add a sysfs entry to control max_victim_search
Date: Wed, 08 Jan 2014 14:45:02 +0900
Message-ID: <1389159902-25491-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1389159902-25491-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1389159902-25491-1-git-send-email-jaegeuk.kim@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously during SSR and GC, the maximum number of retrials to find a victim
segment was hard-coded by MAX_VICTIM_SEARCH, 4096 by default.

This number makes an effect on IO locality, when SSR mode is activated, which
results in performance fluctuation on some low-end devices.

If max_victim_search = 4, the victim will be searched like below.
("D" represents a dirty segment, and "*" indicates a selected victim segment.)

 D1 D2 D3 D4 D5 D6 D7 D8 D9
[   *       ]
      [   *    ]
            [         * ]
	                [ ....]

This patch adds a sysfs entry to control the number dynamically through:
  /sys/fs/f2fs/$dev/max_victim_search

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h  | 3 +++
 fs/f2fs/gc.c    | 4 ++--
 fs/f2fs/gc.h    | 2 +-
 fs/f2fs/super.c | 6 ++++++
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b69f190..5f7dc4f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -451,6 +451,9 @@ struct f2fs_sb_info {
 	struct f2fs_gc_kthread	*gc_thread;	/* GC thread */
 	unsigned int cur_victim_sec;		/* current victim section num */
 
+	/* maximum # of trials to find a victim segment for SSR and GC */
+	unsigned int max_victim_search;
+
 	/*
 	 * for stat information.
 	 * one is for the LFS mode, and the other is for the SSR mode.
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 599f546..9117cca 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -163,8 +163,8 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
 		p->ofs_unit = sbi->segs_per_sec;
 	}
 
-	if (p->max_search > MAX_VICTIM_SEARCH)
-		p->max_search = MAX_VICTIM_SEARCH;
+	if (p->max_search > sbi->max_victim_search)
+		p->max_search = sbi->max_victim_search;
 
 	p->offset = sbi->last_victim[p->gc_mode];
 }
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 507056d..5d5eb60 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -20,7 +20,7 @@
 #define LIMIT_FREE_BLOCK	40 /* percentage over invalid + free space */
 
 /* Search max. number of dirty segments to select a victim segment */
-#define MAX_VICTIM_SEARCH 4096 /* covers 8GB */
+#define DEF_MAX_VICTIM_SEARCH 4096 /* covers 8GB */
 
 struct f2fs_gc_kthread {
 	struct task_struct *f2fs_gc_task;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f16da92..b070f30 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -74,6 +74,7 @@ static match_table_t f2fs_tokens = {
 enum {
 	GC_THREAD,	/* struct f2fs_gc_thread */
 	SM_INFO,	/* struct f2fs_sm_info */
+	F2FS_SBI,	/* struct f2fs_sb_info */
 };
 
 struct f2fs_attr {
@@ -91,6 +92,8 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 		return (unsigned char *)sbi->gc_thread;
 	else if (struct_type == SM_INFO)
 		return (unsigned char *)SM_I(sbi);
+	else if (struct_type == F2FS_SBI)
+		return (unsigned char *)sbi;
 	return NULL;
 }
 
@@ -180,6 +183,7 @@ F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, reclaim_segments, rec_prefree_segments);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, max_small_discards, max_discards);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ipu_util, min_ipu_util);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -191,6 +195,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(max_small_discards),
 	ATTR_LIST(ipu_policy),
 	ATTR_LIST(min_ipu_util),
+	ATTR_LIST(max_victim_search),
 	NULL,
 };
 
@@ -775,6 +780,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->node_ino_num = le32_to_cpu(raw_super->node_ino);
 	sbi->meta_ino_num = le32_to_cpu(raw_super->meta_ino);
 	sbi->cur_victim_sec = NULL_SECNO;
+	sbi->max_victim_search = DEF_MAX_VICTIM_SEARCH;
 
 	for (i = 0; i < NR_COUNT_TYPE; i++)
 		atomic_set(&sbi->nr_pages[i], 0);
-- 
1.8.4.474.g128a96c

