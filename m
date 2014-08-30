From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 03/17] fsck.f2fs: clean up codes
Date: Fri, 29 Aug 2014 17:28:50 -0700
Message-ID: <1409358544-54740-3-git-send-email-jaegeuk@kernel.org>
References: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XNWXx-0005Qb-Ep
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:37 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XNWXu-0004ds-Qn for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:37 +0000
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

Fix wrong coding style.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/dump.c       |   2 +-
 fsck/f2fs.h       |  12 +--
 fsck/fsck.c       | 294 +++++++++++++++++++++++++-----------------------------
 fsck/fsck.h       | 105 +++++++------------
 include/f2fs_fs.h |  83 ++++++++-------
 5 files changed, 217 insertions(+), 279 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 44d4105..e14a190 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -141,7 +141,7 @@ static void dump_node_blk(struct f2fs_sb_info *sbi, int ntype,
 	struct node_info ni;
 	struct f2fs_node *node_blk;
 	int i, ret;
-	u32 idx, skip;
+	u32 idx, skip = 0;
 
 	switch (ntype) {
 	case TYPE_DIRECT_NODE:
diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 427a733..aa43cdc 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -301,12 +301,12 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
 	(segno / SIT_ENTRY_PER_BLOCK)
 #define TOTAL_SEGS(sbi) (SM_I(sbi)->main_segments)
 
-#define IS_VALID_NID(sbi, nid) 			\
-	do {						\
-		ASSERT(nid <= (NAT_ENTRY_PER_BLOCK *	\
-					F2FS_RAW_SUPER(sbi)->segment_count_nat	\
-					<< (sbi->log_blocks_per_seg - 1)));	\
-	} while (0);
+static inline bool IS_VALID_NID(struct f2fs_sb_info *sbi, u32 nid)
+{
+	return (nid <= (NAT_ENTRY_PER_BLOCK *
+			F2FS_RAW_SUPER(sbi)->segment_count_nat
+			<< (sbi->log_blocks_per_seg - 1)));
+}
 
 #define IS_VALID_BLK_ADDR(sbi, addr)				\
 	do {							\
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 9a4c26c..5c99385 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -13,7 +13,30 @@
 char *tree_mark;
 uint32_t tree_mark_size = 256;
 
-static int add_into_hard_link_list(struct f2fs_sb_info *sbi, u32 nid, u32 link_cnt)
+static inline int f2fs_set_main_bitmap(struct f2fs_sb_info *sbi, u32 blk)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+
+	return f2fs_set_bit(BLKOFF_FROM_MAIN(sbi, blk), fsck->main_area_bitmap);
+}
+
+static inline int f2fs_test_main_bitmap(struct f2fs_sb_info *sbi, u32 blk)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+
+	return f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, blk),
+						fsck->main_area_bitmap);
+}
+
+static inline int f2fs_test_sit_bitmap(struct f2fs_sb_info *sbi, u32 blk)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+
+	return f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, blk), fsck->sit_area_bitmap);
+}
+
+static int add_into_hard_link_list(struct f2fs_sb_info *sbi,
+						u32 nid, u32 link_cnt)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct hard_link_node *node = NULL, *tmp = NULL, *prev = NULL;
@@ -90,7 +113,8 @@ static int find_and_dec_hard_link_list(struct f2fs_sb_info *sbi, u32 nid)
 
 }
 
-static int is_valid_ssa_node_blk(struct f2fs_sb_info *sbi, u32 nid, u32 blk_addr)
+static int is_valid_ssa_node_blk(struct f2fs_sb_info *sbi, u32 nid,
+							u32 blk_addr)
 {
 	int ret = 0;
 	struct f2fs_summary sum_entry;
@@ -99,23 +123,26 @@ static int is_valid_ssa_node_blk(struct f2fs_sb_info *sbi, u32 nid, u32 blk_addr
 	ASSERT(ret >= 0);
 
 	if (ret == SEG_TYPE_DATA || ret == SEG_TYPE_CUR_DATA) {
-		ASSERT_MSG(0, "Summary footer is not a node segment summary\n");;
+		ASSERT_MSG("Summary footer is not for node segment\n");
 	} else if (ret == SEG_TYPE_NODE) {
 		if (le32_to_cpu(sum_entry.nid) != nid) {
 			DBG(0, "nid                       [0x%x]\n", nid);
 			DBG(0, "target blk_addr           [0x%x]\n", blk_addr);
 			DBG(0, "summary blk_addr          [0x%x]\n",
-					GET_SUM_BLKADDR(sbi, GET_SEGNO(sbi, blk_addr)));
+					GET_SUM_BLKADDR(sbi,
+						GET_SEGNO(sbi, blk_addr)));
 			DBG(0, "seg no / offset           [0x%x / 0x%x]\n",
-					GET_SEGNO(sbi, blk_addr), OFFSET_IN_SEG(sbi, blk_addr));
-			DBG(0, "summary_entry.nid         [0x%x]\n", le32_to_cpu(sum_entry.nid));
+					GET_SEGNO(sbi, blk_addr),
+						OFFSET_IN_SEG(sbi, blk_addr));
+			DBG(0, "summary_entry.nid         [0x%x]\n",
+					le32_to_cpu(sum_entry.nid));
 			DBG(0, "--> node block's nid      [0x%x]\n", nid);
-			ASSERT_MSG(0, "Invalid node seg summary\n");
+			ASSERT_MSG("Invalid node seg summary\n");
 		}
 	} else if (ret == SEG_TYPE_CUR_NODE) {
 		/* current node segment has no ssa */
 	} else {
-		ASSERT_MSG(0, "Invalid return value of 'get_sum_entry'");
+		ASSERT_MSG("Invalid return value of 'get_sum_entry'");
 	}
 
 	return 1;
@@ -134,18 +161,19 @@ static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 			sum_entry.version != version ||
 			le16_to_cpu(sum_entry.ofs_in_node) != idx_in_node) {
 
-		DBG(0, "summary_entry.nid         [0x%x]\n", le32_to_cpu(sum_entry.nid));
-		DBG(0, "summary_entry.version     [0x%x]\n", sum_entry.version);
-		DBG(0, "summary_entry.ofs_in_node [0x%x]\n", le16_to_cpu(sum_entry.ofs_in_node));
-
+		DBG(0, "summary_entry.nid         [0x%x]\n",
+					le32_to_cpu(sum_entry.nid));
+		DBG(0, "summary_entry.version     [0x%x]\n",
+					sum_entry.version);
+		DBG(0, "summary_entry.ofs_in_node [0x%x]\n",
+					le16_to_cpu(sum_entry.ofs_in_node));
 		DBG(0, "parent nid                [0x%x]\n", parent_nid);
 		DBG(0, "version from nat          [0x%x]\n", version);
 		DBG(0, "idx in parent node        [0x%x]\n", idx_in_node);
 
 		DBG(0, "Target data block addr    [0x%x]\n", blk_addr);
-		ASSERT_MSG(0, "Invalid data seg summary\n");
+		ASSERT_MSG("Invalid data seg summary\n");
 	}
-
 	return 1;
 }
 
@@ -161,13 +189,14 @@ int fsck_chk_node_blk(struct f2fs_sb_info *sbi,
 	struct f2fs_node *node_blk = NULL;
 	int ret = 0;
 
-	IS_VALID_NID(sbi, nid);
+	if (!IS_VALID_NID(sbi, nid))
+		ASSERT_MSG("nid is not valid. [0x%x]", nid);
 
 	if (ftype != F2FS_FT_ORPHAN ||
 			f2fs_test_bit(nid, fsck->nat_area_bitmap) != 0x0)
 		f2fs_clear_bit(nid, fsck->nat_area_bitmap);
 	else
-		ASSERT_MSG(0, "nid duplicated [0x%x]\n", nid);
+		ASSERT_MSG("nid duplicated [0x%x]\n", nid);
 
 	ret = get_node_info(sbi, nid, &ni);
 	ASSERT(ret >= 0);
@@ -188,12 +217,10 @@ int fsck_chk_node_blk(struct f2fs_sb_info *sbi,
 
 	is_valid_ssa_node_blk(sbi, nid, ni.blk_addr);
 
-	if (f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, ni.blk_addr), fsck->sit_area_bitmap) == 0x0) {
-		DBG(0, "SIT bitmap is 0x0. blk_addr[0x%x]\n", ni.blk_addr);
-		ASSERT(0);
-	}
+	if (f2fs_test_sit_bitmap(sbi, ni.blk_addr) == 0)
+		ASSERT_MSG("SIT bitmap is 0x0. blk_addr[0x%x]", ni.blk_addr);
 
-	if (f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, ni.blk_addr), fsck->main_area_bitmap) == 0x0) {
+	if (f2fs_test_main_bitmap(sbi, ni.blk_addr) == 0) {
 		fsck->chk.valid_blk_cnt++;
 		fsck->chk.valid_node_cnt++;
 	}
@@ -204,8 +231,8 @@ int fsck_chk_node_blk(struct f2fs_sb_info *sbi,
 	ret = dev_read_block(node_blk, ni.blk_addr);
 	ASSERT(ret >= 0);
 
-	ASSERT_MSG(nid == le32_to_cpu(node_blk->footer.nid),
-			"nid[0x%x] blk_addr[0x%x] footer.nid[0x%x]\n",
+	if (nid != le32_to_cpu(node_blk->footer.nid))
+		ASSERT_MSG("nid[0x%x] blk_addr[0x%x] footer.nid[0x%x]",
 			nid, ni.blk_addr, le32_to_cpu(node_blk->footer.nid));
 
 	if (ntype == TYPE_INODE) {
@@ -219,34 +246,23 @@ int fsck_chk_node_blk(struct f2fs_sb_info *sbi,
 		/* it's not inode */
 		ASSERT(node_blk->footer.nid != node_blk->footer.ino);
 
-		if (f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, ni.blk_addr), fsck->main_area_bitmap) != 0) {
-			DBG(0, "Duplicated node block. ino[0x%x][0x%x]\n", nid, ni.blk_addr);
-			ASSERT(0);
-		}
-		f2fs_set_bit(BLKOFF_FROM_MAIN(sbi, ni.blk_addr), fsck->main_area_bitmap);
+		if (f2fs_test_main_bitmap(sbi, ni.blk_addr) != 0)
+			ASSERT_MSG("Duplicated node blk. nid[0x%x][0x%x]\n",
+						nid, ni.blk_addr);
+
+		f2fs_set_main_bitmap(sbi, ni.blk_addr);
 
 		switch (ntype) {
 		case TYPE_DIRECT_NODE:
-			ret = fsck_chk_dnode_blk(sbi,
-					inode,
-					nid,
-					ftype,
-					node_blk,
-					blk_cnt,
-					&ni);
+			ret = fsck_chk_dnode_blk(sbi, inode, nid, ftype,
+					node_blk, blk_cnt, &ni);
 			break;
 		case TYPE_INDIRECT_NODE:
-			ret = fsck_chk_idnode_blk(sbi,
-					inode,
-					ftype,
-					node_blk,
+			ret = fsck_chk_idnode_blk(sbi, inode, ftype, node_blk,
 					blk_cnt);
 			break;
 		case TYPE_DOUBLE_INDIRECT_NODE:
-			ret = fsck_chk_didnode_blk(sbi,
-					inode,
-					ftype,
-					node_blk,
+			ret = fsck_chk_didnode_blk(sbi, inode, ftype, node_blk,
 					blk_cnt);
 			break;
 		default:
@@ -277,7 +293,7 @@ int fsck_chk_inode_blk(struct f2fs_sb_info *sbi,
 	ASSERT(node_blk->footer.nid == node_blk->footer.ino);
 	ASSERT(le32_to_cpu(node_blk->footer.nid) == nid);
 
-	if (f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, ni->blk_addr), fsck->main_area_bitmap) == 0x0)
+	if (f2fs_test_main_bitmap(sbi, ni->blk_addr) == 0)
 		fsck->chk.valid_inode_cnt++;
 
 	/* Orphan node. i_links should be 0 */
@@ -290,16 +306,16 @@ int fsck_chk_inode_blk(struct f2fs_sb_info *sbi,
 	if (ftype == F2FS_FT_DIR) {
 
 		/* not included '.' & '..' */
-		if (f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, ni->blk_addr), fsck->main_area_bitmap) != 0) {
-			DBG(0, "Duplicated inode blk. ino[0x%x][0x%x]\n", nid, ni->blk_addr);
+		if (f2fs_test_main_bitmap(sbi, ni->blk_addr) != 0) {
+			DBG(0, "Duplicated inode blk. ino[0x%x][0x%x]\n",
+							nid, ni->blk_addr);
 			ASSERT(0);
 		}
-		f2fs_set_bit(BLKOFF_FROM_MAIN(sbi, ni->blk_addr), fsck->main_area_bitmap);
+		f2fs_set_main_bitmap(sbi, ni->blk_addr);
 
 	} else {
-
-		if (f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, ni->blk_addr), fsck->main_area_bitmap) == 0x0) {
-			f2fs_set_bit(BLKOFF_FROM_MAIN(sbi, ni->blk_addr), fsck->main_area_bitmap);
+		if (f2fs_test_main_bitmap(sbi, ni->blk_addr) == 0) {
+			f2fs_set_main_bitmap(sbi, ni->blk_addr);
 			if (i_links > 1) {
 				/* First time. Create new hard link node */
 				add_into_hard_link_list(sbi, nid, i_links);
@@ -308,13 +324,14 @@ int fsck_chk_inode_blk(struct f2fs_sb_info *sbi,
 		} else {
 			if (i_links <= 1) {
 				DBG(0, "Error. Node ID [0x%x]."
-						" There are one more hard links."
-						" But i_links is [0x%x]\n",
+					" There are one more hard links."
+					" But i_links is [0x%x]\n",
 						nid, i_links);
 				ASSERT(0);
 			}
 
-			DBG(3, "ino[0x%x] has hard links [0x%x]\n", nid, i_links);
+			DBG(3, "ino[0x%x] has hard links [0x%x]\n",
+						nid, i_links);
 			ret = find_and_dec_hard_link_list(sbi, nid);
 			ASSERT(ret >= 0);
 
@@ -323,7 +340,8 @@ int fsck_chk_inode_blk(struct f2fs_sb_info *sbi,
 		}
 	}
 
-	fsck_chk_xattr_blk(sbi, nid, le32_to_cpu(node_blk->i.i_xattr_nid), blk_cnt);
+	fsck_chk_xattr_blk(sbi, nid,
+			le32_to_cpu(node_blk->i.i_xattr_nid), blk_cnt);
 
 	if (ftype == F2FS_FT_CHRDEV || ftype == F2FS_FT_BLKDEV ||
 			ftype == F2FS_FT_FIFO || ftype == F2FS_FT_SOCK)
@@ -339,13 +357,9 @@ int fsck_chk_inode_blk(struct f2fs_sb_info *sbi,
 			*blk_cnt = *blk_cnt + 1;
 			ret = fsck_chk_data_blk(sbi,
 					le32_to_cpu(node_blk->i.i_addr[idx]),
-					&child_cnt,
-					&child_files,
+					&child_cnt, &child_files,
 					(i_blocks == *blk_cnt),
-					ftype,
-					nid,
-					idx,
-					ni->version);
+					ftype, nid, idx, ni->version);
 			ASSERT(ret >= 0);
 		}
 	}
@@ -363,23 +377,23 @@ int fsck_chk_inode_blk(struct f2fs_sb_info *sbi,
 
 		if (le32_to_cpu(node_blk->i.i_nid[idx]) != 0) {
 			*blk_cnt = *blk_cnt + 1;
-			ret = fsck_chk_node_blk(sbi,
-					&node_blk->i,
+			ret = fsck_chk_node_blk(sbi, &node_blk->i,
 					le32_to_cpu(node_blk->i.i_nid[idx]),
-					ftype,
-					ntype,
-					blk_cnt);
+					ftype, ntype, blk_cnt);
 			ASSERT(ret >= 0);
 		}
 	}
 check:
 	if (ftype == F2FS_FT_DIR)
-		DBG(1, "Directory Inode: ino: %x name: %s depth: %d child files: %d\n\n",
-				le32_to_cpu(node_blk->footer.ino), node_blk->i.i_name,
-				le32_to_cpu(node_blk->i.i_current_depth), child_files);
+		DBG(1, "Directory Inode: 0x%x [%s] depth: %d has %d files\n\n",
+				le32_to_cpu(node_blk->footer.ino),
+				node_blk->i.i_name,
+				le32_to_cpu(node_blk->i.i_current_depth),
+				child_files);
 	if (ftype == F2FS_FT_ORPHAN)
-		DBG(1, "Orphan Inode: ino: %x name: %s i_blocks: %u\n\n",
-				le32_to_cpu(node_blk->footer.ino), node_blk->i.i_name,
+		DBG(1, "Orphan Inode: 0x%x [%s] i_blocks: %u\n\n",
+				le32_to_cpu(node_blk->footer.ino),
+				node_blk->i.i_name,
 				(u32)i_blocks);
 	if ((ftype == F2FS_FT_DIR && i_links != child_cnt) ||
 			(i_blocks != *blk_cnt)) {
@@ -395,13 +409,9 @@ out:
 	return 0;
 }
 
-int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi,
-		struct f2fs_inode *inode,
-		u32 nid,
-		enum FILE_TYPE ftype,
-		struct f2fs_node *node_blk,
-		u32 *blk_cnt,
-		struct node_info *ni)
+int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
+		u32 nid, enum FILE_TYPE ftype, struct f2fs_node *node_blk,
+		u32 *blk_cnt, struct node_info *ni)
 {
 	int idx;
 	u32 child_cnt = 0, child_files = 0;
@@ -411,24 +421,16 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi,
 			continue;
 		*blk_cnt = *blk_cnt + 1;
 		fsck_chk_data_blk(sbi,
-				le32_to_cpu(node_blk->dn.addr[idx]),
-				&child_cnt,
-				&child_files,
-				le64_to_cpu(inode->i_blocks) == *blk_cnt,
-				ftype,
-				nid,
-				idx,
-				ni->version);
+			le32_to_cpu(node_blk->dn.addr[idx]),
+			&child_cnt, &child_files,
+			le64_to_cpu(inode->i_blocks) == *blk_cnt, ftype,
+			nid, idx, ni->version);
 	}
-
 	return 0;
 }
 
-int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi,
-		struct f2fs_inode *inode,
-		enum FILE_TYPE ftype,
-		struct f2fs_node *node_blk,
-		u32 *blk_cnt)
+int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
+		enum FILE_TYPE ftype, struct f2fs_node *node_blk, u32 *blk_cnt)
 {
 	int i = 0;
 
@@ -436,22 +438,14 @@ int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi,
 		if (le32_to_cpu(node_blk->in.nid[i]) == 0x0)
 			continue;
 		*blk_cnt = *blk_cnt + 1;
-		fsck_chk_node_blk(sbi,
-				inode,
-				le32_to_cpu(node_blk->in.nid[i]),
-				ftype,
-				TYPE_DIRECT_NODE,
-				blk_cnt);
+		fsck_chk_node_blk(sbi, inode, le32_to_cpu(node_blk->in.nid[i]),
+				ftype, TYPE_DIRECT_NODE, blk_cnt);
 	}
-
 	return 0;
 }
 
-int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi,
-		struct f2fs_inode *inode,
-		enum FILE_TYPE ftype,
-		struct f2fs_node *node_blk,
-		u32 *blk_cnt)
+int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
+		enum FILE_TYPE ftype, struct f2fs_node *node_blk, u32 *blk_cnt)
 {
 	int i = 0;
 
@@ -459,14 +453,10 @@ int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi,
 		if (le32_to_cpu(node_blk->in.nid[i]) == 0x0)
 			continue;
 		*blk_cnt = *blk_cnt + 1;
-		fsck_chk_node_blk(sbi,
-				inode,
+		fsck_chk_node_blk(sbi, inode,
 				le32_to_cpu(node_blk->in.nid[i]),
-				ftype,
-				TYPE_INDIRECT_NODE,
-				blk_cnt);
+				ftype, TYPE_INDIRECT_NODE, blk_cnt);
 	}
-
 	return 0;
 }
 
@@ -510,11 +500,8 @@ static void print_dentry(__u32 depth, __u8 *name,
 				name, le32_to_cpu(de_blk->dentry[idx].ino));
 }
 
-int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi,
-		u32 blk_addr,
-		u32 *child_cnt,
-		u32 *child_files,
-		int last_blk)
+int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
+		u32 *child_cnt, u32 *child_files, int last_blk)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	int i;
@@ -537,7 +524,7 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi,
 	fsck->dentry_depth++;
 
 	for (i = 0; i < NR_DENTRY_IN_BLOCK;) {
-		if (test_bit(i, (unsigned long *)de_blk->dentry_bitmap) == 0x0) {
+		if (test_bit(i, (unsigned long *)de_blk->dentry_bitmap) == 0) {
 			i++;
 			continue;
 		}
@@ -555,15 +542,16 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi,
 		/* Becareful. 'dentry.file_type' is not imode. */
 		if (ftype == F2FS_FT_DIR) {
 			*child_cnt = *child_cnt + 1;
-			if ((name[0] == '.' && name[1] == '.' && name_len == 2) ||
-					(name[0] == '.' && name_len == 1)) {
+			if ((name[0] == '.' && name_len == 1) ||
+				(name[0] == '.' && name[1] == '.' &&
+							name_len == 2)) {
 				i++;
 				free(name);
 				continue;
 			}
 		}
 
-		DBG(1, "[%3u] - no[0x%x] name[%s] len[0x%x] ino[0x%x] type[0x%x]\n",
+		DBG(1, "[%3u]-[0x%x] name[%s] len[0x%x] ino[0x%x] type[0x%x]\n",
 				fsck->dentry_depth, i, name, name_len,
 				le32_to_cpu(de_blk->dentry[i].ino),
 				de_blk->dentry[i].file_type);
@@ -586,23 +574,19 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi,
 		free(name);
 	}
 
-	DBG(1, "[%3d] Dentry Block [0x%x] Done : dentries:%d in %d slots (len:%d)\n\n",
-			fsck->dentry_depth, blk_addr, dentries, NR_DENTRY_IN_BLOCK, F2FS_NAME_LEN);
+	DBG(1, "[%3d] Dentry Block [0x%x] Done : "
+				"dentries:%d in %d slots (len:%d)\n\n",
+			fsck->dentry_depth, blk_addr, dentries,
+			NR_DENTRY_IN_BLOCK, F2FS_NAME_LEN);
 	fsck->dentry_depth--;
 
 	free(de_blk);
 	return 0;
 }
 
-int fsck_chk_data_blk(struct f2fs_sb_info *sbi,
-		u32 blk_addr,
-		u32 *child_cnt,
-		u32 *child_files,
-		int last_blk,
-		enum FILE_TYPE ftype,
-		u32 parent_nid,
-		u16 idx_in_node,
-		u8 ver)
+int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
+		u32 *child_cnt, u32 *child_files, int last_blk,
+		enum FILE_TYPE ftype, u32 parent_nid, u16 idx_in_node, u8 ver)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 
@@ -616,24 +600,20 @@ int fsck_chk_data_blk(struct f2fs_sb_info *sbi,
 
 	is_valid_ssa_data_blk(sbi, blk_addr, parent_nid, idx_in_node, ver);
 
-	if (f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, blk_addr), fsck->sit_area_bitmap) == 0x0) {
-		ASSERT_MSG(0, "SIT bitmap is 0x0. blk_addr[0x%x]\n", blk_addr);
-	}
+	if (f2fs_test_sit_bitmap(sbi, blk_addr) == 0)
+		ASSERT_MSG("SIT bitmap is 0x0. blk_addr[0x%x]\n", blk_addr);
 
-	if (f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, blk_addr), fsck->main_area_bitmap) != 0) {
-		ASSERT_MSG(0, "Duplicated data block. pnid[0x%x] idx[0x%x] blk_addr[0x%x]\n",
-				parent_nid, idx_in_node, blk_addr);
-	}
-	f2fs_set_bit(BLKOFF_FROM_MAIN(sbi, blk_addr), fsck->main_area_bitmap);
+	if (f2fs_test_main_bitmap(sbi, blk_addr) != 0)
+		ASSERT_MSG("Duplicated data [0x%x]. pnid[0x%x] idx[0x%x]",
+				blk_addr, parent_nid, idx_in_node);
+
+	f2fs_set_main_bitmap(sbi, blk_addr);
 
 	fsck->chk.valid_blk_cnt++;
 
 	if (ftype == F2FS_FT_DIR) {
-		fsck_chk_dentry_blk(sbi,
-				blk_addr,
-				child_cnt,
-				child_files,
-				last_blk);
+		fsck_chk_dentry_blk(sbi, blk_addr, child_cnt,
+				child_files, last_blk);
 	}
 
 	return 0;
@@ -665,23 +645,18 @@ int fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 			nid_t ino = le32_to_cpu(orphan_blk->ino[j]);
 			DBG(1, "[%3d] ino [0x%x]\n", i, ino);
 			blk_cnt = 1;
-			ret = fsck_chk_node_blk(sbi,
-					NULL,
-					ino,
-					F2FS_FT_ORPHAN,
-					TYPE_INODE,
-					&blk_cnt);
+			ret = fsck_chk_node_blk(sbi, NULL, ino,
+					F2FS_FT_ORPHAN, TYPE_INODE, &blk_cnt);
 			ASSERT(ret >= 0);
 		}
 		memset(orphan_blk, 0, BLOCK_SZ);
 	}
 	free(orphan_blk);
-
-
 	return 0;
 }
 
-int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 ino, u32 x_nid, u32 *blk_cnt)
+int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 ino,
+					u32 x_nid, u32 *blk_cnt)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct node_info ni;
@@ -692,7 +667,7 @@ int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 ino, u32 x_nid, u32 *blk_cn
 	if (f2fs_test_bit(x_nid, fsck->nat_area_bitmap) != 0x0) {
 		f2fs_clear_bit(x_nid, fsck->nat_area_bitmap);
 	} else {
-		ASSERT_MSG(0, "xattr_nid duplicated [0x%x]\n", x_nid);
+		ASSERT_MSG("xattr_nid duplicated [0x%x]\n", x_nid);
 	}
 
 	*blk_cnt = *blk_cnt + 1;
@@ -701,12 +676,12 @@ int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 ino, u32 x_nid, u32 *blk_cn
 
 	ASSERT(get_node_info(sbi, x_nid, &ni) >= 0);
 
-	if (f2fs_test_bit(BLKOFF_FROM_MAIN(sbi, ni.blk_addr), fsck->main_area_bitmap) != 0) {
-		ASSERT_MSG(0, "Duplicated node block for x_attr. "
+	if (f2fs_test_main_bitmap(sbi, ni.blk_addr) != 0) {
+		ASSERT_MSG("Duplicated node block for x_attr. "
 				"x_nid[0x%x] block addr[0x%x]\n",
 				x_nid, ni.blk_addr);
 	}
-	f2fs_set_bit(BLKOFF_FROM_MAIN(sbi, ni.blk_addr), fsck->main_area_bitmap);
+	f2fs_set_main_bitmap(sbi, ni.blk_addr);
 
 	DBG(2, "ino[0x%x] x_nid[0x%x]\n", ino, x_nid);
 	return 0;
@@ -718,8 +693,10 @@ int fsck_init(struct f2fs_sb_info *sbi)
 	struct f2fs_sm_info *sm_i = SM_I(sbi);
 
 	/*
-	 * We build three bitmap for main/sit/nat so that may check consistency of filesystem.
-	 * 1. main_area_bitmap will be used to check whether all blocks of main area is used or not.
+	 * We build three bitmap for main/sit/nat so that may check consistency
+	 * of filesystem.
+	 * 1. main_area_bitmap will be used to check whether all blocks of main
+	 *    area is used or not.
 	 * 2. nat_area_bitmap has bitmap information of used nid in NAT.
 	 * 3. sit_area_bitmap has bitmap information of used main block.
 	 * At Last sequence, we compare main_area_bitmap with sit_area_bitmap.
@@ -774,7 +751,8 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	}
 
 	printf("[FSCK] SIT valid block bitmap checking                ");
-	if (memcmp(fsck->sit_area_bitmap, fsck->main_area_bitmap, fsck->sit_area_bitmap_sz) == 0x0) {
+	if (memcmp(fsck->sit_area_bitmap, fsck->main_area_bitmap,
+					fsck->sit_area_bitmap_sz) == 0x0) {
 		printf("[Ok..]\n");
 	} else {
 		printf("[Fail]\n");
diff --git a/fsck/fsck.h b/fsck/fsck.h
index e5a3841..dcb6656 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -76,72 +76,37 @@ enum seg_type {
 	SEG_TYPE_MAX,
 };
 
-extern int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 ino, u32 x_nid, u32 *blk_cnt);
-extern int fsck_chk_orphan_node(struct f2fs_sb_info *sbi);
-
-extern int fsck_chk_node_blk(struct f2fs_sb_info *sbi,
-		struct f2fs_inode *inode,
-		u32 nid,
-		enum FILE_TYPE ftype,
-		enum NODE_TYPE ntype,
-		u32 *blk_cnt);
-
-extern int fsck_chk_inode_blk(struct f2fs_sb_info *sbi,
-		u32 nid,
-		enum FILE_TYPE ftype,
-		struct f2fs_node *node_blk,
-		u32 *blk_cnt,
-		struct node_info *ni);
-
-extern int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi,
-		struct f2fs_inode *inode,
-		u32 nid,
-		enum FILE_TYPE ftype,
-		struct f2fs_node *node_blk,
-		u32 *blk_cnt,
-		struct node_info *ni);
-
-extern int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi,
-		struct f2fs_inode *inode,
-		enum FILE_TYPE ftype,
-		struct f2fs_node *node_blk,
-		u32 *blk_cnt);
-
-extern int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi,
-		struct f2fs_inode *inode,
-		enum FILE_TYPE ftype,
-		struct f2fs_node *node_blk,
-		u32 *blk_cnt);
-
-extern int fsck_chk_data_blk(struct f2fs_sb_info *sbi,
-		u32 blk_addr,
-		u32 *child_cnt,
-		u32 *child_files,
-		int last_blk,
-		enum FILE_TYPE ftype,
-		u32 parent_nid,
-		u16 idx_in_node,
-		u8 ver);
-
-extern int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi,
-		u32 blk_addr,
-		u32 *child_cnt,
-		u32 *child_files,
-		int last_blk);
-
-extern void print_node_info(struct f2fs_node *node_block);
-extern void print_inode_info(struct f2fs_inode *inode);
-extern struct seg_entry *get_seg_entry(struct f2fs_sb_info *sbi, unsigned int segno);
-extern int get_sum_block(struct f2fs_sb_info *sbi, unsigned int segno, struct f2fs_summary_block *sum_blk);
-extern int get_sum_entry(struct f2fs_sb_info *sbi, u32 blk_addr, struct f2fs_summary *sum_entry);
-extern int get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni);
-extern void build_nat_area_bitmap(struct f2fs_sb_info *sbi);
-extern int build_sit_area_bitmap(struct f2fs_sb_info *sbi);
-extern int fsck_init(struct f2fs_sb_info *sbi);
-extern int fsck_verify(struct f2fs_sb_info *sbi);
-extern void fsck_free(struct f2fs_sb_info *sbi);
-extern int f2fs_do_mount(struct f2fs_sb_info *sbi);
-extern void f2fs_do_umount(struct f2fs_sb_info *sbi);
+extern int fsck_chk_xattr_blk(struct f2fs_sb_info *, u32, u32, u32 *);
+extern int fsck_chk_orphan_node(struct f2fs_sb_info *);
+extern int fsck_chk_node_blk(struct f2fs_sb_info *, struct f2fs_inode *, u32,
+		enum FILE_TYPE, enum NODE_TYPE, u32 *);
+extern int fsck_chk_inode_blk(struct f2fs_sb_info *, u32, enum FILE_TYPE,
+		struct f2fs_node *, u32 *, struct node_info *);
+extern int fsck_chk_dnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
+		u32, enum FILE_TYPE, struct f2fs_node *, u32 *,
+		struct node_info *);
+extern int fsck_chk_idnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
+		enum FILE_TYPE, struct f2fs_node *, u32 *);
+extern int fsck_chk_didnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
+		enum FILE_TYPE, struct f2fs_node *, u32 *);
+extern int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32, u32 *, u32 *,
+		int, enum FILE_TYPE, u32, u16, u8);
+extern int fsck_chk_dentry_blk(struct f2fs_sb_info *, u32, u32 *, u32 *, int);
+
+extern void print_node_info(struct f2fs_node *);
+extern void print_inode_info(struct f2fs_inode *);
+extern struct seg_entry *get_seg_entry(struct f2fs_sb_info *, unsigned int);
+extern int get_sum_block(struct f2fs_sb_info *, unsigned int,
+				struct f2fs_summary_block *);
+extern int get_sum_entry(struct f2fs_sb_info *, u32, struct f2fs_summary *);
+extern int get_node_info(struct f2fs_sb_info *, nid_t, struct node_info *);
+extern void build_nat_area_bitmap(struct f2fs_sb_info *);
+extern int build_sit_area_bitmap(struct f2fs_sb_info *);
+extern int fsck_init(struct f2fs_sb_info *);
+extern int fsck_verify(struct f2fs_sb_info *);
+extern void fsck_free(struct f2fs_sb_info *);
+extern int f2fs_do_mount(struct f2fs_sb_info *);
+extern void f2fs_do_umount(struct f2fs_sb_info *);
 
 /* dump.c */
 struct dump_option {
@@ -153,9 +118,9 @@ struct dump_option {
 	int32_t blk_addr;
 };
 
-extern void sit_dump(struct f2fs_sb_info *sbi, int start_sit, int end_sit);
-extern void ssa_dump(struct f2fs_sb_info *sbi, int start_ssa, int end_ssa);
-extern int dump_node(struct f2fs_sb_info *sbi, nid_t nid);
-extern int dump_inode_from_blkaddr(struct f2fs_sb_info *sbi, u32 blk_addr);
+extern void sit_dump(struct f2fs_sb_info *, int, int);
+extern void ssa_dump(struct f2fs_sb_info *, int, int);
+extern int dump_node(struct f2fs_sb_info *, nid_t);
+extern int dump_inode_from_blkaddr(struct f2fs_sb_info *, u32);
 
 #endif /* _FSCK_H_ */
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 49911a0..dace9aa 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -54,39 +54,33 @@ typedef unsigned long	pgoff_t;
 /*
  * Debugging interfaces
  */
-#define ASSERT_MSG(exp, fmt, ...)					\
+#define ASSERT_MSG(fmt, ...)						\
 	do {								\
-		if (!(exp)) {						\
-			printf("\nAssertion failed!\n");		\
-			printf("[%s:%4d] " #exp, __func__, __LINE__);	\
-			printf("\n --> "fmt, ##__VA_ARGS__);		\
-			config.bug_on = 1;				\
-			exit(-1);					\
-		}							\
-	} while (0);
+		printf("[ASSERT] (%s:%4d) ", __func__, __LINE__);	\
+		printf(" --> "fmt"\n", ##__VA_ARGS__);			\
+		config.bug_on = 1;					\
+	} while (0)
 
 #define ASSERT(exp)							\
 	do {								\
 		if (!(exp)) {						\
-			printf("\nAssertion failed!\n");		\
-			printf("[%s:%4d] " #exp"\n", __func__, __LINE__);\
-			config.bug_on = 1;				\
+			printf("[ASSERT] (%s:%4d) " #exp"\n",		\
+					__func__, __LINE__);		\
 			exit(-1);					\
 		}							\
-	} while (0);
+	} while (0)
 
 #define ERR_MSG(fmt, ...)						\
 	do {								\
-		printf("[%s:%d] " fmt, __func__, __LINE__, ##__VA_ARGS__);	\
-	} while (0);
-
+		printf("[%s:%d] " fmt, __func__, __LINE__, ##__VA_ARGS__); \
+	} while (0)
 
 #define MSG(n, fmt, ...)						\
 	do {								\
 		if (config.dbg_lv >= n) {				\
 			printf(fmt, ##__VA_ARGS__);			\
 		}							\
-	} while (0);
+	} while (0)
 
 #define DBG(n, fmt, ...)						\
 	do {								\
@@ -94,52 +88,52 @@ typedef unsigned long	pgoff_t;
 			printf("[%s:%4d] " fmt,				\
 				__func__, __LINE__, ##__VA_ARGS__);	\
 		}							\
-	} while (0);
+	} while (0)
 
 /* Display on console */
 #define DISP(fmt, ptr, member)				\
 	do {						\
 		printf("%-30s" fmt, #member, ((ptr)->member));	\
-	} while (0);
+	} while (0)
 
 #define DISP_u32(ptr, member)						\
 	do {								\
 		assert(sizeof((ptr)->member) <= 4);			\
 		printf("%-30s" "\t\t[0x%8x : %u]\n",		\
-			#member, ((ptr)->member), ((ptr)->member) );	\
-	} while (0);
+			#member, ((ptr)->member), ((ptr)->member));	\
+	} while (0)
 
 #define DISP_u64(ptr, member)						\
 	do {								\
 		assert(sizeof((ptr)->member) == 8);			\
 		printf("%-30s" "\t\t[0x%8llx : %llu]\n",		\
-			#member, ((ptr)->member), ((ptr)->member) );	\
-	} while (0);
+			#member, ((ptr)->member), ((ptr)->member));	\
+	} while (0)
 
 #define DISP_utf(ptr, member)						\
 	do {								\
-		printf("%-30s" "\t\t[%s]\n", #member, ((ptr)->member) );	\
-	} while (0);
+		printf("%-30s" "\t\t[%s]\n", #member, ((ptr)->member)); \
+	} while (0)
 
 /* Display to buffer */
-#define BUF_DISP_u32(buf, data, len, ptr, member)					\
-	do {										\
-		assert(sizeof((ptr)->member) <= 4);					\
-		snprintf(buf, len, #member);						\
-		snprintf(data, len, "0x%x : %u", ((ptr)->member), ((ptr)->member));	\
-	} while (0);
-
-#define BUF_DISP_u64(buf, data, len, ptr, member)					\
-	do {										\
-		assert(sizeof((ptr)->member) == 8);					\
-		snprintf(buf, len, #member);						\
-		snprintf(data, len, "0x%llx : %llu", ((ptr)->member), ((ptr)->member));	\
-	} while (0);
-
-#define BUF_DISP_utf(buf, data, len, ptr, member)				\
-	do {									\
-		snprintf(buf, len, #member);					\
-	} while (0);
+#define BUF_DISP_u32(buf, data, len, ptr, member)			\
+	do {								\
+		assert(sizeof((ptr)->member) <= 4);			\
+		snprintf(buf, len, #member);				\
+		snprintf(data, len, "0x%x : %u", ((ptr)->member),	\
+						((ptr)->member));	\
+	} while (0)
+
+#define BUF_DISP_u64(buf, data, len, ptr, member)			\
+	do {								\
+		assert(sizeof((ptr)->member) == 8);			\
+		snprintf(buf, len, #member);				\
+		snprintf(data, len, "0x%llx : %llu", ((ptr)->member),	\
+						((ptr)->member));	\
+	} while (0)
+
+#define BUF_DISP_utf(buf, data, len, ptr, member)			\
+		snprintf(buf, len, #member)
 
 /* these are defined in kernel */
 #define PAGE_SIZE		4096
@@ -665,7 +659,8 @@ extern int test_bit(unsigned int nr, const void * addr);
 extern int f2fs_test_bit(unsigned int, const char *);
 extern int f2fs_set_bit(unsigned int, char *);
 extern int f2fs_clear_bit(unsigned int, char *);
-extern unsigned long find_next_bit(const unsigned long *, unsigned long, unsigned long);
+extern unsigned long find_next_bit(const unsigned long *,
+				unsigned long, unsigned long);
 
 extern u_int32_t f2fs_cal_crc32(u_int32_t, void *, int);
 extern int f2fs_crc_valid(u_int32_t blk_crc, void *buf, int len);
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
