From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs-tools: use pointer and memory alloaction
 instead of defining "structure stat" in function stack
Date: Tue,  3 Apr 2018 13:23:03 -0700
Message-ID: <20180403202303.80797-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1f3SSk-0004zU-N9
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Apr 2018 20:23:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f3SSg-007jXW-QQ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Apr 2018 20:23:26 +0000
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
Cc: Iris Chang <iris.chang@mediatek.com>

From: Iris Chang <iris.chang@mediatek.com>

Problem:
Function f2fs_dev_is_unmounted() and get_device_info() define local
variable "struct stat xxx". If the callstack is very deep and stack
is smaller, it will result in stack corruption.

Solution:
It is better to use pointer and memory allocation instead of defining
"structure stat" in function stack.

Signed-off-by: Iris Chang <iris.chang@mediatek.com>
---
 lib/libf2fs.c            | 28 ++++++++++++++++++++--------
 mkfs/f2fs_format_utils.c | 23 ++++++++++++++++-------
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 5c56416..05b026b 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -643,7 +643,7 @@ int f2fs_dev_is_umounted(char *path)
 #ifdef ANDROID_WINDOWS_HOST
 	return 0;
 #else
-	struct stat st_buf;
+	struct stat *st_buf;
 	int is_rootdev = 0;
 	int ret = 0;
 
@@ -690,16 +690,19 @@ int f2fs_dev_is_umounted(char *path)
 	 * If f2fs is umounted with -l, the process can still use
 	 * the file system. In this case, we should not format.
 	 */
-	if (stat(path, &st_buf) == 0 && S_ISBLK(st_buf.st_mode)) {
+	st_buf = malloc(sizeof(struct stat));
+	if (stat(path, st_buf) == 0 && S_ISBLK(st_buf->st_mode)) {
 		int fd = open(path, O_RDONLY | O_EXCL);
 
 		if (fd >= 0) {
 			close(fd);
 		} else if (errno == EBUSY) {
 			MSG(0, "\tError: In use by the system!\n");
+			free(st_buf);
 			return -1;
 		}
 	}
+	free(st_buf);
 	return ret;
 #endif
 }
@@ -751,7 +754,7 @@ int get_device_info(int i)
 #ifndef BLKGETSIZE64
 	uint32_t total_sectors;
 #endif
-	struct stat stat_buf;
+	struct stat *stat_buf;
 #ifdef HDIO_GETGIO
 	struct hd_geometry geom;
 #endif
@@ -787,16 +790,18 @@ int get_device_info(int i)
 		}
 	}
 
-	if (fstat(fd, &stat_buf) < 0 ) {
+	stat_buf = malloc(sizeof(struct stat));
+	if (fstat(fd, stat_buf) < 0 ) {
 		MSG(0, "\tError: Failed to get the device stat!\n");
+		free(stat_buf);
 		return -1;
 	}
 
 	if (c.sparse_mode) {
 		dev->total_sectors = c.device_size / dev->sector_size;
-	} else if (S_ISREG(stat_buf.st_mode)) {
-		dev->total_sectors = stat_buf.st_size / dev->sector_size;
-	} else if (S_ISBLK(stat_buf.st_mode)) {
+	} else if (S_ISREG(stat_buf->st_mode)) {
+		dev->total_sectors = stat_buf->st_size / dev->sector_size;
+	} else if (S_ISBLK(stat_buf->st_mode)) {
 #ifdef BLKSSZGET
 		if (ioctl(fd, BLKSSZGET, &sector_size) < 0)
 			MSG(0, "\tError: Using the default sector size\n");
@@ -806,11 +811,13 @@ int get_device_info(int i)
 #ifdef BLKGETSIZE64
 		if (ioctl(fd, BLKGETSIZE64, &dev->total_sectors) < 0) {
 			MSG(0, "\tError: Cannot get the device size\n");
+			free(stat_buf);
 			return -1;
 		}
 #else
 		if (ioctl(fd, BLKGETSIZE, &total_sectors) < 0) {
 			MSG(0, "\tError: Cannot get the device size\n");
+			free(stat_buf);
 			return -1;
 		}
 		dev->total_sectors = total_sectors;
@@ -851,6 +858,7 @@ int get_device_info(int i)
 #endif
 	} else {
 		MSG(0, "\tError: Volume type is not supported!!!\n");
+		free(stat_buf);
 		return -1;
 	}
 
@@ -859,11 +867,12 @@ int get_device_info(int i)
 		c.sectors_per_blk = F2FS_BLKSIZE / c.sector_size;
 	} else if (c.sector_size != c.devices[i].sector_size) {
 		MSG(0, "\tError: Different sector sizes!!!\n");
+		free(stat_buf);
 		return -1;
 	}
 
 #if !defined(WITH_ANDROID) && defined(__linux__)
-	if (S_ISBLK(stat_buf.st_mode))
+	if (S_ISBLK(stat_buf->st_mode))
 		f2fs_get_zoned_model(i);
 
 	if (dev->zoned_model != F2FS_ZONED_NONE) {
@@ -872,11 +881,13 @@ int get_device_info(int i)
 
 		if (f2fs_get_zone_blocks(i)) {
 			MSG(0, "\tError: Failed to get number of blocks per zone\n");
+			free(stat_buf);
 			return -1;
 		}
 
 		if (f2fs_check_zones(i)) {
 			MSG(0, "\tError: Failed to check zone configuration\n");
+			free(stat_buf);
 			return -1;
 		}
 		MSG(0, "Info: Host-%s zoned block device:\n",
@@ -901,6 +912,7 @@ int get_device_info(int i)
 	}
 
 	c.total_sectors += dev->total_sectors;
+	free(stat_buf);
 	return 0;
 }
 
diff --git a/mkfs/f2fs_format_utils.c b/mkfs/f2fs_format_utils.c
index e481a8f..4933fa5 100644
--- a/mkfs/f2fs_format_utils.c
+++ b/mkfs/f2fs_format_utils.c
@@ -20,6 +20,7 @@
 
 #include <stdio.h>
 #include <unistd.h>
+#include <stdlib.h>
 #ifndef ANDROID_WINDOWS_HOST
 #include <sys/ioctl.h>
 #endif
@@ -44,13 +45,15 @@ static int trim_device(int i)
 {
 #ifndef ANDROID_WINDOWS_HOST
 	unsigned long long range[2];
-	struct stat stat_buf;
+	struct stat *stat_buf;
 	struct device_info *dev = c.devices + i;
 	u_int64_t bytes = dev->total_sectors * dev->sector_size;
 	int fd = dev->fd;
 
-	if (fstat(fd, &stat_buf) < 0 ) {
+	stat_buf = malloc(sizeof(struct stat));
+	if (fstat(fd, stat_buf) < 0 ) {
 		MSG(1, "\tError: Failed to get the device stat!!!\n");
+		free(stat_buf);
 		return -1;
 	}
 
@@ -59,7 +62,7 @@ static int trim_device(int i)
 
 #if defined(WITH_BLKDISCARD) && defined(BLKDISCARD)
 	MSG(0, "Info: [%s] Discarding device\n", dev->path);
-	if (S_ISREG(stat_buf.st_mode)) {
+	if (S_ISREG(stat_buf->st_mode)) {
 #if defined(HAVE_FALLOCATE) && defined(FALLOC_FL_PUNCH_HOLE)
 		if (fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
 				range[0], range[1]) < 0) {
@@ -67,15 +70,18 @@ static int trim_device(int i)
 		}
 #endif
 		return 0;
-	} else if (S_ISBLK(stat_buf.st_mode)) {
-		if (dev->zoned_model != F2FS_ZONED_NONE)
+	} else if (S_ISBLK(stat_buf->st_mode)) {
+		if (dev->zoned_model != F2FS_ZONED_NONE) {
+			free(stat_buf);
 			return f2fs_reset_zones(i);
+		}
 #ifdef BLKSECDISCARD
 		if (ioctl(fd, BLKSECDISCARD, &range) < 0) {
 			MSG(0, "Info: This device doesn't support BLKSECDISCARD\n");
 		} else {
 			MSG(0, "Info: Secure Discarded %lu MB\n",
-					(unsigned long)stat_buf.st_size >> 20);
+					(unsigned long)stat_buf->st_size >> 20);
+			free(stat_buf);
 			return 0;
 		}
 #endif
@@ -84,11 +90,14 @@ static int trim_device(int i)
 		} else {
 			MSG(0, "Info: Discarded %llu MB\n", range[1] >> 20);
 		}
-	} else
+	} else {
+		free(stat_buf);
 		return -1;
+	}
 #endif
 
 #endif
+	free(stat_buf);
 	return 0;
 }
 
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
