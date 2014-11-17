From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] mkfs.f2fs: introduce some macros to simplify
	coding style
Date: Mon, 17 Nov 2014 14:03:41 +0900
Message-ID: <1416200621-27989-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1XqEV3-0007ls-VV
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Nov 2014 05:05:18 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XqEUz-00027b-Un
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Nov 2014 05:05:17 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0NF600GPL3GIID70@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Nov 2014 14:05:06 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

This patch tries to simplify coding style for readability.
Rename shortly
 o rename super_block to sb

And, introduce some macros.
 o set/get_cp
 o set/get_sb
 o next/prev_zone, last_zone and last_section
 o ALIGN, SEG_ALIGN and ZONE_ALIGN

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 include/f2fs_fs.h       |   6 +
 lib/libf2fs.c           |   1 +
 mkfs/f2fs_format.c      | 548 +++++++++++++++++++++++-------------------------
 mkfs/f2fs_format_main.c |   1 +
 4 files changed, 272 insertions(+), 284 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index efddfca..0c3ba04 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -230,6 +230,7 @@ struct f2fs_configuration {
 	u_int32_t cur_seg[6];
 	u_int32_t segs_per_sec;
 	u_int32_t secs_per_zone;
+	u_int32_t segs_per_zone;
 	u_int32_t start_sector;
 	u_int64_t total_sectors;
 	u_int32_t sectors_per_blk;
@@ -786,4 +787,9 @@ f2fs_hash_t f2fs_dentry_hash(const unsigned char *, int);
 
 extern struct f2fs_configuration config;
 
+#define ALIGN(val, size)	((val) + (size) - 1) / (size)
+#define SEG_ALIGN(blks)		ALIGN(blks, config.blks_per_seg)
+#define ZONE_ALIGN(blks)	ALIGN(blks, config.blks_per_seg * \
+					config.segs_per_zone)
+
 #endif	/*__F2FS_FS_H */
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 14e4164..8123528 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -357,6 +357,7 @@ void f2fs_init_configuration(struct f2fs_configuration *c)
 	c->overprovision = 5;
 	c->segs_per_sec = 1;
 	c->secs_per_zone = 1;
+	c->segs_per_zone = 1;
 	c->heap = 1;
 	c->vol_label = "";
 	c->device_name = NULL;
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index c0028a3..a8d2db6 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -22,7 +22,71 @@
 #include "f2fs_format_utils.h"
 
 extern struct f2fs_configuration config;
-struct f2fs_super_block super_block;
+struct f2fs_super_block sb;
+struct f2fs_checkpoint *cp;
+
+/* Return first segment number of each area */
+#define prev_zone(cur)		(config.cur_seg[cur] - config.segs_per_zone)
+#define next_zone(cur)		(config.cur_seg[cur] + config.segs_per_zone)
+#define last_zone(cur)		((cur - 1) * config.segs_per_zone)
+#define last_section(cur)	(cur + (config.secs_per_zone - 1) * config.segs_per_sec)
+
+#define set_sb_le64(member, val)		(sb.member = cpu_to_le64(val))
+#define set_sb_le32(member, val)		(sb.member = cpu_to_le32(val))
+#define set_sb_le16(member, val)		(sb.member = cpu_to_le16(val))
+#define get_sb_le64(member)			le64_to_cpu(sb.member)
+#define get_sb_le32(member)			le32_to_cpu(sb.member)
+#define get_sb_le16(member)			le16_to_cpu(sb.member)
+
+#define set_sb(member, val)	\
+			do {						\
+				typeof(sb.member) t;			\
+				switch (sizeof(t)) {			\
+				case 8: set_sb_le64(member, val); break; \
+				case 4: set_sb_le32(member, val); break; \
+				case 2: set_sb_le16(member, val); break; \
+				} \
+			} while(0)
+
+#define get_sb(member)		\
+			({						\
+				typeof(sb.member) t;			\
+				switch (sizeof(t)) {			\
+				case 8: t = get_sb_le64(member); break; \
+				case 4: t = get_sb_le32(member); break; \
+				case 2: t = get_sb_le16(member); break; \
+				} 					\
+				t; \
+			})
+
+#define set_cp_le64(member, val)		(cp->member = cpu_to_le64(val))
+#define set_cp_le32(member, val)		(cp->member = cpu_to_le32(val))
+#define set_cp_le16(member, val)		(cp->member = cpu_to_le16(val))
+#define get_cp_le64(member)			le64_to_cpu(cp->member)
+#define get_cp_le32(member)			le32_to_cpu(cp->member)
+#define get_cp_le16(member)			le16_to_cpu(cp->member)
+
+#define set_cp(member, val)	\
+			do {						\
+				typeof(cp->member) t;			\
+				switch (sizeof(t)) {			\
+				case 8: set_cp_le64(member, val); break; \
+				case 4: set_cp_le32(member, val); break; \
+				case 2: set_cp_le16(member, val); break; \
+				} \
+			} while(0)
+
+#define get_cp(member)		\
+			({						\
+				typeof(cp->member) t;			\
+				switch (sizeof(t)) {			\
+				case 8: t = get_cp_le64(member); break; \
+				case 4: t = get_cp_le32(member); break; \
+				case 2: t = get_cp_le16(member); break; \
+				} 					\
+				t; \
+			})
+
 
 const char *media_ext_lists[] = {
 	"jpg",
@@ -62,16 +126,16 @@ static void configure_extension_list(void)
 	int name_len;
 	int i = 0;
 
-	super_block.extension_count = 0;
-	memset(super_block.extension_list, 0,
-			sizeof(super_block.extension_list));
+	sb.extension_count = 0;
+	memset(sb.extension_list, 0,
+			sizeof(sb.extension_list));
 
 	while (*extlist) {
 		name_len = strlen(*extlist);
-		memcpy(super_block.extension_list[i++], *extlist, name_len);
+		memcpy(sb.extension_list[i++], *extlist, name_len);
 		extlist++;
 	}
-	super_block.extension_count = cpu_to_le32(i);
+	set_sb(extension_count, i);
 
 	if (!ext_str)
 		return;
@@ -80,13 +144,13 @@ static void configure_extension_list(void)
 	ue = strtok(ext_str, ",");
 	while (ue != NULL) {
 		name_len = strlen(ue);
-		memcpy(super_block.extension_list[i++], ue, name_len);
+		memcpy(sb.extension_list[i++], ue, name_len);
 		ue = strtok(NULL, ",");
 		if (i >= F2FS_MAX_EXTENSION)
 			break;
 	}
 
-	super_block.extension_count = cpu_to_le32(i);
+	set_sb(extension_count, i);
 
 	free(config.extension_list);
 }
@@ -105,34 +169,33 @@ static int f2fs_prepare_super_block(void)
 	u_int32_t max_nat_bitmap_size, max_nat_segments;
 	u_int32_t total_zones;
 
-	super_block.magic = cpu_to_le32(F2FS_SUPER_MAGIC);
-	super_block.major_ver = cpu_to_le16(F2FS_MAJOR_VERSION);
-	super_block.minor_ver = cpu_to_le16(F2FS_MINOR_VERSION);
+	set_sb(magic, F2FS_SUPER_MAGIC);
+	set_sb(major_ver, F2FS_MAJOR_VERSION);
+	set_sb(minor_ver, F2FS_MINOR_VERSION);
 
 	log_sectorsize = log_base_2(config.sector_size);
 	log_sectors_per_block = log_base_2(config.sectors_per_blk);
 	log_blocksize = log_sectorsize + log_sectors_per_block;
 	log_blks_per_seg = log_base_2(config.blks_per_seg);
 
-	super_block.log_sectorsize = cpu_to_le32(log_sectorsize);
-	super_block.log_sectors_per_block = cpu_to_le32(log_sectors_per_block);
+	set_sb(log_sectorsize, log_sectorsize);
+	set_sb(log_sectors_per_block, log_sectors_per_block);
+
+	set_sb(log_blocksize, log_blocksize);
+	set_sb(log_blocks_per_seg, log_blks_per_seg);
 
-	super_block.log_blocksize = cpu_to_le32(log_blocksize);
-	super_block.log_blocks_per_seg = cpu_to_le32(log_blks_per_seg);
+	set_sb(segs_per_sec, config.segs_per_sec);
+	set_sb(secs_per_zone, config.secs_per_zone);
 
-	super_block.segs_per_sec = cpu_to_le32(config.segs_per_sec);
-	super_block.secs_per_zone = cpu_to_le32(config.secs_per_zone);
 	blk_size_bytes = 1 << log_blocksize;
 	segment_size_bytes = blk_size_bytes * config.blks_per_seg;
 	zone_size_bytes =
 		blk_size_bytes * config.secs_per_zone *
 		config.segs_per_sec * config.blks_per_seg;
 
-	super_block.checksum_offset = 0;
+	sb.checksum_offset = 0;
 
-	super_block.block_count = cpu_to_le64(
-		(config.total_sectors * DEFAULT_SECTOR_SIZE) /
-			blk_size_bytes);
+	set_sb(block_count, config.total_sectors >> log_sectors_per_block);
 
 	zone_align_start_offset =
 		(config.start_sector * DEFAULT_SECTOR_SIZE +
@@ -148,55 +211,41 @@ static int f2fs_prepare_super_block(void)
 				DEFAULT_SECTORS_PER_BLOCK);
 	}
 
-	super_block.segment_count = cpu_to_le32(
-		((config.total_sectors * DEFAULT_SECTOR_SIZE) -
-		zone_align_start_offset) / segment_size_bytes);
+	set_sb(segment_count, (config.total_sectors * DEFAULT_SECTOR_SIZE -
+				zone_align_start_offset) / segment_size_bytes);
 
-	super_block.segment0_blkaddr =
-		cpu_to_le32(zone_align_start_offset / blk_size_bytes);
-	super_block.cp_blkaddr = super_block.segment0_blkaddr;
+	set_sb(segment0_blkaddr, zone_align_start_offset / blk_size_bytes);
+	sb.cp_blkaddr = sb.segment0_blkaddr;
 
-	MSG(0, "Info: zone aligned segment0 blkaddr: %u\n",
-				le32_to_cpu(super_block.segment0_blkaddr));
+	MSG(0, "Info: zone aligned segment0 blkaddr: %u\n", get_sb(segment0_blkaddr));
 
-	super_block.segment_count_ckpt =
-				cpu_to_le32(F2FS_NUMBER_OF_CHECKPOINT_PACK);
+	set_sb(segment_count_ckpt, F2FS_NUMBER_OF_CHECKPOINT_PACK);
 
-	super_block.sit_blkaddr = cpu_to_le32(
-		le32_to_cpu(super_block.segment0_blkaddr) +
-		(le32_to_cpu(super_block.segment_count_ckpt) *
-		(1 << log_blks_per_seg)));
+	set_sb(sit_blkaddr, get_sb(segment0_blkaddr) + get_sb(segment_count_ckpt) *
+			config.blks_per_seg);
 
-	blocks_for_sit = (le32_to_cpu(super_block.segment_count) +
-			SIT_ENTRY_PER_BLOCK - 1) / SIT_ENTRY_PER_BLOCK;
+	blocks_for_sit = ALIGN(get_sb(segment_count), SIT_ENTRY_PER_BLOCK);
 
-	sit_segments = (blocks_for_sit + config.blks_per_seg - 1)
-			/ config.blks_per_seg;
+	sit_segments = SEG_ALIGN(blocks_for_sit);
 
-	super_block.segment_count_sit = cpu_to_le32(sit_segments * 2);
+	set_sb(segment_count_sit, sit_segments * 2);
 
-	super_block.nat_blkaddr = cpu_to_le32(
-			le32_to_cpu(super_block.sit_blkaddr) +
-			(le32_to_cpu(super_block.segment_count_sit) *
-			 config.blks_per_seg));
+	set_sb(nat_blkaddr, get_sb(sit_blkaddr) + get_sb(segment_count_sit) *
+			config.blks_per_seg);
 
-	total_valid_blks_available = (le32_to_cpu(super_block.segment_count) -
-			(le32_to_cpu(super_block.segment_count_ckpt) +
-			 le32_to_cpu(super_block.segment_count_sit))) *
+	total_valid_blks_available = (get_sb(segment_count) -
+			(get_sb(segment_count_ckpt) + get_sb(segment_count_sit))) *
 			config.blks_per_seg;
 
-	blocks_for_nat = (total_valid_blks_available + NAT_ENTRY_PER_BLOCK - 1)
-				/ NAT_ENTRY_PER_BLOCK;
+	blocks_for_nat = ALIGN(total_valid_blks_available, NAT_ENTRY_PER_BLOCK);
 
-	super_block.segment_count_nat = cpu_to_le32(
-				(blocks_for_nat + config.blks_per_seg - 1) /
-				config.blks_per_seg);
+	set_sb(segment_count_nat, SEG_ALIGN(blocks_for_nat));
 	/*
 	 * The number of node segments should not be exceeded a "Threshold".
 	 * This number resizes NAT bitmap area in a CP page.
 	 * So the threshold is determined not to overflow one CP page
 	 */
-	sit_bitmap_size = ((le32_to_cpu(super_block.segment_count_sit) / 2) <<
+	sit_bitmap_size = ((get_sb(segment_count_sit) / 2) <<
 				log_blks_per_seg) / 8;
 
 	if (sit_bitmap_size > MAX_SIT_BITMAP_SIZE)
@@ -211,90 +260,74 @@ static int f2fs_prepare_super_block(void)
 	if (max_sit_bitmap_size >
 			(CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 65)) {
 		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1;
-		super_block.cp_payload = cpu_to_le32(F2FS_BLK_ALIGN(max_sit_bitmap_size));
+		set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
 	} else {
 		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
 			- max_sit_bitmap_size;
-		super_block.cp_payload = 0;
+		sb.cp_payload = 0;
 	}
 
 	max_nat_segments = (max_nat_bitmap_size * 8) >> log_blks_per_seg;
 
-	if (le32_to_cpu(super_block.segment_count_nat) > max_nat_segments)
-		super_block.segment_count_nat = cpu_to_le32(max_nat_segments);
+	if (get_sb(segment_count_nat) > max_nat_segments)
+		set_sb(segment_count_nat, max_nat_segments);
 
-	super_block.segment_count_nat = cpu_to_le32(
-			le32_to_cpu(super_block.segment_count_nat) * 2);
+	set_sb(segment_count_nat, get_sb(segment_count_nat) * 2);
 
-	super_block.ssa_blkaddr = cpu_to_le32(
-			le32_to_cpu(super_block.nat_blkaddr) +
-			le32_to_cpu(super_block.segment_count_nat) *
+	set_sb(ssa_blkaddr, get_sb(nat_blkaddr) + get_sb(segment_count_nat) *
 			config.blks_per_seg);
 
-	total_valid_blks_available = (le32_to_cpu(super_block.segment_count) -
-			(le32_to_cpu(super_block.segment_count_ckpt) +
-			le32_to_cpu(super_block.segment_count_sit) +
-			le32_to_cpu(super_block.segment_count_nat))) *
+	total_valid_blks_available = (get_sb(segment_count) -
+			(get_sb(segment_count_ckpt) +
+			get_sb(segment_count_sit) +
+			get_sb(segment_count_nat))) *
 			config.blks_per_seg;
 
 	blocks_for_ssa = total_valid_blks_available /
 				config.blks_per_seg + 1;
 
-	super_block.segment_count_ssa = cpu_to_le32(
-			(blocks_for_ssa + config.blks_per_seg - 1) /
-			config.blks_per_seg);
+	set_sb(segment_count_ssa, SEG_ALIGN(blocks_for_ssa));
 
-	total_meta_segments = le32_to_cpu(super_block.segment_count_ckpt) +
-		le32_to_cpu(super_block.segment_count_sit) +
-		le32_to_cpu(super_block.segment_count_nat) +
-		le32_to_cpu(super_block.segment_count_ssa);
-	diff = total_meta_segments % (config.segs_per_sec *
-						config.secs_per_zone);
+	total_meta_segments = get_sb(segment_count_ckpt) +
+		get_sb(segment_count_sit) +
+		get_sb(segment_count_nat) +
+		get_sb(segment_count_ssa);
+	diff = total_meta_segments % (config.segs_per_zone);
 	if (diff)
-		super_block.segment_count_ssa = cpu_to_le32(
-			le32_to_cpu(super_block.segment_count_ssa) +
-			(config.segs_per_sec * config.secs_per_zone -
-			 diff));
-
-	super_block.main_blkaddr = cpu_to_le32(
-			le32_to_cpu(super_block.ssa_blkaddr) +
-			(le32_to_cpu(super_block.segment_count_ssa) *
-			 config.blks_per_seg));
-
-	super_block.segment_count_main = cpu_to_le32(
-			le32_to_cpu(super_block.segment_count) -
-			(le32_to_cpu(super_block.segment_count_ckpt)
-			 + le32_to_cpu(super_block.segment_count_sit) +
-			 le32_to_cpu(super_block.segment_count_nat) +
-			 le32_to_cpu(super_block.segment_count_ssa)));
-
-	super_block.section_count = cpu_to_le32(
-			le32_to_cpu(super_block.segment_count_main)
-			/ config.segs_per_sec);
-
-	super_block.segment_count_main = cpu_to_le32(
-			le32_to_cpu(super_block.section_count) *
-			config.segs_per_sec);
-
-	if ((le32_to_cpu(super_block.segment_count_main) - 2) <
+		set_sb(segment_count_ssa, get_sb(segment_count_ssa) +
+			(config.segs_per_zone - diff));
+
+	set_sb(main_blkaddr, get_sb(ssa_blkaddr) + get_sb(segment_count_ssa) *
+			 config.blks_per_seg);
+
+	set_sb(segment_count_main, get_sb(segment_count) -
+			(get_sb(segment_count_ckpt) +
+			 get_sb(segment_count_sit) +
+			 get_sb(segment_count_nat) +
+			 get_sb(segment_count_ssa)));
+
+	set_sb(section_count, get_sb(segment_count_main) / config.segs_per_sec);
+
+	set_sb(segment_count_main, get_sb(section_count) * config.segs_per_sec);
+
+	if ((get_sb(segment_count_main) - 2) <
 					config.reserved_segments) {
 		MSG(1, "\tError: Device size is not sufficient for F2FS volume,\
 			more segment needed =%u",
 			config.reserved_segments -
-			(le32_to_cpu(super_block.segment_count_main) - 2));
+			(get_sb(segment_count_main) - 2));
 		return -1;
 	}
 
-	uuid_generate(super_block.uuid);
+	uuid_generate(sb.uuid);
 
-	ASCIIToUNICODE(super_block.volume_name, (u_int8_t *)config.vol_label);
+	ASCIIToUNICODE(sb.volume_name, (u_int8_t *)config.vol_label);
 
-	super_block.node_ino = cpu_to_le32(1);
-	super_block.meta_ino = cpu_to_le32(2);
-	super_block.root_ino = cpu_to_le32(3);
+	set_sb(node_ino, 1);
+	set_sb(meta_ino, 2);
+	set_sb(root_ino, 3);
 
-	total_zones = le32_to_cpu(super_block.segment_count_main) /
-			(config.segs_per_sec * config.secs_per_zone);
+	total_zones = get_sb(segment_count_main) / (config.segs_per_zone);
 	if (total_zones <= 6) {
 		MSG(1, "\tError: %d zones: Need more zones \
 			by shrinking zone size\n", total_zones);
@@ -302,50 +335,19 @@ static int f2fs_prepare_super_block(void)
 	}
 
 	if (config.heap) {
-		config.cur_seg[CURSEG_HOT_NODE] = (total_zones - 1) *
-					config.segs_per_sec *
-					config.secs_per_zone +
-					((config.secs_per_zone - 1) *
-					config.segs_per_sec);
-		config.cur_seg[CURSEG_WARM_NODE] =
-					config.cur_seg[CURSEG_HOT_NODE] -
-					config.segs_per_sec *
-					config.secs_per_zone;
-		config.cur_seg[CURSEG_COLD_NODE] =
-					config.cur_seg[CURSEG_WARM_NODE] -
-					config.segs_per_sec *
-					config.secs_per_zone;
-		config.cur_seg[CURSEG_HOT_DATA] =
-					config.cur_seg[CURSEG_COLD_NODE] -
-					config.segs_per_sec *
-					config.secs_per_zone;
+		config.cur_seg[CURSEG_HOT_NODE] = last_section(last_zone(total_zones));
+		config.cur_seg[CURSEG_WARM_NODE] = prev_zone(CURSEG_HOT_NODE);
+		config.cur_seg[CURSEG_COLD_NODE] = prev_zone(CURSEG_WARM_NODE);
+		config.cur_seg[CURSEG_HOT_DATA] = prev_zone(CURSEG_COLD_NODE);
 		config.cur_seg[CURSEG_COLD_DATA] = 0;
-		config.cur_seg[CURSEG_WARM_DATA] =
-					config.cur_seg[CURSEG_COLD_DATA] +
-					config.segs_per_sec *
-					config.secs_per_zone;
+		config.cur_seg[CURSEG_WARM_DATA] = next_zone(CURSEG_COLD_DATA);
 	} else {
 		config.cur_seg[CURSEG_HOT_NODE] = 0;
-		config.cur_seg[CURSEG_WARM_NODE] =
-					config.cur_seg[CURSEG_HOT_NODE] +
-					config.segs_per_sec *
-					config.secs_per_zone;
-		config.cur_seg[CURSEG_COLD_NODE] =
-					config.cur_seg[CURSEG_WARM_NODE] +
-					config.segs_per_sec *
-					config.secs_per_zone;
-		config.cur_seg[CURSEG_HOT_DATA] =
-					config.cur_seg[CURSEG_COLD_NODE] +
-					config.segs_per_sec *
-					config.secs_per_zone;
-		config.cur_seg[CURSEG_COLD_DATA] =
-					config.cur_seg[CURSEG_HOT_DATA] +
-					config.segs_per_sec *
-					config.secs_per_zone;
-		config.cur_seg[CURSEG_WARM_DATA] =
-					config.cur_seg[CURSEG_COLD_DATA] +
-					config.segs_per_sec *
-					config.secs_per_zone;
+		config.cur_seg[CURSEG_WARM_NODE] = next_zone(CURSEG_HOT_NODE);
+		config.cur_seg[CURSEG_COLD_NODE] = next_zone(CURSEG_WARM_NODE);
+		config.cur_seg[CURSEG_HOT_DATA] = next_zone(CURSEG_COLD_NODE);
+		config.cur_seg[CURSEG_COLD_DATA] = next_zone(CURSEG_HOT_DATA);
+		config.cur_seg[CURSEG_WARM_DATA] = next_zone(CURSEG_COLD_DATA);
 	}
 
 	configure_extension_list();
@@ -359,8 +361,8 @@ static int f2fs_prepare_super_block(void)
 		memset(config.version, 0, VERSION_LEN);
 	}
 
-	memcpy(super_block.version, config.version, VERSION_LEN);
-	memcpy(super_block.init_version, config.version, VERSION_LEN);
+	memcpy(sb.version, config.version, VERSION_LEN);
+	memcpy(sb.init_version, config.version, VERSION_LEN);
 
 	return 0;
 }
@@ -372,9 +374,8 @@ static int f2fs_init_sit_area(void)
 	u_int64_t sit_seg_addr = 0;
 	u_int8_t *zero_buf = NULL;
 
-	blk_size = 1 << le32_to_cpu(super_block.log_blocksize);
-	seg_size = (1 << le32_to_cpu(super_block.log_blocks_per_seg)) *
-							blk_size;
+	blk_size = 1 << get_sb(log_blocksize);
+	seg_size = (1 << get_sb(log_blocks_per_seg)) * blk_size;
 
 	zero_buf = calloc(sizeof(u_int8_t), seg_size);
 	if(zero_buf == NULL) {
@@ -382,13 +383,11 @@ static int f2fs_init_sit_area(void)
 		return -1;
 	}
 
-	sit_seg_addr = le32_to_cpu(super_block.sit_blkaddr);
+	sit_seg_addr = get_sb(sit_blkaddr);
 	sit_seg_addr *= blk_size;
 
 	DBG(1, "\tFilling sit area at offset 0x%08"PRIx64"\n", sit_seg_addr);
-	for (index = 0;
-		index < (le32_to_cpu(super_block.segment_count_sit) / 2);
-								index++) {
+	for (index = 0; index < (get_sb(segment_count_sit) / 2); index++) {
 		if (dev_fill(zero_buf, sit_seg_addr, seg_size)) {
 			MSG(1, "\tError: While zeroing out the sit area \
 					on disk!!!\n");
@@ -408,9 +407,8 @@ static int f2fs_init_nat_area(void)
 	u_int64_t nat_seg_addr = 0;
 	u_int8_t *nat_buf = NULL;
 
-	blk_size = 1 << le32_to_cpu(super_block.log_blocksize);
-	seg_size = (1 << le32_to_cpu(super_block.log_blocks_per_seg)) *
-							blk_size;
+	blk_size = 1 << get_sb(log_blocksize);
+	seg_size = (1 << get_sb(log_blocks_per_seg)) * blk_size;
 
 	nat_buf = calloc(sizeof(u_int8_t), seg_size);
 	if (nat_buf == NULL) {
@@ -418,13 +416,11 @@ static int f2fs_init_nat_area(void)
 		return -1;
 	}
 
-	nat_seg_addr = le32_to_cpu(super_block.nat_blkaddr);
+	nat_seg_addr = get_sb(nat_blkaddr);
 	nat_seg_addr *= blk_size;
 
 	DBG(1, "\tFilling nat area at offset 0x%08"PRIx64"\n", nat_seg_addr);
-	for (index = 0;
-		index < (le32_to_cpu(super_block.segment_count_nat) / 2);
-								index++) {
+	for (index = 0; index < get_sb(segment_count_nat) / 2; index++) {
 		if (dev_fill(nat_buf, nat_seg_addr, seg_size)) {
 			MSG(1, "\tError: While zeroing out the nat area \
 					on disk!!!\n");
@@ -439,18 +435,17 @@ static int f2fs_init_nat_area(void)
 
 static int f2fs_write_check_point_pack(void)
 {
-	struct f2fs_checkpoint *ckp = NULL;
 	struct f2fs_summary_block *sum = NULL;
 	u_int32_t blk_size_bytes;
 	u_int64_t cp_seg_blk_offset = 0;
 	u_int32_t crc = 0;
 	unsigned int i;
 	char *cp_payload = NULL;
-	char *sum_buf, *sum_buf_ptr;
+	char *sum_compact, *sum_compact_p;
 	struct f2fs_summary *sum_entry;
 
-	ckp = calloc(F2FS_BLKSIZE, 1);
-	if (ckp == NULL) {
+	cp = calloc(F2FS_BLKSIZE, 1);
+	if (cp == NULL) {
 		MSG(1, "\tError: Calloc Failed for f2fs_checkpoint!!!\n");
 		return -1;
 	}
@@ -461,12 +456,12 @@ static int f2fs_write_check_point_pack(void)
 		return -1;
 	}
 
-	sum_buf = calloc(F2FS_BLKSIZE, 1);
+	sum_compact = calloc(F2FS_BLKSIZE, 1);
 	if (sum == NULL) {
 		MSG(1, "\tError: Calloc Failed for summay buffer!!!\n");
 		return -1;
 	}
-	sum_buf_ptr = sum_buf;
+	sum_compact_p = sum_compact;
 
 	cp_payload = calloc(F2FS_BLKSIZE, 1);
 	if (cp_payload == NULL) {
@@ -475,77 +470,62 @@ static int f2fs_write_check_point_pack(void)
 	}
 
 	/* 1. cp page 1 of checkpoint pack 1 */
-	ckp->checkpoint_ver = cpu_to_le64(1);
-	ckp->cur_node_segno[0] =
-		cpu_to_le32(config.cur_seg[CURSEG_HOT_NODE]);
-	ckp->cur_node_segno[1] =
-		cpu_to_le32(config.cur_seg[CURSEG_WARM_NODE]);
-	ckp->cur_node_segno[2] =
-		cpu_to_le32(config.cur_seg[CURSEG_COLD_NODE]);
-	ckp->cur_data_segno[0] =
-		cpu_to_le32(config.cur_seg[CURSEG_HOT_DATA]);
-	ckp->cur_data_segno[1] =
-		cpu_to_le32(config.cur_seg[CURSEG_WARM_DATA]);
-	ckp->cur_data_segno[2] =
-		cpu_to_le32(config.cur_seg[CURSEG_COLD_DATA]);
+	set_cp(checkpoint_ver, 1);
+	set_cp(cur_node_segno[0], config.cur_seg[CURSEG_HOT_NODE]);
+	set_cp(cur_node_segno[1], config.cur_seg[CURSEG_WARM_NODE]);
+	set_cp(cur_node_segno[2], config.cur_seg[CURSEG_COLD_NODE]);
+	set_cp(cur_data_segno[0], config.cur_seg[CURSEG_HOT_DATA]);
+	set_cp(cur_data_segno[1], config.cur_seg[CURSEG_WARM_DATA]);
+	set_cp(cur_data_segno[2], config.cur_seg[CURSEG_COLD_DATA]);
 	for (i = 3; i < MAX_ACTIVE_NODE_LOGS; i++) {
-		ckp->cur_node_segno[i] = 0xffffffff;
-		ckp->cur_data_segno[i] = 0xffffffff;
+		set_cp(cur_node_segno[i], 0xffffffff);
+		set_cp(cur_data_segno[i], 0xffffffff);
 	}
 
-	ckp->cur_node_blkoff[0] = cpu_to_le16(1);
-	ckp->cur_data_blkoff[0] = cpu_to_le16(1);
-	ckp->valid_block_count = cpu_to_le64(2);
-	ckp->rsvd_segment_count = cpu_to_le32(config.reserved_segments);
-	ckp->overprov_segment_count = cpu_to_le32(
-			(le32_to_cpu(super_block.segment_count_main) -
-			le32_to_cpu(ckp->rsvd_segment_count)) *
+	set_cp(cur_node_blkoff[0], 1);
+	set_cp(cur_data_blkoff[0], 1);
+	set_cp(valid_block_count, 2);
+	set_cp(rsvd_segment_count, config.reserved_segments);
+	set_cp(overprov_segment_count, (get_sb(segment_count_main) -
+			get_cp(rsvd_segment_count)) *
 			config.overprovision / 100);
-	ckp->overprov_segment_count = cpu_to_le32(
-			le32_to_cpu(ckp->overprov_segment_count) +
-			le32_to_cpu(ckp->rsvd_segment_count));
+	set_cp(overprov_segment_count, get_cp(overprov_segment_count) +
+			get_cp(rsvd_segment_count));
 
 	/* main segments - reserved segments - (node + data segments) */
-	ckp->free_segment_count = cpu_to_le32(
-			le32_to_cpu(super_block.segment_count_main) - 6);
-	ckp->user_block_count = cpu_to_le64(
-			((le32_to_cpu(ckp->free_segment_count) + 6 -
-			le32_to_cpu(ckp->overprov_segment_count)) *
-			 config.blks_per_seg));
+	set_cp(free_segment_count, get_sb(segment_count_main) - 6);
+	set_cp(user_block_count, ((get_cp(free_segment_count) + 6 -
+			get_cp(overprov_segment_count)) * config.blks_per_seg));
 	/* cp page (2), data summaries (1), node summaries (3) */
-	ckp->cp_pack_total_block_count =
-		cpu_to_le32(6 + le32_to_cpu(super_block.cp_payload));
-	ckp->ckpt_flags = cpu_to_le32(CP_UMOUNT_FLAG | CP_COMPACT_SUM_FLAG);
-	ckp->cp_pack_start_sum = cpu_to_le32(1 + le32_to_cpu(super_block.cp_payload));
-	ckp->valid_node_count = cpu_to_le32(1);
-	ckp->valid_inode_count = cpu_to_le32(1);
-	ckp->next_free_nid = cpu_to_le32(
-			le32_to_cpu(super_block.root_ino) + 1);
-	ckp->sit_ver_bitmap_bytesize = cpu_to_le32(
-			((le32_to_cpu(super_block.segment_count_sit) / 2) <<
-			 le32_to_cpu(super_block.log_blocks_per_seg)) / 8);
-
-	ckp->nat_ver_bitmap_bytesize = cpu_to_le32(
-			((le32_to_cpu(super_block.segment_count_nat) / 2) <<
-			 le32_to_cpu(super_block.log_blocks_per_seg)) / 8);
-
-	ckp->checksum_offset = cpu_to_le32(CHECKSUM_OFFSET);
-
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, ckp, CHECKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)ckp + CHECKSUM_OFFSET)) =
+	set_cp(cp_pack_total_block_count, 6 + get_sb(cp_payload));
+	set_cp(ckpt_flags, CP_UMOUNT_FLAG | CP_COMPACT_SUM_FLAG);
+	set_cp(cp_pack_start_sum, 1 + get_sb(cp_payload));
+	set_cp(valid_node_count, 1);
+	set_cp(valid_inode_count, 1);
+	set_cp(next_free_nid, get_sb(root_ino) + 1);
+	set_cp(sit_ver_bitmap_bytesize, ((get_sb(segment_count_sit) / 2) <<
+			get_sb(log_blocks_per_seg)) / 8);
+
+	set_cp(nat_ver_bitmap_bytesize, ((get_sb(segment_count_nat) / 2) <<
+			 get_sb(log_blocks_per_seg)) / 8);
+
+	set_cp(checksum_offset, CHECKSUM_OFFSET);
+
+	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CHECKSUM_OFFSET);
+	*((__le32 *)((unsigned char *)cp + CHECKSUM_OFFSET)) =
 							cpu_to_le32(crc);
 
-	blk_size_bytes = 1 << le32_to_cpu(super_block.log_blocksize);
-	cp_seg_blk_offset = le32_to_cpu(super_block.segment0_blkaddr);
+	blk_size_bytes = 1 << get_sb(log_blocksize);
+	cp_seg_blk_offset = get_sb(segment0_blkaddr);
 	cp_seg_blk_offset *= blk_size_bytes;
 
-	DBG(1, "\tWriting main segments, ckp at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
-	if (dev_write(ckp, cp_seg_blk_offset, blk_size_bytes)) {
-		MSG(1, "\tError: While writing the ckp to disk!!!\n");
+	DBG(1, "\tWriting main segments, cp at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
+	if (dev_write(cp, cp_seg_blk_offset, blk_size_bytes)) {
+		MSG(1, "\tError: While writing the cp to disk!!!\n");
 		return -1;
 	}
 
-	for (i = 0; i < le32_to_cpu(super_block.cp_payload); i++) {
+	for (i = 0; i < get_sb(cp_payload); i++) {
 		cp_seg_blk_offset += blk_size_bytes;
 		if (dev_fill(cp_payload, cp_seg_blk_offset, blk_size_bytes)) {
 			MSG(1, "\tError: While zeroing out the sit bitmap area \
@@ -573,42 +553,42 @@ static int f2fs_write_check_point_pack(void)
 	SET_SUM_TYPE((&sum->footer), SUM_TYPE_DATA);
 
 	sum->n_nats = cpu_to_le16(1);
-	sum->nat_j.entries[0].nid = super_block.root_ino;
+	sum->nat_j.entries[0].nid = sb.root_ino;
 	sum->nat_j.entries[0].ne.version = 0;
-	sum->nat_j.entries[0].ne.ino = super_block.root_ino;
+	sum->nat_j.entries[0].ne.ino = sb.root_ino;
 	sum->nat_j.entries[0].ne.block_addr = cpu_to_le32(
-			le32_to_cpu(super_block.main_blkaddr) +
-			ckp->cur_node_segno[0] * config.blks_per_seg);
+			get_sb(main_blkaddr) +
+			get_cp(cur_node_segno[0]) * config.blks_per_seg);
 
-	memcpy(sum_buf_ptr, &sum->n_nats, SUM_JOURNAL_SIZE);
-	sum_buf_ptr += SUM_JOURNAL_SIZE;
+	memcpy(sum_compact_p, &sum->n_nats, SUM_JOURNAL_SIZE);
+	sum_compact_p += SUM_JOURNAL_SIZE;
 
 	memset(sum, 0, sizeof(struct f2fs_summary_block));
 	/* inode sit for root */
 	sum->n_sits = cpu_to_le16(6);
-	sum->sit_j.entries[0].segno = ckp->cur_node_segno[0];
+	sum->sit_j.entries[0].segno = cp->cur_node_segno[0];
 	sum->sit_j.entries[0].se.vblocks = cpu_to_le16((CURSEG_HOT_NODE << 10) | 1);
 	f2fs_set_bit(0, (char *)sum->sit_j.entries[0].se.valid_map);
-	sum->sit_j.entries[1].segno = ckp->cur_node_segno[1];
+	sum->sit_j.entries[1].segno = cp->cur_node_segno[1];
 	sum->sit_j.entries[1].se.vblocks = cpu_to_le16((CURSEG_WARM_NODE << 10));
-	sum->sit_j.entries[2].segno = ckp->cur_node_segno[2];
+	sum->sit_j.entries[2].segno = cp->cur_node_segno[2];
 	sum->sit_j.entries[2].se.vblocks = cpu_to_le16((CURSEG_COLD_NODE << 10));
 
 	/* data sit for root */
-	sum->sit_j.entries[3].segno = ckp->cur_data_segno[0];
+	sum->sit_j.entries[3].segno = cp->cur_data_segno[0];
 	sum->sit_j.entries[3].se.vblocks = cpu_to_le16((CURSEG_HOT_DATA << 10) | 1);
 	f2fs_set_bit(0, (char *)sum->sit_j.entries[3].se.valid_map);
-	sum->sit_j.entries[4].segno = ckp->cur_data_segno[1];
+	sum->sit_j.entries[4].segno = cp->cur_data_segno[1];
 	sum->sit_j.entries[4].se.vblocks = cpu_to_le16((CURSEG_WARM_DATA << 10));
-	sum->sit_j.entries[5].segno = ckp->cur_data_segno[2];
+	sum->sit_j.entries[5].segno = cp->cur_data_segno[2];
 	sum->sit_j.entries[5].se.vblocks = cpu_to_le16((CURSEG_COLD_DATA << 10));
 
-	memcpy(sum_buf_ptr, &sum->n_sits, SUM_JOURNAL_SIZE);
-	sum_buf_ptr += SUM_JOURNAL_SIZE;
+	memcpy(sum_compact_p, &sum->n_sits, SUM_JOURNAL_SIZE);
+	sum_compact_p += SUM_JOURNAL_SIZE;
 
 	/* hot data summary */
-	sum_entry = (struct f2fs_summary *)sum_buf_ptr;
-	sum_entry->nid = super_block.root_ino;
+	sum_entry = (struct f2fs_summary *)sum_compact_p;
+	sum_entry->nid = sb.root_ino;
 	sum_entry->ofs_in_node = 0;
 	/* warm data summary, nothing to do */
 	/* cold data summary, nothing to do */
@@ -616,7 +596,7 @@ static int f2fs_write_check_point_pack(void)
 	cp_seg_blk_offset += blk_size_bytes;
 	DBG(1, "\tWriting Segment summary for HOT/WARM/COLD_DATA, at offset 0x%08"PRIx64"\n",
 			cp_seg_blk_offset);
-	if (dev_write(sum_buf, cp_seg_blk_offset, blk_size_bytes)) {
+	if (dev_write(sum_compact, cp_seg_blk_offset, blk_size_bytes)) {
 		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
 		return -1;
 	}
@@ -625,7 +605,7 @@ static int f2fs_write_check_point_pack(void)
 	memset(sum, 0, sizeof(struct f2fs_summary_block));
 	SET_SUM_TYPE((&sum->footer), SUM_TYPE_NODE);
 
-	sum->entries[0].nid = super_block.root_ino;
+	sum->entries[0].nid = sb.root_ino;
 	sum->entries[0].ofs_in_node = 0;
 
 	cp_seg_blk_offset += blk_size_bytes;
@@ -662,29 +642,29 @@ static int f2fs_write_check_point_pack(void)
 	/* cp page2 */
 	cp_seg_blk_offset += blk_size_bytes;
 	DBG(1, "\tWriting cp page2, at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
-	if (dev_write(ckp, cp_seg_blk_offset, blk_size_bytes)) {
-		MSG(1, "\tError: While writing the ckp to disk!!!\n");
+	if (dev_write(cp, cp_seg_blk_offset, blk_size_bytes)) {
+		MSG(1, "\tError: While writing the cp to disk!!!\n");
 		return -1;
 	}
 
 	/* cp page 1 of check point pack 2
 	 * Initiatialize other checkpoint pack with version zero
 	 */
-	ckp->checkpoint_ver = 0;
+	cp->checkpoint_ver = 0;
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, ckp, CHECKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)ckp + CHECKSUM_OFFSET)) =
+	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CHECKSUM_OFFSET);
+	*((__le32 *)((unsigned char *)cp + CHECKSUM_OFFSET)) =
 							cpu_to_le32(crc);
-	cp_seg_blk_offset = (le32_to_cpu(super_block.segment0_blkaddr) +
+	cp_seg_blk_offset = (get_sb(segment0_blkaddr) +
 				config.blks_per_seg) *
 				blk_size_bytes;
 	DBG(1, "\tWriting cp page 1 of checkpoint pack 2, at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
-	if (dev_write(ckp, cp_seg_blk_offset, blk_size_bytes)) {
-		MSG(1, "\tError: While writing the ckp to disk!!!\n");
+	if (dev_write(cp, cp_seg_blk_offset, blk_size_bytes)) {
+		MSG(1, "\tError: While writing the cp to disk!!!\n");
 		return -1;
 	}
 
-	for (i = 0; i < le32_to_cpu(super_block.cp_payload); i++) {
+	for (i = 0; i < get_sb(cp_payload); i++) {
 		cp_seg_blk_offset += blk_size_bytes;
 		if (dev_fill(cp_payload, cp_seg_blk_offset, blk_size_bytes)) {
 			MSG(1, "\tError: While zeroing out the sit bitmap area \
@@ -694,18 +674,18 @@ static int f2fs_write_check_point_pack(void)
 	}
 
 	/* cp page 2 of check point pack 2 */
-	cp_seg_blk_offset += blk_size_bytes * (le32_to_cpu(ckp->cp_pack_total_block_count)
-			- le32_to_cpu(super_block.cp_payload) - 1);
+	cp_seg_blk_offset += blk_size_bytes * (le32_to_cpu(cp->cp_pack_total_block_count)
+			- get_sb(cp_payload) - 1);
 	DBG(1, "\tWriting cp page 2 of checkpoint pack 2, at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
-	if (dev_write(ckp, cp_seg_blk_offset, blk_size_bytes)) {
-		MSG(1, "\tError: While writing the ckp to disk!!!\n");
+	if (dev_write(cp, cp_seg_blk_offset, blk_size_bytes)) {
+		MSG(1, "\tError: While writing the cp to disk!!!\n");
 		return -1;
 	}
 
-	free(sum_buf);
+	free(sum_compact);
 	free(sum);
-	free(ckp);
 	free(cp_payload);
+	free(cp);
 	return	0;
 }
 
@@ -716,8 +696,8 @@ static int f2fs_write_super_block(void)
 
 	zero_buff = calloc(F2FS_BLKSIZE, 1);
 
-	memcpy(zero_buff + F2FS_SUPER_OFFSET, &super_block,
-						sizeof(super_block));
+	memcpy(zero_buff + F2FS_SUPER_OFFSET, &sb,
+						sizeof(sb));
 	DBG(1, "\tWriting super block, at offset 0x%08x\n", 0);
 	for (index = 0; index < 2; index++) {
 		if (dev_write(zero_buff, index * F2FS_BLKSIZE, F2FS_BLKSIZE)) {
@@ -743,11 +723,11 @@ static int f2fs_write_root_inode(void)
 		return -1;
 	}
 
-	raw_node->footer.nid = super_block.root_ino;
-	raw_node->footer.ino = super_block.root_ino;
+	raw_node->footer.nid = sb.root_ino;
+	raw_node->footer.ino = sb.root_ino;
 	raw_node->footer.cp_ver = cpu_to_le64(1);
 	raw_node->footer.next_blkaddr = cpu_to_le32(
-			le32_to_cpu(super_block.main_blkaddr) +
+			get_sb(main_blkaddr) +
 			config.cur_seg[CURSEG_HOT_NODE] *
 			config.blks_per_seg + 1);
 
@@ -756,7 +736,7 @@ static int f2fs_write_root_inode(void)
 	raw_node->i.i_uid = cpu_to_le32(getuid());
 	raw_node->i.i_gid = cpu_to_le32(getgid());
 
-	blk_size_bytes = 1 << le32_to_cpu(super_block.log_blocksize);
+	blk_size_bytes = 1 << get_sb(log_blocksize);
 	raw_node->i.i_size = cpu_to_le64(1 * blk_size_bytes); /* dentry */
 	raw_node->i.i_blocks = cpu_to_le64(2);
 
@@ -772,7 +752,7 @@ static int f2fs_write_root_inode(void)
 	raw_node->i.i_current_depth = cpu_to_le32(1);
 	raw_node->i.i_dir_level = DEF_DIR_LEVEL;
 
-	data_blk_nor = le32_to_cpu(super_block.main_blkaddr) +
+	data_blk_nor = get_sb(main_blkaddr) +
 		config.cur_seg[CURSEG_HOT_DATA] * config.blks_per_seg;
 	raw_node->i.i_addr[0] = cpu_to_le32(data_blk_nor);
 
@@ -780,7 +760,7 @@ static int f2fs_write_root_inode(void)
 	raw_node->i.i_ext.blk_addr = cpu_to_le32(data_blk_nor);
 	raw_node->i.i_ext.len = cpu_to_le32(1);
 
-	main_area_node_seg_blk_offset = le32_to_cpu(super_block.main_blkaddr);
+	main_area_node_seg_blk_offset = get_sb(main_blkaddr);
 	main_area_node_seg_blk_offset += config.cur_seg[CURSEG_HOT_NODE] *
 					config.blks_per_seg;
         main_area_node_seg_blk_offset *= blk_size_bytes;
@@ -794,7 +774,7 @@ static int f2fs_write_root_inode(void)
 	memset(raw_node, 0xff, sizeof(struct f2fs_node));
 
 	/* avoid power-off-recovery based on roll-forward policy */
-	main_area_node_seg_blk_offset = le32_to_cpu(super_block.main_blkaddr);
+	main_area_node_seg_blk_offset = get_sb(main_blkaddr);
 	main_area_node_seg_blk_offset += config.cur_seg[CURSEG_WARM_NODE] *
 					config.blks_per_seg;
         main_area_node_seg_blk_offset *= blk_size_bytes;
@@ -820,21 +800,21 @@ static int f2fs_update_nat_root(void)
 	}
 
 	/* update root */
-	nat_blk->entries[le32_to_cpu(super_block.root_ino)].block_addr = cpu_to_le32(
-		le32_to_cpu(super_block.main_blkaddr) +
+	nat_blk->entries[get_sb(root_ino)].block_addr = cpu_to_le32(
+		get_sb(main_blkaddr) +
 		config.cur_seg[CURSEG_HOT_NODE] * config.blks_per_seg);
-	nat_blk->entries[le32_to_cpu(super_block.root_ino)].ino = super_block.root_ino;
+	nat_blk->entries[get_sb(root_ino)].ino = sb.root_ino;
 
 	/* update node nat */
-	nat_blk->entries[le32_to_cpu(super_block.node_ino)].block_addr = cpu_to_le32(1);
-	nat_blk->entries[le32_to_cpu(super_block.node_ino)].ino = super_block.node_ino;
+	nat_blk->entries[get_sb(node_ino)].block_addr = cpu_to_le32(1);
+	nat_blk->entries[get_sb(node_ino)].ino = sb.node_ino;
 
 	/* update meta nat */
-	nat_blk->entries[le32_to_cpu(super_block.meta_ino)].block_addr = cpu_to_le32(1);
-	nat_blk->entries[le32_to_cpu(super_block.meta_ino)].ino = super_block.meta_ino;
+	nat_blk->entries[get_sb(meta_ino)].block_addr = cpu_to_le32(1);
+	nat_blk->entries[get_sb(meta_ino)].ino = sb.meta_ino;
 
-	blk_size_bytes = 1 << le32_to_cpu(super_block.log_blocksize);
-	nat_seg_blk_offset = le32_to_cpu(super_block.nat_blkaddr);
+	blk_size_bytes = 1 << get_sb(log_blocksize);
+	nat_seg_blk_offset = get_sb(nat_blkaddr);
 	nat_seg_blk_offset *= blk_size_bytes;
 
 	DBG(1, "\tWriting nat root, at offset 0x%08"PRIx64"\n", nat_seg_blk_offset);
@@ -859,21 +839,21 @@ static int f2fs_add_default_dentry_root(void)
 	}
 
 	dent_blk->dentry[0].hash_code = 0;
-	dent_blk->dentry[0].ino = super_block.root_ino;
+	dent_blk->dentry[0].ino = sb.root_ino;
 	dent_blk->dentry[0].name_len = cpu_to_le16(1);
 	dent_blk->dentry[0].file_type = F2FS_FT_DIR;
 	memcpy(dent_blk->filename[0], ".", 1);
 
 	dent_blk->dentry[1].hash_code = 0;
-	dent_blk->dentry[1].ino = super_block.root_ino;
+	dent_blk->dentry[1].ino = sb.root_ino;
 	dent_blk->dentry[1].name_len = cpu_to_le16(2);
 	dent_blk->dentry[1].file_type = F2FS_FT_DIR;
 	memcpy(dent_blk->filename[1], "..", 2);
 
 	/* bitmap for . and .. */
 	dent_blk->dentry_bitmap[0] = (1 << 1) | (1 << 0);
-	blk_size_bytes = 1 << le32_to_cpu(super_block.log_blocksize);
-	data_blk_offset = le32_to_cpu(super_block.main_blkaddr);
+	blk_size_bytes = 1 << get_sb(log_blocksize);
+	data_blk_offset = get_sb(main_blkaddr);
 	data_blk_offset += config.cur_seg[CURSEG_HOT_DATA] *
 				config.blks_per_seg;
 	data_blk_offset *= blk_size_bytes;
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index e1f7c69..bba2085 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -110,6 +110,7 @@ static void f2fs_parse_options(int argc, char *argv[])
 	config.reserved_segments  =
 			(2 * (100 / config.overprovision + 1) + 6)
 			* config.segs_per_sec;
+	config.segs_per_zone = config.segs_per_sec * config.secs_per_zone;
 }
 
 int main(int argc, char *argv[])
-- 
1.9.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
