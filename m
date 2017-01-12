From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/6] f2fs: clean up flush/discard command namings
Date: Thu, 12 Jan 2017 14:44:02 -0800
Message-ID: <20170112224407.54026-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch simply cleans up the names for flush/discard commands.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c   |  2 +-
 fs/f2fs/f2fs.h    | 20 +++++-------
 fs/f2fs/segment.c | 98 +++++++++++++++++++++++++++----------------------------
 3 files changed, 59 insertions(+), 61 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 29cdf0c1da1d..883f1ea9e0b6 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -194,7 +194,7 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 		si->cache_mem += sizeof(struct f2fs_gc_kthread);
 
 	/* build merge flush thread */
-	if (SM_I(sbi)->cmd_control_info)
+	if (SM_I(sbi)->fcc_info)
 		si->cache_mem += sizeof(struct flush_cmd_control);
 
 	/* free nids */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4a84b3fbbfd1..548e75d18ec1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -181,13 +181,12 @@ struct discard_entry {
 	int len;		/* # of consecutive blocks of the discard */
 };
 
-struct bio_entry {
-	struct list_head list;
-	block_t lstart;
-	block_t len;
-	struct bio *bio;
-	struct completion event;
-	int error;
+struct discard_cmd {
+	struct list_head list;		/* command list */
+	struct completion wait;		/* compleation */
+	block_t lstart;			/* logical start address */
+	block_t len;			/* length */
+	struct bio *bio;		/* bio */
 };
 
 /* for the list of fsync inodes, used only during recovery */
@@ -634,8 +633,8 @@ struct f2fs_sm_info {
 	unsigned int rec_prefree_segments;
 
 	/* for small discard management */
-	struct list_head discard_list;		/* 4KB discard list */
-	struct list_head wait_list;		/* linked with issued discard bio */
+	struct list_head discard_entry_list;	/* 4KB discard entry list */
+	struct list_head discard_cmd_list;	/* discard cmd list */
 	int nr_discards;			/* # of discards in the list */
 	int max_discards;			/* max. discards to be issued */
 
@@ -649,8 +648,7 @@ struct f2fs_sm_info {
 	unsigned int min_fsync_blocks;	/* threshold for fsync */
 
 	/* for flush command control */
-	struct flush_cmd_control *cmd_control_info;
-
+	struct flush_cmd_control *fcc_info;
 };
 
 /*
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 40fd04e1e23d..73282108fa33 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -26,7 +26,7 @@
 #define __reverse_ffz(x) __reverse_ffs(~(x))
 
 static struct kmem_cache *discard_entry_slab;
-static struct kmem_cache *bio_entry_slab;
+static struct kmem_cache *discard_cmd_slab;
 static struct kmem_cache *sit_entry_set_slab;
 static struct kmem_cache *inmem_entry_slab;
 
@@ -439,7 +439,7 @@ static int submit_flush_wait(struct f2fs_sb_info *sbi)
 static int issue_flush_thread(void *data)
 {
 	struct f2fs_sb_info *sbi = data;
-	struct flush_cmd_control *fcc = SM_I(sbi)->cmd_control_info;
+	struct flush_cmd_control *fcc = SM_I(sbi)->fcc_info;
 	wait_queue_head_t *q = &fcc->flush_wait_queue;
 repeat:
 	if (kthread_should_stop())
@@ -468,7 +468,7 @@ static int issue_flush_thread(void *data)
 
 int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 {
-	struct flush_cmd_control *fcc = SM_I(sbi)->cmd_control_info;
+	struct flush_cmd_control *fcc = SM_I(sbi)->fcc_info;
 	struct flush_cmd cmd;
 
 	trace_f2fs_issue_flush(sbi->sb, test_opt(sbi, NOBARRIER),
@@ -511,8 +511,8 @@ int create_flush_cmd_control(struct f2fs_sb_info *sbi)
 	struct flush_cmd_control *fcc;
 	int err = 0;
 
-	if (SM_I(sbi)->cmd_control_info) {
-		fcc = SM_I(sbi)->cmd_control_info;
+	if (SM_I(sbi)->fcc_info) {
+		fcc = SM_I(sbi)->fcc_info;
 		goto init_thread;
 	}
 
@@ -522,14 +522,14 @@ int create_flush_cmd_control(struct f2fs_sb_info *sbi)
 	atomic_set(&fcc->submit_flush, 0);
 	init_waitqueue_head(&fcc->flush_wait_queue);
 	init_llist_head(&fcc->issue_list);
-	SM_I(sbi)->cmd_control_info = fcc;
+	SM_I(sbi)->fcc_info = fcc;
 init_thread:
 	fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
 				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(fcc->f2fs_issue_flush)) {
 		err = PTR_ERR(fcc->f2fs_issue_flush);
 		kfree(fcc);
-		SM_I(sbi)->cmd_control_info = NULL;
+		SM_I(sbi)->fcc_info = NULL;
 		return err;
 	}
 
@@ -538,7 +538,7 @@ int create_flush_cmd_control(struct f2fs_sb_info *sbi)
 
 void destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free)
 {
-	struct flush_cmd_control *fcc = SM_I(sbi)->cmd_control_info;
+	struct flush_cmd_control *fcc = SM_I(sbi)->fcc_info;
 
 	if (fcc && fcc->f2fs_issue_flush) {
 		struct task_struct *flush_thread = fcc->f2fs_issue_flush;
@@ -548,7 +548,7 @@ void destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free)
 	}
 	if (free) {
 		kfree(fcc);
-		SM_I(sbi)->cmd_control_info = NULL;
+		SM_I(sbi)->fcc_info = NULL;
 	}
 }
 
@@ -628,42 +628,43 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 	mutex_unlock(&dirty_i->seglist_lock);
 }
 
-static struct bio_entry *__add_bio_entry(struct f2fs_sb_info *sbi,
+static struct discard_cmd *__add_discard_cmd(struct f2fs_sb_info *sbi,
 			struct bio *bio, block_t lstart, block_t len)
 {
-	struct list_head *wait_list = &(SM_I(sbi)->wait_list);
-	struct bio_entry *be = f2fs_kmem_cache_alloc(bio_entry_slab, GFP_NOFS);
+	struct list_head *wait_list = &(SM_I(sbi)->discard_cmd_list);
+	struct discard_cmd *dc;
 
-	INIT_LIST_HEAD(&be->list);
-	be->bio = bio;
-	be->lstart = lstart;
-	be->len = len;
-	init_completion(&be->event);
-	list_add_tail(&be->list, wait_list);
+	dc = f2fs_kmem_cache_alloc(discard_cmd_slab, GFP_NOFS);
+	INIT_LIST_HEAD(&dc->list);
+	dc->bio = bio;
+	dc->lstart = lstart;
+	dc->len = len;
+	init_completion(&dc->wait);
+	list_add_tail(&dc->list, wait_list);
 
-	return be;
+	return dc;
 }
 
 /* This should be covered by global mutex, &sit_i->sentry_lock */
 void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
-	struct list_head *wait_list = &(SM_I(sbi)->wait_list);
-	struct bio_entry *be, *tmp;
+	struct list_head *wait_list = &(SM_I(sbi)->discard_cmd_list);
+	struct discard_cmd *dc, *tmp;
 
-	list_for_each_entry_safe(be, tmp, wait_list, list) {
-		struct bio *bio = be->bio;
+	list_for_each_entry_safe(dc, tmp, wait_list, list) {
+		struct bio *bio = dc->bio;
 		int err;
 
-		if (!completion_done(&be->event)) {
-			if ((be->lstart <= blkaddr &&
-					blkaddr < be->lstart + be->len) ||
+		if (!completion_done(&dc->wait)) {
+			if ((dc->lstart <= blkaddr &&
+					blkaddr < dc->lstart + dc->len) ||
 					blkaddr == NULL_ADDR)
-				wait_for_completion_io(&be->event);
+				wait_for_completion_io(&dc->wait);
 			else
 				continue;
 		}
 
-		err = be->error;
+		err = bio->bi_error;
 		if (err == -EOPNOTSUPP)
 			err = 0;
 
@@ -672,17 +673,16 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 				"Issue discard failed, ret: %d", err);
 
 		bio_put(bio);
-		list_del(&be->list);
-		kmem_cache_free(bio_entry_slab, be);
+		list_del(&dc->list);
+		kmem_cache_free(discard_cmd_slab, dc);
 	}
 }
 
-static void f2fs_submit_bio_wait_endio(struct bio *bio)
+static void f2fs_submit_discard_endio(struct bio *bio)
 {
-	struct bio_entry *be = (struct bio_entry *)bio->bi_private;
+	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
 
-	be->error = bio->bi_error;
-	complete(&be->event);
+	complete(&dc->wait);
 }
 
 /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
@@ -705,11 +705,11 @@ static int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi,
 				SECTOR_FROM_BLOCK(blklen),
 				GFP_NOFS, 0, &bio);
 	if (!err && bio) {
-		struct bio_entry *be = __add_bio_entry(sbi, bio,
+		struct discard_cmd *dc = __add_discard_cmd(sbi, bio,
 						lblkstart, blklen);
 
-		bio->bi_private = be;
-		bio->bi_end_io = f2fs_submit_bio_wait_endio;
+		bio->bi_private = dc;
+		bio->bi_end_io = f2fs_submit_discard_endio;
 		bio->bi_opf |= REQ_SYNC;
 		submit_bio(bio);
 	}
@@ -817,7 +817,7 @@ static void __add_discard_entry(struct f2fs_sb_info *sbi,
 		struct cp_control *cpc, struct seg_entry *se,
 		unsigned int start, unsigned int end)
 {
-	struct list_head *head = &SM_I(sbi)->discard_list;
+	struct list_head *head = &SM_I(sbi)->discard_entry_list;
 	struct discard_entry *new, *last;
 
 	if (!list_empty(head)) {
@@ -886,7 +886,7 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
 
 void release_discard_addrs(struct f2fs_sb_info *sbi)
 {
-	struct list_head *head = &(SM_I(sbi)->discard_list);
+	struct list_head *head = &(SM_I(sbi)->discard_entry_list);
 	struct discard_entry *entry, *this;
 
 	/* drop caches */
@@ -912,7 +912,7 @@ static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
 
 void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
-	struct list_head *head = &(SM_I(sbi)->discard_list);
+	struct list_head *head = &(SM_I(sbi)->discard_entry_list);
 	struct discard_entry *entry, *this;
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	struct blk_plug plug;
@@ -2703,8 +2703,8 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	sm_info->min_ipu_util = DEF_MIN_IPU_UTIL;
 	sm_info->min_fsync_blocks = DEF_MIN_FSYNC_BLOCKS;
 
-	INIT_LIST_HEAD(&sm_info->discard_list);
-	INIT_LIST_HEAD(&sm_info->wait_list);
+	INIT_LIST_HEAD(&sm_info->discard_entry_list);
+	INIT_LIST_HEAD(&sm_info->discard_cmd_list);
 	sm_info->nr_discards = 0;
 	sm_info->max_discards = 0;
 
@@ -2854,15 +2854,15 @@ int __init create_segment_manager_caches(void)
 	if (!discard_entry_slab)
 		goto fail;
 
-	bio_entry_slab = f2fs_kmem_cache_create("bio_entry",
-			sizeof(struct bio_entry));
-	if (!bio_entry_slab)
+	discard_cmd_slab = f2fs_kmem_cache_create("discard_cmd",
+			sizeof(struct discard_cmd));
+	if (!discard_cmd_slab)
 		goto destroy_discard_entry;
 
 	sit_entry_set_slab = f2fs_kmem_cache_create("sit_entry_set",
 			sizeof(struct sit_entry_set));
 	if (!sit_entry_set_slab)
-		goto destroy_bio_entry;
+		goto destroy_discard_cmd;
 
 	inmem_entry_slab = f2fs_kmem_cache_create("inmem_page_entry",
 			sizeof(struct inmem_pages));
@@ -2872,8 +2872,8 @@ int __init create_segment_manager_caches(void)
 
 destroy_sit_entry_set:
 	kmem_cache_destroy(sit_entry_set_slab);
-destroy_bio_entry:
-	kmem_cache_destroy(bio_entry_slab);
+destroy_discard_cmd:
+	kmem_cache_destroy(discard_cmd_slab);
 destroy_discard_entry:
 	kmem_cache_destroy(discard_entry_slab);
 fail:
@@ -2883,7 +2883,7 @@ int __init create_segment_manager_caches(void)
 void destroy_segment_manager_caches(void)
 {
 	kmem_cache_destroy(sit_entry_set_slab);
-	kmem_cache_destroy(bio_entry_slab);
+	kmem_cache_destroy(discard_cmd_slab);
 	kmem_cache_destroy(discard_entry_slab);
 	kmem_cache_destroy(inmem_entry_slab);
 }
-- 
2.11.0
