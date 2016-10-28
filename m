From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2 7/9] f2fs: Cache zoned block devices zone type
Date: Fri, 28 Oct 2016 17:45:05 +0900
Message-ID: <1477644307-30115-8-git-send-email-damien.lemoal@wdc.com>
References: <1477644307-30115-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Damien.LeMoal@wdc.com>) id 1c02oG-0007kp-5R
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:46:44 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c02oF-0005S5-63
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

With the zoned block device feature enabled, section discard
need to do a zone reset for sections contained in sequential
zones, and a regular discard (if supported) for sections
stored in conventional zones. Avoid the need for a costly
report zones to obtain a section zone type when discarding it
by caching the types of the device zones in the super block
information. This cache is initialized at mount time for mounts
with the zoned block device feature enabled.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/f2fs.h  | 18 +++++++++++++++
 fs/f2fs/super.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index beb2093..a1a074d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -750,6 +750,14 @@ struct f2fs_sb_info {
 	u8 key_prefix[F2FS_KEY_DESC_PREFIX_SIZE];
 	u8 key_prefix_size;
 #endif
+
+#ifdef CONFIG_BLK_DEV_ZONED
+	unsigned int nr_blkz;			/* Total number of zones */
+	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
+	unsigned int log_blocks_per_blkz;	/* log2 F2FS blocks per zone */
+	u8 *blkz_type;				/* Array of zones type */
+#endif
+
 	/* for node-related operations */
 	struct f2fs_nm_info *nm_info;		/* node manager */
 	struct inode *node_inode;		/* cache node blocks */
@@ -2410,6 +2418,16 @@ static inline int f2fs_sb_mounted_blkzoned(struct super_block *sb)
 	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_BLKZONED);
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
+static inline int get_blkz_type(struct f2fs_sb_info *sbi,
+				block_t blkaddr)
+{
+	unsigned int zno = blkaddr >> sbi->log_blocks_per_blkz;
+
+	return sbi->blkz_type[zno];
+}
+#endif
+
 static inline bool f2fs_discard_en(struct f2fs_sb_info *sbi)
 {
 	struct request_queue *q = bdev_get_queue(sbi->sb->s_bdev);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 58fd69d..2b7880d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1515,6 +1515,65 @@ static int init_percpu_info(struct f2fs_sb_info *sbi)
 								GFP_KERNEL);
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
+static int init_blkz_info(struct f2fs_sb_info *sbi)
+{
+	struct block_device *bdev = sbi->sb->s_bdev;
+	sector_t nr_sectors = bdev->bd_part->nr_sects;
+	sector_t sector = 0;
+	struct blk_zone *zones;
+	unsigned int i, nr_zones;
+	unsigned int n = 0;
+	int err = -EIO;
+
+	if (!f2fs_sb_mounted_blkzoned(sbi->sb))
+		return 0;
+
+	sbi->blocks_per_blkz = SECTOR_TO_BLOCK(bdev_zone_size(bdev));
+	sbi->log_blocks_per_blkz = __ilog2_u32(sbi->blocks_per_blkz);
+	sbi->nr_blkz = SECTOR_TO_BLOCK(nr_sectors) >>
+		sbi->log_blocks_per_blkz;
+	if (nr_sectors & (bdev_zone_size(bdev) - 1))
+		sbi->nr_blkz++;
+
+	sbi->blkz_type = kmalloc(sbi->nr_blkz, GFP_KERNEL);
+	if (!sbi->blkz_type)
+		return -ENOMEM;
+
+#define F2FS_REPORT_NR_ZONES   4096
+
+	zones = kcalloc(F2FS_REPORT_NR_ZONES, sizeof(struct blk_zone),
+			GFP_KERNEL);
+	if (!zones)
+		return -ENOMEM;
+
+	/* Get block zones type */
+	while (zones && sector < nr_sectors) {
+
+		nr_zones = F2FS_REPORT_NR_ZONES;
+		err = blkdev_report_zones(bdev, sector,
+					  zones, &nr_zones,
+					  GFP_KERNEL);
+		if (err)
+			break;
+		if (!nr_zones) {
+			err = -EIO;
+			break;
+		}
+
+		for (i = 0; i < nr_zones; i++) {
+			sbi->blkz_type[n] = zones[i].type;
+			sector += zones[i].len;
+			n++;
+		}
+	}
+
+	kfree(zones);
+
+	return err;
+}
+#endif
+
 /*
  * Read f2fs raw super block.
  * Because we have two copies of super block, so read both of them
@@ -1761,6 +1820,15 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	init_ino_entry_info(sbi);
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	err = init_blkz_info(sbi);
+	if (err) {
+		f2fs_msg(sb, KERN_ERR,
+			"Failed to initialize F2FS blkzone information");
+		goto free_blkz;
+	}
+#endif
+
 	/* setup f2fs internal modules */
 	err = build_segment_manager(sbi);
 	if (err) {
@@ -1932,6 +2000,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	destroy_node_manager(sbi);
 free_sm:
 	destroy_segment_manager(sbi);
+#ifdef CONFIG_BLK_DEV_ZONED
+free_blkz:
+	kfree(sbi->blkz_type);
+#endif
 	kfree(sbi->ckpt);
 free_meta_inode:
 	make_bad_inode(sbi->meta_inode);
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
