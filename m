From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] mkfs: get fd for f2fs_trim_device
Date: Sat, 24 Sep 2016 11:21:38 -0700
Message-ID: <20160924182140.25395-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bnraB-0005Tn-AO
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 18:21:51 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bnraA-0002PY-7o
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 18:21:51 +0000
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

This patch is to get a parameter for fd in f2fs_trim_device.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format.c       | 10 ++++++----
 mkfs/f2fs_format_utils.c | 28 ++++++++++++----------------
 mkfs/f2fs_format_utils.h |  2 +-
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 6b1318a..466df27 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -927,10 +927,12 @@ int f2fs_format_device(void)
 		goto exit;
 	}
 
-	err = f2fs_trim_device();
-	if (err < 0) {
-		MSG(0, "\tError: Failed to trim whole device!!!\n");
-		goto exit;
+	if (config.trim) {
+		err = f2fs_trim_device(config.fd);
+		if (err < 0) {
+			MSG(0, "\tError: Failed to trim whole device!!!\n");
+			goto exit;
+		}
 	}
 
 	err = f2fs_init_sit_area();
diff --git a/mkfs/f2fs_format_utils.c b/mkfs/f2fs_format_utils.c
index d469ce5..eb8e3c0 100644
--- a/mkfs/f2fs_format_utils.c
+++ b/mkfs/f2fs_format_utils.c
@@ -34,27 +34,24 @@
 #define BLKSECDISCARD	_IO(0x12,125)
 #endif
 
-int f2fs_trim_device()
+int f2fs_trim_device(int fd)
 {
 	unsigned long long range[2];
 	struct stat stat_buf;
 
-	if (!config.trim)
-		return 0;
-
-	range[0] = 0;
-	range[1] = config.total_sectors * config.sector_size;
-
-	if (fstat(config.fd, &stat_buf) < 0 ) {
+	if (fstat(fd, &stat_buf) < 0 ) {
 		MSG(1, "\tError: Failed to get the device stat!!!\n");
 		return -1;
 	}
 
+	range[0] = 0;
+	range[1] = stat_buf.st_size;
+
 #if defined(WITH_BLKDISCARD) && defined(BLKDISCARD)
 	MSG(0, "Info: Discarding device\n");
 	if (S_ISREG(stat_buf.st_mode)) {
 #if defined(HAVE_FALLOCATE) && defined(FALLOC_FL_PUNCH_HOLE)
-		if (fallocate(config.fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+		if (fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
 				range[0], range[1]) < 0) {
 			MSG(0, "Info: fallocate(PUNCH_HOLE|KEEP_SIZE) is failed\n");
 		}
@@ -62,23 +59,22 @@ int f2fs_trim_device()
 		return 0;
 	} else if (S_ISBLK(stat_buf.st_mode)) {
 #ifdef BLKSECDISCARD
-		if (ioctl(config.fd, BLKSECDISCARD, &range) < 0) {
+		if (ioctl(fd, BLKSECDISCARD, &range) < 0) {
 			MSG(0, "Info: This device doesn't support BLKSECDISCARD\n");
 		} else {
-			MSG(0, "Info: Secure Discarded %lu sectors\n",
-						config.total_sectors);
+			MSG(0, "Info: Secure Discarded %lu MB\n",
+						stat_buf.st_size >> 20);
 			return 0;
 		}
 #endif
-		if (ioctl(config.fd, BLKDISCARD, &range) < 0) {
+		if (ioctl(fd, BLKDISCARD, &range) < 0) {
 			MSG(0, "Info: This device doesn't support BLKDISCARD\n");
 		} else {
-			MSG(0, "Info: Discarded %lu sectors\n",
-						config.total_sectors);
+			MSG(0, "Info: Discarded %lu MB\n",
+						stat_buf.st_size >> 20);
 		}
 	} else
 		return -1;
 #endif
 	return 0;
 }
-
diff --git a/mkfs/f2fs_format_utils.h b/mkfs/f2fs_format_utils.h
index 9eb2cea..8bf598e 100644
--- a/mkfs/f2fs_format_utils.h
+++ b/mkfs/f2fs_format_utils.h
@@ -12,5 +12,5 @@
 
 extern struct f2fs_configuration config;
 
-int f2fs_trim_device(void);
+int f2fs_trim_device(int);
 int f2fs_format_device(void);
-- 
2.8.3


------------------------------------------------------------------------------
