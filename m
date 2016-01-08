From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: clean up f2fs_balance_fs
Date: Thu,  7 Jan 2016 17:36:36 -0800
Message-ID: <1452216996-9689-3-git-send-email-jaegeuk@kernel.org>
References: <1452216996-9689-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452216996-9689-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds one parameter to clean up all the callers of f2fs_balance_fs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c    | 17 ++++++-----------
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/file.c    | 17 ++++++++---------
 fs/f2fs/inline.c  |  3 +--
 fs/f2fs/inode.c   |  2 +-
 fs/f2fs/namei.c   | 22 +++++++++++-----------
 fs/f2fs/segment.c |  6 ++++--
 fs/f2fs/xattr.c   |  2 +-
 8 files changed, 33 insertions(+), 38 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3cf86fd..6fae75d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -546,8 +546,7 @@ static int __allocate_data_blocks(struct inode *inode, loff_t offset,
 		f2fs_put_dnode(&dn);
 		f2fs_unlock_op(sbi);
 
-		if (dn.node_changed)
-			f2fs_balance_fs(sbi);
+		f2fs_balance_fs(sbi, dn.node_changed);
 	}
 	return err;
 
@@ -557,8 +556,7 @@ sync_out:
 	f2fs_put_dnode(&dn);
 out:
 	f2fs_unlock_op(sbi);
-	if (dn.node_changed)
-		f2fs_balance_fs(sbi);
+	f2fs_balance_fs(sbi, dn.node_changed);
 	return err;
 }
 
@@ -657,8 +655,7 @@ get_next:
 
 		if (create) {
 			f2fs_unlock_op(sbi);
-			if (dn.node_changed)
-				f2fs_balance_fs(sbi);
+			f2fs_balance_fs(sbi, dn.node_changed);
 			f2fs_lock_op(sbi);
 		}
 
@@ -718,8 +715,7 @@ put_out:
 unlock_out:
 	if (create) {
 		f2fs_unlock_op(sbi);
-		if (dn.node_changed)
-			f2fs_balance_fs(sbi);
+		f2fs_balance_fs(sbi, dn.node_changed);
 	}
 out:
 	trace_f2fs_map_blocks(inode, map, err);
@@ -1178,8 +1174,7 @@ out:
 	if (err)
 		ClearPageUptodate(page);
 	unlock_page(page);
-	if (need_balance_fs)
-		f2fs_balance_fs(sbi);
+	f2fs_balance_fs(sbi, need_balance_fs);
 	if (wbc->for_reclaim || unlikely(f2fs_cp_error(sbi))) {
 		f2fs_submit_merged_bio(sbi, DATA, WRITE);
 		remove_dirty_inode(inode);
@@ -1506,7 +1501,7 @@ repeat:
 
 	if (need_balance && has_not_enough_free_secs(sbi, 0)) {
 		unlock_page(page);
-		f2fs_balance_fs(sbi);
+		f2fs_balance_fs(sbi, true);
 		lock_page(page);
 		if (page->mapping != mapping) {
 			/* The page got truncated from under us */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 461b329..4128654 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1780,7 +1780,7 @@ void destroy_node_manager_caches(void);
  */
 void register_inmem_page(struct inode *, struct page *);
 int commit_inmem_pages(struct inode *, bool);
-void f2fs_balance_fs(struct f2fs_sb_info *);
+void f2fs_balance_fs(struct f2fs_sb_info *, bool);
 void f2fs_balance_fs_bg(struct f2fs_sb_info *);
 int f2fs_issue_flush(struct f2fs_sb_info *);
 int create_flush_cmd_control(struct f2fs_sb_info *);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 69bc65f..ff06827 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -55,8 +55,7 @@ static int f2fs_vm_page_mkwrite(struct vm_area_struct *vma,
 	f2fs_put_dnode(&dn);
 	f2fs_unlock_op(sbi);
 
-	if (dn.node_changed)
-		f2fs_balance_fs(sbi);
+	f2fs_balance_fs(sbi, dn.node_changed);
 
 	file_update_time(vma->vm_file);
 	lock_page(page);
@@ -677,7 +676,7 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 			err = f2fs_truncate(inode, true);
 			if (err)
 				return err;
-			f2fs_balance_fs(F2FS_I_SB(inode));
+			f2fs_balance_fs(F2FS_I_SB(inode), true);
 		} else {
 			/*
 			 * do not trim all blocks after i_size if target size is
@@ -732,7 +731,7 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 	if (!len)
 		return 0;
 
-	f2fs_balance_fs(sbi);
+	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);
 	page = get_new_data_page(inode, NULL, index, false);
@@ -818,7 +817,7 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 			loff_t blk_start, blk_end;
 			struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
-			f2fs_balance_fs(sbi);
+			f2fs_balance_fs(sbi, true);
 
 			blk_start = (loff_t)pg_start << PAGE_CACHE_SHIFT;
 			blk_end = (loff_t)pg_end << PAGE_CACHE_SHIFT;
@@ -921,7 +920,7 @@ static int f2fs_do_collapse(struct inode *inode, pgoff_t start, pgoff_t end)
 	int ret = 0;
 
 	for (; end < nrpages; start++, end++) {
-		f2fs_balance_fs(sbi);
+		f2fs_balance_fs(sbi, true);
 		f2fs_lock_op(sbi);
 		ret = __exchange_data_block(inode, end, start, true);
 		f2fs_unlock_op(sbi);
@@ -1103,7 +1102,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
-	f2fs_balance_fs(sbi);
+	f2fs_balance_fs(sbi, true);
 
 	ret = truncate_blocks(inode, i_size_read(inode), true);
 	if (ret)
@@ -1155,7 +1154,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 	if (ret)
 		return ret;
 
-	f2fs_balance_fs(sbi);
+	f2fs_balance_fs(sbi, true);
 
 	pg_start = ((unsigned long long) offset) >> PAGE_CACHE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_CACHE_SHIFT;
@@ -1653,7 +1652,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	pg_start = range->start >> PAGE_CACHE_SHIFT;
 	pg_end = (range->start + range->len) >> PAGE_CACHE_SHIFT;
 
-	f2fs_balance_fs(sbi);
+	f2fs_balance_fs(sbi, true);
 
 	mutex_lock(&inode->i_mutex);
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 5ffbd16..c3f0b7d 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -200,8 +200,7 @@ out:
 
 	f2fs_put_page(page, 1);
 
-	if (dn.node_changed)
-		f2fs_balance_fs(sbi);
+	f2fs_balance_fs(sbi, dn.node_changed);
 
 	return err;
 }
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index cabc1ff..2ac4b78 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -303,7 +303,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	 * during the urgent cleaning time when runing out of free sections.
 	 */
 	if (update_inode_page(inode))
-		f2fs_balance_fs(sbi);
+		f2fs_balance_fs(sbi, true);
 	return 0;
 }
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 0d61a68..53d6227 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -140,7 +140,7 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	inode->i_mapping->a_ops = &f2fs_dblock_aops;
 	ino = inode->i_ino;
 
-	f2fs_balance_fs(sbi);
+	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);
 	err = f2fs_add_link(dentry, inode);
@@ -172,7 +172,7 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 		!f2fs_is_child_context_consistent_with_parent(dir, inode))
 		return -EPERM;
 
-	f2fs_balance_fs(sbi);
+	f2fs_balance_fs(sbi, true);
 
 	inode->i_ctime = CURRENT_TIME;
 	ihold(inode);
@@ -221,7 +221,7 @@ static int __recover_dot_dentries(struct inode *dir, nid_t pino)
 		return 0;
 	}
 
-	f2fs_balance_fs(sbi);
+	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);
 
@@ -302,7 +302,7 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	if (!de)
 		goto fail;
 
-	f2fs_balance_fs(sbi);
+	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);
 	err = acquire_orphan_inode(sbi);
@@ -361,7 +361,7 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 		inode->i_op = &f2fs_symlink_inode_operations;
 	inode->i_mapping->a_ops = &f2fs_dblock_aops;
 
-	f2fs_balance_fs(sbi);
+	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);
 	err = f2fs_add_link(dentry, inode);
@@ -452,7 +452,7 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	inode->i_mapping->a_ops = &f2fs_dblock_aops;
 	mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_HIGH_ZERO);
 
-	f2fs_balance_fs(sbi);
+	f2fs_balance_fs(sbi, true);
 
 	set_inode_flag(F2FS_I(inode), FI_INC_LINK);
 	f2fs_lock_op(sbi);
@@ -498,7 +498,7 @@ static int f2fs_mknod(struct inode *dir, struct dentry *dentry,
 	init_special_inode(inode, inode->i_mode, rdev);
 	inode->i_op = &f2fs_special_inode_operations;
 
-	f2fs_balance_fs(sbi);
+	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);
 	err = f2fs_add_link(dentry, inode);
@@ -539,7 +539,7 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
 		inode->i_mapping->a_ops = &f2fs_dblock_aops;
 	}
 
-	f2fs_balance_fs(sbi);
+	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);
 	err = acquire_orphan_inode(sbi);
@@ -642,7 +642,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		if (!new_entry)
 			goto out_whiteout;
 
-		f2fs_balance_fs(sbi);
+		f2fs_balance_fs(sbi, true);
 
 		f2fs_lock_op(sbi);
 
@@ -675,7 +675,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		update_inode_page(old_inode);
 		update_inode_page(new_inode);
 	} else {
-		f2fs_balance_fs(sbi);
+		f2fs_balance_fs(sbi, true);
 
 		f2fs_lock_op(sbi);
 
@@ -816,7 +816,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 			goto out_new_dir;
 	}
 
-	f2fs_balance_fs(sbi);
+	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a3474ba..c7bbc91 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -213,7 +213,7 @@ int commit_inmem_pages(struct inode *inode, bool abort)
 	 * inode becomes free by iget_locked in f2fs_iget.
 	 */
 	if (!abort) {
-		f2fs_balance_fs(sbi);
+		f2fs_balance_fs(sbi, true);
 		f2fs_lock_op(sbi);
 	}
 
@@ -262,8 +262,10 @@ int commit_inmem_pages(struct inode *inode, bool abort)
  * This function balances dirty node and dentry pages.
  * In addition, it controls garbage collection.
  */
-void f2fs_balance_fs(struct f2fs_sb_info *sbi)
+void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 {
+	if (!need)
+		return;
 	/*
 	 * We should do GC or end up with checkpoint, if there are so many dirty
 	 * dir/node pages without enough free segments.
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 862368a..822a8af 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -609,7 +609,7 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
 	if (ipage)
 		return __f2fs_setxattr(inode, index, name, value,
 						size, ipage, flags);
-	f2fs_balance_fs(sbi);
+	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);
 	/* protect xattr_ver */
-- 
2.6.3
