From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs-tools: get kernel version via
 uname(2)
Date: Tue, 1 May 2018 15:55:28 -0700
Message-ID: <20180501225528.GA63516@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180501211424.46491-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fDeBR-0000uO-B9
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 01 May 2018 22:55:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fDeBL-004SWk-AL
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 01 May 2018 22:55:41 +0000
Received: from localhost (unknown [104.132.1.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 94E84236F2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  1 May 2018 22:55:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20180501211424.46491-1-jaegeuk@kernel.org>
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

Change log from v1:
 - fix build error by checking sys/utsname.h

This patch introduces uname(2) to get kernel version.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 configure.ac       |  1 +
 fsck/mount.c       |  2 +-
 include/f2fs_fs.h  |  1 +
 lib/libf2fs.c      | 20 ++++++++++++++++++++
 mkfs/f2fs_format.c |  2 +-
 5 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 64c156e..a3ff12b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -102,6 +102,7 @@ AC_CHECK_HEADERS(m4_flatten([
 	sys/syscall.h
 	sys/mount.h
 	sys/sysmacros.h
+	sys/utsname.h
 	sys/xattr.h
 	unistd.h
 ]))
diff --git a/fsck/mount.c b/fsck/mount.c
index e4ca0b8..61ea0ea 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -625,7 +625,7 @@ int validate_super_block(struct f2fs_sb_info *sbi, int block)
 			dev_read_version(c.version, 0, VERSION_LEN);
 			get_kernel_version(c.version);
 		} else {
-			memset(c.version, 0, VERSION_LEN);
+			get_kernel_uname_version(c.version);
 		}
 
 		/* build sb version */
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 8ed9db1..e800004 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1118,6 +1118,7 @@ extern int dev_reada_block(__u64);
 
 extern int dev_read_version(void *, __u64, size_t);
 extern void get_kernel_version(__u8 *);
+extern void get_kernel_uname_version(__u8 *);
 f2fs_hash_t f2fs_dentry_hash(const unsigned char *, int);
 
 static inline bool f2fs_has_extra_isize(struct f2fs_inode *inode)
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 19491b6..5ef0214 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -27,6 +27,9 @@
 #ifdef HAVE_SYS_SYSMACROS_H
 #include <sys/sysmacros.h>
 #endif
+#ifdef HAVE_SYS_UTSNAME_H
+#include <sys/utsname.h>
+#endif
 #ifndef WITH_ANDROID
 #ifdef HAVE_SCSI_SG_H
 #include <scsi/sg.h>
@@ -740,6 +743,21 @@ void get_kernel_version(__u8 *version)
 	memset(version + i, 0, VERSION_LEN + 1 - i);
 }
 
+void get_kernel_uname_version(__u8 *version)
+{
+#ifdef HAVE_SYS_UTSNAME_H
+	struct utsname buf;
+
+	memset(version, 0, VERSION_LEN);
+	if (uname(&buf))
+		return;
+
+	snprintf((char *)version,
+		VERSION_LEN, "%s %s", buf.release, buf.version);
+#else
+	memset(version, 0, VERSION_LEN);
+#endif
+}
 
 #if defined(__linux__) && defined(_IO) && !defined(BLKGETSIZE)
 #define BLKGETSIZE	_IO(0x12,96)
@@ -796,7 +814,9 @@ int get_device_info(int i)
 	}
 
 	if (c.kd == -1) {
+#if !defined(WITH_ANDROID) && defined(__linux__)
 		c.kd = open("/proc/version", O_RDONLY);
+#endif
 		if (c.kd < 0) {
 			MSG(0, "\tInfo: No support kernel version!\n");
 			c.kd = -2;
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 0fc8b30..09886b4 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -442,7 +442,7 @@ static int f2fs_prepare_super_block(void)
 		get_kernel_version(c.version);
 		MSG(0, "Info: format version with\n  \"%s\"\n", c.version);
 	} else {
-		memset(c.version, 0, VERSION_LEN);
+		get_kernel_uname_version(c.version);
 	}
 
 	memcpy(sb->version, c.version, VERSION_LEN);
-- 
2.17.0.484.g0c8726318c-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
