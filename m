From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3] mkfs.f2fs: expand scalability of nat bitmap
Date: Thu, 25 Jan 2018 19:45:13 +0800
Message-ID: <20180125114513.89632-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eefyI-0005LA-Pj
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Jan 2018 11:45:34 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eefyG-0004Pw-OY
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Jan 2018 11:45:34 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Previously, our total node number (nat_bitmap) and total nat segment count
will not monotonously increase along with image size, and max nat_bitmap size
is limited by "CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1", it is
with bad scalability when user wants to create more inode/node in larger image.

So this patch tries to relieve the limitation, by default, limitting total nat
entry number with 20% of total block number.

Before:
image_size(GB)	nat_bitmap	sit_bitmap	nat_segment	sit_segment
16		3836		64		36		2
32		3836		64		72		2
64		3772		128		116		4
128		3708		192		114		6
256		3580		320		110		10
512		3260		640		100		20
1024		2684		1216		82		38
2048		1468		2432		44		76
4096		3900		4800		120		150

After:
image_size(GB)	nat_bitmap	sit_bitmap	nat_segment	sit_segment
16		256		64		8		2
32		512		64		16		2
64		960		128		30		4
128		1856		192		58		6
256		3712		320		116		10
512		7424		640		232		20
1024		14787		1216		462		38
2048		29504		2432		922		76
4096		59008		4800		1844		150

Add a new option '-i' to control turning on/off this feature.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- add a option '-i' to control turning on/off this feature.
 fsck/f2fs.h             | 19 +++++++++-----
 fsck/resize.c           | 59 ++++++++++++++++++++++++++++++-------------
 include/f2fs_fs.h       |  8 +++++-
 lib/libf2fs.c           |  1 +
 mkfs/f2fs_format.c      | 67 +++++++++++++++++++++++++++++++++----------------
 mkfs/f2fs_format_main.c |  6 ++++-
 6 files changed, 114 insertions(+), 46 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index f5970d9dafc0..8a5ce365282d 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -239,6 +239,12 @@ static inline unsigned int ofs_of_node(struct f2fs_node *node_blk)
 	return flag >> OFFSET_BIT_SHIFT;
 }
 
+static inline bool is_set_ckpt_flags(struct f2fs_checkpoint *cp, unsigned int f)
+{
+	unsigned int ckpt_flags = le32_to_cpu(cp->ckpt_flags);
+	return ckpt_flags & f ? 1 : 0;
+}
+
 static inline unsigned long __bitmap_size(struct f2fs_sb_info *sbi, int flag)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
@@ -256,6 +262,13 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	int offset;
+
+	if (is_set_ckpt_flags(ckpt, CP_LARGE_NAT_BITMAP_FLAG)) {
+		offset = (flag == SIT_BITMAP) ?
+			le32_to_cpu(ckpt->nat_ver_bitmap_bytesize) : 0;
+		return &ckpt->sit_nat_version_bitmap + offset;
+	}
+
 	if (le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload) > 0) {
 		if (flag == NAT_BITMAP)
 			return &ckpt->sit_nat_version_bitmap;
@@ -268,12 +281,6 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 	}
 }
 
-static inline bool is_set_ckpt_flags(struct f2fs_checkpoint *cp, unsigned int f)
-{
-	unsigned int ckpt_flags = le32_to_cpu(cp->ckpt_flags);
-	return ckpt_flags & f ? 1 : 0;
-}
-
 static inline block_t __start_cp_addr(struct f2fs_sb_info *sbi)
 {
 	block_t start_addr = le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_blkaddr);
diff --git a/fsck/resize.c b/fsck/resize.c
index 143ad5d3c0a1..7fd272502660 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -13,7 +13,7 @@ static int get_new_sb(struct f2fs_super_block *sb)
 {
 	u_int32_t zone_size_bytes, zone_align_start_offset;
 	u_int32_t blocks_for_sit, blocks_for_nat, blocks_for_ssa;
-	u_int32_t sit_segments, diff, total_meta_segments;
+	u_int32_t sit_segments, nat_segments, diff, total_meta_segments;
 	u_int32_t total_valid_blks_available;
 	u_int32_t sit_bitmap_size, max_sit_bitmap_size;
 	u_int32_t max_nat_bitmap_size, max_nat_segments;
@@ -47,7 +47,18 @@ static int get_new_sb(struct f2fs_super_block *sb)
 			get_sb(segment_count_sit))) * blks_per_seg;
 	blocks_for_nat = SIZE_ALIGN(total_valid_blks_available,
 					NAT_ENTRY_PER_BLOCK);
-	set_sb(segment_count_nat, SEG_ALIGN(blocks_for_nat));
+
+	if (c.large_nat_bitmap) {
+		nat_segments = SEG_ALIGN(blocks_for_nat) *
+						DEFAULT_NAT_ENTRY_RATIO / 100;
+		set_sb(segment_count_nat, nat_segments ? nat_segments : 1);
+
+		max_nat_bitmap_size = (get_sb(segment_count_nat) <<
+						get_sb(log_blocks_per_seg)) / 8;
+		set_sb(segment_count_nat, get_sb(segment_count_nat) * 2);
+	} else {
+		set_sb(segment_count_nat, SEG_ALIGN(blocks_for_nat));
+	}
 
 	sit_bitmap_size = ((get_sb(segment_count_sit) / 2) <<
 				get_sb(log_blocks_per_seg)) / 8;
@@ -56,26 +67,40 @@ static int get_new_sb(struct f2fs_super_block *sb)
 	else
 		max_sit_bitmap_size = sit_bitmap_size;
 
-	/*
-	 * It should be reserved minimum 1 segment for nat.
-	 * When sit is too large, we should expand cp area. It requires more pages for cp.
-	 */
-	if (max_sit_bitmap_size > MAX_SIT_BITMAP_SIZE_IN_CKPT) {
-		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1;
-		set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
+	if (c.large_nat_bitmap) {
+		/* use cp_payload if free space of f2fs_checkpoint is not enough */
+		if (max_sit_bitmap_size + max_nat_bitmap_size >
+						MAX_BITMAP_SIZE_IN_CKPT) {
+			u_int32_t diff =  max_sit_bitmap_size +
+						max_nat_bitmap_size -
+						MAX_BITMAP_SIZE_IN_CKPT;
+			set_sb(cp_payload, F2FS_BLK_ALIGN(diff));
+		} else {
+			set_sb(cp_payload, 0);
+		}
 	} else {
-		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
-			- max_sit_bitmap_size;
-		set_sb(cp_payload, 0);
-	}
+		/*
+		 * It should be reserved minimum 1 segment for nat.
+		 * When sit is too large, we should expand cp area.
+		 * It requires more pages for cp.
+		 */
+		if (max_sit_bitmap_size > MAX_SIT_BITMAP_SIZE_IN_CKPT) {
+			max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1;
+			set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
+		} else {
+			max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
+				- max_sit_bitmap_size;
+			set_sb(cp_payload, 0);
+		}
 
-	max_nat_segments = (max_nat_bitmap_size * 8) >>
+		max_nat_segments = (max_nat_bitmap_size * 8) >>
 					get_sb(log_blocks_per_seg);
 
-	if (get_sb(segment_count_nat) > max_nat_segments)
-		set_sb(segment_count_nat, max_nat_segments);
+		if (get_sb(segment_count_nat) > max_nat_segments)
+			set_sb(segment_count_nat, max_nat_segments);
 
-	set_sb(segment_count_nat, get_sb(segment_count_nat) * 2);
+		set_sb(segment_count_nat, get_sb(segment_count_nat) * 2);
+	}
 
 	set_sb(ssa_blkaddr, get_sb(nat_blkaddr) +
 				get_sb(segment_count_nat) * blks_per_seg);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 053ccbe2eaf6..548a3e85a1d5 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -362,6 +362,7 @@ struct f2fs_configuration {
 	int preen_mode;
 	int ro;
 	int preserve_limits;		/* preserve quota limits */
+	int large_nat_bitmap;
 	__le32 feature;			/* defined features */
 
 	/* defragmentation parameters */
@@ -614,6 +615,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_LARGE_NAT_BITMAP_FLAG	0x00000400
 #define CP_NOCRC_RECOVERY_FLAG	0x00000200
 #define CP_TRIMMED_FLAG		0x00000100
 #define CP_NAT_BITS_FLAG	0x00000080
@@ -659,8 +661,10 @@ struct f2fs_checkpoint {
 	unsigned char sit_nat_version_bitmap[1];
 } __attribute__((packed));
 
-#define MAX_SIT_BITMAP_SIZE_IN_CKPT	\
+#define MAX_SIT_BITMAP_SIZE_IN_CKPT    \
 	(CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1 - 64)
+#define MAX_BITMAP_SIZE_IN_CKPT	\
+	(CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1)
 
 /*
  * For orphan inode management
@@ -850,6 +854,8 @@ struct f2fs_node {
 #define NAT_ENTRY_PER_BLOCK (PAGE_CACHE_SIZE / sizeof(struct f2fs_nat_entry))
 #define NAT_BLOCK_OFFSET(start_nid) (start_nid / NAT_ENTRY_PER_BLOCK)
 
+#define DEFAULT_NAT_ENTRY_RATIO		20
+
 #ifdef ANDROID_WINDOWS_HOST
 #pragma pack(1)
 #endif
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index ffdbccb34627..e8b1842b7391 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -623,6 +623,7 @@ void f2fs_init_configuration(void)
 	c.ro = 0;
 	c.kd = -1;
 	c.dry_run = 0;
+	c.large_nat_bitmap = 0;
 	c.fixed_time = -1;
 }
 
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 0fc8b30296ef..93e9feaecda6 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -151,7 +151,7 @@ static int f2fs_prepare_super_block(void)
 	u_int32_t log_sectorsize, log_sectors_per_block;
 	u_int32_t log_blocksize, log_blks_per_seg;
 	u_int32_t segment_size_bytes, zone_size_bytes;
-	u_int32_t sit_segments;
+	u_int32_t sit_segments, nat_segments;
 	u_int32_t blocks_for_sit, blocks_for_nat, blocks_for_ssa;
 	u_int32_t total_valid_blks_available;
 	u_int64_t zone_align_start_offset, diff;
@@ -272,7 +272,17 @@ static int f2fs_prepare_super_block(void)
 	blocks_for_nat = SIZE_ALIGN(total_valid_blks_available,
 			NAT_ENTRY_PER_BLOCK);
 
-	set_sb(segment_count_nat, SEG_ALIGN(blocks_for_nat));
+	if (c.large_nat_bitmap) {
+		nat_segments = SEG_ALIGN(blocks_for_nat) *
+						DEFAULT_NAT_ENTRY_RATIO / 100;
+		set_sb(segment_count_nat, nat_segments ? nat_segments : 1);
+		max_nat_bitmap_size = (get_sb(segment_count_nat) <<
+						log_blks_per_seg) / 8;
+		set_sb(segment_count_nat, get_sb(segment_count_nat) * 2);
+	} else {
+		set_sb(segment_count_nat, SEG_ALIGN(blocks_for_nat));
+	}
+
 	/*
 	 * The number of node segments should not be exceeded a "Threshold".
 	 * This number resizes NAT bitmap area in a CP page.
@@ -286,28 +296,40 @@ static int f2fs_prepare_super_block(void)
 	else
 		max_sit_bitmap_size = sit_bitmap_size;
 
-	/*
-	 * It should be reserved minimum 1 segment for nat.
-	 * When sit is too large, we should expand cp area. It requires more
-	 * pages for cp.
-	 */
-	if (max_sit_bitmap_size > MAX_SIT_BITMAP_SIZE_IN_CKPT) {
-		max_nat_bitmap_size = CHECKSUM_OFFSET -
-				sizeof(struct f2fs_checkpoint) + 1;
-		set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
+	if (c.large_nat_bitmap) {
+		/* use cp_payload if free space of f2fs_checkpoint is not enough */
+		if (max_sit_bitmap_size + max_nat_bitmap_size >
+						MAX_BITMAP_SIZE_IN_CKPT) {
+			u_int32_t diff =  max_sit_bitmap_size +
+						max_nat_bitmap_size -
+						MAX_BITMAP_SIZE_IN_CKPT;
+			set_sb(cp_payload, F2FS_BLK_ALIGN(diff));
+		} else {
+			set_sb(cp_payload, 0);
+		}
 	} else {
-		max_nat_bitmap_size =
-			CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
-			- max_sit_bitmap_size;
-		set_sb(cp_payload, 0);
-	}
-
-	max_nat_segments = (max_nat_bitmap_size * 8) >> log_blks_per_seg;
+		/*
+		 * It should be reserved minimum 1 segment for nat.
+		 * When sit is too large, we should expand cp area.
+		 * It requires more pages for cp.
+		 */
+		if (max_sit_bitmap_size > MAX_SIT_BITMAP_SIZE_IN_CKPT) {
+			max_nat_bitmap_size = CHECKSUM_OFFSET -
+					sizeof(struct f2fs_checkpoint) + 1;
+			set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
+	        } else {
+			max_nat_bitmap_size =
+				CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
+				- max_sit_bitmap_size;
+			set_sb(cp_payload, 0);
+		}
+		max_nat_segments = (max_nat_bitmap_size * 8) >> log_blks_per_seg;
 
-	if (get_sb(segment_count_nat) > max_nat_segments)
-		set_sb(segment_count_nat, max_nat_segments);
+		if (get_sb(segment_count_nat) > max_nat_segments)
+			set_sb(segment_count_nat, max_nat_segments);
 
-	set_sb(segment_count_nat, get_sb(segment_count_nat) * 2);
+		set_sb(segment_count_nat, get_sb(segment_count_nat) * 2);
+	}
 
 	set_sb(ssa_blkaddr, get_sb(nat_blkaddr) + get_sb(segment_count_nat) *
 			c.blks_per_seg);
@@ -623,6 +645,9 @@ static int f2fs_write_check_point_pack(void)
 	if (c.trimmed)
 		flags |= CP_TRIMMED_FLAG;
 
+	if (c.large_nat_bitmap)
+		flags |= CP_LARGE_NAT_BITMAP_FLAG;
+
 	set_cp(ckpt_flags, flags);
 	set_cp(cp_pack_start_sum, 1 + get_sb(cp_payload));
 	set_cp(valid_node_count, 1 + quota_inum);
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 8cbe6a21735a..94e2fa422acf 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -46,6 +46,7 @@ static void mkfs_usage()
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -e [extension list] e.g. \"mp3,gif,mov\"\n");
 	MSG(0, "  -f force overwrite the exist filesystem\n");
+	MSG(0, "  -i extended node bitmap, node ratio is 20%% by default\n");
 	MSG(0, "  -l label\n");
 	MSG(0, "  -m support zoned block device [default:0]\n");
 	MSG(0, "  -o overprovision ratio [default:5]\n");
@@ -102,7 +103,7 @@ static void parse_feature(const char *features)
 
 static void f2fs_parse_options(int argc, char *argv[])
 {
-	static const char *option_string = "qa:c:d:e:l:mo:O:s:S:z:t:f";
+	static const char *option_string = "qa:c:d:e:il:mo:O:s:S:z:t:f";
 	int32_t option=0;
 
 	while ((option = getopt(argc,argv,option_string)) != EOF) {
@@ -132,6 +133,9 @@ static void f2fs_parse_options(int argc, char *argv[])
 		case 'e':
 			c.extension_list = strdup(optarg);
 			break;
+		case 'i':
+			c.large_nat_bitmap = 1;
+			break;
 		case 'l':		/*v: volume label */
 			if (strlen(optarg) > 512) {
 				MSG(0, "Error: Volume Label should be less than "
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
