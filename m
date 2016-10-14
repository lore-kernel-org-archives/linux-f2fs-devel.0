From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH 2/2] f2fs: fix allocation failure
Date: Fri, 14 Oct 2016 13:37:00 -0700
Message-ID: <20161014203700.GC67182@jaegeuk>
References: <20161012161427.24419-1-chao@kernel.org>
 <20161012161427.24419-2-chao@kernel.org>
 <20161013204907.GC6363@jaegeuk>
 <bdaa97c9-5c37-d210-13c8-c2ca009cf221@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bdaa97c9-5c37-d210-13c8-c2ca009cf221@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, Oct 14, 2016 at 10:09:29PM +0800, Chao Yu wrote:
...

> >> Finally it needs to update the dirty time of inode into inode page,
> >> and writeback the page, however, before that, we didn't count the inode
> >> as imeta data. So f2fs won't be aware of dirty metadata page count is
> >> exceeded watermark of GC, result in encountering panic when allocating
> >> free segment.
> >>
> >> There is an easy way to produce this bug:
> >> 1. mount with lazytime option
> >> 2. fragment space
> >> 3. touch all files in the image
> >> 4. umount
> > 
> > I think modifying has_not_enough_secs() is enough like this.
> 
> Seems it won't solve this problem as I tested, the root cause here is that if
> huge number of inode updates due to time changes, actually inodes won't be set
> dirty as we return directly if flags is I_DIRTY_TIME in f2fs_dirty_inode, then
> once inode cache is been shrunk, inodes in lru list will be set dirty in iput:
> 
> In iput()
> 		if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> 			atomic_inc(&inode->i_count);
> 			inode->i_state &= ~I_DIRTY_TIME;
> 			spin_unlock(&inode->i_lock);
> 			trace_writeback_lazytime_iput(inode);
> 			mark_inode_dirty_sync(inode);
> 			goto retry;
> 
> After that once someone calls write_checkpoint(), if number of dirty imeta data
> is exceeded remain blocks in free segments, we will encounter this bug.
> 
> In order to fix this bug, I try to account these delayed dirtied inodes to
> detect actual dirty metadata number, by this way we can set delayed dirtied
> inode dirty and flush them in advance to avoid the dirty metadata number
> exceeding blocks number in free segments, finally allocation failure issue can
> be solved.

Yup, I did understand like that before. But actually, I tested this patch and
unfortunately I got a deadlock when running fsstress quickly. So, this makes me
rethink the whole design in terms of how to reuse the existing codes.

I think we're able to consider inode cache apart from FS consistency. The
IMETA list was actually keeping all the dirty inodes for FS consistency, but
it seems we don't need to store all of them which will consume free segments
dramatically during checkpoint.

I wrote a patch to add dirty inodes into IMETA list selectively.
The goal is to avoid adding dirty inodes by mark_inode_dirty_sync() called by
vfs, not by f2fs. Instead, those changes will be done by f2fs_write_inode().

Could you take a look at this?

>From bc165410f30274dce76e053b922d39a61b012e43 Mon Sep 17 00:00:00 2001
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
 fs/f2fs/f2fs.h         | 25 +++++++++++++------------
 fs/f2fs/file.c         |  8 ++++----
 fs/f2fs/inline.c       |  2 +-
 fs/f2fs/inode.c        | 10 +++++-----
 fs/f2fs/namei.c        |  6 +++---
 fs/f2fs/super.c        |  3 +++
 fs/f2fs/xattr.c        |  4 ++--
 10 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 1e29630..6266fba 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -386,7 +386,7 @@ int f2fs_init_acl(struct inode *inode, struct inode *dir, struct page *ipage,
 	if (error)
 		return error;
 
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
 
 	if (default_acl) {
 		error = __f2fs_set_acl(inode, ACL_TYPE_DEFAULT, default_acl,
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index a46079a..e71793c 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -313,7 +313,7 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 	set_page_dirty(page);
 
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
-	f2fs_mark_inode_dirty_sync(dir);
+	f2fs_mark_inode_dirty_sync(dir, false);
 	f2fs_put_page(page, 1);
 }
 
@@ -466,7 +466,7 @@ void update_parent_metadata(struct inode *dir, struct inode *inode,
 		clear_inode_flag(inode, FI_NEW_INODE);
 	}
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
-	f2fs_mark_inode_dirty_sync(dir);
+	f2fs_mark_inode_dirty_sync(dir, false);
 
 	if (F2FS_I(dir)->i_current_depth != current_depth)
 		f2fs_i_depth_write(dir, current_depth);
@@ -731,7 +731,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	set_page_dirty(page);
 
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
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
index 6dc004e..921f44d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -513,13 +513,13 @@ static inline bool __is_front_mergeable(struct extent_info *cur,
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
 
@@ -1625,6 +1625,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 enum {
 	FI_NEW_INODE,		/* indicate newly allocated inode */
 	FI_DIRTY_INODE,		/* indicate inode is dirty or not */
+	FI_DIRTY_INODE_SYNC,	/* indicate inode needs to be synced or not */
 	FI_AUTO_RECOVER,	/* indicate inode is recoverable */
 	FI_DIRTY_DIR,		/* indicate directory has dirty pages */
 	FI_INC_LINK,		/* need to increment i_nlink */
@@ -1659,7 +1660,7 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 			return;
 	case FI_DATA_EXIST:
 	case FI_INLINE_DOTS:
-		f2fs_mark_inode_dirty_sync(inode);
+		f2fs_mark_inode_dirty_sync(inode, true);
 	}
 }
 
@@ -1686,7 +1687,7 @@ static inline void set_acl_inode(struct inode *inode, umode_t mode)
 {
 	F2FS_I(inode)->i_acl_mode = mode;
 	set_inode_flag(inode, FI_ACL_MODE);
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, false);
 }
 
 static inline void f2fs_i_links_write(struct inode *inode, bool inc)
@@ -1695,7 +1696,7 @@ static inline void f2fs_i_links_write(struct inode *inode, bool inc)
 		inc_nlink(inode);
 	else
 		drop_nlink(inode);
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
 static inline void f2fs_i_blocks_write(struct inode *inode,
@@ -1706,7 +1707,7 @@ static inline void f2fs_i_blocks_write(struct inode *inode,
 
 	inode->i_blocks = add ? inode->i_blocks + diff :
 				inode->i_blocks - diff;
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
 	if (clean || recover)
 		set_inode_flag(inode, FI_AUTO_RECOVER);
 }
@@ -1720,7 +1721,7 @@ static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
 		return;
 
 	i_size_write(inode, i_size);
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
 	if (clean || recover)
 		set_inode_flag(inode, FI_AUTO_RECOVER);
 }
@@ -1735,19 +1736,19 @@ static inline bool f2fs_skip_inode_update(struct inode *inode)
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
@@ -1875,13 +1876,13 @@ static inline int is_file(struct inode *inode, int type)
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
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index bfce575..aa778c6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -266,7 +266,6 @@ sync_nodes:
 	}
 
 	if (need_inode_block_update(sbi, ino)) {
-		f2fs_mark_inode_dirty_sync(inode);
 		f2fs_write_inode(inode, NULL);
 		goto sync_nodes;
 	}
@@ -671,7 +670,7 @@ int f2fs_truncate(struct inode *inode)
 		return err;
 
 	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, false);
 	return 0;
 }
 
@@ -760,7 +759,8 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 		}
 	}
 
-	f2fs_mark_inode_dirty_sync(inode);
+	/* update attributes only */
+	f2fs_mark_inode_dirty_sync(inode, false);
 
 	/* inode change will produce dirty node pages flushed by checkpoint */
 	f2fs_balance_fs(F2FS_I_SB(inode), true);
@@ -1441,7 +1441,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 	if (!ret) {
 		inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-		f2fs_mark_inode_dirty_sync(inode);
+		f2fs_mark_inode_dirty_sync(inode, false);
 		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	}
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 8d71d64..a05be5d 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -575,7 +575,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	f2fs_put_page(page, 1);
 
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
-	f2fs_mark_inode_dirty_sync(dir);
+	f2fs_mark_inode_dirty_sync(dir, false);
 
 	if (inode)
 		f2fs_drop_nlink(dir, inode);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index d32fd03..4368ee7 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -19,10 +19,13 @@
 
 #include <trace/events/f2fs.h>
 
-void f2fs_mark_inode_dirty_sync(struct inode *inode)
+void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
 {
+	if (sync)
+		set_inode_flag(inode, FI_DIRTY_INODE_SYNC);
 	if (f2fs_inode_dirtied(inode))
 		return;
+
 	mark_inode_dirty_sync(inode);
 }
 
@@ -43,7 +46,7 @@ void f2fs_set_inode_flags(struct inode *inode)
 		new_fl |= S_DIRSYNC;
 	inode_set_flags(inode, new_fl,
 			S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC);
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, false);
 }
 
 static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
@@ -331,9 +334,6 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 			inode->i_ino == F2FS_META_INO(sbi))
 		return 0;
 
-	if (!is_inode_flag_set(inode, FI_DIRTY_INODE))
-		return 0;
-
 	/*
 	 * We need to balance fs here to prevent from producing dirty node pages
 	 * during the urgent cleaning time when runing out of free sections.
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 300aef8..21b336a 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -778,7 +778,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	up_write(&F2FS_I(old_inode)->i_sem);
 
 	old_inode->i_ctime = CURRENT_TIME;
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
index 0559cd6..d22a4d2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -651,6 +651,7 @@ void f2fs_inode_synced(struct inode *inode)
 	}
 	list_del_init(&F2FS_I(inode)->gdirty_list);
 	clear_inode_flag(inode, FI_DIRTY_INODE);
+	clear_inode_flag(inode, FI_DIRTY_INODE_SYNC);
 	clear_inode_flag(inode, FI_AUTO_RECOVER);
 	dec_page_count(sbi, F2FS_DIRTY_IMETA);
 	stat_dec_dirty_inode(F2FS_I_SB(inode), DIRTY_META);
@@ -672,6 +673,8 @@ static void f2fs_dirty_inode(struct inode *inode, int flags)
 
 	if (flags == I_DIRTY_TIME)
 		return;
+	if (!is_inode_flag_set(inode, FI_DIRTY_INODE_SYNC))
+		return;
 
 	if (is_inode_flag_set(inode, FI_AUTO_RECOVER))
 		clear_inode_flag(inode, FI_AUTO_RECOVER);
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 83234dd..4effb96 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -106,7 +106,7 @@ static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
 		return -EINVAL;
 
 	F2FS_I(inode)->i_advise |= *(char *)value;
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
 	return 0;
 }
 
@@ -561,7 +561,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 		else
 			file_clear_key(inode);
 	}
-	f2fs_mark_inode_dirty_sync(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
 	if (!error && S_ISDIR(inode->i_mode))
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
 exit:
-- 
2.8.3
