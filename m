From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: obsolete free nid list approach
Date: Thu, 23 Nov 2017 20:12:28 +0800
Message-ID: <20171123121228.89060-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eHqNS-0005Kd-PW
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Nov 2017 12:13:10 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eHqNN-00078O-UB
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Nov 2017 12:13:10 +0000
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

Previously, we use free nid list to manage free nid entry, so during nid
allocation, we can just pick up one entry from list header, which has
quite low overhead.

But sadly, during initialization of free nid list, we should do lookup
combining with lots of different inner caches, including NAT page cache,
nat entry cache, curseg journal cache and free nid bitmap, so flow became
quite complicated.

In this patch, we choose to obsolete old free nid management approach,
instead, we use existing free nid bitmap which has the same functionality
to manage free nid, in order to make free nid management codes more easy
to maintain.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- avoid reusing nid incorrectly.
 fs/f2fs/checkpoint.c |   1 -
 fs/f2fs/debug.c      |   7 +-
 fs/f2fs/f2fs.h       |  10 +-
 fs/f2fs/inode.c      |   3 +
 fs/f2fs/node.c       | 483 +++++++++++++++++----------------------------------
 fs/f2fs/node.h       |  22 ---
 fs/f2fs/segment.c    |   5 -
 fs/f2fs/shrinker.c   |  14 --
 8 files changed, 163 insertions(+), 382 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a30024f2a567..69559b199983 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1024,7 +1024,6 @@ static void __prepare_cp_block(struct f2fs_sb_info *sbi)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	nid_t last_nid = nm_i->next_scan_nid;
 
-	next_free_nid(sbi, &last_nid);
 	ckpt->valid_block_count = cpu_to_le64(valid_user_blocks(sbi));
 	ckpt->valid_node_count = cpu_to_le32(valid_node_count(sbi));
 	ckpt->valid_inode_count = cpu_to_le32(valid_inode_count(sbi));
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 674f9bbe98d9..600a7d0b236c 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -100,9 +100,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->dirty_nats = NM_I(sbi)->dirty_nat_cnt;
 	si->sits = MAIN_SEGS(sbi);
 	si->dirty_sits = SIT_I(sbi)->dirty_sentries;
-	si->free_nids = NM_I(sbi)->nid_cnt[FREE_NID];
+	si->free_nids = NM_I(sbi)->total_free_nid_count;
 	si->avail_nids = NM_I(sbi)->available_nids;
-	si->alloc_nids = NM_I(sbi)->nid_cnt[PREALLOC_NID];
 	si->bg_gc = sbi->bg_gc;
 	si->util_free = (int)(free_user_blocks(sbi) >> sbi->log_blocks_per_seg)
 		* 100 / (int)(sbi->user_block_count >> sbi->log_blocks_per_seg)
@@ -233,10 +232,6 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 			atomic_read(&SM_I(sbi)->dcc_info->discard_cmd_cnt);
 	}
 
-	/* free nids */
-	si->cache_mem += (NM_I(sbi)->nid_cnt[FREE_NID] +
-				NM_I(sbi)->nid_cnt[PREALLOC_NID]) *
-				sizeof(struct free_nid);
 	si->cache_mem += NM_I(sbi)->nat_cnt * sizeof(struct nat_entry);
 	si->cache_mem += NM_I(sbi)->dirty_nat_cnt *
 					sizeof(struct nat_entry_set);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7fe1e1564d33..93aeef5bf949 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -721,14 +721,13 @@ struct f2fs_nm_info {
 	unsigned int nat_blocks;	/* # of nat blocks */
 
 	/* free node ids management */
-	struct radix_tree_root free_nid_root;/* root of the free_nid cache */
-	struct list_head free_nid_list;		/* list for free nids excluding preallocated nids */
-	unsigned int nid_cnt[MAX_NID_STATE];	/* the number of free node id */
-	spinlock_t nid_list_lock;	/* protect nid lists ops */
+	spinlock_t free_nid_lock;	/* protect nid lists ops */
 	struct mutex build_lock;	/* lock for build free nids */
 	unsigned char (*free_nid_bitmap)[NAT_ENTRY_BITMAP_SIZE];
+	unsigned char (*prealloc_nid_bitmap)[NAT_ENTRY_BITMAP_SIZE];
 	unsigned char *nat_block_bitmap;
 	unsigned short *free_nid_count;	/* free nid count of NAT block */
+	unsigned int total_free_nid_count;	/* total free nid count in bitmap */
 
 	/* for checkpoint */
 	char *nat_bitmap;		/* NAT bitmap pointer */
@@ -2644,11 +2643,10 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			struct writeback_control *wbc, bool atomic);
 int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc,
 			bool do_balance, enum iostat_type io_type);
-void build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount);
+void build_free_nids(struct f2fs_sb_info *sbi, bool mount);
 bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid);
 void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid);
 void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid);
-int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink);
 void recover_inline_xattr(struct inode *inode, struct page *page);
 int recover_xattr_data(struct inode *inode, struct page *page,
 			block_t blkaddr);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 9684d53563f1..a697c25c7e38 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -559,7 +559,10 @@ void f2fs_evict_inode(struct inode *inode)
 			add_ino_entry(sbi, inode->i_ino, UPDATE_INO);
 	}
 	if (is_inode_flag_set(inode, FI_FREE_NID)) {
+		f2fs_lock_op(sbi);
 		alloc_nid_failed(sbi, inode->i_ino);
+		f2fs_unlock_op(sbi);
+		//printk("evict_inode, ino:%lu\n", inode->i_ino);
 		clear_inode_flag(inode, FI_FREE_NID);
 	} else {
 		f2fs_bug_on(sbi, err &&
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 992f052af885..1a05a9d2381a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -23,10 +23,7 @@
 #include "trace.h"
 #include <trace/events/f2fs.h>
 
-#define on_build_free_nids(nmi) mutex_is_locked(&(nm_i)->build_lock)
-
 static struct kmem_cache *nat_entry_slab;
-static struct kmem_cache *free_nid_slab;
 static struct kmem_cache *nat_entry_set_slab;
 
 bool available_free_memory(struct f2fs_sb_info *sbi, int type)
@@ -43,13 +40,9 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
 	avail_ram = val.totalram - val.totalhigh;
 
 	/*
-	 * give 25%, 25%, 50%, 50%, 50% memory for each components respectively
+	 * give 25%, 50%, 50%, 50% memory for each components respectively
 	 */
-	if (type == FREE_NIDS) {
-		mem_size = (nm_i->nid_cnt[FREE_NID] *
-				sizeof(struct free_nid)) >> PAGE_SHIFT;
-		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 2);
-	} else if (type == NAT_ENTRIES) {
+	if (type == NAT_ENTRIES) {
 		mem_size = (nm_i->nat_cnt * sizeof(struct nat_entry)) >>
 							PAGE_SHIFT;
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 2);
@@ -1775,259 +1768,153 @@ const struct address_space_operations f2fs_node_aops = {
 #endif
 };
 
-static struct free_nid *__lookup_free_nid_list(struct f2fs_nm_info *nm_i,
-						nid_t n)
-{
-	return radix_tree_lookup(&nm_i->free_nid_root, n);
-}
-
-static int __insert_free_nid(struct f2fs_sb_info *sbi,
-			struct free_nid *i, enum nid_state state)
-{
-	struct f2fs_nm_info *nm_i = NM_I(sbi);
-
-	int err = radix_tree_insert(&nm_i->free_nid_root, i->nid, i);
-	if (err)
-		return err;
-
-	f2fs_bug_on(sbi, state != i->state);
-	nm_i->nid_cnt[state]++;
-	if (state == FREE_NID)
-		list_add_tail(&i->list, &nm_i->free_nid_list);
-	return 0;
-}
-
-static void __remove_free_nid(struct f2fs_sb_info *sbi,
-			struct free_nid *i, enum nid_state state)
-{
-	struct f2fs_nm_info *nm_i = NM_I(sbi);
-
-	f2fs_bug_on(sbi, state != i->state);
-	nm_i->nid_cnt[state]--;
-	if (state == FREE_NID)
-		list_del(&i->list);
-	radix_tree_delete(&nm_i->free_nid_root, i->nid);
-}
-
-static void __move_free_nid(struct f2fs_sb_info *sbi, struct free_nid *i,
-			enum nid_state org_state, enum nid_state dst_state)
-{
-	struct f2fs_nm_info *nm_i = NM_I(sbi);
-
-	f2fs_bug_on(sbi, org_state != i->state);
-	i->state = dst_state;
-	nm_i->nid_cnt[org_state]--;
-	nm_i->nid_cnt[dst_state]++;
-
-	switch (dst_state) {
-	case PREALLOC_NID:
-		list_del(&i->list);
-		break;
-	case FREE_NID:
-		list_add_tail(&i->list, &nm_i->free_nid_list);
-		break;
-	default:
-		BUG_ON(1);
-	}
-}
-
-static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
-							bool set, bool build)
+static bool update_free_nid_bitmap(struct f2fs_sb_info *sbi,
+					nid_t nid, bool set)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	unsigned int nat_ofs = NAT_BLOCK_OFFSET(nid);
 	unsigned int nid_ofs = nid - START_NID(nid);
 
 	if (!test_bit_le(nat_ofs, nm_i->nat_block_bitmap))
-		return;
+		return false;
 
 	if (set) {
 		if (test_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]))
-			return;
+			return false;
 		__set_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
 		nm_i->free_nid_count[nat_ofs]++;
+		nm_i->total_free_nid_count++;
 	} else {
 		if (!test_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]))
-			return;
+			return false;
 		__clear_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
-		if (!build)
-			nm_i->free_nid_count[nat_ofs]--;
+		nm_i->free_nid_count[nat_ofs]--;
+		nm_i->total_free_nid_count--;
 	}
+	return true;
 }
 
 /* return if the nid is recognized as free */
-static bool add_free_nid(struct f2fs_sb_info *sbi,
-				nid_t nid, bool build, bool update)
+static bool add_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	struct free_nid *i, *e;
 	struct nat_entry *ne;
-	int err = -EINVAL;
-	bool ret = false;
+	unsigned int nat_ofs, nid_ofs;
 
 	/* 0 nid should not be used */
 	if (unlikely(nid == 0))
 		return false;
 
-	i = f2fs_kmem_cache_alloc(free_nid_slab, GFP_NOFS);
-	i->nid = nid;
-	i->state = FREE_NID;
-
-	radix_tree_preload(GFP_NOFS | __GFP_NOFAIL);
-
-	spin_lock(&nm_i->nid_list_lock);
+	ne = __lookup_nat_cache(nm_i, nid);
+	if (ne && (!get_nat_flag(ne, IS_CHECKPOINTED) ||
+			nat_get_blkaddr(ne) != NULL_ADDR))
+		return false;
 
-	if (build) {
-		/*
-		 *   Thread A             Thread B
-		 *  - f2fs_create
-		 *   - f2fs_new_inode
-		 *    - alloc_nid
-		 *     - __insert_nid_to_list(PREALLOC_NID)
-		 *                     - f2fs_balance_fs_bg
-		 *                      - build_free_nids
-		 *                       - __build_free_nids
-		 *                        - scan_nat_page
-		 *                         - add_free_nid
-		 *                          - __lookup_nat_cache
-		 *  - f2fs_add_link
-		 *   - init_inode_metadata
-		 *    - new_inode_page
-		 *     - new_node_page
-		 *      - set_node_addr
-		 *  - alloc_nid_done
-		 *   - __remove_nid_from_list(PREALLOC_NID)
-		 *                         - __insert_nid_to_list(FREE_NID)
-		 */
-		ne = __lookup_nat_cache(nm_i, nid);
-		if (ne && (!get_nat_flag(ne, IS_CHECKPOINTED) ||
-				nat_get_blkaddr(ne) != NULL_ADDR))
-			goto err_out;
-
-		e = __lookup_free_nid_list(nm_i, nid);
-		if (e) {
-			if (e->state == FREE_NID)
-				ret = true;
-			goto err_out;
-		}
-	}
-	ret = true;
-	err = __insert_free_nid(sbi, i, FREE_NID);
-err_out:
-	if (update) {
-		update_free_nid_bitmap(sbi, nid, ret, build);
-		if (!build)
-			nm_i->available_nids++;
-	}
-	spin_unlock(&nm_i->nid_list_lock);
-	radix_tree_preload_end();
+	nat_ofs = NAT_BLOCK_OFFSET(nid);
+	nid_ofs = nid - START_NID(nid);
+	if (test_bit_le(nid_ofs, nm_i->prealloc_nid_bitmap[nat_ofs]))
+		return false;
 
-	if (err)
-		kmem_cache_free(free_nid_slab, i);
-	return ret;
+	update_free_nid_bitmap(sbi, nid, true);
+	return true;
 }
 
-static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
+static void scan_curseg_cache(struct f2fs_sb_info *sbi, nid_t start_nid,
+								nid_t end_nid)
 {
-	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	struct free_nid *i;
-	bool need_free = false;
+	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
+	struct f2fs_journal *journal = curseg->journal;
+	int i;
 
-	spin_lock(&nm_i->nid_list_lock);
-	i = __lookup_free_nid_list(nm_i, nid);
-	if (i && i->state == FREE_NID) {
-		__remove_free_nid(sbi, i, FREE_NID);
-		need_free = true;
-	}
-	spin_unlock(&nm_i->nid_list_lock);
+	down_read(&curseg->journal_rwsem);
+	for (i = 0; i < nats_in_cursum(journal); i++) {
+		block_t addr;
+		nid_t nid = le32_to_cpu(nid_in_journal(journal, i));
 
-	if (need_free)
-		kmem_cache_free(free_nid_slab, i);
+		if (nid < start_nid || nid >= end_nid)
+			continue;
+
+		addr = le32_to_cpu(nat_in_journal(journal, i).block_addr);
+
+		f2fs_bug_on(sbi, addr == NEW_ADDR);
+
+		spin_lock(&NM_I(sbi)->free_nid_lock);
+		if (addr == NULL_ADDR)
+			add_free_nid(sbi, nid);
+		else
+			update_free_nid_bitmap(sbi, nid, false);
+		spin_unlock(&NM_I(sbi)->free_nid_lock);
+	}
+	up_read(&curseg->journal_rwsem);
 }
 
-static void scan_nat_page(struct f2fs_sb_info *sbi,
-			struct page *nat_page, nid_t start_nid)
+static void scan_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	struct f2fs_nat_block *nat_blk = page_address(nat_page);
+	struct page *page;
+	struct f2fs_nat_block *nat_blk;
 	block_t blk_addr;
-	unsigned int nat_ofs = NAT_BLOCK_OFFSET(start_nid);
+	unsigned int nat_ofs = NAT_BLOCK_OFFSET(nid);
+	nid_t start_nid = nid;
 	int i;
 
+	if (test_bit_le(nat_ofs, nm_i->nat_block_bitmap))
+		return;
+
+	page = get_current_nat_page(sbi, nid);
+	nat_blk = page_address(page);
+
 	__set_bit_le(nat_ofs, nm_i->nat_block_bitmap);
 
-	i = start_nid % NAT_ENTRY_PER_BLOCK;
+	i = nid % NAT_ENTRY_PER_BLOCK;
 
-	for (; i < NAT_ENTRY_PER_BLOCK; i++, start_nid++) {
-		if (unlikely(start_nid >= nm_i->max_nid))
+	for (; i < NAT_ENTRY_PER_BLOCK; i++, nid++) {
+		if (unlikely(nid >= nm_i->max_nid))
 			break;
 
 		blk_addr = le32_to_cpu(nat_blk->entries[i].block_addr);
 		f2fs_bug_on(sbi, blk_addr == NEW_ADDR);
 		if (blk_addr == NULL_ADDR) {
-			add_free_nid(sbi, start_nid, true, true);
-		} else {
-			spin_lock(&NM_I(sbi)->nid_list_lock);
-			update_free_nid_bitmap(sbi, start_nid, false, true);
-			spin_unlock(&NM_I(sbi)->nid_list_lock);
+			spin_lock(&nm_i->free_nid_lock);
+			add_free_nid(sbi, nid);
+			spin_unlock(&nm_i->free_nid_lock);
 		}
 	}
-}
 
-static void scan_curseg_cache(struct f2fs_sb_info *sbi)
-{
-	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	struct f2fs_journal *journal = curseg->journal;
-	int i;
-
-	down_read(&curseg->journal_rwsem);
-	for (i = 0; i < nats_in_cursum(journal); i++) {
-		block_t addr;
-		nid_t nid;
+	f2fs_put_page(page, 1);
 
-		addr = le32_to_cpu(nat_in_journal(journal, i).block_addr);
-		nid = le32_to_cpu(nid_in_journal(journal, i));
-		if (addr == NULL_ADDR)
-			add_free_nid(sbi, nid, true, false);
-		else
-			remove_free_nid(sbi, nid);
-	}
-	up_read(&curseg->journal_rwsem);
+	/* find free nids from current sum_pages */
+	scan_curseg_cache(sbi, start_nid, start_nid + NAT_ENTRY_PER_BLOCK);
 }
 
-static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
+static nid_t lookup_free_nid_bitmap(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	unsigned int i, idx;
-	nid_t nid;
+	unsigned int i;
 
-	down_read(&nm_i->nat_tree_lock);
+	if (!nm_i->total_free_nid_count)
+		return 0;
 
 	for (i = 0; i < nm_i->nat_blocks; i++) {
+		unsigned int idx = 0;
+
 		if (!test_bit_le(i, nm_i->nat_block_bitmap))
 			continue;
 		if (!nm_i->free_nid_count[i])
 			continue;
-		for (idx = 0; idx < NAT_ENTRY_PER_BLOCK; idx++) {
-			idx = find_next_bit_le(nm_i->free_nid_bitmap[i],
-						NAT_ENTRY_PER_BLOCK, idx);
-			if (idx >= NAT_ENTRY_PER_BLOCK)
-				break;
 
-			nid = i * NAT_ENTRY_PER_BLOCK + idx;
-			add_free_nid(sbi, nid, true, false);
+		idx = find_next_bit_le(nm_i->free_nid_bitmap[i],
+					NAT_ENTRY_PER_BLOCK, idx);
+		if (idx >= NAT_ENTRY_PER_BLOCK)
+			continue;
 
-			if (nm_i->nid_cnt[FREE_NID] >= MAX_FREE_NIDS)
-				goto out;
-		}
+		return i * NAT_ENTRY_PER_BLOCK + idx;
 	}
-out:
-	scan_curseg_cache(sbi);
 
-	up_read(&nm_i->nat_tree_lock);
+	return 0;
 }
 
-static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
+static void __build_free_nids(struct f2fs_sb_info *sbi, bool mount)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	int i = 0;
@@ -2037,61 +1924,36 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 		nid = 0;
 
 	/* Enough entries */
-	if (nm_i->nid_cnt[FREE_NID] >= NAT_ENTRY_PER_BLOCK)
-		return;
-
-	if (!sync && !available_free_memory(sbi, FREE_NIDS))
+	if (nm_i->total_free_nid_count >= NAT_ENTRY_PER_BLOCK)
 		return;
 
-	if (!mount) {
-		/* try to find free nids in free_nid_bitmap */
-		scan_free_nid_bits(sbi);
-
-		if (nm_i->nid_cnt[FREE_NID] >= NAT_ENTRY_PER_BLOCK)
-			return;
-	}
-
 	/* readahead nat pages to be scanned */
 	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), FREE_NID_PAGES,
 							META_NAT, true);
 
 	down_read(&nm_i->nat_tree_lock);
 
-	while (1) {
-		struct page *page;
+	do {
+		scan_nat_page(sbi, nid);
 
-		if (test_bit_le(NAT_BLOCK_OFFSET(nid),
-					nm_i->nat_block_bitmap))
-			goto skip;
-
-		page = get_current_nat_page(sbi, nid);
-		scan_nat_page(sbi, page, nid);
-		f2fs_put_page(page, 1);
-skip:
 		nid += (NAT_ENTRY_PER_BLOCK - (nid % NAT_ENTRY_PER_BLOCK));
 		if (unlikely(nid >= nm_i->max_nid))
 			nid = 0;
-
-		if (++i >= FREE_NID_PAGES)
-			break;
-	}
+	} while (++i < FREE_NID_PAGES);
 
 	/* go to the next free nat pages to find free nids abundantly */
 	nm_i->next_scan_nid = nid;
 
-	/* find free nids from current sum_pages */
-	scan_curseg_cache(sbi);
-
 	up_read(&nm_i->nat_tree_lock);
 
 	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nm_i->next_scan_nid),
 					nm_i->ra_nid_pages, META_NAT, false);
 }
 
-void build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
+void build_free_nids(struct f2fs_sb_info *sbi, bool mount)
 {
 	mutex_lock(&NM_I(sbi)->build_lock);
-	__build_free_nids(sbi, sync, mount);
+	__build_free_nids(sbi, mount);
 	mutex_unlock(&NM_I(sbi)->build_lock);
 }
 
@@ -2103,7 +1965,6 @@ void build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	struct free_nid *i = NULL;
 retry:
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (time_to_inject(sbi, FAULT_ALLOC_NID)) {
@@ -2111,32 +1972,40 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 		return false;
 	}
 #endif
-	spin_lock(&nm_i->nid_list_lock);
+
+	spin_lock(&nm_i->free_nid_lock);
 
 	if (unlikely(nm_i->available_nids == 0)) {
-		spin_unlock(&nm_i->nid_list_lock);
+		spin_unlock(&nm_i->free_nid_lock);
 		return false;
 	}
 
 	/* We should not use stale free nids created by build_free_nids */
-	if (nm_i->nid_cnt[FREE_NID] && !on_build_free_nids(nm_i)) {
-		f2fs_bug_on(sbi, list_empty(&nm_i->free_nid_list));
-		i = list_first_entry(&nm_i->free_nid_list,
-					struct free_nid, list);
-		*nid = i->nid;
+	if (nm_i->total_free_nid_count && mutex_trylock(&nm_i->build_lock)) {
+		bool updated;
+		unsigned int nat_ofs, nid_ofs;
+
+		*nid = lookup_free_nid_bitmap(sbi);
+		f2fs_bug_on(sbi, !*nid);
 
-		__move_free_nid(sbi, i, FREE_NID, PREALLOC_NID);
+		updated = update_free_nid_bitmap(sbi, *nid, false);
+		f2fs_bug_on(sbi, !updated);
 		nm_i->available_nids--;
 
-		update_free_nid_bitmap(sbi, *nid, false, false);
+		nat_ofs = NAT_BLOCK_OFFSET(*nid);
+		nid_ofs = *nid - START_NID(*nid);
+		f2fs_bug_on(sbi, test_bit_le(nid_ofs,
+				nm_i->prealloc_nid_bitmap[nat_ofs]));
+		__set_bit_le(nid_ofs, nm_i->prealloc_nid_bitmap[nat_ofs]);
 
-		spin_unlock(&nm_i->nid_list_lock);
+		spin_unlock(&nm_i->free_nid_lock);
+		mutex_unlock(&nm_i->build_lock);
 		return true;
 	}
-	spin_unlock(&nm_i->nid_list_lock);
+	spin_unlock(&nm_i->free_nid_lock);
 
 	/* Let's scan nat pages and its caches to get free nids */
-	build_free_nids(sbi, true, false);
+	build_free_nids(sbi, false);
 	goto retry;
 }
 
@@ -2146,15 +2015,16 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	struct free_nid *i;
+	unsigned int nat_ofs, nid_ofs;
 
-	spin_lock(&nm_i->nid_list_lock);
-	i = __lookup_free_nid_list(nm_i, nid);
-	f2fs_bug_on(sbi, !i);
-	__remove_free_nid(sbi, i, PREALLOC_NID);
-	spin_unlock(&nm_i->nid_list_lock);
+	nat_ofs = NAT_BLOCK_OFFSET(nid);
+	nid_ofs = nid - START_NID(nid);
 
-	kmem_cache_free(free_nid_slab, i);
+	spin_lock(&nm_i->free_nid_lock);
+	f2fs_bug_on(sbi, !test_bit_le(nid_ofs,
+			nm_i->prealloc_nid_bitmap[nat_ofs]));
+	__clear_bit_le(nid_ofs, nm_i->prealloc_nid_bitmap[nat_ofs]);
+	spin_unlock(&nm_i->free_nid_lock);
 }
 
 /*
@@ -2163,59 +2033,27 @@ void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid)
 void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	struct free_nid *i;
-	bool need_free = false;
+	unsigned int nat_ofs, nid_ofs;
 
 	if (!nid)
 		return;
 
-	spin_lock(&nm_i->nid_list_lock);
-	i = __lookup_free_nid_list(nm_i, nid);
-	f2fs_bug_on(sbi, !i);
-
-	if (!available_free_memory(sbi, FREE_NIDS)) {
-		__remove_free_nid(sbi, i, PREALLOC_NID);
-		need_free = true;
-	} else {
-		__move_free_nid(sbi, i, PREALLOC_NID, FREE_NID);
-	}
-
-	nm_i->available_nids++;
-
-	update_free_nid_bitmap(sbi, nid, true, false);
-
-	spin_unlock(&nm_i->nid_list_lock);
-
-	if (need_free)
-		kmem_cache_free(free_nid_slab, i);
-}
-
-int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
-{
-	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	struct free_nid *i, *next;
-	int nr = nr_shrink;
-
-	if (nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
-		return 0;
+	nat_ofs = NAT_BLOCK_OFFSET(nid);
+	nid_ofs = nid - START_NID(nid);
 
-	if (!mutex_trylock(&nm_i->build_lock))
-		return 0;
+	mutex_lock(&nm_i->build_lock);
+	down_read(&nm_i->nat_tree_lock);
+	spin_lock(&nm_i->free_nid_lock);
 
-	spin_lock(&nm_i->nid_list_lock);
-	list_for_each_entry_safe(i, next, &nm_i->free_nid_list, list) {
-		if (nr_shrink <= 0 ||
-				nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
-			break;
+	f2fs_bug_on(sbi, !test_bit_le(nid_ofs,
+			nm_i->prealloc_nid_bitmap[nat_ofs]));
+	__clear_bit_le(nid_ofs, nm_i->prealloc_nid_bitmap[nat_ofs]);
 
-		__remove_free_nid(sbi, i, FREE_NID);
-		kmem_cache_free(free_nid_slab, i);
-		nr_shrink--;
-	}
-	spin_unlock(&nm_i->nid_list_lock);
+	if (add_free_nid(sbi, nid))
+		nm_i->available_nids++;
+	spin_unlock(&nm_i->free_nid_lock);
+	up_read(&nm_i->nat_tree_lock);
 	mutex_unlock(&nm_i->build_lock);
-
-	return nr - nr_shrink;
 }
 
 void recover_inline_xattr(struct inode *inode, struct page *page)
@@ -2307,7 +2145,10 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	}
 
 	/* Should not use this inode from free nid list */
-	remove_free_nid(sbi, ino);
+	spin_lock(&NM_I(sbi)->free_nid_lock);
+	update_free_nid_bitmap(sbi, ino, false);
+	NM_I(sbi)->available_nids--;
+	spin_unlock(&NM_I(sbi)->free_nid_lock);
 
 	if (!PageUptodate(ipage))
 		SetPageUptodate(ipage);
@@ -2412,9 +2253,9 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 		 */
 		if (!get_nat_flag(ne, IS_DIRTY) &&
 				le32_to_cpu(raw_ne.block_addr) == NULL_ADDR) {
-			spin_lock(&nm_i->nid_list_lock);
+			spin_lock(&nm_i->free_nid_lock);
 			nm_i->available_nids--;
-			spin_unlock(&nm_i->nid_list_lock);
+			spin_unlock(&nm_i->free_nid_lock);
 		}
 
 		__set_nat_cache_dirty(nm_i, ne);
@@ -2523,11 +2364,14 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 		nat_reset_flag(ne);
 		__clear_nat_cache_dirty(NM_I(sbi), set, ne);
 		if (nat_get_blkaddr(ne) == NULL_ADDR) {
-			add_free_nid(sbi, nid, false, true);
+			spin_lock(&NM_I(sbi)->free_nid_lock);
+			add_free_nid(sbi, nid);
+			NM_I(sbi)->available_nids++;
+			spin_unlock(&NM_I(sbi)->free_nid_lock);
 		} else {
-			spin_lock(&NM_I(sbi)->nid_list_lock);
-			update_free_nid_bitmap(sbi, nid, false, false);
-			spin_unlock(&NM_I(sbi)->nid_list_lock);
+			spin_lock(&NM_I(sbi)->free_nid_lock);
+			update_free_nid_bitmap(sbi, nid, false);
+			spin_unlock(&NM_I(sbi)->free_nid_lock);
 		}
 	}
 
@@ -2651,10 +2495,10 @@ static inline void load_free_nid_bitmap(struct f2fs_sb_info *sbi)
 		nid = i * NAT_ENTRY_PER_BLOCK;
 		last_nid = nid + NAT_ENTRY_PER_BLOCK;
 
-		spin_lock(&NM_I(sbi)->nid_list_lock);
+		spin_lock(&NM_I(sbi)->free_nid_lock);
 		for (; nid < last_nid; nid++)
-			update_free_nid_bitmap(sbi, nid, true, true);
-		spin_unlock(&NM_I(sbi)->nid_list_lock);
+			update_free_nid_bitmap(sbi, nid, true);
+		spin_unlock(&NM_I(sbi)->free_nid_lock);
 	}
 
 	for (i = 0; i < nm_i->nat_blocks; i++) {
@@ -2664,6 +2508,8 @@ static inline void load_free_nid_bitmap(struct f2fs_sb_info *sbi)
 
 		__set_bit_le(i, nm_i->nat_block_bitmap);
 	}
+
+	scan_curseg_cache(sbi, 0, nm_i->max_nid);
 }
 
 static int init_node_manager(struct f2fs_sb_info *sbi)
@@ -2684,21 +2530,18 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	/* not used nids: 0, node, meta, (and root counted as valid node) */
 	nm_i->available_nids = nm_i->max_nid - sbi->total_valid_node_count -
 				sbi->nquota_files - F2FS_RESERVED_NODE_NUM;
-	nm_i->nid_cnt[FREE_NID] = 0;
-	nm_i->nid_cnt[PREALLOC_NID] = 0;
+	nm_i->total_free_nid_count = 0;
 	nm_i->nat_cnt = 0;
 	nm_i->ram_thresh = DEF_RAM_THRESHOLD;
 	nm_i->ra_nid_pages = DEF_RA_NID_PAGES;
 	nm_i->dirty_nats_ratio = DEF_DIRTY_NAT_RATIO_THRESHOLD;
 
-	INIT_RADIX_TREE(&nm_i->free_nid_root, GFP_ATOMIC);
-	INIT_LIST_HEAD(&nm_i->free_nid_list);
 	INIT_RADIX_TREE(&nm_i->nat_root, GFP_NOIO);
 	INIT_RADIX_TREE(&nm_i->nat_set_root, GFP_NOIO);
 	INIT_LIST_HEAD(&nm_i->nat_entries);
 
 	mutex_init(&nm_i->build_lock);
-	spin_lock_init(&nm_i->nid_list_lock);
+	spin_lock_init(&nm_i->free_nid_lock);
 	init_rwsem(&nm_i->nat_tree_lock);
 
 	nm_i->next_scan_nid = le32_to_cpu(sbi->ckpt->next_free_nid);
@@ -2735,6 +2578,11 @@ static int init_free_nid_cache(struct f2fs_sb_info *sbi)
 	if (!nm_i->free_nid_bitmap)
 		return -ENOMEM;
 
+	nm_i->prealloc_nid_bitmap = kvzalloc(nm_i->nat_blocks *
+					NAT_ENTRY_BITMAP_SIZE, GFP_KERNEL);
+	if (!nm_i->prealloc_nid_bitmap)
+		return -ENOMEM;
+
 	nm_i->nat_block_bitmap = kvzalloc(nm_i->nat_blocks / 8,
 								GFP_KERNEL);
 	if (!nm_i->nat_block_bitmap)
@@ -2766,14 +2614,13 @@ int build_node_manager(struct f2fs_sb_info *sbi)
 	/* load free nid status from nat_bits table */
 	load_free_nid_bitmap(sbi);
 
-	build_free_nids(sbi, true, true);
+	build_free_nids(sbi, true);
 	return 0;
 }
 
 void destroy_node_manager(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	struct free_nid *i, *next_i;
 	struct nat_entry *natvec[NATVEC_SIZE];
 	struct nat_entry_set *setvec[SETVEC_SIZE];
 	nid_t nid = 0;
@@ -2782,19 +2629,6 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
 	if (!nm_i)
 		return;
 
-	/* destroy free nid list */
-	spin_lock(&nm_i->nid_list_lock);
-	list_for_each_entry_safe(i, next_i, &nm_i->free_nid_list, list) {
-		__remove_free_nid(sbi, i, FREE_NID);
-		spin_unlock(&nm_i->nid_list_lock);
-		kmem_cache_free(free_nid_slab, i);
-		spin_lock(&nm_i->nid_list_lock);
-	}
-	f2fs_bug_on(sbi, nm_i->nid_cnt[FREE_NID]);
-	f2fs_bug_on(sbi, nm_i->nid_cnt[PREALLOC_NID]);
-	f2fs_bug_on(sbi, !list_empty(&nm_i->free_nid_list));
-	spin_unlock(&nm_i->nid_list_lock);
-
 	/* destroy nat cache */
 	down_write(&nm_i->nat_tree_lock);
 	while ((found = __gang_lookup_nat_cache(nm_i,
@@ -2825,6 +2659,7 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
 
 	kvfree(nm_i->nat_block_bitmap);
 	kvfree(nm_i->free_nid_bitmap);
+	kvfree(nm_i->prealloc_nid_bitmap);
 	kvfree(nm_i->free_nid_count);
 
 	kfree(nm_i->nat_bitmap);
@@ -2843,19 +2678,12 @@ int __init create_node_manager_caches(void)
 	if (!nat_entry_slab)
 		goto fail;
 
-	free_nid_slab = f2fs_kmem_cache_create("free_nid",
-			sizeof(struct free_nid));
-	if (!free_nid_slab)
-		goto destroy_nat_entry;
-
 	nat_entry_set_slab = f2fs_kmem_cache_create("nat_entry_set",
 			sizeof(struct nat_entry_set));
 	if (!nat_entry_set_slab)
-		goto destroy_free_nid;
+		goto destroy_nat_entry;
 	return 0;
 
-destroy_free_nid:
-	kmem_cache_destroy(free_nid_slab);
 destroy_nat_entry:
 	kmem_cache_destroy(nat_entry_slab);
 fail:
@@ -2865,6 +2693,5 @@ int __init create_node_manager_caches(void)
 void destroy_node_manager_caches(void)
 {
 	kmem_cache_destroy(nat_entry_set_slab);
-	kmem_cache_destroy(free_nid_slab);
 	kmem_cache_destroy(nat_entry_slab);
 }
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 9e0c675db2fd..cdf8d347c156 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -136,7 +136,6 @@ static inline bool excess_cached_nats(struct f2fs_sb_info *sbi)
 }
 
 enum mem_type {
-	FREE_NIDS,	/* indicates the free nid list */
 	NAT_ENTRIES,	/* indicates the cached nat entry */
 	DIRTY_DENTS,	/* indicates dirty dentry pages */
 	INO_ENTRIES,	/* indicates inode entries */
@@ -152,27 +151,6 @@ struct nat_entry_set {
 	unsigned int entry_cnt;		/* the # of nat entries in set */
 };
 
-struct free_nid {
-	struct list_head list;	/* for free node id list */
-	nid_t nid;		/* node id */
-	int state;		/* in use or not: FREE_NID or PREALLOC_NID */
-};
-
-static inline void next_free_nid(struct f2fs_sb_info *sbi, nid_t *nid)
-{
-	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	struct free_nid *fnid;
-
-	spin_lock(&nm_i->nid_list_lock);
-	if (nm_i->nid_cnt[FREE_NID] <= 0) {
-		spin_unlock(&nm_i->nid_list_lock);
-		return;
-	}
-	fnid = list_first_entry(&nm_i->free_nid_list, struct free_nid, list);
-	*nid = fnid->nid;
-	spin_unlock(&nm_i->nid_list_lock);
-}
-
 /*
  * inline functions
  */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 562ad437fbc0..9edf0121c3b5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -484,11 +484,6 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 	if (!available_free_memory(sbi, NAT_ENTRIES))
 		try_to_free_nats(sbi, NAT_ENTRY_PER_BLOCK);
 
-	if (!available_free_memory(sbi, FREE_NIDS))
-		try_to_free_nids(sbi, MAX_FREE_NIDS);
-	else
-		build_free_nids(sbi, false, false);
-
 	if (!is_idle(sbi) && !excess_dirty_nats(sbi))
 		return;
 
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index 0b5664a1a6cc..7123bcb3cb62 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -26,13 +26,6 @@ static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
 	return count > 0 ? count : 0;
 }
 
-static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
-{
-	long count = NM_I(sbi)->nid_cnt[FREE_NID] - MAX_FREE_NIDS;
-
-	return count > 0 ? count : 0;
-}
-
 static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi)
 {
 	return atomic_read(&sbi->total_zombie_tree) +
@@ -64,9 +57,6 @@ unsigned long f2fs_shrink_count(struct shrinker *shrink,
 		/* shrink clean nat cache entries */
 		count += __count_nat_entries(sbi);
 
-		/* count free nids cache entries */
-		count += __count_free_nids(sbi);
-
 		spin_lock(&f2fs_list_lock);
 		p = p->next;
 		mutex_unlock(&sbi->umount_mutex);
@@ -111,10 +101,6 @@ unsigned long f2fs_shrink_scan(struct shrinker *shrink,
 		if (freed < nr)
 			freed += try_to_free_nats(sbi, nr - freed);
 
-		/* shrink free nids cache entries */
-		if (freed < nr)
-			freed += try_to_free_nids(sbi, nr - freed);
-
 		spin_lock(&f2fs_list_lock);
 		p = p->next;
 		list_move_tail(&sbi->s_list, &f2fs_list);
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
