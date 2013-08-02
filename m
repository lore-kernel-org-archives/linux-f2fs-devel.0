From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] libf2fs: check more conditions on mounted
	filesystem
Date: Fri, 02 Aug 2013 17:09:49 +0900
Message-ID: <1375430989-4689-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1V5ARM-0004nN-PC
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 02 Aug 2013 08:10:24 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V5ARJ-0002Kp-9v for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 02 Aug 2013 08:10:23 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MQW00JQA9D2OGC0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 02 Aug 2013 17:10:14 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In the case of lazy umount, "umount -l", some processes are able to use the
file system even if its mountpoint was disconnected.
At this moment, we should not allow mkfs.f2fs.
This patch adds this condition check.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fsck/main.c        |  2 +-
 include/f2fs_fs.h  |  2 +-
 lib/libf2fs.c      | 60 +++++++++++++++++++++++++++++++++++++++---------------
 mkfs/f2fs_format.c |  2 +-
 4 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 80db15d..a0144fc 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -183,7 +183,7 @@ int main (int argc, char **argv)
 
 	f2fs_parse_options(argc, argv);
 
-	if (f2fs_dev_is_mounted(&config) < 0)
+	if (f2fs_dev_is_umounted(&config) < 0)
 		return -1;
 
 	/* Get device */
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index d0fc79e..7081e5e 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -641,7 +641,7 @@ extern u_int32_t f2fs_cal_crc32(u_int32_t, void *, int);
 extern int f2fs_crc_valid(u_int32_t blk_crc, void *buf, int len);
 
 extern void f2fs_init_configuration(struct f2fs_configuration *);
-extern int f2fs_dev_is_mounted(struct f2fs_configuration *);
+extern int f2fs_dev_is_umounted(struct f2fs_configuration *);
 extern int f2fs_get_device_info(struct f2fs_configuration *);
 
 extern int dev_read(void *, __u64, size_t);
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index b02072f..6947425 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <errno.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <mntent.h>
@@ -365,31 +366,58 @@ void f2fs_init_configuration(struct f2fs_configuration *c)
 	c->device_name = NULL;
 }
 
-int f2fs_dev_is_mounted(struct f2fs_configuration *c)
+static int is_mounted(const char *mpt, const char *device)
 {
 	FILE *file = NULL;
 	struct mntent *mnt = NULL;
 
-	file = setmntent(MOUNTED, "r");
-	if (file == NULL) {
-		/* if failed due to /etc/mtab file not present
-		   try with /proc/mounts */
-		file = setmntent("/proc/mounts", "r");
-		if (file == NULL)
-			return 0;
-	}
+	file = setmntent(mpt, "r");
+	if (file == NULL)
+		return 0;
 
-	while (1) {
-		mnt = getmntent(file);
-		if (mnt == NULL)
+	while ((mnt = getmntent(file)) != NULL) {
+		if (!strcmp(device, mnt->mnt_fsname))
 			break;
-		if (!strcmp(c->device_name, mnt->mnt_fsname)) {
-			endmntent(file);
-			MSG(0, "\tError: Not available on mounted device!\n");
+	}
+	endmntent(file);
+	return mnt ? 1 : 0;
+}
+
+int f2fs_dev_is_umounted(struct f2fs_configuration *c)
+{
+	struct stat st_buf;
+	int ret = 0;
+
+	ret = is_mounted(MOUNTED, c->device_name);
+	if (ret) {
+		MSG(0, "\tError: Not available on mounted device!\n");
+		return -1;
+	}
+
+	/*
+	 * if failed due to /etc/mtab file not present
+	 * try with /proc/mounts.
+	 */
+	ret = is_mounted("/proc/mounts", c->device_name);
+	if (ret) {
+		MSG(0, "\tError: Not available on mounted device!\n");
+		return -1;
+	}
+
+	/*
+	 * If f2fs is umounted with -l, the process can still use
+	 * the file system. In this case, we should not format.
+	 */
+	if (stat(c->device_name, &st_buf) == 0 && S_ISBLK(st_buf.st_mode)) {
+		int fd = open(c->device_name, O_RDONLY | O_EXCL);
+
+		if (fd >= 0) {
+			close(fd);
+		} else if (errno == EBUSY) {
+			MSG(0, "\tError: In use by the system!\n");
 			return -1;
 		}
 	}
-	endmntent(file);
 	return 0;
 }
 
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index d60f990..5b017c7 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -998,7 +998,7 @@ int main(int argc, char *argv[])
 
 	f2fs_parse_options(argc, argv);
 
-	if (f2fs_dev_is_mounted(&config) < 0)
+	if (f2fs_dev_is_umounted(&config) < 0)
 		return -1;
 
 	if (f2fs_get_device_info(&config) < 0)
-- 
1.8.3.1.437.g0dbd812


------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
