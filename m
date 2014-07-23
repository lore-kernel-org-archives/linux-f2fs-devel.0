From: Sankalp Bose <sankalp@tuxera.com>
Subject: [PATCH] mkfs.f2fs: Fix name conflict for BLKDISCARD
Date: Wed, 23 Jul 2014 03:28:14 +0300
Message-ID: <1406075294-10599-1-git-send-email-sankalp@tuxera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sankalp@tuxera.com>) id 1X9kcj-0006Ts-IX
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Jul 2014 00:41:37 +0000
Received: from nbl-ex10-fe02.nebula.fi ([188.117.32.122] helo=ex10.nebula.fi)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps
	(TLSv1:AES128-SHA:128) (Exim 4.76) id 1X9kch-00048N-I8
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Jul 2014 00:41:37 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: sankalp@tuxera.com, linux-f2fs-devel@lists.sourceforge.net

The compile time option BLKDISCARD conflicts with ioctl code
for discard. This causes discard to fail with "Info: This
device doesn't support TRIM". Rename compile time option
to WITH_BLKDISCARD.

Signed-off-by: Sankalp Bose <sankalp@tuxera.com>
---
 configure.ac             | 2 +-
 mkfs/Makefile.am         | 2 +-
 mkfs/f2fs_format_utils.c | 7 ++++++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index c2dafb0..0111e72 100644
--- a/configure.ac
+++ b/configure.ac
@@ -56,7 +56,7 @@ AC_PATH_PROG([LDCONFIG], [ldconfig],
 PKG_CHECK_MODULES([libuuid], [uuid])
 
 # Checks for header files.
-AC_CHECK_HEADERS([fcntl.h mntent.h stdlib.h string.h \
+AC_CHECK_HEADERS([linux/fs.h fcntl.h mntent.h stdlib.h string.h \
 		sys/ioctl.h sys/mount.h unistd.h])
 
 # Checks for typedefs, structures, and compiler characteristics.
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index ff136a7..fa48699 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -1,7 +1,7 @@
 ## Makefile.am
 
 AM_CPPFLAGS = ${libuuid_CFLAGS} -I$(top_srcdir)/include
-AM_CFLAGS = -Wall -DBLKDISCARD
+AM_CFLAGS = -Wall -DWITH_BLKDISCARD
 sbin_PROGRAMS = mkfs.f2fs
 mkfs_f2fs_SOURCES = f2fs_format_main.c f2fs_format.c f2fs_format_utils.c
 mkfs_f2fs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/libf2fs.la
diff --git a/mkfs/f2fs_format_utils.c b/mkfs/f2fs_format_utils.c
index 8f7e094..1e629ed 100644
--- a/mkfs/f2fs_format_utils.c
+++ b/mkfs/f2fs_format_utils.c
@@ -15,6 +15,11 @@
 
 #include "f2fs_fs.h"
 
+#ifdef HAVE_LINUX_FS_H
+#include <linux/fs.h>
+#endif
+
+
 int f2fs_trim_device()
 {
 	unsigned long long range[2];
@@ -31,7 +36,7 @@ int f2fs_trim_device()
 		return -1;
 	}
 
-#if defined(BLKDISCARD)
+#if defined(WITH_BLKDISCARD) && defined(BLKDISCARD)
 	MSG(0, "Info: Discarding device\n");
 	if (S_ISREG(stat_buf.st_mode))
 		return 0;
-- 
2.0.1


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
