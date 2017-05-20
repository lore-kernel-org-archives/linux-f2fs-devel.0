From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 3/5] f2fs: use bucket sort to avoid list sort
	when flush sit entries
Date: Sat, 20 May 2017 12:24:33 +0000
Message-ID: <20170520122435.17574-4-houpengyang@huawei.com>
References: <20170520122435.17574-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1dC3RN-0001Or-BQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 20 May 2017 12:25:01 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dC3RL-0007hD-Ll
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 20 May 2017 12:25:01 +0000
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

Like we optimized nat flushing with bucket sort, in this patch, we introduce a bucket 
 f2fs_sm_info->dirty to linked link all nat_entry_set to be flushed by their cnt_count.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c | 53 +++++++++++++++++++++++++++++------------------------
 fs/f2fs/segment.h |  3 ++-
 3 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 88a96bb..198da30 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -733,6 +733,7 @@ struct f2fs_sm_info {
 	unsigned int trim_sections;		/* # of sections to trim */
 
 	struct list_head sit_entry_set;	/* sit entry set list */
+	struct list_head dirty_set[SIT_ENTRY_PER_BLOCK + 1];
 
 	unsigned int ipu_policy;	/* in-place-update policy */
 	unsigned int min_ipu_util;	/* in-place-update threshold */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2c99fec..af470d3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2648,39 +2648,28 @@ static struct sit_entry_set *grab_sit_entry_set(void)
 
 	ses->entry_cnt = 0;
 	INIT_LIST_HEAD(&ses->set_list);
+	INIT_LIST_HEAD(&ses->cnt_list);
 	return ses;
 }
 
 static void release_sit_entry_set(struct sit_entry_set *ses)
 {
 	list_del(&ses->set_list);
+	list_del(&ses->cnt_list);
 	kmem_cache_free(sit_entry_set_slab, ses);
 }
 
-static void adjust_sit_entry_set(struct sit_entry_set *ses,
-						struct list_head *head)
-{
-	struct sit_entry_set *next = ses;
-
-	if (list_is_last(&ses->set_list, head))
-		return;
-
-	list_for_each_entry_continue(next, head, set_list)
-		if (ses->entry_cnt <= next->entry_cnt)
-			break;
-
-	list_move_tail(&ses->set_list, &next->set_list);
-}
-
-static void add_sit_entry(unsigned int segno, struct list_head *head)
+static void add_sit_entry(struct f2fs_sb_info *sbi,
+					unsigned int segno, struct list_head *head)
 {
 	struct sit_entry_set *ses;
+	struct f2fs_sm_info *sm_i = SM_I(sbi);
 	unsigned int start_segno = START_SEGNO(segno);
 
 	list_for_each_entry(ses, head, set_list) {
 		if (ses->start_segno == start_segno) {
 			ses->entry_cnt++;
-			adjust_sit_entry_set(ses, head);
+			list_move_tail(&ses->cnt_list, &sm_i->dirty_set[ses->entry_cnt]);
 			return;
 		}
 	}
@@ -2689,6 +2678,7 @@ static void add_sit_entry(unsigned int segno, struct list_head *head)
 
 	ses->start_segno = start_segno;
 	ses->entry_cnt++;
+	list_move_tail(&ses->cnt_list, &sm_i->dirty_set[ses->entry_cnt]);
 	list_add(&ses->set_list, head);
 }
 
@@ -2700,7 +2690,7 @@ static void add_sits_in_set(struct f2fs_sb_info *sbi)
 	unsigned int segno;
 
 	for_each_set_bit(segno, bitmap, MAIN_SEGS(sbi))
-		add_sit_entry(segno, set_list);
+		add_sit_entry(sbi, segno, set_list);
 }
 
 static void remove_sits_in_journal(struct f2fs_sb_info *sbi)
@@ -2718,7 +2708,7 @@ static void remove_sits_in_journal(struct f2fs_sb_info *sbi)
 		dirtied = __mark_sit_entry_dirty(sbi, segno);
 
 		if (!dirtied)
-			add_sit_entry(segno, &SM_I(sbi)->sit_entry_set);
+			add_sit_entry(sbi, segno, &SM_I(sbi)->sit_entry_set);
 	}
 	update_sits_in_cursum(journal, -i);
 	up_write(&curseg->journal_rwsem);
@@ -2794,11 +2784,13 @@ static void __flush_sit_entry_set(struct f2fs_sb_info *sbi,
 void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
+	struct f2fs_sm_info *sm_i = SM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
 	struct f2fs_journal *journal = curseg->journal;
 	struct sit_entry_set *ses, *tmp;
 	struct list_head *head = &SM_I(sbi)->sit_entry_set;
 	bool to_journal = true;
+	int i;
 
 	mutex_lock(&sit_i->sentry_lock);
 
@@ -2824,11 +2816,14 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * #1, flush sit entries to journal in current cold data summary block.
 	 * #2, flush sit entries to sit page.
 	 */
-	list_for_each_entry_safe(ses, tmp, head, set_list) {
-		if (to_journal &&
-			!__has_cursum_space(journal, ses->entry_cnt, SIT_JOURNAL))
-			to_journal = false;
-		__flush_sit_entry_set(sbi, ses, cpc, to_journal);
+	for (i = 0; i <= SIT_ENTRY_PER_BLOCK; i++) {
+		list_for_each_entry_safe(ses, tmp, &sm_i->dirty_set[i], cnt_list) {
+			if (to_journal &&
+				!__has_cursum_space(journal, ses->entry_cnt, SIT_JOURNAL))
+				to_journal = false;
+			__flush_sit_entry_set(sbi, ses, cpc, to_journal);
+		}
+		f2fs_bug_on(sbi, !list_empty(&sm_i->dirty_set[i]));
 	}
 
 	f2fs_bug_on(sbi, !list_empty(head));
@@ -3196,6 +3191,15 @@ static void init_min_max_mtime(struct f2fs_sb_info *sbi)
 	mutex_unlock(&sit_i->sentry_lock);
 }
 
+static void init_sit_dirty_set_list(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_sm_info *sm_i = SM_I(sbi);
+	int i;
+
+	for (i = 0; i <= SIT_ENTRY_PER_BLOCK; i++)
+		INIT_LIST_HEAD(&sm_i->dirty_set[i]);
+}
+
 int build_segment_manager(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
@@ -3260,6 +3264,7 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 		return err;
 
 	init_min_max_mtime(sbi);
+	init_sit_dirty_set_list(sbi);
 	return 0;
 }
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index e9ba1f1..3fca58e 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -294,7 +294,8 @@ struct curseg_info {
 };
 
 struct sit_entry_set {
-	struct list_head set_list;	/* link with all sit sets */
+	struct list_head set_list;	/* link with all sit sets globally */
+	struct list_head cnt_list;  /* link to sets with same # of dirty sit entries */
 	unsigned int start_segno;	/* start segno of sits in set */
 	unsigned int entry_cnt;		/* the # of sit entries in set */
 };
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
