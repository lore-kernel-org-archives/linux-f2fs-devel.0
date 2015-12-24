From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/5] f2fs: let user being aware of IO error
Date: Thu, 24 Dec 2015 18:04:56 +0800
Message-ID: <016501d13e32$a358fca0$ea0af5e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Sometimes we keep dumb when IO error occur in lower layer device, so user
will not receive any error return value for some operation, but actually,
the operation did not succeed.

This sould be avoided, so this patch reports such kind of error to user.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 17 +++++++----------
 fs/f2fs/data.c       | 23 +++++++++++++----------
 fs/f2fs/f2fs.h       |  2 +-
 fs/f2fs/file.c       |  4 +++-
 fs/f2fs/gc.c         |  4 +++-
 fs/f2fs/node.c       |  5 +++++
 6 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 9cdb161..6b89ac6 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -798,7 +798,7 @@ void remove_dirty_inode(struct inode *inode)
 	}
 }
 
-void sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
+int sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 {
 	struct list_head *head;
 	struct inode *inode;
@@ -810,7 +810,7 @@ void sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA));
 retry:
 	if (unlikely(f2fs_cp_error(sbi)))
-		return;
+		return -EIO;
 
 	spin_lock(&sbi->inode_lock[type]);
 
@@ -820,7 +820,7 @@ retry:
 		trace_f2fs_sync_dirty_inodes_exit(sbi->sb, is_dir,
 				get_pages(sbi, is_dir ?
 				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA));
-		return;
+		return 0;
 	}
 	fi = list_entry(head->next, struct f2fs_inode_info, dirty_list);
 	inode = igrab(&fi->vfs_inode);
@@ -859,11 +859,9 @@ retry_flush_dents:
 	/* write all the dirty dentry pages */
 	if (get_pages(sbi, F2FS_DIRTY_DENTS)) {
 		f2fs_unlock_all(sbi);
-		sync_dirty_inodes(sbi, DIR_INODE);
-		if (unlikely(f2fs_cp_error(sbi))) {
-			err = -EIO;
+		err = sync_dirty_inodes(sbi, DIR_INODE);
+		if (err)
 			goto out;
-		}
 		goto retry_flush_dents;
 	}
 
@@ -876,10 +874,9 @@ retry_flush_nodes:
 
 	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
 		up_write(&sbi->node_write);
-		sync_node_pages(sbi, 0, &wbc);
-		if (unlikely(f2fs_cp_error(sbi))) {
+		err = sync_node_pages(sbi, 0, &wbc);
+		if (err) {
 			f2fs_unlock_all(sbi);
-			err = -EIO;
 			goto out;
 		}
 		goto retry_flush_nodes;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d53cf4f..e332c0d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -498,7 +498,7 @@ alloc:
 	return 0;
 }
 
-static void __allocate_data_blocks(struct inode *inode, loff_t offset,
+static int __allocate_data_blocks(struct inode *inode, loff_t offset,
 							size_t count)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -507,13 +507,15 @@ static void __allocate_data_blocks(struct inode *inode, loff_t offset,
 	u64 len = F2FS_BYTES_TO_BLK(count);
 	bool allocated;
 	u64 end_offset;
+	int err = 0;
 
 	while (len) {
 		f2fs_lock_op(sbi);
 
 		/* When reading holes, we need its node page */
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
-		if (get_dnode_of_data(&dn, start, ALLOC_NODE))
+		err = get_dnode_of_data(&dn, start, ALLOC_NODE);
+		if (err)
 			goto out;
 
 		allocated = false;
@@ -522,12 +524,15 @@ static void __allocate_data_blocks(struct inode *inode, loff_t offset,
 		while (dn.ofs_in_node < end_offset && len) {
 			block_t blkaddr;
 
-			if (unlikely(f2fs_cp_error(sbi)))
+			if (unlikely(f2fs_cp_error(sbi))) {
+				err = -EIO;
 				goto sync_out;
+			}
 
 			blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
 			if (blkaddr == NULL_ADDR || blkaddr == NEW_ADDR) {
-				if (__allocate_data_block(&dn))
+				err = __allocate_data_block(&dn);
+				if (err)
 					goto sync_out;
 				allocated = true;
 			}
@@ -545,7 +550,7 @@ static void __allocate_data_blocks(struct inode *inode, loff_t offset,
 		if (dn.node_changed)
 			f2fs_balance_fs(sbi);
 	}
-	return;
+	return err;
 
 sync_out:
 	if (allocated)
@@ -555,7 +560,7 @@ out:
 	f2fs_unlock_op(sbi);
 	if (dn.node_changed)
 		f2fs_balance_fs(sbi);
-	return;
+	return err;
 }
 
 /*
@@ -1652,11 +1657,9 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
 
 	if (iov_iter_rw(iter) == WRITE) {
-		__allocate_data_blocks(inode, offset, count);
-		if (unlikely(f2fs_cp_error(F2FS_I_SB(inode)))) {
-			err = -EIO;
+		err = __allocate_data_blocks(inode, offset, count);
+		if (err)
 			goto out;
-		}
 	}
 
 	err = blockdev_direct_IO(iocb, inode, iter, offset, get_data_block_dio);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 79345e7..3406e99 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1837,7 +1837,7 @@ int get_valid_checkpoint(struct f2fs_sb_info *);
 void update_dirty_page(struct inode *, struct page *);
 void add_dirty_dir_inode(struct inode *);
 void remove_dirty_inode(struct inode *);
-void sync_dirty_inodes(struct f2fs_sb_info *, enum inode_type);
+int sync_dirty_inodes(struct f2fs_sb_info *, enum inode_type);
 int write_checkpoint(struct f2fs_sb_info *, struct cp_control *);
 void init_ino_entry_info(struct f2fs_sb_info *);
 int __init create_checkpoint_caches(void);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 780db8b..2d87a3c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -259,8 +259,10 @@ sync_nodes:
 	sync_node_pages(sbi, ino, &wbc);
 
 	/* if cp_error was enabled, we should avoid infinite loop */
-	if (unlikely(f2fs_cp_error(sbi)))
+	if (unlikely(f2fs_cp_error(sbi))) {
+		ret = -EIO;
 		goto out;
+	}
 
 	if (need_inode_block_update(sbi, ino)) {
 		mark_inode_dirty_sync(inode);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ce350c4..c09be33 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -832,8 +832,10 @@ gc_more:
 
 	if (unlikely(!(sbi->sb->s_flags & MS_ACTIVE)))
 		goto stop;
-	if (unlikely(f2fs_cp_error(sbi)))
+	if (unlikely(f2fs_cp_error(sbi))) {
+		ret = -EIO;
 		goto stop;
+	}
 
 	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, sec_freed)) {
 		gc_type = FG_GC;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e17128d..bcbee52 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1188,6 +1188,11 @@ next_step:
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 
+			if (unlikely(f2fs_cp_error(sbi))) {
+				pagevec_release(&pvec);
+				return -EIO;
+			}
+
 			/*
 			 * flushing sequence with step:
 			 * 0. indirect nodes
-- 
2.6.3
