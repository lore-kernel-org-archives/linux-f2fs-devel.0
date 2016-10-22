From: Christian Hesse <mail@eworm.de>
Subject: [PATCH 1/1] sload.f2fs: allow to build without libselinux
Date: Sat, 22 Oct 2016 22:06:54 +0200
Message-ID: <20161022200654.11193-1-mail@eworm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eworm@leda.eworm.de>) id 1by2pw-0003S7-MK
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 22 Oct 2016 20:24:12 +0000
Received: from mx.mylinuxtime.de ([148.251.109.235])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1by2pt-0007do-13
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 22 Oct 2016 20:24:12 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Christian Hesse <mail@eworm.de>

Some systems do not have libselinux. Allow to build sload.f2fs without
support for selinux.

Signed-off-by: Christian Hesse <mail@eworm.de>
---
 configure.ac |  4 +++-
 fsck/sload.c | 12 +++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index f519790..7a62328 100644
--- a/configure.ac
+++ b/configure.ac
@@ -54,7 +54,9 @@ AC_PATH_PROG([LDCONFIG], [ldconfig],
 
 # Checks for libraries.
 PKG_CHECK_MODULES([libuuid], [uuid])
-PKG_CHECK_MODULES([libselinux], [libselinux])
+PKG_CHECK_MODULES([libselinux], [libselinux],
+	[AC_DEFINE([HAVE_LIBSELINUX], [1], [Use libselinux])],
+	[AC_MSG_NOTICE([libselinux not found])])
 
 # Checks for header files.
 AC_CHECK_HEADERS([linux/fs.h fcntl.h mntent.h stdlib.h string.h \
diff --git a/fsck/sload.c b/fsck/sload.c
index 424e642..662119d 100644
--- a/fsck/sload.c
+++ b/fsck/sload.c
@@ -16,8 +16,11 @@
 #include <libgen.h>
 #include <dirent.h>
 #include <mntent.h>
+
+#ifdef HAVE_LIBSELINUX
 #include <selinux/selinux.h>
 #include <selinux/label.h>
+#endif
 
 #ifdef WITH_ANDROID
 #include <selinux/label.h>
@@ -110,10 +113,12 @@ static int build_directory(struct f2fs_sb_info *sbi, const char *full_path,
 		handle_selabel(dentries + i, S_ISDIR(stat.st_mode),
 							target_out_dir);
 
+#ifdef HAVE_LIBSELINUX
 		if (sehnd && selabel_lookup(sehnd, &dentries[i].secon,
 					dentries[i].path, stat.st_mode) < 0)
 			ERR_MSG("Cannot lookup security context for %s\n",
 						dentries[i].path);
+#endif
 
 		dentries[i].pino = dir_ino;
 
@@ -174,6 +179,7 @@ static int build_directory(struct f2fs_sb_info *sbi, const char *full_path,
 			MSG(1, "Error unknown file type\n");
 		}
 
+#ifdef HAVE_LIBSELINUX
 		if (dentries[i].secon) {
 			inode_set_selinux(sbi, dentries[i].ino, dentries[i].secon);
 			MSG(1, "File = %s \n----->SELinux context = %s\n",
@@ -184,10 +190,12 @@ static int build_directory(struct f2fs_sb_info *sbi, const char *full_path,
 					dentries[i].gid, dentries[i].capabilities);
 		}
 
+		free(dentries[i].secon);
+#endif
+
 		free(dentries[i].path);
 		free(dentries[i].full_path);
 		free((void *)dentries[i].name);
-		free(dentries[i].secon);
 	}
 
 	free(dentries);
@@ -218,6 +226,7 @@ int f2fs_sload(struct f2fs_sb_info *sbi, const char *from_dir,
 		return ret;
 	}
 
+#ifdef HAVE_LIBSELINUX
 	if (sehnd) {
 		char *secontext = NULL;
 
@@ -233,6 +242,7 @@ int f2fs_sload(struct f2fs_sb_info *sbi, const char *from_dir,
 		}
 		free(secontext);
 	}
+#endif
 
 	/* update curseg info; can update sit->types */
 	move_curseg_info(sbi, SM_I(sbi)->main_blkaddr);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
