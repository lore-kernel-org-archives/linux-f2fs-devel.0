From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] f2fs-tools: Fix device zoned model detection
Date: Fri, 19 Apr 2019 17:19:57 +0900
Message-ID: <20190419081957.23419-1-shinichiro.kawasaki@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=00520c172=shinichiro.kawasaki@wdc.com>)
 id 1hHOkk-0008NO-Jr
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Apr 2019 08:20:10 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hHOki-00FsBG-OU
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Apr 2019 08:20:10 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>

A partition device does not have the "zoned" nor "chunk_sectors" sysfs
attribute files. Only the owner block device of the partition has these
files. This causes the detection of the zoned model and zone size of a
partition device to fail when executing mkfs.f2fs.

Fix this problem by using the owner device sysfs directory as the base
directory for accessing the zoned and chunk_sectors files. This is done
by using the device major:minor symbolic link under the /sys/dev/block
directory, reading this link and removing the partition device name from
the link path for a partition device (which is indicated by the presence
of the "partition" file under the directory).

Also add a check for the ENOENT error when opening the device "zoned"
sysfs attribute file. The absence of this file indicates that the
kernel does not support zoned block devices. Since the device file is
already open, it exists, and so the device can safely be assumed as not
being zoned.

Changes from v1:
* Addressed Chao Yu's comment on ENOENT and return value checks
* Rewrite of sysfs file handling (simplified)
* Rebased on dev-test tree

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 lib/libf2fs_zoned.c | 101 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 88 insertions(+), 13 deletions(-)

diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
index a5f3fea..e5151c0 100644
--- a/lib/libf2fs_zoned.c
+++ b/lib/libf2fs_zoned.c
@@ -8,6 +8,7 @@
  */
 #define _LARGEFILE64_SOURCE
 
+#include <f2fs_fs.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -15,6 +16,12 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/stat.h>
+#ifdef HAVE_SYS_SYSMACROS_H
+#include <sys/sysmacros.h>
+#endif
+#ifdef HAVE_LINUX_LIMITS_H
+#include <linux/limits.h>
+#endif
 #ifndef ANDROID_WINDOWS_HOST
 #include <sys/ioctl.h>
 #endif
@@ -24,27 +31,92 @@
 
 #ifdef HAVE_LINUX_BLKZONED_H
 
+int get_sysfs_path(struct device_info *dev, const char *attr,
+		   char *buf, size_t buflen)
+{
+	struct stat statbuf;
+	char str[PATH_MAX];
+	char sysfs_path[PATH_MAX];
+	ssize_t len;
+	char *delim;
+	int ret;
+
+	if (stat(dev->path, &statbuf) < 0)
+		return -1;
+
+	snprintf(str, sizeof(str), "/sys/dev/block/%d:%d",
+		 major(statbuf.st_rdev), minor(statbuf.st_rdev));
+	len = readlink(str, buf, buflen - 1);
+	if (len < 0)
+		return -1;
+	buf[len] = '\0';
+
+	ret = snprintf(sysfs_path, sizeof(sysfs_path) - 1,
+		       "/sys/dev/block/%s", buf);
+	if (ret >= sizeof(sysfs_path))
+		return -1;
+
+	/* Test if the device is a partition */
+	ret = snprintf(str, sizeof(str), "%s/partition", sysfs_path);
+	if (ret >= sizeof(str))
+		return -1;
+	ret = stat(str, &statbuf);
+	if (ret) {
+		if (errno == ENOENT) {
+			/* Not a partition */
+			goto out;
+		}
+		return -1;
+	}
+
+	/*
+	 * The device is a partition: remove the device name from the
+	 * attribute file path to obtain the sysfs path of the holder device.
+	 *   e.g.:  /sys/dev/block/.../sda/sda1 -> /sys/dev/block/.../sda
+	 */
+	delim = strrchr(sysfs_path, '/');
+	if (!delim)
+		return -1;
+	*delim = '\0';
+
+out:
+	ret = snprintf(buf, buflen - 1, "%s/%s", sysfs_path, attr);
+	if (ret >= buflen)
+		return -1;
+
+	return 0;
+}
+
 int f2fs_get_zoned_model(int i)
 {
 	struct device_info *dev = c.devices + i;
-	char str[128];
+	char str[PATH_MAX];
 	FILE *file;
 	int res;
 
 	/* Check that this is a zoned block device */
-	snprintf(str, sizeof(str),
-		 "/sys/block/%s/queue/zoned",
-		 basename(dev->path));
+	res = get_sysfs_path(dev, "queue/zoned", str, sizeof(str));
+	if (res != 0) {
+		MSG(0, "\tError: Failed to get device sysfs path\n");
+		return -1;
+	}
+
 	file = fopen(str, "r");
 	if (!file) {
 		/*
 		 * The kernel does not support zoned block devices, but we have
-		 * a block device file. This means that the device is not zoned
-		 * or is zoned but can be randomly written (i.e. host-aware
-		 * zoned model). Treat the device as a regular block device.
+		 * a block device file. This means that if the zoned file is
+		 * not found, then the device is not zoned or is zoned but can
+		 * be randomly written (i.e. host-aware zoned model).
+		 * Treat the device as a regular block device. Otherwise, signal
+		 * the failure to verify the disk zone model.
 		 */
-		dev->zoned_model = F2FS_ZONED_NONE;
-		return 0;
+		if (errno == ENOENT) {
+			dev->zoned_model = F2FS_ZONED_NONE;
+			return 0;
+		}
+		MSG(0, "\tError: Failed to check the device zoned model\n");
+		return -1;
 	}
 
 	memset(str, 0, sizeof(str));
@@ -77,16 +149,19 @@ int f2fs_get_zone_blocks(int i)
 {
 	struct device_info *dev = c.devices + i;
 	uint64_t sectors;
-	char str[128];
+	char str[PATH_MAX];
 	FILE *file;
 	int res;
 
 	/* Get zone size */
 	dev->zone_blocks = 0;
 
-	snprintf(str, sizeof(str),
-		 "/sys/block/%s/queue/chunk_sectors",
-		 basename(dev->path));
+	res = get_sysfs_path(dev, "queue/chunk_sectors", str, sizeof(str));
+	if (res != 0) {
+		MSG(0, "\tError: Failed to get device sysfs attribute path\n");
+		return -1;
+	}
+
 	file = fopen(str, "r");
 	if (!file)
 		return -1;
-- 
2.20.1
