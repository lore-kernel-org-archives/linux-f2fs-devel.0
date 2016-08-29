From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: support async discard
Date: Mon, 29 Aug 2016 23:58:34 +0800
Message-ID: <1472486314-11286-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1beOzX-0000iW-HH
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Aug 2016 16:00:55 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1beOzV-0005ZE-KI
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Aug 2016 16:00:55 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Like most filesystems, f2fs will issue discard command synchronously, so
when user trigger fstrim through ioctl, multiple discard commands will be
issued serially with sync mode, which makes poor performance.

In this patch we try to support async discard, so that all discard
commands can be issued and be waited for endio in batch to improve
performance.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c |  3 ++
 fs/f2fs/f2fs.h       |  9 ++++++
 fs/f2fs/recovery.c   |  2 ++
 fs/f2fs/segment.c    | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 1864078..a2e5963 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1205,6 +1205,7 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		f2fs_bug_on(sbi, prefree_segments(sbi));
 		flush_sit_entries(sbi, cpc);
 		clear_prefree_segments(sbi, cpc);
+		f2fs_wait_all_discard_bio(sbi);
 		unblock_operations(sbi);
 		goto out;
 	}
@@ -1224,6 +1225,8 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	/* unlock all the fs_lock[] in do_checkpoint() */
 	err = do_checkpoint(sbi, cpc);
 
+	f2fs_wait_all_discard_bio(sbi);
+
 	unblock_operations(sbi);
 	stat_inc_cp_count(sbi->stat_info);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dcdf87d..9371171 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -211,6 +211,13 @@ struct discard_entry {
 	int len;		/* # of consecutive blocks of the discard */
 };
 
+struct bio_entry {
+	struct list_head list;
+	struct bio *bio;
+	struct completion event;
+	int error;
+};
+
 /* for the list of fsync inodes, used only during recovery */
 struct fsync_inode_entry {
 	struct list_head list;	/* list head */
@@ -665,6 +672,7 @@ struct f2fs_sm_info {
 
 	/* for small discard management */
 	struct list_head discard_list;		/* 4KB discard list */
+	struct list_head wait_list;		/* linked with issued discard bio */
 	int nr_discards;			/* # of discards in the list */
 	int max_discards;			/* max. discards to be issued */
 
@@ -2046,6 +2054,7 @@ void destroy_flush_cmd_control(struct f2fs_sb_info *);
 void invalidate_blocks(struct f2fs_sb_info *, block_t);
 bool is_checkpointed_data(struct f2fs_sb_info *, block_t);
 void refresh_sit_entry(struct f2fs_sb_info *, block_t, block_t);
+void f2fs_wait_all_discard_bio(struct f2fs_sb_info *);
 void clear_prefree_segments(struct f2fs_sb_info *, struct cp_control *);
 void release_discard_addrs(struct f2fs_sb_info *);
 bool discard_next_dnode(struct f2fs_sb_info *, block_t);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 9e652d5..2f38bbb 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -636,6 +636,8 @@ out:
 			invalidate = true;
 		}
 
+		f2fs_wait_all_discard_bio(sbi);
+
 		/* Flush all the NAT/SIT pages */
 		while (get_pages(sbi, F2FS_DIRTY_META))
 			sync_meta_pages(sbi, META, LONG_MAX);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d0f74eb..c81526a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -26,6 +26,7 @@
 #define __reverse_ffz(x) __reverse_ffs(~(x))
 
 static struct kmem_cache *discard_entry_slab;
+static struct kmem_cache *bio_entry_slab;
 static struct kmem_cache *sit_entry_set_slab;
 static struct kmem_cache *inmem_entry_slab;
 
@@ -580,6 +581,74 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 	mutex_unlock(&dirty_i->seglist_lock);
 }
 
+static struct bio_entry *__add_bio_entry(struct f2fs_sb_info *sbi,
+							struct bio *bio)
+{
+	struct list_head *wait_list = &(SM_I(sbi)->wait_list);
+	struct bio_entry *be = f2fs_kmem_cache_alloc(bio_entry_slab, GFP_NOFS);
+
+	INIT_LIST_HEAD(&be->list);
+	be->bio = bio;
+	init_completion(&be->event);
+	list_add_tail(&be->list, wait_list);
+
+	return be;
+}
+
+void f2fs_wait_all_discard_bio(struct f2fs_sb_info *sbi)
+{
+	struct list_head *wait_list = &(SM_I(sbi)->wait_list);
+	struct bio_entry *be, *tmp;
+
+	list_for_each_entry_safe(be, tmp, wait_list, list) {
+		struct bio *bio = be->bio;
+		int err;
+
+		wait_for_completion_io(&be->event);
+		err = be->error;
+		if (err == -EOPNOTSUPP)
+			err = 0;
+
+		if (err)
+			f2fs_msg(sbi->sb, KERN_INFO,
+				"Issue discard failed, ret: %d", err);
+
+		bio_put(bio);
+		list_del(&be->list);
+		kmem_cache_free(bio_entry_slab, be);
+	}
+}
+
+static void f2fs_submit_bio_wait_endio(struct bio *bio)
+{
+	struct bio_entry *be = (struct bio_entry *)bio->bi_private;
+
+	be->error = bio->bi_error;
+	complete(&be->event);
+}
+
+/* this function is copied from blkdev_issue_discard from block/blk-lib.c */
+int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask, unsigned long flags)
+{
+	struct block_device *bdev = sbi->sb->s_bdev;
+	struct bio *bio = NULL;
+	int err;
+
+	err = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, flags,
+			&bio);
+	if (!err && bio) {
+		struct bio_entry *be = __add_bio_entry(sbi, bio);
+
+		bio->bi_private = be;
+		bio->bi_end_io = f2fs_submit_bio_wait_endio;
+		bio->bi_rw |= REQ_SYNC;
+		submit_bio(bio);
+	}
+
+	return err;
+}
+
 static int f2fs_issue_discard(struct f2fs_sb_info *sbi,
 				block_t blkstart, block_t blklen)
 {
@@ -597,7 +666,7 @@ static int f2fs_issue_discard(struct f2fs_sb_info *sbi,
 			sbi->discard_blks--;
 	}
 	trace_f2fs_issue_discard(sbi->sb, blkstart, blklen);
-	return blkdev_issue_discard(sbi->sb->s_bdev, start, len, GFP_NOFS, 0);
+	return __f2fs_issue_discard_async(sbi, start, len, GFP_NOFS, 0);
 }
 
 bool discard_next_dnode(struct f2fs_sb_info *sbi, block_t blkaddr)
@@ -719,11 +788,14 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct list_head *head = &(SM_I(sbi)->discard_list);
 	struct discard_entry *entry, *this;
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
+	struct blk_plug plug;
 	unsigned long *prefree_map = dirty_i->dirty_segmap[PRE];
 	unsigned int start = 0, end = -1;
 	unsigned int secno, start_segno;
 	bool force = (cpc->reason == CP_DISCARD);
 
+	blk_start_plug(&plug);
+
 	mutex_lock(&dirty_i->seglist_lock);
 
 	while (1) {
@@ -772,6 +844,8 @@ skip:
 		SM_I(sbi)->nr_discards -= entry->len;
 		kmem_cache_free(discard_entry_slab, entry);
 	}
+
+	blk_finish_plug(&plug);
 }
 
 static bool __mark_sit_entry_dirty(struct f2fs_sb_info *sbi, unsigned int segno)
@@ -2457,6 +2531,7 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	sm_info->min_fsync_blocks = DEF_MIN_FSYNC_BLOCKS;
 
 	INIT_LIST_HEAD(&sm_info->discard_list);
+	INIT_LIST_HEAD(&sm_info->wait_list);
 	sm_info->nr_discards = 0;
 	sm_info->max_discards = 0;
 
@@ -2600,10 +2675,15 @@ int __init create_segment_manager_caches(void)
 	if (!discard_entry_slab)
 		goto fail;
 
+	bio_entry_slab = f2fs_kmem_cache_create("bio_entry",
+			sizeof(struct bio_entry));
+	if (!bio_entry_slab)
+		goto destory_discard_entry;
+
 	sit_entry_set_slab = f2fs_kmem_cache_create("sit_entry_set",
 			sizeof(struct sit_entry_set));
 	if (!sit_entry_set_slab)
-		goto destory_discard_entry;
+		goto destroy_bio_entry;
 
 	inmem_entry_slab = f2fs_kmem_cache_create("inmem_page_entry",
 			sizeof(struct inmem_pages));
@@ -2613,6 +2693,8 @@ int __init create_segment_manager_caches(void)
 
 destroy_sit_entry_set:
 	kmem_cache_destroy(sit_entry_set_slab);
+destroy_bio_entry:
+	kmem_cache_destroy(bio_entry_slab);
 destory_discard_entry:
 	kmem_cache_destroy(discard_entry_slab);
 fail:
@@ -2622,6 +2704,7 @@ fail:
 void destroy_segment_manager_caches(void)
 {
 	kmem_cache_destroy(sit_entry_set_slab);
+	kmem_cache_destroy(bio_entry_slab);
 	kmem_cache_destroy(discard_entry_slab);
 	kmem_cache_destroy(inmem_entry_slab);
 }
-- 
2.7.2


------------------------------------------------------------------------------
