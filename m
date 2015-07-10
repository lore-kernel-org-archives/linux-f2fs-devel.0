From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: add new ioctl F2FS_IOC_GARBAGE_COLLECT
Date: Fri, 10 Jul 2015 18:08:10 +0800
Message-ID: <015b01d0baf8$6e595b70$4b0c1250$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZDVEt-0006Hf-VW
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Jul 2015 10:09:03 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZDVEr-0005QH-Pu
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Jul 2015 10:09:03 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NR9003NUO6UMO90@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Jul 2015 19:08:54 +0900 (KST)
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

When background gc is off, the only way to trigger gc is executing
a force gc in some operations who wants to grab space in disk.

The executing condition is limited: to execute force gc, we should
wait for the time when there is almost no more free section for LFS
allocation. This seems not reasonable for our user who wants to
control triggering gc by himself.

This patch introduces F2FS_IOC_GARBAGE_COLLECT interface for
triggering garbage collection by using ioctl. It provides our users
one more option to trigger gc.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/file.c | 32 ++++++++++++++++++++++++++++++++
 fs/f2fs/gc.h   |  6 ++++++
 3 files changed, 39 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 88b05cb..673623b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -228,6 +228,7 @@ static inline bool __has_cursum_space(struct f2fs_summary_block *sum, int size,
 #define F2FS_IOC_START_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 3)
 #define F2FS_IOC_RELEASE_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 4)
 #define F2FS_IOC_ABORT_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 5)
+#define F2FS_IOC_GARBAGE_COLLECT	_IO(F2FS_IOCTL_MAGIC, 6)
 
 #define F2FS_IOC_SET_ENCRYPTION_POLICY					\
 		_IOR('f', 19, struct f2fs_encryption_policy)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1b67215..55e8e4b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -27,6 +27,7 @@
 #include "segment.h"
 #include "xattr.h"
 #include "acl.h"
+#include "gc.h"
 #include "trace.h"
 #include <trace/events/f2fs.h>
 
@@ -1557,6 +1558,35 @@ got_it:
 	return 0;
 }
 
+static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	__u32 i, count;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (get_user(count, (__u32 __user *)arg))
+		return -EFAULT;
+
+	if (!count || count > F2FS_BATCH_GC_MAX_NUM)
+		return -EINVAL;
+
+	for (i = 0; i < count; i++) {
+		if (!mutex_trylock(&sbi->gc_mutex))
+			break;
+
+		if (f2fs_gc(sbi))
+			break;
+	}
+
+	if (put_user(i, (__u32 __user *)arg))
+		return -EFAULT;
+
+	return 0;
+}
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
@@ -1586,6 +1616,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_get_encryption_policy(filp, arg);
 	case F2FS_IOC_GET_ENCRYPTION_PWSALT:
 		return f2fs_ioc_get_encryption_pwsalt(filp, arg);
+	case F2FS_IOC_GARBAGE_COLLECT:
+		return f2fs_ioc_gc(filp, arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index b4a65be..c5a055b 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -19,6 +19,12 @@
 #define LIMIT_INVALID_BLOCK	40 /* percentage over total user space */
 #define LIMIT_FREE_BLOCK	40 /* percentage over invalid + free space */
 
+/*
+ * with this macro, we can control the max time we do garbage collection,
+ * when user triggers batch mode gc by ioctl.
+ */
+#define F2FS_BATCH_GC_MAX_NUM		16
+
 /* Search max. number of dirty segments to select a victim segment */
 #define DEF_MAX_VICTIM_SEARCH 4096 /* covers 8GB */
 
-- 
2.4.2



------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
