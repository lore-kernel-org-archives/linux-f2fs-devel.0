From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs-tools: add library version info
Date: Wed,  9 Dec 2015 11:12:56 -0800
Message-ID: <1449688376-3311-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a6kAs-0001rG-AK
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Dec 2015 19:13:14 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a6kAr-00054n-73 for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Dec 2015 19:13:14 +0000
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
Cc: Kai-Chung Yan <seamlikok@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Hans-Christoph Steiner <hans@eds.org>

This patch gives the version info for two libraries.

mkfs/libf2fs_format.la
lib/libf2fs.la

The versioning rule should be:

1. Start with version information of '0:0:0' for each libtool library.
2. Update the version information only immediately before a public release of
   your software. More frequent updates are unnecessary, and only guarantee
   that the current interface number gets larger faster.
2. If the library source code has changed at all since the last update, then
   increment revision (c:r:a) becomes (c:r+1:a).
3. If any interfaces have been added, removed, or changed since the last update,
   increment current, and set revision to 0.
4. If any interfaces have been added since the last public release, then
   increment age.
5. If any interfaces have been removed or changed since the last public release,
   then set age to 0.

quoted from:
http://www.gnu.org/software/libtool/manual/html_node/Updating-version-info.html#Updating-version-info

Cc: Hans-Christoph Steiner <hans@eds.org>
Cc: Kai-Chung Yan <seamlikok@gmail.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 configure.ac     | 10 ++++++++++
 lib/Makefile.am  |  1 +
 mkfs/Makefile.am |  3 ++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index b18ee4d..280a0d3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -90,4 +90,14 @@ AC_CONFIG_FILES([
 	tools/Makefile
 ])
 
+# export library version info for mkfs/libf2fs_format_la
+AC_SUBST(FMT_CURRENT, 0)
+AC_SUBST(FMT_REVISION, 0)
+AC_SUBST(FMT_AGE, 0)
+
+# export library version info for lib/libf2fs_la
+AC_SUBST(LIBF2FS_CURRENT, 0)
+AC_SUBST(LIBF2FS_REVISION, 0)
+AC_SUBST(LIBF2FS_AGE, 0)
+
 AC_OUTPUT
diff --git a/lib/Makefile.am b/lib/Makefile.am
index a6b304c..37b8d57 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -5,3 +5,4 @@ lib_LTLIBRARIES = libf2fs.la
 libf2fs_la_SOURCES = libf2fs.c libf2fs_io.c
 libf2fs_la_CFLAGS = -Wall
 libf2fs_la_CPPFLAGS = -I$(top_srcdir)/include
+libf2fs_la_LDFLAGS = -version-info $(LIBF2FS_CURRENT):$(LIBF2FS_REVISION):$(LIBF2FS_AGE)
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index 8969a04..8b4c16c 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -10,4 +10,5 @@ lib_LTLIBRARIES = libf2fs_format.la
 libf2fs_format_la_SOURCES = f2fs_format_main.c f2fs_format.c f2fs_format_utils.c
 libf2fs_format_la_CFLAGS = -DWITH_BLKDISCARD
 libf2fs_format_la_CPPFLAGS = -I$(top_srcdir)/include
-libf2fs_format_la_LDFLAGS = -luuid -L$(top_srcdir)/lib -lf2fs
+libf2fs_format_la_LDFLAGS = -luuid -L$(top_srcdir)/lib -lf2fs \
+	-version-info $(FMT_CURRENT):$(FMT_REVISION):$(FMT_AGE)
-- 
2.4.9 (Apple Git-60)


------------------------------------------------------------------------------
