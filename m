From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: fix double lock in handle_failed_inode
Date: Thu, 16 Jul 2015 18:19:02 +0800
Message-ID: <018e01d0bfb0$f2e493c0$d8adbb40$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In handle_failed_inode, there is a potential deadlock which can happen
in below call path:

- f2fs_create
 - f2fs_lock_op   down_read(cp_rwsem)
 - f2fs_add_link
  - __f2fs_add_link
   - init_inode_metadata
    - f2fs_init_security    failed
    - truncate_blocks    failed
 - handle_failed_inode
  - f2fs_truncate
   - truncate_blocks(..,true)
					- write_checkpoint
					 - block_operations
					  - f2fs_lock_all  down_write(cp_rwsem)
    - f2fs_lock_op   down_read(cp_rwsem)

So in this path, we pass parameter to f2fs_truncate to make sure
cp_rwsem in truncate_blocks will not be locked again.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h  | 2 +-
 fs/f2fs/file.c  | 6 +++---
 fs/f2fs/inode.c | 4 ++--
 fs/f2fs/super.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5d42e8d..cda9e36 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1585,7 +1585,7 @@ static inline bool f2fs_may_extent_tree(struct inode *inode)
 int f2fs_sync_file(struct file *, loff_t, loff_t, int);
 void truncate_data_blocks(struct dnode_of_data *);
 int truncate_blocks(struct inode *, u64, bool);
-void f2fs_truncate(struct inode *);
+void f2fs_truncate(struct inode *, bool);
 int f2fs_getattr(struct vfsmount *, struct dentry *, struct kstat *);
 int f2fs_setattr(struct dentry *, struct iattr *);
 int truncate_hole(struct inode *, pgoff_t, pgoff_t);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 852535f..1bb1d6e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -579,7 +579,7 @@ out:
 	return err;
 }
 
-void f2fs_truncate(struct inode *inode)
+void f2fs_truncate(struct inode *inode, bool lock)
 {
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 				S_ISLNK(inode->i_mode)))
@@ -593,7 +593,7 @@ void f2fs_truncate(struct inode *inode)
 			return;
 	}
 
-	if (!truncate_blocks(inode, i_size_read(inode), true)) {
+	if (!truncate_blocks(inode, i_size_read(inode), lock)) {
 		inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		mark_inode_dirty(inode);
 	}
@@ -656,7 +656,7 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 
 		if (attr->ia_size <= i_size_read(inode)) {
 			truncate_setsize(inode, attr->ia_size);
-			f2fs_truncate(inode);
+			f2fs_truncate(inode, true);
 			f2fs_balance_fs(F2FS_I_SB(inode));
 		} else {
 			/*
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 5b7547f..cc4f108 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -343,7 +343,7 @@ void f2fs_evict_inode(struct inode *inode)
 	i_size_write(inode, 0);
 
 	if (F2FS_HAS_BLOCKS(inode))
-		f2fs_truncate(inode);
+		f2fs_truncate(inode, true);
 
 	f2fs_lock_op(sbi);
 	remove_inode_page(inode);
@@ -385,7 +385,7 @@ void handle_failed_inode(struct inode *inode)
 
 	i_size_write(inode, 0);
 	if (F2FS_HAS_BLOCKS(inode))
-		f2fs_truncate(inode);
+		f2fs_truncate(inode, false);
 
 	remove_inode_page(inode);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4921b73..ecb32c4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -468,7 +468,7 @@ static int f2fs_drop_inode(struct inode *inode)
 			i_size_write(inode, 0);
 
 			if (F2FS_HAS_BLOCKS(inode))
-				f2fs_truncate(inode);
+				f2fs_truncate(inode, true);
 
 			sb_end_intwrite(inode->i_sb);
 
-- 
2.4.2
