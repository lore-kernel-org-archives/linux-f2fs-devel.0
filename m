From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/4] f2fs: show issued flush/discard count
Date: Sat, 25 Mar 2017 17:19:58 +0800
Message-ID: <20170325091959.57695-3-yuchao0@huawei.com>
References: <20170325091959.57695-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1crhsA-0006Ft-59
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Mar 2017 09:20:34 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1crhs7-0003hy-Ql
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Mar 2017 09:20:34 +0000
In-Reply-To: <20170325091959.57695-1-yuchao0@huawei.com>
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Show historical count of flush command and discard command.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/debug.c   | 24 ++++++++++++++++--------
 fs/f2fs/f2fs.h    |  9 ++++++---
 fs/f2fs/segment.c | 37 +++++++++++++++++++++++--------------
 3 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 0baa3ee39392..f27e66ea7ff3 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -56,12 +56,18 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->max_vw_cnt = atomic_read(&sbi->max_vw_cnt);
 	si->nr_wb_cp_data = get_pages(sbi, F2FS_WB_CP_DATA);
 	si->nr_wb_data = get_pages(sbi, F2FS_WB_DATA);
-	if (SM_I(sbi) && SM_I(sbi)->fcc_info)
-		si->nr_flush =
-			atomic_read(&SM_I(sbi)->fcc_info->submit_flush);
-	if (SM_I(sbi) && SM_I(sbi)->dcc_info)
-		si->nr_discard =
-			atomic_read(&SM_I(sbi)->dcc_info->submit_discard);
+	if (SM_I(sbi) && SM_I(sbi)->fcc_info) {
+		si->nr_flushed =
+			atomic_read(&SM_I(sbi)->fcc_info->issued_flush);
+		si->nr_flushing =
+			atomic_read(&SM_I(sbi)->fcc_info->issing_flush);
+	}
+	if (SM_I(sbi) && SM_I(sbi)->dcc_info) {
+		si->nr_discarded =
+			atomic_read(&SM_I(sbi)->dcc_info->issued_discard);
+		si->nr_discarding =
+			atomic_read(&SM_I(sbi)->dcc_info->issing_discard);
+	}
 	si->total_count = (int)sbi->user_block_count / sbi->blocks_per_seg;
 	si->rsvd_segs = reserved_segments(sbi);
 	si->overp_segs = overprovision_segments(sbi);
@@ -336,9 +342,11 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "  - Inner Struct Count: tree: %d(%d), node: %d\n",
 				si->ext_tree, si->zombie_tree, si->ext_node);
 		seq_puts(s, "\nBalancing F2FS Async:\n");
-		seq_printf(s, "  - IO (CP: %4d, Data: %4d, Flush: %4d, Discard: %4d)\n",
+		seq_printf(s, "  - IO (CP: %4d, Data: %4d, Flush: (%4d %4d), "
+			"Discard: (%4d %4d))\n",
 			   si->nr_wb_cp_data, si->nr_wb_data,
-			   si->nr_flush, si->nr_discard);
+			   si->nr_flushing, si->nr_flushed,
+			   si->nr_discarding, si->nr_discarded);
 		seq_printf(s, "  - inmem: %4d, atomic IO: %4d (Max. %4d), "
 			"volatile IO: %4d (Max. %4d)\n",
 			   si->inmem_pages, si->aw_cnt, si->max_aw_cnt,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 054c72da466f..8145fa5ca53e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -215,7 +215,8 @@ struct discard_cmd_control {
 	wait_queue_head_t discard_wait_queue;	/* waiting queue for wake-up */
 	struct mutex cmd_lock;
 	int max_discards;			/* max. discards to be issued */
-	atomic_t submit_discard;		/* # of issued discard */
+	atomic_t issued_discard;		/* # of issued discard */
+	atomic_t issing_discard;		/* # of issing discard */
 };
 
 /* for the list of fsync inodes, used only during recovery */
@@ -644,7 +645,8 @@ struct flush_cmd {
 struct flush_cmd_control {
 	struct task_struct *f2fs_issue_flush;	/* flush thread */
 	wait_queue_head_t flush_wait_queue;	/* waiting queue for wake-up */
-	atomic_t submit_flush;			/* # of issued flushes */
+	atomic_t issued_flush;			/* # of issued flushes */
+	atomic_t issing_flush;			/* # of issing flushes */
 	struct llist_head issue_list;		/* list for command issue */
 	struct llist_node *dispatch_list;	/* list for command dispatch */
 };
@@ -2332,7 +2334,8 @@ struct f2fs_stat_info {
 	unsigned int ndirty_dirs, ndirty_files, ndirty_all;
 	int nats, dirty_nats, sits, dirty_sits, free_nids, alloc_nids;
 	int total_count, utilization;
-	int bg_gc, nr_wb_cp_data, nr_wb_data, nr_flush, nr_discard;
+	int bg_gc, nr_wb_cp_data, nr_wb_data;
+	int nr_flushing, nr_flushed, nr_discarding, nr_discarded;
 	int inline_xattr, inline_inode, inline_dir, append, update, orphans;
 	int aw_cnt, max_aw_cnt, vw_cnt, max_vw_cnt;
 	unsigned int valid_count, valid_node_count, valid_inode_count, discard_blks;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4d345897b1ce..bf7e29d45513 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -490,6 +490,8 @@ static int issue_flush_thread(void *data)
 		fcc->dispatch_list = llist_reverse_order(fcc->dispatch_list);
 
 		ret = submit_flush_wait(sbi);
+		atomic_inc(&fcc->issued_flush);
+
 		llist_for_each_entry_safe(cmd, next,
 					  fcc->dispatch_list, llnode) {
 			cmd->ret = ret;
@@ -507,25 +509,29 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 {
 	struct flush_cmd_control *fcc = SM_I(sbi)->fcc_info;
 	struct flush_cmd cmd;
+	int ret;
 
 	if (test_opt(sbi, NOBARRIER))
 		return 0;
 
-	if (!test_opt(sbi, FLUSH_MERGE))
-		return submit_flush_wait(sbi);
-
-	if (!atomic_read(&fcc->submit_flush)) {
-		int ret;
+	if (!test_opt(sbi, FLUSH_MERGE)) {
+		ret = submit_flush_wait(sbi);
+		atomic_inc(&fcc->issued_flush);
+		return ret;
+	}
 
-		atomic_inc(&fcc->submit_flush);
+	if (!atomic_read(&fcc->issing_flush)) {
+		atomic_inc(&fcc->issing_flush);
 		ret = submit_flush_wait(sbi);
-		atomic_dec(&fcc->submit_flush);
+		atomic_dec(&fcc->issing_flush);
+
+		atomic_inc(&fcc->issued_flush);
 		return ret;
 	}
 
 	init_completion(&cmd.wait);
 
-	atomic_inc(&fcc->submit_flush);
+	atomic_inc(&fcc->issing_flush);
 	llist_add(&cmd.llnode, &fcc->issue_list);
 
 	if (!fcc->dispatch_list)
@@ -533,10 +539,10 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 
 	if (fcc->f2fs_issue_flush) {
 		wait_for_completion(&cmd.wait);
-		atomic_dec(&fcc->submit_flush);
+		atomic_dec(&fcc->issing_flush);
 	} else {
 		llist_del_all(&fcc->issue_list);
-		atomic_set(&fcc->submit_flush, 0);
+		atomic_set(&fcc->issing_flush, 0);
 	}
 
 	return cmd.ret;
@@ -556,7 +562,8 @@ int create_flush_cmd_control(struct f2fs_sb_info *sbi)
 	fcc = kzalloc(sizeof(struct flush_cmd_control), GFP_KERNEL);
 	if (!fcc)
 		return -ENOMEM;
-	atomic_set(&fcc->submit_flush, 0);
+	atomic_set(&fcc->issued_flush, 0);
+	atomic_set(&fcc->issing_flush, 0);
 	init_waitqueue_head(&fcc->flush_wait_queue);
 	init_llist_head(&fcc->issue_list);
 	SM_I(sbi)->fcc_info = fcc;
@@ -691,7 +698,7 @@ static void __add_discard_cmd(struct f2fs_sb_info *sbi,
 static void __remove_discard_cmd(struct f2fs_sb_info *sbi, struct discard_cmd *dc)
 {
 	if (dc->state == D_DONE)
-		atomic_dec(&(SM_I(sbi)->dcc_info->submit_discard));
+		atomic_dec(&(SM_I(sbi)->dcc_info->issing_discard));
 
 	if (dc->error == -EOPNOTSUPP)
 		dc->error = 0;
@@ -730,7 +737,8 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 	if (!dc->error) {
 		/* should keep before submission to avoid D_DONE right away */
 		dc->state = D_SUBMIT;
-		atomic_inc(&dcc->submit_discard);
+		atomic_inc(&dcc->issued_discard);
+		atomic_inc(&dcc->issing_discard);
 		if (bio) {
 			bio->bi_private = dc;
 			bio->bi_end_io = f2fs_submit_discard_endio;
@@ -1149,7 +1157,8 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	INIT_LIST_HEAD(&dcc->discard_pend_list);
 	INIT_LIST_HEAD(&dcc->discard_wait_list);
 	mutex_init(&dcc->cmd_lock);
-	atomic_set(&dcc->submit_discard, 0);
+	atomic_set(&dcc->issued_discard, 0);
+	atomic_set(&dcc->issing_discard, 0);
 	dcc->nr_discards = 0;
 	dcc->max_discards = 0;
 
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
