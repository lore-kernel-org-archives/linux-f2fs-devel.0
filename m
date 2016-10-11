From: Chao Yu <chao@kernel.org>
Subject: [PATCH 6/7] f2fs: don't interrupt free nids building during nid allocation
Date: Tue, 11 Oct 2016 22:31:35 +0800
Message-ID: <20161011143136.2107-6-chao@kernel.org>
References: <20161011143136.2107-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161011143136.2107-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Let build_free_nids support sync/async methods, in allocation flow of nids,
we use synchronuous method, so that we can avoid looping in alloc_nid when
free memory is low; in unblock_operations and f2fs_balance_fs_bg we use
asynchronuous method in where low memory condition can interrupt us.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/f2fs.h       |  2 +-
 fs/f2fs/node.c       | 22 ++++++++++------------
 fs/f2fs/segment.c    |  2 +-
 4 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7e9b504..eacc697 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -987,7 +987,7 @@ static void unblock_operations(struct f2fs_sb_info *sbi)
 {
 	up_write(&sbi->node_write);
 
-	build_free_nids(sbi);
+	build_free_nids(sbi, false);
 	f2fs_unlock_all(sbi);
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a726e47..ce34b5f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2056,7 +2056,7 @@ void move_node_page(struct page *, int);
 int fsync_node_pages(struct f2fs_sb_info *, struct inode *,
 			struct writeback_control *, bool);
 int sync_node_pages(struct f2fs_sb_info *, struct writeback_control *);
-void build_free_nids(struct f2fs_sb_info *);
+void build_free_nids(struct f2fs_sb_info *, bool);
 bool alloc_nid(struct f2fs_sb_info *, nid_t *);
 void alloc_nid_done(struct f2fs_sb_info *, nid_t);
 void alloc_nid_failed(struct f2fs_sb_info *, nid_t);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c68e92d..0a9692e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1744,9 +1744,6 @@ static int add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 	struct free_nid *i;
 	struct nat_entry *ne;
 
-	if (!available_free_memory(sbi, FREE_NIDS))
-		return -1;
-
 	/* 0 nid should not be used */
 	if (unlikely(nid == 0))
 		return 0;
@@ -1817,14 +1814,12 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
 
 		blk_addr = le32_to_cpu(nat_blk->entries[i].block_addr);
 		f2fs_bug_on(sbi, blk_addr == NEW_ADDR);
-		if (blk_addr == NULL_ADDR) {
-			if (add_free_nid(sbi, start_nid, true) < 0)
-				break;
-		}
+		if (blk_addr == NULL_ADDR)
+			add_free_nid(sbi, start_nid, true);
 	}
 }
 
-void __build_free_nids(struct f2fs_sb_info *sbi)
+void __build_free_nids(struct f2fs_sb_info *sbi, bool sync)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
@@ -1836,6 +1831,9 @@ void __build_free_nids(struct f2fs_sb_info *sbi)
 	if (nm_i->free_nid_cnt >= NAT_ENTRY_PER_BLOCK)
 		return;
 
+	if (!sync && !available_free_memory(sbi, FREE_NIDS))
+		return;
+
 	/* readahead nat pages to be scanned */
 	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), FREE_NID_PAGES,
 							META_NAT, true);
@@ -1878,10 +1876,10 @@ void __build_free_nids(struct f2fs_sb_info *sbi)
 					nm_i->ra_nid_pages, META_NAT, false);
 }
 
-void build_free_nids(struct f2fs_sb_info *sbi)
+void build_free_nids(struct f2fs_sb_info *sbi, bool sync)
 {
 	mutex_lock(&NM_I(sbi)->build_lock);
-	__build_free_nids(sbi);
+	__build_free_nids(sbi, sync);
 	mutex_unlock(&NM_I(sbi)->build_lock);
 }
 
@@ -1920,7 +1918,7 @@ retry:
 	spin_unlock(&nm_i->free_nid_list_lock);
 
 	/* Let's scan nat pages and its caches to get free nids */
-	build_free_nids(sbi);
+	build_free_nids(sbi, true);
 	goto retry;
 }
 
@@ -2359,7 +2357,7 @@ int build_node_manager(struct f2fs_sb_info *sbi)
 	if (err)
 		return err;
 
-	build_free_nids(sbi);
+	build_free_nids(sbi, true);
 	return 0;
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fc886f0..7f62dd0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -380,7 +380,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 	if (!available_free_memory(sbi, FREE_NIDS))
 		try_to_free_nids(sbi, MAX_FREE_NIDS);
 	else
-		build_free_nids(sbi);
+		build_free_nids(sbi, false);
 
 	/* checkpoint is the only way to shrink partial cached entries */
 	if (!available_free_memory(sbi, NAT_ENTRIES) ||
-- 
2.10.1
