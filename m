From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/5] f2fs: show GC failure info in debugfs
Date: Wed, 18 Apr 2018 17:45:04 +0800
Message-ID: <20180418094505.98888-4-yuchao0@huawei.com>
References: <20180418094505.98888-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f8jed-0004br-3X
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Apr 2018 09:45:31 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f8jeb-00HAUz-3E
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Apr 2018 09:45:31 +0000
In-Reply-To: <20180418094505.98888-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds to show GC failure information in debugfs, now it just
shows count of failure caused by atomic write.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/debug.c |  5 +++++
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/gc.c    | 13 +++++++------
 fs/f2fs/gc.h    |  2 +-
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index a66107b5cfff..715beb85e9db 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -104,6 +104,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->avail_nids = NM_I(sbi)->available_nids;
 	si->alloc_nids = NM_I(sbi)->nid_cnt[PREALLOC_NID];
 	si->bg_gc = sbi->bg_gc;
+	si->bg_atomic = sbi->gc_thread->atomic_file[BG_GC];
+	si->fg_atomic = sbi->gc_thread->atomic_file[FG_GC];
 	si->util_free = (int)(free_user_blocks(sbi) >> sbi->log_blocks_per_seg)
 		* 100 / (int)(sbi->user_block_count >> sbi->log_blocks_per_seg)
 		/ 2;
@@ -342,6 +344,9 @@ static int stat_show(struct seq_file *s, void *v)
 				si->bg_data_blks);
 		seq_printf(s, "  - node blocks : %d (%d)\n", si->node_blks,
 				si->bg_node_blks);
+		seq_printf(s, "Failure : atomic write %d (%d)\n",
+				si->bg_atomic + si->fg_atomic,
+				si->bg_atomic);
 		seq_puts(s, "\nExtent Cache:\n");
 		seq_printf(s, "  - Hit Count: L1-1:%llu L1-2:%llu L2:%llu\n",
 				si->hit_largest, si->hit_cached,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3453288d6a71..567c6bb57ae3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3003,6 +3003,7 @@ struct f2fs_stat_info {
 	int bg_node_segs, bg_data_segs;
 	int tot_blks, data_blks, node_blks;
 	int bg_data_blks, bg_node_blks;
+	unsigned int bg_atomic, fg_atomic;
 	int curseg[NR_CURSEG_TYPE];
 	int cursec[NR_CURSEG_TYPE];
 	int curzone[NR_CURSEG_TYPE];
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 495876ca62b6..da89ca16a55d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -135,7 +135,8 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
 	gc_th->gc_urgent = 0;
 	gc_th->gc_wake= 0;
 
-	gc_th->atomic_file = 0;
+	gc_th->atomic_file[BG_GC] = 0;
+	gc_th->atomic_file[FG_GC] = 0;
 
 	sbi->gc_thread = gc_th;
 	init_waitqueue_head(&sbi->gc_thread->gc_wait_queue_head);
@@ -633,7 +634,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
 		goto out;
 
 	if (f2fs_is_atomic_file(inode)) {
-		F2FS_I_SB(inode)->gc_thread->atomic_file++;
+		F2FS_I_SB(inode)->gc_thread->atomic_file[gc_type]++;
 		goto out;
 	}
 
@@ -742,7 +743,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 		goto out;
 
 	if (f2fs_is_atomic_file(inode)) {
-		F2FS_I_SB(inode)->gc_thread->atomic_file++;
+		F2FS_I_SB(inode)->gc_thread->atomic_file[gc_type]++;
 		goto out;
 	}
 	if (f2fs_is_pinned_file(inode)) {
@@ -1024,7 +1025,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 		.ilist = LIST_HEAD_INIT(gc_list.ilist),
 		.iroot = RADIX_TREE_INIT(GFP_NOFS),
 	};
-	unsigned int last_atomic_file = sbi->gc_thread->atomic_file;
+	unsigned int last_atomic_file = sbi->gc_thread->atomic_file[FG_GC];
 	unsigned int skipped_round = 0, round = 0;
 
 	trace_f2fs_gc_begin(sbi->sb, sync, background,
@@ -1078,9 +1079,9 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 	total_freed += seg_freed;
 
 	if (gc_type == FG_GC) {
-		if (sbi->gc_thread->atomic_file > last_atomic_file)
+		if (sbi->gc_thread->atomic_file[FG_GC] > last_atomic_file)
 			skipped_round++;
-		last_atomic_file = sbi->gc_thread->atomic_file;
+		last_atomic_file = sbi->gc_thread->atomic_file[FG_GC];
 		round++;
 	}
 
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index bc1d21d46ae7..a6cffe6b249b 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -41,7 +41,7 @@ struct f2fs_gc_kthread {
 	unsigned int gc_wake;
 
 	/* for stuck statistic */
-	unsigned int atomic_file;
+	unsigned int atomic_file[2];
 };
 
 struct gc_inode_list {
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
