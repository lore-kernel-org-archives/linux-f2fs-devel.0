From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 07/12] f2fs: remove syncing inode page in all the
	cases
Date: Tue, 24 May 2016 17:03:33 -0700
Message-ID: <1464134619-37015-7-git-send-email-jaegeuk@kernel.org>
References: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b5MIu-00059o-1a
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 May 2016 00:04:04 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b5MIs-0001xG-Dv
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 May 2016 00:04:04 +0000
In-Reply-To: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
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

This patch reduces to call them across the whole tree.
- sync_inode_page()
- update_inode_page()
- update_inode()
- f2fs_write_inode()

Instead, checkpoint will flush all the dirty inode metadata before syncing
node pages.
Note that, this is doable, since we call mark_inode_dirty_sync() for all
inode's field change which needs to update on-disk inode as well.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c         | 11 +----------
 fs/f2fs/dir.c          | 24 +++---------------------
 fs/f2fs/extent_cache.c |  7 ++-----
 fs/f2fs/f2fs.h         |  2 --
 fs/f2fs/file.c         | 15 +++------------
 fs/f2fs/inline.c       | 27 ++++++---------------------
 fs/f2fs/namei.c        | 15 +--------------
 fs/f2fs/node.c         | 28 ----------------------------
 fs/f2fs/recovery.c     |  3 ---
 fs/f2fs/xattr.c        |  6 +-----
 10 files changed, 17 insertions(+), 121 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6a4c60c..a3dea51 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -343,8 +343,6 @@ int reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
 
 	if (set_page_dirty(dn->node_page))
 		dn->node_changed = true;
-
-	sync_inode_page(dn);
 	return 0;
 }
 
@@ -562,11 +560,8 @@ struct page *get_new_data_page(struct inode *inode,
 	}
 got_it:
 	if (new_i_size && i_size_read(inode) <
-				((loff_t)(index + 1) << PAGE_SHIFT)) {
+				((loff_t)(index + 1) << PAGE_SHIFT))
 		f2fs_i_size_write(inode, ((loff_t)(index + 1) << PAGE_SHIFT));
-		/* Only the directory inode sets new_i_size */
-		set_inode_flag(inode, FI_UPDATE_DIR);
-	}
 	return page;
 }
 
@@ -787,8 +782,6 @@ skip:
 	else if (dn.ofs_in_node < end_offset)
 		goto next_block;
 
-	if (allocated)
-		sync_inode_page(&dn);
 	f2fs_put_dnode(&dn);
 
 	if (create) {
@@ -799,8 +792,6 @@ skip:
 	goto next_dnode;
 
 sync_out:
-	if (allocated)
-		sync_inode_page(&dn);
 	f2fs_put_dnode(&dn);
 unlock_out:
 	if (create) {
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 384d51c..24d1308 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -454,19 +454,15 @@ void update_parent_metadata(struct inode *dir, struct inode *inode,
 						unsigned int current_depth)
 {
 	if (inode && is_inode_flag_set(inode, FI_NEW_INODE)) {
-		if (S_ISDIR(inode->i_mode)) {
+		if (S_ISDIR(inode->i_mode))
 			f2fs_i_links_write(dir, true);
-			set_inode_flag(dir, FI_UPDATE_DIR);
-		}
 		clear_inode_flag(inode, FI_NEW_INODE);
 	}
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	mark_inode_dirty_sync(dir);
 
-	if (F2FS_I(dir)->i_current_depth != current_depth) {
+	if (F2FS_I(dir)->i_current_depth != current_depth)
 		f2fs_i_depth_write(dir, current_depth);
-		set_inode_flag(dir, FI_UPDATE_DIR);
-	}
 
 	if (inode && is_inode_flag_set(inode, FI_INC_LINK))
 		clear_inode_flag(inode, FI_INC_LINK);
@@ -595,9 +591,7 @@ add_dentry:
 	set_page_dirty(dentry_page);
 
 	if (inode) {
-		/* we don't need to mark_inode_dirty now */
 		f2fs_i_pino_write(inode, dir->i_ino);
-		update_inode(inode, page);
 		f2fs_put_page(page, 1);
 	}
 
@@ -606,10 +600,6 @@ fail:
 	if (inode)
 		up_write(&F2FS_I(inode)->i_sem);
 
-	if (is_inode_flag_set(dir, FI_UPDATE_DIR)) {
-		update_inode_page(dir);
-		clear_inode_flag(dir, FI_UPDATE_DIR);
-	}
 	kunmap(dentry_page);
 	f2fs_put_page(dentry_page, 1);
 
@@ -656,8 +646,6 @@ int f2fs_do_tmpfile(struct inode *inode, struct inode *dir)
 		err = PTR_ERR(page);
 		goto fail;
 	}
-	/* we don't need to mark_inode_dirty now */
-	update_inode(inode, page);
 	f2fs_put_page(page, 1);
 
 	clear_inode_flag(inode, FI_NEW_INODE);
@@ -673,13 +661,8 @@ void f2fs_drop_nlink(struct inode *dir, struct inode *inode, struct page *page)
 
 	down_write(&F2FS_I(inode)->i_sem);
 
-	if (S_ISDIR(inode->i_mode)) {
+	if (S_ISDIR(inode->i_mode))
 		f2fs_i_links_write(dir, false);
-		if (page)
-			update_inode(dir, page);
-		else
-			update_inode_page(dir);
-	}
 	inode->i_ctime = CURRENT_TIME;
 
 	f2fs_i_links_write(inode, false);
@@ -688,7 +671,6 @@ void f2fs_drop_nlink(struct inode *dir, struct inode *inode, struct page *page)
 		f2fs_i_size_write(inode, 0);
 	}
 	up_write(&F2FS_I(inode)->i_sem);
-	update_inode_page(inode);
 
 	if (inode->i_nlink == 0)
 		add_orphan_inode(sbi, inode->i_ino);
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index d21dda6..e858869 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -689,9 +689,7 @@ void f2fs_update_extent_cache(struct dnode_of_data *dn)
 
 	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), dn->inode) +
 								dn->ofs_in_node;
-
-	if (f2fs_update_extent_tree_range(dn->inode, fofs, blkaddr, 1))
-		sync_inode_page(dn);
+	f2fs_update_extent_tree_range(dn->inode, fofs, blkaddr, 1);
 }
 
 void f2fs_update_extent_cache_range(struct dnode_of_data *dn,
@@ -701,8 +699,7 @@ void f2fs_update_extent_cache_range(struct dnode_of_data *dn,
 	if (!f2fs_may_extent_tree(dn->inode))
 		return;
 
-	if (f2fs_update_extent_tree_range(dn->inode, fofs, blkaddr, len))
-		sync_inode_page(dn);
+	f2fs_update_extent_tree_range(dn->inode, fofs, blkaddr, len);
 }
 
 void init_extent_cache_info(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d89a651..6d26b32 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1521,7 +1521,6 @@ enum {
 	FI_ACL_MODE,		/* indicate acl mode */
 	FI_NO_ALLOC,		/* should not allocate any blocks */
 	FI_FREE_NID,		/* free allocated nide */
-	FI_UPDATE_DIR,		/* should update inode block for consistency */
 	FI_NO_EXTENT,		/* not to use the extent cache */
 	FI_INLINE_XATTR,	/* used for inline xattr */
 	FI_INLINE_DATA,		/* used for inline data*/
@@ -1932,7 +1931,6 @@ struct page *new_node_page(struct dnode_of_data *, unsigned int, struct page *);
 void ra_node_page(struct f2fs_sb_info *, nid_t);
 struct page *get_node_page(struct f2fs_sb_info *, pgoff_t);
 struct page *get_node_page_ra(struct page *, int);
-void sync_inode_page(struct dnode_of_data *);
 void move_node_page(struct page *, int);
 int fsync_node_pages(struct f2fs_sb_info *, nid_t, struct writeback_control *,
 								bool);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e8d95e9..6dd64dc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -173,12 +173,8 @@ static void try_to_fix_pino(struct inode *inode)
 			get_parent_ino(inode, &pino)) {
 		f2fs_i_pino_write(inode, pino);
 		file_got_pino(inode);
-		up_write(&fi->i_sem);
-
-		f2fs_write_inode(inode, NULL);
-	} else {
-		up_write(&fi->i_sem);
 	}
+	up_write(&fi->i_sem);
 }
 
 static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
@@ -499,7 +495,6 @@ int truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 							dn->inode) + ofs;
 		f2fs_update_extent_cache_range(dn, fofs, 0, len);
 		dec_valid_block_count(sbi, dn->inode, nr_free);
-		sync_inode_page(dn);
 	}
 	dn->ofs_in_node = ofs;
 
@@ -1123,10 +1118,8 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	}
 
 out:
-	if (!(mode & FALLOC_FL_KEEP_SIZE) && i_size_read(inode) < new_size) {
+	if (!(mode & FALLOC_FL_KEEP_SIZE) && i_size_read(inode) < new_size)
 		f2fs_i_size_write(inode, new_size);
-		update_inode_page(inode);
-	}
 
 	return ret;
 }
@@ -1232,10 +1225,8 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 		new_size = ((loff_t)pg_end << PAGE_SHIFT) + off_end;
 	}
 
-	if (!(mode & FALLOC_FL_KEEP_SIZE) && i_size_read(inode) < new_size) {
+	if (!(mode & FALLOC_FL_KEEP_SIZE) && i_size_read(inode) < new_size)
 		f2fs_i_size_write(inode, new_size);
-		update_inode_page(inode);
-	}
 
 	return ret;
 }
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 4bc025c..77c9c24 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -73,7 +73,7 @@ bool truncate_inline_inode(struct page *ipage, u64 from)
 
 	f2fs_wait_on_page_writeback(ipage, NODE, true);
 	memset(addr + from, 0, MAX_INLINE_DATA - from);
-
+	set_page_dirty(ipage);
 	return true;
 }
 
@@ -146,7 +146,6 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 clear_out:
 	stat_dec_inline_inode(dn->inode);
 	f2fs_clear_inline_inode(dn->inode);
-	sync_inode_page(dn);
 	f2fs_put_dnode(dn);
 	return 0;
 }
@@ -212,11 +211,11 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 	dst_addr = inline_data_addr(dn.inode_page);
 	memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
 	kunmap_atomic(src_addr);
+	set_page_dirty(dn.inode_page);
 
 	set_inode_flag(inode, FI_APPEND_WRITE);
 	set_inode_flag(inode, FI_DATA_EXIST);
 
-	sync_inode_page(&dn);
 	clear_inline_node(dn.inode_page);
 	f2fs_put_dnode(&dn);
 	return 0;
@@ -255,7 +254,7 @@ process_inline:
 		set_inode_flag(inode, FI_INLINE_DATA);
 		set_inode_flag(inode, FI_DATA_EXIST);
 
-		update_inode(inode, ipage);
+		set_page_dirty(ipage);
 		f2fs_put_page(ipage, 1);
 		return true;
 	}
@@ -266,7 +265,6 @@ process_inline:
 		if (!truncate_inline_inode(ipage, 0))
 			return false;
 		f2fs_clear_inline_inode(inode);
-		update_inode(inode, ipage);
 		f2fs_put_page(ipage, 1);
 	} else if (ri && (ri->i_inline & F2FS_INLINE_DATA)) {
 		if (truncate_blocks(inode, 0, false))
@@ -339,10 +337,8 @@ int make_empty_inline_dir(struct inode *inode, struct inode *parent,
 	set_page_dirty(ipage);
 
 	/* update i_size to MAX_INLINE_DATA */
-	if (i_size_read(inode) < MAX_INLINE_DATA) {
+	if (i_size_read(inode) < MAX_INLINE_DATA)
 		f2fs_i_size_write(inode, MAX_INLINE_DATA);
-		set_inode_flag(inode, FI_UPDATE_DIR);
-	}
 	return 0;
 }
 
@@ -401,12 +397,8 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 	clear_inode_flag(dir, FI_INLINE_DENTRY);
 
 	f2fs_i_depth_write(dir, 1);
-	if (i_size_read(dir) < PAGE_SIZE) {
+	if (i_size_read(dir) < PAGE_SIZE)
 		f2fs_i_size_write(dir, PAGE_SIZE);
-		set_inode_flag(dir, FI_UPDATE_DIR);
-	}
-
-	sync_inode_page(&dn);
 out:
 	f2fs_put_page(page, 1);
 	return err;
@@ -486,7 +478,6 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct page *ipage,
 
 	stat_dec_inline_dir(dir);
 	clear_inode_flag(dir, FI_INLINE_DENTRY);
-	update_inode(dir, ipage);
 	kfree(backup_dentry);
 	return 0;
 recover:
@@ -494,7 +485,7 @@ recover:
 	memcpy(inline_dentry, backup_dentry, MAX_INLINE_DATA);
 	f2fs_i_depth_write(dir, 0);
 	f2fs_i_size_write(dir, MAX_INLINE_DATA);
-	update_inode(dir, ipage);
+	set_page_dirty(ipage);
 	f2fs_put_page(ipage, 1);
 
 	kfree(backup_dentry);
@@ -559,7 +550,6 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *name,
 	/* we don't need to mark_inode_dirty now */
 	if (inode) {
 		f2fs_i_pino_write(inode, dir->i_ino);
-		update_inode(inode, page);
 		f2fs_put_page(page, 1);
 	}
 
@@ -567,11 +557,6 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *name,
 fail:
 	if (inode)
 		up_write(&F2FS_I(inode)->i_sem);
-
-	if (is_inode_flag_set(dir, FI_UPDATE_DIR)) {
-		update_inode(dir, ipage);
-		clear_inode_flag(dir, FI_UPDATE_DIR);
-	}
 out:
 	f2fs_put_page(ipage, 1);
 	return err;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 5746fb2..059c578 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -706,9 +706,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			add_orphan_inode(sbi, new_inode->i_ino);
 		else
 			release_orphan_inode(sbi);
-
-		update_inode_page(old_inode);
-		update_inode_page(new_inode);
 	} else {
 		f2fs_balance_fs(sbi, true);
 
@@ -720,10 +717,8 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			goto out_whiteout;
 		}
 
-		if (old_dir_entry) {
+		if (old_dir_entry)
 			f2fs_i_links_write(new_dir, true);
-			update_inode_page(new_dir);
-		}
 
 		/*
 		 * old entry and new entry can locate in the same inline
@@ -771,13 +766,11 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		if (old_dir != new_dir && !whiteout) {
 			f2fs_set_link(old_inode, old_dir_entry,
 						old_dir_page, new_dir);
-			update_inode_page(old_inode);
 		} else {
 			f2fs_dentry_kunmap(old_inode, old_dir_page);
 			f2fs_put_page(old_dir_page, 0);
 		}
 		f2fs_i_links_write(old_dir, false);
-		update_inode_page(old_dir);
 	}
 
 	f2fs_unlock_op(sbi);
@@ -899,8 +892,6 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	file_lost_pino(old_inode);
 	up_write(&F2FS_I(old_inode)->i_sem);
 
-	update_inode_page(old_inode);
-
 	old_dir->i_ctime = CURRENT_TIME;
 	if (old_nlink) {
 		down_write(&F2FS_I(old_dir)->i_sem);
@@ -908,7 +899,6 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		up_write(&F2FS_I(old_dir)->i_sem);
 	}
 	mark_inode_dirty_sync(old_dir);
-	update_inode_page(old_dir);
 
 	/* update directory entry info of new dir inode */
 	f2fs_set_link(new_dir, new_entry, new_page, old_inode);
@@ -917,8 +907,6 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	file_lost_pino(new_inode);
 	up_write(&F2FS_I(new_inode)->i_sem);
 
-	update_inode_page(new_inode);
-
 	new_dir->i_ctime = CURRENT_TIME;
 	if (new_nlink) {
 		down_write(&F2FS_I(new_dir)->i_sem);
@@ -926,7 +914,6 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		up_write(&F2FS_I(new_dir)->i_sem);
 	}
 	mark_inode_dirty_sync(new_dir);
-	update_inode_page(new_dir);
 
 	f2fs_unlock_op(sbi);
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 0635304..b90125d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -670,8 +670,6 @@ static void truncate_node(struct dnode_of_data *dn)
 	if (dn->nid == dn->inode->i_ino) {
 		remove_orphan_inode(sbi, dn->nid);
 		dec_valid_inode_count(sbi);
-	} else {
-		sync_inode_page(dn);
 	}
 invalidate:
 	clear_node_page_dirty(dn->node_page);
@@ -1049,14 +1047,8 @@ struct page *new_node_page(struct dnode_of_data *dn,
 	if (f2fs_has_xattr_block(ofs))
 		f2fs_i_xnid_write(dn->inode, dn->nid);
 
-	dn->node_page = page;
-	if (ipage)
-		update_inode(dn->inode, ipage);
-	else
-		sync_inode_page(dn);
 	if (ofs == 0)
 		inc_valid_inode_count(sbi);
-
 	return page;
 
 fail:
@@ -1175,24 +1167,6 @@ struct page *get_node_page_ra(struct page *parent, int start)
 	return __get_node_page(sbi, nid, parent, start);
 }
 
-void sync_inode_page(struct dnode_of_data *dn)
-{
-	int ret = 0;
-
-	if (IS_INODE(dn->node_page) || dn->inode_page == dn->node_page) {
-		ret = update_inode(dn->inode, dn->node_page);
-	} else if (dn->inode_page) {
-		if (!dn->inode_page_locked)
-			lock_page(dn->inode_page);
-		ret = update_inode(dn->inode, dn->inode_page);
-		if (!dn->inode_page_locked)
-			unlock_page(dn->inode_page);
-	} else {
-		ret = update_inode_page(dn->inode);
-	}
-	dn->node_changed = ret ? true: false;
-}
-
 static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	struct inode *inode;
@@ -2002,8 +1976,6 @@ recover_xnid:
 	/* 3: update xattr blkaddr */
 	refresh_sit_entry(sbi, NEW_ADDR, blkaddr);
 	set_node_addr(sbi, &ni, blkaddr, false);
-
-	update_inode_page(inode);
 }
 
 int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 2500b6a..68c433f 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -490,9 +490,6 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		}
 	}
 
-	if (IS_INODE(dn.node_page))
-		sync_inode_page(&dn);
-
 	copy_node_footer(dn.node_page, page);
 	fill_node_footer(dn.node_page, dn.nid, ni.ino,
 					ofs_of_node(page), false);
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 745382e..af04f53 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -299,6 +299,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 		if (ipage) {
 			inline_addr = inline_xattr_addr(ipage);
 			f2fs_wait_on_page_writeback(ipage, NODE, true);
+			set_page_dirty(ipage);
 		} else {
 			page = get_node_page(sbi, inode->i_ino);
 			if (IS_ERR(page)) {
@@ -547,11 +548,6 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
 			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
 		f2fs_set_encrypted_inode(inode);
-
-	if (ipage)
-		update_inode(inode, ipage);
-	else
-		update_inode_page(inode);
 exit:
 	kzfree(base_addr);
 	return error;
-- 
2.6.3


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
