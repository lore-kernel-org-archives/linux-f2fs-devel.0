From: Chao Yu <chao@kernel.org>
Subject: [PATCH RESEND 5/6] f2fs: support F2FS_IOC_FS{GET,SET}XATTR
Date: Sat, 29 Jul 2017 00:32:52 +0800
Message-ID: <20170728163254.7953-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch adds FS_IOC_FSSETXATTR/FS_IOC_FSGETXATTR ioctl interface
support for f2fs. The interface is kept consistent with the one
of ext4/xfs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h |   3 +
 fs/f2fs/file.c | 264 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 239 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d35621b8d739..2c23b0c40817 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -338,6 +338,9 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 #define F2FS_IOC32_GETVERSION		FS_IOC32_GETVERSION
 #endif
 
+#define F2FS_IOC_FSGETXATTR		FS_IOC_FSGETXATTR
+#define F2FS_IOC_FSSETXATTR		FS_IOC_FSSETXATTR
+
 struct f2fs_gc_range {
 	u32 sync;
 	u64 start;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a0413c951458..560e962a6a85 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -652,7 +652,7 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	unsigned int flags;
 
-	flags = fi->i_flags & FS_FL_USER_VISIBLE;
+	flags = fi->i_flags & (FS_FL_USER_VISIBLE | FS_PROJINHERIT_FL);
 	if (flags & FS_APPEND_FL)
 		stat->attributes |= STATX_ATTR_APPEND;
 	if (flags & FS_COMPR_FL)
@@ -1522,16 +1522,47 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	unsigned int flags = fi->i_flags & FS_FL_USER_VISIBLE;
+	unsigned int flags = fi->i_flags &
+			(FS_FL_USER_VISIBLE | FS_PROJINHERIT_FL);
 	return put_user(flags, (int __user *)arg);
 }
 
+static int __f2fs_ioc_setflags(struct inode *inode, unsigned int flags)
+{
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	unsigned int oldflags;
+
+	/* Is it quota file? Do not allow user to mess with it */
+	if (IS_NOQUOTA(inode))
+		return -EPERM;
+
+	flags = f2fs_mask_flags(inode->i_mode, flags);
+
+	oldflags = fi->i_flags;
+
+	if ((flags ^ oldflags) & (FS_APPEND_FL | FS_IMMUTABLE_FL))
+		if (!capable(CAP_LINUX_IMMUTABLE))
+			return -EPERM;
+
+	flags = flags & (FS_FL_USER_MODIFIABLE | FS_PROJINHERIT_FL);
+	flags |= oldflags & ~(FS_FL_USER_MODIFIABLE | FS_PROJINHERIT_FL);
+	fi->i_flags = flags;
+
+	if (fi->i_flags & FS_PROJINHERIT_FL)
+		set_inode_flag(inode, FI_PROJ_INHERIT);
+	else
+		clear_inode_flag(inode, FI_PROJ_INHERIT);
+
+	inode->i_ctime = current_time(inode);
+	f2fs_set_inode_flags(inode);
+	f2fs_mark_inode_dirty_sync(inode, false);
+	return 0;
+}
+
 static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
-	struct f2fs_inode_info *fi = F2FS_I(inode);
 	unsigned int flags;
-	unsigned int oldflags;
 	int ret;
 
 	if (!inode_owner_or_capable(inode))
@@ -1546,31 +1577,8 @@ static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
 
 	inode_lock(inode);
 
-	/* Is it quota file? Do not allow user to mess with it */
-	if (IS_NOQUOTA(inode)) {
-		ret = -EPERM;
-		goto unlock_out;
-	}
-
-	flags = f2fs_mask_flags(inode->i_mode, flags);
-
-	oldflags = fi->i_flags;
-
-	if ((flags ^ oldflags) & (FS_APPEND_FL | FS_IMMUTABLE_FL)) {
-		if (!capable(CAP_LINUX_IMMUTABLE)) {
-			ret = -EPERM;
-			goto unlock_out;
-		}
-	}
+	ret = __f2fs_ioc_setflags(inode, flags);
 
-	flags = flags & FS_FL_USER_MODIFIABLE;
-	flags |= oldflags & ~FS_FL_USER_MODIFIABLE;
-	fi->i_flags = flags;
-
-	inode->i_ctime = current_time(inode);
-	f2fs_set_inode_flags(inode);
-	f2fs_mark_inode_dirty_sync(inode, false);
-unlock_out:
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 	return ret;
@@ -2406,6 +2414,200 @@ static int f2fs_ioc_get_features(struct file *filp, unsigned long arg)
 	return put_user(sb_feature, (u32 __user *)arg);
 }
 
+#ifdef CONFIG_QUOTA
+static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct super_block *sb = sbi->sb;
+	struct dquot *transfer_to[MAXQUOTAS] = {};
+	struct page *ipage;
+	kprojid_t kprojid;
+	int err;
+
+	if (!f2fs_sb_has_project_quota(sb)) {
+		if (projid != F2FS_DEF_PROJID)
+			return -EOPNOTSUPP;
+		else
+			return 0;
+	}
+
+	if (!f2fs_has_extra_attr(inode))
+		return -EOPNOTSUPP;
+
+	kprojid = make_kprojid(&init_user_ns, (projid_t)projid);
+
+	if (projid_eq(kprojid, F2FS_I(inode)->i_projid))
+		return 0;
+
+	err = mnt_want_write_file(filp);
+	if (err)
+		return err;
+
+	err = -EPERM;
+	inode_lock(inode);
+
+	/* Is it quota file? Do not allow user to mess with it */
+	if (IS_NOQUOTA(inode))
+		goto out_unlock;
+
+	ipage = get_node_page(sbi, inode->i_ino);
+	if (IS_ERR(ipage)) {
+		err = PTR_ERR(ipage);
+		goto out_unlock;
+	}
+
+	if (!F2FS_FITS_IN_INODE(F2FS_INODE(ipage), fi->i_extra_isize,
+								i_projid)) {
+		err = -EOVERFLOW;
+		f2fs_put_page(ipage, 1);
+		goto out_unlock;
+	}
+	f2fs_put_page(ipage, 1);
+
+	dquot_initialize(inode);
+
+	transfer_to[PRJQUOTA] = dqget(sb, make_kqid_projid(kprojid));
+	if (!IS_ERR(transfer_to[PRJQUOTA])) {
+		err = __dquot_transfer(inode, transfer_to);
+		dqput(transfer_to[PRJQUOTA]);
+		if (err)
+			goto out_dirty;
+	}
+
+	F2FS_I(inode)->i_projid = kprojid;
+	inode->i_ctime = current_time(inode);
+out_dirty:
+	f2fs_mark_inode_dirty_sync(inode, true);
+out_unlock:
+	inode_unlock(inode);
+	mnt_drop_write_file(filp);
+	return err;
+}
+#else
+static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
+{
+	if (projid != F2FS_DEF_PROJID)
+		return -EOPNOTSUPP;
+	return 0;
+}
+#endif
+
+/* Transfer internal flags to xflags */
+static inline __u32 f2fs_iflags_to_xflags(unsigned long iflags)
+{
+	__u32 xflags = 0;
+
+	if (iflags & FS_SYNC_FL)
+		xflags |= FS_XFLAG_SYNC;
+	if (iflags & FS_IMMUTABLE_FL)
+		xflags |= FS_XFLAG_IMMUTABLE;
+	if (iflags & FS_APPEND_FL)
+		xflags |= FS_XFLAG_APPEND;
+	if (iflags & FS_NODUMP_FL)
+		xflags |= FS_XFLAG_NODUMP;
+	if (iflags & FS_NOATIME_FL)
+		xflags |= FS_XFLAG_NOATIME;
+	if (iflags & FS_PROJINHERIT_FL)
+		xflags |= FS_XFLAG_PROJINHERIT;
+	return xflags;
+}
+
+#define F2FS_SUPPORTED_FS_XFLAGS (FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | \
+				  FS_XFLAG_APPEND | FS_XFLAG_NODUMP | \
+				  FS_XFLAG_NOATIME | FS_XFLAG_PROJINHERIT)
+
+/* Flags we can manipulate with through EXT4_IOC_FSSETXATTR */
+#define F2FS_FL_XFLAG_VISIBLE		(FS_SYNC_FL | \
+					 FS_IMMUTABLE_FL | \
+					 FS_APPEND_FL | \
+					 FS_NODUMP_FL | \
+					 FS_NOATIME_FL | \
+					 FS_PROJINHERIT_FL)
+
+/* Transfer xflags flags to internal */
+static inline unsigned long f2fs_xflags_to_iflags(__u32 xflags)
+{
+	unsigned long iflags = 0;
+
+	if (xflags & FS_XFLAG_SYNC)
+		iflags |= FS_SYNC_FL;
+	if (xflags & FS_XFLAG_IMMUTABLE)
+		iflags |= FS_IMMUTABLE_FL;
+	if (xflags & FS_XFLAG_APPEND)
+		iflags |= FS_APPEND_FL;
+	if (xflags & FS_XFLAG_NODUMP)
+		iflags |= FS_NODUMP_FL;
+	if (xflags & FS_XFLAG_NOATIME)
+		iflags |= FS_NOATIME_FL;
+	if (xflags & FS_XFLAG_PROJINHERIT)
+		iflags |= FS_PROJINHERIT_FL;
+
+	return iflags;
+}
+
+static int f2fs_ioc_fsgetxattr(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct fsxattr fa;
+
+	memset(&fa, 0, sizeof(struct fsxattr));
+	fa.fsx_xflags = f2fs_iflags_to_xflags(fi->i_flags &
+				(FS_FL_USER_VISIBLE | FS_PROJINHERIT_FL));
+
+	if (f2fs_sb_has_project_quota(inode->i_sb))
+		fa.fsx_projid = (__u32)from_kprojid(&init_user_ns,
+							fi->i_projid);
+
+	if (copy_to_user((struct fsxattr __user *)arg, &fa, sizeof(fa)))
+		return -EFAULT;
+	return 0;
+}
+
+static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct fsxattr fa;
+	unsigned int flags;
+	int err;
+
+	if (copy_from_user(&fa, (struct fsxattr __user *)arg, sizeof(fa)))
+		return -EFAULT;
+
+	/* Make sure caller has proper permission */
+	if (!inode_owner_or_capable(inode))
+		return -EACCES;
+
+	if (fa.fsx_xflags & ~F2FS_SUPPORTED_FS_XFLAGS)
+		return -EOPNOTSUPP;
+
+	flags = f2fs_xflags_to_iflags(fa.fsx_xflags);
+	if (f2fs_mask_flags(inode->i_mode, flags) != flags)
+		return -EOPNOTSUPP;
+
+	err = mnt_want_write_file(filp);
+	if (err)
+		return err;
+
+	inode_lock(inode);
+	flags = (fi->i_flags & ~F2FS_FL_XFLAG_VISIBLE) |
+				(flags & F2FS_FL_XFLAG_VISIBLE);
+	err = __f2fs_ioc_setflags(inode, flags);
+	inode_unlock(inode);
+	mnt_drop_write_file(filp);
+	if (err)
+		return err;
+
+	err = f2fs_ioc_setproject(filp, fa.fsx_projid);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
@@ -2449,6 +2651,10 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_flush_device(filp, arg);
 	case F2FS_IOC_GET_FEATURES:
 		return f2fs_ioc_get_features(filp, arg);
+	case F2FS_IOC_FSGETXATTR:
+		return f2fs_ioc_fsgetxattr(filp, arg);
+	case F2FS_IOC_FSSETXATTR:
+		return f2fs_ioc_fssetxattr(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -2515,6 +2721,8 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_MOVE_RANGE:
 	case F2FS_IOC_FLUSH_DEVICE:
 	case F2FS_IOC_GET_FEATURES:
+	case F2FS_IOC_FSGETXATTR:
+	case F2FS_IOC_FSSETXATTR:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.13.0.90.g1eb437020
