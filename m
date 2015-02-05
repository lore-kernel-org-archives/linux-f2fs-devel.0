From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v3 08/10] f2fs: enable rb-tree extent cache
Date: Thu, 05 Feb 2015 17:57:31 +0800
Message-ID: <000501d0412a$43487bc0$c9d97340$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch enables rb-tree based extent cache in f2fs.

When we mount with "-o extent_cache", f2fs will try to add recently accessed
page-block mappings into rb-tree based extent cache as much as possible, instead
of original one extent info cache.

By this way, f2fs can support more effective cache between dnode page cache and
disk. It will supply high hit ratio in the cache with fewer memory when dnode
page cache are reclaimed in environment of low memory.

Storage: Sandisk sd card 64g
1.append write file (offset: 0, size: 128M);
2.override write file (offset: 2M, size: 1M);
3.override write file (offset: 4M, size: 1M);
...
4.override write file (offset: 48M, size: 1M);
...
5.override write file (offset: 112M, size: 1M);
6.sync
7.echo 3 > /proc/sys/vm/drop_caches
8.read file (size:128M, unit: 4k, count: 32768)
(time dd if=/mnt/f2fs/128m bs=4k count=32768)

Extent Hit Ratio:
		before		patched
Hit Ratio	121 / 1071	1071 / 1071

Performance:
		before		patched
real    	0m37.051s	0m35.556s
user    	0m0.040s	0m0.026s
sys     	0m2.990s	0m2.251s

Memory Cost:
		before		patched
Tree Count:	0		1 (size: 24 bytes)
Node Count:	0		45 (size: 1440 bytes)

v3:
 o retest and given more details of test result.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c    | 13 +++++++++++++
 fs/f2fs/f2fs.h    |  5 +++++
 fs/f2fs/inode.c   |  1 +
 fs/f2fs/segment.c |  3 +++
 fs/f2fs/super.c   |  9 ++++++++-
 5 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4b240fb..6c8119a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -666,6 +666,9 @@ void f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 	void **slot;
 	unsigned int found;
 
+	if (!test_opt(sbi, EXTENT_CACHE))
+		return;
+
 	if (available_free_memory(sbi, EXTENT_CACHE))
 		return;
 
@@ -714,6 +717,9 @@ void f2fs_destroy_extent_tree(struct inode *inode)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_tree *et;
 
+	if (!test_opt(sbi, EXTENT_CACHE))
+		return;
+
 	down_read(&sbi->extent_tree_lock);
 	et = radix_tree_lookup(&sbi->extent_tree_root, inode->i_ino);
 	if (!et) {
@@ -749,6 +755,9 @@ out:
 static bool f2fs_lookup_extent_cache(struct inode *inode, pgoff_t pgofs,
 							struct extent_info *ei)
 {
+	if (test_opt(F2FS_I_SB(inode), EXTENT_CACHE))
+		return f2fs_lookup_extent_tree(inode, pgofs, ei);
+
 	return lookup_extent_info(inode, pgofs, ei);
 }
 
@@ -765,6 +774,10 @@ void f2fs_update_extent_cache(struct dnode_of_data *dn)
 	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), fi) +
 							dn->ofs_in_node;
 
+	if (test_opt(F2FS_I_SB(dn->inode), EXTENT_CACHE))
+		return f2fs_update_extent_tree(dn->inode, fofs,
+							dn->data_blkaddr);
+
 	if (update_extent_info(dn->inode, fofs, dn->data_blkaddr))
 		sync_inode_page(dn);
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 507e604..73ca511 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1568,12 +1568,17 @@ void f2fs_submit_page_mbio(struct f2fs_sb_info *, struct page *,
 						struct f2fs_io_info *);
 int reserve_new_block(struct dnode_of_data *);
 int f2fs_reserve_block(struct dnode_of_data *, pgoff_t);
+void f2fs_shrink_extent_tree(struct f2fs_sb_info *, int);
+void f2fs_destroy_extent_tree(struct inode *);
 void f2fs_update_extent_cache(struct dnode_of_data *);
 struct page *find_data_page(struct inode *, pgoff_t, bool);
 struct page *get_lock_data_page(struct inode *, pgoff_t);
 struct page *get_new_data_page(struct inode *, struct page *, pgoff_t, bool);
 int do_write_data_page(struct page *, struct f2fs_io_info *);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *, u64, u64);
+void init_extent_cache_info(struct f2fs_sb_info *);
+int __init create_extent_cache(void);
+void destroy_extent_cache(void);
 
 /*
  * gc.c
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 28dd26a..b508744 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -335,6 +335,7 @@ void f2fs_evict_inode(struct inode *inode)
 no_delete:
 	stat_dec_inline_dir(inode);
 	stat_dec_inline_inode(inode);
+	f2fs_destroy_extent_tree(inode);
 	invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino, inode->i_ino);
 	if (xnid)
 		invalidate_mapping_pages(NODE_MAPPING(sbi), xnid, xnid);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b85bb97..f3f2d6f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -277,6 +277,9 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi)
 
 void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 {
+	/* try to shrink extent cache when there is no enough memory */
+	f2fs_shrink_extent_tree(sbi, EXTENT_CACHE_SHRINK_NUMBER);
+
 	/* check the # of cached NAT entries and prefree segments */
 	if (try_to_free_nats(sbi, NAT_ENTRY_PER_BLOCK) ||
 			excess_prefree_segs(sbi) ||
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 07a5564..3aaf2b5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1077,6 +1077,8 @@ try_onemore:
 	INIT_LIST_HEAD(&sbi->dir_inode_list);
 	spin_lock_init(&sbi->dir_inode_lock);
 
+	init_extent_cache_info(sbi);
+
 	init_ino_entry_info(sbi);
 
 	/* setup f2fs internal modules */
@@ -1283,10 +1285,13 @@ static int __init init_f2fs_fs(void)
 	err = create_checkpoint_caches();
 	if (err)
 		goto free_segment_manager_caches;
+	err = create_extent_cache();
+	if (err)
+		goto free_checkpoint_caches;
 	f2fs_kset = kset_create_and_add("f2fs", NULL, fs_kobj);
 	if (!f2fs_kset) {
 		err = -ENOMEM;
-		goto free_checkpoint_caches;
+		goto free_extent_cache;
 	}
 	err = register_filesystem(&f2fs_fs_type);
 	if (err)
@@ -1297,6 +1302,8 @@ static int __init init_f2fs_fs(void)
 
 free_kset:
 	kset_unregister(f2fs_kset);
+free_extent_cache:
+	destroy_extent_cache();
 free_checkpoint_caches:
 	destroy_checkpoint_caches();
 free_segment_manager_caches:
-- 
2.2.1
