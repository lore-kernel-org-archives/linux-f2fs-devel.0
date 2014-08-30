From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 08/17] fsck.f2fs: give a chance to recover sit
	entries
Date: Fri, 29 Aug 2014 17:28:55 -0700
Message-ID: <1409358544-54740-8-git-send-email-jaegeuk@kernel.org>
References: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XNWY8-0005fj-7d
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:48 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XNWY7-0000Of-G6 for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:48 +0000
In-Reply-To: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
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

This patch skips initial verfication on SIT entries, which checks the number of
valid blocks from its bitmap.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c  |  2 +-
 fsck/fsck.h  |  2 +-
 fsck/mount.c | 39 +++++++++++++--------------------------
 3 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 9ebe2be..49d9ccc 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -634,7 +634,7 @@ int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 	is_valid_ssa_data_blk(sbi, blk_addr, parent_nid, idx_in_node, ver);
 
 	if (f2fs_test_sit_bitmap(sbi, blk_addr) == 0)
-		ASSERT_MSG("SIT bitmap is 0x0. blk_addr[0x%x]\n", blk_addr);
+		ASSERT_MSG("SIT bitmap is 0x0. blk_addr[0x%x]", blk_addr);
 
 	if (f2fs_test_main_bitmap(sbi, blk_addr) != 0)
 		ASSERT_MSG("Duplicated data [0x%x]. pnid[0x%x] idx[0x%x]",
diff --git a/fsck/fsck.h b/fsck/fsck.h
index aecfa9a..a3f03fd 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -102,7 +102,7 @@ extern int get_sum_block(struct f2fs_sb_info *, unsigned int,
 extern int get_sum_entry(struct f2fs_sb_info *, u32, struct f2fs_summary *);
 extern void get_node_info(struct f2fs_sb_info *, nid_t, struct node_info *);
 extern void build_nat_area_bitmap(struct f2fs_sb_info *);
-extern int build_sit_area_bitmap(struct f2fs_sb_info *);
+extern void build_sit_area_bitmap(struct f2fs_sb_info *);
 extern void fsck_init(struct f2fs_sb_info *);
 extern int fsck_verify(struct f2fs_sb_info *);
 extern void fsck_free(struct f2fs_sb_info *);
diff --git a/fsck/mount.c b/fsck/mount.c
index b0dd5c7..4880848 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -726,18 +726,22 @@ void check_block_count(struct f2fs_sb_info *sbi,
 	int valid_blocks = 0;
 	unsigned int i;
 
-
 	/* check segment usage */
-	ASSERT(GET_SIT_VBLOCKS(raw_sit) <= sbi->blocks_per_seg);
+	if (GET_SIT_VBLOCKS(raw_sit) > sbi->blocks_per_seg)
+		ASSERT_MSG("Invalid SIT vblocks: segno=0x%x, %u",
+				segno, GET_SIT_VBLOCKS(raw_sit));
 
 	/* check boundary of a given segment number */
-	ASSERT(segno <= end_segno);
+	if (segno > end_segno)
+		ASSERT_MSG("Invalid SEGNO: 0x%x", segno);
 
 	/* check bitmap with valid block count */
-	for (i = 0; i < sbi->blocks_per_seg; i++)
-		if (f2fs_test_bit(i, (char *)raw_sit->valid_map))
-			valid_blocks++;
-	ASSERT(GET_SIT_VBLOCKS(raw_sit) == valid_blocks);
+	for (i = 0; i < SIT_VBLOCK_MAP_SIZE; i++)
+		valid_blocks += get_bits_in_byte(raw_sit->valid_map[i]);
+
+	if (GET_SIT_VBLOCKS(raw_sit) != valid_blocks)
+		ASSERT_MSG("Wrong SIT valid blocks: segno=0x%x, %u vs. %u",
+				segno, GET_SIT_VBLOCKS(raw_sit), valid_blocks);
 }
 
 void seg_info_from_raw_sit(struct seg_entry *se,
@@ -918,18 +922,14 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
-int build_sit_area_bitmap(struct f2fs_sb_info *sbi)
+void build_sit_area_bitmap(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct f2fs_sm_info *sm_i = SM_I(sbi);
 	unsigned int segno = 0;
-	int j = 0;
 	char *ptr = NULL;
-
 	u32 sum_vblocks = 0;
 	u32 free_segs = 0;
-	u32 vblocks = 0;
-
 	struct seg_entry *se;
 
 	fsck->sit_area_bitmap_sz = sm_i->main_segments * SIT_VBLOCK_MAP_SIZE;
@@ -938,20 +938,13 @@ int build_sit_area_bitmap(struct f2fs_sb_info *sbi)
 
 	ASSERT(fsck->sit_area_bitmap_sz == fsck->main_area_bitmap_sz);
 
-	for (segno = 0; segno < sm_i->main_segments; segno++) {
+	for (segno = 0; segno < TOTAL_SEGS(sbi); segno++) {
 		se = get_seg_entry(sbi, segno);
 
 		memcpy(ptr, se->cur_valid_map, SIT_VBLOCK_MAP_SIZE);
 		ptr += SIT_VBLOCK_MAP_SIZE;
 
-		vblocks = 0;
-		for (j = 0; j < SIT_VBLOCK_MAP_SIZE; j++) {
-			vblocks += get_bits_in_byte(se->cur_valid_map[j]);
-		}
-		ASSERT(vblocks == se->valid_blocks);
-
 		if (se->valid_blocks == 0x0) {
-
 			if (sbi->ckpt->cur_node_segno[0] == segno ||
 					sbi->ckpt->cur_data_segno[0] == segno ||
 					sbi->ckpt->cur_node_segno[1] == segno ||
@@ -962,20 +955,16 @@ int build_sit_area_bitmap(struct f2fs_sb_info *sbi)
 			} else {
 				free_segs++;
 			}
-
 		} else {
-			ASSERT(se->valid_blocks <= 512);
 			sum_vblocks += se->valid_blocks;
 		}
 	}
-
 	fsck->chk.sit_valid_blocks = sum_vblocks;
 	fsck->chk.sit_free_segs = free_segs;
 
 	DBG(1, "Blocks [0x%x : %d] Free Segs [0x%x : %d]\n\n",
 			sum_vblocks, sum_vblocks,
 			free_segs, free_segs);
-	return 0;
 }
 
 int lookup_nat_in_journal(struct f2fs_sb_info *sbi, u32 nid,
@@ -1003,14 +992,12 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct f2fs_nat_block *nat_block;
 	u32 nid, nr_nat_blks;
-
 	pgoff_t block_off;
 	pgoff_t block_addr;
 	int seg_off;
 	int ret;
 	unsigned int i;
 
-
 	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
 
 	/* Alloc & build nat entry bitmap */
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
