From: Sotirios-Efstathios Maneas <smaneas@cs.toronto.edu>
Subject: [PATCH 4/4] fsck/mount: Gracefully terminate the mount
 procedure in case the program runs out of memory.
Date: Thu, 11 Oct 2018 18:21:35 -0400
Message-ID: <37055E66-4A79-4F24-82AD-D69F9525D397@cs.toronto.edu>
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <smaneas@cs.toronto.edu>) id 1gAjKx-00028v-OA
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Oct 2018 22:21:43 +0000
Received: from aviary.cs.toronto.edu ([128.100.3.90])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:DHE-RSA-AES128-SHA:128) (Exim 4.90_1) id 1gAjKw-00H4rP-97
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Oct 2018 22:21:43 +0000
Received: from airport-26.cs.toronto.edu ([128.100.27.26] helo=[172.31.34.138])
 by aviary.cs.toronto.edu (as smtp.cs.toronto.edu) with esmtpsa
 (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.82)
 (envelope-from <smaneas@cs.toronto.edu>) id 1gAjKp-0006Sd-GX
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Oct 2018 18:21:35 -0400
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Added the necessary statements so that the mount procedure gracefully terminates in case the program runs out of memory.

Signed-off-by: Sotirios-Efstathios Maneas <smaneas@cs.toronto.edu>
---
 fsck/mount.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 18 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 861e5fb..0036e6f 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1299,20 +1299,26 @@ int build_sit_info(struct f2fs_sb_info *sbi)
 	unsigned int bitmap_size;
 
 	sit_i = malloc(sizeof(struct sit_info));
-	if (!sit_i)
+	if (!sit_i) {
+		MSG(1, "\tError: Malloc failed for build_sit_info!\n");
 		return -ENOMEM;
+	}
 
 	SM_I(sbi)->sit_info = sit_i;
 
 	sit_i->sentries = calloc(TOTAL_SEGS(sbi) * sizeof(struct seg_entry), 1);
-	if (!sit_i->sentries)
-		return -ENOMEM;
+	if (!sit_i->sentries) {
+		MSG(1, "\tError: Calloc failed for build_sit_info!\n");
+		goto free_sit_info;
+	}
 
 	for (start = 0; start < TOTAL_SEGS(sbi); start++) {
 		sit_i->sentries[start].cur_valid_map
 			= calloc(SIT_VBLOCK_MAP_SIZE, 1);
-		if (!sit_i->sentries[start].cur_valid_map)
-			return -ENOMEM;
+		if (!sit_i->sentries[start].cur_valid_map) {
+			MSG(1, "\tError: Calloc failed for build_sit_info!!\n");
+			goto free_validity_maps;
+		}
 	}
 
 	sit_segs = get_sb(segment_count_sit) >> 1;
@@ -1320,6 +1326,10 @@ int build_sit_info(struct f2fs_sb_info *sbi)
 	src_bitmap = __bitmap_ptr(sbi, SIT_BITMAP);
 
 	dst_bitmap = malloc(bitmap_size);
+	if (!dst_bitmap) {
+		MSG(1, "\tError: Malloc failed for build_sit_info!!\n");
+		goto free_validity_maps;
+	}
 	memcpy(dst_bitmap, src_bitmap, bitmap_size);
 
 	sit_i->sit_base_addr = get_sb(sit_blkaddr);
@@ -1331,6 +1341,16 @@ int build_sit_info(struct f2fs_sb_info *sbi)
 	sit_i->sents_per_block = SIT_ENTRY_PER_BLOCK;
 	sit_i->elapsed_time = get_cp(elapsed_time);
 	return 0;
+
+free_validity_maps:
+	for (--start ; start >= 0; --start)
+		free(sit_i->sentries[start].cur_valid_map);
+	free(sit_i->sentries);
+
+free_sit_info:
+	free(sit_i);
+
+	return -ENOMEM;
 }
 
 void reset_curseg(struct f2fs_sb_info *sbi, int type)
@@ -1504,7 +1524,7 @@ static void restore_curseg_summaries(struct f2fs_sb_info *sbi)
 		read_normal_summaries(sbi, type);
 }
 
-static void build_curseg(struct f2fs_sb_info *sbi)
+static int build_curseg(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 	struct curseg_info *array;
@@ -1513,13 +1533,20 @@ static void build_curseg(struct f2fs_sb_info *sbi)
 	int i;
 
 	array = malloc(sizeof(*array) * NR_CURSEG_TYPE);
-	ASSERT(array);
+	if (!array) {
+		MSG(1, "\tError: Malloc failed for build_curseg!\n");
+		return -ENOMEM;
+	}
 
 	SM_I(sbi)->curseg_array = array;
 
 	for (i = 0; i < NR_CURSEG_TYPE; i++) {
 		array[i].sum_blk = malloc(PAGE_CACHE_SIZE);
-		ASSERT(array[i].sum_blk);
+		if (!array[i].sum_blk) {
+			MSG(1, "\tError: Malloc failed for build_curseg!!\n");
+			goto seg_cleanup;
+		}
+
 		if (i <= CURSEG_COLD_DATA) {
 			blk_off = get_cp(cur_data_blkoff[i]);
 			segno = get_cp(cur_data_segno[i]);
@@ -1538,6 +1565,14 @@ static void build_curseg(struct f2fs_sb_info *sbi)
 		array[i].alloc_type = cp->alloc_type[i];
 	}
 	restore_curseg_summaries(sbi);
+	return 0;
+
+seg_cleanup:
+	for(--i ; i >=0; --i)
+		free(array[i].sum_blk);
+	free(array);
+
+	return -ENOMEM;
 }
 
 static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
@@ -1823,7 +1858,7 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
 	node_info_from_raw_nat(ni, &raw_nat);
 }
 
-void build_sit_entries(struct f2fs_sb_info *sbi)
+static int build_sit_entries(struct f2fs_sb_info *sbi)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
@@ -1834,7 +1869,11 @@ void build_sit_entries(struct f2fs_sb_info *sbi)
 	unsigned int i, segno;
 
 	sit_blk = calloc(BLOCK_SZ, 1);
-	ASSERT(sit_blk);
+	if (!sit_blk) {
+		MSG(1, "\tError: Calloc failed for build_sit_entries!\n");
+		return -ENOMEM;
+	}
+
 	for (segno = 0; segno < TOTAL_SEGS(sbi); segno++) {
 		se = &sit_i->sentries[segno];
 
@@ -1854,18 +1893,20 @@ void build_sit_entries(struct f2fs_sb_info *sbi)
 		check_block_count(sbi, segno, &sit);
 		seg_info_from_raw_sit(se, &sit);
 	}
-
+	return 0;
 }
 
-int build_segment_manager(struct f2fs_sb_info *sbi)
+static int build_segment_manager(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 	struct f2fs_sm_info *sm_info;
 
 	sm_info = malloc(sizeof(struct f2fs_sm_info));
-	if (!sm_info)
+	if (!sm_info) {
+		MSG(1, "\tError: Malloc failed for build_segment_manager!\n");
 		return -ENOMEM;
+	}
 
 	/* init sm info */
 	sbi->sm_info = sm_info;
@@ -1877,11 +1918,10 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	sm_info->main_segments = get_sb(segment_count_main);
 	sm_info->ssa_blkaddr = get_sb(ssa_blkaddr);
 
-	build_sit_info(sbi);
-
-	build_curseg(sbi);
-
-	build_sit_entries(sbi);
+	if (build_sit_info(sbi) || build_curseg(sbi) || build_sit_entries(sbi)) {
+		free(sm_info);
+		return -ENOMEM;
+	}
 
 	return 0;
 }
-- 
2.10.1

Kind regards,
Stathis Maneas
