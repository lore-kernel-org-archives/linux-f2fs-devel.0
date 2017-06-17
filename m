From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: add ioctl to do gc with target block address
Date: Sat, 17 Jun 2017 07:17:20 -0700
Message-ID: <20170617141720.51953-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds f2fs_ioc_gc_range() to move blocks located in the given
range.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h |  8 ++++++++
 fs/f2fs/file.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 91db1d07f9f8..c27a6264d9bf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -303,6 +303,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 						struct f2fs_move_range)
 #define F2FS_IOC_FLUSH_DEVICE		_IOW(F2FS_IOCTL_MAGIC, 10,	\
 						struct f2fs_flush_device)
+#define F2FS_IOC_GARBAGE_COLLECT_RANGE	_IOW(F2FS_IOCTL_MAGIC, 11,	\
+						struct f2fs_gc_range)
 
 #define F2FS_IOC_SET_ENCRYPTION_POLICY	FS_IOC_SET_ENCRYPTION_POLICY
 #define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
@@ -327,6 +329,12 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 #define F2FS_IOC32_GETVERSION		FS_IOC32_GETVERSION
 #endif
 
+struct f2fs_gc_range {
+	u32 sync;
+	u64 start;
+	u64 len;
+};
+
 struct f2fs_defragment {
 	u64 start;
 	u64 len;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6a201c61eef5..3f56b27e761b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1911,6 +1911,50 @@ static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
 	return ret;
 }
 
+static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_gc_range range;
+	u64 end;
+	int ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(&range, (struct f2fs_gc_range __user *)arg,
+							sizeof(range)))
+		return -EFAULT;
+
+	if (f2fs_readonly(sbi->sb))
+		return -EROFS;
+
+	ret = mnt_want_write_file(filp);
+	if (ret)
+		return ret;
+
+	end = range.start + range.len;
+	if (range.start < MAIN_BLKADDR(sbi) || end >= MAX_BLKADDR(sbi))
+		return -EINVAL;
+do_more:
+	if (!range.sync) {
+		if (!mutex_trylock(&sbi->gc_mutex)) {
+			ret = -EBUSY;
+			goto out;
+		}
+	} else {
+		mutex_lock(&sbi->gc_mutex);
+	}
+
+	ret = f2fs_gc(sbi, range.sync, true, GET_SEGNO(sbi, range.start));
+	range.start += sbi->blocks_per_seg;
+	if (range.start <= end)
+		goto do_more;
+out:
+	mnt_drop_write_file(filp);
+	return ret;
+}
+
 static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -2355,6 +2399,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_get_encryption_pwsalt(filp, arg);
 	case F2FS_IOC_GARBAGE_COLLECT:
 		return f2fs_ioc_gc(filp, arg);
+	case F2FS_IOC_GARBAGE_COLLECT_RANGE:
+		return f2fs_ioc_gc_range(filp, arg);
 	case F2FS_IOC_WRITE_CHECKPOINT:
 		return f2fs_ioc_write_checkpoint(filp, arg);
 	case F2FS_IOC_DEFRAGMENT:
@@ -2423,6 +2469,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_GET_ENCRYPTION_PWSALT:
 	case F2FS_IOC_GET_ENCRYPTION_POLICY:
 	case F2FS_IOC_GARBAGE_COLLECT:
+	case F2FS_IOC_GARBAGE_COLLECT_RANGE:
 	case F2FS_IOC_WRITE_CHECKPOINT:
 	case F2FS_IOC_DEFRAGMENT:
 	case F2FS_IOC_MOVE_RANGE:
-- 
2.13.0.rc1.294.g07d810a77f-goog
