From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH] f2fs: add F2FS_IOC_GETVERSION support
Date: Fri, 23 Jan 2015 20:36:04 +0800
Message-ID: <000601d03709$4c803b90$e580b2b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In this patch we add the FS_IOC_GETVERSION ioctl for getting i_generation from
inode, after that, users can list file's generation number by using "lsattr -v".

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h | 1 +
 fs/f2fs/file.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c2cf040..92e0b3a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -202,6 +202,7 @@ static inline bool __has_cursum_space(struct f2fs_summary_block *sum, int size,
  */
 #define F2FS_IOC_GETFLAGS		FS_IOC_GETFLAGS
 #define F2FS_IOC_SETFLAGS		FS_IOC_SETFLAGS
+#define F2FS_IOC_GETVERSION		FS_IOC_GETVERSION
 
 #define F2FS_IOCTL_MAGIC		0xf5
 #define F2FS_IOC_START_ATOMIC_WRITE	_IO(F2FS_IOCTL_MAGIC, 1)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0d88a28..5cbbc9a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -926,6 +926,13 @@ out:
 	return ret;
 }
 
+static int f2fs_ioc_getversion(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+
+	return put_user(inode->i_generation, (int __user *)arg);
+}
+
 static int f2fs_ioc_start_atomic_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
@@ -1096,6 +1103,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_getflags(filp, arg);
 	case F2FS_IOC_SETFLAGS:
 		return f2fs_ioc_setflags(filp, arg);
+	case F2FS_IOC_GETVERSION:
+		return f2fs_ioc_getversion(filp, arg);
 	case F2FS_IOC_START_ATOMIC_WRITE:
 		return f2fs_ioc_start_atomic_write(filp);
 	case F2FS_IOC_COMMIT_ATOMIC_WRITE:
-- 
2.2.1
