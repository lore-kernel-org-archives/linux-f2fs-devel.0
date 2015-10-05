From: Chao Yu <yuchaochina@hotmail.com>
Subject: [PATCH 4/4] f2fs: introduce a new ioctl
	F2FS_IOC_WRITE_CHECKPOINT
Date: Mon, 5 Oct 2015 22:24:19 +0800
Message-ID: <COL402-EAS58375DA13999E279D80142AB480@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchaochina@hotmail.com>) id 1Zj6gp-0007tH-Qt
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 14:24:31 +0000
Received: from col004-omc1s3.hotmail.com ([65.55.34.13])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Zj6go-0006Ah-Ub
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 14:24:31 +0000
Content-Language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch introduce a new ioctl for those users who want to trigger
checkpoint from userspace through ioctl.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/file.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1b2fc23..18e5902 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -231,6 +231,7 @@ static inline bool __has_cursum_space(struct f2fs_summary_block *sum, int
size,
 #define F2FS_IOC_RELEASE_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 4)
 #define F2FS_IOC_ABORT_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 5)
 #define F2FS_IOC_GARBAGE_COLLECT	_IO(F2FS_IOCTL_MAGIC, 6)
+#define F2FS_IOC_WRITE_CHECKPOINT	_IO(F2FS_IOCTL_MAGIC, 7)
 
 #define F2FS_IOC_SET_ENCRYPTION_POLICY					\
 		_IOR('f', 19, struct f2fs_encryption_policy)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c269966..b3985a6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1639,6 +1639,27 @@ static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
 	return f2fs_gc(sbi, sync);
 }
 
+static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct cp_control cpc;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (f2fs_readonly(sbi->sb))
+		return -EROFS;
+
+	cpc.reason = __get_cp_reason(sbi);
+
+	mutex_lock(&sbi->gc_mutex);
+	write_checkpoint(sbi, &cpc);
+	mutex_unlock(&sbi->gc_mutex);
+
+	return 0;
+}
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
@@ -1670,6 +1691,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_get_encryption_pwsalt(filp, arg);
 	case F2FS_IOC_GARBAGE_COLLECT:
 		return f2fs_ioc_gc(filp, arg);
+	case F2FS_IOC_WRITE_CHECKPOINT:
+		return f2fs_ioc_write_checkpoint(filp, arg);
 	default:
 		return -ENOTTY;
 	}
-- 
2.5.3


------------------------------------------------------------------------------
