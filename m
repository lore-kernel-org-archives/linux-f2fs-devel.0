From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH] f2fs: Reduce zoned block device memory usage
Date: Tue, 20 Feb 2018 15:06:10 +0900
Message-ID: <20180220060610.12588-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from siteops-lb-1.v20.lw.sourceforge.com ([172.30.20.11]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <prvs=582868023=damien.lemoal@wdc.com>)
 id 1eo149-0004wO-8c
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Feb 2018 06:06:13 +0000
Received: from [172.30.20.11] (helo=esa3.hgst.iphmx.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps (TLSv1.2:RC4-SHA:128)
 (Exim 4.89) id 1eo147-0003Q3-UK
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Feb 2018 06:06:12 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org

For a zoned block device mount, an array of zone types for the device is
allocated and initialized in order to determine if a section is stored
on a sequential zone (zone reset needed) or a conventional zone (no zone
reset needed and regular discard applies). Considering this usage, the
zone types stored in memory can be replaced with a bitmap to indicate
equivalent information, that is, if a zone is sequential or not. This
reduces the memory usage for the device mount by roughly 8 (on a 14TB
disk with zones of 256 MB, the zone type array consumes 13x4KB pages
while the bitmap uses only 2x4KB pages.

This patch changes the f2fs_dev_info structure blkz_type field to the
bitmap blkz_seq. Access to this bitmap is done using the function
f2fs_blkz_is_seq(), which is a rewrite of the function get_blkz_type().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/f2fs.h    | 13 +++++++------
 fs/f2fs/segment.c | 23 +++++++----------------
 fs/f2fs/super.c   | 13 ++++++++-----
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6300ac5bcbe4..c5700f63ebe7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1000,8 +1000,8 @@ struct f2fs_dev_info {
 	block_t start_blk;
 	block_t end_blk;
 #ifdef CONFIG_BLK_DEV_ZONED
-	unsigned int nr_blkz;			/* Total number of zones */
-	u8 *blkz_type;				/* Array of zones type */
+	unsigned int nr_blkz;		/* Total number of zones */
+	unsigned long *blkz_seq;	/* Bitmap indicating sequential zones */
 #endif
 };
 
@@ -3213,16 +3213,17 @@ static inline int f2fs_sb_has_inode_crtime(struct super_block *sb)
 }
 
 #ifdef CONFIG_BLK_DEV_ZONED
-static inline int get_blkz_type(struct f2fs_sb_info *sbi,
-			struct block_device *bdev, block_t blkaddr)
+static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi,
+				    struct block_device *bdev, block_t blkaddr)
 {
 	unsigned int zno = blkaddr >> sbi->log_blocks_per_blkz;
 	int i;
 
 	for (i = 0; i < sbi->s_ndevs; i++)
 		if (FDEV(i).bdev == bdev)
-			return FDEV(i).blkz_type[zno];
-	return -EINVAL;
+			return test_bit(zno, FDEV(i).blkz_seq);
+	WARN_ON_ONCE(1);
+	return false;
 }
 #endif
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b16a8e6625aa..1abf951abeb1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1447,19 +1447,8 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 		blkstart -= FDEV(devi).start_blk;
 	}
 
-	/*
-	 * We need to know the type of the zone: for conventional zones,
-	 * use regular discard if the drive supports it. For sequential
-	 * zones, reset the zone write pointer.
-	 */
-	switch (get_blkz_type(sbi, bdev, blkstart)) {
-
-	case BLK_ZONE_TYPE_CONVENTIONAL:
-		if (!blk_queue_discard(bdev_get_queue(bdev)))
-			return 0;
-		return __queue_discard_cmd(sbi, bdev, lblkstart, blklen);
-	case BLK_ZONE_TYPE_SEQWRITE_REQ:
-	case BLK_ZONE_TYPE_SEQWRITE_PREF:
+	/* For sequential zones, reset the zone write pointer */
+	if (f2fs_blkz_is_seq(sbi, bdev, blkstart)) {
 		sector = SECTOR_FROM_BLOCK(blkstart);
 		nr_sects = SECTOR_FROM_BLOCK(blklen);
 
@@ -1474,10 +1463,12 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 		trace_f2fs_issue_reset_zone(bdev, blkstart);
 		return blkdev_reset_zones(bdev, sector,
 					  nr_sects, GFP_NOFS);
-	default:
-		/* Unknown zone type: broken device ? */
-		return -EIO;
 	}
+
+	 /* For conventional zones, use regular discard if supported */
+	if (!blk_queue_discard(bdev_get_queue(bdev)))
+		return 0;
+	return __queue_discard_cmd(sbi, bdev, lblkstart, blklen);
 }
 #endif
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8173ae688814..205be76d6e53 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -881,7 +881,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 	for (i = 0; i < sbi->s_ndevs; i++) {
 		blkdev_put(FDEV(i).bdev, FMODE_EXCL);
 #ifdef CONFIG_BLK_DEV_ZONED
-		kfree(FDEV(i).blkz_type);
+		kfree(FDEV(i).blkz_seq);
 #endif
 	}
 	kfree(sbi->devs);
@@ -2222,9 +2222,11 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))
 		FDEV(devi).nr_blkz++;
 
-	FDEV(devi).blkz_type = f2fs_kmalloc(sbi, FDEV(devi).nr_blkz,
-								GFP_KERNEL);
-	if (!FDEV(devi).blkz_type)
+	FDEV(devi).blkz_seq = f2fs_kzalloc(sbi,
+					BITS_TO_LONGS(FDEV(devi).nr_blkz)
+					* sizeof(unsigned long),
+					GFP_KERNEL);
+	if (!FDEV(devi).blkz_seq)
 		return -ENOMEM;
 
 #define F2FS_REPORT_NR_ZONES   4096
@@ -2249,7 +2251,8 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 		}
 
 		for (i = 0; i < nr_zones; i++) {
-			FDEV(devi).blkz_type[n] = zones[i].type;
+			if (zones[i].type != BLK_ZONE_TYPE_CONVENTIONAL)
+				set_bit(n, FDEV(devi).blkz_seq);
 			sector += zones[i].len;
 			n++;
 		}
-- 
2.14.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
