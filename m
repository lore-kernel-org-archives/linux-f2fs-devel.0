From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 05/12] f2fs: call mark_inode_dirty_sync for i_field changes
Date: Tue, 24 May 2016 17:03:31 -0700
Message-ID: <1464134619-37015-5-git-send-email-jaegeuk@kernel.org>
References: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch calls mark_inode_dirty_sync() for the following on-disk inode
changes.

 -> largest
 -> ctime/mtime/atime
 -> i_current_depth
 -> i_xattr_nid
 -> i_pino
 -> i_advise
 -> flags

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c          | 14 ++++++-------
 fs/f2fs/extent_cache.c | 24 ++++++++++++---------
 fs/f2fs/f2fs.h         | 57 +++++++++++++++++++++++++++++++++++++++++++-------
 fs/f2fs/file.c         | 11 +++++-----
 fs/f2fs/inline.c       |  7 ++++---
 fs/f2fs/namei.c        | 11 ++++------
 fs/f2fs/node.c         |  6 +++---
 fs/f2fs/xattr.c        |  3 ++-
 8 files changed, 88 insertions(+), 45 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index f8ca0f3..384d51c 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -243,8 +243,7 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 				"Corrupted max_depth of %lu: %u",
 				dir->i_ino, max_depth);
 		max_depth = MAX_DIR_HASH_DEPTH;
-		F2FS_I(dir)->i_current_depth = max_depth;
-		mark_inode_dirty(dir);
+		f2fs_i_depth_write(dir, max_depth);
 	}
 
 	for (level = 0; level < max_depth; level++) {
@@ -303,9 +302,9 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 	set_de_type(de, inode->i_mode);
 	f2fs_dentry_kunmap(dir, page);
 	set_page_dirty(page);
-	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
-	mark_inode_dirty(dir);
 
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	mark_inode_dirty_sync(dir);
 	f2fs_put_page(page, 1);
 }
 
@@ -462,10 +461,10 @@ void update_parent_metadata(struct inode *dir, struct inode *inode,
 		clear_inode_flag(inode, FI_NEW_INODE);
 	}
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
-	mark_inode_dirty(dir);
+	mark_inode_dirty_sync(dir);
 
 	if (F2FS_I(dir)->i_current_depth != current_depth) {
-		F2FS_I(dir)->i_current_depth = current_depth;
+		f2fs_i_depth_write(dir, current_depth);
 		set_inode_flag(dir, FI_UPDATE_DIR);
 	}
 
@@ -597,7 +596,7 @@ add_dentry:
 
 	if (inode) {
 		/* we don't need to mark_inode_dirty now */
-		F2FS_I(inode)->i_pino = dir->i_ino;
+		f2fs_i_pino_write(inode, dir->i_ino);
 		update_inode(inode, page);
 		f2fs_put_page(page, 1);
 	}
@@ -730,6 +729,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	set_page_dirty(page);
 
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	mark_inode_dirty_sync(dir);
 
 	if (inode)
 		f2fs_drop_nlink(dir, inode, NULL);
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 852a0b6..d21dda6 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -170,8 +170,10 @@ static void __drop_largest_extent(struct inode *inode,
 {
 	struct extent_info *largest = &F2FS_I(inode)->extent_tree->largest;
 
-	if (fofs < largest->fofs + largest->len && fofs + len > largest->fofs)
+	if (fofs < largest->fofs + largest->len && fofs + len > largest->fofs) {
 		largest->len = 0;
+		mark_inode_dirty_sync(inode);
+	}
 }
 
 /* return true, if inode page is changed */
@@ -335,11 +337,12 @@ lookup_neighbors:
 	return en;
 }
 
-static struct extent_node *__try_merge_extent_node(struct f2fs_sb_info *sbi,
+static struct extent_node *__try_merge_extent_node(struct inode *inode,
 				struct extent_tree *et, struct extent_info *ei,
 				struct extent_node *prev_ex,
 				struct extent_node *next_ex)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_node *en = NULL;
 
 	if (prev_ex && __is_back_mergeable(ei, &prev_ex->ei)) {
@@ -360,7 +363,7 @@ static struct extent_node *__try_merge_extent_node(struct f2fs_sb_info *sbi,
 	if (!en)
 		return NULL;
 
-	__try_update_largest_extent(et, en);
+	__try_update_largest_extent(inode, et, en);
 
 	spin_lock(&sbi->extent_lock);
 	if (!list_empty(&en->list)) {
@@ -371,11 +374,12 @@ static struct extent_node *__try_merge_extent_node(struct f2fs_sb_info *sbi,
 	return en;
 }
 
-static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
+static struct extent_node *__insert_extent_tree(struct inode *inode,
 				struct extent_tree *et, struct extent_info *ei,
 				struct rb_node **insert_p,
 				struct rb_node *insert_parent)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct rb_node **p = &et->root.rb_node;
 	struct rb_node *parent = NULL;
 	struct extent_node *en = NULL;
@@ -402,7 +406,7 @@ do_insert:
 	if (!en)
 		return NULL;
 
-	__try_update_largest_extent(et, en);
+	__try_update_largest_extent(inode, et, en);
 
 	/* update in global extent list */
 	spin_lock(&sbi->extent_lock);
@@ -473,7 +477,7 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 				set_extent_info(&ei, end,
 						end - dei.fofs + dei.blk,
 						org_end - end);
-				en1 = __insert_extent_tree(sbi, et, &ei,
+				en1 = __insert_extent_tree(inode, et, &ei,
 							NULL, NULL);
 				next_en = en1;
 			} else {
@@ -494,7 +498,7 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 		}
 
 		if (parts)
-			__try_update_largest_extent(et, en);
+			__try_update_largest_extent(inode, et, en);
 		else
 			__release_extent_node(sbi, et, en);
 
@@ -514,15 +518,15 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 	if (blkaddr) {
 
 		set_extent_info(&ei, fofs, blkaddr, len);
-		if (!__try_merge_extent_node(sbi, et, &ei, prev_en, next_en))
-			__insert_extent_tree(sbi, et, &ei,
+		if (!__try_merge_extent_node(inode, et, &ei, prev_en, next_en))
+			__insert_extent_tree(inode, et, &ei,
 						insert_p, insert_parent);
 
 		/* give up extent_cache, if split and small updates happen */
 		if (dei.len >= 1 &&
 				prev.len < F2FS_MIN_EXTENT_LEN &&
 				et->largest.len < F2FS_MIN_EXTENT_LEN) {
-			et->largest.len = 0;
+			__drop_largest_extent(inode, 0, UINT_MAX);
 			set_inode_flag(inode, FI_NO_EXTENT);
 		}
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5af9768..6721a43 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -498,11 +498,13 @@ static inline bool __is_front_mergeable(struct extent_info *cur,
 	return __is_extent_mergeable(cur, front);
 }
 
-static inline void __try_update_largest_extent(struct extent_tree *et,
-						struct extent_node *en)
+static inline void __try_update_largest_extent(struct inode *inode,
+			struct extent_tree *et, struct extent_node *en)
 {
-	if (en->ei.len > et->largest.len)
+	if (en->ei.len > et->largest.len) {
 		et->largest = en->ei;
+		mark_inode_dirty_sync(inode);
+	}
 }
 
 struct f2fs_nm_info {
@@ -1534,10 +1536,26 @@ enum {
 	FI_DIRTY_FILE,		/* indicate regular/symlink has dirty pages */
 };
 
+static inline void __mark_inode_dirty_flag(struct inode *inode,
+						int flag, bool set)
+{
+	switch (flag) {
+	case FI_INLINE_XATTR:
+	case FI_INLINE_DATA:
+	case FI_INLINE_DENTRY:
+		if (set)
+			return;
+	case FI_DATA_EXIST:
+	case FI_INLINE_DOTS:
+		mark_inode_dirty_sync(inode);
+	}
+}
+
 static inline void set_inode_flag(struct inode *inode, int flag)
 {
 	if (!test_bit(flag, &F2FS_I(inode)->flags))
 		set_bit(flag, &F2FS_I(inode)->flags);
+	__mark_inode_dirty_flag(inode, flag, true);
 }
 
 static inline int is_inode_flag_set(struct inode *inode, int flag)
@@ -1549,6 +1567,7 @@ static inline void clear_inode_flag(struct inode *inode, int flag)
 {
 	if (test_bit(flag, &F2FS_I(inode)->flags))
 		clear_bit(flag, &F2FS_I(inode)->flags);
+	__mark_inode_dirty_flag(inode, flag, false);
 }
 
 static inline void set_acl_inode(struct inode *inode, umode_t mode)
@@ -1580,18 +1599,38 @@ static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
 	mark_inode_dirty_sync(inode);
 }
 
+static inline void f2fs_i_depth_write(struct inode *inode, unsigned int depth)
+{
+	F2FS_I(inode)->i_current_depth = depth;
+	mark_inode_dirty_sync(inode);
+}
+
+static inline void f2fs_i_xnid_write(struct inode *inode, nid_t xnid)
+{
+	F2FS_I(inode)->i_xattr_nid = xnid;
+	mark_inode_dirty_sync(inode);
+}
+
+static inline void f2fs_i_pino_write(struct inode *inode, nid_t pino)
+{
+	F2FS_I(inode)->i_pino = pino;
+	mark_inode_dirty_sync(inode);
+}
+
 static inline void get_inline_info(struct inode *inode, struct f2fs_inode *ri)
 {
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+
 	if (ri->i_inline & F2FS_INLINE_XATTR)
-		set_inode_flag(inode, FI_INLINE_XATTR);
+		set_bit(FI_INLINE_XATTR, &fi->flags);
 	if (ri->i_inline & F2FS_INLINE_DATA)
-		set_inode_flag(inode, FI_INLINE_DATA);
+		set_bit(FI_INLINE_DATA, &fi->flags);
 	if (ri->i_inline & F2FS_INLINE_DENTRY)
-		set_inode_flag(inode, FI_INLINE_DENTRY);
+		set_bit(FI_INLINE_DENTRY, &fi->flags);
 	if (ri->i_inline & F2FS_DATA_EXIST)
-		set_inode_flag(inode, FI_DATA_EXIST);
+		set_bit(FI_DATA_EXIST, &fi->flags);
 	if (ri->i_inline & F2FS_INLINE_DOTS)
-		set_inode_flag(inode, FI_INLINE_DOTS);
+		set_bit(FI_INLINE_DOTS, &fi->flags);
 }
 
 static inline void set_raw_inline(struct inode *inode, struct f2fs_inode *ri)
@@ -1703,11 +1742,13 @@ static inline int is_file(struct inode *inode, int type)
 static inline void set_file(struct inode *inode, int type)
 {
 	F2FS_I(inode)->i_advise |= type;
+	mark_inode_dirty_sync(inode);
 }
 
 static inline void clear_file(struct inode *inode, int type)
 {
 	F2FS_I(inode)->i_advise &= ~type;
+	mark_inode_dirty_sync(inode);
 }
 
 static inline int f2fs_readonly(struct super_block *sb)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d0f4258..e8d95e9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -171,11 +171,10 @@ static void try_to_fix_pino(struct inode *inode)
 	fi->xattr_ver = 0;
 	if (file_wrong_pino(inode) && inode->i_nlink == 1 &&
 			get_parent_ino(inode, &pino)) {
-		fi->i_pino = pino;
+		f2fs_i_pino_write(inode, pino);
 		file_got_pino(inode);
 		up_write(&fi->i_sem);
 
-		mark_inode_dirty_sync(inode);
 		f2fs_write_inode(inode, NULL);
 	} else {
 		up_write(&fi->i_sem);
@@ -636,7 +635,7 @@ int f2fs_truncate(struct inode *inode, bool lock)
 		return err;
 
 	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-	mark_inode_dirty(inode);
+	mark_inode_dirty_sync(inode);
 	return 0;
 }
 
@@ -726,7 +725,7 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 		}
 	}
 
-	mark_inode_dirty(inode);
+	mark_inode_dirty_sync(inode);
 	return err;
 }
 
@@ -1279,7 +1278,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 	if (!ret) {
 		inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-		mark_inode_dirty(inode);
+		mark_inode_dirty_sync(inode);
 		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	}
 
@@ -1372,7 +1371,7 @@ static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
 
 	f2fs_set_inode_flags(inode);
 	inode->i_ctime = CURRENT_TIME;
-	mark_inode_dirty(inode);
+	mark_inode_dirty_sync(inode);
 out:
 	mnt_drop_write_file(filp);
 	return ret;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 7a9bc44..4bc025c 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -400,7 +400,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 	stat_dec_inline_dir(dir);
 	clear_inode_flag(dir, FI_INLINE_DENTRY);
 
-	F2FS_I(dir)->i_current_depth = 1;
+	f2fs_i_depth_write(dir, 1);
 	if (i_size_read(dir) < PAGE_SIZE) {
 		f2fs_i_size_write(dir, PAGE_SIZE);
 		set_inode_flag(dir, FI_UPDATE_DIR);
@@ -492,7 +492,7 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct page *ipage,
 recover:
 	lock_page(ipage);
 	memcpy(inline_dentry, backup_dentry, MAX_INLINE_DATA);
-	F2FS_I(dir)->i_current_depth = 0;
+	f2fs_i_depth_write(dir, 0);
 	f2fs_i_size_write(dir, MAX_INLINE_DATA);
 	update_inode(dir, ipage);
 	f2fs_put_page(ipage, 1);
@@ -558,7 +558,7 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *name,
 
 	/* we don't need to mark_inode_dirty now */
 	if (inode) {
-		F2FS_I(inode)->i_pino = dir->i_ino;
+		f2fs_i_pino_write(inode, dir->i_ino);
 		update_inode(inode, page);
 		f2fs_put_page(page, 1);
 	}
@@ -597,6 +597,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	set_page_dirty(page);
 
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	mark_inode_dirty_sync(dir);
 
 	if (inode)
 		f2fs_drop_nlink(dir, inode, page);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 2bcbb42..5746fb2 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -76,7 +76,6 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	stat_inc_inline_dir(inode);
 
 	trace_f2fs_new_inode(inode, 0);
-	mark_inode_dirty(inode);
 	return inode;
 
 fail:
@@ -247,10 +246,8 @@ static int __recover_dot_dentries(struct inode *dir, nid_t pino)
 		err = __f2fs_add_link(dir, &dotdot, NULL, pino, S_IFDIR);
 	}
 out:
-	if (!err) {
+	if (!err)
 		clear_inode_flag(dir, FI_INLINE_DOTS);
-		mark_inode_dirty(dir);
-	}
 
 	f2fs_unlock_op(sbi);
 	return err;
@@ -756,7 +753,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	up_write(&F2FS_I(old_inode)->i_sem);
 
 	old_inode->i_ctime = CURRENT_TIME;
-	mark_inode_dirty(old_inode);
+	mark_inode_dirty_sync(old_inode);
 
 	f2fs_delete_entry(old_entry, old_page, old_dir, NULL);
 
@@ -910,7 +907,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_links_write(old_dir, old_nlink > 0);
 		up_write(&F2FS_I(old_dir)->i_sem);
 	}
-	mark_inode_dirty(old_dir);
+	mark_inode_dirty_sync(old_dir);
 	update_inode_page(old_dir);
 
 	/* update directory entry info of new dir inode */
@@ -928,7 +925,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_links_write(new_dir, new_nlink > 0);
 		up_write(&F2FS_I(new_dir)->i_sem);
 	}
-	mark_inode_dirty(new_dir);
+	mark_inode_dirty_sync(new_dir);
 	update_inode_page(new_dir);
 
 	f2fs_unlock_op(sbi);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8001020..0635304 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -953,7 +953,7 @@ int truncate_xattr_node(struct inode *inode, struct page *page)
 	if (IS_ERR(npage))
 		return PTR_ERR(npage);
 
-	F2FS_I(inode)->i_xattr_nid = 0;
+	f2fs_i_xnid_write(inode, 0);
 
 	/* need to do checkpoint during fsync */
 	F2FS_I(inode)->xattr_ver = cur_cp_version(F2FS_CKPT(sbi));
@@ -1047,7 +1047,7 @@ struct page *new_node_page(struct dnode_of_data *dn,
 		dn->node_changed = true;
 
 	if (f2fs_has_xattr_block(ofs))
-		F2FS_I(dn->inode)->i_xattr_nid = dn->nid;
+		f2fs_i_xnid_write(dn->inode, dn->nid);
 
 	dn->node_page = page;
 	if (ipage)
@@ -1997,7 +1997,7 @@ recover_xnid:
 	get_node_info(sbi, new_xnid, &ni);
 	ni.ino = inode->i_ino;
 	set_node_addr(sbi, &ni, NEW_ADDR, false);
-	F2FS_I(inode)->i_xattr_nid = new_xnid;
+	f2fs_i_xnid_write(inode, new_xnid);
 
 	/* 3: update xattr blkaddr */
 	refresh_sit_entry(sbi, NEW_ADDR, blkaddr);
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 76ca827..745382e 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -106,7 +106,7 @@ static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
 		return -EINVAL;
 
 	F2FS_I(inode)->i_advise |= *(char *)value;
-	mark_inode_dirty(inode);
+	mark_inode_dirty_sync(inode);
 	return 0;
 }
 
@@ -541,6 +541,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (is_inode_flag_set(inode, FI_ACL_MODE)) {
 		inode->i_mode = F2FS_I(inode)->i_acl_mode;
 		inode->i_ctime = CURRENT_TIME;
+		mark_inode_dirty_sync(inode);
 		clear_inode_flag(inode, FI_ACL_MODE);
 	}
 	if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
-- 
2.6.3
