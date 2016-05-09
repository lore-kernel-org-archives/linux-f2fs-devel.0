From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/6] f2fs: use mnt_{want,drop}_write_file in ioctl
Date: Mon, 9 May 2016 19:56:32 +0800
Message-ID: <20160509115635.123946-3-yuchao0@huawei.com>
References: <20160509115635.123946-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160509115635.123946-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

In interfaces of ioctl, mnt_{want,drop}_write_file should be used for:
- get exclusion against file system freezing which may used by lvm
  snapshot.
- do telling filesystem that a write is about to be performed on it, and
  make sure that the writes are permitted.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 130 ++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 97 insertions(+), 33 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d5910bc..828b53e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1374,20 +1374,16 @@ static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
 	unsigned int oldflags;
 	int ret;
 
+	if (!inode_owner_or_capable(inode))
+		return -EACCES;
+
+	if (get_user(flags, (int __user *)arg))
+		return -EFAULT;
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
 
-	if (!inode_owner_or_capable(inode)) {
-		ret = -EACCES;
-		goto out;
-	}
-
-	if (get_user(flags, (int __user *)arg)) {
-		ret = -EFAULT;
-		goto out;
-	}
-
 	flags = f2fs_mask_flags(inode->i_mode, flags);
 
 	inode_lock(inode);
@@ -1430,18 +1426,22 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
 	if (f2fs_is_atomic_file(inode))
-		return 0;
+		goto out;
 
 	ret = f2fs_convert_inline_inode(inode);
 	if (ret)
-		return ret;
+		goto out;
 
 	set_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 
 	if (!get_dirty_pages(inode))
-		return 0;
+		goto out;
 
 	f2fs_msg(F2FS_I_SB(inode)->sb, KERN_WARNING,
 		"Unexpected flush for atomic writes: ino=%lu, npages=%u",
@@ -1449,6 +1449,8 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (ret)
 		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
+out:
+	mnt_drop_write_file(filp);
 	return ret;
 }
 
@@ -1460,13 +1462,13 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
-	if (f2fs_is_volatile_file(inode))
-		return 0;
-
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
 
+	if (f2fs_is_volatile_file(inode))
+		goto err_out;
+
 	if (f2fs_is_atomic_file(inode)) {
 		clear_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
 		ret = commit_inmem_pages(inode);
@@ -1490,32 +1492,48 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
 	if (f2fs_is_volatile_file(inode))
-		return 0;
+		goto out;
 
 	ret = f2fs_convert_inline_inode(inode);
 	if (ret)
-		return ret;
+		goto out;
 
 	set_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
-	return 0;
+out:
+	mnt_drop_write_file(filp);
+	return ret;
 }
 
 static int f2fs_ioc_release_volatile_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
+	int ret;
 
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
 	if (!f2fs_is_volatile_file(inode))
-		return 0;
+		goto out;
 
-	if (!f2fs_is_first_block_written(inode))
-		return truncate_partial_data_page(inode, 0, true);
+	if (!f2fs_is_first_block_written(inode)) {
+		ret = truncate_partial_data_page(inode, 0, true);
+		goto out;
+	}
 
-	return punch_hole(inode, 0, F2FS_BLKSIZE);
+	ret = punch_hole(inode, 0, F2FS_BLKSIZE);
+out:
+	mnt_drop_write_file(filp);
+	return ret;
 }
 
 static int f2fs_ioc_abort_volatile_write(struct file *filp)
@@ -1548,6 +1566,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct super_block *sb = sbi->sb;
 	__u32 in;
+	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1555,6 +1574,10 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 	if (get_user(in, (__u32 __user *)arg))
 		return -EFAULT;
 
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
 	switch (in) {
 	case F2FS_GOING_DOWN_FULLSYNC:
 		sb = freeze_bdev(sb->s_bdev);
@@ -1576,10 +1599,13 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		f2fs_stop_checkpoint(sbi);
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 	f2fs_update_time(sbi, REQ_TIME);
-	return 0;
+out:
+	mnt_drop_write_file(filp);
+	return ret;
 }
 
 static int f2fs_ioc_fitrim(struct file *filp, unsigned long arg)
@@ -1600,9 +1626,14 @@ static int f2fs_ioc_fitrim(struct file *filp, unsigned long arg)
 				sizeof(range)))
 		return -EFAULT;
 
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
 	range.minlen = max((unsigned int)range.minlen,
 				q->limits.discard_granularity);
 	ret = f2fs_trim_fs(F2FS_SB(sb), &range);
+	mnt_drop_write_file(filp);
 	if (ret < 0)
 		return ret;
 
@@ -1629,6 +1660,7 @@ static int f2fs_ioc_keyctl(struct file *filp, unsigned long arg)
 	struct f2fs_key key;
 	void *value = key.key;
 	int type = XATTR_CREATE;
+	int ret;
 
 	if (copy_from_user(&key, (u8 __user *)arg, sizeof(key)))
 		return -EFAULT;
@@ -1636,33 +1668,47 @@ static int f2fs_ioc_keyctl(struct file *filp, unsigned long arg)
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
 
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
 	if (key.mode == F2FS_DROP_KEY) {
 		int ret = validate_access_key(inode);
-
 		if (ret)
-			return ret;
+			goto out;
 
 		value = NULL;
 		type = XATTR_REPLACE;
 	}
 
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
-	return f2fs_setxattr(inode, F2FS_XATTR_INDEX_KEY,
+	ret = f2fs_setxattr(inode, F2FS_XATTR_INDEX_KEY,
 				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT,
 				value, F2FS_KEY_SIZE, NULL, type);
+out:
+	mnt_drop_write_file(filp);
+	return ret;
 }
 
 static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long arg)
 {
 	struct fscrypt_policy policy;
 	struct inode *inode = file_inode(filp);
+	int ret;
 
 	if (copy_from_user(&policy, (struct fscrypt_policy __user *)arg,
 							sizeof(policy)))
 		return -EFAULT;
 
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
-	return fscrypt_process_policy(inode, &policy);
+	ret = fscrypt_process_policy(inode, &policy);
+
+	mnt_drop_write_file(filp);
+	return ret;
 }
 
 static int f2fs_ioc_get_encryption_policy(struct file *filp, unsigned long arg)
@@ -1719,6 +1765,7 @@ static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	__u32 sync;
+	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1729,20 +1776,30 @@ static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
 	if (!sync) {
-		if (!mutex_trylock(&sbi->gc_mutex))
-			return -EBUSY;
+		if (!mutex_trylock(&sbi->gc_mutex)) {
+			ret = -EBUSY;
+			goto out;
+		}
 	} else {
 		mutex_lock(&sbi->gc_mutex);
 	}
 
-	return f2fs_gc(sbi, sync);
+	ret = f2fs_gc(sbi, sync);
+out:
+	mnt_drop_write_file(filp);
+	return ret;
 }
 
 static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1750,7 +1807,14 @@ static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
-	return f2fs_sync_fs(sbi->sb, 1);
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
+	ret = f2fs_sync_fs(sbi->sb, 1);
+
+	mnt_drop_write_file(filp);
+	return ret;
 }
 
 static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
-- 
2.8.2.311.gee88674
