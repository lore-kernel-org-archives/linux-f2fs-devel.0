From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH v2 2/7] mkfs.f2fs: introduce mkfs parameters
 in f2fs_configuration
Date: Fri, 23 Feb 2018 11:17:56 +0800
Message-ID: <20180223031801.231805-3-shengyong1@huawei.com>
References: <20180223031801.231805-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1ep3sb-0003b7-3Y
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Feb 2018 03:18:37 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ep3sW-00071e-Pg
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Feb 2018 03:18:37 +0000
In-Reply-To: <20180223031801.231805-1-shengyong1@huawei.com>
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
Cc: hyojun@google.com, miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Introduce new parameters in f2fs_configuration for mkfs:
  * next_free_nid: save the next free nid
  * quota_inum: save how many blocks are used for quota inodes
  * quota_dnum: save how many blocks are used for quota data

Use these parameters to avoid duplicated count of these values. And
discard obsolete dnodes after all inodes are created.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 include/f2fs_fs.h  |  5 ++++
 mkfs/f2fs_format.c | 85 ++++++++++++++++++++++++++----------------------------
 2 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 548a3e8..ca4522d 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -365,6 +365,11 @@ struct f2fs_configuration {
 	int large_nat_bitmap;
 	__le32 feature;			/* defined features */
 
+	/* mkfs parameters */
+	u_int32_t next_free_nid;
+	u_int32_t quota_inum;
+	u_int32_t quota_dnum;
+
 	/* defragmentation parameters */
 	int defrag_shrink;
 	u_int64_t defrag_start;
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 4fb429e..5eaeff4 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -159,7 +159,6 @@ static int f2fs_prepare_super_block(void)
 	u_int32_t sit_bitmap_size, max_sit_bitmap_size;
 	u_int32_t max_nat_bitmap_size, max_nat_segments;
 	u_int32_t total_zones;
-	u_int32_t next_ino;
 	enum quota_type qtype;
 	int i;
 
@@ -411,7 +410,7 @@ static int f2fs_prepare_super_block(void)
 	set_sb(node_ino, 1);
 	set_sb(meta_ino, 2);
 	set_sb(root_ino, 3);
-	next_ino = 4;
+	c.next_free_nid = 4;
 
 	if (c.feature & cpu_to_le32(F2FS_FEATURE_QUOTA_INO)) {
 		quotatype_bits = QUOTA_USR_BIT | QUOTA_GRP_BIT;
@@ -422,9 +421,9 @@ static int f2fs_prepare_super_block(void)
 	for (qtype = 0; qtype < F2FS_MAX_QUOTAS; qtype++) {
 		if (!((1 << qtype) & quotatype_bits))
 			continue;
-		sb->qf_ino[qtype] = cpu_to_le32(next_ino++);
+		sb->qf_ino[qtype] = cpu_to_le32(c.next_free_nid++);
 		MSG(0, "Info: add quota type = %u => %u\n",
-					qtype, next_ino - 1);
+					qtype, c.next_free_nid - 1);
 	}
 
 	if (total_zones <= 6) {
@@ -558,7 +557,6 @@ static int f2fs_write_check_point_pack(void)
 	char *sum_compact, *sum_compact_p;
 	struct f2fs_summary *sum_entry;
 	enum quota_type qtype;
-	u_int32_t quota_inum, quota_dnum;
 	int off;
 	int ret = -1;
 
@@ -610,16 +608,9 @@ static int f2fs_write_check_point_pack(void)
 		set_cp(cur_data_segno[i], 0xffffffff);
 	}
 
-	quota_inum = quota_dnum = 0;
-	for (qtype = 0; qtype < F2FS_MAX_QUOTAS; qtype++)
-		if (sb->qf_ino[qtype]) {
-			quota_inum++;
-			quota_dnum += QUOTA_DATA(qtype);
-		}
-
-	set_cp(cur_node_blkoff[0], 1 + quota_inum);
-	set_cp(cur_data_blkoff[0], 1 + quota_dnum);
-	set_cp(valid_block_count, 2 + quota_inum + quota_dnum);
+	set_cp(cur_node_blkoff[0], 1 + c.quota_inum);
+	set_cp(cur_data_blkoff[0], 1 + c.quota_dnum);
+	set_cp(valid_block_count, 2 + c.quota_inum + c.quota_dnum);
 	set_cp(rsvd_segment_count, c.reserved_segments);
 	set_cp(overprov_segment_count, (get_sb(segment_count_main) -
 			get_cp(rsvd_segment_count)) *
@@ -651,9 +642,9 @@ static int f2fs_write_check_point_pack(void)
 
 	set_cp(ckpt_flags, flags);
 	set_cp(cp_pack_start_sum, 1 + get_sb(cp_payload));
-	set_cp(valid_node_count, 1 + quota_inum);
-	set_cp(valid_inode_count, 1 + quota_inum);
-	set_cp(next_free_nid, get_sb(root_ino) + 1 + quota_inum);
+	set_cp(valid_node_count, 1 + c.quota_inum);
+	set_cp(valid_inode_count, 1 + c.quota_inum);
+	set_cp(next_free_nid, c.next_free_nid);
 	set_cp(sit_ver_bitmap_bytesize, ((get_sb(segment_count_sit) / 2) <<
 			get_sb(log_blocks_per_seg)) / 8);
 
@@ -711,7 +702,7 @@ static int f2fs_write_check_point_pack(void)
 	SET_SUM_TYPE((&sum->footer), SUM_TYPE_DATA);
 
 	journal = &sum->journal;
-	journal->n_nats = cpu_to_le16(1 + quota_inum);
+	journal->n_nats = cpu_to_le16(1 + c.quota_inum);
 	journal->nat_j.entries[0].nid = sb->root_ino;
 	journal->nat_j.entries[0].ne.version = 0;
 	journal->nat_j.entries[0].ne.ino = sb->root_ino;
@@ -741,9 +732,9 @@ static int f2fs_write_check_point_pack(void)
 	journal->sit_j.entries[0].segno = cp->cur_node_segno[0];
 	journal->sit_j.entries[0].se.vblocks =
 				cpu_to_le16((CURSEG_HOT_NODE << 10) |
-						(1 + quota_inum));
+						(1 + c.quota_inum));
 	f2fs_set_bit(0, (char *)journal->sit_j.entries[0].se.valid_map);
-	for (i = 1; i <= quota_inum; i++)
+	for (i = 1; i <= c.quota_inum; i++)
 		f2fs_set_bit(i, (char *)journal->sit_j.entries[0].se.valid_map);
 	journal->sit_j.entries[1].segno = cp->cur_node_segno[1];
 	journal->sit_j.entries[1].se.vblocks =
@@ -756,9 +747,9 @@ static int f2fs_write_check_point_pack(void)
 	journal->sit_j.entries[3].segno = cp->cur_data_segno[0];
 	journal->sit_j.entries[3].se.vblocks =
 				cpu_to_le16((CURSEG_HOT_DATA << 10) |
-						(1 + quota_dnum));
+						(1 + c.quota_dnum));
 	f2fs_set_bit(0, (char *)journal->sit_j.entries[3].se.valid_map);
-	for (i = 1; i <= quota_dnum; i++)
+	for (i = 1; i <= c.quota_dnum; i++)
 		f2fs_set_bit(i, (char *)journal->sit_j.entries[3].se.valid_map);
 
 	journal->sit_j.entries[4].segno = cp->cur_data_segno[1];
@@ -951,31 +942,36 @@ static int f2fs_write_super_block(void)
 }
 
 #ifndef WITH_ANDROID
-static int discard_obsolete_dnode(struct f2fs_node *raw_node, u_int64_t offset)
+static int f2fs_discard_obsolete_dnode(void)
 {
-	u_int64_t next_blkaddr = 0;
+	struct f2fs_node *raw_node;
+	u_int64_t next_blkaddr = 0, offset;
 	u64 end_blkaddr = (get_sb(segment_count_main) <<
 			get_sb(log_blocks_per_seg)) + get_sb(main_blkaddr);
 	u_int64_t start_inode_pos = get_sb(main_blkaddr);
 	u_int64_t last_inode_pos;
-	enum quota_type qtype;
-	u_int32_t quota_inum = 0;
 
-	for (qtype = 0; qtype < F2FS_MAX_QUOTAS; qtype++)
-		if (sb->qf_ino[qtype]) quota_inum++;
+	if (c.zoned_mode)
+		return 0;
+
+	raw_node = calloc(sizeof(struct f2fs_node), 1);
+	if (!raw_node)
+		return -1;
+
+	/* avoid power-off-recovery based on roll-forward policy */
+	offset = get_sb(main_blkaddr);
+	offset += c.cur_seg[CURSEG_WARM_NODE] * c.blks_per_seg;
 
-	/* only root inode was written before truncating dnodes */
 	last_inode_pos = start_inode_pos +
-		c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg + quota_inum;
+		c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg + c.quota_inum;
 
-	if (c.zoned_mode)
-		return 0;
 	do {
 		if (offset < get_sb(main_blkaddr) || offset >= end_blkaddr)
 			break;
 
 		if (dev_read_block(raw_node, offset)) {
 			MSG(1, "\tError: While traversing direct node!!!\n");
+			free(raw_node);
 			return -1;
 		}
 
@@ -985,6 +981,7 @@ static int discard_obsolete_dnode(struct f2fs_node *raw_node, u_int64_t offset)
 		DBG(1, "\tDiscard dnode, at offset 0x%08"PRIx64"\n", offset);
 		if (dev_write_block(raw_node, offset)) {
 			MSG(1, "\tError: While discarding direct node!!!\n");
+			free(raw_node);
 			return -1;
 		}
 		offset = next_blkaddr;
@@ -993,6 +990,7 @@ static int discard_obsolete_dnode(struct f2fs_node *raw_node, u_int64_t offset)
 			break;
 	} while (1);
 
+	free(raw_node);
 	return 0;
 }
 #endif
@@ -1078,17 +1076,6 @@ static int f2fs_write_root_inode(void)
 		return -1;
 	}
 
-	/* avoid power-off-recovery based on roll-forward policy */
-	main_area_node_seg_blk_offset = get_sb(main_blkaddr);
-	main_area_node_seg_blk_offset += c.cur_seg[CURSEG_WARM_NODE] *
-					c.blks_per_seg;
-
-#ifndef WITH_ANDROID
-	if (discard_obsolete_dnode(raw_node, main_area_node_seg_blk_offset)) {
-		free(raw_node);
-		return -1;
-	}
-#endif
 	free(raw_node);
 	return 0;
 }
@@ -1154,6 +1141,7 @@ static int f2fs_write_default_quota(int qtype, unsigned int blkaddr,
 	DBG(1, "\tWriting quota data, at offset %08x, %08x\n",
 					blkaddr, blkaddr + 1);
 	free(filebuf);
+	c.quota_dnum += QUOTA_DATA(qtype);
 	return 0;
 }
 
@@ -1255,6 +1243,7 @@ static int f2fs_write_qf_inode(int qtype)
 	}
 
 	free(raw_node);
+	c.quota_inum++;
 	return 0;
 }
 
@@ -1375,6 +1364,14 @@ static int f2fs_create_root_dir(void)
 		}
 	}
 
+#ifndef WITH_ANDROID
+	err = f2fs_discard_obsolete_dnode();
+	if (err < 0) {
+		MSG(1, "\tError: Failed to discard obsolete dnode!!!\n");
+		goto exit;
+	}
+#endif
+
 	err = f2fs_update_nat_root();
 	if (err < 0) {
 		MSG(1, "\tError: Failed to update NAT for root!!!\n");
-- 
2.14.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
