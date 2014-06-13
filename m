From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] libf2fs, fsck,
	mkfs: call f2fs_finalize_device before exit
Date: Fri, 13 Jun 2014 17:25:25 +0900
Message-ID: <1402647925-79429-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1WvMnt-0003PP-43
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Jun 2014 08:25:41 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WvMnr-00011z-B3 for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Jun 2014 08:25:41 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

The fsck tool should call f2fs_finalize_device before exit to close the device
file.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c              |  3 +++
 include/f2fs_fs.h        |  1 +
 lib/libf2fs.c            | 12 ++++++++++++
 mkfs/f2fs_format.c       |  2 --
 mkfs/f2fs_format_main.c  |  2 ++
 mkfs/f2fs_format_utils.c | 14 --------------
 mkfs/f2fs_format_utils.h |  1 -
 7 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 5aa3956..46f5d04 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -203,6 +203,9 @@ int main (int argc, char **argv)
 	}
 
 	f2fs_do_umount(sbi);
+
+	f2fs_finalize_device(&config);
+
 	printf("\nDone.\n");
 	return ret;
 }
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 4f44866..53b8cb9 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -659,6 +659,7 @@ extern int f2fs_crc_valid(u_int32_t blk_crc, void *buf, int len);
 extern void f2fs_init_configuration(struct f2fs_configuration *);
 extern int f2fs_dev_is_umounted(struct f2fs_configuration *);
 extern int f2fs_get_device_info(struct f2fs_configuration *);
+extern void f2fs_finalize_device(struct f2fs_configuration *);
 
 extern int dev_read(void *, __u64, size_t);
 extern int dev_write(void *, __u64, size_t);
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 6168c5c..8d6c670 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -493,3 +493,15 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
 	return 0;
 }
 
+void f2fs_finalize_device(struct f2fs_configuration *c)
+{
+	/*
+	 * We should call fsync() to flush out all the dirty pages
+	 * in the block device page cache.
+	 */
+	if (fsync(c->fd) < 0)
+		MSG(0, "\tError: Could not conduct fsync!!!\n");
+
+	if (close(c->fd) < 0)
+		MSG(0, "\tError: Failed to close device file!!!\n");
+}
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index c7c6971..1568545 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -880,7 +880,5 @@ exit:
 	if (err)
 		MSG(0, "\tError: Could not format the device!!!\n");
 
-	f2fs_finalize_device();
-
 	return err;
 }
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 2b6c195..19c52e4 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -129,6 +129,8 @@ int main(int argc, char *argv[])
 	if (f2fs_format_device() < 0)
 		return -1;
 
+	f2fs_finalize_device(&config);
+
 	MSG(0, "Info: format successful\n");
 
 	return 0;
diff --git a/mkfs/f2fs_format_utils.c b/mkfs/f2fs_format_utils.c
index f4c3767..5cc2a32 100644
--- a/mkfs/f2fs_format_utils.c
+++ b/mkfs/f2fs_format_utils.c
@@ -15,20 +15,6 @@
 
 #include "f2fs_fs.h"
 
-void f2fs_finalize_device()
-{
-	/*
-	 * We should call fsync() to flush out all the dirty pages
-	 * in the block device page cache.
-	 */
-	if (fsync(config.fd) < 0)
-		MSG(0, "\tError: Could not conduct fsync!!!\n");
-
-	if (close(config.fd) < 0)
-		MSG(0, "\tError: Failed to close device file!!!\n");
-
-}
-
 int f2fs_trim_device()
 {
 	unsigned long long range[2];
diff --git a/mkfs/f2fs_format_utils.h b/mkfs/f2fs_format_utils.h
index fb731fc..9eb2cea 100644
--- a/mkfs/f2fs_format_utils.h
+++ b/mkfs/f2fs_format_utils.h
@@ -12,6 +12,5 @@
 
 extern struct f2fs_configuration config;
 
-void f2fs_finalize_device(void);
 int f2fs_trim_device(void);
 int f2fs_format_device(void);
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
