From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] libf2fs: avoid to use static local string for
 global f2fs_conf
Date: Thu, 22 Nov 2018 03:57:44 -0800
Message-ID: <20181122115744.51781-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gPncX-0000u5-CE
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Nov 2018 11:58:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gPncG-00HDBn-EM
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Nov 2018 11:58:09 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

We don't need to use c.rootdev_name, but do it locally.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 lib/libf2fs.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index a1a5c02..cc335db 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -535,22 +535,21 @@ __u32 f2fs_inode_chksum(struct f2fs_node *node)
 /*
  * try to identify the root device
  */
-const char *get_rootdev()
+char *get_rootdev()
 {
 #if defined(ANDROID_WINDOWS_HOST) || defined(WITH_ANDROID)
 	return NULL;
 #else
 	struct stat sb;
 	int fd, ret;
-	char buf[32];
+	char buf[PATH_MAX + 1];
 	char *uevent, *ptr;
-
-	static char rootdev[PATH_MAX + 1];
+	char *rootdev;
 
 	if (stat("/", &sb) == -1)
 		return NULL;
 
-	snprintf(buf, 32, "/sys/dev/block/%u:%u/uevent",
+	snprintf(buf, PATH_MAX, "/sys/dev/block/%u:%u/uevent",
 		major(sb.st_dev), minor(sb.st_dev));
 
 	fd = open(buf, O_RDONLY);
@@ -577,8 +576,16 @@ const char *get_rootdev()
 		return NULL;
 
 	ret = sscanf(ptr, "DEVNAME=%s\n", buf);
-	snprintf(rootdev, PATH_MAX + 1, "/dev/%s", buf);
+	if (strlen(buf) == 0)
+		return NULL;
 
+	ret = strlen(buf) + 5;
+	rootdev = malloc(ret + 1);
+	if (!rootdev)
+		return NULL;
+	rootdev[ret] = '\0';
+
+	snprintf(rootdev, ret, "/dev/%s", buf);
 	return rootdev;
 #endif
 }
@@ -594,7 +601,6 @@ void f2fs_init_configuration(void)
 	c.ndevs = 1;
 	c.sectors_per_blk = DEFAULT_SECTORS_PER_BLOCK;
 	c.blks_per_seg = DEFAULT_BLOCKS_PER_SEGMENT;
-	c.rootdev_name = get_rootdev();
 	c.wanted_total_sectors = -1;
 	c.wanted_sector_size = -1;
 #ifndef WITH_ANDROID
@@ -654,9 +660,13 @@ int f2fs_dev_is_umounted(char *path)
 	struct stat *st_buf;
 	int is_rootdev = 0;
 	int ret = 0;
+	char *rootdev_name = get_rootdev();
 
-	if (c.rootdev_name && !strcmp(path, c.rootdev_name))
-		is_rootdev = 1;
+	if (rootdev_name) {
+		if (!strcmp(path, rootdev_name))
+			is_rootdev = 1;
+		free(rootdev_name);
+	}
 
 	/*
 	 * try with /proc/mounts fist to detect RDONLY.
-- 
2.19.0.605.g01d371f741-goog
