From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH 1/2] mkfs: use compact mode for data summaries
Date: Thu, 13 Nov 2014 20:15:04 +0900
Message-ID: <1415877305-4871-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch is for optimization related to format
 o reduce 2 blocks for data summaries
 o reduce initial mount time after mkfs.f2fs

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 mkfs/f2fs_format.c | 102 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 38 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index bf6ce00..0a9d728 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -446,6 +446,8 @@ static int f2fs_write_check_point_pack(void)
 	u_int32_t crc = 0;
 	unsigned int i;
 	char *cp_payload = NULL;
+	char *sum_buf, *sum_buf_ptr;
+	struct f2fs_summary *sum_entry;
 
 	ckp = calloc(F2FS_BLKSIZE, 1);
 	if (ckp == NULL) {
@@ -459,6 +461,13 @@ static int f2fs_write_check_point_pack(void)
 		return -1;
 	}
 
+	sum_buf = calloc(F2FS_BLKSIZE, 1);
+	if (sum == NULL) {
+		MSG(1, "\tError: Calloc Failed for summay buffer!!!\n");
+		return -1;
+	}
+	sum_buf_ptr = sum_buf;
+
 	cp_payload = calloc(F2FS_BLKSIZE, 1);
 	if (cp_payload == NULL) {
 		MSG(1, "\tError: Calloc Failed for cp_payload!!!\n");
@@ -503,9 +512,10 @@ static int f2fs_write_check_point_pack(void)
 			((le32_to_cpu(ckp->free_segment_count) + 6 -
 			le32_to_cpu(ckp->overprov_segment_count)) *
 			 config.blks_per_seg));
+	/* cp page (2), data summaries (1), node summaries (3) */
 	ckp->cp_pack_total_block_count =
-		cpu_to_le32(8 + le32_to_cpu(super_block.cp_payload));
-	ckp->ckpt_flags = cpu_to_le32(CP_UMOUNT_FLAG);
+		cpu_to_le32(6 + le32_to_cpu(super_block.cp_payload));
+	ckp->ckpt_flags = cpu_to_le32(CP_UMOUNT_FLAG | CP_COMPACT_SUM_FLAG);
 	ckp->cp_pack_start_sum = cpu_to_le32(1 + le32_to_cpu(super_block.cp_payload));
 	ckp->valid_node_count = cpu_to_le32(1);
 	ckp->valid_inode_count = cpu_to_le32(1);
@@ -544,35 +554,36 @@ static int f2fs_write_check_point_pack(void)
 		}
 	}
 
-	/* 2. Prepare and write Segment summary for data blocks */
+	/* Prepare and write Segment summary for HOT/WARM/COLD DATA
+	 *
+	 * The structure of compact summary
+	 * +-------------------+
+	 * | nat_journal       |
+	 * +-------------------+
+	 * | sit_journal       |
+	 * +-------------------+
+	 * | hot data summary  |
+	 * +-------------------+
+	 * | warm data summary |
+	 * +-------------------+
+	 * | cold data summary |
+	 * +-------------------+
+	*/
 	memset(sum, 0, sizeof(struct f2fs_summary_block));
 	SET_SUM_TYPE((&sum->footer), SUM_TYPE_DATA);
 
-	sum->entries[0].nid = super_block.root_ino;
-	sum->entries[0].ofs_in_node = 0;
-
-	cp_seg_blk_offset += blk_size_bytes;
-	DBG(1, "\tWriting segment summary for data, ckp at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
-	if (dev_write(sum, cp_seg_blk_offset, blk_size_bytes)) {
-		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
-		return -1;
-	}
-
-	/* 3. Fill segment summary for data block to zero. */
-	memset(sum, 0, sizeof(struct f2fs_summary_block));
-	SET_SUM_TYPE((&sum->footer), SUM_TYPE_DATA);
+	sum->n_nats = cpu_to_le16(1);
+	sum->nat_j.entries[0].nid = super_block.root_ino;
+	sum->nat_j.entries[0].ne.version = 0;
+	sum->nat_j.entries[0].ne.ino = super_block.root_ino;
+	sum->nat_j.entries[0].ne.block_addr = cpu_to_le32(
+			le32_to_cpu(super_block.main_blkaddr) +
+			ckp->cur_node_segno[0] * config.blks_per_seg);
 
-	cp_seg_blk_offset += blk_size_bytes;
-	DBG(1, "\tWriting segment summary, ckp at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
-	if (dev_write(sum, cp_seg_blk_offset, blk_size_bytes)) {
-		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
-		return -1;
-	}
+	memcpy(sum_buf_ptr, &sum->n_nats, SUM_JOURNAL_SIZE);
+	sum_buf_ptr += SUM_JOURNAL_SIZE;
 
-	/* 4. Fill segment summary for data block to zero. */
 	memset(sum, 0, sizeof(struct f2fs_summary_block));
-	SET_SUM_TYPE((&sum->footer), SUM_TYPE_DATA);
-
 	/* inode sit for root */
 	sum->n_sits = cpu_to_le16(6);
 	sum->sit_j.entries[0].segno = ckp->cur_node_segno[0];
@@ -592,14 +603,25 @@ static int f2fs_write_check_point_pack(void)
 	sum->sit_j.entries[5].segno = ckp->cur_data_segno[2];
 	sum->sit_j.entries[5].se.vblocks = cpu_to_le16((CURSEG_COLD_DATA << 10));
 
+	memcpy(sum_buf_ptr, &sum->n_sits, SUM_JOURNAL_SIZE);
+	sum_buf_ptr += SUM_JOURNAL_SIZE;
+
+	/* hot data summary */
+	sum_entry = (struct f2fs_summary *)sum_buf_ptr;
+	sum_entry->nid = super_block.root_ino;
+	sum_entry->ofs_in_node = 0;
+	/* warm data summary, nothing to do */
+	/* cold data summary, nothing to do */
+
 	cp_seg_blk_offset += blk_size_bytes;
-	DBG(1, "\tWriting data sit for root, at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
-	if (dev_write(sum, cp_seg_blk_offset, blk_size_bytes)) {
+	DBG(1, "\tWriting Segment summary for HOT/WARM/COLD_DATA, at offset 0x%08"PRIx64"\n",
+			cp_seg_blk_offset);
+	if (dev_write(sum_buf, cp_seg_blk_offset, blk_size_bytes)) {
 		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
 		return -1;
 	}
 
-	/* 5. Prepare and write Segment summary for node blocks */
+	/* Prepare and write Segment summary for HOT_NODE */
 	memset(sum, 0, sizeof(struct f2fs_summary_block));
 	SET_SUM_TYPE((&sum->footer), SUM_TYPE_NODE);
 
@@ -607,34 +629,37 @@ static int f2fs_write_check_point_pack(void)
 	sum->entries[0].ofs_in_node = 0;
 
 	cp_seg_blk_offset += blk_size_bytes;
-	DBG(1, "\tWriting Segment summary for node blocks, at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
+	DBG(1, "\tWriting Segment summary for HOT_NODE, at offset 0x%08"PRIx64"\n",
+			cp_seg_blk_offset);
 	if (dev_write(sum, cp_seg_blk_offset, blk_size_bytes)) {
 		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
 		return -1;
 	}
 
-	/* 6. Fill segment summary for data block to zero. */
+	/* Fill segment summary for WARM_NODE to zero. */
 	memset(sum, 0, sizeof(struct f2fs_summary_block));
 	SET_SUM_TYPE((&sum->footer), SUM_TYPE_NODE);
 
 	cp_seg_blk_offset += blk_size_bytes;
-	DBG(1, "\tWriting Segment summary for data block (1/2), at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
+	DBG(1, "\tWriting Segment summary for WARM_NODE, at offset 0x%08"PRIx64"\n",
+			cp_seg_blk_offset);
 	if (dev_write(sum, cp_seg_blk_offset, blk_size_bytes)) {
 		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
 		return -1;
 	}
 
-	/* 7. Fill segment summary for data block to zero. */
+	/* Fill segment summary for COLD_NODE to zero. */
 	memset(sum, 0, sizeof(struct f2fs_summary_block));
 	SET_SUM_TYPE((&sum->footer), SUM_TYPE_NODE);
 	cp_seg_blk_offset += blk_size_bytes;
-	DBG(1, "\tWriting Segment summary for data block (2/2), at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
+	DBG(1, "\tWriting Segment summary for COLD_NODE, at offset 0x%08"PRIx64"\n",
+			cp_seg_blk_offset);
 	if (dev_write(sum, cp_seg_blk_offset, blk_size_bytes)) {
 		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
 		return -1;
 	}
 
-	/* 8. cp page2 */
+	/* cp page2 */
 	cp_seg_blk_offset += blk_size_bytes;
 	DBG(1, "\tWriting cp page2, at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
 	if (dev_write(ckp, cp_seg_blk_offset, blk_size_bytes)) {
@@ -642,7 +667,7 @@ static int f2fs_write_check_point_pack(void)
 		return -1;
 	}
 
-	/* 9. cp page 1 of check point pack 2
+	/* cp page 1 of check point pack 2
 	 * Initiatialize other checkpoint pack with version zero
 	 */
 	ckp->checkpoint_ver = 0;
@@ -668,7 +693,7 @@ static int f2fs_write_check_point_pack(void)
 		}
 	}
 
-	/* 10. cp page 2 of check point pack 2 */
+	/* cp page 2 of check point pack 2 */
 	cp_seg_blk_offset += blk_size_bytes * (le32_to_cpu(ckp->cp_pack_total_block_count)
 			- le32_to_cpu(super_block.cp_payload) - 1);
 	DBG(1, "\tWriting cp page 2 of checkpoint pack 2, at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
@@ -677,8 +702,9 @@ static int f2fs_write_check_point_pack(void)
 		return -1;
 	}
 
-	free(sum) ;
-	free(ckp) ;
+	free(sum_buf);
+	free(sum);
+	free(ckp);
 	free(cp_payload);
 	return	0;
 }
-- 
1.9.1

