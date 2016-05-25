From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 01/12] f2fs: use inode pointer for {set,
	clear}_inode_flag
Date: Tue, 24 May 2016 17:03:27 -0700
Message-ID: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b5MIm-000588-Ha
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 May 2016 00:03:56 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b5MIj-0006iV-IX
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 May 2016 00:03:56 +0000
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

This patch refactors to use inode pointer for set_inode_flag and
clear_inode_flag.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/acl.c          |  7 ++---
 fs/f2fs/checkpoint.c   | 15 ++++------
 fs/f2fs/data.c         | 21 +++++++-------
 fs/f2fs/dir.c          | 22 +++++++--------
 fs/f2fs/extent_cache.c |  6 ++--
 fs/f2fs/f2fs.h         | 74 ++++++++++++++++++++++++--------------------------
 fs/f2fs/file.c         | 58 ++++++++++++++++++---------------------
 fs/f2fs/gc.c           |  4 +--
 fs/f2fs/inline.c       | 25 ++++++++---------
 fs/f2fs/inode.c        | 29 ++++++++++----------
 fs/f2fs/namei.c        | 22 +++++++++------
 fs/f2fs/node.c         |  4 +--
 fs/f2fs/segment.c      |  2 +-
 fs/f2fs/segment.h      |  2 +-
 fs/f2fs/super.c        |  7 +----
 fs/f2fs/xattr.c        |  7 ++---
 16 files changed, 145 insertions(+), 160 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index a31c7e8..1b2c202 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -201,7 +201,6 @@ struct posix_acl *f2fs_get_acl(struct inode *inode, int type)
 static int __f2fs_set_acl(struct inode *inode, int type,
 			struct posix_acl *acl, struct page *ipage)
 {
-	struct f2fs_inode_info *fi = F2FS_I(inode);
 	int name_index;
 	void *value = NULL;
 	size_t size = 0;
@@ -214,7 +213,7 @@ static int __f2fs_set_acl(struct inode *inode, int type,
 			error = posix_acl_equiv_mode(acl, &inode->i_mode);
 			if (error < 0)
 				return error;
-			set_acl_inode(fi, inode->i_mode);
+			set_acl_inode(inode, inode->i_mode);
 			if (error == 0)
 				acl = NULL;
 		}
@@ -233,7 +232,7 @@ static int __f2fs_set_acl(struct inode *inode, int type,
 	if (acl) {
 		value = f2fs_acl_to_disk(acl, &size);
 		if (IS_ERR(value)) {
-			clear_inode_flag(fi, FI_ACL_MODE);
+			clear_inode_flag(inode, FI_ACL_MODE);
 			return (int)PTR_ERR(value);
 		}
 	}
@@ -244,7 +243,7 @@ static int __f2fs_set_acl(struct inode *inode, int type,
 	if (!error)
 		set_cached_acl(inode, type, acl);
 
-	clear_inode_flag(fi, FI_ACL_MODE);
+	clear_inode_flag(inode, FI_ACL_MODE);
 	return error;
 }
 
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 3891600..94bd5e2 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -759,28 +759,25 @@ fail_no_cp:
 static void __add_dirty_inode(struct inode *inode, enum inode_type type)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct f2fs_inode_info *fi = F2FS_I(inode);
 	int flag = (type == DIR_INODE) ? FI_DIRTY_DIR : FI_DIRTY_FILE;
 
-	if (is_inode_flag_set(fi, flag))
+	if (is_inode_flag_set(inode, flag))
 		return;
 
-	set_inode_flag(fi, flag);
-	list_add_tail(&fi->dirty_list, &sbi->inode_list[type]);
+	set_inode_flag(inode, flag);
+	list_add_tail(&F2FS_I(inode)->dirty_list, &sbi->inode_list[type]);
 	stat_inc_dirty_inode(sbi, type);
 }
 
 static void __remove_dirty_inode(struct inode *inode, enum inode_type type)
 {
-	struct f2fs_inode_info *fi = F2FS_I(inode);
 	int flag = (type == DIR_INODE) ? FI_DIRTY_DIR : FI_DIRTY_FILE;
 
-	if (get_dirty_pages(inode) ||
-			!is_inode_flag_set(F2FS_I(inode), flag))
+	if (get_dirty_pages(inode) || !is_inode_flag_set(inode, flag))
 		return;
 
-	list_del_init(&fi->dirty_list);
-	clear_inode_flag(fi, flag);
+	list_del_init(&F2FS_I(inode)->dirty_list);
+	clear_inode_flag(inode, flag);
 	stat_dec_dirty_inode(F2FS_I_SB(inode), type);
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9a8bbc1..dd46ca8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -321,7 +321,7 @@ int reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
 	if (!count)
 		return 0;
 
-	if (unlikely(is_inode_flag_set(F2FS_I(dn->inode), FI_NO_ALLOC)))
+	if (unlikely(is_inode_flag_set(dn->inode, FI_NO_ALLOC)))
 		return -EPERM;
 	if (unlikely(!inc_valid_block_count(sbi, dn->inode, &count)))
 		return -ENOSPC;
@@ -566,7 +566,7 @@ got_it:
 				((loff_t)(index + 1) << PAGE_SHIFT)) {
 		i_size_write(inode, ((loff_t)(index + 1) << PAGE_SHIFT));
 		/* Only the directory inode sets new_i_size */
-		set_inode_flag(F2FS_I(inode), FI_UPDATE_DIR);
+		set_inode_flag(inode, FI_UPDATE_DIR);
 	}
 	return page;
 }
@@ -580,7 +580,7 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 	pgoff_t fofs;
 	blkcnt_t count = 1;
 
-	if (unlikely(is_inode_flag_set(F2FS_I(dn->inode), FI_NO_ALLOC)))
+	if (unlikely(is_inode_flag_set(dn->inode, FI_NO_ALLOC)))
 		return -EPERM;
 
 	dn->data_blkaddr = datablock_addr(dn->node_page, dn->ofs_in_node);
@@ -717,8 +717,7 @@ next_block:
 			} else {
 				err = __allocate_data_block(&dn);
 				if (!err) {
-					set_inode_flag(F2FS_I(inode),
-							FI_APPEND_WRITE);
+					set_inode_flag(inode, FI_APPEND_WRITE);
 					allocated = true;
 				}
 			}
@@ -1193,14 +1192,14 @@ retry_encrypt:
 			!IS_ATOMIC_WRITTEN_PAGE(page) &&
 			need_inplace_update(inode))) {
 		rewrite_data_page(fio);
-		set_inode_flag(F2FS_I(inode), FI_UPDATE_WRITE);
+		set_inode_flag(inode, FI_UPDATE_WRITE);
 		trace_f2fs_do_write_data_page(page, IPU);
 	} else {
 		write_data_page(&dn, fio);
 		trace_f2fs_do_write_data_page(page, OPU);
-		set_inode_flag(F2FS_I(inode), FI_APPEND_WRITE);
+		set_inode_flag(inode, FI_APPEND_WRITE);
 		if (page->index == 0)
-			set_inode_flag(F2FS_I(inode), FI_FIRST_BLOCK_WRITTEN);
+			set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 	}
 out_writepage:
 	f2fs_put_dnode(&dn);
@@ -1469,7 +1468,7 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 		goto skip_write;
 
 	/* skip writing during file defragment */
-	if (is_inode_flag_set(F2FS_I(inode), FI_DO_DEFRAG))
+	if (is_inode_flag_set(inode, FI_DO_DEFRAG))
 		goto skip_write;
 
 	/* during POR, we don't need to trigger writepage at all. */
@@ -1549,7 +1548,7 @@ restart:
 	if (f2fs_has_inline_data(inode)) {
 		if (pos + len <= MAX_INLINE_DATA) {
 			read_inline_data(page, ipage);
-			set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
+			set_inode_flag(inode, FI_DATA_EXIST);
 			if (inode->i_nlink)
 				set_inline_node(ipage);
 		} else {
@@ -1756,7 +1755,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	err = blockdev_direct_IO(iocb, inode, iter, get_data_block_dio);
 	if (iov_iter_rw(iter) == WRITE) {
 		if (err > 0)
-			set_inode_flag(F2FS_I(inode), FI_UPDATE_WRITE);
+			set_inode_flag(inode, FI_UPDATE_WRITE);
 		else if (err < 0)
 			f2fs_write_failed(mapping, offset + count);
 	}
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index f9313f6..9fa8d3e 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -385,7 +385,7 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 	struct page *page;
 	int err;
 
-	if (is_inode_flag_set(F2FS_I(inode), FI_NEW_INODE)) {
+	if (is_inode_flag_set(inode, FI_NEW_INODE)) {
 		page = new_inode_page(inode);
 		if (IS_ERR(page))
 			return page;
@@ -429,7 +429,7 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 	 * This file should be checkpointed during fsync.
 	 * We lost i_pino from now on.
 	 */
-	if (is_inode_flag_set(F2FS_I(inode), FI_INC_LINK)) {
+	if (is_inode_flag_set(inode, FI_INC_LINK)) {
 		file_lost_pino(inode);
 		/*
 		 * If link the tmpfile to alias through linkat path,
@@ -454,23 +454,23 @@ put_error:
 void update_parent_metadata(struct inode *dir, struct inode *inode,
 						unsigned int current_depth)
 {
-	if (inode && is_inode_flag_set(F2FS_I(inode), FI_NEW_INODE)) {
+	if (inode && is_inode_flag_set(inode, FI_NEW_INODE)) {
 		if (S_ISDIR(inode->i_mode)) {
 			inc_nlink(dir);
-			set_inode_flag(F2FS_I(dir), FI_UPDATE_DIR);
+			set_inode_flag(dir, FI_UPDATE_DIR);
 		}
-		clear_inode_flag(F2FS_I(inode), FI_NEW_INODE);
+		clear_inode_flag(inode, FI_NEW_INODE);
 	}
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(dir);
 
 	if (F2FS_I(dir)->i_current_depth != current_depth) {
 		F2FS_I(dir)->i_current_depth = current_depth;
-		set_inode_flag(F2FS_I(dir), FI_UPDATE_DIR);
+		set_inode_flag(dir, FI_UPDATE_DIR);
 	}
 
-	if (inode && is_inode_flag_set(F2FS_I(inode), FI_INC_LINK))
-		clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
+	if (inode && is_inode_flag_set(inode, FI_INC_LINK))
+		clear_inode_flag(inode, FI_INC_LINK);
 }
 
 int room_for_filename(const void *bitmap, int slots, int max_slots)
@@ -607,9 +607,9 @@ fail:
 	if (inode)
 		up_write(&F2FS_I(inode)->i_sem);
 
-	if (is_inode_flag_set(F2FS_I(dir), FI_UPDATE_DIR)) {
+	if (is_inode_flag_set(dir, FI_UPDATE_DIR)) {
 		update_inode_page(dir);
-		clear_inode_flag(F2FS_I(dir), FI_UPDATE_DIR);
+		clear_inode_flag(dir, FI_UPDATE_DIR);
 	}
 	kunmap(dentry_page);
 	f2fs_put_page(dentry_page, 1);
@@ -661,7 +661,7 @@ int f2fs_do_tmpfile(struct inode *inode, struct inode *dir)
 	update_inode(inode, page);
 	f2fs_put_page(page, 1);
 
-	clear_inode_flag(F2FS_I(inode), FI_NEW_INODE);
+	clear_inode_flag(inode, FI_NEW_INODE);
 fail:
 	up_write(&F2FS_I(inode)->i_sem);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 5bfcdb9..852a0b6 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -431,7 +431,7 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 
 	write_lock(&et->lock);
 
-	if (is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT)) {
+	if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
 		write_unlock(&et->lock);
 		return false;
 	}
@@ -523,11 +523,11 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 				prev.len < F2FS_MIN_EXTENT_LEN &&
 				et->largest.len < F2FS_MIN_EXTENT_LEN) {
 			et->largest.len = 0;
-			set_inode_flag(F2FS_I(inode), FI_NO_EXTENT);
+			set_inode_flag(inode, FI_NO_EXTENT);
 		}
 	}
 
-	if (is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT))
+	if (is_inode_flag_set(inode, FI_NO_EXTENT))
 		__free_extent_tree(sbi, et);
 
 	write_unlock(&et->lock);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 916e7c2..9371063 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1533,64 +1533,62 @@ enum {
 	FI_DIRTY_FILE,		/* indicate regular/symlink has dirty pages */
 };
 
-static inline void set_inode_flag(struct f2fs_inode_info *fi, int flag)
+static inline void set_inode_flag(struct inode *inode, int flag)
 {
-	if (!test_bit(flag, &fi->flags))
-		set_bit(flag, &fi->flags);
+	if (!test_bit(flag, &F2FS_I(inode)->flags))
+		set_bit(flag, &F2FS_I(inode)->flags);
 }
 
-static inline int is_inode_flag_set(struct f2fs_inode_info *fi, int flag)
+static inline int is_inode_flag_set(struct inode *inode, int flag)
 {
-	return test_bit(flag, &fi->flags);
+	return test_bit(flag, &F2FS_I(inode)->flags);
 }
 
-static inline void clear_inode_flag(struct f2fs_inode_info *fi, int flag)
+static inline void clear_inode_flag(struct inode *inode, int flag)
 {
-	if (test_bit(flag, &fi->flags))
-		clear_bit(flag, &fi->flags);
+	if (test_bit(flag, &F2FS_I(inode)->flags))
+		clear_bit(flag, &F2FS_I(inode)->flags);
 }
 
-static inline void set_acl_inode(struct f2fs_inode_info *fi, umode_t mode)
+static inline void set_acl_inode(struct inode *inode, umode_t mode)
 {
-	fi->i_acl_mode = mode;
-	set_inode_flag(fi, FI_ACL_MODE);
+	F2FS_I(inode)->i_acl_mode = mode;
+	set_inode_flag(inode, FI_ACL_MODE);
 }
 
-static inline void get_inline_info(struct f2fs_inode_info *fi,
-					struct f2fs_inode *ri)
+static inline void get_inline_info(struct inode *inode, struct f2fs_inode *ri)
 {
 	if (ri->i_inline & F2FS_INLINE_XATTR)
-		set_inode_flag(fi, FI_INLINE_XATTR);
+		set_inode_flag(inode, FI_INLINE_XATTR);
 	if (ri->i_inline & F2FS_INLINE_DATA)
-		set_inode_flag(fi, FI_INLINE_DATA);
+		set_inode_flag(inode, FI_INLINE_DATA);
 	if (ri->i_inline & F2FS_INLINE_DENTRY)
-		set_inode_flag(fi, FI_INLINE_DENTRY);
+		set_inode_flag(inode, FI_INLINE_DENTRY);
 	if (ri->i_inline & F2FS_DATA_EXIST)
-		set_inode_flag(fi, FI_DATA_EXIST);
+		set_inode_flag(inode, FI_DATA_EXIST);
 	if (ri->i_inline & F2FS_INLINE_DOTS)
-		set_inode_flag(fi, FI_INLINE_DOTS);
+		set_inode_flag(inode, FI_INLINE_DOTS);
 }
 
-static inline void set_raw_inline(struct f2fs_inode_info *fi,
-					struct f2fs_inode *ri)
+static inline void set_raw_inline(struct inode *inode, struct f2fs_inode *ri)
 {
 	ri->i_inline = 0;
 
-	if (is_inode_flag_set(fi, FI_INLINE_XATTR))
+	if (is_inode_flag_set(inode, FI_INLINE_XATTR))
 		ri->i_inline |= F2FS_INLINE_XATTR;
-	if (is_inode_flag_set(fi, FI_INLINE_DATA))
+	if (is_inode_flag_set(inode, FI_INLINE_DATA))
 		ri->i_inline |= F2FS_INLINE_DATA;
-	if (is_inode_flag_set(fi, FI_INLINE_DENTRY))
+	if (is_inode_flag_set(inode, FI_INLINE_DENTRY))
 		ri->i_inline |= F2FS_INLINE_DENTRY;
-	if (is_inode_flag_set(fi, FI_DATA_EXIST))
+	if (is_inode_flag_set(inode, FI_DATA_EXIST))
 		ri->i_inline |= F2FS_DATA_EXIST;
-	if (is_inode_flag_set(fi, FI_INLINE_DOTS))
+	if (is_inode_flag_set(inode, FI_INLINE_DOTS))
 		ri->i_inline |= F2FS_INLINE_DOTS;
 }
 
 static inline int f2fs_has_inline_xattr(struct inode *inode)
 {
-	return is_inode_flag_set(F2FS_I(inode), FI_INLINE_XATTR);
+	return is_inode_flag_set(inode, FI_INLINE_XATTR);
 }
 
 static inline unsigned int addrs_per_inode(struct inode *inode)
@@ -1617,43 +1615,43 @@ static inline int inline_xattr_size(struct inode *inode)
 
 static inline int f2fs_has_inline_data(struct inode *inode)
 {
-	return is_inode_flag_set(F2FS_I(inode), FI_INLINE_DATA);
+	return is_inode_flag_set(inode, FI_INLINE_DATA);
 }
 
 static inline void f2fs_clear_inline_inode(struct inode *inode)
 {
-	clear_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
-	clear_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
+	clear_inode_flag(inode, FI_INLINE_DATA);
+	clear_inode_flag(inode, FI_DATA_EXIST);
 }
 
 static inline int f2fs_exist_data(struct inode *inode)
 {
-	return is_inode_flag_set(F2FS_I(inode), FI_DATA_EXIST);
+	return is_inode_flag_set(inode, FI_DATA_EXIST);
 }
 
 static inline int f2fs_has_inline_dots(struct inode *inode)
 {
-	return is_inode_flag_set(F2FS_I(inode), FI_INLINE_DOTS);
+	return is_inode_flag_set(inode, FI_INLINE_DOTS);
 }
 
 static inline bool f2fs_is_atomic_file(struct inode *inode)
 {
-	return is_inode_flag_set(F2FS_I(inode), FI_ATOMIC_FILE);
+	return is_inode_flag_set(inode, FI_ATOMIC_FILE);
 }
 
 static inline bool f2fs_is_volatile_file(struct inode *inode)
 {
-	return is_inode_flag_set(F2FS_I(inode), FI_VOLATILE_FILE);
+	return is_inode_flag_set(inode, FI_VOLATILE_FILE);
 }
 
 static inline bool f2fs_is_first_block_written(struct inode *inode)
 {
-	return is_inode_flag_set(F2FS_I(inode), FI_FIRST_BLOCK_WRITTEN);
+	return is_inode_flag_set(inode, FI_FIRST_BLOCK_WRITTEN);
 }
 
 static inline bool f2fs_is_drop_cache(struct inode *inode)
 {
-	return is_inode_flag_set(F2FS_I(inode), FI_DROP_CACHE);
+	return is_inode_flag_set(inode, FI_DROP_CACHE);
 }
 
 static inline void *inline_data_addr(struct page *page)
@@ -1664,7 +1662,7 @@ static inline void *inline_data_addr(struct page *page)
 
 static inline int f2fs_has_inline_dentry(struct inode *inode)
 {
-	return is_inode_flag_set(F2FS_I(inode), FI_INLINE_DENTRY);
+	return is_inode_flag_set(inode, FI_INLINE_DENTRY);
 }
 
 static inline void f2fs_dentry_kunmap(struct inode *dir, struct page *page)
@@ -1712,7 +1710,7 @@ static inline bool is_dot_dotdot(const struct qstr *str)
 static inline bool f2fs_may_extent_tree(struct inode *inode)
 {
 	if (!test_opt(F2FS_I_SB(inode), EXTENT_CACHE) ||
-			is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT))
+			is_inode_flag_set(inode, FI_NO_EXTENT))
 		return false;
 
 	return S_ISREG(inode->i_mode);
@@ -1748,7 +1746,7 @@ static inline void *f2fs_kvzalloc(size_t size, gfp_t flags)
 }
 
 #define get_inode_mode(i) \
-	((is_inode_flag_set(F2FS_I(i), FI_ACL_MODE)) ? \
+	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
 	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
 
 /* get offset of first page in next direct node */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f4c0086..e68e5ad 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -186,7 +186,6 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 						int datasync, bool atomic)
 {
 	struct inode *inode = file->f_mapping->host;
-	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	nid_t ino = inode->i_ino;
 	int ret = 0;
@@ -204,9 +203,9 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 
 	/* if fdatasync is triggered, let's do in-place-update */
 	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
-		set_inode_flag(fi, FI_NEED_IPU);
+		set_inode_flag(inode, FI_NEED_IPU);
 	ret = filemap_write_and_wait_range(inode->i_mapping, start, end);
-	clear_inode_flag(fi, FI_NEED_IPU);
+	clear_inode_flag(inode, FI_NEED_IPU);
 
 	if (ret) {
 		trace_f2fs_sync_file_exit(inode, need_cp, datasync, ret);
@@ -222,14 +221,14 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	/*
 	 * if there is no written data, don't waste time to write recovery info.
 	 */
-	if (!is_inode_flag_set(fi, FI_APPEND_WRITE) &&
+	if (!is_inode_flag_set(inode, FI_APPEND_WRITE) &&
 			!exist_written_data(sbi, ino, APPEND_INO)) {
 
 		/* it may call write_inode just prior to fsync */
 		if (need_inode_page_update(sbi, ino))
 			goto go_write;
 
-		if (is_inode_flag_set(fi, FI_UPDATE_WRITE) ||
+		if (is_inode_flag_set(inode, FI_UPDATE_WRITE) ||
 				exist_written_data(sbi, ino, UPDATE_INO))
 			goto flush_out;
 		goto out;
@@ -239,9 +238,9 @@ go_write:
 	 * Both of fdatasync() and fsync() are able to be recovered from
 	 * sudden-power-off.
 	 */
-	down_read(&fi->i_sem);
+	down_read(&F2FS_I(inode)->i_sem);
 	need_cp = need_do_checkpoint(inode);
-	up_read(&fi->i_sem);
+	up_read(&F2FS_I(inode)->i_sem);
 
 	if (need_cp) {
 		/* all the dirty node pages should be flushed for POR */
@@ -252,8 +251,8 @@ go_write:
 		 * will be used only for fsynced inodes after checkpoint.
 		 */
 		try_to_fix_pino(inode);
-		clear_inode_flag(fi, FI_APPEND_WRITE);
-		clear_inode_flag(fi, FI_UPDATE_WRITE);
+		clear_inode_flag(inode, FI_APPEND_WRITE);
+		clear_inode_flag(inode, FI_UPDATE_WRITE);
 		goto out;
 	}
 sync_nodes:
@@ -279,10 +278,10 @@ sync_nodes:
 
 	/* once recovery info is written, don't need to tack this */
 	remove_ino_entry(sbi, ino, APPEND_INO);
-	clear_inode_flag(fi, FI_APPEND_WRITE);
+	clear_inode_flag(inode, FI_APPEND_WRITE);
 flush_out:
 	remove_ino_entry(sbi, ino, UPDATE_INO);
-	clear_inode_flag(fi, FI_UPDATE_WRITE);
+	clear_inode_flag(inode, FI_UPDATE_WRITE);
 	ret = f2fs_issue_flush(sbi);
 	f2fs_update_time(sbi, REQ_TIME);
 out:
@@ -487,8 +486,7 @@ int truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 		set_data_blkaddr(dn);
 		invalidate_blocks(sbi, blkaddr);
 		if (dn->ofs_in_node == 0 && IS_INODE(dn->node_page))
-			clear_inode_flag(F2FS_I(dn->inode),
-						FI_FIRST_BLOCK_WRITTEN);
+			clear_inode_flag(dn->inode, FI_FIRST_BLOCK_WRITTEN);
 		nr_free++;
 	}
 
@@ -654,7 +652,6 @@ int f2fs_getattr(struct vfsmount *mnt,
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
 static void __setattr_copy(struct inode *inode, const struct iattr *attr)
 {
-	struct f2fs_inode_info *fi = F2FS_I(inode);
 	unsigned int ia_valid = attr->ia_valid;
 
 	if (ia_valid & ATTR_UID)
@@ -675,7 +672,7 @@ static void __setattr_copy(struct inode *inode, const struct iattr *attr)
 
 		if (!in_group_p(inode->i_gid) && !capable(CAP_FSETID))
 			mode &= ~S_ISGID;
-		set_acl_inode(fi, mode);
+		set_acl_inode(inode, mode);
 	}
 }
 #else
@@ -685,7 +682,6 @@ static void __setattr_copy(struct inode *inode, const struct iattr *attr)
 int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
-	struct f2fs_inode_info *fi = F2FS_I(inode);
 	int err;
 
 	err = inode_change_ok(inode, attr);
@@ -724,9 +720,9 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 
 	if (attr->ia_valid & ATTR_MODE) {
 		err = posix_acl_chmod(inode, get_inode_mode(inode));
-		if (err || is_inode_flag_set(fi, FI_ACL_MODE)) {
-			inode->i_mode = fi->i_acl_mode;
-			clear_inode_flag(fi, FI_ACL_MODE);
+		if (err || is_inode_flag_set(inode, FI_ACL_MODE)) {
+			inode->i_mode = F2FS_I(inode)->i_acl_mode;
+			clear_inode_flag(inode, FI_ACL_MODE);
 		}
 	}
 
@@ -1310,10 +1306,10 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
 	if (f2fs_is_atomic_file(inode))
 		drop_inmem_pages(inode);
 	if (f2fs_is_volatile_file(inode)) {
-		clear_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
-		set_inode_flag(F2FS_I(inode), FI_DROP_CACHE);
+		clear_inode_flag(inode, FI_VOLATILE_FILE);
+		set_inode_flag(inode, FI_DROP_CACHE);
 		filemap_fdatawrite(inode->i_mapping);
-		clear_inode_flag(F2FS_I(inode), FI_DROP_CACHE);
+		clear_inode_flag(inode, FI_DROP_CACHE);
 	}
 	return 0;
 }
@@ -1412,7 +1408,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	if (ret)
 		goto out;
 
-	set_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
+	set_inode_flag(inode, FI_ATOMIC_FILE);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 
 	if (!get_dirty_pages(inode))
@@ -1423,7 +1419,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 					inode->i_ino, get_dirty_pages(inode));
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (ret)
-		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
+		clear_inode_flag(inode, FI_ATOMIC_FILE);
 out:
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
@@ -1448,10 +1444,10 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 		goto err_out;
 
 	if (f2fs_is_atomic_file(inode)) {
-		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
+		clear_inode_flag(inode, FI_ATOMIC_FILE);
 		ret = commit_inmem_pages(inode);
 		if (ret) {
-			set_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
+			set_inode_flag(inode, FI_ATOMIC_FILE);
 			goto err_out;
 		}
 	}
@@ -1484,7 +1480,7 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
 	if (ret)
 		goto out;
 
-	set_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
+	set_inode_flag(inode, FI_VOLATILE_FILE);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 out:
 	inode_unlock(inode);
@@ -1538,7 +1534,7 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 	if (f2fs_is_atomic_file(inode))
 		drop_inmem_pages(inode);
 	if (f2fs_is_volatile_file(inode)) {
-		clear_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
+		clear_inode_flag(inode, FI_VOLATILE_FILE);
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
 	}
 
@@ -1871,7 +1867,7 @@ do_map:
 			continue;
 		}
 
-		set_inode_flag(F2FS_I(inode), FI_DO_DEFRAG);
+		set_inode_flag(inode, FI_DO_DEFRAG);
 
 		idx = map.m_lblk;
 		while (idx < map.m_lblk + map.m_len && cnt < blk_per_seg) {
@@ -1896,14 +1892,14 @@ do_map:
 		if (idx < pg_end && cnt < blk_per_seg)
 			goto do_map;
 
-		clear_inode_flag(F2FS_I(inode), FI_DO_DEFRAG);
+		clear_inode_flag(inode, FI_DO_DEFRAG);
 
 		err = filemap_fdatawrite(inode->i_mapping);
 		if (err)
 			goto out;
 	}
 clear_out:
-	clear_inode_flag(F2FS_I(inode), FI_DO_DEFRAG);
+	clear_inode_flag(inode, FI_DO_DEFRAG);
 out:
 	inode_unlock(inode);
 	if (!err)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 38d56f6..4a03076 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -617,9 +617,9 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 	f2fs_submit_page_mbio(&fio);
 
 	f2fs_update_data_blkaddr(&dn, newaddr);
-	set_inode_flag(F2FS_I(inode), FI_APPEND_WRITE);
+	set_inode_flag(inode, FI_APPEND_WRITE);
 	if (page->index == 0)
-		set_inode_flag(F2FS_I(inode), FI_FIRST_BLOCK_WRITTEN);
+		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 put_page_out:
 	f2fs_put_page(fio.encrypted_page, 1);
 recover_block:
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index a4bb155..c50dee9 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -138,7 +138,7 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 		inode_dec_dirty_pages(dn->inode);
 
 	/* this converted inline_data should be recovered. */
-	set_inode_flag(F2FS_I(dn->inode), FI_APPEND_WRITE);
+	set_inode_flag(dn->inode, FI_APPEND_WRITE);
 
 	/* clear inline data and flag after data writeback */
 	truncate_inline_inode(dn->inode_page, 0);
@@ -213,8 +213,8 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 	memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
 	kunmap_atomic(src_addr);
 
-	set_inode_flag(F2FS_I(inode), FI_APPEND_WRITE);
-	set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
+	set_inode_flag(inode, FI_APPEND_WRITE);
+	set_inode_flag(inode, FI_DATA_EXIST);
 
 	sync_inode_page(&dn);
 	clear_inline_node(dn.inode_page);
@@ -252,8 +252,8 @@ process_inline:
 		dst_addr = inline_data_addr(ipage);
 		memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
 
-		set_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
-		set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
+		set_inode_flag(inode, FI_INLINE_DATA);
+		set_inode_flag(inode, FI_DATA_EXIST);
 
 		update_inode(inode, ipage);
 		f2fs_put_page(ipage, 1);
@@ -341,7 +341,7 @@ int make_empty_inline_dir(struct inode *inode, struct inode *parent,
 	/* update i_size to MAX_INLINE_DATA */
 	if (i_size_read(inode) < MAX_INLINE_DATA) {
 		i_size_write(inode, MAX_INLINE_DATA);
-		set_inode_flag(F2FS_I(inode), FI_UPDATE_DIR);
+		set_inode_flag(inode, FI_UPDATE_DIR);
 	}
 	return 0;
 }
@@ -398,12 +398,12 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 	truncate_inline_inode(ipage, 0);
 
 	stat_dec_inline_dir(dir);
-	clear_inode_flag(F2FS_I(dir), FI_INLINE_DENTRY);
+	clear_inode_flag(dir, FI_INLINE_DENTRY);
 
 	F2FS_I(dir)->i_current_depth = 1;
 	if (i_size_read(dir) < PAGE_SIZE) {
 		i_size_write(dir, PAGE_SIZE);
-		set_inode_flag(F2FS_I(dir), FI_UPDATE_DIR);
+		set_inode_flag(dir, FI_UPDATE_DIR);
 	}
 
 	sync_inode_page(&dn);
@@ -464,7 +464,6 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct page *ipage,
 				struct f2fs_inline_dentry *inline_dentry)
 {
 	struct f2fs_inline_dentry *backup_dentry;
-	struct f2fs_inode_info *fi = F2FS_I(dir);
 	int err;
 
 	backup_dentry = f2fs_kmalloc(sizeof(struct f2fs_inline_dentry),
@@ -486,14 +485,14 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct page *ipage,
 	lock_page(ipage);
 
 	stat_dec_inline_dir(dir);
-	clear_inode_flag(fi, FI_INLINE_DENTRY);
+	clear_inode_flag(dir, FI_INLINE_DENTRY);
 	update_inode(dir, ipage);
 	kfree(backup_dentry);
 	return 0;
 recover:
 	lock_page(ipage);
 	memcpy(inline_dentry, backup_dentry, MAX_INLINE_DATA);
-	fi->i_current_depth = 0;
+	F2FS_I(dir)->i_current_depth = 0;
 	i_size_write(dir, MAX_INLINE_DATA);
 	update_inode(dir, ipage);
 	f2fs_put_page(ipage, 1);
@@ -569,9 +568,9 @@ fail:
 	if (inode)
 		up_write(&F2FS_I(inode)->i_sem);
 
-	if (is_inode_flag_set(F2FS_I(dir), FI_UPDATE_DIR)) {
+	if (is_inode_flag_set(dir, FI_UPDATE_DIR)) {
 		update_inode(dir, ipage);
-		clear_inode_flag(F2FS_I(dir), FI_UPDATE_DIR);
+		clear_inode_flag(dir, FI_UPDATE_DIR);
 	}
 out:
 	f2fs_put_page(ipage, 1);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 2e68ada..62d8c90 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -85,8 +85,8 @@ static void __recover_inline_status(struct inode *inode, struct page *ipage)
 		if (*start++) {
 			f2fs_wait_on_page_writeback(ipage, NODE, true);
 
-			set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
-			set_raw_inline(F2FS_I(inode), F2FS_INODE(ipage));
+			set_inode_flag(inode, FI_DATA_EXIST);
+			set_raw_inline(inode, F2FS_INODE(ipage));
 			set_page_dirty(ipage);
 			return;
 		}
@@ -141,7 +141,7 @@ static int do_read_inode(struct inode *inode)
 	if (f2fs_init_extent_tree(inode, &ri->i_ext))
 		set_page_dirty(node_page);
 
-	get_inline_info(fi, ri);
+	get_inline_info(inode, ri);
 
 	/* check data exist */
 	if (f2fs_has_inline_data(inode) && !f2fs_exist_data(inode))
@@ -151,7 +151,7 @@ static int do_read_inode(struct inode *inode)
 	__get_inode_rdev(inode, ri);
 
 	if (__written_first_block(ri))
-		set_inode_flag(F2FS_I(inode), FI_FIRST_BLOCK_WRITTEN);
+		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 
 	f2fs_put_page(node_page, 1);
 
@@ -244,7 +244,7 @@ int update_inode(struct inode *inode, struct page *node_page)
 							&ri->i_ext);
 	else
 		memset(&ri->i_ext, 0, sizeof(ri->i_ext));
-	set_raw_inline(F2FS_I(inode), ri);
+	set_raw_inline(inode, ri);
 
 	ri->i_atime = cpu_to_le64(inode->i_atime.tv_sec);
 	ri->i_ctime = cpu_to_le64(inode->i_ctime.tv_sec);
@@ -261,7 +261,7 @@ int update_inode(struct inode *inode, struct page *node_page)
 
 	__set_inode_rdev(inode, ri);
 	set_cold_node(inode, node_page);
-	clear_inode_flag(F2FS_I(inode), FI_DIRTY_INODE);
+	clear_inode_flag(inode, FI_DIRTY_INODE);
 
 	/* deleted inode */
 	if (inode->i_nlink == 0)
@@ -300,7 +300,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 			inode->i_ino == F2FS_META_INO(sbi))
 		return 0;
 
-	if (!is_inode_flag_set(F2FS_I(inode), FI_DIRTY_INODE))
+	if (!is_inode_flag_set(inode, FI_DIRTY_INODE))
 		return 0;
 
 	/*
@@ -318,8 +318,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 void f2fs_evict_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-	nid_t xnid = fi->i_xattr_nid;
+	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
 	int err = 0;
 
 	/* some remained atomic pages should discarded */
@@ -342,7 +341,7 @@ void f2fs_evict_inode(struct inode *inode)
 		goto no_delete;
 
 	sb_start_intwrite(inode->i_sb);
-	set_inode_flag(fi, FI_NO_ALLOC);
+	set_inode_flag(inode, FI_NO_ALLOC);
 	i_size_write(inode, 0);
 retry:
 	if (F2FS_HAS_BLOCKS(inode))
@@ -369,13 +368,13 @@ no_delete:
 	invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino, inode->i_ino);
 	if (xnid)
 		invalidate_mapping_pages(NODE_MAPPING(sbi), xnid, xnid);
-	if (is_inode_flag_set(fi, FI_APPEND_WRITE))
+	if (is_inode_flag_set(inode, FI_APPEND_WRITE))
 		add_ino_entry(sbi, inode->i_ino, APPEND_INO);
-	if (is_inode_flag_set(fi, FI_UPDATE_WRITE))
+	if (is_inode_flag_set(inode, FI_UPDATE_WRITE))
 		add_ino_entry(sbi, inode->i_ino, UPDATE_INO);
-	if (is_inode_flag_set(fi, FI_FREE_NID)) {
+	if (is_inode_flag_set(inode, FI_FREE_NID)) {
 		alloc_nid_failed(sbi, inode->i_ino);
-		clear_inode_flag(fi, FI_FREE_NID);
+		clear_inode_flag(inode, FI_FREE_NID);
 	}
 	f2fs_bug_on(sbi, err &&
 		!exist_written_data(sbi, inode->i_ino, ORPHAN_INO));
@@ -411,7 +410,7 @@ void handle_failed_inode(struct inode *inode)
 		}
 		alloc_nid_done(sbi, inode->i_ino);
 	} else {
-		set_inode_flag(F2FS_I(inode), FI_FREE_NID);
+		set_inode_flag(inode, FI_FREE_NID);
 	}
 
 	f2fs_unlock_op(sbi);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 324ed38..cbf61a5 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -60,10 +60,14 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode))
 		f2fs_set_encrypted_inode(inode);
 
+	set_inode_flag(inode, FI_NEW_INODE);
+
+	if (test_opt(sbi, INLINE_XATTR))
+		set_inode_flag(inode, FI_INLINE_XATTR);
 	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
-		set_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
+		set_inode_flag(inode, FI_INLINE_DATA);
 	if (f2fs_may_inline_dentry(inode))
-		set_inode_flag(F2FS_I(inode), FI_INLINE_DENTRY);
+		set_inode_flag(inode, FI_INLINE_DENTRY);
 
 	f2fs_init_extent_tree(inode, NULL);
 
@@ -79,7 +83,7 @@ fail:
 	trace_f2fs_new_inode(inode, err);
 	make_bad_inode(inode);
 	if (nid_free)
-		set_inode_flag(F2FS_I(inode), FI_FREE_NID);
+		set_inode_flag(inode, FI_FREE_NID);
 	iput(inode);
 	return ERR_PTR(err);
 }
@@ -177,7 +181,7 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 	inode->i_ctime = CURRENT_TIME;
 	ihold(inode);
 
-	set_inode_flag(F2FS_I(inode), FI_INC_LINK);
+	set_inode_flag(inode, FI_INC_LINK);
 	f2fs_lock_op(sbi);
 	err = f2fs_add_link(dentry, inode);
 	if (err)
@@ -190,7 +194,7 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 		f2fs_sync_fs(sbi->sb, 1);
 	return 0;
 out:
-	clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
+	clear_inode_flag(inode, FI_INC_LINK);
 	iput(inode);
 	f2fs_unlock_op(sbi);
 	return err;
@@ -244,7 +248,7 @@ static int __recover_dot_dentries(struct inode *dir, nid_t pino)
 	}
 out:
 	if (!err) {
-		clear_inode_flag(F2FS_I(dir), FI_INLINE_DOTS);
+		clear_inode_flag(dir, FI_INLINE_DOTS);
 		mark_inode_dirty(dir);
 	}
 
@@ -492,7 +496,7 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 
 	f2fs_balance_fs(sbi, true);
 
-	set_inode_flag(F2FS_I(inode), FI_INC_LINK);
+	set_inode_flag(inode, FI_INC_LINK);
 	f2fs_lock_op(sbi);
 	err = f2fs_add_link(dentry, inode);
 	if (err)
@@ -509,7 +513,7 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	return 0;
 
 out_fail:
-	clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
+	clear_inode_flag(inode, FI_INC_LINK);
 	handle_failed_inode(inode);
 	return err;
 }
@@ -763,7 +767,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	if (whiteout) {
 		whiteout->i_state |= I_LINKABLE;
-		set_inode_flag(F2FS_I(whiteout), FI_INC_LINK);
+		set_inode_flag(whiteout, FI_INC_LINK);
 		err = f2fs_add_link(old_dentry, whiteout);
 		if (err)
 			goto put_out_dir;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1f21aae..8001020 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1019,7 +1019,7 @@ struct page *new_node_page(struct dnode_of_data *dn,
 	struct page *page;
 	int err;
 
-	if (unlikely(is_inode_flag_set(F2FS_I(dn->inode), FI_NO_ALLOC)))
+	if (unlikely(is_inode_flag_set(dn->inode, FI_NO_ALLOC)))
 		return ERR_PTR(-EPERM);
 
 	page = f2fs_grab_cache_page(NODE_MAPPING(sbi), dn->nid, false);
@@ -1955,7 +1955,7 @@ void recover_inline_xattr(struct inode *inode, struct page *page)
 
 	ri = F2FS_INODE(page);
 	if (!(ri->i_inline & F2FS_INLINE_XATTR)) {
-		clear_inode_flag(F2FS_I(inode), FI_INLINE_XATTR);
+		clear_inode_flag(inode, FI_INLINE_XATTR);
 		goto update_inode;
 	}
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2e6f537..77dc929 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -241,7 +241,7 @@ void drop_inmem_pages(struct inode *inode)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 
-	clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
+	clear_inode_flag(inode, FI_ATOMIC_FILE);
 
 	mutex_lock(&fi->inmem_lock);
 	__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 7a756ff..fcdd731 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -544,7 +544,7 @@ static inline bool need_inplace_update(struct inode *inode)
 
 	/* this is only set during fdatasync */
 	if (policy & (0x1 << F2FS_IPU_FSYNC) &&
-			is_inode_flag_set(F2FS_I(inode), FI_NEED_IPU))
+			is_inode_flag_set(inode, FI_NEED_IPU))
 		return true;
 
 	return false;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 74cc852..160b15b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -540,11 +540,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&fi->inmem_pages);
 	mutex_init(&fi->inmem_lock);
 
-	set_inode_flag(fi, FI_NEW_INODE);
-
-	if (test_opt(F2FS_SB(sb), INLINE_XATTR))
-		set_inode_flag(fi, FI_INLINE_XATTR);
-
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
 	return &fi->vfs_inode;
@@ -596,7 +591,7 @@ static int f2fs_drop_inode(struct inode *inode)
  */
 static void f2fs_dirty_inode(struct inode *inode, int flags)
 {
-	set_inode_flag(F2FS_I(inode), FI_DIRTY_INODE);
+	set_inode_flag(inode, FI_DIRTY_INODE);
 }
 
 static void f2fs_i_callback(struct rcu_head *head)
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 00ea567..76ca827 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -441,7 +441,6 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 			const char *name, const void *value, size_t size,
 			struct page *ipage, int flags)
 {
-	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_xattr_entry *here, *last;
 	void *base_addr;
 	int found, newsize;
@@ -539,10 +538,10 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (error)
 		goto exit;
 
-	if (is_inode_flag_set(fi, FI_ACL_MODE)) {
-		inode->i_mode = fi->i_acl_mode;
+	if (is_inode_flag_set(inode, FI_ACL_MODE)) {
+		inode->i_mode = F2FS_I(inode)->i_acl_mode;
 		inode->i_ctime = CURRENT_TIME;
-		clear_inode_flag(fi, FI_ACL_MODE);
+		clear_inode_flag(inode, FI_ACL_MODE);
 	}
 	if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
 			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
-- 
2.6.3


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
