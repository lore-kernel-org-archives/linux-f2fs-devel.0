From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 1/2] add configure option --with-root-libdir
Date: Sun, 19 Aug 2018 23:04:06 -0400
Message-ID: <20180820030407.13225-1-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@thunk.org>) id 1frb7w-000672-14
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 Aug 2018 03:45:12 +0000
Received: from imap.thunk.org ([74.207.234.97])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1frb7s-005e9w-9H
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 Aug 2018 03:45:11 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Theodore Ts'o <tytso@mit.edu>

This allows the development link libraries to be installed in
/usr/lib, while the run-libraries are installed in /lib, which is
required by Debian policy.  This can be done via:

    configure --prefix=/ --libdir=/usr/lib --with-root-libdir=/lib

The technique of working around libtool's inflexibility is borrowed
from util-linux.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 configure.ac     | 11 +++++++++++
 lib/Makefile.am  | 17 +++++++++++++++++
 mkfs/Makefile.am | 15 +++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/configure.ac b/configure.ac
index f04f281..62c18eb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -190,6 +190,17 @@ AM_CONDITIONAL([OSX], [test "$build_mac" = "yes"])
 #AC_SUBST([sbindir], [/sbin])
 #AC_SUBST([sysconfdir], [/etc])
 #AC_SUBST([localstatedir], [/var])
+
+AC_ARG_WITH([root-libdir],
+[  --with-root-libdir=DIR override location for /lib/libf2fs.so],
+root_libdir=$withval,
+root_libdir=NONE)dnl
+
+if test "$root_libdir" = NONE ; then
+   root_libdir="$libdir"
+fi
+AC_SUBST(root_libdir)
+
 AC_CONFIG_FILES([
 	Makefile
 	man/Makefile
diff --git a/lib/Makefile.am b/lib/Makefile.am
index b26b404..c1875a0 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -6,3 +6,20 @@ libf2fs_la_SOURCES = libf2fs.c libf2fs_io.c libf2fs_zoned.c
 libf2fs_la_CFLAGS = -Wall
 libf2fs_la_CPPFLAGS = -I$(top_srcdir)/include
 libf2fs_la_LDFLAGS = -version-info $(LIBF2FS_CURRENT):$(LIBF2FS_REVISION):$(LIBF2FS_AGE)
+
+root_libdir=@root_libdir@
+
+install-exec-hook:
+	if test -n "$(root_libdir)" -a "$(libdir)" != "$(root_libdir)" -a \
+	    -f "$(DESTDIR)$(libdir)/libf2fs.so"; then \
+		$(MKDIR_P) $(DESTDIR)$(root_libdir); \
+		mv $(DESTDIR)$(libdir)/libf2fs.so.* $(DESTDIR)$(root_libdir); \
+		so_img_name=$$(readlink $(DESTDIR)$(libdir)/libf2fs.so); \
+		so_img_rel_target=$$(echo $(libdir) | sed 's,\(^/\|\)[^/][^/]*,..,g'); \
+		(cd $(DESTDIR)$(libdir) && \
+			rm -f libf2fs.so && \
+			$(LN_S) $$so_img_rel_target$(root_libdir)/$$so_img_name libf2fs.so); \
+	fi
+
+uninstall-hook:
+	rm -f $(DESTDIR)$(root_libdir)/libf2fs.so*
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index bbb4917..32996ba 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -14,3 +14,18 @@ libf2fs_format_la_CFLAGS = -DWITH_BLKDISCARD
 libf2fs_format_la_CPPFLAGS = -I$(top_srcdir)/include
 libf2fs_format_la_LDFLAGS = -luuid -L$(top_builddir)/lib -lf2fs \
 	-version-info $(FMT_CURRENT):$(FMT_REVISION):$(FMT_AGE)
+
+install-exec-hook:
+	if test -n "$(root_libdir)" -a "$(libdir)" != "$(root_libdir)" -a \
+	    -f "$(DESTDIR)$(libdir)/libf2fs_format.so"; then \
+		$(MKDIR_P) $(DESTDIR)$(root_libdir); \
+		mv $(DESTDIR)$(libdir)/libf2fs_format.so.* $(DESTDIR)$(root_libdir); \
+		so_img_name=$$(readlink $(DESTDIR)$(libdir)/libf2fs_format.so); \
+		so_img_rel_target=$$(echo $(libdir) | sed 's,\(^/\|\)[^/][^/]*,..,g'); \
+		(cd $(DESTDIR)$(libdir) && \
+			rm -f libf2fs_format.so && \
+			$(LN_S) $$so_img_rel_target$(root_libdir)/$$so_img_name libf2fs_format.so); \
+	fi
+
+uninstall-hook:
+	rm $(DESTDIR)$(root_libdir)/libf2fs_format.so*
-- 
2.18.0.rc0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
