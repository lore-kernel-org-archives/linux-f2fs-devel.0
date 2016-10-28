From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 8/9] f2fs: Reset sequential zones on zoned block devices
Date: Fri, 28 Oct 2016 16:55:36 +0900
Message-ID: <1477641337-12321-9-git-send-email-damien.lemoal@wdc.com>
References: <1477641337-12321-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1477641337-12321-1-git-send-email-damien.lemoal@wdc.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>, Damien Le Moal <damien.lemoal@wdc.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

When a zoned block device is mounted, discarding sections
contained in sequential zones must reset the zone write pointer.
For sections contained in conventional zones, the regular discard
is used if the drive supports it.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/segment.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fc886f0..bce79e2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -633,15 +633,19 @@ static void f2fs_submit_bio_wait_endio(struct bio *bio)
 }
 
 /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
-int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi, sector_t sector,
-		sector_t nr_sects, gfp_t gfp_mask, unsigned long flags)
+static int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi,
+					block_t blkstart, block_t blklen)
 {
 	struct block_device *bdev = sbi->sb->s_bdev;
 	struct bio *bio = NULL;
 	int err;
 
-	err = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, flags,
-			&bio);
+	trace_f2fs_issue_discard(sbi->sb, blkstart, blklen);
+
+	err = __blkdev_issue_discard(bdev,
+				     SECTOR_FROM_BLOCK(blkstart),
+				     SECTOR_FROM_BLOCK(blklen),
+				     GFP_NOFS, 0, &bio);
 	if (!err && bio) {
 		struct bio_entry *be = __add_bio_entry(sbi, bio);
 
@@ -654,11 +658,48 @@ int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi, sector_t sector,
 	return err;
 }
 
+static int f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
+					block_t blkstart, block_t blklen)
+{
+	sector_t sector = SECTOR_FROM_BLOCK(blkstart);
+	sector_t nr_sects = SECTOR_FROM_BLOCK(blklen);
+	struct block_device *bdev = sbi->sb->s_bdev;
+
+	if (nr_sects != bdev_zone_size(bdev)) {
+		f2fs_msg(sbi->sb, KERN_INFO,
+			 "Unaligned discard attempted (sector %llu + %llu)",
+			 (unsigned long long)sector,
+			 (unsigned long long)nr_sects);
+		return -EIO;
+	}
+
+	/*
+	 * We need to know the type of the zone: for conventional zones,
+	 * use regular discard if the drive supports it. For sequential
+	 * zones, reset the zone write pointer.
+	 */
+	switch (get_blkz_type(sbi, blkstart)) {
+
+	case BLK_ZONE_TYPE_CONVENTIONAL:
+		if (!blk_queue_discard(bdev_get_queue(bdev)))
+			return 0;
+		return __f2fs_issue_discard_async(sbi, blkstart,
+						  blklen);
+
+	case BLK_ZONE_TYPE_SEQWRITE_REQ:
+	case BLK_ZONE_TYPE_SEQWRITE_PREF:
+		return blkdev_reset_zones(bdev, sector,
+					  nr_sects, GFP_NOFS);
+
+	default:
+		/* Unknown zone type: broken device ? */
+		return -EIO;
+	}
+}
+
 static int f2fs_issue_discard(struct f2fs_sb_info *sbi,
 				block_t blkstart, block_t blklen)
 {
-	sector_t start = SECTOR_FROM_BLOCK(blkstart);
-	sector_t len = SECTOR_FROM_BLOCK(blklen);
 	struct seg_entry *se;
 	unsigned int offset;
 	block_t i;
@@ -670,8 +711,11 @@ static int f2fs_issue_discard(struct f2fs_sb_info *sbi,
 		if (!f2fs_test_and_set_bit(offset, se->discard_map))
 			sbi->discard_blks--;
 	}
-	trace_f2fs_issue_discard(sbi->sb, blkstart, blklen);
-	return __f2fs_issue_discard_async(sbi, start, len, GFP_NOFS, 0);
+
+	if (f2fs_sb_mounted_blkzoned(sbi->sb))
+		return f2fs_issue_discard_zone(sbi, blkstart, blklen);
+
+	return __f2fs_issue_discard_async(sbi, blkstart, blklen);
 }
 
 static void __add_discard_entry(struct f2fs_sb_info *sbi,
-- 
2.7.4

