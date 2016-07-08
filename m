From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: avoid mark_inode_dirty
Date: Fri,  8 Jul 2016 10:32:35 -0700
Message-ID: <20160708173235.98362-2-jaegeuk@kernel.org>
References: <20160708173235.98362-1-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20160708173235.98362-1-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Let's check inode's dirtiness before calling mark_inode_dirty.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/acl.c          |  2 +-
 fs/f2fs/dir.c          |  6 +++---
 fs/f2fs/extent_cache.c |  2 +-
 fs/f2fs/f2fs.h         | 24 +++++++++++++-----------
 fs/f2fs/file.c         |  8 ++++----
 fs/f2fs/inline.c       |  2 +-
 fs/f2fs/inode.c        |  9 ++++++++-
 fs/f2fs/namei.c        |  6 +++---
 fs/f2fs/super.c        | 43 ++++++++++++++++++++++++++-----------------
 fs/f2fs/xattr.c        |  4 ++--
 10 files changed, 62 insertions(+), 44 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 6a414e7..4dcc9e2 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -384,7 +384,7 @@ int f2fs_init_acl(struct inode *inode, struct inode *dir, struct page *ipage,
 	if (error)
 		return error;
 
-	mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode);
 
 	if (default_acl) {
 		error = __f2fs_set_acl(inode, ACL_TYPE_DEFAULT, default_acl,
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 7ba52a0..db4022f 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -300,7 +300,7 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 	set_page_dirty(page);
 
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
-	mark_inode_dirty_sync(dir);
+	f2fs_mark_inode_dirty_sync(dir);
 	f2fs_put_page(page, 1);
 }
 
@@ -452,7 +452,7 @@ void update_parent_metadata(struct inode *dir, struct inode *inode,
 		clear_inode_flag(inode, FI_NEW_INODE);
 	}
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
-	mark_inode_dirty_sync(dir);
+	f2fs_mark_inode_dirty_sync(dir);
 
 	if (F2FS_I(dir)->i_current_depth != current_depth)
 		f2fs_i_depth_write(dir, current_depth);
@@ -704,7 +704,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	set_page_dirty(page);
 
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
-	mark_inode_dirty_sync(dir);
+	f2fs_mark_inode_dirty_sync(dir);
 
 	if (inode)
 		f2fs_drop_nlink(dir, inode);
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index e858869..5b4b6d4 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -172,7 +172,7 @@ static void __drop_largest_extent(struct inode *inode,
 
 	if (fofs < largest->fofs + largest->len && fofs + len > largest->fofs) {
 		largest->len = 0;
-		mark_inode_dirty_sync(inode);
+		f2fs_mark_inode_dirty_sync(inode);
 	}
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2f59888..1190c04 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -526,12 +526,13 @@ static inline bool __is_front_mergeable(struct extent_info *cur,
 	return __is_extent_mergeable(cur, front);
 }
 
+extern void f2fs_mark_inode_dirty_sync(struct inode *);
 static inline void __try_update_largest_extent(struct inode *inode,
 			struct extent_tree *et, struct extent_node *en)
 {
 	if (en->ei.len > et->largest.len) {
 		et->largest = en->ei;
-		mark_inode_dirty_sync(inode);
+		f2fs_mark_inode_dirty_sync(inode);
 	}
 }
 
@@ -1571,7 +1572,7 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 			return;
 	case FI_DATA_EXIST:
 	case FI_INLINE_DOTS:
-		mark_inode_dirty_sync(inode);
+		f2fs_mark_inode_dirty_sync(inode);
 	}
 }
 
@@ -1598,7 +1599,7 @@ static inline void set_acl_inode(struct inode *inode, umode_t mode)
 {
 	F2FS_I(inode)->i_acl_mode = mode;
 	set_inode_flag(inode, FI_ACL_MODE);
-	mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode);
 }
 
 static inline void f2fs_i_links_write(struct inode *inode, bool inc)
@@ -1607,7 +1608,7 @@ static inline void f2fs_i_links_write(struct inode *inode, bool inc)
 		inc_nlink(inode);
 	else
 		drop_nlink(inode);
-	mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode);
 }
 
 static inline void f2fs_i_blocks_write(struct inode *inode,
@@ -1618,7 +1619,7 @@ static inline void f2fs_i_blocks_write(struct inode *inode,
 
 	inode->i_blocks = add ? inode->i_blocks + diff :
 				inode->i_blocks - diff;
-	mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode);
 	if (clean || recover)
 		set_inode_flag(inode, FI_AUTO_RECOVER);
 }
@@ -1632,7 +1633,7 @@ static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
 		return;
 
 	i_size_write(inode, i_size);
-	mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode);
 	if (clean || recover)
 		set_inode_flag(inode, FI_AUTO_RECOVER);
 }
@@ -1647,19 +1648,19 @@ static inline bool f2fs_skip_inode_update(struct inode *inode)
 static inline void f2fs_i_depth_write(struct inode *inode, unsigned int depth)
 {
 	F2FS_I(inode)->i_current_depth = depth;
-	mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode);
 }
 
 static inline void f2fs_i_xnid_write(struct inode *inode, nid_t xnid)
 {
 	F2FS_I(inode)->i_xattr_nid = xnid;
-	mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode);
 }
 
 static inline void f2fs_i_pino_write(struct inode *inode, nid_t pino)
 {
 	F2FS_I(inode)->i_pino = pino;
-	mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode);
 }
 
 static inline void get_inline_info(struct inode *inode, struct f2fs_inode *ri)
@@ -1787,13 +1788,13 @@ static inline int is_file(struct inode *inode, int type)
 static inline void set_file(struct inode *inode, int type)
 {
 	F2FS_I(inode)->i_advise |= type;
-	mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode);
 }
 
 static inline void clear_file(struct inode *inode, int type)
 {
 	F2FS_I(inode)->i_advise &= ~type;
-	mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode);
 }
 
 static inline int f2fs_readonly(struct super_block *sb)
@@ -1940,6 +1941,7 @@ static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
 /*
  * super.c
  */
+int f2fs_inode_dirtied(struct inode *);
 void f2fs_inode_synced(struct inode *);
 int f2fs_commit_super(struct f2fs_sb_info *, bool);
 int f2fs_sync_fs(struct super_block *, int);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 952cbcf..e6b770d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -265,7 +265,7 @@ sync_nodes:
 	}
 
 	if (need_inode_block_update(sbi, ino)) {
-		mark_inode_dirty_sync(inode);
+		f2fs_mark_inode_dirty_sync(inode);
 		f2fs_write_inode(inode, NULL);
 		goto sync_nodes;
 	}
@@ -670,7 +670,7 @@ int f2fs_truncate(struct inode *inode)
 		return err;
 
 	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-	mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode);
 	return 0;
 }
 
@@ -760,7 +760,7 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 		}
 	}
 
-	mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode);
 	return err;
 }
 
@@ -1315,7 +1315,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 	if (!ret) {
 		inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-		mark_inode_dirty_sync(inode);
+		f2fs_mark_inode_dirty_sync(inode);
 		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	}
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 2cd0edc..d411ab6 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -569,7 +569,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	f2fs_put_page(page, 1);
 
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
-	mark_inode_dirty_sync(dir);
+	f2fs_mark_inode_dirty_sync(dir);
 
 	if (inode)
 		f2fs_drop_nlink(dir, inode);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 9221ca2..9ac5efc 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -18,6 +18,13 @@
 
 #include <trace/events/f2fs.h>
 
+void f2fs_mark_inode_dirty_sync(struct inode *inode)
+{
+	if (f2fs_inode_dirtied(inode))
+		return;
+	mark_inode_dirty_sync(inode);
+}
+
 void f2fs_set_inode_flags(struct inode *inode)
 {
 	unsigned int flags = F2FS_I(inode)->i_flags;
@@ -35,7 +42,7 @@ void f2fs_set_inode_flags(struct inode *inode)
 		new_fl |= S_DIRSYNC;
 	inode_set_flags(inode, new_fl,
 			S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC);
-	mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode);
 }
 
 static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 4460400..c9ba6d7 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -757,7 +757,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	up_write(&F2FS_I(old_inode)->i_sem);
 
 	old_inode->i_ctime = CURRENT_TIME;
-	mark_inode_dirty_sync(old_inode);
+	f2fs_mark_inode_dirty_sync(old_inode);
 
 	f2fs_delete_entry(old_entry, old_page, old_dir, NULL);
 
@@ -909,7 +909,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_links_write(old_dir, old_nlink > 0);
 		up_write(&F2FS_I(old_dir)->i_sem);
 	}
-	mark_inode_dirty_sync(old_dir);
+	f2fs_mark_inode_dirty_sync(old_dir);
 
 	/* update directory entry info of new dir inode */
 	f2fs_set_link(new_dir, new_entry, new_page, old_inode);
@@ -924,7 +924,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_links_write(new_dir, new_nlink > 0);
 		up_write(&F2FS_I(new_dir)->i_sem);
 	}
-	mark_inode_dirty_sync(new_dir);
+	f2fs_mark_inode_dirty_sync(new_dir);
 
 	f2fs_unlock_op(sbi);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index edd1b35..451dfb4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -625,29 +625,14 @@ static int f2fs_drop_inode(struct inode *inode)
 	return generic_drop_inode(inode);
 }
 
-/*
- * f2fs_dirty_inode() is called from __mark_inode_dirty()
- *
- * We should call set_dirty_inode to write the dirty inode through write_inode.
- */
-static void f2fs_dirty_inode(struct inode *inode, int flags)
+int f2fs_inode_dirtied(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
-	if (inode->i_ino == F2FS_NODE_INO(sbi) ||
-			inode->i_ino == F2FS_META_INO(sbi))
-		return;
-
-	if (flags == I_DIRTY_TIME)
-		return;
-
-	if (is_inode_flag_set(inode, FI_AUTO_RECOVER))
-		clear_inode_flag(inode, FI_AUTO_RECOVER);
-
 	spin_lock(&sbi->inode_lock[DIRTY_META]);
 	if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
 		spin_unlock(&sbi->inode_lock[DIRTY_META]);
-		return;
+		return 1;
 	}
 
 	set_inode_flag(inode, FI_DIRTY_INODE);
@@ -656,6 +641,8 @@ static void f2fs_dirty_inode(struct inode *inode, int flags)
 	inc_page_count(sbi, F2FS_DIRTY_IMETA);
 	stat_inc_dirty_inode(sbi, DIRTY_META);
 	spin_unlock(&sbi->inode_lock[DIRTY_META]);
+
+	return 0;
 }
 
 void f2fs_inode_synced(struct inode *inode)
@@ -675,6 +662,28 @@ void f2fs_inode_synced(struct inode *inode)
 	spin_unlock(&sbi->inode_lock[DIRTY_META]);
 }
 
+/*
+ * f2fs_dirty_inode() is called from __mark_inode_dirty()
+ *
+ * We should call set_dirty_inode to write the dirty inode through write_inode.
+ */
+static void f2fs_dirty_inode(struct inode *inode, int flags)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+	if (inode->i_ino == F2FS_NODE_INO(sbi) ||
+			inode->i_ino == F2FS_META_INO(sbi))
+		return;
+
+	if (flags == I_DIRTY_TIME)
+		return;
+
+	if (is_inode_flag_set(inode, FI_AUTO_RECOVER))
+		clear_inode_flag(inode, FI_AUTO_RECOVER);
+
+	f2fs_inode_dirtied(inode);
+}
+
 static void f2fs_i_callback(struct rcu_head *head)
 {
 	struct inode *inode = container_of(head, struct inode, i_rcu);
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index e530254..5e9aced 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -106,7 +106,7 @@ static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
 		return -EINVAL;
 
 	F2FS_I(inode)->i_advise |= *(char *)value;
-	mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode);
 	return 0;
 }
 
@@ -555,7 +555,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 		else
 			file_clear_key(inode);
 	}
-	mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode);
 exit:
 	kzfree(base_addr);
 	return error;
-- 
2.8.3

