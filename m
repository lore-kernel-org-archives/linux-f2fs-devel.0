From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: add undiscard blocks stat
Date: Tue, 18 Apr 2017 19:23:40 +0800
Message-ID: <20170418112340.96171-2-yuchao0@huawei.com>
References: <20170418112340.96171-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d0RF4-0005AH-Ck
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Apr 2017 11:24:18 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187]
	helo=dggrg01-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d0REz-0002q6-Sm
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Apr 2017 11:24:18 +0000
In-Reply-To: <20170418112340.96171-1-yuchao0@huawei.com>
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

This patch adds to account undiscard blocks.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/debug.c   | 5 +++--
 fs/f2fs/f2fs.h    | 2 ++
 fs/f2fs/segment.c | 9 +++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 692beff66bf8..6102737473d4 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -69,6 +69,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 			atomic_read(&SM_I(sbi)->dcc_info->issing_discard);
 		si->nr_discard_cmd =
 			atomic_read(&SM_I(sbi)->dcc_info->discard_cmd_cnt);
+		si->undiscard_blks = SM_I(sbi)->dcc_info->undiscard_blks;
 	}
 	si->total_count = (int)sbi->user_block_count / sbi->blocks_per_seg;
 	si->rsvd_segs = reserved_segments(sbi);
@@ -348,11 +349,11 @@ static int stat_show(struct seq_file *s, void *v)
 				si->ext_tree, si->zombie_tree, si->ext_node);
 		seq_puts(s, "\nBalancing F2FS Async:\n");
 		seq_printf(s, "  - IO (CP: %4d, Data: %4d, Flush: (%4d %4d), "
-			"Discard: (%4d %4d)) cmd: %4d\n",
+			"Discard: (%4d %4d)) cmd: %4d undiscard:%4u\n",
 			   si->nr_wb_cp_data, si->nr_wb_data,
 			   si->nr_flushing, si->nr_flushed,
 			   si->nr_discarding, si->nr_discarded,
-			   si->nr_discard_cmd);
+			   si->nr_discard_cmd, si->undiscard_blks);
 		seq_printf(s, "  - inmem: %4d, atomic IO: %4d (Max. %4d), "
 			"volatile IO: %4d (Max. %4d)\n",
 			   si->inmem_pages, si->aw_cnt, si->max_aw_cnt,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5c3e60551df5..b866504e8ec3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -233,6 +233,7 @@ struct discard_cmd_control {
 	struct mutex cmd_lock;
 	int nr_discards;			/* # of discards in the list */
 	int max_discards;			/* max. discards to be issued */
+	unsigned int undiscard_blks;		/* # of undiscard blocks */
 	atomic_t issued_discard;		/* # of issued discard */
 	atomic_t issing_discard;		/* # of issing discard */
 	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
@@ -2393,6 +2394,7 @@ struct f2fs_stat_info {
 	int bg_gc, nr_wb_cp_data, nr_wb_data;
 	int nr_flushing, nr_flushed, nr_discarding, nr_discarded;
 	int nr_discard_cmd;
+	unsigned int undiscard_blks;
 	int inline_xattr, inline_inode, inline_dir, append, update, orphans;
 	int aw_cnt, max_aw_cnt, vw_cnt, max_vw_cnt;
 	unsigned int valid_count, valid_node_count, valid_inode_count, discard_blks;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index eea70621a50f..9b7587db73ab 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -695,6 +695,7 @@ static struct discard_cmd *__create_discard_cmd(struct f2fs_sb_info *sbi,
 	init_completion(&dc->wait);
 	list_add_tail(&dc->list, pend_list);
 	atomic_inc(&dcc->discard_cmd_cnt);
+	dcc->undiscard_blks += len;
 
 	return dc;
 }
@@ -723,6 +724,7 @@ static void __detach_discard_cmd(struct discard_cmd_control *dcc,
 
 	list_del(&dc->list);
 	rb_erase(&dc->rb_node, &dcc->root);
+	dcc->undiscard_blks -= dc->len;
 
 	kmem_cache_free(discard_cmd_slab, dc);
 
@@ -831,8 +833,11 @@ static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
 		return;
 	}
 
+	dcc->undiscard_blks -= di.len;
+
 	if (blkaddr > di.lstart) {
 		dc->len = blkaddr - dc->lstart;
+		dcc->undiscard_blks += dc->len;
 		__relocate_discard_cmd(dcc, dc);
 		f2fs_bug_on(sbi, !__check_rb_tree_consistence(sbi, &dcc->root));
 		modified = true;
@@ -850,6 +855,7 @@ static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
 			dc->lstart++;
 			dc->len--;
 			dc->start++;
+			dcc->undiscard_blks += dc->len;
 			__relocate_discard_cmd(dcc, dc);
 			f2fs_bug_on(sbi,
 				!__check_rb_tree_consistence(sbi, &dcc->root));
@@ -911,6 +917,7 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 			prev_dc->bdev == bdev &&
 			__is_discard_back_mergeable(&di, &prev_dc->di)) {
 			prev_dc->di.len += di.len;
+			dcc->undiscard_blks += di.len;
 			__relocate_discard_cmd(dcc, prev_dc);
 			f2fs_bug_on(sbi,
 				!__check_rb_tree_consistence(sbi, &dcc->root));
@@ -925,6 +932,7 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 			next_dc->di.lstart = di.lstart;
 			next_dc->di.len += di.len;
 			next_dc->di.start = di.start;
+			dcc->undiscard_blks += di.len;
 			__relocate_discard_cmd(dcc, next_dc);
 			if (tdc)
 				__remove_discard_cmd(sbi, tdc);
@@ -1358,6 +1366,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	atomic_set(&dcc->discard_cmd_cnt, 0);
 	dcc->nr_discards = 0;
 	dcc->max_discards = DEFAULT_SMALL_DISCARD_NUMBER;
+	dcc->undiscard_blks = 0;
 	dcc->root = RB_ROOT;
 
 	init_waitqueue_head(&dcc->discard_wait_queue);
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
