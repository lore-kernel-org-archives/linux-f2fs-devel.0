From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] mkfs.f2fs: support large sector size
Date: Wed, 04 Feb 2015 11:30:10 +0800
Message-ID: <000501d0402b$05d34e50$1179eaf0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

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

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 lib/libf2fs.c            | 10 +++-------
 mkfs/f2fs_format.c       | 12 ++++++------
 mkfs/f2fs_format_utils.c |  2 +-
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 8123528..d2942f0 100644
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
@@ -495,8 +491,8 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
 		return -1;
 	}
 	if (wanted_total_sectors && wanted_total_sectors < c->total_sectors) {
-		MSG(0, "Info: total device sectors = %"PRIu64" (in 512bytes)\n",
-					c->total_sectors);
+		MSG(0, "Info: total device sectors = %"PRIu64" (in %u bytes)\n",
+					c->total_sectors, c->sector_size);
 		c->total_sectors = wanted_total_sectors;
 
 	}
@@ -504,7 +500,7 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
 	MSG(0, "Info: total sectors = %"PRIu64" (in 512bytes)\n",
 					c->total_sectors);
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
