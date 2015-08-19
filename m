From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 9/9] f2fs: update extent tree in batches
Date: Wed, 19 Aug 2015 19:21:48 +0800
Message-ID: <017d01d0da71$5780e8d0$0682ba70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZS1S7-0005h5-5o
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Aug 2015 11:22:43 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZS1S3-0002VE-Ds
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Aug 2015 11:22:43 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NTB0072AU9K6530@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Aug 2015 20:22:32 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch introduce a new helper f2fs_update_extent_tree_range
which can update extent nodes in extent tree in batches.

Now, we use the function to invalidate blocks in batches instead of
invalidating them one by one when truncating blocks.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/extent_cache.c | 217 +++++++++++++++++++++++++++++++++++--------------
 fs/f2fs/f2fs.h         |   2 +
 fs/f2fs/file.c         |  12 ++-
 3 files changed, 170 insertions(+), 61 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index dcfeb43..e6b2457 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -386,23 +386,21 @@ do_insert:
 	return en;
 }
 
-/* return true, if on-disk extent should be updated */
-static bool f2fs_update_extent_tree(struct inode *inode, pgoff_t fofs,
-							block_t blkaddr)
+unsigned int f2fs_update_extent_tree_range(struct inode *inode,
+				pgoff_t fofs, block_t blkaddr, unsigned int len)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_tree *et = F2FS_I(inode)->extent_tree;
 	struct extent_node *en = NULL, *en1 = NULL, *en2 = NULL, *en3 = NULL;
-	struct extent_node *den = NULL, *prev_ex = NULL, *next_ex = NULL;
+	struct extent_node *prev_en = NULL, *next_en = NULL;
 	struct extent_info ei, dei, prev;
 	struct rb_node **insert_p = NULL, *insert_parent = NULL;
-	unsigned int endofs;
+	unsigned int end = fofs + len;
+	unsigned int pos = (unsigned int)fofs;
 
 	if (!et)
 		return false;
 
-	trace_f2fs_update_extent_tree(inode, fofs, blkaddr);
-
 	write_lock(&et->lock);
 
 	if (is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT)) {
@@ -416,39 +414,143 @@ static bool f2fs_update_extent_tree(struct inode *inode, pgoff_t fofs,
 	/* we do not guarantee that the largest extent is cached all the time */
 	f2fs_drop_largest_extent(inode, fofs);
 
-	/* 1. lookup and remove existing extent info in cache */
-	en = __lookup_extent_tree_ret(et, fofs, &prev_ex, &next_ex,
+	/* 1. lookup first extent node in range [fofs, fofs + len - 1] */
+	en = __lookup_extent_tree_ret(et, fofs, &prev_en, &next_en,
 					&insert_p, &insert_parent);
-	if (!en)
-		goto update_extent;
-
-	dei = en->ei;
-	__detach_extent_node(sbi, et, en);
-
-	/* 2. if extent can be split, try to split it */
-	if (dei.len > F2FS_MIN_EXTENT_LEN) {
-		/*  insert left part of split extent into cache */
-		if (fofs - dei.fofs >= F2FS_MIN_EXTENT_LEN) {
-			set_extent_info(&ei, dei.fofs, dei.blk,
-						fofs - dei.fofs);
-			en1 = __insert_extent_tree(sbi, et, &ei, NULL, NULL);
+	if (!en) {
+		if (next_en) {
+			en = next_en;
+			f2fs_bug_on(sbi, en->ei.fofs <= pos);
+			pos = en->ei.fofs;
+		} else {
+			/*
+			 * skip searching in the tree since there is no
+			 * larger extent node in the cache.
+			 */
+			goto update_extent;
+		}
+	}
+
+	/* 2. invlidate all extent nodes in range [fofs, fofs + len - 1] */
+	while (en) {
+		struct rb_node *node;
+
+		if (pos >= end)
+			break;
+
+		dei = en->ei;
+		en1 = en2 = NULL;
+
+		node = rb_next(&en->rb_node);
+
+		/*
+		 * 2.1 there are four cases when we invalidate blkaddr in extent
+		 * node, |V: valid address, X: will be invalidated|
+		 */
+		/* case#1, invalidate right part of extent node |VVVVVXXXXX| */
+		if (pos > dei.fofs && end >= dei.fofs + dei.len) {
+			en->ei.len = pos - dei.fofs;
+
+			if (en->ei.len < F2FS_MIN_EXTENT_LEN) {
+				__detach_extent_node(sbi, et, en);
+				insert_p = NULL;
+				insert_parent = NULL;
+				goto update;
+			}
+
+			if (__is_extent_same(&dei, &et->largest))
+				et->largest = en->ei;
+			goto next;
+		}
+
+		/* case#2, invalidate left part of extent node |XXXXXVVVVV| */
+		if (pos <= dei.fofs && end < dei.fofs + dei.len) {
+			en->ei.fofs = end;
+			en->ei.blk += end - dei.fofs;
+			en->ei.len -= end - dei.fofs;
+
+			if (en->ei.len < F2FS_MIN_EXTENT_LEN) {
+				__detach_extent_node(sbi, et, en);
+				insert_p = NULL;
+				insert_parent = NULL;
+				goto update;
+			}
+
+			if (__is_extent_same(&dei, &et->largest))
+				et->largest = en->ei;
+			goto next;
 		}
 
-		/* insert right part of split extent into cache */
-		endofs = dei.fofs + dei.len - 1;
-		if (endofs - fofs >= F2FS_MIN_EXTENT_LEN) {
-			set_extent_info(&ei, fofs + 1,
-				fofs - dei.fofs + dei.blk + 1, endofs - fofs);
-			en2 = __insert_extent_tree(sbi, et, &ei, NULL, NULL);
+		__detach_extent_node(sbi, et, en);
+
+		/*
+		 * if we remove node in rb-tree, our parent node pointer may
+		 * point the wrong place, discard them.
+		 */
+		insert_p = NULL;
+		insert_parent = NULL;
+
+		/* case#3, invalidate entire extent node |XXXXXXXXXX| */
+		if (pos <= dei.fofs && end >= dei.fofs + dei.len) {
+			if (__is_extent_same(&dei, &et->largest))
+				et->largest.len = 0;
+			goto update;
+		}
+
+		/*
+		 * case#4, invalidate data in the middle of extent node
+		 * |VVVXXXXVVV|
+		 */
+		if (dei.len > F2FS_MIN_EXTENT_LEN) {
+			unsigned int endofs;
+
+			/*  insert left part of split extent into cache */
+			if (pos - dei.fofs >= F2FS_MIN_EXTENT_LEN) {
+				set_extent_info(&ei, dei.fofs, dei.blk,
+							pos - dei.fofs);
+				en1 = __insert_extent_tree(sbi, et, &ei,
+								NULL, NULL);
+			}
+
+			/* insert right part of split extent into cache */
+			endofs = dei.fofs + dei.len;
+			if (endofs - end >= F2FS_MIN_EXTENT_LEN) {
+				set_extent_info(&ei, end,
+						end - dei.fofs + dei.blk,
+						endofs - end);
+				en2 = __insert_extent_tree(sbi, et, &ei,
+								NULL, NULL);
+			}
 		}
+update:
+		/* 2.2 update in global extent list */
+		spin_lock(&sbi->extent_lock);
+		if (en && !list_empty(&en->list))
+			list_del(&en->list);
+		if (en1)
+			list_add_tail(&en1->list, &sbi->extent_list);
+		if (en2)
+			list_add_tail(&en2->list, &sbi->extent_list);
+		spin_unlock(&sbi->extent_lock);
+
+		/* 2.3 release extent node */
+		if (en)
+			kmem_cache_free(extent_node_slab, en);
+next:
+		en = node ? rb_entry(node, struct extent_node, rb_node) : NULL;
+		next_en = en;
+		if (en)
+			pos = en->ei.fofs;
 	}
 
 update_extent:
 	/* 3. update extent in extent cache */
 	if (blkaddr) {
-		set_extent_info(&ei, fofs, blkaddr, 1);
+		struct extent_node *den = NULL;
+
+		set_extent_info(&ei, fofs, blkaddr, len);
 		en3 = __try_merge_extent_node(sbi, et, &ei, &den,
-						prev_ex, next_ex);
+							prev_en, next_en);
 		if (!en3)
 			en3 = __insert_extent_tree(sbi, et, &ei,
 						insert_p, insert_parent);
@@ -460,36 +562,21 @@ update_extent:
 			et->largest.len = 0;
 			set_inode_flag(F2FS_I(inode), FI_NO_EXTENT);
 		}
-	}
 
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
+		spin_lock(&sbi->extent_lock);
+		if (en3) {
+			if (list_empty(&en3->list))
+				list_add_tail(&en3->list, &sbi->extent_list);
+			else
+				list_move_tail(&en3->list, &sbi->extent_list);
+		}
+		if (den && !list_empty(&den->list))
+			list_del(&den->list);
+		spin_unlock(&sbi->extent_lock);
 
-	/* 5. release extent node */
-	if (en)
-		kmem_cache_free(extent_node_slab, en);
-	if (den)
-		kmem_cache_free(extent_node_slab, den);
+		if (den)
+			kmem_cache_free(extent_node_slab, den);
+	}
 
 	if (is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT))
 		__free_extent_tree(sbi, et, true);
@@ -645,10 +732,22 @@ void f2fs_update_extent_cache(struct dnode_of_data *dn)
 
 	f2fs_bug_on(F2FS_I_SB(dn->inode), dn->data_blkaddr == NEW_ADDR);
 
+
 	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), fi) +
 							dn->ofs_in_node;
 
-	if (f2fs_update_extent_tree(dn->inode, fofs, dn->data_blkaddr))
+	if (f2fs_update_extent_tree_range(dn->inode, fofs, dn->data_blkaddr, 1))
+		sync_inode_page(dn);
+}
+
+void f2fs_update_extent_cache_range(struct dnode_of_data *dn,
+				pgoff_t fofs, block_t blkaddr, unsigned int len)
+
+{
+	if (!f2fs_may_extent_tree(dn->inode))
+		return;
+
+	if (f2fs_update_extent_tree_range(dn->inode, fofs, blkaddr, len))
 		sync_inode_page(dn);
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 68c5acd..a2ac8d7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2038,6 +2038,8 @@ unsigned int f2fs_destroy_extent_node(struct inode *);
 void f2fs_destroy_extent_tree(struct inode *);
 bool f2fs_lookup_extent_cache(struct inode *, pgoff_t, struct extent_info *);
 void f2fs_update_extent_cache(struct dnode_of_data *);
+void f2fs_update_extent_cache_range(struct dnode_of_data *dn,
+						pgoff_t, block_t, unsigned int);
 void init_extent_cache_info(struct f2fs_sb_info *);
 int __init create_extent_cache(void);
 void destroy_extent_cache(void);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7faafb5..d280d23 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -445,9 +445,9 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 
 int truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 {
-	int nr_free = 0, ofs = dn->ofs_in_node;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct f2fs_node *raw_node;
+	int nr_free = 0, ofs = dn->ofs_in_node, len = count;
 	__le32 *addr;
 
 	raw_node = F2FS_NODE(dn->node_page);
@@ -460,14 +460,22 @@ int truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 
 		dn->data_blkaddr = NULL_ADDR;
 		set_data_blkaddr(dn);
-		f2fs_update_extent_cache(dn);
 		invalidate_blocks(sbi, blkaddr);
 		if (dn->ofs_in_node == 0 && IS_INODE(dn->node_page))
 			clear_inode_flag(F2FS_I(dn->inode),
 						FI_FIRST_BLOCK_WRITTEN);
 		nr_free++;
 	}
+
 	if (nr_free) {
+		pgoff_t fofs;
+		/*
+		 * once we invalidate valid blkaddr in range [ofs, ofs + count],
+		 * we will invalidate all blkaddr in the whole range.
+		 */
+		fofs = start_bidx_of_node(ofs_of_node(dn->node_page),
+						F2FS_I(dn->inode)) + ofs;
+		f2fs_update_extent_cache_range(dn, fofs, 0, len);
 		dec_valid_block_count(sbi, dn->inode, nr_free);
 		set_page_dirty(dn->node_page);
 		sync_inode_page(dn);
-- 
2.4.2



------------------------------------------------------------------------------
