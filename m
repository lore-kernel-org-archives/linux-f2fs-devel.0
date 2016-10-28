From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2 8/9] f2fs: Reset sequential zones on zoned
	block devices
Date: Fri, 28 Oct 2016 17:45:06 +0900
Message-ID: <1477644307-30115-9-git-send-email-damien.lemoal@wdc.com>
References: <1477644307-30115-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Damien.LeMoal@wdc.com>) id 1c02oG-0004aR-Vk
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:46:44 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c02oF-0003iL-T5
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:46:44 +0000
In-Reply-To: <1477644307-30115-1-git-send-email-damien.lemoal@wdc.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: Le Moal <damien.lemoal@wdc.com>, Damien, linux-f2fs-devel@lists.sourceforge.net, Shaun Tancheff <shaun@tancheff.com>, Hannes Reinecke <hare@suse.de>, linux-fsdevel@vger.kernel.org

When a zoned block device is mounted, discarding sections
contained in sequential zones must reset the zone write pointer.
For sections contained in conventional zones, the regular discard
is used if the drive supports it.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/segment.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fc886f0..ee66e08 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -16,6 +16,7 @@
 #include <linux/kthread.h>
 #include <linux/swap.h>
 #include <linux/timer.h>
+#include <linux/timer.h>
 
 #include "f2fs.h"
 #include "segment.h"
@@ -633,15 +634,19 @@ static void f2fs_submit_bio_wait_endio(struct bio *bio)
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
 
@@ -654,11 +659,50 @@ int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi, sector_t sector,
 	return err;
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
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
+#endif
+
 static int f2fs_issue_discard(struct f2fs_sb_info *sbi,
 				block_t blkstart, block_t blklen)
 {
-	sector_t start = SECTOR_FROM_BLOCK(blkstart);
-	sector_t len = SECTOR_FROM_BLOCK(blklen);
 	struct seg_entry *se;
 	unsigned int offset;
 	block_t i;
@@ -670,8 +714,13 @@ static int f2fs_issue_discard(struct f2fs_sb_info *sbi,
 		if (!f2fs_test_and_set_bit(offset, se->discard_map))
 			sbi->discard_blks--;
 	}
-	trace_f2fs_issue_discard(sbi->sb, blkstart, blklen);
-	return __f2fs_issue_discard_async(sbi, start, len, GFP_NOFS, 0);
+
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (f2fs_sb_mounted_blkzoned(sbi->sb))
+		return f2fs_issue_discard_zone(sbi, blkstart, blklen);
+#endif
+
+	return __f2fs_issue_discard_async(sbi, blkstart, blklen);
 }
 
 static void __add_discard_entry(struct f2fs_sb_info *sbi,
-- 
2.7.4

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.


------------------------------------------------------------------------------
The Command Line: Reinvented for Modern Developers
Did the resurgence of CLI tooling catch you by surprise?
Reconnect with the command line and become more productive. 
Learn the new .NET and ASP.NET CLI. Get your free copy!
http://sdm.link/telerik
