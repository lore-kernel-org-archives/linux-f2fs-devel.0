From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] mkfs.f2fs: fix the discarding size for block
	device
Date: Tue, 18 Oct 2016 15:07:07 -0700
Message-ID: <20161018220707.17995-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bwcXa-0000eD-6u
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Oct 2016 22:07:22 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bwcXZ-0006ig-A7
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Oct 2016 22:07:22 +0000
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

This patch fixes wrong discarding size.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format.c       | 2 +-
 mkfs/f2fs_format_utils.c | 7 +++----
 mkfs/f2fs_format_utils.h | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 659c73c..1453b6b 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -948,7 +948,7 @@ int f2fs_format_device(void)
 	}
 
 	if (c.trim) {
-		err = f2fs_trim_device(c.fd);
+		err = f2fs_trim_device(c.fd, c.total_sectors * c.sector_size);
 		if (err < 0) {
 			MSG(0, "\tError: Failed to trim whole device!!!\n");
 			goto exit;
diff --git a/mkfs/f2fs_format_utils.c b/mkfs/f2fs_format_utils.c
index eb8e3c0..ba93308 100644
--- a/mkfs/f2fs_format_utils.c
+++ b/mkfs/f2fs_format_utils.c
@@ -34,7 +34,7 @@
 #define BLKSECDISCARD	_IO(0x12,125)
 #endif
 
-int f2fs_trim_device(int fd)
+int f2fs_trim_device(int fd, u_int64_t bytes)
 {
 	unsigned long long range[2];
 	struct stat stat_buf;
@@ -45,7 +45,7 @@ int f2fs_trim_device(int fd)
 	}
 
 	range[0] = 0;
-	range[1] = stat_buf.st_size;
+	range[1] = bytes;
 
 #if defined(WITH_BLKDISCARD) && defined(BLKDISCARD)
 	MSG(0, "Info: Discarding device\n");
@@ -70,8 +70,7 @@ int f2fs_trim_device(int fd)
 		if (ioctl(fd, BLKDISCARD, &range) < 0) {
 			MSG(0, "Info: This device doesn't support BLKDISCARD\n");
 		} else {
-			MSG(0, "Info: Discarded %lu MB\n",
-						stat_buf.st_size >> 20);
+			MSG(0, "Info: Discarded %llu MB\n", range[1] >> 20);
 		}
 	} else
 		return -1;
diff --git a/mkfs/f2fs_format_utils.h b/mkfs/f2fs_format_utils.h
index bc91aa3..ed28c58 100644
--- a/mkfs/f2fs_format_utils.h
+++ b/mkfs/f2fs_format_utils.h
@@ -12,5 +12,5 @@
 
 extern struct f2fs_configuration c;
 
-int f2fs_trim_device(int);
+int f2fs_trim_device(int, u_int64_t);
 int f2fs_format_device(void);
-- 
2.8.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
