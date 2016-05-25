From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 06/12] f2fs: flush inode metadata when checkpoint
	is doing
Date: Tue, 24 May 2016 17:03:32 -0700
Message-ID: <1464134619-37015-6-git-send-email-jaegeuk@kernel.org>
References: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b5MIr-000593-SG
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 May 2016 00:04:01 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b5MIq-00006l-MM
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 May 2016 00:04:01 +0000
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

This patch registers all the inodes which have dirty metadata to sync when
checkpoint is doing.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 36 ++++++++++++++++++++++++++++++++++++
 fs/f2fs/debug.c      |  5 +++--
 fs/f2fs/f2fs.h       |  8 ++++++--
 fs/f2fs/inode.c      |  6 +++++-
 fs/f2fs/segment.h    |  2 ++
 fs/f2fs/super.c      | 34 ++++++++++++++++++++++++++++++++++
 6 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 57ca0c6..ac90fd7 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -860,6 +860,34 @@ retry:
 	goto retry;
 }
 
+int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
+{
+	struct list_head *head = &sbi->inode_list[DIRTY_META];
+	struct inode *inode;
+	struct f2fs_inode_info *fi;
+	s64 total = get_pages(sbi, F2FS_DIRTY_IMETA);
+
+	while (total--) {
+		if (unlikely(f2fs_cp_error(sbi)))
+			return -EIO;
+
+		spin_lock(&sbi->inode_lock[DIRTY_META]);
+		if (list_empty(head)) {
+			spin_unlock(&sbi->inode_lock[DIRTY_META]);
+			return 0;
+		}
+		fi = list_entry(head->next, struct f2fs_inode_info,
+							gdirty_list);
+		inode = igrab(&fi->vfs_inode);
+		spin_unlock(&sbi->inode_lock[DIRTY_META]);
+		if (inode) {
+			update_inode_page(inode);
+			iput(inode);
+		}
+	};
+	return 0;
+}
+
 /*
  * Freeze all the FS-operations for checkpoint.
  */
@@ -886,6 +914,14 @@ retry_flush_dents:
 		goto retry_flush_dents;
 	}
 
+	if (get_pages(sbi, F2FS_DIRTY_IMETA)) {
+		f2fs_unlock_all(sbi);
+		err = f2fs_sync_inode_meta(sbi);
+		if (err)
+			goto out;
+		goto retry_flush_dents;
+	}
+
 	/*
 	 * POR: we should ensure that there are no dirty node pages
 	 * until finishing nat/sit flush.
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index d89a425..badd407 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -47,6 +47,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->ndirty_data = get_pages(sbi, F2FS_DIRTY_DATA);
 	si->ndirty_dirs = sbi->ndirty_inode[DIR_INODE];
 	si->ndirty_files = sbi->ndirty_inode[FILE_INODE];
+	si->ndirty_all = sbi->ndirty_inode[DIRTY_META];
 	si->inmem_pages = get_pages(sbi, F2FS_INMEM_PAGES);
 	si->wb_bios = atomic_read(&sbi->nr_wb_bios);
 	si->total_count = (int)sbi->user_block_count / sbi->blocks_per_seg;
@@ -304,8 +305,8 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->inmem_pages, si->wb_bios);
 		seq_printf(s, "  - nodes: %4lld in %4d\n",
 			   si->ndirty_node, si->node_pages);
-		seq_printf(s, "  - dents: %4lld in dirs:%4d\n",
-			   si->ndirty_dent, si->ndirty_dirs);
+		seq_printf(s, "  - dents: %4lld in dirs:%4d (%4d)\n",
+			   si->ndirty_dent, si->ndirty_dirs, si->ndirty_all);
 		seq_printf(s, "  - datas: %4lld in files:%4d\n",
 			   si->ndirty_data, si->ndirty_files);
 		seq_printf(s, "  - meta: %4lld in %4d\n",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6721a43..d89a651 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -442,7 +442,8 @@ struct f2fs_inode_info {
 	nid_t i_xattr_nid;		/* node id that contains xattrs */
 	unsigned long long xattr_ver;	/* cp version of xattr modification */
 
-	struct list_head dirty_list;	/* linked in global dirty list */
+	struct list_head dirty_list;	/* dirty list for dirs and files */
+	struct list_head gdirty_list;	/* linked in global dirty list */
 	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
 	struct mutex inmem_lock;	/* lock for inmemory pages */
 	struct extent_tree *extent_tree;	/* cached extent_tree entry */
@@ -657,6 +658,7 @@ enum count_type {
 	F2FS_DIRTY_NODES,
 	F2FS_DIRTY_META,
 	F2FS_INMEM_PAGES,
+	F2FS_DIRTY_IMETA,
 	NR_COUNT_TYPE,
 };
 
@@ -707,6 +709,7 @@ struct f2fs_bio_info {
 enum inode_type {
 	DIR_INODE,			/* for dirty dir inode */
 	FILE_INODE,			/* for dirty regular/symlink inode */
+	DIRTY_META,			/* for all dirtied inode metadata */
 	NR_INODE_TYPE,
 };
 
@@ -1895,6 +1898,7 @@ static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
 /*
  * super.c
  */
+void f2fs_inode_synced(struct inode *);
 int f2fs_commit_super(struct f2fs_sb_info *, bool);
 int f2fs_sync_fs(struct super_block *, int);
 extern __printf(3, 4)
@@ -2074,7 +2078,7 @@ struct f2fs_stat_info {
 	unsigned long long hit_total, total_ext;
 	int ext_tree, zombie_tree, ext_node;
 	s64 ndirty_node, ndirty_dent, ndirty_meta, ndirty_data, inmem_pages;
-	unsigned int ndirty_dirs, ndirty_files;
+	unsigned int ndirty_dirs, ndirty_files, ndirty_all;
 	int nats, dirty_nats, sits, dirty_sits, fnids;
 	int total_count, utilization;
 	int bg_gc, wb_bios;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 62d8c90..6c4d5cc 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -261,7 +261,7 @@ int update_inode(struct inode *inode, struct page *node_page)
 
 	__set_inode_rdev(inode, ri);
 	set_cold_node(inode, node_page);
-	clear_inode_flag(inode, FI_DIRTY_INODE);
+	f2fs_inode_synced(inode);
 
 	/* deleted inode */
 	if (inode->i_nlink == 0)
@@ -285,6 +285,7 @@ retry:
 		} else if (err != -ENOENT) {
 			f2fs_stop_checkpoint(sbi, false);
 		}
+		f2fs_inode_synced(inode);
 		return 0;
 	}
 	ret = update_inode(inode, node_page);
@@ -378,6 +379,9 @@ no_delete:
 	}
 	f2fs_bug_on(sbi, err &&
 		!exist_written_data(sbi, inode->i_ino, ORPHAN_INO));
+	if (err)
+		update_inode_page(inode);
+	f2fs_inode_synced(inode);
 out_clear:
 	fscrypt_put_encryption_info(inode, NULL);
 	clear_inode(inode);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index fcdd731..5d016a1 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -479,6 +479,8 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi, int freed)
 	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
 	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
 
+	node_secs += get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
+
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		return false;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d832bf4..35fd5f3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -537,6 +537,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	fi->i_advise = 0;
 	init_rwsem(&fi->i_sem);
 	INIT_LIST_HEAD(&fi->dirty_list);
+	INIT_LIST_HEAD(&fi->gdirty_list);
 	INIT_LIST_HEAD(&fi->inmem_pages);
 	mutex_init(&fi->inmem_lock);
 
@@ -591,7 +592,40 @@ static int f2fs_drop_inode(struct inode *inode)
  */
 static void f2fs_dirty_inode(struct inode *inode, int flags)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+	if (inode->i_ino == F2FS_NODE_INO(sbi) ||
+			inode->i_ino == F2FS_META_INO(sbi))
+		return;
+
+	spin_lock(&sbi->inode_lock[DIRTY_META]);
+	if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
+		spin_unlock(&sbi->inode_lock[DIRTY_META]);
+		return;
+	}
+
 	set_inode_flag(inode, FI_DIRTY_INODE);
+	list_add_tail(&F2FS_I(inode)->gdirty_list,
+				&sbi->inode_list[DIRTY_META]);
+	inc_page_count(sbi, F2FS_DIRTY_IMETA);
+	spin_unlock(&sbi->inode_lock[DIRTY_META]);
+	stat_inc_dirty_inode(sbi, DIRTY_META);
+}
+
+void f2fs_inode_synced(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+	spin_lock(&sbi->inode_lock[DIRTY_META]);
+	if (!is_inode_flag_set(inode, FI_DIRTY_INODE)) {
+		spin_unlock(&sbi->inode_lock[DIRTY_META]);
+		return;
+	}
+	list_del_init(&F2FS_I(inode)->gdirty_list);
+	clear_inode_flag(inode, FI_DIRTY_INODE);
+	dec_page_count(sbi, F2FS_DIRTY_IMETA);
+	spin_unlock(&sbi->inode_lock[DIRTY_META]);
+	stat_dec_dirty_inode(F2FS_I_SB(inode), DIRTY_META);
 }
 
 static void f2fs_i_callback(struct rcu_head *head)
-- 
2.6.3


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
