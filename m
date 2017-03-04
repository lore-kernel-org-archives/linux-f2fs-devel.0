From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH v2 2/2] mkfs.f2fs: check overwrite before make
	filesystem
Date: Sat, 4 Mar 2017 21:16:27 +0800
Message-ID: <fb227247-220d-3391-9438-7423c8f17cee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1ck9YE-0002rV-E3
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Mar 2017 13:16:46 +0000
Received: from mail-io0-f195.google.com ([209.85.223.195])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ck9YA-0002rE-RW
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Mar 2017 13:16:46 +0000
Received: by mail-io0-f195.google.com with SMTP id f103so9380304ioi.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 04 Mar 2017 05:16:42 -0800 (PST)
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
Cc: linux-f2fs-devel@lists.sourceforge.net

Mkfs.f2fs doesn't check the overwrite of exist filesystem.
Avoid formatting an exist filesystem by mistake, a notice is important.
The code is modified from xfsprogs.

v2, add the manpages description of -f.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 configure.ac            | 20 +++++++++--
 man/mkfs.f2fs.8         |  5 +++
 mkfs/Makefile.am        |  4 +--
 mkfs/f2fs_format_main.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 114 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6a3f7c4..d6de43b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -48,8 +48,11 @@ AC_CHECK_HEADERS_ONCE([
 # Test configure options.
 AC_ARG_WITH([selinux],
 	AS_HELP_STRING([--without-selinux],
-	  [Ignore presence of libselinux and disable selinux support])
-)
+	  [Ignore presence of libselinux and disable selinux support]))
+
+AC_ARG_WITH([blkid],
+	AS_HELP_STRING([--without-blkid],
+	  [Ignore presence of libblkid and disable blkid support]))
 
 # Checks for programs.
 AC_PROG_CC
@@ -74,6 +77,19 @@ AS_IF([test "x$have_selinux" = "xyes"],
 	)]
 )
 
+AS_IF([test "x$with_blkid" != "xno"],
+	[PKG_CHECK_MODULES([libblkid], [blkid],
+	                   [have_blkid=yes], [have_blkid=no])],
+	[have_blkid=no]
+)
+
+AS_IF([test "x$have_blkid" = "xyes"],
+	[AC_DEFINE([HAVE_LIBBLKID], [1], [Use blkid])],
+	[AS_IF([test "x$with_blkid" = "xyes"],
+		[AC_MSG_ERROR([blkid support requested but libblkid not found])]
+	)]
+)
+
 # Checks for header files.
 AC_CHECK_HEADERS([linux/fs.h linux/blkzoned.h fcntl.h mntent.h stdlib.h string.h \
 		sys/ioctl.h sys/mount.h unistd.h linux/falloc.h byteswap.h])
diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
index f7bcad4..9c87541 100644
--- a/man/mkfs.f2fs.8
+++ b/man/mkfs.f2fs.8
@@ -73,6 +73,11 @@ The data of files having those extensions will be stored to the cold log.
 The default list includes most of multimedia file extensions such as jpg, gif,
 mpeg, mkv, and so on.
 .TP
+.BI \-f
+Force overwrite when an existing filesystem is detected on the device.
+By default, mkfs.f2fs will not write to the device if it suspects that
+there is a filesystem or partition table on the device already.
+.TP
 .BI \-l " volume-label"
 Specify the volume label to the partition mounted as F2FS.
 .TP
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index 8b4c16c..162a0cf 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -1,10 +1,10 @@
 ## Makefile.am
 
-AM_CPPFLAGS = ${libuuid_CFLAGS} -I$(top_srcdir)/include
+AM_CPPFLAGS = ${libuuid_CFLAGS} ${libblkid_CFLAGS} -I$(top_srcdir)/include
 AM_CFLAGS = -Wall -DWITH_BLKDISCARD
 sbin_PROGRAMS = mkfs.f2fs
 mkfs_f2fs_SOURCES = f2fs_format_main.c f2fs_format.c f2fs_format_utils.c f2fs_format_utils.h $(top_srcdir)/include/f2fs_fs.h
-mkfs_f2fs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/libf2fs.la
+mkfs_f2fs_LDADD = ${libuuid_LIBS} ${libblkid_LIBS} $(top_builddir)/lib/libf2fs.la
 
 lib_LTLIBRARIES = libf2fs_format.la
 libf2fs_format_la_SOURCES = f2fs_format_main.c f2fs_format.c f2fs_format_utils.c
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 0ac87ed..482506a 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -18,10 +18,16 @@
 #include <time.h>
 #include <uuid/uuid.h>
 
+#include "config.h"
+#ifdef HAVE_LIBBLKID
+#  include <blkid/blkid.h>
+#endif
+
 #include "f2fs_fs.h"
 #include "f2fs_format_utils.h"
 
 extern struct f2fs_configuration c;
+static int force_overwrite = 0;
 
 static void mkfs_usage()
 {
@@ -31,6 +37,7 @@ static void mkfs_usage()
 	MSG(0, "  -c [device path] up to 7 devices excepts meta device\n");
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -e [extension list] e.g. \"mp3,gif,mov\"\n");
+	MSG(0, "  -f force overwrite the exist filesystem\n");
 	MSG(0, "  -l label\n");
 	MSG(0, "  -m support zoned block device [default:0]\n");
 	MSG(0, "  -o overprovision ratio [default:5]\n");
@@ -72,7 +79,7 @@ static void parse_feature(const char *features)
 
 static void f2fs_parse_options(int argc, char *argv[])
 {
-	static const char *option_string = "qa:c:d:e:l:mo:O:s:z:t:";
+	static const char *option_string = "qa:c:d:e:l:mo:O:s:z:t:f";
 	int32_t option=0;
 
 	while ((option = getopt(argc,argv,option_string)) != EOF) {
@@ -128,6 +135,9 @@ static void f2fs_parse_options(int argc, char *argv[])
 		case 't':
 			c.trim = atoi(optarg);
 			break;
+		case 'f':
+			force_overwrite = 1;
+			break;
 		default:
 			MSG(0, "\tError: Unknown option %c\n",option);
 			mkfs_usage();
@@ -155,6 +165,79 @@ static void f2fs_parse_options(int argc, char *argv[])
 		c.feature |= cpu_to_le32(F2FS_FEATURE_BLKZONED);
 }
 
+#ifdef HAVE_LIBBLKID
+static int f2fs_dev_is_overwrite(const char *device)
+{
+	const char	*type;
+	blkid_probe	pr = NULL;
+	int		ret = -1;
+
+	if (!device || !*device)
+		return 0;
+
+	pr = blkid_new_probe_from_filename(device);
+	if (!pr)
+		goto out;
+
+	ret = blkid_probe_enable_partitions(pr, 1);
+	if (ret < 0)
+		goto out;
+
+	ret = blkid_do_fullprobe(pr);
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * Blkid returns 1 for nothing found and 0 when it finds a signature,
+	 * but we want the exact opposite, so reverse the return value here.
+	 *
+	 * In addition print some useful diagnostics about what actually is
+	 * on the device.
+	 */
+	if (ret) {
+		ret = 0;
+		goto out;
+	}
+
+	if (!blkid_probe_lookup_value(pr, "TYPE", &type, NULL)) {
+		MSG(0, "\t%s appears to contain an existing filesystem (%s).\n",
+			device, type);
+	} else if (!blkid_probe_lookup_value(pr, "PTTYPE", &type, NULL)) {
+		MSG(0, "\t%s appears to contain a partition table (%s).\n",
+			device, type);
+	} else {
+		MSG(0, "\t%s appears to contain something weird according to blkid\n",
+			device);
+	}
+	ret = 1;
+out:
+	if (pr)
+		blkid_free_probe(pr);
+	if (ret == -1)
+		MSG(0, "\tprobe of %s failed, cannot detect existing filesystem.\n",
+			device);
+	return ret;
+}
+
+static int f2fs_check_overwrite(void)
+{
+	int i;
+
+	for (i = 0; i < c.ndevs; i++)
+		if (f2fs_dev_is_overwrite((char *)c.devices[i].path))
+			return -1;
+	return 0;
+}
+
+#else
+
+static int f2fs_check_overwrite(void)
+{
+	return 0;
+}
+
+#endif /* HAVE_LIBBLKID */
+
 int main(int argc, char *argv[])
 {
 	f2fs_init_configuration();
@@ -163,6 +246,11 @@ int main(int argc, char *argv[])
 
 	f2fs_show_info();
 
+	if (!force_overwrite && f2fs_check_overwrite()) {
+		MSG(0, "\tUse the -f option to force overwrite.\n");
+		return -1;
+	}
+
 	if (f2fs_devs_are_umounted() < 0) {
 		MSG(0, "\tError: Not available on mounted device!\n");
 		return -1;
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
