From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH RESEND 1/2] mkfs.f2fs: support large sector size
Date: Thu, 05 Feb 2015 17:36:39 +0800
Message-ID: <006201d04127$6f254d70$4d6fe850$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YJIt6-0004Hi-Op
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Feb 2015 09:38:16 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1YJIt4-00014O-UT
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Feb 2015 09:38:16 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NJA0049ILFJ5A60@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Feb 2015 18:38:07 +0900 (KST)
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

But mkfs.f2fs still use default sector size: 512 bytes as sector size, let's fix
this issue in this patch.

v2:
 o remove unneeded printed message when sector size is large than 512 bytes
   suggested by Kinglong.
 o show correct sector size in printed message.
 o use config.sectors_per_blk instead of DEFAULT_SECTORS_PER_BLOCK suggested by
   Kinglong.
v3:
 o remove another unneeded printed message when sector size is large than 512
   bytes suggested by Kinglong.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 lib/libf2fs.c            | 14 +++++---------
 mkfs/f2fs_format.c       | 12 ++++++------
 mkfs/f2fs_format_utils.c |  2 +-
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 8123528..9e19e9b 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -463,10 +463,6 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
 			MSG(0, "\tError: Using the default sector size\n");
 		} else {
 			if (c->sector_size < sector_size) {
-				MSG(0, "\tError: Cannot set the sector size to:"
-					" %d as the device does not support"
-					"\nSetting the sector size to : %d\n",
-					c->sector_size, sector_size);
 				c->sector_size = sector_size;
 				c->sectors_per_blk = PAGE_SIZE / sector_size;
 			}
@@ -495,16 +491,16 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
 		return -1;
 	}
 	if (wanted_total_sectors && wanted_total_sectors < c->total_sectors) {
-		MSG(0, "Info: total device sectors = %"PRIu64" (in 512bytes)\n",
-					c->total_sectors);
+		MSG(0, "Info: total device sectors = %"PRIu64" (in %u bytes)\n",
+					c->total_sectors, c->sector_size);
 		c->total_sectors = wanted_total_sectors;
 
 	}
 	MSG(0, "Info: sector size = %u\n", c->sector_size);
-	MSG(0, "Info: total sectors = %"PRIu64" (in 512bytes)\n",
-					c->total_sectors);
+	MSG(0, "Info: total sectors = %"PRIu64" (in %u bytes)\n",
+					c->total_sectors, c->sector_size);
 	if (c->total_sectors <
-			(F2FS_MIN_VOLUME_SIZE / DEFAULT_SECTOR_SIZE)) {
+			(F2FS_MIN_VOLUME_SIZE / c->sector_size)) {
 		MSG(0, "Error: Min volume size supported is %d\n",
 				F2FS_MIN_VOLUME_SIZE);
 		return -1;
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index a8d2db6..2cce7c3 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -198,20 +198,20 @@ static int f2fs_prepare_super_block(void)
 	set_sb(block_count, config.total_sectors >> log_sectors_per_block);
 
 	zone_align_start_offset =
-		(config.start_sector * DEFAULT_SECTOR_SIZE +
+		(config.start_sector * config.sector_size +
 		2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
 		zone_size_bytes * zone_size_bytes -
-		config.start_sector * DEFAULT_SECTOR_SIZE;
+		config.start_sector * config.sector_size;
 
-	if (config.start_sector % DEFAULT_SECTORS_PER_BLOCK) {
+	if (config.start_sector % config.sectors_per_blk) {
 		MSG(1, "\tWARN: Align start sector number to the page unit\n");
 		MSG(1, "\ti.e., start sector: %d, ofs:%d (sects/page: %d)\n",
 				config.start_sector,
-				config.start_sector % DEFAULT_SECTORS_PER_BLOCK,
-				DEFAULT_SECTORS_PER_BLOCK);
+				config.start_sector % config.sectors_per_blk,
+				config.sectors_per_blk);
 	}
 
-	set_sb(segment_count, (config.total_sectors * DEFAULT_SECTOR_SIZE -
+	set_sb(segment_count, (config.total_sectors * config.sector_size -
 				zone_align_start_offset) / segment_size_bytes);
 
 	set_sb(segment0_blkaddr, zone_align_start_offset / blk_size_bytes);
diff --git a/mkfs/f2fs_format_utils.c b/mkfs/f2fs_format_utils.c
index 88b9953..a0f85f5 100644
--- a/mkfs/f2fs_format_utils.c
+++ b/mkfs/f2fs_format_utils.c
@@ -36,7 +36,7 @@ int f2fs_trim_device()
 		return 0;
 
 	range[0] = 0;
-	range[1] = config.total_sectors * DEFAULT_SECTOR_SIZE;
+	range[1] = config.total_sectors * config.sector_size;
 
 	if (fstat(config.fd, &stat_buf) < 0 ) {
 		MSG(1, "\tError: Failed to get the device stat!!!\n");
-- 
2.2.1



------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
