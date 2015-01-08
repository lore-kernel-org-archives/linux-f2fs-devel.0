From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/6] f2fs: support goingdown for fs shutdown
Date: Thu,  8 Jan 2015 10:10:57 -0800
Message-ID: <1420740661-72288-2-git-send-email-jaegeuk@kernel.org>
References: <1420740661-72288-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Y9HYC-00082Z-8w
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Jan 2015 18:11:16 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y9HY9-0003Za-DG for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Jan 2015 18:11:16 +0000
In-Reply-To: <1420740661-72288-1-git-send-email-jaegeuk@kernel.org>
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

This patch add an ioctl to shutdown f2fs, which stops all the further block
writes after this point.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/file.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ba30218..febad35 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -209,6 +209,7 @@ static inline bool __has_cursum_space(struct f2fs_summary_block *sum, int size,
 #define F2FS_IOC_START_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 3)
 #define F2FS_IOC_RELEASE_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 4)
 #define F2FS_IOC_ABORT_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 5)
+#define F2FS_IOC_GOINGDOWN		_IO(F2FS_IOCTL_MAGIC, 6)
 
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /*
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5df3367..de2f669 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1020,6 +1020,18 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 	return ret;
 }
 
+static int f2fs_ioc_goingdown(struct file *filp)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	f2fs_stop_checkpoint(sbi);
+	return 0;
+}
+
 static int f2fs_ioc_fitrim(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -1067,6 +1079,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_release_volatile_write(filp);
 	case F2FS_IOC_ABORT_VOLATILE_WRITE:
 		return f2fs_ioc_abort_volatile_write(filp);
+	case F2FS_IOC_GOINGDOWN:
+		return f2fs_ioc_goingdown(filp);
 	case FITRIM:
 		return f2fs_ioc_fitrim(filp, arg);
 	default:
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
