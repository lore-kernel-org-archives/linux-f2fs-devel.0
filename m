From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] mkfs.f2fs: reclaim free space in case of regular
	file
Date: Tue, 04 Nov 2014 18:10:54 +0900
Message-ID: <1415092254-21253-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1XlaAH-0000ei-Cq
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 04 Nov 2014 09:12:37 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XlaAF-0006GK-Fc
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 04 Nov 2014 09:12:37 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0NEI00DAJC8R4630@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 04 Nov 2014 18:12:27 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

If we use regular file instead block device, let's reclaim its free
space.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 configure.ac             |  2 +-
 mkfs/f2fs_format_utils.c | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 0111e72..d66cb73 100644
--- a/configure.ac
+++ b/configure.ac
@@ -57,7 +57,7 @@ PKG_CHECK_MODULES([libuuid], [uuid])
 
 # Checks for header files.
 AC_CHECK_HEADERS([linux/fs.h fcntl.h mntent.h stdlib.h string.h \
-		sys/ioctl.h sys/mount.h unistd.h])
+		sys/ioctl.h sys/mount.h unistd.h linux/falloc.h])
 
 # Checks for typedefs, structures, and compiler characteristics.
 AC_C_INLINE
diff --git a/mkfs/f2fs_format_utils.c b/mkfs/f2fs_format_utils.c
index 9892a8f..88b9953 100644
--- a/mkfs/f2fs_format_utils.c
+++ b/mkfs/f2fs_format_utils.c
@@ -6,18 +6,26 @@
  *
  * Dual licensed under the GPL or LGPL version 2 licenses.
  */
+#define _LARGEFILE_SOURCE
 #define _LARGEFILE64_SOURCE
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
 
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
+#include <fcntl.h>
 
 #include "f2fs_fs.h"
 
 #ifdef HAVE_LINUX_FS_H
 #include <linux/fs.h>
 #endif
+#ifdef HAVE_LINUX_FALLOC_H
+#include <linux/falloc.h>
+#endif
 
 int f2fs_trim_device()
 {
@@ -37,9 +45,15 @@ int f2fs_trim_device()
 
 #if defined(WITH_BLKDISCARD) && defined(BLKDISCARD)
 	MSG(0, "Info: Discarding device\n");
-	if (S_ISREG(stat_buf.st_mode))
+	if (S_ISREG(stat_buf.st_mode)) {
+#ifdef FALLOC_FL_PUNCH_HOLE
+		if (fallocate(config.fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				range[0], range[1]) < 0) {
+			MSG(0, "Info: fallocate(PUNCH_HOLE|KEEP_SIZE) is failed\n");
+		}
+#endif
 		return 0;
-	else if (S_ISBLK(stat_buf.st_mode)) {
+	} else if (S_ISBLK(stat_buf.st_mode)) {
 		if (ioctl(config.fd, BLKDISCARD, &range) < 0) {
 			MSG(0, "Info: This device doesn't support TRIM\n");
 		} else {
-- 
1.9.1


------------------------------------------------------------------------------
