From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] f2fs: fix the fault of calculating blkstart twice
Date: Sat, 4 Mar 2017 09:12:46 +0800
Message-ID: <9f3a4202-11cb-5861-838c-ebbc94b71554@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cjyFt-00026I-SF
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Mar 2017 01:13:05 +0000
Received: from mail-it0-f67.google.com ([209.85.214.67])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cjyFs-0007cR-VY
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Mar 2017 01:13:05 +0000
Received: by mail-it0-f67.google.com with SMTP id 68so4105800itg.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 03 Mar 2017 17:13:04 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

When the zone type is BLK_ZONE_TYPE_CONVENTIONAL, the blkstart is 
calculated twice.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/segment.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4bd7a8b..ed181d1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -772,11 +772,6 @@ static int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi,
 
 	trace_f2fs_issue_discard(bdev, blkstart, blklen);
 
-	if (sbi->s_ndevs) {
-		int devi = f2fs_target_device_index(sbi, blkstart);
-
-		blkstart -= FDEV(devi).start_blk;
-	}
 	err = __blkdev_issue_discard(bdev,
 				SECTOR_FROM_BLOCK(blkstart),
 				SECTOR_FROM_BLOCK(blklen),
@@ -796,12 +791,6 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 		struct block_device *bdev, block_t blkstart, block_t blklen)
 {
 	sector_t sector, nr_sects;
-	int devi = 0;
-
-	if (sbi->s_ndevs) {
-		devi = f2fs_target_device_index(sbi, blkstart);
-		blkstart -= FDEV(devi).start_blk;
-	}
 
 	/*
 	 * We need to know the type of the zone: for conventional zones,
@@ -822,8 +811,8 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 		if (sector & (bdev_zone_sectors(bdev) - 1) ||
 				nr_sects != bdev_zone_sectors(bdev)) {
 			f2fs_msg(sbi->sb, KERN_INFO,
-				"(%d) %s: Unaligned discard attempted (block %x + %x)",
-				devi, sbi->s_ndevs ? FDEV(devi).path: "",
+				"Dev(%u:%u): Unaligned discard attempted (block %x + %x)",
+				MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev),
 				blkstart, blklen);
 			return -EIO;
 		}
@@ -840,6 +829,13 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 static int __issue_discard_async(struct f2fs_sb_info *sbi,
 		struct block_device *bdev, block_t blkstart, block_t blklen)
 {
+	int devi = 0;
+
+	if (sbi->s_ndevs) {
+		devi = f2fs_target_device_index(sbi, blkstart);
+		blkstart -= FDEV(devi).start_blk;
+	}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 	if (f2fs_sb_mounted_blkzoned(sbi->sb) &&
 				bdev_zoned_model(bdev) != BLK_ZONED_NONE)
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
