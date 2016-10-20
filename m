From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/3 v2] f2fs: keep dirty inodes selectively for checkpoint
Date: Wed, 19 Oct 2016 19:26:09 -0700
Message-ID: <20161020022609.GA39988@jaegeuk>
References: <20161017215645.435-1-jaegeuk@kernel.org>
 <20161017215645.435-3-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161017215645.435-3-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Change log from v1:
 o avoid performance regression

>From b34a3d3c4c3fa2d6e000acc99bc5216a247bd6cb Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 14 Oct 2016 11:51:23 -0700
Subject: [PATCH] f2fs: keep dirty inodes selectively for checkpoint

This is to avoid no free segment bug during checkpoint caused by a number of
dirty inodes.

The case was reported by Chao like this.

1. mount with lazytime option
2. fragment space
3. touch all files in the image
4. umount

In this case, we actually don't need to flush dirty inode to inode page during
checkpoint.

Reported-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/acl.c          |  2 +-
 fs/f2fs/dir.c          |  6 +++---
 fs/f2fs/extent_cache.c |  2 +-
 fs/f2fs/f2fs.h         | 26 +++++++++++++-------------
 fs/f2fs/file.c         |  9 +++++----
 fs/f2fs/inline.c       |  2 +-
 fs/f2fs/inode.c        |  7 ++++---
 fs/f2fs/namei.c        |  6 +++---
 fs/f2fs/super.c        | 29 ++++++++++++++++-------------
 fs/f2fs/xattr.c        |  4 ++--
 10 files changed, 49 insertions(+), 44 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 6fe23af..8f48769 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -384,7 +384,7 @@ int f2fs_init_acl(struct inode *inode, struct inode *dir, struct page *ipage,
 	if (error)
 		return error;
 
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
 
 	if (default_acl) {
 		error = __f2fs_set_acl(inode, ACL_TYPE_DEFAULT, default_acl,
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 9fd1b0e..5f5678e 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -313,7 +313,7 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 	set_page_dirty(page);
 
 	dir->i_mtime = dir->i_ctime = current_time(dir);
-	f2fs_mark_inode_dirty_sync(dir);
+	f2fs_mark_inode_dirty_sync(dir, false);
 	f2fs_put_page(page, 1);
 }
 
@@ -466,7 +466,7 @@ void update_parent_metadata(struct inode *dir, struct inode *inode,
 		clear_inode_flag(inode, FI_NEW_INODE);
 	}
 	dir->i_mtime = dir->i_ctime = current_time(dir);
-	f2fs_mark_inode_dirty_sync(dir);
+	f2fs_mark_inode_dirty_sync(dir, false);
 
 	if (F2FS_I(dir)->i_current_depth != current_depth)
 		f2fs_i_depth_write(dir, current_depth);
@@ -731,7 +731,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	set_page_dirty(page);
 
 	dir->i_ctime = dir->i_mtime = current_time(dir);
-	f2fs_mark_inode_dirty_sync(dir);
+	f2fs_mark_inode_dirty_sync(dir, false);
 
 	if (inode)
 		f2fs_drop_nlink(dir, inode);
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 2b06d4f..4db44da 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -172,7 +172,7 @@ static void __drop_largest_extent(struct inode *inode,
 
 	if (fofs < largest->fofs + largest->len && fofs + len > largest->fofs) {
 		largest->len = 0;
-		f2fs_mark_inode_dirty_sync(inode);
+		f2fs_mark_inode_dirty_sync(inode, true);
 	}
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 692f08a..e6d057c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -493,13 +493,13 @@ static inline bool __is_front_mergeable(struct extent_info *cur,
 	return __is_extent_mergeable(cur, front);
 }
 
-extern void f2fs_mark_inode_dirty_sync(struct inode *);
+extern void f2fs_mark_inode_dirty_sync(struct inode *, bool);
 static inline void __try_update_largest_extent(struct inode *inode,
 			struct extent_tree *et, struct extent_node *en)
 {
 	if (en->ei.len > et->largest.len) {
 		et->largest = en->ei;
-		f2fs_mark_inode_dirty_sync(inode);
+		f2fs_mark_inode_dirty_sync(inode, true);
 	}
 }
 
@@ -1627,7 +1627,7 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 			return;
 	case FI_DATA_EXIST:
 	case FI_INLINE_DOTS:
-		f2fs_mark_inode_dirty_sync(inode);
+		f2fs_mark_inode_dirty_sync(inode, true);
 	}
 }
 
@@ -1654,7 +1654,7 @@ static inline void set_acl_inode(struct inode *inode, umode_t mode)
 {
 	F2FS_I(inode)->i_acl_mode = mode;
 	set_inode_flag(inode, FI_ACL_MODE);
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, false);
 }
 
 static inline void f2fs_i_links_write(struct inode *inode, bool inc)
@@ -1663,7 +1663,7 @@ static inline void f2fs_i_links_write(struct inode *inode, bool inc)
 		inc_nlink(inode);
 	else
 		drop_nlink(inode);
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
 static inline void f2fs_i_blocks_write(struct inode *inode,
@@ -1674,7 +1674,7 @@ static inline void f2fs_i_blocks_write(struct inode *inode,
 
 	inode->i_blocks = add ? inode->i_blocks + diff :
 				inode->i_blocks - diff;
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
 	if (clean || recover)
 		set_inode_flag(inode, FI_AUTO_RECOVER);
 }
@@ -1688,7 +1688,7 @@ static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
 		return;
 
 	i_size_write(inode, i_size);
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
 	if (clean || recover)
 		set_inode_flag(inode, FI_AUTO_RECOVER);
 }
@@ -1703,19 +1703,19 @@ static inline bool f2fs_skip_inode_update(struct inode *inode)
 static inline void f2fs_i_depth_write(struct inode *inode, unsigned int depth)
 {
 	F2FS_I(inode)->i_current_depth = depth;
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
 static inline void f2fs_i_xnid_write(struct inode *inode, nid_t xnid)
 {
 	F2FS_I(inode)->i_xattr_nid = xnid;
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
 static inline void f2fs_i_pino_write(struct inode *inode, nid_t pino)
 {
 	F2FS_I(inode)->i_pino = pino;
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
 static inline void get_inline_info(struct inode *inode, struct f2fs_inode *ri)
@@ -1843,13 +1843,13 @@ static inline int is_file(struct inode *inode, int type)
 static inline void set_file(struct inode *inode, int type)
 {
 	F2FS_I(inode)->i_advise |= type;
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
 static inline void clear_file(struct inode *inode, int type)
 {
 	F2FS_I(inode)->i_advise &= ~type;
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
 static inline int f2fs_readonly(struct super_block *sb)
@@ -2001,7 +2001,7 @@ static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
 /*
  * super.c
  */
-int f2fs_inode_dirtied(struct inode *);
+int f2fs_inode_dirtied(struct inode *, bool);
 void f2fs_inode_synced(struct inode *);
 int f2fs_commit_super(struct f2fs_sb_info *, bool);
 int f2fs_sync_fs(struct super_block *, int);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 42d0ee1..80eb6a1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -264,7 +264,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	}
 
 	if (need_inode_block_update(sbi, ino)) {
-		f2fs_mark_inode_dirty_sync(inode);
+		f2fs_mark_inode_dirty_sync(inode, true);
 		f2fs_write_inode(inode, NULL);
 		goto sync_nodes;
 	}
@@ -632,7 +632,7 @@ int f2fs_truncate(struct inode *inode)
 		return err;
 
 	inode->i_mtime = inode->i_ctime = current_time(inode);
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, false);
 	return 0;
 }
 
@@ -721,7 +721,8 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 		}
 	}
 
-	f2fs_mark_inode_dirty_sync(inode);
+	/* update attributes only */
+	f2fs_mark_inode_dirty_sync(inode, false);
 
 	/* inode change will produce dirty node pages flushed by checkpoint */
 	f2fs_balance_fs(F2FS_I_SB(inode), true);
@@ -1399,7 +1400,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 	if (!ret) {
 		inode->i_mtime = inode->i_ctime = current_time(inode);
-		f2fs_mark_inode_dirty_sync(inode);
+		f2fs_mark_inode_dirty_sync(inode, false);
 		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	}
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 9cd3379..8cab5df 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -575,7 +575,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	f2fs_put_page(page, 1);
 
 	dir->i_ctime = dir->i_mtime = current_time(dir);
-	f2fs_mark_inode_dirty_sync(dir);
+	f2fs_mark_inode_dirty_sync(dir, false);
 
 	if (inode)
 		f2fs_drop_nlink(dir, inode);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index d32fd03..bfa512d 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -19,10 +19,11 @@
 
 #include <trace/events/f2fs.h>
 
-void f2fs_mark_inode_dirty_sync(struct inode *inode)
+void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
 {
-	if (f2fs_inode_dirtied(inode))
+	if (f2fs_inode_dirtied(inode, sync))
 		return;
+
 	mark_inode_dirty_sync(inode);
 }
 
@@ -43,7 +44,7 @@ void f2fs_set_inode_flags(struct inode *inode)
 		new_fl |= S_DIRSYNC;
 	inode_set_flags(inode, new_fl,
 			S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC);
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, false);
 }
 
 static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 489fa0d..db33b56 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -778,7 +778,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	up_write(&F2FS_I(old_inode)->i_sem);
 
 	old_inode->i_ctime = current_time(old_inode);
-	f2fs_mark_inode_dirty_sync(old_inode);
+	f2fs_mark_inode_dirty_sync(old_inode, false);
 
 	f2fs_delete_entry(old_entry, old_page, old_dir, NULL);
 
@@ -938,7 +938,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_links_write(old_dir, old_nlink > 0);
 		up_write(&F2FS_I(old_dir)->i_sem);
 	}
-	f2fs_mark_inode_dirty_sync(old_dir);
+	f2fs_mark_inode_dirty_sync(old_dir, false);
 
 	/* update directory entry info of new dir inode */
 	f2fs_set_link(new_dir, new_entry, new_page, old_inode);
@@ -953,7 +953,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_links_write(new_dir, new_nlink > 0);
 		up_write(&F2FS_I(new_dir)->i_sem);
 	}
-	f2fs_mark_inode_dirty_sync(new_dir);
+	f2fs_mark_inode_dirty_sync(new_dir, false);
 
 	f2fs_unlock_op(sbi);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bfa4414..f8e2f31 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -620,24 +620,25 @@ static int f2fs_drop_inode(struct inode *inode)
 	return generic_drop_inode(inode);
 }
 
-int f2fs_inode_dirtied(struct inode *inode)
+int f2fs_inode_dirtied(struct inode *inode, bool sync)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	int ret = 0;
 
 	spin_lock(&sbi->inode_lock[DIRTY_META]);
 	if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
-		spin_unlock(&sbi->inode_lock[DIRTY_META]);
-		return 1;
+		ret = 1;
+	} else {
+		set_inode_flag(inode, FI_DIRTY_INODE);
+		stat_inc_dirty_inode(sbi, DIRTY_META);
 	}
-
-	set_inode_flag(inode, FI_DIRTY_INODE);
-	list_add_tail(&F2FS_I(inode)->gdirty_list,
+	if (sync && list_empty(&F2FS_I(inode)->gdirty_list)) {
+		list_add_tail(&F2FS_I(inode)->gdirty_list,
 				&sbi->inode_list[DIRTY_META]);
-	inc_page_count(sbi, F2FS_DIRTY_IMETA);
-	stat_inc_dirty_inode(sbi, DIRTY_META);
+		inc_page_count(sbi, F2FS_DIRTY_IMETA);
+	}
 	spin_unlock(&sbi->inode_lock[DIRTY_META]);
-
-	return 0;
+	return ret;
 }
 
 void f2fs_inode_synced(struct inode *inode)
@@ -649,10 +650,12 @@ void f2fs_inode_synced(struct inode *inode)
 		spin_unlock(&sbi->inode_lock[DIRTY_META]);
 		return;
 	}
-	list_del_init(&F2FS_I(inode)->gdirty_list);
+	if (!list_empty(&F2FS_I(inode)->gdirty_list)) {
+		list_del_init(&F2FS_I(inode)->gdirty_list);
+		dec_page_count(sbi, F2FS_DIRTY_IMETA);
+	}
 	clear_inode_flag(inode, FI_DIRTY_INODE);
 	clear_inode_flag(inode, FI_AUTO_RECOVER);
-	dec_page_count(sbi, F2FS_DIRTY_IMETA);
 	stat_dec_dirty_inode(F2FS_I_SB(inode), DIRTY_META);
 	spin_unlock(&sbi->inode_lock[DIRTY_META]);
 }
@@ -676,7 +679,7 @@ static void f2fs_dirty_inode(struct inode *inode, int flags)
 	if (is_inode_flag_set(inode, FI_AUTO_RECOVER))
 		clear_inode_flag(inode, FI_AUTO_RECOVER);
 
-	f2fs_inode_dirtied(inode);
+	f2fs_inode_dirtied(inode, false);
 }
 
 static void f2fs_i_callback(struct rcu_head *head)
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 3e1c028..c47ce2f 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -106,7 +106,7 @@ static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
 		return -EINVAL;
 
 	F2FS_I(inode)->i_advise |= *(char *)value;
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
 	return 0;
 }
 
@@ -554,7 +554,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
 			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
 		f2fs_set_encrypted_inode(inode);
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
 	if (!error && S_ISDIR(inode->i_mode))
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
 exit:
-- 
2.8.3
