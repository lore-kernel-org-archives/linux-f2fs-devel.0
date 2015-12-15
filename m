From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/8] f2fs: introduce dirty list node in inode info
Date: Tue, 15 Dec 2015 13:30:45 +0800
Message-ID: <00f501d136f9$d73c60b0$85b52210$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Add a new dirt list node member in inode info for linking the inode to
global dirty list in superblock, instead of old implementation which
allocate slab cache memory as an entry to inode.

It avoids memory pressure due to slab cache allocation, and also makes
codes more clean.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 54 +++++++++++++++++-----------------------------------
 fs/f2fs/debug.c      |  1 -
 fs/f2fs/f2fs.h       | 10 ++--------
 fs/f2fs/super.c      |  1 +
 4 files changed, 20 insertions(+), 46 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index b839f5f..1aca402 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -722,25 +722,23 @@ fail_no_cp:
 	return -EINVAL;
 }
 
-static int __add_dirty_inode(struct inode *inode, struct inode_entry *new)
+static void __add_dirty_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
 
-	if (is_inode_flag_set(F2FS_I(inode), FI_DIRTY_DIR))
-		return -EEXIST;
+	if (is_inode_flag_set(fi, FI_DIRTY_DIR))
+		return;
 
-	set_inode_flag(F2FS_I(inode), FI_DIRTY_DIR);
-	F2FS_I(inode)->dirty_dir = new;
-	list_add_tail(&new->list, &sbi->dir_inode_list);
+	set_inode_flag(fi, FI_DIRTY_DIR);
+	list_add_tail(&fi->dirty_list, &sbi->dir_inode_list);
 	stat_inc_dirty_dir(sbi);
-	return 0;
+	return;
 }
 
 void update_dirty_page(struct inode *inode, struct page *page)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct inode_entry *new;
-	int ret = 0;
 
 	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
 			!S_ISLNK(inode->i_mode))
@@ -751,17 +749,11 @@ void update_dirty_page(struct inode *inode, struct page *page)
 		goto out;
 	}
 
-	new = f2fs_kmem_cache_alloc(inode_entry_slab, GFP_NOFS);
-	new->inode = inode;
-	INIT_LIST_HEAD(&new->list);
-
 	spin_lock(&sbi->dir_inode_lock);
-	ret = __add_dirty_inode(inode, new);
+	__add_dirty_inode(inode);
 	inode_inc_dirty_pages(inode);
 	spin_unlock(&sbi->dir_inode_lock);
 
-	if (ret)
-		kmem_cache_free(inode_entry_slab, new);
 out:
 	SetPagePrivate(page);
 	f2fs_trace_pid(page);
@@ -770,25 +762,16 @@ out:
 void add_dirty_dir_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct inode_entry *new =
-			f2fs_kmem_cache_alloc(inode_entry_slab, GFP_NOFS);
-	int ret = 0;
-
-	new->inode = inode;
-	INIT_LIST_HEAD(&new->list);
 
 	spin_lock(&sbi->dir_inode_lock);
-	ret = __add_dirty_inode(inode, new);
+	__add_dirty_inode(inode);
 	spin_unlock(&sbi->dir_inode_lock);
-
-	if (ret)
-		kmem_cache_free(inode_entry_slab, new);
 }
 
 void remove_dirty_dir_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct inode_entry *entry;
+	struct f2fs_inode_info *fi = F2FS_I(inode);
 
 	if (!S_ISDIR(inode->i_mode))
 		return;
@@ -800,17 +783,14 @@ void remove_dirty_dir_inode(struct inode *inode)
 		return;
 	}
 
-	entry = F2FS_I(inode)->dirty_dir;
-	list_del(&entry->list);
-	F2FS_I(inode)->dirty_dir = NULL;
-	clear_inode_flag(F2FS_I(inode), FI_DIRTY_DIR);
+	list_del_init(&fi->dirty_list);
+	clear_inode_flag(fi, FI_DIRTY_DIR);
 	stat_dec_dirty_dir(sbi);
 	spin_unlock(&sbi->dir_inode_lock);
-	kmem_cache_free(inode_entry_slab, entry);
 
 	/* Only from the recovery routine */
-	if (is_inode_flag_set(F2FS_I(inode), FI_DELAY_IPUT)) {
-		clear_inode_flag(F2FS_I(inode), FI_DELAY_IPUT);
+	if (is_inode_flag_set(fi, FI_DELAY_IPUT)) {
+		clear_inode_flag(fi, FI_DELAY_IPUT);
 		iput(inode);
 	}
 }
@@ -818,8 +798,8 @@ void remove_dirty_dir_inode(struct inode *inode)
 void sync_dirty_dir_inodes(struct f2fs_sb_info *sbi)
 {
 	struct list_head *head;
-	struct inode_entry *entry;
 	struct inode *inode;
+	struct f2fs_inode_info *fi;
 retry:
 	if (unlikely(f2fs_cp_error(sbi)))
 		return;
@@ -831,8 +811,8 @@ retry:
 		spin_unlock(&sbi->dir_inode_lock);
 		return;
 	}
-	entry = list_entry(head->next, struct inode_entry, list);
-	inode = igrab(entry->inode);
+	fi = list_entry(head->next, struct f2fs_inode_info, dirty_list);
+	inode = igrab(&fi->vfs_inode);
 	spin_unlock(&sbi->dir_inode_lock);
 	if (inode) {
 		filemap_fdatawrite(inode->i_mapping);
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 8ce2fe3..f4a7b9e 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -189,7 +189,6 @@ get_cache:
 	si->cache_mem += NM_I(sbi)->dirty_nat_cnt *
 					sizeof(struct nat_entry_set);
 	si->cache_mem += si->inmem_pages * sizeof(struct inmem_pages);
-	si->cache_mem += sbi->n_dirty_dirs * sizeof(struct inode_entry);
 	for (i = 0; i <= UPDATE_INO; i++)
 		si->cache_mem += sbi->im[i].ino_num * sizeof(struct ino_entry);
 	si->cache_mem += sbi->total_ext_tree * sizeof(struct extent_tree);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4be54e6..aea5620 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -158,13 +158,7 @@ struct ino_entry {
 	nid_t ino;		/* inode number */
 };
 
-/*
- * for the list of directory inodes or gc inodes.
- * NOTE: there are two slab users for this structure, if we add/modify/delete
- * fields in structure for one of slab users, it may affect fields or size of
- * other one, in this condition, it's better to split both of slab and related
- * data structure.
- */
+/* for the list of inodes to be GCed */
 struct inode_entry {
 	struct list_head list;	/* list head */
 	struct inode *inode;	/* vfs inode pointer */
@@ -441,8 +435,8 @@ struct f2fs_inode_info {
 	unsigned int clevel;		/* maximum level of given file name */
 	nid_t i_xattr_nid;		/* node id that contains xattrs */
 	unsigned long long xattr_ver;	/* cp version of xattr modification */
-	struct inode_entry *dirty_dir;	/* the pointer of dirty dir */
 
+	struct list_head dirty_list;	/* linked in global dirty list */
 	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
 	struct mutex inmem_lock;	/* lock for inmemory pages */
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f7e9384..b6c1ac9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -437,6 +437,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	fi->i_current_depth = 1;
 	fi->i_advise = 0;
 	init_rwsem(&fi->i_sem);
+	INIT_LIST_HEAD(&fi->dirty_list);
 	INIT_LIST_HEAD(&fi->inmem_pages);
 	mutex_init(&fi->inmem_lock);
 
-- 
2.6.3
