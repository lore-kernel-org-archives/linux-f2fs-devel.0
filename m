From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH] fsck.f2fs: supply more check entries for
 checkpoint
Date: Fri, 3 Aug 2018 12:09:05 +0800
Message-ID: <20180803040905.238176-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1flRP1-0003LO-DP
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Aug 2018 04:09:23 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1flROz-007OWV-17
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Aug 2018 04:09:23 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Supply some more check entries for checkpoint in sanity_check_ckpt()
and validate_checkpoint() to sync them with kernel.

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 fsck/mount.c      | 69 +++++++++++++++++++++++++++++++++++++++++++++--
 include/f2fs_fs.h |  1 +
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 8fb4d59..2c2473d 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -747,6 +747,9 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
 	if (f2fs_crc_valid(crc, cp, crc_offset))
 		goto invalid_cp1;
 
+	if (get_cp(cp_pack_total_block_count) > sbi->blocks_per_seg)
+		goto invalid_cp1;
+
 	pre_version = get_cp(checkpoint_ver);
 
 	/* Read the 2nd cp block in this CP pack */
@@ -867,17 +870,79 @@ int sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	unsigned int total, fsmeta;
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
+	unsigned int ovp_segments, reserved_segments;
+	unsigned int main_segs, blocks_per_seg;
+	unsigned int sit_segs, nat_segs;
+	unsigned int sit_bitmap_size, nat_bitmap_size;
+	unsigned int log_blocks_per_seg;
+	unsigned int segment_count_main;
+	unsigned int cp_pack_start_sum, cp_payload;
+	block_t user_block_count;
+	int i;
 
 	total = get_sb(segment_count);
 	fsmeta = get_sb(segment_count_ckpt);
-	fsmeta += get_sb(segment_count_sit);
-	fsmeta += get_sb(segment_count_nat);
+	sit_segs = get_sb(segment_count_sit);
+	fsmeta += sit_segs;
+	nat_segs = get_sb(segment_count_nat);
+	fsmeta += nat_segs;
 	fsmeta += get_cp(rsvd_segment_count);
 	fsmeta += get_sb(segment_count_ssa);
 
 	if (fsmeta >= total)
 		return 1;
 
+	ovp_segments = get_cp(overprov_segment_count);
+	reserved_segments = get_cp(rsvd_segment_count);
+
+	if (fsmeta < F2FS_MIN_SEGMENT || ovp_segments == 0 ||
+					reserved_segments == 0) {
+		MSG(0, "\tWrong layout: check mkfs.f2fs version\n");
+		return 1;
+	}
+
+	user_block_count = get_cp(user_block_count);
+	segment_count_main = get_sb(segment_count_main);
+	log_blocks_per_seg = get_sb(log_blocks_per_seg);
+	if (!user_block_count || user_block_count >=
+			segment_count_main << log_blocks_per_seg) {
+		MSG(0, "\tWrong user_block_count(%u)\n", user_block_count);
+		return 1;
+	}
+
+	main_segs = get_sb(segment_count_main);
+	blocks_per_seg = sbi->blocks_per_seg;
+
+	for (i = 0; i < NR_CURSEG_NODE_TYPE; i++) {
+		if (get_cp(cur_node_segno[i]) >= main_segs ||
+			get_cp(cur_node_blkoff[i]) >= blocks_per_seg)
+			return 1;
+	}
+	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
+		if (get_cp(cur_data_segno[i]) >= main_segs ||
+			get_cp(cur_data_blkoff[i]) >= blocks_per_seg)
+			return 1;
+	}
+
+	sit_bitmap_size = get_cp(sit_ver_bitmap_bytesize);
+	nat_bitmap_size = get_cp(nat_ver_bitmap_bytesize);
+
+	if (sit_bitmap_size != ((sit_segs / 2) << log_blocks_per_seg) / 8 ||
+		nat_bitmap_size != ((nat_segs / 2) << log_blocks_per_seg) / 8) {
+		MSG(0, "\tWrong bitmap size: sit(%u), nat(%u)\n",
+				sit_bitmap_size, nat_bitmap_size);
+		return 1;
+	}
+
+	cp_pack_start_sum = __start_sum_addr(sbi);
+	cp_payload = get_sb(cp_payload);
+	if (cp_pack_start_sum < cp_payload + 1 ||
+		cp_pack_start_sum > blocks_per_seg - 1 -
+			NR_CURSEG_TYPE) {
+		MSG(0, "\tWrong cp_pack_start_sum(%u)\n", cp_pack_start_sum);
+		return 1;
+	}
+
 	return 0;
 }
 
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 53fa002..2c086a9 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -888,6 +888,7 @@ struct f2fs_nat_block {
  * F2FS uses 4 bytes to represent block address. As a result, supported size of
  * disk is 16 TB and it equals to 16 * 1024 * 1024 / 2 segments.
  */
+#define F2FS_MIN_SEGMENT      9 /* SB + 2 (CP + SIT + NAT) + SSA + MAIN */
 #define F2FS_MAX_SEGMENT       ((16 * 1024 * 1024) / 2)
 #define MAX_SIT_BITMAP_SIZE    (SEG_ALIGN(SIZE_ALIGN(F2FS_MAX_SEGMENT, \
 						SIT_ENTRY_PER_BLOCK)) * \
-- 
2.18.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
