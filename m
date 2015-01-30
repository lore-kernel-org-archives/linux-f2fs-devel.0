From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] mkfs.f2fs: support large sector size
Date: Fri, 30 Jan 2015 15:49:02 +0800
Message-ID: <006f01d03c61$5b4be860$11e3b920$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YH6LH-0007J1-37
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Jan 2015 07:50:15 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1YH6LE-0005JY-Pf
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Jan 2015 07:50:14 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NIZ004QWCFHP700@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Jan 2015 16:50:05 +0900 (KST)
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

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 lib/libf2fs.c            | 2 +-
 mkfs/f2fs_format.c       | 6 +++---
 mkfs/f2fs_format_utils.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 8123528..9b9578b 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -504,7 +504,7 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
 	MSG(0, "Info: total sectors = %"PRIu64" (in 512bytes)\n",
 					c->total_sectors);
 	if (c->total_sectors <
-			(F2FS_MIN_VOLUME_SIZE / DEFAULT_SECTOR_SIZE)) {
+			(F2FS_MIN_VOLUME_SIZE / c->sector_size)) {
 		MSG(0, "Error: Min volume size supported is %d\n",
 				F2FS_MIN_VOLUME_SIZE);
 		return -1;
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index a8d2db6..861fe2f 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -198,10 +198,10 @@ static int f2fs_prepare_super_block(void)
 	set_sb(block_count, config.total_sectors >> log_sectors_per_block);
 
 	zone_align_start_offset =
-		(config.start_sector * DEFAULT_SECTOR_SIZE +
+		(config.start_sector * config.sector_size +
 		2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
 		zone_size_bytes * zone_size_bytes -
-		config.start_sector * DEFAULT_SECTOR_SIZE;
+		config.start_sector * config.sector_size;
 
 	if (config.start_sector % DEFAULT_SECTORS_PER_BLOCK) {
 		MSG(1, "\tWARN: Align start sector number to the page unit\n");
@@ -211,7 +211,7 @@ static int f2fs_prepare_super_block(void)
 				DEFAULT_SECTORS_PER_BLOCK);
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
