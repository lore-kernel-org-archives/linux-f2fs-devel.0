From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: move extent cache codes to
	extent_cache.c
Date: Tue, 30 Jun 2015 18:44:00 +0800
Message-ID: <00eb01d0b321$c62f36a0$528da3e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Z9t29-0004QW-QK
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jun 2015 10:44:57 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z9t25-0000GT-Vn
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jun 2015 10:44:57 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NQR01Q7K76M9P30@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jun 2015 19:44:46 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch moves extent cache related code from data.c into extent_cache.c
since extent cache is independent feature, and its code is not relate to
others in data.c, it's better for us to maintain it in separated place.

Certainly there is no functionality change.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/Makefile       |   2 +-
 fs/f2fs/data.c         | 550 -----------------------------------------------
 fs/f2fs/extent_cache.c | 568 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h         |  22 +-
 4 files changed, 583 insertions(+), 559 deletions(-)
 create mode 100644 fs/f2fs/extent_cache.c

diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
index 005251b..08e101e 100644
--- a/fs/f2fs/Makefile
+++ b/fs/f2fs/Makefile
@@ -2,7 +2,7 @@ obj-$(CONFIG_F2FS_FS) += f2fs.o
 
 f2fs-y		:= dir.o file.o inode.o namei.o hash.o super.o inline.o
 f2fs-y		+= checkpoint.o gc.o data.o node.o segment.o recovery.o
-f2fs-y		+= shrinker.o
+f2fs-y		+= shrinker.o extent_cache.o
 f2fs-$(CONFIG_F2FS_STAT_FS) += debug.o
 f2fs-$(CONFIG_F2FS_FS_XATTR) += xattr.o
 f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) += acl.o
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e96916a..b62fcfe 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -26,9 +26,6 @@
 #include "trace.h"
 #include <trace/events/f2fs.h>
 
-static struct kmem_cache *extent_tree_slab;
-static struct kmem_cache *extent_node_slab;
-
 static void f2fs_read_end_io(struct bio *bio, int err)
 {
 	struct bio_vec *bvec;
@@ -266,522 +263,6 @@ int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
 	return err;
 }
 
-static struct extent_node *__attach_extent_node(struct f2fs_sb_info *sbi,
-				struct extent_tree *et, struct extent_info *ei,
-				struct rb_node *parent, struct rb_node **p)
-{
-	struct extent_node *en;
-
-	en = kmem_cache_alloc(extent_node_slab, GFP_ATOMIC);
-	if (!en)
-		return NULL;
-
-	en->ei = *ei;
-	INIT_LIST_HEAD(&en->list);
-
-	en->et = et;
-	rb_link_node(&en->rb_node, parent, p);
-	rb_insert_color(&en->rb_node, &et->root);
-	et->count++;
-	atomic_inc(&sbi->total_ext_node);
-	return en;
-}
-
-static void __detach_extent_node(struct f2fs_sb_info *sbi,
-				struct extent_tree *et, struct extent_node *en)
-{
-	rb_erase(&en->rb_node, &et->root);
-	et->count--;
-	atomic_dec(&sbi->total_ext_node);
-
-	if (et->cached_en == en)
-		et->cached_en = NULL;
-}
-
-static struct extent_tree *__grab_extent_tree(struct inode *inode)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_tree *et;
-	nid_t ino = inode->i_ino;
-
-	down_write(&sbi->extent_tree_lock);
-	et = radix_tree_lookup(&sbi->extent_tree_root, ino);
-	if (!et) {
-		et = f2fs_kmem_cache_alloc(extent_tree_slab, GFP_NOFS);
-		f2fs_radix_tree_insert(&sbi->extent_tree_root, ino, et);
-		memset(et, 0, sizeof(struct extent_tree));
-		et->ino = ino;
-		et->root = RB_ROOT;
-		et->cached_en = NULL;
-		rwlock_init(&et->lock);
-		atomic_set(&et->refcount, 0);
-		et->count = 0;
-		sbi->total_ext_tree++;
-	}
-	atomic_inc(&et->refcount);
-	up_write(&sbi->extent_tree_lock);
-
-	/* never died untill evict_inode */
-	F2FS_I(inode)->extent_tree = et;
-
-	return et;
-}
-
-static struct extent_node *__lookup_extent_tree(struct extent_tree *et,
-							unsigned int fofs)
-{
-	struct rb_node *node = et->root.rb_node;
-	struct extent_node *en;
-
-	if (et->cached_en) {
-		struct extent_info *cei = &et->cached_en->ei;
-
-		if (cei->fofs <= fofs && cei->fofs + cei->len > fofs)
-			return et->cached_en;
-	}
-
-	while (node) {
-		en = rb_entry(node, struct extent_node, rb_node);
-
-		if (fofs < en->ei.fofs)
-			node = node->rb_left;
-		else if (fofs >= en->ei.fofs + en->ei.len)
-			node = node->rb_right;
-		else
-			return en;
-	}
-	return NULL;
-}
-
-static struct extent_node *__try_back_merge(struct f2fs_sb_info *sbi,
-				struct extent_tree *et, struct extent_node *en)
-{
-	struct extent_node *prev;
-	struct rb_node *node;
-
-	node = rb_prev(&en->rb_node);
-	if (!node)
-		return NULL;
-
-	prev = rb_entry(node, struct extent_node, rb_node);
-	if (__is_back_mergeable(&en->ei, &prev->ei)) {
-		en->ei.fofs = prev->ei.fofs;
-		en->ei.blk = prev->ei.blk;
-		en->ei.len += prev->ei.len;
-		__detach_extent_node(sbi, et, prev);
-		return prev;
-	}
-	return NULL;
-}
-
-static struct extent_node *__try_front_merge(struct f2fs_sb_info *sbi,
-				struct extent_tree *et, struct extent_node *en)
-{
-	struct extent_node *next;
-	struct rb_node *node;
-
-	node = rb_next(&en->rb_node);
-	if (!node)
-		return NULL;
-
-	next = rb_entry(node, struct extent_node, rb_node);
-	if (__is_front_mergeable(&en->ei, &next->ei)) {
-		en->ei.len += next->ei.len;
-		__detach_extent_node(sbi, et, next);
-		return next;
-	}
-	return NULL;
-}
-
-static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
-				struct extent_tree *et, struct extent_info *ei,
-				struct extent_node **den)
-{
-	struct rb_node **p = &et->root.rb_node;
-	struct rb_node *parent = NULL;
-	struct extent_node *en;
-
-	while (*p) {
-		parent = *p;
-		en = rb_entry(parent, struct extent_node, rb_node);
-
-		if (ei->fofs < en->ei.fofs) {
-			if (__is_front_mergeable(ei, &en->ei)) {
-				en->ei.fofs = ei->fofs;
-				en->ei.blk = ei->blk;
-				en->ei.len += ei->len;
-				if (den)
-					*den = __try_back_merge(sbi, et, en);
-				goto update_out;
-			}
-			p = &(*p)->rb_left;
-		} else if (ei->fofs >= en->ei.fofs + en->ei.len) {
-			if (__is_back_mergeable(ei, &en->ei)) {
-				en->ei.len += ei->len;
-				if (den)
-					*den = __try_front_merge(sbi, et, en);
-				goto update_out;
-			}
-			p = &(*p)->rb_right;
-		} else {
-			f2fs_bug_on(sbi, 1);
-		}
-	}
-
-	en = __attach_extent_node(sbi, et, ei, parent, p);
-update_out:
-	if (en && en->ei.len > et->largest.len)
-		et->largest = en->ei;
-	return en;
-}
-
-static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
-						struct extent_tree *et)
-{
-	struct rb_node *node, *next;
-	struct extent_node *en;
-	unsigned int count = et->count;
-
-	node = rb_first(&et->root);
-	while (node) {
-		next = rb_next(node);
-		en = rb_entry(node, struct extent_node, rb_node);
-
-		spin_lock(&sbi->extent_lock);
-		if (!list_empty(&en->list))
-			list_del_init(&en->list);
-		spin_unlock(&sbi->extent_lock);
-
-		__detach_extent_node(sbi, et, en);
-		kmem_cache_free(extent_node_slab, en);
-		node = next;
-	}
-
-	return count - et->count;
-}
-
-static bool __try_free_extent_tree(struct f2fs_sb_info *sbi, nid_t ino)
-{
-	struct extent_tree *et;
-
-	if (!down_write_trylock(&sbi->extent_tree_lock))
-		return false;
-
-	et = radix_tree_lookup(&sbi->extent_tree_root, ino);
-	if (!et)
-		goto out;
-
-	if (__can_free_extent_tree(et)) {
-		radix_tree_delete(&sbi->extent_tree_root, ino);
-		kmem_cache_free(extent_tree_slab, et);
-		sbi->total_ext_tree--;
-		up_write(&sbi->extent_tree_lock);
-		return true;
-	}
-out:
-	up_write(&sbi->extent_tree_lock);
-	return false;
-}
-
-static void __drop_largest_extent(struct inode *inode, pgoff_t fofs)
-{
-	struct extent_info *largest = &F2FS_I(inode)->extent_tree->largest;
-
-	if (largest->fofs <= fofs && largest->fofs + largest->len > fofs)
-		largest->len = 0;
-}
-
-void f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_tree *et;
-	struct extent_node *en;
-	struct extent_info ei;
-
-	if (!f2fs_may_extent_tree(inode))
-		return;
-
-	et = __grab_extent_tree(inode);
-
-	if (!i_ext || le32_to_cpu(i_ext->len) < F2FS_MIN_EXTENT_LEN)
-		return;
-
-	set_extent_info(&ei, le32_to_cpu(i_ext->fofs),
-		le32_to_cpu(i_ext->blk), le32_to_cpu(i_ext->len));
-
-	write_lock(&et->lock);
-	if (et->count)
-		goto out;
-
-	en = __insert_extent_tree(sbi, et, &ei, NULL);
-	if (en) {
-		et->cached_en = en;
-
-		spin_lock(&sbi->extent_lock);
-		list_add_tail(&en->list, &sbi->extent_list);
-		spin_unlock(&sbi->extent_lock);
-	}
-out:
-	write_unlock(&et->lock);
-}
-
-static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
-							struct extent_info *ei)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_tree *et = F2FS_I(inode)->extent_tree;
-	struct extent_node *en;
-
-	f2fs_bug_on(sbi, !et);
-
-	trace_f2fs_lookup_extent_tree_start(inode, pgofs);
-
-	read_lock(&et->lock);
-	en = __lookup_extent_tree(et, pgofs);
-	if (en) {
-		*ei = en->ei;
-		spin_lock(&sbi->extent_lock);
-		if (!list_empty(&en->list))
-			list_move_tail(&en->list, &sbi->extent_list);
-		et->cached_en = en;
-		spin_unlock(&sbi->extent_lock);
-		stat_inc_read_hit(sbi->sb);
-	}
-	stat_inc_total_hit(sbi->sb);
-	read_unlock(&et->lock);
-
-	trace_f2fs_lookup_extent_tree_end(inode, pgofs, en);
-	return en ? true : false;
-}
-
-/* return true, if on-disk extent should be updated */
-static bool f2fs_update_extent_tree(struct inode *inode, pgoff_t fofs,
-							block_t blkaddr)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_tree *et = F2FS_I(inode)->extent_tree;
-	struct extent_node *en = NULL, *en1 = NULL, *en2 = NULL, *en3 = NULL;
-	struct extent_node *den = NULL;
-	struct extent_info ei, dei, prev;
-	unsigned int endofs;
-
-	if (!et)
-		return false;
-
-	trace_f2fs_update_extent_tree(inode, fofs, blkaddr);
-
-	write_lock(&et->lock);
-
-	if (is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT)) {
-		write_unlock(&et->lock);
-		return false;
-	}
-
-	prev = et->largest;
-	dei.len = 0;
-
-	/* 1. lookup and remove existing extent info in cache */
-	en = __lookup_extent_tree(et, fofs);
-	if (!en)
-		goto update_extent;
-
-	dei = en->ei;
-	__detach_extent_node(sbi, et, en);
-
-	__drop_largest_extent(inode, fofs);
-
-	/* 2. if extent can be split more, split and insert the left part */
-	if (dei.len > 1) {
-		/*  insert left part of split extent into cache */
-		if (fofs - dei.fofs >= F2FS_MIN_EXTENT_LEN) {
-			set_extent_info(&ei, dei.fofs, dei.blk,
-							fofs - dei.fofs);
-			en1 = __insert_extent_tree(sbi, et, &ei, NULL);
-		}
-
-		/* insert right part of split extent into cache */
-		endofs = dei.fofs + dei.len - 1;
-		if (endofs - fofs >= F2FS_MIN_EXTENT_LEN) {
-			set_extent_info(&ei, fofs + 1,
-				fofs - dei.fofs + dei.blk + 1, endofs - fofs);
-			en2 = __insert_extent_tree(sbi, et, &ei, NULL);
-		}
-	}
-
-update_extent:
-	/* 3. update extent in extent cache */
-	if (blkaddr) {
-		set_extent_info(&ei, fofs, blkaddr, 1);
-		en3 = __insert_extent_tree(sbi, et, &ei, &den);
-
-		/* give up extent_cache, if split and small updates happen */
-		if (dei.len >= 1 &&
-				prev.len < F2FS_MIN_EXTENT_LEN &&
-				et->largest.len < F2FS_MIN_EXTENT_LEN) {
-			et->largest.len = 0;
-			set_inode_flag(F2FS_I(inode), FI_NO_EXTENT);
-		}
-	}
-
-	/* 4. update in global extent list */
-	spin_lock(&sbi->extent_lock);
-	if (en && !list_empty(&en->list))
-		list_del(&en->list);
-	/*
-	 * en1 and en2 split from en, they will become more and more smaller
-	 * fragments after splitting several times. So if the length is smaller
-	 * than F2FS_MIN_EXTENT_LEN, we will not add them into extent tree.
-	 */
-	if (en1)
-		list_add_tail(&en1->list, &sbi->extent_list);
-	if (en2)
-		list_add_tail(&en2->list, &sbi->extent_list);
-	if (en3) {
-		if (list_empty(&en3->list))
-			list_add_tail(&en3->list, &sbi->extent_list);
-		else
-			list_move_tail(&en3->list, &sbi->extent_list);
-	}
-	if (den && !list_empty(&den->list))
-		list_del(&den->list);
-	spin_unlock(&sbi->extent_lock);
-
-	/* 5. release extent node */
-	if (en)
-		kmem_cache_free(extent_node_slab, en);
-	if (den)
-		kmem_cache_free(extent_node_slab, den);
-
-	if (is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT))
-		__free_extent_tree(sbi, et);
-
-	write_unlock(&et->lock);
-
-	return !__is_extent_same(&prev, &et->largest);
-}
-
-unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
-{
-	struct extent_tree *et;
-	struct extent_node *en;
-	unsigned int node_cnt = 0, tree_cnt = 0;
-
-	if (!test_opt(sbi, EXTENT_CACHE))
-		return 0;
-
-	spin_lock(&sbi->extent_lock);
-	for (; nr_shrink > 0; nr_shrink--) {
-		nid_t ino;
-		bool can_free;
-
-		if (list_empty(&sbi->extent_list))
-			break;
-		en = list_first_entry(&sbi->extent_list, struct extent_node,
-								list);
-		et = en->et;
-
-		if (!write_trylock(&et->lock)) {
-			/* refresh this extent node's position in extent list */
-			list_move_tail(&en->list, &sbi->extent_list);
-			continue;
-		}
-
-		list_del(&en->list);
-		spin_unlock(&sbi->extent_lock);
-
-		__detach_extent_node(sbi, et, en);
-		kmem_cache_free(extent_node_slab, en);
-
-		ino = et->ino;
-		can_free = __can_free_extent_tree(et);
-		write_unlock(&et->lock);
-
-		node_cnt++;
-
-		if (can_free && __try_free_extent_tree(sbi, ino))
-			tree_cnt++;
-
-		spin_lock(&sbi->extent_lock);
-	}
-	spin_unlock(&sbi->extent_lock);
-
-	trace_f2fs_shrink_extent_tree(sbi, node_cnt, tree_cnt);
-
-	return node_cnt + tree_cnt;
-}
-
-void f2fs_destroy_extent_node(struct inode *inode)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_tree *et = F2FS_I(inode)->extent_tree;
-	unsigned int node_cnt = 0;
-
-	if (!et)
-		return;
-
-	write_lock(&et->lock);
-	node_cnt = __free_extent_tree(sbi, et);
-	write_unlock(&et->lock);
-}
-
-void f2fs_destroy_extent_tree(struct inode *inode)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_tree *et = F2FS_I(inode)->extent_tree;
-	unsigned int node_cnt = 0;
-
-	if (!et)
-		return;
-
-	if (inode->i_nlink && !is_bad_inode(inode) && et->count) {
-		atomic_dec(&et->refcount);
-		return;
-	}
-
-	/* free all extent info belong to this extent tree */
-	f2fs_destroy_extent_node(inode);
-
-	/* delete extent tree entry in radix tree */
-	down_write(&sbi->extent_tree_lock);
-	atomic_dec(&et->refcount);
-	f2fs_bug_on(sbi, !__can_free_extent_tree(et));
-	radix_tree_delete(&sbi->extent_tree_root, inode->i_ino);
-	kmem_cache_free(extent_tree_slab, et);
-	sbi->total_ext_tree--;
-	up_write(&sbi->extent_tree_lock);
-
-	F2FS_I(inode)->extent_tree = NULL;
-
-	trace_f2fs_destroy_extent_tree(inode, node_cnt);
-	return;
-}
-
-static bool f2fs_lookup_extent_cache(struct inode *inode, pgoff_t pgofs,
-							struct extent_info *ei)
-{
-	if (!f2fs_may_extent_tree(inode))
-		return false;
-
-	return f2fs_lookup_extent_tree(inode, pgofs, ei);
-}
-
-void f2fs_update_extent_cache(struct dnode_of_data *dn)
-{
-	struct f2fs_inode_info *fi = F2FS_I(dn->inode);
-	pgoff_t fofs;
-
-	if (!f2fs_may_extent_tree(dn->inode))
-		return;
-
-	f2fs_bug_on(F2FS_I_SB(dn->inode), dn->data_blkaddr == NEW_ADDR);
-
-	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), fi) +
-							dn->ofs_in_node;
-
-	if (f2fs_update_extent_tree(dn->inode, fofs, dn->data_blkaddr))
-		sync_inode_page(dn);
-}
-
 struct page *get_read_data_page(struct inode *inode, pgoff_t index, int rw)
 {
 	struct address_space *mapping = inode->i_mapping;
@@ -1971,37 +1452,6 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 	return generic_block_bmap(mapping, block, get_data_block);
 }
 
-void init_extent_cache_info(struct f2fs_sb_info *sbi)
-{
-	INIT_RADIX_TREE(&sbi->extent_tree_root, GFP_NOIO);
-	init_rwsem(&sbi->extent_tree_lock);
-	INIT_LIST_HEAD(&sbi->extent_list);
-	spin_lock_init(&sbi->extent_lock);
-	sbi->total_ext_tree = 0;
-	atomic_set(&sbi->total_ext_node, 0);
-}
-
-int __init create_extent_cache(void)
-{
-	extent_tree_slab = f2fs_kmem_cache_create("f2fs_extent_tree",
-			sizeof(struct extent_tree));
-	if (!extent_tree_slab)
-		return -ENOMEM;
-	extent_node_slab = f2fs_kmem_cache_create("f2fs_extent_node",
-			sizeof(struct extent_node));
-	if (!extent_node_slab) {
-		kmem_cache_destroy(extent_tree_slab);
-		return -ENOMEM;
-	}
-	return 0;
-}
-
-void destroy_extent_cache(void)
-{
-	kmem_cache_destroy(extent_node_slab);
-	kmem_cache_destroy(extent_tree_slab);
-}
-
 const struct address_space_operations f2fs_dblock_aops = {
 	.readpage	= f2fs_read_data_page,
 	.readpages	= f2fs_read_data_pages,
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
new file mode 100644
index 0000000..25be61e
--- /dev/null
+++ b/fs/f2fs/extent_cache.c
@@ -0,0 +1,568 @@
+/*
+ * f2fs extent cache support
+ *
+ * Copyright (c) 2015 Motorola Mobility
+ * Copyright (c) 2015 Samsung Electronics
+ * Authors: Jaegeuk Kim <jaegeuk@kernel.org>
+ *          Chao Yu <chao2.yu@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/fs.h>
+#include <linux/f2fs_fs.h>
+
+#include "f2fs.h"
+#include "node.h"
+#include <trace/events/f2fs.h>
+
+static struct kmem_cache *extent_tree_slab;
+static struct kmem_cache *extent_node_slab;
+
+static struct extent_node *__attach_extent_node(struct f2fs_sb_info *sbi,
+				struct extent_tree *et, struct extent_info *ei,
+				struct rb_node *parent, struct rb_node **p)
+{
+	struct extent_node *en;
+
+	en = kmem_cache_alloc(extent_node_slab, GFP_ATOMIC);
+	if (!en)
+		return NULL;
+
+	en->ei = *ei;
+	INIT_LIST_HEAD(&en->list);
+
+	en->et = et;
+	rb_link_node(&en->rb_node, parent, p);
+	rb_insert_color(&en->rb_node, &et->root);
+	et->count++;
+	atomic_inc(&sbi->total_ext_node);
+	return en;
+}
+
+static void __detach_extent_node(struct f2fs_sb_info *sbi,
+				struct extent_tree *et, struct extent_node *en)
+{
+	rb_erase(&en->rb_node, &et->root);
+	et->count--;
+	atomic_dec(&sbi->total_ext_node);
+
+	if (et->cached_en == en)
+		et->cached_en = NULL;
+}
+
+static struct extent_tree *__grab_extent_tree(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct extent_tree *et;
+	nid_t ino = inode->i_ino;
+
+	down_write(&sbi->extent_tree_lock);
+	et = radix_tree_lookup(&sbi->extent_tree_root, ino);
+	if (!et) {
+		et = f2fs_kmem_cache_alloc(extent_tree_slab, GFP_NOFS);
+		f2fs_radix_tree_insert(&sbi->extent_tree_root, ino, et);
+		memset(et, 0, sizeof(struct extent_tree));
+		et->ino = ino;
+		et->root = RB_ROOT;
+		et->cached_en = NULL;
+		rwlock_init(&et->lock);
+		atomic_set(&et->refcount, 0);
+		et->count = 0;
+		sbi->total_ext_tree++;
+	}
+	atomic_inc(&et->refcount);
+	up_write(&sbi->extent_tree_lock);
+
+	/* never died until evict_inode */
+	F2FS_I(inode)->extent_tree = et;
+
+	return et;
+}
+
+static struct extent_node *__lookup_extent_tree(struct extent_tree *et,
+							unsigned int fofs)
+{
+	struct rb_node *node = et->root.rb_node;
+	struct extent_node *en;
+
+	if (et->cached_en) {
+		struct extent_info *cei = &et->cached_en->ei;
+
+		if (cei->fofs <= fofs && cei->fofs + cei->len > fofs)
+			return et->cached_en;
+	}
+
+	while (node) {
+		en = rb_entry(node, struct extent_node, rb_node);
+
+		if (fofs < en->ei.fofs)
+			node = node->rb_left;
+		else if (fofs >= en->ei.fofs + en->ei.len)
+			node = node->rb_right;
+		else
+			return en;
+	}
+	return NULL;
+}
+
+static struct extent_node *__try_back_merge(struct f2fs_sb_info *sbi,
+				struct extent_tree *et, struct extent_node *en)
+{
+	struct extent_node *prev;
+	struct rb_node *node;
+
+	node = rb_prev(&en->rb_node);
+	if (!node)
+		return NULL;
+
+	prev = rb_entry(node, struct extent_node, rb_node);
+	if (__is_back_mergeable(&en->ei, &prev->ei)) {
+		en->ei.fofs = prev->ei.fofs;
+		en->ei.blk = prev->ei.blk;
+		en->ei.len += prev->ei.len;
+		__detach_extent_node(sbi, et, prev);
+		return prev;
+	}
+	return NULL;
+}
+
+static struct extent_node *__try_front_merge(struct f2fs_sb_info *sbi,
+				struct extent_tree *et, struct extent_node *en)
+{
+	struct extent_node *next;
+	struct rb_node *node;
+
+	node = rb_next(&en->rb_node);
+	if (!node)
+		return NULL;
+
+	next = rb_entry(node, struct extent_node, rb_node);
+	if (__is_front_mergeable(&en->ei, &next->ei)) {
+		en->ei.len += next->ei.len;
+		__detach_extent_node(sbi, et, next);
+		return next;
+	}
+	return NULL;
+}
+
+static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
+				struct extent_tree *et, struct extent_info *ei,
+				struct extent_node **den)
+{
+	struct rb_node **p = &et->root.rb_node;
+	struct rb_node *parent = NULL;
+	struct extent_node *en;
+
+	while (*p) {
+		parent = *p;
+		en = rb_entry(parent, struct extent_node, rb_node);
+
+		if (ei->fofs < en->ei.fofs) {
+			if (__is_front_mergeable(ei, &en->ei)) {
+				en->ei.fofs = ei->fofs;
+				en->ei.blk = ei->blk;
+				en->ei.len += ei->len;
+				if (den)
+					*den = __try_back_merge(sbi, et, en);
+				goto update_out;
+			}
+			p = &(*p)->rb_left;
+		} else if (ei->fofs >= en->ei.fofs + en->ei.len) {
+			if (__is_back_mergeable(ei, &en->ei)) {
+				en->ei.len += ei->len;
+				if (den)
+					*den = __try_front_merge(sbi, et, en);
+				goto update_out;
+			}
+			p = &(*p)->rb_right;
+		} else {
+			f2fs_bug_on(sbi, 1);
+		}
+	}
+
+	en = __attach_extent_node(sbi, et, ei, parent, p);
+update_out:
+	if (en && en->ei.len > et->largest.len)
+		et->largest = en->ei;
+	return en;
+}
+
+static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
+						struct extent_tree *et)
+{
+	struct rb_node *node, *next;
+	struct extent_node *en;
+	unsigned int count = et->count;
+
+	node = rb_first(&et->root);
+	while (node) {
+		next = rb_next(node);
+		en = rb_entry(node, struct extent_node, rb_node);
+
+		spin_lock(&sbi->extent_lock);
+		if (!list_empty(&en->list))
+			list_del_init(&en->list);
+		spin_unlock(&sbi->extent_lock);
+
+		__detach_extent_node(sbi, et, en);
+		kmem_cache_free(extent_node_slab, en);
+		node = next;
+	}
+
+	return count - et->count;
+}
+
+static bool __try_free_extent_tree(struct f2fs_sb_info *sbi, nid_t ino)
+{
+	struct extent_tree *et;
+
+	if (!down_write_trylock(&sbi->extent_tree_lock))
+		return false;
+
+	et = radix_tree_lookup(&sbi->extent_tree_root, ino);
+	if (!et)
+		goto out;
+
+	if (__can_free_extent_tree(et)) {
+		radix_tree_delete(&sbi->extent_tree_root, ino);
+		kmem_cache_free(extent_tree_slab, et);
+		sbi->total_ext_tree--;
+		up_write(&sbi->extent_tree_lock);
+		return true;
+	}
+out:
+	up_write(&sbi->extent_tree_lock);
+	return false;
+}
+
+void __drop_largest_extent(struct inode *inode, pgoff_t fofs)
+{
+	struct extent_info *largest = &F2FS_I(inode)->extent_tree->largest;
+
+	if (largest->fofs <= fofs && largest->fofs + largest->len > fofs)
+		largest->len = 0;
+}
+
+void f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct extent_tree *et;
+	struct extent_node *en;
+	struct extent_info ei;
+
+	if (!f2fs_may_extent_tree(inode))
+		return;
+
+	et = __grab_extent_tree(inode);
+
+	if (!i_ext || le32_to_cpu(i_ext->len) < F2FS_MIN_EXTENT_LEN)
+		return;
+
+	set_extent_info(&ei, le32_to_cpu(i_ext->fofs),
+		le32_to_cpu(i_ext->blk), le32_to_cpu(i_ext->len));
+
+	write_lock(&et->lock);
+	if (et->count)
+		goto out;
+
+	en = __insert_extent_tree(sbi, et, &ei, NULL);
+	if (en) {
+		et->cached_en = en;
+
+		spin_lock(&sbi->extent_lock);
+		list_add_tail(&en->list, &sbi->extent_list);
+		spin_unlock(&sbi->extent_lock);
+	}
+out:
+	write_unlock(&et->lock);
+}
+
+static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
+							struct extent_info *ei)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct extent_tree *et = F2FS_I(inode)->extent_tree;
+	struct extent_node *en;
+
+	f2fs_bug_on(sbi, !et);
+
+	trace_f2fs_lookup_extent_tree_start(inode, pgofs);
+
+	read_lock(&et->lock);
+	en = __lookup_extent_tree(et, pgofs);
+	if (en) {
+		*ei = en->ei;
+		spin_lock(&sbi->extent_lock);
+		if (!list_empty(&en->list))
+			list_move_tail(&en->list, &sbi->extent_list);
+		et->cached_en = en;
+		spin_unlock(&sbi->extent_lock);
+		stat_inc_read_hit(sbi->sb);
+	}
+	stat_inc_total_hit(sbi->sb);
+	read_unlock(&et->lock);
+
+	trace_f2fs_lookup_extent_tree_end(inode, pgofs, en);
+	return en ? true : false;
+}
+
+/* return true, if on-disk extent should be updated */
+static bool f2fs_update_extent_tree(struct inode *inode, pgoff_t fofs,
+							block_t blkaddr)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct extent_tree *et = F2FS_I(inode)->extent_tree;
+	struct extent_node *en = NULL, *en1 = NULL, *en2 = NULL, *en3 = NULL;
+	struct extent_node *den = NULL;
+	struct extent_info ei, dei, prev;
+	unsigned int endofs;
+
+	if (!et)
+		return false;
+
+	trace_f2fs_update_extent_tree(inode, fofs, blkaddr);
+
+	write_lock(&et->lock);
+
+	if (is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT)) {
+		write_unlock(&et->lock);
+		return false;
+	}
+
+	prev = et->largest;
+	dei.len = 0;
+
+	/* 1. lookup and remove existing extent info in cache */
+	en = __lookup_extent_tree(et, fofs);
+	if (!en)
+		goto update_extent;
+
+	dei = en->ei;
+	__detach_extent_node(sbi, et, en);
+
+	__drop_largest_extent(inode, fofs);
+
+	/* 2. if extent can be split more, split and insert the left part */
+	if (dei.len > 1) {
+		/*  insert left part of split extent into cache */
+		if (fofs - dei.fofs >= F2FS_MIN_EXTENT_LEN) {
+			set_extent_info(&ei, dei.fofs, dei.blk,
+							fofs - dei.fofs);
+			en1 = __insert_extent_tree(sbi, et, &ei, NULL);
+		}
+
+		/* insert right part of split extent into cache */
+		endofs = dei.fofs + dei.len - 1;
+		if (endofs - fofs >= F2FS_MIN_EXTENT_LEN) {
+			set_extent_info(&ei, fofs + 1,
+				fofs - dei.fofs + dei.blk + 1, endofs - fofs);
+			en2 = __insert_extent_tree(sbi, et, &ei, NULL);
+		}
+	}
+
+update_extent:
+	/* 3. update extent in extent cache */
+	if (blkaddr) {
+		set_extent_info(&ei, fofs, blkaddr, 1);
+		en3 = __insert_extent_tree(sbi, et, &ei, &den);
+
+		/* give up extent_cache, if split and small updates happen */
+		if (dei.len >= 1 &&
+				prev.len < F2FS_MIN_EXTENT_LEN &&
+				et->largest.len < F2FS_MIN_EXTENT_LEN) {
+			et->largest.len = 0;
+			set_inode_flag(F2FS_I(inode), FI_NO_EXTENT);
+		}
+	}
+
+	/* 4. update in global extent list */
+	spin_lock(&sbi->extent_lock);
+	if (en && !list_empty(&en->list))
+		list_del(&en->list);
+	/*
+	 * en1 and en2 split from en, they will become more and more smaller
+	 * fragments after splitting several times. So if the length is smaller
+	 * than F2FS_MIN_EXTENT_LEN, we will not add them into extent tree.
+	 */
+	if (en1)
+		list_add_tail(&en1->list, &sbi->extent_list);
+	if (en2)
+		list_add_tail(&en2->list, &sbi->extent_list);
+	if (en3) {
+		if (list_empty(&en3->list))
+			list_add_tail(&en3->list, &sbi->extent_list);
+		else
+			list_move_tail(&en3->list, &sbi->extent_list);
+	}
+	if (den && !list_empty(&den->list))
+		list_del(&den->list);
+	spin_unlock(&sbi->extent_lock);
+
+	/* 5. release extent node */
+	if (en)
+		kmem_cache_free(extent_node_slab, en);
+	if (den)
+		kmem_cache_free(extent_node_slab, den);
+
+	if (is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT))
+		__free_extent_tree(sbi, et);
+
+	write_unlock(&et->lock);
+
+	return !__is_extent_same(&prev, &et->largest);
+}
+
+unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
+{
+	struct extent_tree *et;
+	struct extent_node *en;
+	unsigned int node_cnt = 0, tree_cnt = 0;
+
+	if (!test_opt(sbi, EXTENT_CACHE))
+		return 0;
+
+	spin_lock(&sbi->extent_lock);
+	for (; nr_shrink > 0; nr_shrink--) {
+		nid_t ino;
+		bool can_free;
+
+		if (list_empty(&sbi->extent_list))
+			break;
+		en = list_first_entry(&sbi->extent_list, struct extent_node,
+								list);
+		et = en->et;
+
+		if (!write_trylock(&et->lock)) {
+			/* refresh this extent node's position in extent list */
+			list_move_tail(&en->list, &sbi->extent_list);
+			continue;
+		}
+
+		list_del(&en->list);
+		spin_unlock(&sbi->extent_lock);
+
+		__detach_extent_node(sbi, et, en);
+		kmem_cache_free(extent_node_slab, en);
+
+		ino = et->ino;
+		can_free = __can_free_extent_tree(et);
+		write_unlock(&et->lock);
+
+		node_cnt++;
+
+		if (can_free && __try_free_extent_tree(sbi, ino))
+			tree_cnt++;
+
+		spin_lock(&sbi->extent_lock);
+	}
+	spin_unlock(&sbi->extent_lock);
+
+	trace_f2fs_shrink_extent_tree(sbi, node_cnt, tree_cnt);
+
+	return node_cnt + tree_cnt;
+}
+
+void f2fs_destroy_extent_node(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct extent_tree *et = F2FS_I(inode)->extent_tree;
+	unsigned int node_cnt = 0;
+
+	if (!et)
+		return;
+
+	write_lock(&et->lock);
+	node_cnt = __free_extent_tree(sbi, et);
+	write_unlock(&et->lock);
+}
+
+void f2fs_destroy_extent_tree(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct extent_tree *et = F2FS_I(inode)->extent_tree;
+	unsigned int node_cnt = 0;
+
+	if (!et)
+		return;
+
+	if (inode->i_nlink && !is_bad_inode(inode) && et->count) {
+		atomic_dec(&et->refcount);
+		return;
+	}
+
+	/* free all extent info belong to this extent tree */
+	f2fs_destroy_extent_node(inode);
+
+	/* delete extent tree entry in radix tree */
+	down_write(&sbi->extent_tree_lock);
+	atomic_dec(&et->refcount);
+	f2fs_bug_on(sbi, !__can_free_extent_tree(et));
+	radix_tree_delete(&sbi->extent_tree_root, inode->i_ino);
+	kmem_cache_free(extent_tree_slab, et);
+	sbi->total_ext_tree--;
+	up_write(&sbi->extent_tree_lock);
+
+	F2FS_I(inode)->extent_tree = NULL;
+
+	trace_f2fs_destroy_extent_tree(inode, node_cnt);
+}
+
+bool f2fs_lookup_extent_cache(struct inode *inode, pgoff_t pgofs,
+							struct extent_info *ei)
+{
+	if (!f2fs_may_extent_tree(inode))
+		return false;
+
+	return f2fs_lookup_extent_tree(inode, pgofs, ei);
+}
+
+void f2fs_update_extent_cache(struct dnode_of_data *dn)
+{
+	struct f2fs_inode_info *fi = F2FS_I(dn->inode);
+	pgoff_t fofs;
+
+	if (!f2fs_may_extent_tree(dn->inode))
+		return;
+
+	f2fs_bug_on(F2FS_I_SB(dn->inode), dn->data_blkaddr == NEW_ADDR);
+
+	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), fi) +
+							dn->ofs_in_node;
+
+	if (f2fs_update_extent_tree(dn->inode, fofs, dn->data_blkaddr))
+		sync_inode_page(dn);
+}
+
+void init_extent_cache_info(struct f2fs_sb_info *sbi)
+{
+	INIT_RADIX_TREE(&sbi->extent_tree_root, GFP_NOIO);
+	init_rwsem(&sbi->extent_tree_lock);
+	INIT_LIST_HEAD(&sbi->extent_list);
+	spin_lock_init(&sbi->extent_lock);
+	sbi->total_ext_tree = 0;
+	atomic_set(&sbi->total_ext_node, 0);
+}
+
+int __init create_extent_cache(void)
+{
+	extent_tree_slab = f2fs_kmem_cache_create("f2fs_extent_tree",
+			sizeof(struct extent_tree));
+	if (!extent_tree_slab)
+		return -ENOMEM;
+	extent_node_slab = f2fs_kmem_cache_create("f2fs_extent_node",
+			sizeof(struct extent_node));
+	if (!extent_node_slab) {
+		kmem_cache_destroy(extent_tree_slab);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+void destroy_extent_cache(void)
+{
+	kmem_cache_destroy(extent_node_slab);
+	kmem_cache_destroy(extent_tree_slab);
+}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ee4c04a..7b22595 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1771,20 +1771,12 @@ void f2fs_submit_page_mbio(struct f2fs_io_info *);
 void set_data_blkaddr(struct dnode_of_data *);
 int reserve_new_block(struct dnode_of_data *);
 int f2fs_reserve_block(struct dnode_of_data *, pgoff_t);
-unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *, int);
-void f2fs_init_extent_tree(struct inode *, struct f2fs_extent *);
-void f2fs_destroy_extent_node(struct inode *);
-void f2fs_destroy_extent_tree(struct inode *);
-void f2fs_update_extent_cache(struct dnode_of_data *);
 struct page *get_read_data_page(struct inode *, pgoff_t, int);
 struct page *find_data_page(struct inode *, pgoff_t);
 struct page *get_lock_data_page(struct inode *, pgoff_t);
 struct page *get_new_data_page(struct inode *, struct page *, pgoff_t, bool);
 int do_write_data_page(struct f2fs_io_info *);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *, u64, u64);
-void init_extent_cache_info(struct f2fs_sb_info *);
-int __init create_extent_cache(void);
-void destroy_extent_cache(void);
 void f2fs_invalidate_page(struct page *, unsigned int, unsigned int);
 int f2fs_release_page(struct page *, gfp_t);
 
@@ -1982,6 +1974,20 @@ void f2fs_join_shrinker(struct f2fs_sb_info *);
 void f2fs_leave_shrinker(struct f2fs_sb_info *);
 
 /*
+ * extent_cache.c
+ */
+unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *, int);
+void __drop_largest_extent(struct inode *, pgoff_t);
+void f2fs_init_extent_tree(struct inode *, struct f2fs_extent *);
+void f2fs_destroy_extent_node(struct inode *);
+void f2fs_destroy_extent_tree(struct inode *);
+bool f2fs_lookup_extent_cache(struct inode *, pgoff_t, struct extent_info *);
+void f2fs_update_extent_cache(struct dnode_of_data *);
+void init_extent_cache_info(struct f2fs_sb_info *);
+int __init create_extent_cache(void);
+void destroy_extent_cache(void);
+
+/*
  * crypto support
  */
 static inline int f2fs_encrypted_inode(struct inode *inode)
-- 
2.4.2



------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
