From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: fix to enable missing ioctl interfaces
 in ->compat_ioctl
Date: Tue, 10 Nov 2015 18:44:20 +0800
Message-ID: <01b801d11ba4$d8702630$89507290$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Zw6QH-0006TC-RT
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 10 Nov 2015 10:45:09 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zw6QF-00073c-SC
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 10 Nov 2015 10:45:09 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NXL017GWHUG9M90@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 10 Nov 2015 19:45:00 +0900 (KST)
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

In 64-bit kernel f2fs can supports 32-bit ioctl system call by identifying
encoded code which is converted from 32-bit one to 64-bit one in
->compat_ioctl.

When we introduced new interfaces in ->ioctl, we forgot to enable them in
->compat_ioctl, so enable them for fixing.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/file.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b01ad51..06497eb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -259,6 +259,7 @@ static inline bool __has_cursum_space(struct f2fs_summary_block *sum, int size,
  */
 #define F2FS_IOC32_GETFLAGS             FS_IOC32_GETFLAGS
 #define F2FS_IOC32_SETFLAGS             FS_IOC32_SETFLAGS
+#define F2FS_IOC32_GETVERSION		FS_IOC32_GETVERSION
 #endif
 
 struct f2fs_defragment {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2f39298..3f1026c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1901,6 +1901,22 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC32_SETFLAGS:
 		cmd = F2FS_IOC_SETFLAGS;
 		break;
+	case F2FS_IOC32_GETVERSION:
+		cmd = F2FS_IOC_GETVERSION;
+		break;
+	case F2FS_IOC_START_ATOMIC_WRITE:
+	case F2FS_IOC_COMMIT_ATOMIC_WRITE:
+	case F2FS_IOC_START_VOLATILE_WRITE:
+	case F2FS_IOC_RELEASE_VOLATILE_WRITE:
+	case F2FS_IOC_ABORT_VOLATILE_WRITE:
+	case F2FS_IOC_SHUTDOWN:
+	case F2FS_IOC_SET_ENCRYPTION_POLICY:
+	case F2FS_IOC_GET_ENCRYPTION_PWSALT:
+	case F2FS_IOC_GET_ENCRYPTION_POLICY:
+	case F2FS_IOC_GARBAGE_COLLECT:
+	case F2FS_IOC_WRITE_CHECKPOINT:
+	case F2FS_IOC_DEFRAGMENT:
+		break;
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.6.1



------------------------------------------------------------------------------
