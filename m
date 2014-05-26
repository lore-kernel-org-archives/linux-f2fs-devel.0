From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH 1/2 V3] mkfs.f2fs: large volume support
Date: Tue, 27 May 2014 08:38:52 +0900
Message-ID: <20140526233852.GA30978@cm224.lee>
References: <1399877875-2561-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1Wp4VI-00087f-Vc
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 May 2014 23:40:28 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Wp4VG-0002XN-Ln
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 May 2014 23:40:28 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N6700C1QGF7NK70@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 May 2014 08:40:19 +0900 (KST)
Received: from localhost ([12.36.79.189])
	by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
	(7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTPA id <0N6700BQPGF6T920@mmp2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 27 May 2014 08:40:18 +0900 (KST)
Content-disposition: inline
In-reply-to: <1399877875-2561-1-git-send-email-cm224.lee@samsung.com>
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


Changes from V2
 o remove CP_LARGE_VOL_LFLAG instead, use cp_payload in superblock
 because disk size is determined at format

Changes from V1
 o fix orphan node blkaddr

-- >8 --

>From 7e5e66699bb383e4fa7ce970e1cc8e10eb0a5c6f Mon Sep 17 00:00:00 2001
From: root <root@f2fs-00.(none)>
Date: Mon, 12 May 2014 22:01:38 +0900
Subject: [PATCH 1/2] mkfs.f2fs: large volume support

This patch supports large volume over about 3TB.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 include/f2fs_fs.h  |    9 +++++++
 mkfs/f2fs_format.c |   68 +++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 94d8dc3..3003f7f 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -223,6 +223,7 @@ enum {
 #define F2FS_LOG_SECTORS_PER_BLOCK	3	/* 4KB: F2FS_BLKSIZE */
 #define F2FS_BLKSIZE			4096	/* support only 4KB block */
 #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
+#define F2FS_BLK_ALIGN(x)	(((x) + F2FS_BLKSIZE - 1) / F2FS_BLKSIZE)
 
 #define NULL_ADDR		0x0U
 #define NEW_ADDR		-1U
@@ -279,6 +280,7 @@ struct f2fs_super_block {
 	__le16 volume_name[512];	/* volume name */
 	__le32 extension_count;		/* # of extensions below */
 	__u8 extension_list[F2FS_MAX_EXTENSION][8];	/* extension array */
+	__le32 cp_payload;
 } __attribute__((packed));
 
 /*
@@ -457,6 +459,13 @@ struct f2fs_nat_block {
 #define SIT_ENTRY_PER_BLOCK (PAGE_CACHE_SIZE / sizeof(struct f2fs_sit_entry))
 
 /*
+ * F2FS uses 4 bytes to represent block address. As a result, supported size of
+ * disk is 16 TB and it equals to 16 * 1024 * 1024 / 2 segments.
+ */
+#define F2FS_MAX_SEGMENT       ((16 * 1024 * 1024) / 2)
+#define MAX_SIT_BITMAP_SIZE    ((F2FS_MAX_SEGMENT / SIT_ENTRY_PER_BLOCK) / 8)
+
+/*
  * Note that f2fs_sit_entry->vblocks has the following bit-field information.
  * [15:10] : allocation type such as CURSEG_XXXX_TYPE
  * [9:0] : valid block count
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index cdbf74a..58550a2 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -102,7 +102,8 @@ static int f2fs_prepare_super_block(void)
 	u_int32_t blocks_for_sit, blocks_for_nat, blocks_for_ssa;
 	u_int32_t total_valid_blks_available;
 	u_int64_t zone_align_start_offset, diff, total_meta_segments;
-	u_int32_t sit_bitmap_size, max_nat_bitmap_size, max_nat_segments;
+	u_int32_t sit_bitmap_size, max_sit_bitmap_size;
+	u_int32_t max_nat_bitmap_size, max_nat_segments;
 	u_int32_t total_zones;
 
 	super_block.magic = cpu_to_le32(F2FS_SUPER_MAGIC);
@@ -217,8 +218,25 @@ static int f2fs_prepare_super_block(void)
 	 */
 	sit_bitmap_size = ((le32_to_cpu(super_block.segment_count_sit) / 2) <<
 				log_blks_per_seg) / 8;
-	max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1 -
-			sit_bitmap_size;
+
+	if (sit_bitmap_size > MAX_SIT_BITMAP_SIZE)
+		max_sit_bitmap_size = MAX_SIT_BITMAP_SIZE;
+	else
+		max_sit_bitmap_size = sit_bitmap_size;
+
+	/*
+	 * It should be reserved minimum 1 segment for nat.
+	 * When sit is too large, we should expand cp area. It requires more pages for cp.
+	 */
+	if (max_sit_bitmap_size >
+			(CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 65)) {
+		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1;
+		super_block.cp_payload = F2FS_BLK_ALIGN(max_sit_bitmap_size);
+	} else {
+		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1 - max_sit_bitmap_size;
+		super_block.cp_payload = 0;
+	}
+
 	max_nat_segments = (max_nat_bitmap_size * 8) >> log_blks_per_seg;
 
 	if (le32_to_cpu(super_block.segment_count_nat) > max_nat_segments)
@@ -434,6 +452,7 @@ static int f2fs_write_check_point_pack(void)
 	u_int64_t cp_seg_blk_offset = 0;
 	u_int32_t crc = 0;
 	int i;
+	char *cp_payload = NULL;
 
 	ckp = calloc(F2FS_BLKSIZE, 1);
 	if (ckp == NULL) {
@@ -447,6 +466,12 @@ static int f2fs_write_check_point_pack(void)
 		return -1;
 	}
 
+	cp_payload = calloc(F2FS_BLKSIZE, 1);
+	if (cp_payload == NULL) {
+		MSG(1, "\tError: Calloc Failed for cp_payload!!!\n");
+		return -1;
+	}
+
 	/* 1. cp page 1 of checkpoint pack 1 */
 	ckp->checkpoint_ver = cpu_to_le64(1);
 	ckp->cur_node_segno[0] =
@@ -485,9 +510,11 @@ static int f2fs_write_check_point_pack(void)
 			((le32_to_cpu(ckp->free_segment_count) + 6 -
 			le32_to_cpu(ckp->overprov_segment_count)) *
 			 config.blks_per_seg));
-	ckp->cp_pack_total_block_count = cpu_to_le32(8);
+	ckp->cp_pack_total_block_count =
+		cpu_to_le32(8 + le32_to_cpu(super_block.cp_payload));
 	ckp->ckpt_flags = cpu_to_le32(CP_UMOUNT_FLAG);
-	ckp->cp_pack_start_sum = cpu_to_le32(1);
+	ckp->cp_pack_start_sum = cpu_to_le32(1 +
+			le32_to_cpu(super_block.cp_payload));
 	ckp->valid_node_count = cpu_to_le32(1);
 	ckp->valid_inode_count = cpu_to_le32(1);
 	ckp->next_free_nid = cpu_to_le32(0xc00000);
@@ -511,11 +538,20 @@ static int f2fs_write_check_point_pack(void)
 	cp_seg_blk_offset *= blk_size_bytes;
 
 	DBG(1, "\tWriting main segments, ckp at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
-	if (dev_write(ckp, cp_seg_blk_offset, F2FS_BLKSIZE)) {
+	if (dev_write(ckp, cp_seg_blk_offset, blk_size_bytes)) {
 		MSG(1, "\tError: While writing the ckp to disk!!!\n");
 		return -1;
 	}
 
+	for (i = 0; i < le32_to_cpu(super_block.cp_payload); i++) {
+		cp_seg_blk_offset += blk_size_bytes;
+		if (dev_fill(cp_payload, cp_seg_blk_offset, blk_size_bytes)) {
+			MSG(1, "\tError: While zeroing out the sit bitmap area \
+					on disk!!!\n");
+			return -1;
+		}
+	}
+
 	/* 2. Prepare and write Segment summary for data blocks */
 	memset(sum, 0, sizeof(struct f2fs_summary_block));
 	SET_SUM_TYPE((&sum->footer), SUM_TYPE_DATA);
@@ -525,7 +561,7 @@ static int f2fs_write_check_point_pack(void)
 
 	cp_seg_blk_offset += blk_size_bytes;
 	DBG(1, "\tWriting segment summary for data, ckp at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
-	if (dev_write(sum, cp_seg_blk_offset, F2FS_BLKSIZE)) {
+	if (dev_write(sum, cp_seg_blk_offset, blk_size_bytes)) {
 		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
 		return -1;
 	}
@@ -609,7 +645,7 @@ static int f2fs_write_check_point_pack(void)
 	/* 8. cp page2 */
 	cp_seg_blk_offset += blk_size_bytes;
 	DBG(1, "\tWriting cp page2, at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
-	if (dev_write(ckp, cp_seg_blk_offset, F2FS_BLKSIZE)) {
+	if (dev_write(ckp, cp_seg_blk_offset, blk_size_bytes)) {
 		MSG(1, "\tError: While writing the ckp to disk!!!\n");
 		return -1;
 	}
@@ -626,21 +662,31 @@ static int f2fs_write_check_point_pack(void)
 				config.blks_per_seg) *
 				blk_size_bytes;
 	DBG(1, "\tWriting cp page 1 of checkpoint pack 2, at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
-	if (dev_write(ckp, cp_seg_blk_offset, F2FS_BLKSIZE)) {
+	if (dev_write(ckp, cp_seg_blk_offset, blk_size_bytes)) {
 		MSG(1, "\tError: While writing the ckp to disk!!!\n");
 		return -1;
 	}
 
+	for (i = 0; i < le32_to_cpu(super_block.cp_payload); i++) {
+		cp_seg_blk_offset += blk_size_bytes;
+		if (dev_fill(cp_payload, cp_seg_blk_offset, blk_size_bytes)) {
+			MSG(1, "\tError: While zeroing out the sit bitmap area \
+					on disk!!!\n");
+			return -1;
+		}
+	}
+
 	/* 10. cp page 2 of check point pack 2 */
-	cp_seg_blk_offset += blk_size_bytes * (le32_to_cpu(ckp->cp_pack_total_block_count) - 1);
+	cp_seg_blk_offset += blk_size_bytes * (le32_to_cpu(ckp->cp_pack_total_block_count) - le32_to_cpu(super_block.cp_payload) - 1);
 	DBG(1, "\tWriting cp page 2 of checkpoint pack 2, at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
-	if (dev_write(ckp, cp_seg_blk_offset, F2FS_BLKSIZE)) {
+	if (dev_write(ckp, cp_seg_blk_offset, blk_size_bytes)) {
 		MSG(1, "\tError: While writing the ckp to disk!!!\n");
 		return -1;
 	}
 
 	free(sum) ;
 	free(ckp) ;
+	free(cp_payload);
 	return	0;
 }
 
-- 
1.7.10.4


------------------------------------------------------------------------------
The best possible search technologies are now affordable for all companies.
Download your FREE open source Enterprise Search Engine today!
Our experts will assist you in its installation for $59/mo, no commitment.
Test it for FREE on our Cloud platform anytime!
http://pubads.g.doubleclick.net/gampad/clk?id=145328191&iu=/4140/ostg.clktrk
