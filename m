From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] libf2fs: use dev_read_block and
	dev_write_block
Date: Sat, 24 Sep 2016 11:21:39 -0700
Message-ID: <20160924182140.25395-2-jaegeuk@kernel.org>
References: <20160924182140.25395-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bnraD-0007mB-Uz
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 18:21:53 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bnraC-0000xh-GT
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Sep 2016 18:21:53 +0000
In-Reply-To: <20160924182140.25395-1-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patche tries to use dev_read_block and dev_write_block as much as possible.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/f2fs_fs.h  |   2 +-
 lib/libf2fs_io.c   |  12 +++----
 mkfs/f2fs_format.c | 101 ++++++++++++++++++++++++++++-------------------------
 3 files changed, 61 insertions(+), 54 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 1345e2d..d44e10e 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -964,9 +964,9 @@ extern int dev_write_block(void *, __u64);
 extern int dev_write_dump(void *, __u64, size_t);
 /* All bytes in the buffer must be 0 use dev_fill(). */
 extern int dev_fill(void *, __u64, size_t);
+extern int dev_fill_block(void *, __u64);
 
 extern int dev_read_block(void *, __u64);
-extern int dev_read_blocks(void *, __u64, __u32 );
 extern int dev_reada_block(__u64);
 
 extern int dev_read_version(void *, __u64, size_t);
diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
index afa345f..d2a04b2 100644
--- a/lib/libf2fs_io.c
+++ b/lib/libf2fs_io.c
@@ -66,7 +66,7 @@ int dev_write(void *buf, __u64 offset, size_t len)
 
 int dev_write_block(void *buf, __u64 blk_addr)
 {
-	return dev_write(buf, blk_addr * F2FS_BLKSIZE, F2FS_BLKSIZE);
+	return dev_write(buf, blk_addr << F2FS_BLKSIZE_BITS, F2FS_BLKSIZE);
 }
 
 int dev_write_dump(void *buf, __u64 offset, size_t len)
@@ -90,19 +90,19 @@ int dev_fill(void *buf, __u64 offset, size_t len)
 	return 0;
 }
 
-int dev_read_block(void *buf, __u64 blk_addr)
+int dev_fill_block(void *buf, __u64 blk_addr)
 {
-	return dev_read(buf, blk_addr * F2FS_BLKSIZE, F2FS_BLKSIZE);
+	return dev_fill(buf, blk_addr << F2FS_BLKSIZE_BITS, F2FS_BLKSIZE);
 }
 
-int dev_read_blocks(void *buf, __u64 addr, __u32 nr_blks)
+int dev_read_block(void *buf, __u64 blk_addr)
 {
-	return dev_read(buf, addr * F2FS_BLKSIZE, nr_blks * F2FS_BLKSIZE);
+	return dev_read(buf, blk_addr << F2FS_BLKSIZE_BITS, F2FS_BLKSIZE);
 }
 
 int dev_reada_block(__u64 blk_addr)
 {
-	return dev_readahead(blk_addr * F2FS_BLKSIZE, F2FS_BLKSIZE);
+	return dev_readahead(blk_addr << F2FS_BLKSIZE_BITS, F2FS_BLKSIZE);
 }
 
 void f2fs_finalize_device(struct f2fs_configuration *c)
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 466df27..9dd30db 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -413,7 +413,7 @@ static int f2fs_write_check_point_pack(void)
 	struct f2fs_summary_block *sum = NULL;
 	struct f2fs_journal *journal;
 	u_int32_t blk_size_bytes;
-	u_int64_t cp_seg_blk_offset = 0;
+	u_int64_t cp_seg_blk = 0;
 	u_int32_t crc = 0;
 	unsigned int i;
 	char *cp_payload = NULL;
@@ -498,18 +498,25 @@ static int f2fs_write_check_point_pack(void)
 							cpu_to_le32(crc);
 
 	blk_size_bytes = 1 << get_sb(log_blocksize);
-	cp_seg_blk_offset = get_sb(segment0_blkaddr);
-	cp_seg_blk_offset *= blk_size_bytes;
 
-	DBG(1, "\tWriting main segments, cp at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
-	if (dev_write(cp, cp_seg_blk_offset, blk_size_bytes)) {
+	if (blk_size_bytes != F2FS_BLKSIZE) {
+		MSG(1, "\tError: Wrong block size %d / %d!!!\n",
+					blk_size_bytes, F2FS_BLKSIZE);
+		goto free_cp_payload;
+	}
+
+	cp_seg_blk = get_sb(segment0_blkaddr);
+
+	DBG(1, "\tWriting main segments, cp at offset 0x%08"PRIx64"\n",
+						cp_seg_blk);
+	if (dev_write_block(cp, cp_seg_blk)) {
 		MSG(1, "\tError: While writing the cp to disk!!!\n");
 		goto free_cp_payload;
 	}
 
 	for (i = 0; i < get_sb(cp_payload); i++) {
-		cp_seg_blk_offset += blk_size_bytes;
-		if (dev_fill(cp_payload, cp_seg_blk_offset, blk_size_bytes)) {
+		cp_seg_blk++;
+		if (dev_fill_block(cp_payload, cp_seg_blk)) {
 			MSG(1, "\tError: While zeroing out the sit bitmap area "
 					"on disk!!!\n");
 			goto free_cp_payload;
@@ -576,10 +583,10 @@ static int f2fs_write_check_point_pack(void)
 	/* warm data summary, nothing to do */
 	/* cold data summary, nothing to do */
 
-	cp_seg_blk_offset += blk_size_bytes;
+	cp_seg_blk++;
 	DBG(1, "\tWriting Segment summary for HOT/WARM/COLD_DATA, at offset 0x%08"PRIx64"\n",
-			cp_seg_blk_offset);
-	if (dev_write(sum_compact, cp_seg_blk_offset, blk_size_bytes)) {
+			cp_seg_blk);
+	if (dev_write_block(sum_compact, cp_seg_blk)) {
 		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
 		goto free_cp_payload;
 	}
@@ -591,10 +598,10 @@ static int f2fs_write_check_point_pack(void)
 	sum->entries[0].nid = sb->root_ino;
 	sum->entries[0].ofs_in_node = 0;
 
-	cp_seg_blk_offset += blk_size_bytes;
+	cp_seg_blk++;
 	DBG(1, "\tWriting Segment summary for HOT_NODE, at offset 0x%08"PRIx64"\n",
-			cp_seg_blk_offset);
-	if (dev_write(sum, cp_seg_blk_offset, blk_size_bytes)) {
+			cp_seg_blk);
+	if (dev_write_block(sum, cp_seg_blk)) {
 		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
 		goto free_cp_payload;
 	}
@@ -603,10 +610,10 @@ static int f2fs_write_check_point_pack(void)
 	memset(sum, 0, sizeof(struct f2fs_summary_block));
 	SET_SUM_TYPE((&sum->footer), SUM_TYPE_NODE);
 
-	cp_seg_blk_offset += blk_size_bytes;
+	cp_seg_blk++;
 	DBG(1, "\tWriting Segment summary for WARM_NODE, at offset 0x%08"PRIx64"\n",
-			cp_seg_blk_offset);
-	if (dev_write(sum, cp_seg_blk_offset, blk_size_bytes)) {
+			cp_seg_blk);
+	if (dev_write_block(sum, cp_seg_blk)) {
 		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
 		goto free_cp_payload;
 	}
@@ -614,18 +621,18 @@ static int f2fs_write_check_point_pack(void)
 	/* Fill segment summary for COLD_NODE to zero. */
 	memset(sum, 0, sizeof(struct f2fs_summary_block));
 	SET_SUM_TYPE((&sum->footer), SUM_TYPE_NODE);
-	cp_seg_blk_offset += blk_size_bytes;
+	cp_seg_blk++;
 	DBG(1, "\tWriting Segment summary for COLD_NODE, at offset 0x%08"PRIx64"\n",
-			cp_seg_blk_offset);
-	if (dev_write(sum, cp_seg_blk_offset, blk_size_bytes)) {
+			cp_seg_blk);
+	if (dev_write_block(sum, cp_seg_blk)) {
 		MSG(1, "\tError: While writing the sum_blk to disk!!!\n");
 		goto free_cp_payload;
 	}
 
 	/* cp page2 */
-	cp_seg_blk_offset += blk_size_bytes;
-	DBG(1, "\tWriting cp page2, at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
-	if (dev_write(cp, cp_seg_blk_offset, blk_size_bytes)) {
+	cp_seg_blk++;
+	DBG(1, "\tWriting cp page2, at offset 0x%08"PRIx64"\n", cp_seg_blk);
+	if (dev_write_block(cp, cp_seg_blk)) {
 		MSG(1, "\tError: While writing the cp to disk!!!\n");
 		goto free_cp_payload;
 	}
@@ -638,18 +645,17 @@ static int f2fs_write_check_point_pack(void)
 	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CHECKSUM_OFFSET);
 	*((__le32 *)((unsigned char *)cp + CHECKSUM_OFFSET)) =
 							cpu_to_le32(crc);
-	cp_seg_blk_offset = (get_sb(segment0_blkaddr) +
-				config.blks_per_seg) *
-				blk_size_bytes;
-	DBG(1, "\tWriting cp page 1 of checkpoint pack 2, at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
-	if (dev_write(cp, cp_seg_blk_offset, blk_size_bytes)) {
+	cp_seg_blk = get_sb(segment0_blkaddr) + config.blks_per_seg;
+	DBG(1, "\tWriting cp page 1 of checkpoint pack 2, at offset 0x%08"PRIx64"\n",
+				cp_seg_blk);
+	if (dev_write_block(cp, cp_seg_blk)) {
 		MSG(1, "\tError: While writing the cp to disk!!!\n");
 		goto free_cp_payload;
 	}
 
 	for (i = 0; i < get_sb(cp_payload); i++) {
-		cp_seg_blk_offset += blk_size_bytes;
-		if (dev_fill(cp_payload, cp_seg_blk_offset, blk_size_bytes)) {
+		cp_seg_blk++;
+		if (dev_fill_block(cp_payload, cp_seg_blk)) {
 			MSG(1, "\tError: While zeroing out the sit bitmap area "
 					"on disk!!!\n");
 			goto free_cp_payload;
@@ -657,10 +663,11 @@ static int f2fs_write_check_point_pack(void)
 	}
 
 	/* cp page 2 of check point pack 2 */
-	cp_seg_blk_offset += blk_size_bytes * (le32_to_cpu(cp->cp_pack_total_block_count)
-			- get_sb(cp_payload) - 1);
-	DBG(1, "\tWriting cp page 2 of checkpoint pack 2, at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
-	if (dev_write(cp, cp_seg_blk_offset, blk_size_bytes)) {
+	cp_seg_blk += (le32_to_cpu(cp->cp_pack_total_block_count) -
+					get_sb(cp_payload) - 1);
+	DBG(1, "\tWriting cp page 2 of checkpoint pack 2, at offset 0x%08"PRIx64"\n",
+				cp_seg_blk);
+	if (dev_write_block(cp, cp_seg_blk)) {
 		MSG(1, "\tError: While writing the cp to disk!!!\n");
 		goto free_cp_payload;
 	}
@@ -688,7 +695,7 @@ static int f2fs_write_super_block(void)
 	memcpy(zero_buff + F2FS_SUPER_OFFSET, sb, sizeof(*sb));
 	DBG(1, "\tWriting super block, at offset 0x%08x\n", 0);
 	for (index = 0; index < 2; index++) {
-		if (dev_write(zero_buff, index * F2FS_BLKSIZE, F2FS_BLKSIZE)) {
+		if (dev_write_block(zero_buff, index)) {
 			MSG(1, "\tError: While while writing supe_blk "
 					"on disk!!! index : %d\n", index);
 			free(zero_buff);
@@ -781,10 +788,12 @@ static int f2fs_write_root_inode(void)
 	main_area_node_seg_blk_offset = get_sb(main_blkaddr);
 	main_area_node_seg_blk_offset += config.cur_seg[CURSEG_HOT_NODE] *
 					config.blks_per_seg;
-        main_area_node_seg_blk_offset *= blk_size_bytes;
 
-	DBG(1, "\tWriting root inode (hot node), %x %x %x at offset 0x%08"PRIu64"\n", get_sb(main_blkaddr), config.cur_seg[CURSEG_HOT_NODE], config.blks_per_seg, main_area_node_seg_blk_offset/512);
-	if (dev_write(raw_node, main_area_node_seg_blk_offset, F2FS_BLKSIZE)) {
+	DBG(1, "\tWriting root inode (hot node), %x %x %x at offset 0x%08"PRIu64"\n",
+			get_sb(main_blkaddr),
+			config.cur_seg[CURSEG_HOT_NODE],
+			config.blks_per_seg, main_area_node_seg_blk_offset);
+	if (dev_write_block(raw_node, main_area_node_seg_blk_offset)) {
 		MSG(1, "\tError: While writing the raw_node to disk!!!\n");
 		free(raw_node);
 		return -1;
@@ -809,7 +818,7 @@ static int f2fs_write_root_inode(void)
 static int f2fs_update_nat_root(void)
 {
 	struct f2fs_nat_block *nat_blk = NULL;
-	u_int64_t blk_size_bytes, nat_seg_blk_offset = 0;
+	u_int64_t nat_seg_blk_offset = 0;
 
 	nat_blk = calloc(F2FS_BLKSIZE, 1);
 	if(nat_blk == NULL) {
@@ -831,12 +840,11 @@ static int f2fs_update_nat_root(void)
 	nat_blk->entries[get_sb(meta_ino)].block_addr = cpu_to_le32(1);
 	nat_blk->entries[get_sb(meta_ino)].ino = sb->meta_ino;
 
-	blk_size_bytes = 1 << get_sb(log_blocksize);
 	nat_seg_blk_offset = get_sb(nat_blkaddr);
-	nat_seg_blk_offset *= blk_size_bytes;
 
-	DBG(1, "\tWriting nat root, at offset 0x%08"PRIx64"\n", nat_seg_blk_offset);
-	if (dev_write(nat_blk, nat_seg_blk_offset, F2FS_BLKSIZE)) {
+	DBG(1, "\tWriting nat root, at offset 0x%08"PRIx64"\n",
+					nat_seg_blk_offset);
+	if (dev_write_block(nat_blk, nat_seg_blk_offset)) {
 		MSG(1, "\tError: While writing the nat_blk set0 to disk!\n");
 		free(nat_blk);
 		return -1;
@@ -849,7 +857,7 @@ static int f2fs_update_nat_root(void)
 static int f2fs_add_default_dentry_root(void)
 {
 	struct f2fs_dentry_block *dent_blk = NULL;
-	u_int64_t blk_size_bytes, data_blk_offset = 0;
+	u_int64_t data_blk_offset = 0;
 
 	dent_blk = calloc(F2FS_BLKSIZE, 1);
 	if(dent_blk == NULL) {
@@ -872,14 +880,13 @@ static int f2fs_add_default_dentry_root(void)
 	/* bitmap for . and .. */
 	test_and_set_bit_le(0, dent_blk->dentry_bitmap);
 	test_and_set_bit_le(1, dent_blk->dentry_bitmap);
-	blk_size_bytes = 1 << get_sb(log_blocksize);
 	data_blk_offset = get_sb(main_blkaddr);
 	data_blk_offset += config.cur_seg[CURSEG_HOT_DATA] *
 				config.blks_per_seg;
-	data_blk_offset *= blk_size_bytes;
 
-	DBG(1, "\tWriting default dentry root, at offset 0x%08"PRIx64"\n", data_blk_offset);
-	if (dev_write(dent_blk, data_blk_offset, F2FS_BLKSIZE)) {
+	DBG(1, "\tWriting default dentry root, at offset 0x%08"PRIx64"\n",
+				data_blk_offset);
+	if (dev_write_block(dent_blk, data_blk_offset)) {
 		MSG(1, "\tError: While writing the dentry_blk to disk!!!\n");
 		free(dent_blk);
 		return -1;
-- 
2.8.3


------------------------------------------------------------------------------
