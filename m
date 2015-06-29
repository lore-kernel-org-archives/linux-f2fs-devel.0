From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 12/12] f2fs: use extent_cache by default
Date: Mon, 29 Jun 2015 11:39:36 -0700
Message-ID: <1435603176-63219-12-git-send-email-jaegeuk@kernel.org>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Z9dyu-00032c-3q
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:40:36 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z9dys-0005Bo-2n for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:40:36 +0000
In-Reply-To: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

We don't need to handle the duplicate extent infot showrmation.

The integrated rule is:
 - update on-disk extent with largest one tracked by in-memory extent_cache
 - destroy extent_tree for the truncation case
 - drop per-inode extent_cache by shrinker

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c     | 349 ++++++++++++++++-------------------------------------
 fs/f2fs/f2fs.h     |  20 ++-
 fs/f2fs/inode.c    |  18 ++-
 fs/f2fs/namei.c    |   2 +
 fs/f2fs/shrinker.c |   2 +
 fs/f2fs/super.c    |   8 +-
 6 files changed, 136 insertions(+), 263 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 18bd0ac..e90522a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -266,103 +266,6 @@ int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
 	return err;
 }
 
-static bool lookup_extent_info(struct inode *inode, pgoff_t pgofs,
-							struct extent_info *ei)
-{
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-	pgoff_t start_fofs, end_fofs;
-	block_t start_blkaddr;
-
-	read_lock(&fi->ext_lock);
-	if (fi->ext.len == 0) {
-		read_unlock(&fi->ext_lock);
-		return false;
-	}
-
-	stat_inc_total_hit(inode->i_sb);
-
-	start_fofs = fi->ext.fofs;
-	end_fofs = fi->ext.fofs + fi->ext.len - 1;
-	start_blkaddr = fi->ext.blk;
-
-	if (pgofs >= start_fofs && pgofs <= end_fofs) {
-		*ei = fi->ext;
-		stat_inc_read_hit(inode->i_sb);
-		read_unlock(&fi->ext_lock);
-		return true;
-	}
-	read_unlock(&fi->ext_lock);
-	return false;
-}
-
-static bool update_extent_info(struct inode *inode, pgoff_t fofs,
-								block_t blkaddr)
-{
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-	pgoff_t start_fofs, end_fofs;
-	block_t start_blkaddr, end_blkaddr;
-	int need_update = true;
-
-	write_lock(&fi->ext_lock);
-
-	start_fofs = fi->ext.fofs;
-	end_fofs = fi->ext.fofs + fi->ext.len - 1;
-	start_blkaddr = fi->ext.blk;
-	end_blkaddr = fi->ext.blk + fi->ext.len - 1;
-
-	/* Drop and initialize the matched extent */
-	if (fi->ext.len == 1 && fofs == start_fofs)
-		fi->ext.len = 0;
-
-	/* Initial extent */
-	if (fi->ext.len == 0) {
-		if (blkaddr != NULL_ADDR) {
-			fi->ext.fofs = fofs;
-			fi->ext.blk = blkaddr;
-			fi->ext.len = 1;
-		}
-		goto end_update;
-	}
-
-	/* Front merge */
-	if (fofs == start_fofs - 1 && blkaddr == start_blkaddr - 1) {
-		fi->ext.fofs--;
-		fi->ext.blk--;
-		fi->ext.len++;
-		goto end_update;
-	}
-
-	/* Back merge */
-	if (fofs == end_fofs + 1 && blkaddr == end_blkaddr + 1) {
-		fi->ext.len++;
-		goto end_update;
-	}
-
-	/* Split the existing extent */
-	if (fi->ext.len > 1 &&
-		fofs >= start_fofs && fofs <= end_fofs) {
-		if ((end_fofs - fofs) < (fi->ext.len >> 1)) {
-			fi->ext.len = fofs - start_fofs;
-		} else {
-			fi->ext.fofs = fofs + 1;
-			fi->ext.blk = start_blkaddr + fofs - start_fofs + 1;
-			fi->ext.len -= fofs - start_fofs + 1;
-		}
-	} else {
-		need_update = false;
-	}
-
-	/* Finally, if the extent is very fragmented, let's drop the cache. */
-	if (fi->ext.len < F2FS_MIN_EXTENT_LEN) {
-		fi->ext.len = 0;
-		set_inode_flag(fi, FI_NO_EXTENT);
-		need_update = true;
-	}
-end_update:
-	write_unlock(&fi->ext_lock);
-	return need_update;
-}
-
 static struct extent_node *__attach_extent_node(struct f2fs_sb_info *sbi,
 				struct extent_tree *et, struct extent_info *ei,
 				struct rb_node *parent, struct rb_node **p)
@@ -394,23 +297,6 @@ static void __detach_extent_node(struct f2fs_sb_info *sbi,
 		et->cached_en = NULL;
 }
 
-static struct extent_tree *__find_extent_tree(struct f2fs_sb_info *sbi,
-							nid_t ino)
-{
-	struct extent_tree *et;
-
-	down_read(&sbi->extent_tree_lock);
-	et = radix_tree_lookup(&sbi->extent_tree_root, ino);
-	if (!et) {
-		up_read(&sbi->extent_tree_lock);
-		return NULL;
-	}
-	atomic_inc(&et->refcount);
-	up_read(&sbi->extent_tree_lock);
-
-	return et;
-}
-
 static struct extent_tree *__grab_extent_tree(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -434,6 +320,9 @@ static struct extent_tree *__grab_extent_tree(struct inode *inode)
 	atomic_inc(&et->refcount);
 	up_write(&sbi->extent_tree_lock);
 
+	/* never died untill evict_inode */
+	F2FS_I(inode)->extent_tree = et;
+
 	return et;
 }
 
@@ -522,7 +411,7 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
 				en->ei.len += ei->len;
 				if (den)
 					*den = __try_back_merge(sbi, et, en);
-				return en;
+				goto update_out;
 			}
 			p = &(*p)->rb_left;
 		} else if (ei->fofs >= en->ei.fofs + en->ei.len) {
@@ -530,7 +419,7 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
 				en->ei.len += ei->len;
 				if (den)
 					*den = __try_front_merge(sbi, et, en);
-				return en;
+				goto update_out;
 			}
 			p = &(*p)->rb_right;
 		} else {
@@ -538,7 +427,11 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
 		}
 	}
 
-	return __attach_extent_node(sbi, et, ei, parent, p);
+	en = __attach_extent_node(sbi, et, ei, parent, p);
+update_out:
+	if (en && en->ei.len > et->largest.len)
+		et->largest = en->ei;
+	return en;
 }
 
 static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
@@ -570,26 +463,36 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 	return count - et->count;
 }
 
-static void f2fs_init_extent_tree(struct inode *inode,
-						struct f2fs_extent *i_ext)
+static void __drop_largest_extent(struct inode *inode, pgoff_t fofs)
+{
+	struct extent_info *largest = &F2FS_I(inode)->extent_tree->largest;
+
+	if (largest->fofs <= fofs && largest->fofs + largest->len > fofs)
+		largest->len = 0;
+}
+
+void f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_tree *et;
 	struct extent_node *en;
 	struct extent_info ei;
 
-	if (le32_to_cpu(i_ext->len) < F2FS_MIN_EXTENT_LEN)
+	if (!f2fs_may_extent_tree(inode))
 		return;
 
 	et = __grab_extent_tree(inode);
 
-	write_lock(&et->lock);
-	if (et->count)
-		goto out;
+	if (!i_ext || le32_to_cpu(i_ext->len) < F2FS_MIN_EXTENT_LEN)
+		return;
 
 	set_extent_info(&ei, le32_to_cpu(i_ext->fofs),
 		le32_to_cpu(i_ext->blk), le32_to_cpu(i_ext->len));
 
+	write_lock(&et->lock);
+	if (et->count)
+		goto out;
+
 	en = __insert_extent_tree(sbi, et, &ei, NULL);
 	if (en) {
 		et->cached_en = en;
@@ -600,21 +503,18 @@ static void f2fs_init_extent_tree(struct inode *inode,
 	}
 out:
 	write_unlock(&et->lock);
-	atomic_dec(&et->refcount);
 }
 
 static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 							struct extent_info *ei)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_tree *et;
+	struct extent_tree *et = F2FS_I(inode)->extent_tree;
 	struct extent_node *en;
 
-	trace_f2fs_lookup_extent_tree_start(inode, pgofs);
+	f2fs_bug_on(sbi, !et);
 
-	et = __find_extent_tree(sbi, inode->i_ino);
-	if (!et)
-		return false;
+	trace_f2fs_lookup_extent_tree_start(inode, pgofs);
 
 	read_lock(&et->lock);
 	en = __lookup_extent_tree(et, pgofs);
@@ -631,27 +531,35 @@ static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 	read_unlock(&et->lock);
 
 	trace_f2fs_lookup_extent_tree_end(inode, pgofs, en);
-
-	atomic_dec(&et->refcount);
 	return en ? true : false;
 }
 
-static void f2fs_update_extent_tree(struct inode *inode, pgoff_t fofs,
+/* return true, if on-disk extent should be updated */
+static bool f2fs_update_extent_tree(struct inode *inode, pgoff_t fofs,
 							block_t blkaddr)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_tree *et;
+	struct extent_tree *et = F2FS_I(inode)->extent_tree;
 	struct extent_node *en = NULL, *en1 = NULL, *en2 = NULL, *en3 = NULL;
 	struct extent_node *den = NULL;
-	struct extent_info ei, dei;
+	struct extent_info ei, dei, prev;
 	unsigned int endofs;
 
-	trace_f2fs_update_extent_tree(inode, fofs, blkaddr);
+	if (!et)
+		return false;
 
-	et = __grab_extent_tree(inode);
+	trace_f2fs_update_extent_tree(inode, fofs, blkaddr);
 
 	write_lock(&et->lock);
 
+	if (is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT)) {
+		write_unlock(&et->lock);
+		return false;
+	}
+
+	prev = et->largest;
+	dei.len = 0;
+
 	/* 1. lookup and remove existing extent info in cache */
 	en = __lookup_extent_tree(et, fofs);
 	if (!en)
@@ -660,6 +568,8 @@ static void f2fs_update_extent_tree(struct inode *inode, pgoff_t fofs,
 	dei = en->ei;
 	__detach_extent_node(sbi, et, en);
 
+	__drop_largest_extent(inode, fofs);
+
 	/* 2. if extent can be split more, split and insert the left part */
 	if (dei.len > 1) {
 		/*  insert left part of split extent into cache */
@@ -683,6 +593,14 @@ update_extent:
 	if (blkaddr) {
 		set_extent_info(&ei, fofs, blkaddr, 1);
 		en3 = __insert_extent_tree(sbi, et, &ei, &den);
+
+		/* give up extent_cache, if split and small updates happen */
+		if (dei.len >= 1 &&
+				prev.len < F2FS_MIN_EXTENT_LEN &&
+				et->largest.len < F2FS_MIN_EXTENT_LEN) {
+			et->largest.len = 0;
+			set_inode_flag(F2FS_I(inode), FI_NO_EXTENT);
+		}
 	}
 
 	/* 4. update in global extent list */
@@ -714,57 +632,12 @@ update_extent:
 	if (den)
 		kmem_cache_free(extent_node_slab, den);
 
-	write_unlock(&et->lock);
-	atomic_dec(&et->refcount);
-}
-
-void f2fs_preserve_extent_tree(struct inode *inode)
-{
-	struct extent_tree *et;
-	struct extent_info *ext = &F2FS_I(inode)->ext;
-	bool sync = false;
-
-	if (!test_opt(F2FS_I_SB(inode), EXTENT_CACHE))
-		return;
-
-	et = __find_extent_tree(F2FS_I_SB(inode), inode->i_ino);
-	if (!et) {
-		if (ext->len) {
-			ext->len = 0;
-			update_inode_page(inode);
-		}
-		return;
-	}
-
-	read_lock(&et->lock);
-	if (et->count) {
-		struct extent_node *en;
-
-		if (et->cached_en) {
-			en = et->cached_en;
-		} else {
-			struct rb_node *node = rb_first(&et->root);
-
-			if (!node)
-				node = rb_last(&et->root);
-			en = rb_entry(node, struct extent_node, rb_node);
-		}
-
-		if (__is_extent_same(ext, &en->ei))
-			goto out;
+	if (is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT))
+		__free_extent_tree(sbi, et, true);
 
-		*ext = en->ei;
-		sync = true;
-	} else if (ext->len) {
-		ext->len = 0;
-		sync = true;
-	}
-out:
-	read_unlock(&et->lock);
-	atomic_dec(&et->refcount);
+	write_unlock(&et->lock);
 
-	if (sync)
-		update_inode_page(inode);
+	return !__is_extent_same(&prev, &et->largest);
 }
 
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
@@ -772,8 +645,7 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 	struct extent_tree *treevec[EXT_TREE_VEC_SIZE];
 	struct extent_node *en, *tmp;
 	unsigned long ino = F2FS_ROOT_INO(sbi);
-	struct radix_tree_iter iter;
-	void **slot;
+	struct radix_tree_root *root = &sbi->extent_tree_root;
 	unsigned int found;
 	unsigned int node_cnt = 0, tree_cnt = 0;
 
@@ -788,10 +660,10 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 	}
 	spin_unlock(&sbi->extent_lock);
 
-	if (!down_read_trylock(&sbi->extent_tree_lock))
+	if (!down_write_trylock(&sbi->extent_tree_lock))
 		goto out;
 
-	while ((found = radix_tree_gang_lookup(&sbi->extent_tree_root,
+	while ((found = radix_tree_gang_lookup(root,
 				(void **)treevec, ino, EXT_TREE_VEC_SIZE))) {
 		unsigned i;
 
@@ -799,27 +671,15 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 		for (i = 0; i < found; i++) {
 			struct extent_tree *et = treevec[i];
 
-			atomic_inc(&et->refcount);
 			write_lock(&et->lock);
 			node_cnt += __free_extent_tree(sbi, et, false);
 			write_unlock(&et->lock);
-			atomic_dec(&et->refcount);
-		}
-	}
-	up_read(&sbi->extent_tree_lock);
-
-	if (!down_write_trylock(&sbi->extent_tree_lock))
-		goto out;
-
-	radix_tree_for_each_slot(slot, &sbi->extent_tree_root, &iter,
-							F2FS_ROOT_INO(sbi)) {
-		struct extent_tree *et = (struct extent_tree *)*slot;
-
-		if (!atomic_read(&et->refcount) && !et->count) {
-			radix_tree_delete(&sbi->extent_tree_root, et->ino);
-			kmem_cache_free(extent_tree_slab, et);
-			sbi->total_ext_tree--;
-			tree_cnt++;
+			if (!atomic_read(&et->refcount) && !et->count) {
+				radix_tree_delete(root, et->ino);
+				kmem_cache_free(extent_tree_slab, et);
+				sbi->total_ext_tree--;
+				tree_cnt++;
+			}
 		}
 	}
 	up_write(&sbi->extent_tree_lock);
@@ -829,63 +689,59 @@ out:
 	return node_cnt + tree_cnt;
 }
 
-void f2fs_destroy_extent_tree(struct inode *inode)
+void f2fs_destroy_extent_node(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_tree *et;
+	struct extent_tree *et = F2FS_I(inode)->extent_tree;
 	unsigned int node_cnt = 0;
 
-	if (!test_opt(sbi, EXTENT_CACHE))
-		return;
-
-	et = __find_extent_tree(sbi, inode->i_ino);
 	if (!et)
-		goto out;
+		return;
 
-	/* free all extent info belong to this extent tree */
 	write_lock(&et->lock);
 	node_cnt = __free_extent_tree(sbi, et, true);
 	write_unlock(&et->lock);
+}
 
-	atomic_dec(&et->refcount);
+void f2fs_destroy_extent_tree(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct extent_tree *et = F2FS_I(inode)->extent_tree;
+	unsigned int node_cnt = 0;
 
-	/* try to find and delete extent tree entry in radix tree */
-	down_write(&sbi->extent_tree_lock);
-	et = radix_tree_lookup(&sbi->extent_tree_root, inode->i_ino);
-	if (!et) {
-		up_write(&sbi->extent_tree_lock);
-		goto out;
+	if (!et)
+		return;
+
+	if (inode->i_nlink && !is_bad_inode(inode) && et->count) {
+		atomic_dec(&et->refcount);
+		return;
 	}
+
+	/* free all extent info belong to this extent tree */
+	f2fs_destroy_extent_node(inode);
+
+	/* delete extent tree entry in radix tree */
+	down_write(&sbi->extent_tree_lock);
+	atomic_dec(&et->refcount);
 	f2fs_bug_on(sbi, atomic_read(&et->refcount) || et->count);
 	radix_tree_delete(&sbi->extent_tree_root, inode->i_ino);
 	kmem_cache_free(extent_tree_slab, et);
 	sbi->total_ext_tree--;
 	up_write(&sbi->extent_tree_lock);
-out:
-	trace_f2fs_destroy_extent_tree(inode, node_cnt);
-	return;
-}
 
-void f2fs_init_extent_cache(struct inode *inode, struct f2fs_extent *i_ext)
-{
-	if (test_opt(F2FS_I_SB(inode), EXTENT_CACHE))
-		f2fs_init_extent_tree(inode, i_ext);
+	F2FS_I(inode)->extent_tree = NULL;
 
-	write_lock(&F2FS_I(inode)->ext_lock);
-	get_extent_info(&F2FS_I(inode)->ext, *i_ext);
-	write_unlock(&F2FS_I(inode)->ext_lock);
+	trace_f2fs_destroy_extent_tree(inode, node_cnt);
+	return;
 }
 
 static bool f2fs_lookup_extent_cache(struct inode *inode, pgoff_t pgofs,
 							struct extent_info *ei)
 {
-	if (is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT))
+	if (!f2fs_may_extent_tree(inode))
 		return false;
 
-	if (test_opt(F2FS_I_SB(inode), EXTENT_CACHE))
-		return f2fs_lookup_extent_tree(inode, pgofs, ei);
-
-	return lookup_extent_info(inode, pgofs, ei);
+	return f2fs_lookup_extent_tree(inode, pgofs, ei);
 }
 
 void f2fs_update_extent_cache(struct dnode_of_data *dn)
@@ -893,19 +749,15 @@ void f2fs_update_extent_cache(struct dnode_of_data *dn)
 	struct f2fs_inode_info *fi = F2FS_I(dn->inode);
 	pgoff_t fofs;
 
-	f2fs_bug_on(F2FS_I_SB(dn->inode), dn->data_blkaddr == NEW_ADDR);
-
-	if (is_inode_flag_set(fi, FI_NO_EXTENT))
+	if (!f2fs_may_extent_tree(dn->inode))
 		return;
 
+	f2fs_bug_on(F2FS_I_SB(dn->inode), dn->data_blkaddr == NEW_ADDR);
+
 	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), fi) +
 							dn->ofs_in_node;
 
-	/* we should call update_extent_info() to update on-disk extent */
-	if (test_opt(F2FS_I_SB(dn->inode), EXTENT_CACHE))
-		f2fs_update_extent_tree(dn->inode, fofs, dn->data_blkaddr);
-
-	if (update_extent_info(dn->inode, fofs, dn->data_blkaddr))
+	if (f2fs_update_extent_tree(dn->inode, fofs, dn->data_blkaddr))
 		sync_inode_page(dn);
 }
 
@@ -1109,8 +961,6 @@ alloc:
 
 	allocate_data_block(sbi, NULL, dn->data_blkaddr, &dn->data_blkaddr,
 								&sum, seg);
-
-	/* direct IO doesn't use extent cache to maximize the performance */
 	set_data_blkaddr(dn);
 
 	/* update i_size */
@@ -1119,6 +969,9 @@ alloc:
 	if (i_size_read(dn->inode) < ((fofs + 1) << PAGE_CACHE_SHIFT))
 		i_size_write(dn->inode, ((fofs + 1) << PAGE_CACHE_SHIFT));
 
+	/* direct IO doesn't use extent cache to maximize the performance */
+	__drop_largest_extent(dn->inode, fofs);
+
 	return 0;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index eeef3eb..281343c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -349,6 +349,7 @@ struct extent_tree {
 	nid_t ino;			/* inode number */
 	struct rb_root root;		/* root of extent info rb-tree */
 	struct extent_node *cached_en;	/* recently accessed extent node */
+	struct extent_info largest;	/* largested extent info */
 	rwlock_t lock;			/* protect extent info rb-tree */
 	atomic_t refcount;		/* reference count of rb-tree */
 	unsigned int count;		/* # of extent node in rb-tree*/
@@ -420,14 +421,14 @@ struct f2fs_inode_info {
 	unsigned int clevel;		/* maximum level of given file name */
 	nid_t i_xattr_nid;		/* node id that contains xattrs */
 	unsigned long long xattr_ver;	/* cp version of xattr modification */
-	struct extent_info ext;		/* in-memory extent cache entry */
-	rwlock_t ext_lock;		/* rwlock for single extent cache */
 	struct inode_entry *dirty_dir;	/* the pointer of dirty dir */
 
 	struct radix_tree_root inmem_root;	/* radix tree for inmem pages */
 	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
 	struct mutex inmem_lock;	/* lock for inmemory pages */
 
+	struct extent_tree *extent_tree;	/* cached extent_tree entry */
+
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 	/* Encryption params */
 	struct f2fs_crypt_info *i_crypt_info;
@@ -1548,6 +1549,17 @@ static inline bool is_dot_dotdot(const struct qstr *str)
 	return false;
 }
 
+static inline bool f2fs_may_extent_tree(struct inode *inode)
+{
+	mode_t mode = inode->i_mode;
+
+	if (!test_opt(F2FS_I_SB(inode), EXTENT_CACHE) ||
+			is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT))
+		return false;
+
+	return S_ISREG(mode);
+}
+
 #define get_inode_mode(i) \
 	((is_inode_flag_set(F2FS_I(i), FI_ACL_MODE)) ? \
 	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
@@ -1755,10 +1767,10 @@ void set_data_blkaddr(struct dnode_of_data *);
 int reserve_new_block(struct dnode_of_data *);
 int f2fs_reserve_block(struct dnode_of_data *, pgoff_t);
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *, int);
+void f2fs_init_extent_tree(struct inode *, struct f2fs_extent *);
+void f2fs_destroy_extent_node(struct inode *);
 void f2fs_destroy_extent_tree(struct inode *);
-void f2fs_init_extent_cache(struct inode *, struct f2fs_extent *);
 void f2fs_update_extent_cache(struct dnode_of_data *);
-void f2fs_preserve_extent_tree(struct inode *);
 struct page *get_read_data_page(struct inode *, pgoff_t, int);
 struct page *find_data_page(struct inode *, pgoff_t);
 struct page *get_lock_data_page(struct inode *, pgoff_t);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 757fed2..978a726 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -139,7 +139,7 @@ static int do_read_inode(struct inode *inode)
 	fi->i_pino = le32_to_cpu(ri->i_pino);
 	fi->i_dir_level = ri->i_dir_level;
 
-	f2fs_init_extent_cache(inode, &ri->i_ext);
+	f2fs_init_extent_tree(inode, &ri->i_ext);
 
 	get_inline_info(fi, ri);
 
@@ -237,10 +237,11 @@ void update_inode(struct inode *inode, struct page *node_page)
 	ri->i_size = cpu_to_le64(i_size_read(inode));
 	ri->i_blocks = cpu_to_le64(inode->i_blocks);
 
-	read_lock(&F2FS_I(inode)->ext_lock);
-	set_raw_extent(&F2FS_I(inode)->ext, &ri->i_ext);
-	read_unlock(&F2FS_I(inode)->ext_lock);
-
+	if (F2FS_I(inode)->extent_tree)
+		set_raw_extent(&F2FS_I(inode)->extent_tree->largest,
+							&ri->i_ext);
+	else
+		memset(&ri->i_ext, 0, sizeof(ri->i_ext));
 	set_raw_inline(F2FS_I(inode), ri);
 
 	ri->i_atime = cpu_to_le64(inode->i_atime.tv_sec);
@@ -331,6 +332,8 @@ void f2fs_evict_inode(struct inode *inode)
 	f2fs_bug_on(sbi, get_dirty_pages(inode));
 	remove_dirty_dir_inode(inode);
 
+	f2fs_destroy_extent_tree(inode);
+
 	if (inode->i_nlink || is_bad_inode(inode))
 		goto no_delete;
 
@@ -350,11 +353,6 @@ no_delete:
 	stat_dec_inline_dir(inode);
 	stat_dec_inline_inode(inode);
 
-	/* update extent info in inode */
-	if (inode->i_nlink)
-		f2fs_preserve_extent_tree(inode);
-	f2fs_destroy_extent_tree(inode);
-
 	invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino, inode->i_ino);
 	if (xnid)
 		invalidate_mapping_pages(NODE_MAPPING(sbi), xnid, xnid);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 08656fc..df315dc 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -65,6 +65,8 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	if (f2fs_may_inline_dentry(inode))
 		set_inode_flag(F2FS_I(inode), FI_INLINE_DENTRY);
 
+	f2fs_init_extent_tree(inode, NULL);
+
 	stat_inc_inline_inode(inode);
 	stat_inc_inline_dir(inode);
 
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index a7d7a7c..2dfb08d 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -117,6 +117,8 @@ void f2fs_join_shrinker(struct f2fs_sb_info *sbi)
 
 void f2fs_leave_shrinker(struct f2fs_sb_info *sbi)
 {
+	f2fs_shrink_extent_tree(sbi, __count_extent_cache(sbi));
+
 	spin_lock(&f2fs_list_lock);
 	list_del(&sbi->s_list);
 	spin_unlock(&f2fs_list_lock);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a9db896..31ac3c7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -422,7 +422,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	atomic_set(&fi->dirty_pages, 0);
 	fi->i_current_depth = 1;
 	fi->i_advise = 0;
-	rwlock_init(&fi->ext_lock);
 	init_rwsem(&fi->i_sem);
 	INIT_RADIX_TREE(&fi->inmem_root, GFP_NOFS);
 	INIT_LIST_HEAD(&fi->inmem_pages);
@@ -453,12 +452,17 @@ static int f2fs_drop_inode(struct inode *inode)
 	 */
 	if (!inode_unhashed(inode) && inode->i_state & I_SYNC) {
 		if (!inode->i_nlink && !is_bad_inode(inode)) {
+			/* to avoid evict_inode call simultaneously */
+			atomic_inc(&inode->i_count);
 			spin_unlock(&inode->i_lock);
 
 			/* some remained atomic pages should discarded */
 			if (f2fs_is_atomic_file(inode))
 				commit_inmem_pages(inode, true);
 
+			/* should remain fi->extent_tree for writepage */
+			f2fs_destroy_extent_node(inode);
+
 			sb_start_intwrite(inode->i_sb);
 			i_size_write(inode, 0);
 
@@ -473,6 +477,7 @@ static int f2fs_drop_inode(struct inode *inode)
 					F2FS_I(inode)->i_crypt_info);
 #endif
 			spin_lock(&inode->i_lock);
+			atomic_dec(&inode->i_count);
 		}
 		return 0;
 	}
@@ -719,6 +724,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 
 	set_opt(sbi, BG_GC);
 	set_opt(sbi, INLINE_DATA);
+	set_opt(sbi, EXTENT_CACHE);
 
 #ifdef CONFIG_F2FS_FS_XATTR
 	set_opt(sbi, XATTR_USER);
-- 
2.1.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
