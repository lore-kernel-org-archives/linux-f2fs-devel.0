From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 7/9] f2fs: Cache zoned block devices zone type
Date: Fri, 28 Oct 2016 16:55:35 +0900
Message-ID: <1477641337-12321-8-git-send-email-damien.lemoal@wdc.com>
References: <1477641337-12321-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1477641337-12321-1-git-send-email-damien.lemoal@wdc.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>, Damien Le Moal <damien.lemoal@wdc.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

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
 fs/f2fs/f2fs.h  | 16 +++++++++++++
 fs/f2fs/super.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index beb2093..1600f4b 100644
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
@@ -2410,6 +2418,14 @@ static inline int f2fs_sb_mounted_blkzoned(struct super_block *sb)
 	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_BLKZONED);
 }
 
+static inline int get_blkz_type(struct f2fs_sb_info *sbi,
+				block_t blkaddr)
+{
+	unsigned int zno = blkaddr >> sbi->log_blocks_per_blkz;
+
+	return sbi->blkz_type[zno];
+}
+
 static inline bool f2fs_discard_en(struct f2fs_sb_info *sbi)
 {
 	struct request_queue *q = bdev_get_queue(sbi->sb->s_bdev);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 58fd69d..dacaa1b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1515,6 +1515,66 @@ static int init_percpu_info(struct f2fs_sb_info *sbi)
 								GFP_KERNEL);
 }
 
+static int init_blkz_info(struct f2fs_sb_info *sbi)
+{
+#ifdef CONFIG_BLK_DEV_ZONED
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
+#endif
+	return 0;
+}
+
 /*
  * Read f2fs raw super block.
  * Because we have two copies of super block, so read both of them
@@ -1761,6 +1821,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	init_ino_entry_info(sbi);
 
+	err = init_blkz_info(sbi);
+	if (err) {
+		f2fs_msg(sb, KERN_ERR,
+			"Failed to initialize F2FS blkzone information");
+		goto free_blkz;
+	}
+
 	/* setup f2fs internal modules */
 	err = build_segment_manager(sbi);
 	if (err) {
@@ -1932,6 +1999,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	destroy_node_manager(sbi);
 free_sm:
 	destroy_segment_manager(sbi);
+free_blkz:
+	kfree(sbi->blkz_type);
 	kfree(sbi->ckpt);
 free_meta_inode:
 	make_bad_inode(sbi->meta_inode);
-- 
2.7.4

