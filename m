From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 4/8] f2fs: record dirty status of regular/symlink
	inode
Date: Tue, 15 Dec 2015 13:32:27 +0800
Message-ID: <00f701d136fa$14821b90$3d8652b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1a8iEf-0004Od-00
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 05:33:17 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a8iEd-0001JB-80
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 05:33:16 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZD02FYHWR04VC0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 14:33:08 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Maintain regular/symlink inode which has dirty pages in global dirty list
like the way of handling directory inode.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 66 ++++++++++++++++++++++++++--------------------------
 fs/f2fs/data.c       |  4 ++--
 fs/f2fs/dir.c        |  2 +-
 fs/f2fs/f2fs.h       | 17 ++++++++++----
 fs/f2fs/inode.c      |  2 +-
 fs/f2fs/super.c      |  6 +++--
 6 files changed, 53 insertions(+), 44 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a4392f0..f33c4d7 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -722,53 +722,51 @@ fail_no_cp:
 	return -EINVAL;
 }
 
-static void __add_dirty_inode(struct inode *inode)
+static void __add_dirty_inode(struct inode *inode, enum inode_type type)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
+	int flag = (type == DIR_INODE) ? FI_DIRTY_DIR : FI_DIRTY_FILE;
 
-	if (is_inode_flag_set(fi, FI_DIRTY_DIR))
+	if (is_inode_flag_set(fi, flag))
 		return;
 
-	set_inode_flag(fi, FI_DIRTY_DIR);
-	list_add_tail(&fi->dirty_list, &sbi->dir_inode_list);
-	stat_inc_dirty_dir(sbi);
-	return;
+	set_inode_flag(fi, flag);
+	list_add_tail(&fi->dirty_list, &sbi->inode_list[type]);
+	if (type == DIR_INODE)
+		stat_inc_dirty_dir(sbi);
 }
 
-static void __remove_dirty_inode(struct inode *inode)
+static void __remove_dirty_inode(struct inode *inode, enum inode_type type)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
+	int flag = (type == DIR_INODE) ? FI_DIRTY_DIR : FI_DIRTY_FILE;
 
 	if (get_dirty_pages(inode) ||
-			!is_inode_flag_set(F2FS_I(inode), FI_DIRTY_DIR))
+			!is_inode_flag_set(F2FS_I(inode), flag))
 		return;
 
 	list_del_init(&fi->dirty_list);
-	clear_inode_flag(fi, FI_DIRTY_DIR);
-	stat_dec_dirty_dir(sbi);
+	clear_inode_flag(fi, flag);
+	if (type == DIR_INODE)
+		stat_dec_dirty_dir(sbi);
 }
 
 void update_dirty_page(struct inode *inode, struct page *page)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	enum inode_type type = S_ISDIR(inode->i_mode) ? DIR_INODE : FILE_INODE;
 
 	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
 			!S_ISLNK(inode->i_mode))
 		return;
 
-	if (!S_ISDIR(inode->i_mode)) {
-		inode_inc_dirty_pages(inode);
-		goto out;
-	}
-
-	spin_lock(&sbi->dir_inode_lock);
-	__add_dirty_inode(inode);
+	spin_lock(&sbi->inode_lock[type]);
+	__add_dirty_inode(inode, type);
 	inode_inc_dirty_pages(inode);
-	spin_unlock(&sbi->dir_inode_lock);
+	spin_unlock(&sbi->inode_lock[type]);
 
-out:
 	SetPagePrivate(page);
 	f2fs_trace_pid(page);
 }
@@ -777,22 +775,24 @@ void add_dirty_dir_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
-	spin_lock(&sbi->dir_inode_lock);
-	__add_dirty_inode(inode);
-	spin_unlock(&sbi->dir_inode_lock);
+	spin_lock(&sbi->inode_lock[DIR_INODE]);
+	__add_dirty_inode(inode, DIR_INODE);
+	spin_unlock(&sbi->inode_lock[DIR_INODE]);
 }
 
-void remove_dirty_dir_inode(struct inode *inode)
+void remove_dirty_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
+	enum inode_type type = S_ISDIR(inode->i_mode) ? DIR_INODE : FILE_INODE;
 
-	if (!S_ISDIR(inode->i_mode))
+	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
+			!S_ISLNK(inode->i_mode))
 		return;
 
-	spin_lock(&sbi->dir_inode_lock);
-	__remove_dirty_inode(inode);
-	spin_unlock(&sbi->dir_inode_lock);
+	spin_lock(&sbi->inode_lock[type]);
+	__remove_dirty_inode(inode, type);
+	spin_unlock(&sbi->inode_lock[type]);
 
 	/* Only from the recovery routine */
 	if (is_inode_flag_set(fi, FI_DELAY_IPUT)) {
@@ -801,7 +801,7 @@ void remove_dirty_dir_inode(struct inode *inode)
 	}
 }
 
-void sync_dirty_dir_inodes(struct f2fs_sb_info *sbi)
+void sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 {
 	struct list_head *head;
 	struct inode *inode;
@@ -810,16 +810,16 @@ retry:
 	if (unlikely(f2fs_cp_error(sbi)))
 		return;
 
-	spin_lock(&sbi->dir_inode_lock);
+	spin_lock(&sbi->inode_lock[type]);
 
-	head = &sbi->dir_inode_list;
+	head = &sbi->inode_list[type];
 	if (list_empty(head)) {
-		spin_unlock(&sbi->dir_inode_lock);
+		spin_unlock(&sbi->inode_lock[type]);
 		return;
 	}
 	fi = list_entry(head->next, struct f2fs_inode_info, dirty_list);
 	inode = igrab(&fi->vfs_inode);
-	spin_unlock(&sbi->dir_inode_lock);
+	spin_unlock(&sbi->inode_lock[type]);
 	if (inode) {
 		filemap_fdatawrite(inode->i_mapping);
 		iput(inode);
@@ -854,7 +854,7 @@ retry_flush_dents:
 	/* write all the dirty dentry pages */
 	if (get_pages(sbi, F2FS_DIRTY_DENTS)) {
 		f2fs_unlock_all(sbi);
-		sync_dirty_dir_inodes(sbi);
+		sync_dirty_inodes(sbi, DIR_INODE);
 		if (unlikely(f2fs_cp_error(sbi))) {
 			err = -EIO;
 			goto out;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e303212..2e97057 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1190,7 +1190,7 @@ out:
 		f2fs_balance_fs(sbi);
 	if (wbc->for_reclaim) {
 		f2fs_submit_merged_bio(sbi, DATA, WRITE);
-		remove_dirty_dir_inode(inode);
+		remove_dirty_inode(inode);
 	}
 	return 0;
 
@@ -1382,7 +1382,7 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 	if (locked)
 		mutex_unlock(&sbi->writepages);
 
-	remove_dirty_dir_inode(inode);
+	remove_dirty_inode(inode);
 
 	wbc->nr_to_write = max((long)0, wbc->nr_to_write - diff);
 	return ret;
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 6554fd5..3da5826 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -444,7 +444,7 @@ error:
 	/* once the failed inode becomes a bad inode, i_mode is S_IFREG */
 	truncate_inode_pages(&inode->i_data, 0);
 	truncate_blocks(inode, 0, false);
-	remove_dirty_dir_inode(inode);
+	remove_dirty_inode(inode);
 	remove_inode_page(inode);
 	return ERR_PTR(err);
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index aea5620..d8bef3c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -696,6 +696,12 @@ struct f2fs_bio_info {
 	struct rw_semaphore io_rwsem;	/* blocking op for bio */
 };
 
+enum inode_type {
+	DIR_INODE,			/* for dirty dir inode */
+	FILE_INODE,			/* for dirty regular/symlink inode */
+	NR_INODE_TYPE,
+};
+
 /* for inner inode cache management */
 struct inode_management {
 	struct radix_tree_root ino_root;	/* ino entry array */
@@ -745,9 +751,9 @@ struct f2fs_sb_info {
 	/* for orphan inode, use 0'th array */
 	unsigned int max_orphans;		/* max orphan inodes */
 
-	/* for directory inode management */
-	struct list_head dir_inode_list;	/* dir inode list */
-	spinlock_t dir_inode_lock;		/* for dir inode list lock */
+	/* for inode management */
+	struct list_head inode_list[NR_INODE_TYPE];	/* dirty inode list */
+	spinlock_t inode_lock[NR_INODE_TYPE];	/* for dirty inode list lock */
 
 	/* for extent tree cache */
 	struct radix_tree_root extent_tree_root;/* cache extent cache entries */
@@ -1417,6 +1423,7 @@ enum {
 	FI_DATA_EXIST,		/* indicate data exists */
 	FI_INLINE_DOTS,		/* indicate inline dot dentries */
 	FI_DO_DEFRAG,		/* indicate defragment is running */
+	FI_DIRTY_FILE,		/* indicate regular/symlink has dirty pages */
 };
 
 static inline void set_inode_flag(struct f2fs_inode_info *fi, int flag)
@@ -1826,8 +1833,8 @@ int recover_orphan_inodes(struct f2fs_sb_info *);
 int get_valid_checkpoint(struct f2fs_sb_info *);
 void update_dirty_page(struct inode *, struct page *);
 void add_dirty_dir_inode(struct inode *);
-void remove_dirty_dir_inode(struct inode *);
-void sync_dirty_dir_inodes(struct f2fs_sb_info *);
+void remove_dirty_inode(struct inode *);
+void sync_dirty_inodes(struct f2fs_sb_info *, enum inode_type);
 void write_checkpoint(struct f2fs_sb_info *, struct cp_control *);
 void init_ino_entry_info(struct f2fs_sb_info *);
 int __init create_checkpoint_caches(void);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 3d2fe59..ec3fb32 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -327,7 +327,7 @@ void f2fs_evict_inode(struct inode *inode)
 		goto out_clear;
 
 	f2fs_bug_on(sbi, get_dirty_pages(inode));
-	remove_dirty_dir_inode(inode);
+	remove_dirty_inode(inode);
 
 	f2fs_destroy_extent_tree(inode);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b6c1ac9..051bce6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1350,8 +1350,10 @@ try_onemore:
 				le64_to_cpu(sbi->ckpt->valid_block_count);
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
 	sbi->alloc_valid_block_count = 0;
-	INIT_LIST_HEAD(&sbi->dir_inode_list);
-	spin_lock_init(&sbi->dir_inode_lock);
+	for (i = 0; i < NR_INODE_TYPE; i++) {
+		INIT_LIST_HEAD(&sbi->inode_list[i]);
+		spin_lock_init(&sbi->inode_lock[i]);
+	}
 
 	init_extent_cache_info(sbi);
 
-- 
2.6.3



------------------------------------------------------------------------------
