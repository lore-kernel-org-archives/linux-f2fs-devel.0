From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/7] f2fs: split free nid list
Date: Tue, 11 Oct 2016 22:31:30 +0800
Message-ID: <20161011143136.2107-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

During free nid allocation, in order to do preallocation, we will tag free
nid entry as allocated one and still leave it in free nid list, for other
allocators who want to grab free nids, it needs to traverse the free nid
list for lookup. It becomes overhead in scenario of allocating free nid
intensively by multithreads.

This patch splits free nid list to two list: {free,alloc}_nid_list, to
keep free nids and preallocated free nids separately, after that, traverse
latency will be gone.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/debug.c    |  5 +++--
 fs/f2fs/f2fs.h     |  4 +++-
 fs/f2fs/node.c     | 56 ++++++++++++++++++++++++++++++++----------------------
 fs/f2fs/node.h     |  2 +-
 fs/f2fs/shrinker.c |  4 ++--
 5 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index fb245bd..9789138 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -74,7 +74,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->dirty_nats = NM_I(sbi)->dirty_nat_cnt;
 	si->sits = MAIN_SEGS(sbi);
 	si->dirty_sits = SIT_I(sbi)->dirty_sentries;
-	si->fnids = NM_I(sbi)->fcnt;
+	si->fnids = NM_I(sbi)->free_nid_cnt;
 	si->bg_gc = sbi->bg_gc;
 	si->util_free = (int)(free_user_blocks(sbi) >> sbi->log_blocks_per_seg)
 		* 100 / (int)(sbi->user_block_count >> sbi->log_blocks_per_seg)
@@ -194,7 +194,8 @@ get_cache:
 		si->cache_mem += sizeof(struct flush_cmd_control);
 
 	/* free nids */
-	si->cache_mem += NM_I(sbi)->fcnt * sizeof(struct free_nid);
+	si->cache_mem += (NM_I(sbi)->free_nid_cnt + NM_I(sbi)->alloc_nid_cnt) *
+							sizeof(struct free_nid);
 	si->cache_mem += NM_I(sbi)->nat_cnt * sizeof(struct nat_entry);
 	si->cache_mem += NM_I(sbi)->dirty_nat_cnt *
 					sizeof(struct nat_entry_set);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d868175..d6dff15 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -543,8 +543,10 @@ struct f2fs_nm_info {
 	/* free node ids management */
 	struct radix_tree_root free_nid_root;/* root of the free_nid cache */
 	struct list_head free_nid_list;	/* a list for free nids */
+	struct list_head alloc_nid_list;/* a list for allocating nids */
 	spinlock_t free_nid_list_lock;	/* protect free nid list */
-	unsigned int fcnt;		/* the number of free node id */
+	unsigned int free_nid_cnt;	/* the number of free node id */
+	unsigned int alloc_nid_cnt;	/* the number of allocating node id */
 	struct mutex build_lock;	/* lock for build free nids */
 
 	/* for checkpoint */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8831035..a1725a9 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -45,7 +45,7 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
 	 * give 25%, 25%, 50%, 50%, 50% memory for each components respectively
 	 */
 	if (type == FREE_NIDS) {
-		mem_size = (nm_i->fcnt * sizeof(struct free_nid)) >>
+		mem_size = (nm_i->free_nid_cnt * sizeof(struct free_nid)) >>
 							PAGE_SHIFT;
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 2);
 	} else if (type == NAT_ENTRIES) {
@@ -1740,14 +1740,15 @@ static int add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 		return 0;
 	}
 	list_add_tail(&i->list, &nm_i->free_nid_list);
-	nm_i->fcnt++;
+	nm_i->free_nid_cnt++;
 	spin_unlock(&nm_i->free_nid_list_lock);
 	radix_tree_preload_end();
 	return 1;
 }
 
-static void remove_free_nid(struct f2fs_nm_info *nm_i, nid_t nid)
+static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
 {
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i;
 	bool need_free = false;
 
@@ -1755,7 +1756,7 @@ static void remove_free_nid(struct f2fs_nm_info *nm_i, nid_t nid)
 	i = __lookup_free_nid_list(nm_i, nid);
 	if (i && i->state == NID_NEW) {
 		__del_from_free_nid_list(nm_i, i);
-		nm_i->fcnt--;
+		nm_i->free_nid_cnt--;
 		need_free = true;
 	}
 	spin_unlock(&nm_i->free_nid_list_lock);
@@ -1797,7 +1798,7 @@ void build_free_nids(struct f2fs_sb_info *sbi)
 	nid_t nid = nm_i->next_scan_nid;
 
 	/* Enough entries */
-	if (nm_i->fcnt >= NAT_ENTRY_PER_BLOCK)
+	if (nm_i->free_nid_cnt >= NAT_ENTRY_PER_BLOCK)
 		return;
 
 	/* readahead nat pages to be scanned */
@@ -1833,7 +1834,7 @@ void build_free_nids(struct f2fs_sb_info *sbi)
 		if (addr == NULL_ADDR)
 			add_free_nid(sbi, nid, true);
 		else
-			remove_free_nid(nm_i, nid);
+			remove_free_nid(sbi, nid);
 	}
 	up_read(&curseg->journal_rwsem);
 	up_read(&nm_i->nat_tree_lock);
@@ -1862,16 +1863,16 @@ retry:
 	spin_lock(&nm_i->free_nid_list_lock);
 
 	/* We should not use stale free nids created by build_free_nids */
-	if (nm_i->fcnt && !on_build_free_nids(nm_i)) {
+	if (nm_i->free_nid_cnt && !on_build_free_nids(nm_i)) {
 		f2fs_bug_on(sbi, list_empty(&nm_i->free_nid_list));
-		list_for_each_entry(i, &nm_i->free_nid_list, list)
-			if (i->state == NID_NEW)
-				break;
-
+		i = list_first_entry(&nm_i->free_nid_list,
+					struct free_nid, list);
 		f2fs_bug_on(sbi, i->state != NID_NEW);
 		*nid = i->nid;
 		i->state = NID_ALLOC;
-		nm_i->fcnt--;
+		nm_i->free_nid_cnt--;
+		nm_i->alloc_nid_cnt++;
+		list_move_tail(&i->list, &nm_i->alloc_nid_list);
 		spin_unlock(&nm_i->free_nid_list_lock);
 		return true;
 	}
@@ -1896,6 +1897,7 @@ void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid)
 	i = __lookup_free_nid_list(nm_i, nid);
 	f2fs_bug_on(sbi, !i || i->state != NID_ALLOC);
 	__del_from_free_nid_list(nm_i, i);
+	nm_i->alloc_nid_cnt--;
 	spin_unlock(&nm_i->free_nid_list_lock);
 
 	kmem_cache_free(free_nid_slab, i);
@@ -1917,11 +1919,14 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 	i = __lookup_free_nid_list(nm_i, nid);
 	f2fs_bug_on(sbi, !i || i->state != NID_ALLOC);
 	if (!available_free_memory(sbi, FREE_NIDS)) {
+		nm_i->alloc_nid_cnt--;
 		__del_from_free_nid_list(nm_i, i);
 		need_free = true;
 	} else {
 		i->state = NID_NEW;
-		nm_i->fcnt++;
+		nm_i->free_nid_cnt++;
+		nm_i->alloc_nid_cnt--;
+		list_move_tail(&i->list, &nm_i->free_nid_list);
 	}
 	spin_unlock(&nm_i->free_nid_list_lock);
 
@@ -1935,7 +1940,7 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 	struct free_nid *i, *next;
 	int nr = nr_shrink;
 
-	if (nm_i->fcnt <= MAX_FREE_NIDS)
+	if (nm_i->free_nid_cnt <= MAX_FREE_NIDS)
 		return 0;
 
 	if (!mutex_trylock(&nm_i->build_lock))
@@ -1943,13 +1948,14 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 
 	spin_lock(&nm_i->free_nid_list_lock);
 	list_for_each_entry_safe(i, next, &nm_i->free_nid_list, list) {
-		if (nr_shrink <= 0 || nm_i->fcnt <= MAX_FREE_NIDS)
+		if (nr_shrink <= 0 || nm_i->free_nid_cnt <= MAX_FREE_NIDS)
 			break;
-		if (i->state == NID_ALLOC)
-			continue;
+
+		f2fs_bug_on(sbi, i->state == NID_ALLOC);
+
 		__del_from_free_nid_list(nm_i, i);
 		kmem_cache_free(free_nid_slab, i);
-		nm_i->fcnt--;
+		nm_i->free_nid_cnt--;
 		nr_shrink--;
 	}
 	spin_unlock(&nm_i->free_nid_list_lock);
@@ -2008,7 +2014,7 @@ recover_xnid:
 	if (unlikely(!inc_valid_node_count(sbi, inode)))
 		f2fs_bug_on(sbi, 1);
 
-	remove_free_nid(NM_I(sbi), new_xnid);
+	remove_free_nid(sbi, new_xnid);
 	get_node_info(sbi, new_xnid, &ni);
 	ni.ino = inode->i_ino;
 	set_node_addr(sbi, &ni, NEW_ADDR, false);
@@ -2038,7 +2044,7 @@ retry:
 	}
 
 	/* Should not use this inode from free nid list */
-	remove_free_nid(NM_I(sbi), ino);
+	remove_free_nid(sbi, ino);
 
 	if (!PageUptodate(ipage))
 		SetPageUptodate(ipage);
@@ -2272,7 +2278,8 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 
 	/* not used nids: 0, node, meta, (and root counted as valid node) */
 	nm_i->available_nids = nm_i->max_nid - F2FS_RESERVED_NODE_NUM;
-	nm_i->fcnt = 0;
+	nm_i->free_nid_cnt = 0;
+	nm_i->alloc_nid_cnt = 0;
 	nm_i->nat_cnt = 0;
 	nm_i->ram_thresh = DEF_RAM_THRESHOLD;
 	nm_i->ra_nid_pages = DEF_RA_NID_PAGES;
@@ -2280,6 +2287,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 
 	INIT_RADIX_TREE(&nm_i->free_nid_root, GFP_ATOMIC);
 	INIT_LIST_HEAD(&nm_i->free_nid_list);
+	INIT_LIST_HEAD(&nm_i->alloc_nid_list);
 	INIT_RADIX_TREE(&nm_i->nat_root, GFP_NOIO);
 	INIT_RADIX_TREE(&nm_i->nat_set_root, GFP_NOIO);
 	INIT_LIST_HEAD(&nm_i->nat_entries);
@@ -2334,12 +2342,14 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
 	list_for_each_entry_safe(i, next_i, &nm_i->free_nid_list, list) {
 		f2fs_bug_on(sbi, i->state == NID_ALLOC);
 		__del_from_free_nid_list(nm_i, i);
-		nm_i->fcnt--;
+		nm_i->free_nid_cnt--;
 		spin_unlock(&nm_i->free_nid_list_lock);
 		kmem_cache_free(free_nid_slab, i);
 		spin_lock(&nm_i->free_nid_list_lock);
 	}
-	f2fs_bug_on(sbi, nm_i->fcnt);
+	f2fs_bug_on(sbi, nm_i->free_nid_cnt);
+	f2fs_bug_on(sbi, nm_i->alloc_nid_cnt);
+	f2fs_bug_on(sbi, !list_empty(&nm_i->alloc_nid_list));
 	spin_unlock(&nm_i->free_nid_list_lock);
 
 	/* destroy nat cache */
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 868bec6..66928d7 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -170,7 +170,7 @@ static inline void next_free_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 	struct free_nid *fnid;
 
 	spin_lock(&nm_i->free_nid_list_lock);
-	if (nm_i->fcnt <= 0) {
+	if (nm_i->free_nid_cnt <= 0) {
 		spin_unlock(&nm_i->free_nid_list_lock);
 		return;
 	}
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index 46c9154..8b0a112 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -26,8 +26,8 @@ static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
 
 static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
 {
-	if (NM_I(sbi)->fcnt > MAX_FREE_NIDS)
-		return NM_I(sbi)->fcnt - MAX_FREE_NIDS;
+	if (NM_I(sbi)->free_nid_cnt > MAX_FREE_NIDS)
+		return NM_I(sbi)->free_nid_cnt - MAX_FREE_NIDS;
 	return 0;
 }
 
-- 
2.10.1
