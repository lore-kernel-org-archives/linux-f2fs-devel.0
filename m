From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: split free nid list
Date: Wed, 12 Oct 2016 19:28:29 +0800
Message-ID: <20161012112829.86781-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1buHiZ-00011I-0k
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Oct 2016 11:29:03 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1buHiU-0003ni-U2
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Oct 2016 11:29:03 +0000
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

During free nid allocation, in order to do preallocation, we will tag free
nid entry as allocated one and still leave it in free nid list, for other
allocators who want to grab free nids, it needs to traverse the free nid
list for lookup. It becomes overhead in scenario of allocating free nid
intensively by multithreads.

This patch splits free nid list to two list: {free,alloc}_nid_list, to
keep free nids and preallocated free nids separately, after that, traverse
latency will be gone, besides split nid_cnt for separate statistic.

Additionally, introduce __insert_nid_to_list and __remove_nid_from_list for
cleanup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2: merge with other cleanup patches.
 fs/f2fs/debug.c    |  11 +++--
 fs/f2fs/f2fs.h     |  14 ++++--
 fs/f2fs/node.c     | 142 +++++++++++++++++++++++++++++++++--------------------
 fs/f2fs/node.h     |  11 +++--
 fs/f2fs/shrinker.c |   4 +-
 5 files changed, 114 insertions(+), 68 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index fb245bd..6af146c 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -74,7 +74,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->dirty_nats = NM_I(sbi)->dirty_nat_cnt;
 	si->sits = MAIN_SEGS(sbi);
 	si->dirty_sits = SIT_I(sbi)->dirty_sentries;
-	si->fnids = NM_I(sbi)->fcnt;
+	si->free_nids = NM_I(sbi)->nid_cnt[FREE_NID_LIST];
+	si->alloc_nids = NM_I(sbi)->nid_cnt[ALLOC_NID_LIST];
 	si->bg_gc = sbi->bg_gc;
 	si->util_free = (int)(free_user_blocks(sbi) >> sbi->log_blocks_per_seg)
 		* 100 / (int)(sbi->user_block_count >> sbi->log_blocks_per_seg)
@@ -194,7 +195,9 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 		si->cache_mem += sizeof(struct flush_cmd_control);
 
 	/* free nids */
-	si->cache_mem += NM_I(sbi)->fcnt * sizeof(struct free_nid);
+	si->cache_mem += (NM_I(sbi)->nid_cnt[FREE_NID_LIST] +
+				NM_I(sbi)->nid_cnt[ALLOC_NID_LIST]) *
+				sizeof(struct free_nid);
 	si->cache_mem += NM_I(sbi)->nat_cnt * sizeof(struct nat_entry);
 	si->cache_mem += NM_I(sbi)->dirty_nat_cnt *
 					sizeof(struct nat_entry_set);
@@ -324,8 +327,8 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->ndirty_imeta);
 		seq_printf(s, "  - NATs: %9d/%9d\n  - SITs: %9d/%9d\n",
 			   si->dirty_nats, si->nats, si->dirty_sits, si->sits);
-		seq_printf(s, "  - free_nids: %9d\n",
-			   si->fnids);
+		seq_printf(s, "  - free_nids: %9d, alloc_nids: %9d\n",
+			   si->free_nids, si->alloc_nids);
 		seq_puts(s, "\nDistribution of User Blocks:");
 		seq_puts(s, " [ valid | invalid | free ]\n");
 		seq_puts(s, "  [");
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d868175..b23e323 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -523,6 +523,12 @@ static inline void __try_update_largest_extent(struct inode *inode,
 	}
 }
 
+enum nid_list {
+	FREE_NID_LIST,
+	ALLOC_NID_LIST,
+	MAX_NID_LIST,
+};
+
 struct f2fs_nm_info {
 	block_t nat_blkaddr;		/* base disk address of NAT */
 	nid_t max_nid;			/* maximum possible node ids */
@@ -542,9 +548,9 @@ struct f2fs_nm_info {
 
 	/* free node ids management */
 	struct radix_tree_root free_nid_root;/* root of the free_nid cache */
-	struct list_head free_nid_list;	/* a list for free nids */
-	spinlock_t free_nid_list_lock;	/* protect free nid list */
-	unsigned int fcnt;		/* the number of free node id */
+	struct list_head nid_list[MAX_NID_LIST];/* lists for free nids */
+	unsigned int nid_cnt[MAX_NID_LIST];	/* the number of free node id */
+	spinlock_t nid_list_lock;	/* protect nid lists ops */
 	struct mutex build_lock;	/* lock for build free nids */
 
 	/* for checkpoint */
@@ -2204,7 +2210,7 @@ struct f2fs_stat_info {
 	s64 ndirty_node, ndirty_dent, ndirty_meta, ndirty_data, ndirty_imeta;
 	s64 inmem_pages;
 	unsigned int ndirty_dirs, ndirty_files, ndirty_all;
-	int nats, dirty_nats, sits, dirty_sits, fnids;
+	int nats, dirty_nats, sits, dirty_sits, free_nids, alloc_nids;
 	int total_count, utilization;
 	int bg_gc, wb_bios;
 	int inline_xattr, inline_inode, inline_dir, orphans;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 6f99907..bafd566 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -45,8 +45,8 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
 	 * give 25%, 25%, 50%, 50%, 50% memory for each components respectively
 	 */
 	if (type == FREE_NIDS) {
-		mem_size = (nm_i->fcnt * sizeof(struct free_nid)) >>
-							PAGE_SHIFT;
+		mem_size = (nm_i->nid_cnt[FREE_NID_LIST] *
+				sizeof(struct free_nid)) >> PAGE_SHIFT;
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 2);
 	} else if (type == NAT_ENTRIES) {
 		mem_size = (nm_i->nat_cnt * sizeof(struct nat_entry)) >>
@@ -1698,10 +1698,37 @@ static struct free_nid *__lookup_free_nid_list(struct f2fs_nm_info *nm_i,
 static void __del_from_free_nid_list(struct f2fs_nm_info *nm_i,
 						struct free_nid *i)
 {
-	list_del(&i->list);
 	radix_tree_delete(&nm_i->free_nid_root, i->nid);
 }
 
+static void __insert_nid_to_list(struct f2fs_sb_info *sbi,
+					struct free_nid *i, enum nid_list list)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+
+	if (list == FREE_NID_LIST)
+		f2fs_bug_on(sbi, i->state != NID_NEW);
+	else
+		f2fs_bug_on(sbi, i->state != NID_ALLOC);
+
+	nm_i->nid_cnt[list]++;
+	list_add_tail(&i->list, &nm_i->nid_list[list]);
+}
+
+static void __remove_nid_from_list(struct f2fs_sb_info *sbi,
+					struct free_nid *i, enum nid_list list)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+
+	if (list == FREE_NID_LIST)
+		f2fs_bug_on(sbi, i->state != NID_NEW);
+	else
+		f2fs_bug_on(sbi, i->state != NID_ALLOC);
+
+	nm_i->nid_cnt[list]--;
+	list_del(&i->list);
+}
+
 static int add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
@@ -1732,33 +1759,33 @@ static int add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 		return 0;
 	}
 
-	spin_lock(&nm_i->free_nid_list_lock);
+	spin_lock(&nm_i->nid_list_lock);
 	if (radix_tree_insert(&nm_i->free_nid_root, i->nid, i)) {
-		spin_unlock(&nm_i->free_nid_list_lock);
+		spin_unlock(&nm_i->nid_list_lock);
 		radix_tree_preload_end();
 		kmem_cache_free(free_nid_slab, i);
 		return 0;
 	}
-	list_add_tail(&i->list, &nm_i->free_nid_list);
-	nm_i->fcnt++;
-	spin_unlock(&nm_i->free_nid_list_lock);
+	__insert_nid_to_list(sbi, i, FREE_NID_LIST);
+	spin_unlock(&nm_i->nid_list_lock);
 	radix_tree_preload_end();
 	return 1;
 }
 
-static void remove_free_nid(struct f2fs_nm_info *nm_i, nid_t nid)
+static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
 {
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i;
 	bool need_free = false;
 
-	spin_lock(&nm_i->free_nid_list_lock);
+	spin_lock(&nm_i->nid_list_lock);
 	i = __lookup_free_nid_list(nm_i, nid);
 	if (i && i->state == NID_NEW) {
+		__remove_nid_from_list(sbi, i, FREE_NID_LIST);
 		__del_from_free_nid_list(nm_i, i);
-		nm_i->fcnt--;
 		need_free = true;
 	}
-	spin_unlock(&nm_i->free_nid_list_lock);
+	spin_unlock(&nm_i->nid_list_lock);
 
 	if (need_free)
 		kmem_cache_free(free_nid_slab, i);
@@ -1797,7 +1824,7 @@ void __build_free_nids(struct f2fs_sb_info *sbi)
 	nid_t nid = nm_i->next_scan_nid;
 
 	/* Enough entries */
-	if (nm_i->fcnt >= NAT_ENTRY_PER_BLOCK)
+	if (nm_i->nid_cnt[FREE_NID_LIST] >= NAT_ENTRY_PER_BLOCK)
 		return;
 
 	/* readahead nat pages to be scanned */
@@ -1833,7 +1860,7 @@ void __build_free_nids(struct f2fs_sb_info *sbi)
 		if (addr == NULL_ADDR)
 			add_free_nid(sbi, nid, true);
 		else
-			remove_free_nid(nm_i, nid);
+			remove_free_nid(sbi, nid);
 	}
 	up_read(&curseg->journal_rwsem);
 	up_read(&nm_i->nat_tree_lock);
@@ -1866,23 +1893,22 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 	if (unlikely(sbi->total_valid_node_count + 1 > nm_i->available_nids))
 		return false;
 
-	spin_lock(&nm_i->free_nid_list_lock);
+	spin_lock(&nm_i->nid_list_lock);
 
 	/* We should not use stale free nids created by build_free_nids */
-	if (nm_i->fcnt && !on_build_free_nids(nm_i)) {
-		f2fs_bug_on(sbi, list_empty(&nm_i->free_nid_list));
-		list_for_each_entry(i, &nm_i->free_nid_list, list)
-			if (i->state == NID_NEW)
-				break;
-
-		f2fs_bug_on(sbi, i->state != NID_NEW);
+	if (nm_i->nid_cnt[FREE_NID_LIST] && !on_build_free_nids(nm_i)) {
+		f2fs_bug_on(sbi, list_empty(&nm_i->nid_list[FREE_NID_LIST]));
+		i = list_first_entry(&nm_i->nid_list[FREE_NID_LIST],
+					struct free_nid, list);
 		*nid = i->nid;
+
+		__remove_nid_from_list(sbi, i, FREE_NID_LIST);
 		i->state = NID_ALLOC;
-		nm_i->fcnt--;
-		spin_unlock(&nm_i->free_nid_list_lock);
+		__insert_nid_to_list(sbi, i, ALLOC_NID_LIST);
+		spin_unlock(&nm_i->nid_list_lock);
 		return true;
 	}
-	spin_unlock(&nm_i->free_nid_list_lock);
+	spin_unlock(&nm_i->nid_list_lock);
 
 	/* Let's scan nat pages and its caches to get free nids */
 	build_free_nids(sbi);
@@ -1897,11 +1923,12 @@ void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i;
 
-	spin_lock(&nm_i->free_nid_list_lock);
+	spin_lock(&nm_i->nid_list_lock);
 	i = __lookup_free_nid_list(nm_i, nid);
-	f2fs_bug_on(sbi, !i || i->state != NID_ALLOC);
+	f2fs_bug_on(sbi, !i);
+	__remove_nid_from_list(sbi, i, ALLOC_NID_LIST);
 	__del_from_free_nid_list(nm_i, i);
-	spin_unlock(&nm_i->free_nid_list_lock);
+	spin_unlock(&nm_i->nid_list_lock);
 
 	kmem_cache_free(free_nid_slab, i);
 }
@@ -1918,17 +1945,20 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 	if (!nid)
 		return;
 
-	spin_lock(&nm_i->free_nid_list_lock);
+	spin_lock(&nm_i->nid_list_lock);
 	i = __lookup_free_nid_list(nm_i, nid);
-	f2fs_bug_on(sbi, !i || i->state != NID_ALLOC);
+	f2fs_bug_on(sbi, !i);
+
+	__remove_nid_from_list(sbi, i, ALLOC_NID_LIST);
+
 	if (!available_free_memory(sbi, FREE_NIDS)) {
 		__del_from_free_nid_list(nm_i, i);
 		need_free = true;
 	} else {
 		i->state = NID_NEW;
-		nm_i->fcnt++;
+		__insert_nid_to_list(sbi, i, FREE_NID_LIST);
 	}
-	spin_unlock(&nm_i->free_nid_list_lock);
+	spin_unlock(&nm_i->nid_list_lock);
 
 	if (need_free)
 		kmem_cache_free(free_nid_slab, i);
@@ -1940,24 +1970,26 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 	struct free_nid *i, *next;
 	int nr = nr_shrink;
 
-	if (nm_i->fcnt <= MAX_FREE_NIDS)
+	if (nm_i->nid_cnt[FREE_NID_LIST] <= MAX_FREE_NIDS)
 		return 0;
 
 	if (!mutex_trylock(&nm_i->build_lock))
 		return 0;
 
-	spin_lock(&nm_i->free_nid_list_lock);
-	list_for_each_entry_safe(i, next, &nm_i->free_nid_list, list) {
-		if (nr_shrink <= 0 || nm_i->fcnt <= MAX_FREE_NIDS)
+	spin_lock(&nm_i->nid_list_lock);
+	list_for_each_entry_safe(i, next, &nm_i->nid_list[FREE_NID_LIST],
+									list) {
+		if (nr_shrink <= 0 ||
+				nm_i->nid_cnt[FREE_NID_LIST] <= MAX_FREE_NIDS)
 			break;
-		if (i->state == NID_ALLOC)
-			continue;
+
+		__remove_nid_from_list(sbi, i, FREE_NID_LIST);
 		__del_from_free_nid_list(nm_i, i);
+
 		kmem_cache_free(free_nid_slab, i);
-		nm_i->fcnt--;
 		nr_shrink--;
 	}
-	spin_unlock(&nm_i->free_nid_list_lock);
+	spin_unlock(&nm_i->nid_list_lock);
 	mutex_unlock(&nm_i->build_lock);
 
 	return nr - nr_shrink;
@@ -2013,7 +2045,7 @@ void recover_xattr_data(struct inode *inode, struct page *page, block_t blkaddr)
 	if (unlikely(!inc_valid_node_count(sbi, inode)))
 		f2fs_bug_on(sbi, 1);
 
-	remove_free_nid(NM_I(sbi), new_xnid);
+	remove_free_nid(sbi, new_xnid);
 	get_node_info(sbi, new_xnid, &ni);
 	ni.ino = inode->i_ino;
 	set_node_addr(sbi, &ni, NEW_ADDR, false);
@@ -2043,7 +2075,7 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	}
 
 	/* Should not use this inode from free nid list */
-	remove_free_nid(NM_I(sbi), ino);
+	remove_free_nid(sbi, ino);
 
 	if (!PageUptodate(ipage))
 		SetPageUptodate(ipage);
@@ -2277,20 +2309,22 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 
 	/* not used nids: 0, node, meta, (and root counted as valid node) */
 	nm_i->available_nids = nm_i->max_nid - F2FS_RESERVED_NODE_NUM;
-	nm_i->fcnt = 0;
+	nm_i->nid_cnt[FREE_NID_LIST] = 0;
+	nm_i->nid_cnt[ALLOC_NID_LIST] = 0;
 	nm_i->nat_cnt = 0;
 	nm_i->ram_thresh = DEF_RAM_THRESHOLD;
 	nm_i->ra_nid_pages = DEF_RA_NID_PAGES;
 	nm_i->dirty_nats_ratio = DEF_DIRTY_NAT_RATIO_THRESHOLD;
 
 	INIT_RADIX_TREE(&nm_i->free_nid_root, GFP_ATOMIC);
-	INIT_LIST_HEAD(&nm_i->free_nid_list);
+	INIT_LIST_HEAD(&nm_i->nid_list[FREE_NID_LIST]);
+	INIT_LIST_HEAD(&nm_i->nid_list[ALLOC_NID_LIST]);
 	INIT_RADIX_TREE(&nm_i->nat_root, GFP_NOIO);
 	INIT_RADIX_TREE(&nm_i->nat_set_root, GFP_NOIO);
 	INIT_LIST_HEAD(&nm_i->nat_entries);
 
 	mutex_init(&nm_i->build_lock);
-	spin_lock_init(&nm_i->free_nid_list_lock);
+	spin_lock_init(&nm_i->nid_list_lock);
 	init_rwsem(&nm_i->nat_tree_lock);
 
 	nm_i->next_scan_nid = le32_to_cpu(sbi->ckpt->next_free_nid);
@@ -2335,17 +2369,19 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
 		return;
 
 	/* destroy free nid list */
-	spin_lock(&nm_i->free_nid_list_lock);
-	list_for_each_entry_safe(i, next_i, &nm_i->free_nid_list, list) {
-		f2fs_bug_on(sbi, i->state == NID_ALLOC);
+	spin_lock(&nm_i->nid_list_lock);
+	list_for_each_entry_safe(i, next_i, &nm_i->nid_list[FREE_NID_LIST],
+									list) {
+		__remove_nid_from_list(sbi, i, FREE_NID_LIST);
 		__del_from_free_nid_list(nm_i, i);
-		nm_i->fcnt--;
-		spin_unlock(&nm_i->free_nid_list_lock);
+		spin_unlock(&nm_i->nid_list_lock);
 		kmem_cache_free(free_nid_slab, i);
-		spin_lock(&nm_i->free_nid_list_lock);
+		spin_lock(&nm_i->nid_list_lock);
 	}
-	f2fs_bug_on(sbi, nm_i->fcnt);
-	spin_unlock(&nm_i->free_nid_list_lock);
+	f2fs_bug_on(sbi, nm_i->nid_cnt[FREE_NID_LIST]);
+	f2fs_bug_on(sbi, nm_i->nid_cnt[ALLOC_NID_LIST]);
+	f2fs_bug_on(sbi, !list_empty(&nm_i->nid_list[ALLOC_NID_LIST]));
+	spin_unlock(&nm_i->nid_list_lock);
 
 	/* destroy nat cache */
 	down_write(&nm_i->nat_tree_lock);
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index cfdcf98..e7997e2 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -169,14 +169,15 @@ static inline void next_free_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *fnid;
 
-	spin_lock(&nm_i->free_nid_list_lock);
-	if (nm_i->fcnt <= 0) {
-		spin_unlock(&nm_i->free_nid_list_lock);
+	spin_lock(&nm_i->nid_list_lock);
+	if (nm_i->nid_cnt[FREE_NID_LIST] <= 0) {
+		spin_unlock(&nm_i->nid_list_lock);
 		return;
 	}
-	fnid = list_entry(nm_i->free_nid_list.next, struct free_nid, list);
+	fnid = list_entry(nm_i->nid_list[FREE_NID_LIST].next,
+						struct free_nid, list);
 	*nid = fnid->nid;
-	spin_unlock(&nm_i->free_nid_list_lock);
+	spin_unlock(&nm_i->nid_list_lock);
 }
 
 /*
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index 46c9154..ec539f4 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -26,8 +26,8 @@ static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
 
 static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
 {
-	if (NM_I(sbi)->fcnt > MAX_FREE_NIDS)
-		return NM_I(sbi)->fcnt - MAX_FREE_NIDS;
+	if (NM_I(sbi)->nid_cnt[FREE_NID_LIST] > MAX_FREE_NIDS)
+		return NM_I(sbi)->nid_cnt[FREE_NID_LIST] - MAX_FREE_NIDS;
 	return 0;
 }
 
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
