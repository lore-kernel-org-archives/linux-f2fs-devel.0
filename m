From: "Gaoxiang (OS)" <gaoxiang25@huawei.com>
Subject: [PATCH RFC 2/2] mkfs.f2fs: binary decision to calculate
 SIT/NAT/SSA
Date: Tue, 9 Jan 2018 08:01:22 +0000
Message-ID: <9047C53C18267742AB12E43B65C7F9F70BCC621D@dggemi505-mbs.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <gaoxiang25@huawei.com>) id 1eYorz-0002k2-NM
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jan 2018 08:02:51 +0000
Received: from [45.249.212.255] (helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eYors-0005hV-PD
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jan 2018 08:02:51 +0000
Content-Language: zh-CN
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, "chao@kernel.org" <chao@kernel.org>
Cc: heyunlei <heyunlei@huawei.com>, "Duwei (Device OS)" <weidu.du@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Use binary decision approach to calculate SIT/NAT/SSA segments
it has some benefits when the partition size >= 512G.

                        (bsearch)
psize   main_segments   main_seaments
...
512G    261507          261508
 1 T    523139          523141
 2 T    1046403         1046407
 4 T    2092781         2092789
...

It also clarify that SIT/NAT/SSA are used for main segment area only.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 mkfs/f2fs_format.c | 114 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 82 insertions(+), 32 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 49dd93c..e01cb37 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -145,20 +145,82 @@ static void verify_cur_segs(void)
 		c.cur_seg[i] = next_zone(i - 1);
 }
 
+static u_int32_t get_best_main_zones(void)
+{
+	u_int32_t total_zones = get_sb(segment_count) / (c.segs_per_zone);
+	u_int32_t left = 1, right = total_zones - 1;
+	u_int32_t candicate = 0;
+
+	while (left <= right) {
+		u_int32_t blocks_for_nat;
+		u_int32_t sit_segments, nat_segments, ssa_segments;
+		u_int32_t meta_segments, meta_zones;
+		u_int32_t max_sit_bitmap_size, max_nat_bitmap_size;
+
+		u_int32_t main_zones = (left + right) / 2;
+		u_int32_t main_segments = c.segs_per_zone * main_zones;
+
+		sit_segments = SEG_ALIGN(SIZE_ALIGN(main_segments,
+			SIT_ENTRY_PER_BLOCK) /* blocks_for_sit */);
+
+		blocks_for_nat = SIZE_ALIGN(main_segments * c.blks_per_seg,
+				NAT_ENTRY_PER_BLOCK);
+
+		nat_segments = SEG_ALIGN(blocks_for_nat);
+
+		max_sit_bitmap_size = min((u_int32_t)MAX_SIT_BITMAP_SIZE,
+			sit_segments * c.blks_per_seg / 8);
+
+		/*
+		 * it's weird because for 1TB storage, payload is still not
+		 * used and max_nat_bitmap_blks is only 21472, which means
+		 * the total number of nodes is 21472 * 409 = 8782048
+		 */
+		if (max_sit_bitmap_size > MAX_SIT_BITMAP_SIZE_IN_CKPT)
+			max_nat_bitmap_size = CHECKSUM_OFFSET -
+					sizeof(struct f2fs_checkpoint) + 1;
+		else
+			max_nat_bitmap_size =
+				CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
+				- max_sit_bitmap_size;
+
+		nat_segments = min(SEG_ALIGN(blocks_for_nat),
+			SEG_ALIGN(max_nat_bitmap_size * 8));
+
+		/* each main segment has a ssa block */
+		ssa_segments = SEG_ALIGN(main_segments);
+
+		meta_segments = (get_sb(segment_count_ckpt) +
+			sit_segments * 2 + nat_segments * 2 +
+			ssa_segments);
+
+		meta_zones = ZONE_ALIGN(meta_segments * c.blks_per_seg);
+
+		if (meta_zones + main_zones == total_zones)
+			return main_zones;
+
+		if (meta_zones + main_zones < total_zones) {
+			left = main_zones + 1;
+			candicate = main_zones;
+		} else
+			right = main_zones - 1;
+	}
+
+	return candicate;
+}
+
 static int f2fs_prepare_super_block(void)
 {
 	u_int32_t blk_size_bytes;
 	u_int32_t log_sectorsize, log_sectors_per_block;
 	u_int32_t log_blocksize, log_blks_per_seg;
 	u_int32_t segment_size_bytes, zone_size_bytes;
-	u_int32_t sit_segments;
-	u_int32_t blocks_for_sit, blocks_for_nat, blocks_for_ssa;
-	u_int32_t total_valid_blks_available;
+	u_int32_t blocks_for_sit, blocks_for_nat;
 	u_int64_t zone_align_start_offset, diff;
 	u_int64_t total_meta_zones, total_meta_segments;
 	u_int32_t sit_bitmap_size, max_sit_bitmap_size;
 	u_int32_t max_nat_bitmap_size, max_nat_segments;
-	u_int32_t total_zones;
+	u_int32_t main_zones, main_segments;
 	u_int32_t next_ino;
 	enum quota_type qtype;
 	int i;
@@ -256,22 +318,18 @@ static int f2fs_prepare_super_block(void)
 	set_sb(sit_blkaddr, get_sb(segment0_blkaddr) +
 			get_sb(segment_count_ckpt) * c.blks_per_seg);
 
-	blocks_for_sit = SIZE_ALIGN(get_sb(segment_count), SIT_ENTRY_PER_BLOCK);
+	/* try to do binary decision to get main_zones */
+	main_zones = get_best_main_zones();
+	main_segments = c.segs_per_zone * main_zones;
 
-	sit_segments = SEG_ALIGN(blocks_for_sit);
-
-	set_sb(segment_count_sit, sit_segments * 2);
+	blocks_for_sit = SIZE_ALIGN(main_segments, SIT_ENTRY_PER_BLOCK);
+	set_sb(segment_count_sit, SEG_ALIGN(blocks_for_sit) * 2);
 
 	set_sb(nat_blkaddr, get_sb(sit_blkaddr) + get_sb(segment_count_sit) *
 			c.blks_per_seg);
 
-	total_valid_blks_available = (get_sb(segment_count) -
-			(get_sb(segment_count_ckpt) +
-			get_sb(segment_count_sit))) * c.blks_per_seg;
-
-	blocks_for_nat = SIZE_ALIGN(total_valid_blks_available,
+	blocks_for_nat = SIZE_ALIGN(main_segments * c.blks_per_seg,
 			NAT_ENTRY_PER_BLOCK);
-
 	set_sb(segment_count_nat, SEG_ALIGN(blocks_for_nat));
 	/*
 	 * The number of node segments should not be exceeded a "Threshold".
@@ -312,16 +370,8 @@ static int f2fs_prepare_super_block(void)
 	set_sb(ssa_blkaddr, get_sb(nat_blkaddr) + get_sb(segment_count_nat) *
 			c.blks_per_seg);
 
-	total_valid_blks_available = (get_sb(segment_count) -
-			(get_sb(segment_count_ckpt) +
-			get_sb(segment_count_sit) +
-			get_sb(segment_count_nat))) *
-			c.blks_per_seg;
 
-	blocks_for_ssa = total_valid_blks_available /
-				c.blks_per_seg + 1;
-
-	set_sb(segment_count_ssa, SEG_ALIGN(blocks_for_ssa));
+	set_sb(segment_count_ssa, SEG_ALIGN(main_segments));
 
 	total_meta_segments = get_sb(segment_count_ckpt) +
 		get_sb(segment_count_sit) +
@@ -354,10 +404,7 @@ static int f2fs_prepare_super_block(void)
 		}
 	}
 
-	total_zones = get_sb(segment_count) / (c.segs_per_zone) -
-							total_meta_zones;
-
-	set_sb(section_count, total_zones * c.secs_per_zone);
+	set_sb(section_count, main_zones * c.secs_per_zone);
 
 	set_sb(segment_count_main, get_sb(section_count) * c.segs_per_sec);
 
@@ -373,6 +420,9 @@ static int f2fs_prepare_super_block(void)
 		return -1;
 	}
 
+	ASSERT((total_meta_zones + main_zones) * c.segs_per_zone
+		== get_sb(segment_count));
+
 	c.reserved_segments =
 			(2 * (100 / c.overprovision + 1) + 6)
 			* c.segs_per_sec;
@@ -404,15 +454,15 @@ static int f2fs_prepare_super_block(void)
 					qtype, next_ino - 1);
 	}
 
-	if (total_zones <= 6) {
+	if (main_zones <= 6) {
 		MSG(1, "\tError: %d zones: Need more zones "
-			"by shrinking zone size\n", total_zones);
+			"by shrinking zone size\n", main_zones);
 		return -1;
 	}
 
 	if (c.heap) {
 		c.cur_seg[CURSEG_HOT_NODE] =
-				last_section(last_zone(total_zones));
+				last_section(last_zone(main_zones));
 		c.cur_seg[CURSEG_WARM_NODE] = prev_zone(CURSEG_HOT_NODE);
 		c.cur_seg[CURSEG_COLD_NODE] = prev_zone(CURSEG_WARM_NODE);
 		c.cur_seg[CURSEG_HOT_DATA] = prev_zone(CURSEG_COLD_NODE);
@@ -424,10 +474,10 @@ static int f2fs_prepare_super_block(void)
 		c.cur_seg[CURSEG_COLD_NODE] = next_zone(CURSEG_WARM_NODE);
 		c.cur_seg[CURSEG_HOT_DATA] = next_zone(CURSEG_COLD_NODE);
 		c.cur_seg[CURSEG_COLD_DATA] =
-				max(last_zone((total_zones >> 2)),
+				max(last_zone((main_zones >> 2)),
 					next_zone(CURSEG_COLD_NODE));
 		c.cur_seg[CURSEG_WARM_DATA] =
-				max(last_zone((total_zones >> 1)),
+				max(last_zone((main_zones >> 1)),
 					next_zone(CURSEG_COLD_DATA));
 	}
 
-- 
2.1.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
