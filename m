From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] fsck.f2fs: support large sector size
Date: Wed, 04 Feb 2015 11:32:41 +0800
Message-ID: <000601d0402b$739e25e0$5ada71a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YIqjR-0003OD-TB
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 04 Feb 2015 03:34:25 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1YIqjQ-0004s0-0y
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 04 Feb 2015 03:34:25 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NJ800CVM9X4WQ20@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 04 Feb 2015 12:34:16 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Since f2fs support large sector size in commit 55cf9cb63f0e "f2fs: support large
sector size", block device with sector size of 512/1024/2048/4096 bytes can be
supported.

But fsck.f2fs still use default F2FS_LOG_SECTOR_SIZE/F2FS_LOG_SECTORS_PER_BLOCK to
verify related data in f2fs image, it's wrong, let's fix this issue in this patch.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fsck/mount.c      | 9 ++++++---
 include/f2fs_fs.h | 4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 73eba6b..6d96db8 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -221,12 +221,15 @@ int sanity_check_raw_super(struct f2fs_super_block *raw_super)
 		return -1;
 	}
 
-	if (F2FS_LOG_SECTOR_SIZE != le32_to_cpu(raw_super->log_sectorsize)) {
+	if (le32_to_cpu(raw_super->log_sectorsize) > F2FS_MAX_LOG_SECTOR_SIZE ||
+		le32_to_cpu(raw_super->log_sectorsize) <
+						F2FS_MIN_LOG_SECTOR_SIZE) {
 		return -1;
 	}
 
-	if (F2FS_LOG_SECTORS_PER_BLOCK !=
-				le32_to_cpu(raw_super->log_sectors_per_block)) {
+	if (le32_to_cpu(raw_super->log_sectors_per_block) +
+				le32_to_cpu(raw_super->log_sectorsize) !=
+						F2FS_MAX_LOG_SECTOR_SIZE) {
 		return -1;
 	}
 
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 4dc2426..99c21eb 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -289,8 +289,8 @@ enum {
  * Copied from include/linux/f2fs_sb.h
  */
 #define F2FS_SUPER_OFFSET		1024	/* byte-size offset */
-#define F2FS_LOG_SECTOR_SIZE		9	/* 9 bits for 512 byte */
-#define F2FS_LOG_SECTORS_PER_BLOCK	3	/* 4KB: F2FS_BLKSIZE */
+#define F2FS_MIN_LOG_SECTOR_SIZE	9	/* 9 bits for 512 bytes */
+#define F2FS_MAX_LOG_SECTOR_SIZE	12	/* 12 bits for 4096 bytes */
 #define F2FS_BLKSIZE			4096	/* support only 4KB block */
 #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
 #define F2FS_BLK_ALIGN(x)	(((x) + F2FS_BLKSIZE - 1) / F2FS_BLKSIZE)
-- 
2.2.1



------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
