From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/4] f2fs: count discard command entry
Date: Sat, 25 Mar 2017 17:19:59 +0800
Message-ID: <20170325091959.57695-4-yuchao0@huawei.com>
References: <20170325091959.57695-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1crhs8-0003bD-Q8
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Mar 2017 09:20:32 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1crhs7-0003i1-2C
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Mar 2017 09:20:32 +0000
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

Adds to count discard command entry and show the number in debugfs,
also fix to add cost of discard command cache into total comsumed
memory footprint.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/debug.c   | 12 +++++++++---
 fs/f2fs/f2fs.h    |  2 ++
 fs/f2fs/segment.c |  4 ++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index f27e66ea7ff3..906f627e44fc 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -67,6 +67,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 			atomic_read(&SM_I(sbi)->dcc_info->issued_discard);
 		si->nr_discarding =
 			atomic_read(&SM_I(sbi)->dcc_info->issing_discard);
+		si->nr_discard_cmd =
+			atomic_read(&SM_I(sbi)->dcc_info->discard_cmd_cnt);
 	}
 	si->total_count = (int)sbi->user_block_count / sbi->blocks_per_seg;
 	si->rsvd_segs = reserved_segments(sbi);
@@ -220,8 +222,11 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	/* build merge flush thread */
 	if (SM_I(sbi)->fcc_info)
 		si->cache_mem += sizeof(struct flush_cmd_control);
-	if (SM_I(sbi)->dcc_info)
+	if (SM_I(sbi)->dcc_info) {
 		si->cache_mem += sizeof(struct discard_cmd_control);
+		si->cache_mem += sizeof(struct discard_cmd) *
+			atomic_read(&SM_I(sbi)->dcc_info->discard_cmd_cnt);
+	}
 
 	/* free nids */
 	si->cache_mem += (NM_I(sbi)->nid_cnt[FREE_NID_LIST] +
@@ -343,10 +348,11 @@ static int stat_show(struct seq_file *s, void *v)
 				si->ext_tree, si->zombie_tree, si->ext_node);
 		seq_puts(s, "\nBalancing F2FS Async:\n");
 		seq_printf(s, "  - IO (CP: %4d, Data: %4d, Flush: (%4d %4d), "
-			"Discard: (%4d %4d))\n",
+			"Discard: (%4d %4d)) cmd: %4d\n",
 			   si->nr_wb_cp_data, si->nr_wb_data,
 			   si->nr_flushing, si->nr_flushed,
-			   si->nr_discarding, si->nr_discarded);
+			   si->nr_discarding, si->nr_discarded,
+			   si->nr_discard_cmd);
 		seq_printf(s, "  - inmem: %4d, atomic IO: %4d (Max. %4d), "
 			"volatile IO: %4d (Max. %4d)\n",
 			   si->inmem_pages, si->aw_cnt, si->max_aw_cnt,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8145fa5ca53e..aa6fdeada83c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -217,6 +217,7 @@ struct discard_cmd_control {
 	int max_discards;			/* max. discards to be issued */
 	atomic_t issued_discard;		/* # of issued discard */
 	atomic_t issing_discard;		/* # of issing discard */
+	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
 };
 
 /* for the list of fsync inodes, used only during recovery */
@@ -2336,6 +2337,7 @@ struct f2fs_stat_info {
 	int total_count, utilization;
 	int bg_gc, nr_wb_cp_data, nr_wb_data;
 	int nr_flushing, nr_flushed, nr_discarding, nr_discarded;
+	int nr_discard_cmd;
 	int inline_xattr, inline_inode, inline_dir, append, update, orphans;
 	int aw_cnt, max_aw_cnt, vw_cnt, max_vw_cnt;
 	unsigned int valid_count, valid_node_count, valid_inode_count, discard_blks;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bf7e29d45513..52aa36d7b2a6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -693,6 +693,8 @@ static void __add_discard_cmd(struct f2fs_sb_info *sbi,
 	mutex_lock(&dcc->cmd_lock);
 	list_add_tail(&dc->list, pend_list);
 	mutex_unlock(&dcc->cmd_lock);
+
+	atomic_inc(&dcc->discard_cmd_cnt);
 }
 
 static void __remove_discard_cmd(struct f2fs_sb_info *sbi, struct discard_cmd *dc)
@@ -708,6 +710,7 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi, struct discard_cmd *d
 				"Issue discard failed, ret: %d", dc->error);
 	list_del(&dc->list);
 	kmem_cache_free(discard_cmd_slab, dc);
+	atomic_dec(&SM_I(sbi)->dcc_info->discard_cmd_cnt);
 }
 
 static void f2fs_submit_discard_endio(struct bio *bio)
@@ -1159,6 +1162,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	mutex_init(&dcc->cmd_lock);
 	atomic_set(&dcc->issued_discard, 0);
 	atomic_set(&dcc->issing_discard, 0);
+	atomic_set(&dcc->discard_cmd_cnt, 0);
 	dcc->nr_discards = 0;
 	dcc->max_discards = 0;
 
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
