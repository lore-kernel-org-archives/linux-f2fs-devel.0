From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] f2fs: check discard alignment only for
	SEQWRITE zones
Date: Wed, 22 Feb 2017 20:28:50 -0800
Message-ID: <20170223042850.43456-4-jaegeuk@kernel.org>
References: <20170223042850.43456-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cgl1c-0000gg-Tg
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 04:29:04 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cgl1c-0003fr-4h
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 04:29:04 +0000
In-Reply-To: <20170223042850.43456-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

For converntional zones, we don't need to align discard commands to exact zone
size.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d76e49c3d1b4..6fff1c58b3b1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -793,24 +793,13 @@ static int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi,
 static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 		struct block_device *bdev, block_t blkstart, block_t blklen)
 {
-	sector_t nr_sects = SECTOR_FROM_BLOCK(blklen);
-	sector_t sector;
+	sector_t sector, nr_sects;
 	int devi = 0;
 
 	if (sbi->s_ndevs) {
 		devi = f2fs_target_device_index(sbi, blkstart);
 		blkstart -= FDEV(devi).start_blk;
 	}
-	sector = SECTOR_FROM_BLOCK(blkstart);
-
-	if (sector & (bdev_zone_sectors(bdev) - 1) ||
-	    nr_sects != bdev_zone_sectors(bdev)) {
-		f2fs_msg(sbi->sb, KERN_INFO,
-			"(%d) %s: Unaligned discard attempted (block %x + %x)",
-			devi, sbi->s_ndevs ? FDEV(devi).path: "",
-			blkstart, blklen);
-		return -EIO;
-	}
 
 	/*
 	 * We need to know the type of the zone: for conventional zones,
@@ -825,6 +814,17 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 		return __f2fs_issue_discard_async(sbi, bdev, blkstart, blklen);
 	case BLK_ZONE_TYPE_SEQWRITE_REQ:
 	case BLK_ZONE_TYPE_SEQWRITE_PREF:
+		sector = SECTOR_FROM_BLOCK(blkstart);
+		nr_sects = SECTOR_FROM_BLOCK(blklen);
+
+		if (sector & (bdev_zone_sectors(bdev) - 1) ||
+				nr_sects != bdev_zone_sectors(bdev)) {
+			f2fs_msg(sbi->sb, KERN_INFO,
+				"(%d) %s: Unaligned discard attempted (block %x + %x)",
+				devi, sbi->s_ndevs ? FDEV(devi).path: "",
+				blkstart, blklen);
+			return -EIO;
+		}
 		trace_f2fs_issue_reset_zone(bdev, blkstart);
 		return blkdev_reset_zones(bdev, sector,
 					  nr_sects, GFP_NOFS);
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
