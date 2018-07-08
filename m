From: Chao Yu <chao@kernel.org>
Subject: [PATCH v3 2/2] f2fs: let checkpoint flush dnode page of
 regular
Date: Sun,  8 Jul 2018 22:04:43 +0800
Message-ID: <20180708140443.23244-2-chao@kernel.org>
References: <20180708140443.23244-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fcAJb-0002OH-9I
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Jul 2018 14:05:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fcAJY-003Ok2-BE
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Jul 2018 14:05:27 +0000
In-Reply-To: <20180708140443.23244-1-chao@kernel.org>
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

From: Chao Yu <yuchao0@huawei.com>

Fsyncer will wait on all dnode pages of regular writeback before flushing,
if there are async dnode pages blocked by IO scheduler, it may decrease
fsync's performance.

In this patch, we choose to let f2fs_balance_fs_bg() to trigger checkpoint
to flush these dnode pages of regular, so async IO of dnode page can be
elimitnated, making fsyncer only need to wait for sync IO.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- rebase code.
 fs/f2fs/node.c    | 8 +++++++-
 fs/f2fs/node.h    | 5 +++++
 fs/f2fs/segment.c | 4 +++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 31dc372c56a0..c48e2a2e5e82 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1453,6 +1453,10 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
 
+	if (wbc->sync_mode == WB_SYNC_NONE &&
+			IS_DNODE(page) && is_cold_node(page))
+		goto redirty_out;
+
 	/* get old block addr of this node page */
 	nid = nid_of_node(page);
 	f2fs_bug_on(sbi, page->index != nid);
@@ -1778,10 +1782,12 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 	}
 
 	if (step < 2) {
+		if (wbc->sync_mode == WB_SYNC_NONE && step == 1)
+			goto out;
 		step++;
 		goto next_step;
 	}
-
+out:
 	if (nwritten)
 		f2fs_submit_merged_write(sbi, NODE);
 
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index b95e49e4a928..b0da4c26eebb 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -135,6 +135,11 @@ static inline bool excess_cached_nats(struct f2fs_sb_info *sbi)
 	return NM_I(sbi)->nat_cnt >= DEF_NAT_CACHE_THRESHOLD;
 }
 
+static inline bool excess_dirty_nodes(struct f2fs_sb_info *sbi)
+{
+	return get_pages(sbi, F2FS_DIRTY_NODES) >= sbi->blocks_per_seg * 8;
+}
+
 enum mem_type {
 	FREE_NIDS,	/* indicates the free nid list */
 	NAT_ENTRIES,	/* indicates the cached nat entry */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 47b6595a078c..99beaf0a2dea 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -503,7 +503,8 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 	else
 		f2fs_build_free_nids(sbi, false, false);
 
-	if (!is_idle(sbi) && !excess_dirty_nats(sbi))
+	if (!is_idle(sbi) &&
+		(!excess_dirty_nats(sbi) && !excess_dirty_nodes(sbi)))
 		return;
 
 	/* checkpoint is the only way to shrink partial cached entries */
@@ -511,6 +512,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 			!f2fs_available_free_memory(sbi, INO_ENTRIES) ||
 			excess_prefree_segs(sbi) ||
 			excess_dirty_nats(sbi) ||
+			excess_dirty_nodes(sbi) ||
 			f2fs_time_over(sbi, CP_TIME)) {
 		if (test_opt(sbi, DATA_FLUSH)) {
 			struct blk_plug plug;
-- 
2.16.2.17.g38e79b1fd


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
