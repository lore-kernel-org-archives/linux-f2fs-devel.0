From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v4 2/2] f2fs: let checkpoint flush dnode page of regular
Date: Wed, 25 Jul 2018 19:16:21 +0800
Message-ID: <20180725111621.37564-2-yuchao0@huawei.com>
References: <20180725111621.37564-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725111621.37564-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Fsyncer will wait on all dnode pages of regular writeback before flushing,
if there are async dnode pages blocked by IO scheduler, it may decrease
fsync's performance.

In this patch, we choose to let f2fs_balance_fs_bg() to trigger checkpoint
to flush these dnode pages of regular, so async IO of dnode page can be
elimitnated, making fsyncer only need to wait for sync IO.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v4:
- rebase to last dev-test.
 fs/f2fs/node.c    | 8 +++++++-
 fs/f2fs/node.h    | 5 +++++
 fs/f2fs/segment.c | 4 +++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d976b8fe479d..2bc5ff76c19c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1478,6 +1478,10 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
 
+	if (wbc->sync_mode == WB_SYNC_NONE &&
+			IS_DNODE(page) && is_cold_node(page))
+		goto redirty_out;
+
 	/* get old block addr of this node page */
 	nid = nid_of_node(page);
 	f2fs_bug_on(sbi, page->index != nid);
@@ -1804,10 +1808,12 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
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
index 8f34bdffde93..0f4db7a61254 100644
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
index 17354089b4ab..27f9a3202d6f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -509,7 +509,8 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 	else
 		f2fs_build_free_nids(sbi, false, false);
 
-	if (!is_idle(sbi) && !excess_dirty_nats(sbi))
+	if (!is_idle(sbi) &&
+		(!excess_dirty_nats(sbi) && !excess_dirty_nodes(sbi)))
 		return;
 
 	/* checkpoint is the only way to shrink partial cached entries */
@@ -517,6 +518,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 			!f2fs_available_free_memory(sbi, INO_ENTRIES) ||
 			excess_prefree_segs(sbi) ||
 			excess_dirty_nats(sbi) ||
+			excess_dirty_nodes(sbi) ||
 			f2fs_time_over(sbi, CP_TIME)) {
 		if (test_opt(sbi, DATA_FLUSH)) {
 			struct blk_plug plug;
-- 
2.18.0.rc1
