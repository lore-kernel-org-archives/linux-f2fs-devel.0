From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 08/12] f2fs: avoid unnecessary updating inode during fsync
Date: Tue, 24 May 2016 17:03:34 -0700
Message-ID: <1464134619-37015-8-git-send-email-jaegeuk@kernel.org>
References: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If roll-forward recovery can recover i_size, we don't need to update inode's
metadata during fsync.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c     |  3 +++
 fs/f2fs/f2fs.h     | 23 +++++++++++++++++++++--
 fs/f2fs/file.c     |  4 ++--
 fs/f2fs/inode.c    |  3 +++
 fs/f2fs/node.c     |  9 +++++++--
 fs/f2fs/recovery.c |  3 +++
 fs/f2fs/super.c    |  4 ++++
 7 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a3dea51..287582e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1204,6 +1204,7 @@ static int f2fs_write_data_page(struct page *page,
 	loff_t i_size = i_size_read(inode);
 	const pgoff_t end_index = ((unsigned long long) i_size)
 							>> PAGE_SHIFT;
+	loff_t psize = (page->index + 1) << PAGE_SHIFT;
 	unsigned offset = 0;
 	bool need_balance_fs = false;
 	int err = 0;
@@ -1265,6 +1266,8 @@ write:
 		err = f2fs_write_inline_data(inode, page);
 	if (err == -EAGAIN)
 		err = do_write_data_page(&fio);
+	if (F2FS_I(inode)->last_disk_size < psize)
+		F2FS_I(inode)->last_disk_size = psize;
 	f2fs_unlock_op(sbi);
 done:
 	if (err && err != -ENOENT)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6d26b32..917cc9b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -441,6 +441,7 @@ struct f2fs_inode_info {
 	unsigned int clevel;		/* maximum level of given file name */
 	nid_t i_xattr_nid;		/* node id that contains xattrs */
 	unsigned long long xattr_ver;	/* cp version of xattr modification */
+	loff_t	last_disk_size;		/* lastly written file size */
 
 	struct list_head dirty_list;	/* dirty list for dirs and files */
 	struct list_head gdirty_list;	/* linked in global dirty list */
@@ -1516,6 +1517,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 enum {
 	FI_NEW_INODE,		/* indicate newly allocated inode */
 	FI_DIRTY_INODE,		/* indicate inode is dirty or not */
+	FI_AUTO_RECOVER,	/* indicate inode is recoverable */
 	FI_DIRTY_DIR,		/* indicate directory has dirty pages */
 	FI_INC_LINK,		/* need to increment i_nlink */
 	FI_ACL_MODE,		/* indicate acl mode */
@@ -1590,15 +1592,32 @@ static inline void f2fs_i_links_write(struct inode *inode, bool inc)
 static inline void f2fs_i_blocks_write(struct inode *inode,
 					blkcnt_t diff, bool add)
 {
+	bool clean = !is_inode_flag_set(inode, FI_DIRTY_INODE);
+	bool recover = is_inode_flag_set(inode, FI_AUTO_RECOVER);
+
 	inode->i_blocks = add ? inode->i_blocks + diff :
 				inode->i_blocks - diff;
 	mark_inode_dirty_sync(inode);
+	if (clean || recover)
+		set_inode_flag(inode, FI_AUTO_RECOVER);
 }
 
 static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
 {
+	bool clean = !is_inode_flag_set(inode, FI_DIRTY_INODE);
+	bool recover = is_inode_flag_set(inode, FI_AUTO_RECOVER);
+
 	i_size_write(inode, i_size);
 	mark_inode_dirty_sync(inode);
+	if (clean || recover)
+		set_inode_flag(inode, FI_AUTO_RECOVER);
+}
+
+static inline bool f2fs_skip_inode_update(struct inode *inode)
+{
+	if (!is_inode_flag_set(inode, FI_AUTO_RECOVER))
+		return false;
+	return F2FS_I(inode)->last_disk_size == i_size_read(inode);
 }
 
 static inline void f2fs_i_depth_write(struct inode *inode, unsigned int depth)
@@ -1932,8 +1951,8 @@ void ra_node_page(struct f2fs_sb_info *, nid_t);
 struct page *get_node_page(struct f2fs_sb_info *, pgoff_t);
 struct page *get_node_page_ra(struct page *, int);
 void move_node_page(struct page *, int);
-int fsync_node_pages(struct f2fs_sb_info *, nid_t, struct writeback_control *,
-								bool);
+int fsync_node_pages(struct f2fs_sb_info *, struct inode *,
+			struct writeback_control *, bool);
 int sync_node_pages(struct f2fs_sb_info *, struct writeback_control *);
 bool alloc_nid(struct f2fs_sb_info *, nid_t *);
 void alloc_nid_done(struct f2fs_sb_info *, nid_t);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6dd64dc..9987a5d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -208,7 +208,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	}
 
 	/* if the inode is dirty, let's recover all the time */
-	if (!datasync) {
+	if (!datasync && !f2fs_skip_inode_update(inode)) {
 		f2fs_write_inode(inode, NULL);
 		goto go_write;
 	}
@@ -251,7 +251,7 @@ go_write:
 		goto out;
 	}
 sync_nodes:
-	ret = fsync_node_pages(sbi, ino, &wbc, atomic);
+	ret = fsync_node_pages(sbi, inode, &wbc, atomic);
 	if (ret)
 		goto out;
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 6c4d5cc..4502ff5 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -153,6 +153,9 @@ static int do_read_inode(struct inode *inode)
 	if (__written_first_block(ri))
 		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 
+	if (!need_inode_block_update(sbi, inode->i_ino))
+		fi->last_disk_size = inode->i_size;
+
 	f2fs_put_page(node_page, 1);
 
 	stat_inc_inline_xattr(inode);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b90125d..d6fd731 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1292,7 +1292,7 @@ continue_unlock:
 	return last_page;
 }
 
-int fsync_node_pages(struct f2fs_sb_info *sbi, nid_t ino,
+int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			struct writeback_control *wbc, bool atomic)
 {
 	pgoff_t index, end;
@@ -1300,6 +1300,7 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, nid_t ino,
 	int ret = 0;
 	struct page *last_page = NULL;
 	bool marked = false;
+	nid_t ino = inode->i_ino;
 
 	if (atomic) {
 		last_page = last_fsync_dnode(sbi, ino);
@@ -1353,9 +1354,13 @@ continue_unlock:
 
 			if (!atomic || page == last_page) {
 				set_fsync_mark(page, 1);
-				if (IS_INODE(page))
+				if (IS_INODE(page)) {
+					if (is_inode_flag_set(inode,
+								FI_DIRTY_INODE))
+						update_inode(inode, page);
 					set_dentry_mark(page,
 						need_dentry_mark(sbi, ino));
+				}
 				/*  may be written by other thread */
 				if (!PageDirty(page))
 					set_page_dirty(page);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 68c433f..b568b28 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -455,6 +455,9 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 			continue;
 		}
 
+		if ((start + 1) << PAGE_SHIFT > i_size_read(inode))
+			f2fs_i_size_write(inode, (start + 1) << PAGE_SHIFT);
+
 		/*
 		 * dest is reserved block, invalidate src block
 		 * and then reserve one new block in dnode page.
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 35fd5f3..e9e81cb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -598,6 +598,9 @@ static void f2fs_dirty_inode(struct inode *inode, int flags)
 			inode->i_ino == F2FS_META_INO(sbi))
 		return;
 
+	if (is_inode_flag_set(inode, FI_AUTO_RECOVER))
+		clear_inode_flag(inode, FI_AUTO_RECOVER);
+
 	spin_lock(&sbi->inode_lock[DIRTY_META]);
 	if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
 		spin_unlock(&sbi->inode_lock[DIRTY_META]);
@@ -623,6 +626,7 @@ void f2fs_inode_synced(struct inode *inode)
 	}
 	list_del_init(&F2FS_I(inode)->gdirty_list);
 	clear_inode_flag(inode, FI_DIRTY_INODE);
+	clear_inode_flag(inode, FI_AUTO_RECOVER);
 	dec_page_count(sbi, F2FS_DIRTY_IMETA);
 	spin_unlock(&sbi->inode_lock[DIRTY_META]);
 	stat_dec_dirty_inode(F2FS_I_SB(inode), DIRTY_META);
-- 
2.6.3
