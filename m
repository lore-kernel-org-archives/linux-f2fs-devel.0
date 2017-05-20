From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 5/5] f2fs: use an array to record sit_entry_set
	info to make sort fast
Date: Sat, 20 May 2017 12:24:35 +0000
Message-ID: <20170520122435.17574-6-houpengyang@huawei.com>
References: <20170520122435.17574-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1dC3RR-0001PN-So
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 20 May 2017 12:25:05 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dC3RQ-0004aL-CT
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 20 May 2017 12:25:05 +0000
In-Reply-To: <20170520122435.17574-1-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, chao@kernel.org, miaoxie@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Currently, we dynamicly alloc sit_entry_set from slab, and link all the sit_entry_set
by sit_entry_set->set_list.

It is inefficient, since in add_sit_entry, we may need to travel all the list to find
the target sit_entry_set.

This patch fixes this by introducing a static array:

	f2fs_sm_info->sit_sets
	(struct sit_entry_set *sit_sets)

when we can find the target sit_entry_set in O(1) time, and then to update the sit_entry_set
info.

What's more there is no need to alloc/free slab memory.

footprint:(64bit machine)

	1T   :  sizeof(struct sit_entry_set) * 1T/(2M*55) = 0.87M
	128G :  sizeof(struct sit_entry_set) * 128G/(2M*55) = 1.16k
	64G  :  0.55k
	32G  :  0.27k
	

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/segment.c | 75 +++++++++++++++++++------------------------------------
 fs/f2fs/segment.h |  1 -
 3 files changed, 26 insertions(+), 52 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 198da30..429d33b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -732,7 +732,7 @@ struct f2fs_sm_info {
 	/* for batched trimming */
 	unsigned int trim_sections;		/* # of sections to trim */
 
-	struct list_head sit_entry_set;	/* sit entry set list */
+	struct sit_entry_set *sit_sets;	/* # of dirty segment in this sit_entry_set */
 	struct list_head dirty_set[SIT_ENTRY_PER_BLOCK + 1];
 
 	unsigned int ipu_policy;	/* in-place-update policy */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index af470d3..04d6329 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -28,7 +28,6 @@
 
 static struct kmem_cache *discard_entry_slab;
 static struct kmem_cache *discard_cmd_slab;
-static struct kmem_cache *sit_entry_set_slab;
 static struct kmem_cache *inmem_entry_slab;
 
 static unsigned long __reverse_ulong(unsigned char *str)
@@ -2641,56 +2640,30 @@ static struct page *get_next_sit_page(struct f2fs_sb_info *sbi,
 	return dst_page;
 }
 
-static struct sit_entry_set *grab_sit_entry_set(void)
-{
-	struct sit_entry_set *ses =
-			f2fs_kmem_cache_alloc(sit_entry_set_slab, GFP_NOFS);
-
-	ses->entry_cnt = 0;
-	INIT_LIST_HEAD(&ses->set_list);
-	INIT_LIST_HEAD(&ses->cnt_list);
-	return ses;
-}
-
 static void release_sit_entry_set(struct sit_entry_set *ses)
 {
-	list_del(&ses->set_list);
 	list_del(&ses->cnt_list);
-	kmem_cache_free(sit_entry_set_slab, ses);
+	INIT_LIST_HEAD(&ses->cnt_list);
 }
 
 static void add_sit_entry(struct f2fs_sb_info *sbi,
-					unsigned int segno, struct list_head *head)
+					unsigned int segno)
 {
-	struct sit_entry_set *ses;
 	struct f2fs_sm_info *sm_i = SM_I(sbi);
-	unsigned int start_segno = START_SEGNO(segno);
+	unsigned int set = SIT_BLOCK_OFFSET(segno);
+	struct sit_entry_set *ses= &sm_i->sit_sets[set];
 
-	list_for_each_entry(ses, head, set_list) {
-		if (ses->start_segno == start_segno) {
-			ses->entry_cnt++;
-			list_move_tail(&ses->cnt_list, &sm_i->dirty_set[ses->entry_cnt]);
-			return;
-		}
-	}
-
-	ses = grab_sit_entry_set();
-
-	ses->start_segno = start_segno;
 	ses->entry_cnt++;
 	list_move_tail(&ses->cnt_list, &sm_i->dirty_set[ses->entry_cnt]);
-	list_add(&ses->set_list, head);
 }
 
 static void add_sits_in_set(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_sm_info *sm_info = SM_I(sbi);
-	struct list_head *set_list = &sm_info->sit_entry_set;
 	unsigned long *bitmap = SIT_I(sbi)->dirty_sentries_bitmap;
 	unsigned int segno;
 
 	for_each_set_bit(segno, bitmap, MAIN_SEGS(sbi))
-		add_sit_entry(sbi, segno, set_list);
+		add_sit_entry(sbi, segno);
 }
 
 static void remove_sits_in_journal(struct f2fs_sb_info *sbi)
@@ -2708,7 +2681,7 @@ static void remove_sits_in_journal(struct f2fs_sb_info *sbi)
 		dirtied = __mark_sit_entry_dirty(sbi, segno);
 
 		if (!dirtied)
-			add_sit_entry(sbi, segno, &SM_I(sbi)->sit_entry_set);
+			add_sit_entry(sbi, segno);
 	}
 	update_sits_in_cursum(journal, -i);
 	up_write(&curseg->journal_rwsem);
@@ -2788,7 +2761,6 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
 	struct f2fs_journal *journal = curseg->journal;
 	struct sit_entry_set *ses, *tmp;
-	struct list_head *head = &SM_I(sbi)->sit_entry_set;
 	bool to_journal = true;
 	int i;
 
@@ -2826,7 +2798,6 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		f2fs_bug_on(sbi, !list_empty(&sm_i->dirty_set[i]));
 	}
 
-	f2fs_bug_on(sbi, !list_empty(head));
 	f2fs_bug_on(sbi, sit_i->dirty_sentries);
 out:
 	if (cpc->reason & CP_DISCARD) {
@@ -3191,13 +3162,26 @@ static void init_min_max_mtime(struct f2fs_sb_info *sbi)
 	mutex_unlock(&sit_i->sentry_lock);
 }
 
-static void init_sit_dirty_set_list(struct f2fs_sb_info *sbi)
+static int init_sit_dirty_set_list(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_sm_info *sm_i = SM_I(sbi);
-	int i;
+	int i, entries;
+
+	entries = (MAIN_SEGS(sbi) + SIT_ENTRY_PER_BLOCK - 1) / SIT_ENTRY_PER_BLOCK;
+	sm_i->sit_sets = f2fs_kvzalloc(entries *
+							sizeof(struct sit_entry_set), GFP_KERNEL);
+	if (!sm_i->sit_sets)
+		return -ENOMEM;
+
+	/* kvzalloc, so no need to init sit_entry_set->entry-cnt */
+	for (i = 0; i < entries; i++) {
+		INIT_LIST_HEAD(&sm_i->sit_sets[i].cnt_list);
+		sm_i->sit_sets[i].start_segno = i * SIT_ENTRY_PER_BLOCK;
+	}
 
 	for (i = 0; i <= SIT_ENTRY_PER_BLOCK; i++)
 		INIT_LIST_HEAD(&sm_i->dirty_set[i]);
+	return 0;
 }
 
 int build_segment_manager(struct f2fs_sb_info *sbi)
@@ -3233,8 +3217,6 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 
 	sm_info->trim_sections = DEF_BATCHED_TRIM_SECTIONS;
 
-	INIT_LIST_HEAD(&sm_info->sit_entry_set);
-
 	if (test_opt(sbi, FLUSH_MERGE) && !f2fs_readonly(sbi->sb)) {
 		err = create_flush_cmd_control(sbi);
 		if (err)
@@ -3264,8 +3246,8 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 		return err;
 
 	init_min_max_mtime(sbi);
-	init_sit_dirty_set_list(sbi);
-	return 0;
+	err = init_sit_dirty_set_list(sbi);
+	return err;
 }
 
 static void discard_dirty_segmap(struct f2fs_sb_info *sbi,
@@ -3372,6 +3354,7 @@ void destroy_segment_manager(struct f2fs_sb_info *sbi)
 	destroy_curseg(sbi);
 	destroy_free_segmap(sbi);
 	destroy_sit_info(sbi);
+	kfree(sm_info->sit_sets);
 	sbi->sm_info = NULL;
 	kfree(sm_info);
 }
@@ -3388,19 +3371,12 @@ int __init create_segment_manager_caches(void)
 	if (!discard_cmd_slab)
 		goto destroy_discard_entry;
 
-	sit_entry_set_slab = f2fs_kmem_cache_create("sit_entry_set",
-			sizeof(struct sit_entry_set));
-	if (!sit_entry_set_slab)
-		goto destroy_discard_cmd;
-
 	inmem_entry_slab = f2fs_kmem_cache_create("inmem_page_entry",
 			sizeof(struct inmem_pages));
 	if (!inmem_entry_slab)
-		goto destroy_sit_entry_set;
+		goto destroy_discard_cmd;
 	return 0;
 
-destroy_sit_entry_set:
-	kmem_cache_destroy(sit_entry_set_slab);
 destroy_discard_cmd:
 	kmem_cache_destroy(discard_cmd_slab);
 destroy_discard_entry:
@@ -3411,7 +3387,6 @@ int __init create_segment_manager_caches(void)
 
 void destroy_segment_manager_caches(void)
 {
-	kmem_cache_destroy(sit_entry_set_slab);
 	kmem_cache_destroy(discard_cmd_slab);
 	kmem_cache_destroy(discard_entry_slab);
 	kmem_cache_destroy(inmem_entry_slab);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 3fca58e..dfb6ed5 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -294,7 +294,6 @@ struct curseg_info {
 };
 
 struct sit_entry_set {
-	struct list_head set_list;	/* link with all sit sets globally */
 	struct list_head cnt_list;  /* link to sets with same # of dirty sit entries */
 	unsigned int start_segno;	/* start segno of sits in set */
 	unsigned int entry_cnt;		/* the # of sit entries in set */
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
