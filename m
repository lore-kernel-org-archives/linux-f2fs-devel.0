From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/5] f2fs: obsolete ALLOC_NID_LIST list
Date: Fri, 29 Sep 2017 13:59:35 +0800
Message-ID: <20170929055939.39937-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

As Fan Li reported, there is no user traversing nid_list[ALLOC_NID_LIST]
which is used for tracking preallocated nids. Let's drop it, and only
track preallocated nids in free_nid_root radix-tree.

Reported-by: Fan Li <fanofcode.li@samsung.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/debug.c    |  8 ++---
 fs/f2fs/f2fs.h     | 15 +++++----
 fs/f2fs/node.c     | 97 ++++++++++++++++++++++++++----------------------------
 fs/f2fs/node.h     | 15 ++-------
 fs/f2fs/shrinker.c |  2 +-
 5 files changed, 64 insertions(+), 73 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 00c1d4a9f356..14095fbb4039 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -98,9 +98,9 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->dirty_nats = NM_I(sbi)->dirty_nat_cnt;
 	si->sits = MAIN_SEGS(sbi);
 	si->dirty_sits = SIT_I(sbi)->dirty_sentries;
-	si->free_nids = NM_I(sbi)->nid_cnt[FREE_NID_LIST];
+	si->free_nids = NM_I(sbi)->nid_cnt[FREE_NID];
 	si->avail_nids = NM_I(sbi)->available_nids;
-	si->alloc_nids = NM_I(sbi)->nid_cnt[ALLOC_NID_LIST];
+	si->alloc_nids = NM_I(sbi)->nid_cnt[PREALLOC_NID];
 	si->bg_gc = sbi->bg_gc;
 	si->util_free = (int)(free_user_blocks(sbi) >> sbi->log_blocks_per_seg)
 		* 100 / (int)(sbi->user_block_count >> sbi->log_blocks_per_seg)
@@ -233,8 +233,8 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	}
 
 	/* free nids */
-	si->cache_mem += (NM_I(sbi)->nid_cnt[FREE_NID_LIST] +
-				NM_I(sbi)->nid_cnt[ALLOC_NID_LIST]) *
+	si->cache_mem += (NM_I(sbi)->nid_cnt[FREE_NID] +
+				NM_I(sbi)->nid_cnt[PREALLOC_NID]) *
 				sizeof(struct free_nid);
 	si->cache_mem += NM_I(sbi)->nat_cnt * sizeof(struct nat_entry);
 	si->cache_mem += NM_I(sbi)->dirty_nat_cnt *
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c95069435b47..3440551289d2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -688,10 +688,13 @@ static inline void __try_update_largest_extent(struct inode *inode,
 	}
 }
 
-enum nid_list {
-	FREE_NID_LIST,
-	ALLOC_NID_LIST,
-	MAX_NID_LIST,
+/*
+ * For free nid management
+ */
+enum nid_state {
+	FREE_NID,		/* newly added to free nid list */
+	PREALLOC_NID,		/* it is preallocated */
+	MAX_NID_STATE,
 };
 
 struct f2fs_nm_info {
@@ -714,8 +717,8 @@ struct f2fs_nm_info {
 
 	/* free node ids management */
 	struct radix_tree_root free_nid_root;/* root of the free_nid cache */
-	struct list_head nid_list[MAX_NID_LIST];/* lists for free nids */
-	unsigned int nid_cnt[MAX_NID_LIST];	/* the number of free node id */
+	struct list_head free_nid_list;		/* list for free nids excluding preallocated nids */
+	unsigned int nid_cnt[MAX_NID_STATE];	/* the number of free node id */
 	spinlock_t nid_list_lock;	/* protect nid lists ops */
 	struct mutex build_lock;	/* lock for build free nids */
 	unsigned char (*free_nid_bitmap)[NAT_ENTRY_BITMAP_SIZE];
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 275ad3f35579..d087b45b3f72 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -46,7 +46,7 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
 	 * give 25%, 25%, 50%, 50%, 50% memory for each components respectively
 	 */
 	if (type == FREE_NIDS) {
-		mem_size = (nm_i->nid_cnt[FREE_NID_LIST] *
+		mem_size = (nm_i->nid_cnt[FREE_NID] *
 				sizeof(struct free_nid)) >> PAGE_SHIFT;
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 2);
 	} else if (type == NAT_ENTRIES) {
@@ -1757,8 +1757,8 @@ static struct free_nid *__lookup_free_nid_list(struct f2fs_nm_info *nm_i,
 	return radix_tree_lookup(&nm_i->free_nid_root, n);
 }
 
-static int __insert_nid_to_list(struct f2fs_sb_info *sbi,
-			struct free_nid *i, enum nid_list list, bool new)
+static int __insert_free_nid(struct f2fs_sb_info *sbi,
+			struct free_nid *i, enum nid_state state, bool new)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 
@@ -1768,22 +1768,22 @@ static int __insert_nid_to_list(struct f2fs_sb_info *sbi,
 			return err;
 	}
 
-	f2fs_bug_on(sbi, list == FREE_NID_LIST ? i->state != NID_NEW :
-						i->state != NID_ALLOC);
-	nm_i->nid_cnt[list]++;
-	list_add_tail(&i->list, &nm_i->nid_list[list]);
+	f2fs_bug_on(sbi, state != i->state);
+	nm_i->nid_cnt[state]++;
+	if (state == FREE_NID)
+		list_add_tail(&i->list, &nm_i->free_nid_list);
 	return 0;
 }
 
-static void __remove_nid_from_list(struct f2fs_sb_info *sbi,
-			struct free_nid *i, enum nid_list list, bool reuse)
+static void __remove_free_nid(struct f2fs_sb_info *sbi,
+			struct free_nid *i, enum nid_state state, bool reuse)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 
-	f2fs_bug_on(sbi, list == FREE_NID_LIST ? i->state != NID_NEW :
-						i->state != NID_ALLOC);
-	nm_i->nid_cnt[list]--;
-	list_del(&i->list);
+	f2fs_bug_on(sbi, state != i->state);
+	nm_i->nid_cnt[state]--;
+	if (state == FREE_NID)
+		list_del(&i->list);
 	if (!reuse)
 		radix_tree_delete(&nm_i->free_nid_root, i->nid);
 }
@@ -1803,7 +1803,7 @@ static bool add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 
 	i = f2fs_kmem_cache_alloc(free_nid_slab, GFP_NOFS);
 	i->nid = nid;
-	i->state = NID_NEW;
+	i->state = FREE_NID;
 
 	if (radix_tree_preload(GFP_NOFS))
 		goto err;
@@ -1816,7 +1816,7 @@ static bool add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 		 *  - f2fs_create
 		 *   - f2fs_new_inode
 		 *    - alloc_nid
-		 *     - __insert_nid_to_list(ALLOC_NID_LIST)
+		 *     - __insert_nid_to_list(PREALLOC_NID)
 		 *                     - f2fs_balance_fs_bg
 		 *                      - build_free_nids
 		 *                       - __build_free_nids
@@ -1829,8 +1829,8 @@ static bool add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 		 *     - new_node_page
 		 *      - set_node_addr
 		 *  - alloc_nid_done
-		 *   - __remove_nid_from_list(ALLOC_NID_LIST)
-		 *                         - __insert_nid_to_list(FREE_NID_LIST)
+		 *   - __remove_nid_from_list(PREALLOC_NID)
+		 *                         - __insert_nid_to_list(FREE_NID)
 		 */
 		ne = __lookup_nat_cache(nm_i, nid);
 		if (ne && (!get_nat_flag(ne, IS_CHECKPOINTED) ||
@@ -1839,13 +1839,13 @@ static bool add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 
 		e = __lookup_free_nid_list(nm_i, nid);
 		if (e) {
-			if (e->state == NID_NEW)
+			if (e->state == FREE_NID)
 				ret = true;
 			goto err_out;
 		}
 	}
 	ret = true;
-	err = __insert_nid_to_list(sbi, i, FREE_NID_LIST, true);
+	err = __insert_free_nid(sbi, i, FREE_NID, true);
 err_out:
 	spin_unlock(&nm_i->nid_list_lock);
 	radix_tree_preload_end();
@@ -1863,8 +1863,8 @@ static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
 
 	spin_lock(&nm_i->nid_list_lock);
 	i = __lookup_free_nid_list(nm_i, nid);
-	if (i && i->state == NID_NEW) {
-		__remove_nid_from_list(sbi, i, FREE_NID_LIST, false);
+	if (i && i->state == FREE_NID) {
+		__remove_free_nid(sbi, i, FREE_NID, false);
 		need_free = true;
 	}
 	spin_unlock(&nm_i->nid_list_lock);
@@ -1949,7 +1949,7 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
 			nid = i * NAT_ENTRY_PER_BLOCK + idx;
 			add_free_nid(sbi, nid, true);
 
-			if (nm_i->nid_cnt[FREE_NID_LIST] >= MAX_FREE_NIDS)
+			if (nm_i->nid_cnt[FREE_NID] >= MAX_FREE_NIDS)
 				goto out;
 		}
 	}
@@ -1982,7 +1982,7 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 		nid = 0;
 
 	/* Enough entries */
-	if (nm_i->nid_cnt[FREE_NID_LIST] >= NAT_ENTRY_PER_BLOCK)
+	if (nm_i->nid_cnt[FREE_NID] >= NAT_ENTRY_PER_BLOCK)
 		return;
 
 	if (!sync && !available_free_memory(sbi, FREE_NIDS))
@@ -1992,7 +1992,7 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 		/* try to find free nids in free_nid_bitmap */
 		scan_free_nid_bits(sbi);
 
-		if (nm_i->nid_cnt[FREE_NID_LIST])
+		if (nm_i->nid_cnt[FREE_NID])
 			return;
 	}
 
@@ -2069,15 +2069,15 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 	}
 
 	/* We should not use stale free nids created by build_free_nids */
-	if (nm_i->nid_cnt[FREE_NID_LIST] && !on_build_free_nids(nm_i)) {
-		f2fs_bug_on(sbi, list_empty(&nm_i->nid_list[FREE_NID_LIST]));
-		i = list_first_entry(&nm_i->nid_list[FREE_NID_LIST],
+	if (nm_i->nid_cnt[FREE_NID] && !on_build_free_nids(nm_i)) {
+		f2fs_bug_on(sbi, list_empty(&nm_i->free_nid_list));
+		i = list_first_entry(&nm_i->free_nid_list,
 					struct free_nid, list);
 		*nid = i->nid;
 
-		__remove_nid_from_list(sbi, i, FREE_NID_LIST, true);
-		i->state = NID_ALLOC;
-		__insert_nid_to_list(sbi, i, ALLOC_NID_LIST, false);
+		__remove_free_nid(sbi, i, FREE_NID, true);
+		i->state = PREALLOC_NID;
+		__insert_free_nid(sbi, i, PREALLOC_NID, false);
 		nm_i->available_nids--;
 
 		update_free_nid_bitmap(sbi, *nid, false, false);
@@ -2103,7 +2103,7 @@ void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid)
 	spin_lock(&nm_i->nid_list_lock);
 	i = __lookup_free_nid_list(nm_i, nid);
 	f2fs_bug_on(sbi, !i);
-	__remove_nid_from_list(sbi, i, ALLOC_NID_LIST, false);
+	__remove_free_nid(sbi, i, PREALLOC_NID, false);
 	spin_unlock(&nm_i->nid_list_lock);
 
 	kmem_cache_free(free_nid_slab, i);
@@ -2126,12 +2126,12 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 	f2fs_bug_on(sbi, !i);
 
 	if (!available_free_memory(sbi, FREE_NIDS)) {
-		__remove_nid_from_list(sbi, i, ALLOC_NID_LIST, false);
+		__remove_free_nid(sbi, i, PREALLOC_NID, false);
 		need_free = true;
 	} else {
-		__remove_nid_from_list(sbi, i, ALLOC_NID_LIST, true);
-		i->state = NID_NEW;
-		__insert_nid_to_list(sbi, i, FREE_NID_LIST, false);
+		__remove_free_nid(sbi, i, PREALLOC_NID, true);
+		i->state = FREE_NID;
+		__insert_free_nid(sbi, i, FREE_NID, false);
 	}
 
 	nm_i->available_nids++;
@@ -2150,20 +2150,19 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 	struct free_nid *i, *next;
 	int nr = nr_shrink;
 
-	if (nm_i->nid_cnt[FREE_NID_LIST] <= MAX_FREE_NIDS)
+	if (nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
 		return 0;
 
 	if (!mutex_trylock(&nm_i->build_lock))
 		return 0;
 
 	spin_lock(&nm_i->nid_list_lock);
-	list_for_each_entry_safe(i, next, &nm_i->nid_list[FREE_NID_LIST],
-									list) {
+	list_for_each_entry_safe(i, next, &nm_i->free_nid_list, list) {
 		if (nr_shrink <= 0 ||
-				nm_i->nid_cnt[FREE_NID_LIST] <= MAX_FREE_NIDS)
+				nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
 			break;
 
-		__remove_nid_from_list(sbi, i, FREE_NID_LIST, false);
+		__remove_free_nid(sbi, i, FREE_NID, false);
 		kmem_cache_free(free_nid_slab, i);
 		nr_shrink--;
 	}
@@ -2641,16 +2640,15 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	/* not used nids: 0, node, meta, (and root counted as valid node) */
 	nm_i->available_nids = nm_i->max_nid - sbi->total_valid_node_count -
 							F2FS_RESERVED_NODE_NUM;
-	nm_i->nid_cnt[FREE_NID_LIST] = 0;
-	nm_i->nid_cnt[ALLOC_NID_LIST] = 0;
+	nm_i->nid_cnt[FREE_NID] = 0;
+	nm_i->nid_cnt[PREALLOC_NID] = 0;
 	nm_i->nat_cnt = 0;
 	nm_i->ram_thresh = DEF_RAM_THRESHOLD;
 	nm_i->ra_nid_pages = DEF_RA_NID_PAGES;
 	nm_i->dirty_nats_ratio = DEF_DIRTY_NAT_RATIO_THRESHOLD;
 
 	INIT_RADIX_TREE(&nm_i->free_nid_root, GFP_ATOMIC);
-	INIT_LIST_HEAD(&nm_i->nid_list[FREE_NID_LIST]);
-	INIT_LIST_HEAD(&nm_i->nid_list[ALLOC_NID_LIST]);
+	INIT_LIST_HEAD(&nm_i->free_nid_list);
 	INIT_RADIX_TREE(&nm_i->nat_root, GFP_NOIO);
 	INIT_RADIX_TREE(&nm_i->nat_set_root, GFP_NOIO);
 	INIT_LIST_HEAD(&nm_i->nat_entries);
@@ -2742,16 +2740,15 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
 
 	/* destroy free nid list */
 	spin_lock(&nm_i->nid_list_lock);
-	list_for_each_entry_safe(i, next_i, &nm_i->nid_list[FREE_NID_LIST],
-									list) {
-		__remove_nid_from_list(sbi, i, FREE_NID_LIST, false);
+	list_for_each_entry_safe(i, next_i, &nm_i->free_nid_list, list) {
+		__remove_free_nid(sbi, i, FREE_NID, false);
 		spin_unlock(&nm_i->nid_list_lock);
 		kmem_cache_free(free_nid_slab, i);
 		spin_lock(&nm_i->nid_list_lock);
 	}
-	f2fs_bug_on(sbi, nm_i->nid_cnt[FREE_NID_LIST]);
-	f2fs_bug_on(sbi, nm_i->nid_cnt[ALLOC_NID_LIST]);
-	f2fs_bug_on(sbi, !list_empty(&nm_i->nid_list[ALLOC_NID_LIST]));
+	f2fs_bug_on(sbi, nm_i->nid_cnt[FREE_NID]);
+	f2fs_bug_on(sbi, nm_i->nid_cnt[PREALLOC_NID]);
+	f2fs_bug_on(sbi, !list_empty(&nm_i->free_nid_list));
 	spin_unlock(&nm_i->nid_list_lock);
 
 	/* destroy nat cache */
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index bb53e9955ff2..e91b08b4a51a 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -150,18 +150,10 @@ struct nat_entry_set {
 	unsigned int entry_cnt;		/* the # of nat entries in set */
 };
 
-/*
- * For free nid mangement
- */
-enum nid_state {
-	NID_NEW,	/* newly added to free nid list */
-	NID_ALLOC	/* it is allocated */
-};
-
 struct free_nid {
 	struct list_head list;	/* for free node id list */
 	nid_t nid;		/* node id */
-	int state;		/* in use or not: NID_NEW or NID_ALLOC */
+	int state;		/* in use or not: FREE_NID or PREALLOC_NID */
 };
 
 static inline void next_free_nid(struct f2fs_sb_info *sbi, nid_t *nid)
@@ -170,12 +162,11 @@ static inline void next_free_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 	struct free_nid *fnid;
 
 	spin_lock(&nm_i->nid_list_lock);
-	if (nm_i->nid_cnt[FREE_NID_LIST] <= 0) {
+	if (nm_i->nid_cnt[FREE_NID] <= 0) {
 		spin_unlock(&nm_i->nid_list_lock);
 		return;
 	}
-	fnid = list_first_entry(&nm_i->nid_list[FREE_NID_LIST],
-						struct free_nid, list);
+	fnid = list_first_entry(&nm_i->free_nid_list, struct free_nid, list);
 	*nid = fnid->nid;
 	spin_unlock(&nm_i->nid_list_lock);
 }
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index 5c60fc28ec75..0b5664a1a6cc 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -28,7 +28,7 @@ static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
 
 static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
 {
-	long count = NM_I(sbi)->nid_cnt[FREE_NID_LIST] - MAX_FREE_NIDS;
+	long count = NM_I(sbi)->nid_cnt[FREE_NID] - MAX_FREE_NIDS;
 
 	return count > 0 ? count : 0;
 }
-- 
2.13.1.388.g69e6b9b4f4a9
