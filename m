From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 06/17] fsck.f2fs: handle error cases
Date: Fri, 29 Aug 2014 17:28:53 -0700
Message-ID: <1409358544-54740-6-git-send-email-jaegeuk@kernel.org>
References: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XNWY4-0007MD-QW
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:44 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XNWY3-00025k-0H for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:44 +0000
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

Do sanity check first and then update metadata.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c       | 344 +++++++++++++++++++++++++++++-------------------------
 fsck/fsck.h       |  11 +-
 fsck/main.c       |  40 ++-----
 fsck/mount.c      |   3 +-
 include/f2fs_fs.h |   4 +
 5 files changed, 205 insertions(+), 197 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index d2781d9..9ebe2be 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -80,10 +80,8 @@ static int find_and_dec_hard_link_list(struct f2fs_sb_info *sbi, u32 nid)
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct hard_link_node *node = NULL, *prev = NULL;
 
-	if (fsck->hard_link_list_head == NULL) {
-		ASSERT(0);
-		return -1;
-	}
+	if (fsck->hard_link_list_head == NULL)
+		return -EINVAL;
 
 	node = fsck->hard_link_list_head;
 
@@ -92,10 +90,8 @@ static int find_and_dec_hard_link_list(struct f2fs_sb_info *sbi, u32 nid)
 		node = node->next;
 	}
 
-	if (node == NULL || (nid != node->nid)) {
-		ASSERT(0);
-		return -1;
-	}
+	if (node == NULL || (nid != node->nid))
+		return -EINVAL;
 
 	/* Decrease link count */
 	node->links = node->links - 1;
@@ -108,9 +104,7 @@ static int find_and_dec_hard_link_list(struct f2fs_sb_info *sbi, u32 nid)
 			prev->next = node->next;
 		free(node);
 	}
-
 	return 0;
-
 }
 
 static int is_valid_ssa_node_blk(struct f2fs_sb_info *sbi, u32 nid,
@@ -138,14 +132,16 @@ static int is_valid_ssa_node_blk(struct f2fs_sb_info *sbi, u32 nid,
 					le32_to_cpu(sum_entry.nid));
 			DBG(0, "--> node block's nid      [0x%x]\n", nid);
 			ASSERT_MSG("Invalid node seg summary\n");
+			return -EINVAL;
 		}
+		return 0;
 	} else if (ret == SEG_TYPE_CUR_NODE) {
 		/* current node segment has no ssa */
+		return 0;
 	} else {
 		ASSERT_MSG("Invalid return value of 'get_sum_entry'");
 	}
-
-	return 1;
+	return -EINVAL;
 }
 
 static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
@@ -177,114 +173,145 @@ static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 	return 1;
 }
 
-int fsck_chk_node_blk(struct f2fs_sb_info *sbi,
-		struct f2fs_inode *inode,
-		u32 nid,
-		enum FILE_TYPE ftype,
-		enum NODE_TYPE ntype,
-		u32 *blk_cnt)
+static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
+			struct f2fs_node *node_blk,
+			enum FILE_TYPE ftype, enum NODE_TYPE ntype,
+			struct node_info *ni)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
-	struct node_info ni;
-	struct f2fs_node *node_blk = NULL;
-	int ret = 0;
+	int ret;
 
 	if (!IS_VALID_NID(sbi, nid)) {
 		ASSERT_MSG("nid is not valid. [0x%x]", nid);
-		return 0;
+		return -EINVAL;
 	}
 
-	if (ftype != F2FS_FT_ORPHAN ||
-			f2fs_test_bit(nid, fsck->nat_area_bitmap) != 0x0)
-		f2fs_clear_bit(nid, fsck->nat_area_bitmap);
-	else
-		ASSERT_MSG("nid duplicated [0x%x]\n", nid);
+	get_node_info(sbi, nid, ni);
+	if (ni->blk_addr == NEW_ADDR) {
+		ASSERT_MSG("nid is NEW_ADDR. [0x%x]", nid);
+		return -EINVAL;
+	}
 
-	get_node_info(sbi, nid, &ni);
+	if (!IS_VALID_BLK_ADDR(sbi, ni->blk_addr)) {
+		ASSERT_MSG("blkaddres is not valid. [0x%x]", ni->blk_addr);
+		return -EINVAL;
+	}
 
-	/* Is it reserved block?
-	 * if block addresss was 0xffff,ffff,ffff,ffff
-	 * it means that block was already allocated, but not stored in disk
-	 */
-	if (ni.blk_addr == NEW_ADDR) {
-		fsck->chk.valid_blk_cnt++;
-		fsck->chk.valid_node_cnt++;
-		if (ntype == TYPE_INODE)
-			fsck->chk.valid_inode_cnt++;
-		return 0;
+	if (is_valid_ssa_node_blk(sbi, nid, ni->blk_addr)) {
+		ASSERT_MSG("summary node block is not valid. [0x%x]", nid);
+		return -EINVAL;
 	}
 
-	if (!IS_VALID_BLK_ADDR(sbi, ni.blk_addr)) {
-		ASSERT_MSG("blkaddres is not valid. [0x%x]", ni.blk_addr);
-		return 0;
+	ret = dev_read_block(node_blk, ni->blk_addr);
+	ASSERT(ret >= 0);
+
+	if (ntype == TYPE_INODE &&
+			node_blk->footer.nid != node_blk->footer.ino) {
+		ASSERT_MSG("nid[0x%x] footer.nid[0x%x] footer.ino[0x%x]",
+				nid, le32_to_cpu(node_blk->footer.nid),
+				le32_to_cpu(node_blk->footer.ino));
+		return -EINVAL;
+	}
+	if (ntype != TYPE_INODE &&
+			node_blk->footer.nid == node_blk->footer.ino) {
+		ASSERT_MSG("nid[0x%x] footer.nid[0x%x] footer.ino[0x%x]",
+				nid, le32_to_cpu(node_blk->footer.nid),
+				le32_to_cpu(node_blk->footer.ino));
+		return -EINVAL;
+	}
+
+	if (le32_to_cpu(node_blk->footer.nid) != nid) {
+		ASSERT_MSG("nid[0x%x] blk_addr[0x%x] footer.nid[0x%x]",
+				nid, ni->blk_addr,
+				le32_to_cpu(node_blk->footer.nid));
+		return -EINVAL;
+	}
+
+	if (ntype == TYPE_XATTR) {
+		u32 flag = le32_to_cpu(node_blk->footer.flag);
+
+		if ((flag >> OFFSET_BIT_SHIFT) != XATTR_NODE_OFFSET) {
+			ASSERT_MSG("xnid[0x%x] has wrong ofs:[0x%x]",
+					nid, flag);
+			return -EINVAL;
+		}
+	}
+
+	if ((ntype == TYPE_INODE && ftype == F2FS_FT_DIR) ||
+			(ntype == TYPE_XATTR && ftype == F2FS_FT_XATTR)) {
+		/* not included '.' & '..' */
+		if (f2fs_test_main_bitmap(sbi, ni->blk_addr) != 0) {
+			ASSERT_MSG("Duplicated node blk. nid[0x%x][0x%x]\n",
+					nid, ni->blk_addr);
+			return -EINVAL;
+		}
 	}
 
-	is_valid_ssa_node_blk(sbi, nid, ni.blk_addr);
+	/* workaround to fix later */
+	if (ftype != F2FS_FT_ORPHAN ||
+			f2fs_test_bit(nid, fsck->nat_area_bitmap) != 0)
+		f2fs_clear_bit(nid, fsck->nat_area_bitmap);
+	else
+		ASSERT_MSG("orphan or xattr nid is duplicated [0x%x]\n",
+				nid);
 
-	if (f2fs_test_sit_bitmap(sbi, ni.blk_addr) == 0)
-		ASSERT_MSG("SIT bitmap is 0x0. blk_addr[0x%x]", ni.blk_addr);
+	if (f2fs_test_sit_bitmap(sbi, ni->blk_addr) == 0)
+		ASSERT_MSG("SIT bitmap is 0x0. blk_addr[0x%x]",
+				ni->blk_addr);
 
-	if (f2fs_test_main_bitmap(sbi, ni.blk_addr) == 0) {
+	if (f2fs_test_main_bitmap(sbi, ni->blk_addr) == 0) {
 		fsck->chk.valid_blk_cnt++;
 		fsck->chk.valid_node_cnt++;
 	}
+	return 0;
+}
+
+int fsck_chk_node_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
+		u32 nid, enum FILE_TYPE ftype, enum NODE_TYPE ntype,
+		u32 *blk_cnt)
+{
+	struct node_info ni;
+	struct f2fs_node *node_blk = NULL;
 
 	node_blk = (struct f2fs_node *)calloc(BLOCK_SZ, 1);
 	ASSERT(node_blk != NULL);
 
-	ret = dev_read_block(node_blk, ni.blk_addr);
-	ASSERT(ret >= 0);
-
-	if (nid != le32_to_cpu(node_blk->footer.nid))
-		ASSERT_MSG("nid[0x%x] blk_addr[0x%x] footer.nid[0x%x]",
-			nid, ni.blk_addr, le32_to_cpu(node_blk->footer.nid));
+	if (sanity_check_nid(sbi, nid, node_blk, ftype, ntype, &ni))
+		goto err;
 
 	if (ntype == TYPE_INODE) {
-		ret = fsck_chk_inode_blk(sbi,
-				nid,
-				ftype,
-				node_blk,
-				blk_cnt,
-				&ni);
+		fsck_chk_inode_blk(sbi, nid, ftype, node_blk, blk_cnt, &ni);
 	} else {
-		/* it's not inode */
-		ASSERT(node_blk->footer.nid != node_blk->footer.ino);
-
-		if (f2fs_test_main_bitmap(sbi, ni.blk_addr) != 0)
-			ASSERT_MSG("Duplicated node blk. nid[0x%x][0x%x]\n",
-						nid, ni.blk_addr);
-
 		f2fs_set_main_bitmap(sbi, ni.blk_addr);
 
 		switch (ntype) {
 		case TYPE_DIRECT_NODE:
-			ret = fsck_chk_dnode_blk(sbi, inode, nid, ftype,
-					node_blk, blk_cnt, &ni);
+			fsck_chk_dnode_blk(sbi, inode, nid, ftype, node_blk,
+					blk_cnt, &ni);
 			break;
 		case TYPE_INDIRECT_NODE:
-			ret = fsck_chk_idnode_blk(sbi, inode, ftype, node_blk,
+			fsck_chk_idnode_blk(sbi, inode, ftype, node_blk,
 					blk_cnt);
 			break;
 		case TYPE_DOUBLE_INDIRECT_NODE:
-			ret = fsck_chk_didnode_blk(sbi, inode, ftype, node_blk,
+			fsck_chk_didnode_blk(sbi, inode, ftype, node_blk,
 					blk_cnt);
 			break;
 		default:
 			ASSERT(0);
 		}
 	}
-	ASSERT(ret >= 0);
-
 	free(node_blk);
 	return 0;
+err:
+	free(node_blk);
+	return -EINVAL;
 }
 
-int fsck_chk_inode_blk(struct f2fs_sb_info *sbi,
-		u32 nid,
-		enum FILE_TYPE ftype,
-		struct f2fs_node *node_blk,
-		u32 *blk_cnt,
-		struct node_info *ni)
+/* start with valid nid and blkaddr */
+void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
+		enum FILE_TYPE ftype, struct f2fs_node *node_blk,
+		u32 *blk_cnt, struct node_info *ni)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	u32 child_cnt = 0, child_files = 0;
@@ -292,31 +319,13 @@ int fsck_chk_inode_blk(struct f2fs_sb_info *sbi,
 	u32 i_links = le32_to_cpu(node_blk->i.i_links);
 	u64 i_blocks = le64_to_cpu(node_blk->i.i_blocks);
 	unsigned int idx = 0;
-	int ret = 0;
-
-	ASSERT(node_blk->footer.nid == node_blk->footer.ino);
-	ASSERT(le32_to_cpu(node_blk->footer.nid) == nid);
+	int ret;
 
 	if (f2fs_test_main_bitmap(sbi, ni->blk_addr) == 0)
 		fsck->chk.valid_inode_cnt++;
 
-	/* Orphan node. i_links should be 0 */
-	if (ftype == F2FS_FT_ORPHAN) {
-		ASSERT(i_links == 0);
-	} else {
-		ASSERT(i_links > 0);
-	}
-
 	if (ftype == F2FS_FT_DIR) {
-
-		/* not included '.' & '..' */
-		if (f2fs_test_main_bitmap(sbi, ni->blk_addr) != 0) {
-			DBG(0, "Duplicated inode blk. ino[0x%x][0x%x]\n",
-							nid, ni->blk_addr);
-			ASSERT(0);
-		}
 		f2fs_set_main_bitmap(sbi, ni->blk_addr);
-
 	} else {
 		if (f2fs_test_main_bitmap(sbi, ni->blk_addr) == 0) {
 			f2fs_set_main_bitmap(sbi, ni->blk_addr);
@@ -326,21 +335,15 @@ int fsck_chk_inode_blk(struct f2fs_sb_info *sbi,
 				fsck->chk.multi_hard_link_files++;
 			}
 		} else {
-			if (i_links <= 1) {
-				DBG(0, "Error. Node ID [0x%x]."
-					" There are one more hard links."
-					" But i_links is [0x%x]\n",
+			DBG(3, "[0x%x] has hard links [0x%x]\n", nid, i_links);
+			if (find_and_dec_hard_link_list(sbi, nid)) {
+				ASSERT_MSG("[0x%x] needs more i_links=0x%x",
 						nid, i_links);
-				ASSERT(0);
+				if (config.fix_cnt)
+					printf("TODO: i_links++\n");
 			}
-
-			DBG(3, "ino[0x%x] has hard links [0x%x]\n",
-						nid, i_links);
-			ret = find_and_dec_hard_link_list(sbi, nid);
-			ASSERT(ret >= 0);
-
 			/* No need to go deep into the node */
-			goto out;
+			return;
 		}
 	}
 
@@ -358,13 +361,13 @@ int fsck_chk_inode_blk(struct f2fs_sb_info *sbi,
 	/* check data blocks in inode */
 	for (idx = 0; idx < ADDRS_PER_INODE(&node_blk->i); idx++) {
 		if (le32_to_cpu(node_blk->i.i_addr[idx]) != 0) {
-			*blk_cnt = *blk_cnt + 1;
 			ret = fsck_chk_data_blk(sbi,
 					le32_to_cpu(node_blk->i.i_addr[idx]),
 					&child_cnt, &child_files,
 					(i_blocks == *blk_cnt),
 					ftype, nid, idx, ni->version);
-			ASSERT(ret >= 0);
+			if (!ret)
+				*blk_cnt = *blk_cnt + 1;
 		}
 	}
 
@@ -380,11 +383,13 @@ int fsck_chk_inode_blk(struct f2fs_sb_info *sbi,
 			ASSERT(0);
 
 		if (le32_to_cpu(node_blk->i.i_nid[idx]) != 0) {
-			*blk_cnt = *blk_cnt + 1;
 			ret = fsck_chk_node_blk(sbi, &node_blk->i,
 					le32_to_cpu(node_blk->i.i_nid[idx]),
 					ftype, ntype, blk_cnt);
-			ASSERT(ret >= 0);
+			if (!ret)
+				*blk_cnt = *blk_cnt + 1;
+			else if (config.fix_cnt)
+				printf("TODO delete i_nid[idx] = 0;\n");
 		}
 	}
 check:
@@ -400,35 +405,46 @@ check:
 				node_blk->i.i_name,
 				(u32)i_blocks);
 	if ((ftype == F2FS_FT_DIR && i_links != child_cnt) ||
-			(i_blocks != *blk_cnt)) {
-		print_node_info(node_blk);
+						(i_blocks != *blk_cnt)) {
+		if (!config.fix_cnt)
+			print_node_info(node_blk);
+
+		/* node_blk, ni.blkaddr, child_cnt, *blk_cnt */
+		if (config.fix_cnt)
+			printf("TODO fix_inode_block\n");
+		else
+			print_node_info(node_blk);
 		DBG(1, "blk   cnt [0x%x]\n", *blk_cnt);
 		DBG(1, "child cnt [0x%x]\n", child_cnt);
 	}
-
-	ASSERT(i_blocks == *blk_cnt);
-	if (ftype == F2FS_FT_DIR)
-		ASSERT(i_links == child_cnt);
-out:
-	return 0;
+	if (i_blocks != *blk_cnt)
+		ASSERT_MSG("ino: 0x%x has i_blocks: %lu, but has %u blocks",
+						nid, i_blocks, *blk_cnt);
+	if (ftype == F2FS_FT_DIR && i_links != child_cnt)
+		ASSERT_MSG("ino: 0x%x has i_links: %u but real links: %u",
+						nid, i_links, child_cnt);
+	if (ftype == F2FS_FT_ORPHAN && i_links)
+		ASSERT_MSG("ino: 0x%x is orphan inode, but has i_links: %u",
+						nid, i_links);
 }
 
 int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		u32 nid, enum FILE_TYPE ftype, struct f2fs_node *node_blk,
 		u32 *blk_cnt, struct node_info *ni)
 {
-	int idx;
+	int idx, ret;
 	u32 child_cnt = 0, child_files = 0;
 
 	for (idx = 0; idx < ADDRS_PER_BLOCK; idx++) {
 		if (le32_to_cpu(node_blk->dn.addr[idx]) == 0x0)
 			continue;
-		*blk_cnt = *blk_cnt + 1;
-		fsck_chk_data_blk(sbi,
+		ret = fsck_chk_data_blk(sbi,
 			le32_to_cpu(node_blk->dn.addr[idx]),
 			&child_cnt, &child_files,
 			le64_to_cpu(inode->i_blocks) == *blk_cnt, ftype,
 			nid, idx, ni->version);
+		if (!ret)
+			*blk_cnt = *blk_cnt + 1;
 	}
 	return 0;
 }
@@ -436,14 +452,19 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		enum FILE_TYPE ftype, struct f2fs_node *node_blk, u32 *blk_cnt)
 {
+	int ret;
 	int i = 0;
 
 	for (i = 0 ; i < NIDS_PER_BLOCK; i++) {
 		if (le32_to_cpu(node_blk->in.nid[i]) == 0x0)
 			continue;
-		*blk_cnt = *blk_cnt + 1;
-		fsck_chk_node_blk(sbi, inode, le32_to_cpu(node_blk->in.nid[i]),
+		ret = fsck_chk_node_blk(sbi, inode,
+				le32_to_cpu(node_blk->in.nid[i]),
 				ftype, TYPE_DIRECT_NODE, blk_cnt);
+		if (!ret)
+			*blk_cnt = *blk_cnt + 1;
+		else if (ret == -EINVAL)
+			printf("delete in.nid[i] = 0;\n");
 	}
 	return 0;
 }
@@ -452,14 +473,18 @@ int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		enum FILE_TYPE ftype, struct f2fs_node *node_blk, u32 *blk_cnt)
 {
 	int i = 0;
+	int ret = 0;
 
 	for (i = 0; i < NIDS_PER_BLOCK; i++) {
 		if (le32_to_cpu(node_blk->in.nid[i]) == 0x0)
 			continue;
-		*blk_cnt = *blk_cnt + 1;
-		fsck_chk_node_blk(sbi, inode,
+		ret = fsck_chk_node_blk(sbi, inode,
 				le32_to_cpu(node_blk->in.nid[i]),
 				ftype, TYPE_INDIRECT_NODE, blk_cnt);
+		if (!ret)
+			*blk_cnt = *blk_cnt + 1;
+		else if (ret == -EINVAL)
+			printf("delete in.nid[i] = 0;\n");
 	}
 	return 0;
 }
@@ -570,7 +595,8 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 				TYPE_INODE,
 				&blk_cnt);
 
-		ASSERT(ret >= 0);
+		if (ret)
+			printf("TODO: delete dentry\n");
 
 		i += (name_len + F2FS_SLOT_LEN - 1) / F2FS_SLOT_LEN;
 		dentries++;
@@ -618,35 +644,34 @@ int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 
 	fsck->chk.valid_blk_cnt++;
 
-	if (ftype == F2FS_FT_DIR) {
-		fsck_chk_dentry_blk(sbi, blk_addr, child_cnt,
+	if (ftype == F2FS_FT_DIR)
+		return fsck_chk_dentry_blk(sbi, blk_addr, child_cnt,
 				child_files, last_blk);
-	}
-
 	return 0;
 }
 
-int fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
+void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 {
-	int ret = 0;
 	u32 blk_cnt = 0;
-
 	block_t start_blk, orphan_blkaddr, i, j;
 	struct f2fs_orphan_block *orphan_blk;
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 
 	if (!is_set_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG))
-		return 0;
+		return;
+
+	if (config.fix_cnt)
+		return;
 
 	start_blk = __start_cp_addr(sbi) + 1 +
 		le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);
-
 	orphan_blkaddr = __start_sum_addr(sbi) - 1;
-
 	orphan_blk = calloc(BLOCK_SZ, 1);
 
 	for (i = 0; i < orphan_blkaddr; i++) {
-		dev_read_block(orphan_blk, start_blk + i);
+		int ret = dev_read_block(orphan_blk, start_blk + i);
+
+		ASSERT(ret >= 0);
 
 		for (j = 0; j < le32_to_cpu(orphan_blk->entry_count); j++) {
 			nid_t ino = le32_to_cpu(orphan_blk->ino[j]);
@@ -654,47 +679,42 @@ int fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 			blk_cnt = 1;
 			ret = fsck_chk_node_blk(sbi, NULL, ino,
 					F2FS_FT_ORPHAN, TYPE_INODE, &blk_cnt);
-			ASSERT(ret >= 0);
+			if (ret == -EINVAL)
+				printf("TODO: nothing?\n");
 		}
 		memset(orphan_blk, 0, BLOCK_SZ);
 	}
 	free(orphan_blk);
-	return 0;
 }
 
-int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 ino,
-					u32 x_nid, u32 *blk_cnt)
+void fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 ino,
+		u32 x_nid, u32 *blk_cnt)
 {
-	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct f2fs_node *node_blk = NULL;
 	struct node_info ni;
 
 	if (x_nid == 0x0)
-		return 0;
+		return;
 
-	if (f2fs_test_bit(x_nid, fsck->nat_area_bitmap) != 0x0) {
-		f2fs_clear_bit(x_nid, fsck->nat_area_bitmap);
-	} else {
-		ASSERT_MSG("xattr_nid duplicated [0x%x]\n", x_nid);
+	node_blk = (struct f2fs_node *)calloc(BLOCK_SZ, 1);
+	ASSERT(node_blk != NULL);
+
+	/* Sanity check */
+	if (sanity_check_nid(sbi, x_nid, node_blk,
+				F2FS_FT_XATTR, TYPE_XATTR, &ni)) {
+		/* TODO: drop xattr node */
+		printf("drop xattr node\n");
+		goto out;
 	}
 
 	*blk_cnt = *blk_cnt + 1;
-	fsck->chk.valid_blk_cnt++;
-	fsck->chk.valid_node_cnt++;
-
-	get_node_info(sbi, x_nid, &ni);
-
-	if (f2fs_test_main_bitmap(sbi, ni.blk_addr) != 0) {
-		ASSERT_MSG("Duplicated node block for x_attr. "
-				"x_nid[0x%x] block addr[0x%x]\n",
-				x_nid, ni.blk_addr);
-	}
 	f2fs_set_main_bitmap(sbi, ni.blk_addr);
-
 	DBG(2, "ino[0x%x] x_nid[0x%x]\n", ino, x_nid);
-	return 0;
+out:
+	free(node_blk);
 }
 
-int fsck_init(struct f2fs_sb_info *sbi)
+void fsck_init(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct f2fs_sm_info *sm_i = SM_I(sbi);
@@ -718,7 +738,7 @@ int fsck_init(struct f2fs_sb_info *sbi)
 	build_sit_area_bitmap(sbi);
 
 	tree_mark = calloc(tree_mark_size, 1);
-	return 0;
+	ASSERT(tree_mark != NULL);
 }
 
 int fsck_verify(struct f2fs_sb_info *sbi)
diff --git a/fsck/fsck.h b/fsck/fsck.h
index b673646..aecfa9a 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -59,7 +59,8 @@ enum NODE_TYPE {
 	TYPE_INODE = 37,
 	TYPE_DIRECT_NODE = 43,
 	TYPE_INDIRECT_NODE = 53,
-	TYPE_DOUBLE_INDIRECT_NODE = 67
+	TYPE_DOUBLE_INDIRECT_NODE = 67,
+	TYPE_XATTR = 77
 };
 
 struct hard_link_node {
@@ -76,11 +77,11 @@ enum seg_type {
 	SEG_TYPE_MAX,
 };
 
-extern int fsck_chk_xattr_blk(struct f2fs_sb_info *, u32, u32, u32 *);
-extern int fsck_chk_orphan_node(struct f2fs_sb_info *);
+extern void fsck_chk_xattr_blk(struct f2fs_sb_info *, u32, u32, u32 *);
+extern void fsck_chk_orphan_node(struct f2fs_sb_info *);
 extern int fsck_chk_node_blk(struct f2fs_sb_info *, struct f2fs_inode *, u32,
 		enum FILE_TYPE, enum NODE_TYPE, u32 *);
-extern int fsck_chk_inode_blk(struct f2fs_sb_info *, u32, enum FILE_TYPE,
+extern void fsck_chk_inode_blk(struct f2fs_sb_info *, u32, enum FILE_TYPE,
 		struct f2fs_node *, u32 *, struct node_info *);
 extern int fsck_chk_dnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
 		u32, enum FILE_TYPE, struct f2fs_node *, u32 *,
@@ -102,7 +103,7 @@ extern int get_sum_entry(struct f2fs_sb_info *, u32, struct f2fs_summary *);
 extern void get_node_info(struct f2fs_sb_info *, nid_t, struct node_info *);
 extern void build_nat_area_bitmap(struct f2fs_sb_info *);
 extern int build_sit_area_bitmap(struct f2fs_sb_info *);
-extern int fsck_init(struct f2fs_sb_info *);
+extern void fsck_init(struct f2fs_sb_info *);
 extern int fsck_verify(struct f2fs_sb_info *);
 extern void fsck_free(struct f2fs_sb_info *);
 extern int f2fs_do_mount(struct f2fs_sb_info *);
diff --git a/fsck/main.c b/fsck/main.c
index 266e9b5..7e3bb49 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -131,44 +131,29 @@ void f2fs_parse_options(int argc, char *argv[])
 	config.device_name = argv[optind];
 }
 
-int do_fsck(struct f2fs_sb_info *sbi)
+static void do_fsck(struct f2fs_sb_info *sbi)
 {
 	u32 blk_cnt;
-	int ret;
 
 	config.bug_on = 0;
 
-	ret = fsck_init(sbi);
-	if (ret < 0)
-		return ret;
+	fsck_init(sbi);
 
 	fsck_chk_orphan_node(sbi);
 
 	/* Traverse all block recursively from root inode */
 	blk_cnt = 1;
-	ret = fsck_chk_node_blk(sbi,
-			NULL,
-			sbi->root_ino_num,
-			F2FS_FT_DIR,
-			TYPE_INODE,
-			&blk_cnt);
-	if (ret < 0)
-		goto out1;
-
-	ret = fsck_verify(sbi);
-out1:
+	fsck_chk_node_blk(sbi, NULL, sbi->root_ino_num,
+			F2FS_FT_DIR, TYPE_INODE, &blk_cnt);
+	fsck_verify(sbi);
 	fsck_free(sbi);
-	return ret;
 }
 
-int do_dump(struct f2fs_sb_info *sbi)
+static void do_dump(struct f2fs_sb_info *sbi)
 {
 	struct dump_option *opt = (struct dump_option *)config.private;
-	int ret;
 
-	ret = fsck_init(sbi);
-	if (ret < 0)
-		return ret;
+	fsck_init(sbi);
 
 	if (opt->end_sit == -1)
 		opt->end_sit = SM_I(sbi)->main_segments;
@@ -182,15 +167,12 @@ int do_dump(struct f2fs_sb_info *sbi)
 		dump_inode_from_blkaddr(sbi, opt->blk_addr);
 		goto cleanup;
 	}
-
 	dump_node(sbi, opt->nid);
-
 cleanup:
 	fsck_free(sbi);
-	return 0;
 }
 
-int main (int argc, char **argv)
+int main(int argc, char **argv)
 {
 	struct f2fs_sb_info *sbi;
 	int ret = 0;
@@ -215,10 +197,10 @@ fsck_again:
 
 	switch (config.func) {
 	case FSCK:
-		ret = do_fsck(sbi);
+		do_fsck(sbi);
 		break;
 	case DUMP:
-		ret = do_dump(sbi);
+		do_dump(sbi);
 		break;
 	}
 
@@ -248,5 +230,5 @@ retry:
 	f2fs_finalize_device(&config);
 
 	printf("\nDone.\n");
-	return ret;
+	return 0;
 }
diff --git a/fsck/mount.c b/fsck/mount.c
index ab5f7f3..a766157 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1020,7 +1020,8 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 			struct node_info ni;
 			ni.nid = nid + i;
 
-			if ((nid + i) == F2FS_NODE_INO(sbi) || (nid + i) == F2FS_META_INO(sbi)) {
+			if ((nid + i) == F2FS_NODE_INO(sbi) ||
+					(nid + i) == F2FS_META_INO(sbi)) {
 				ASSERT(nat_block->entries[i].block_addr != 0x0);
 				continue;
 			}
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index dace9aa..c3cc2aa 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -413,6 +413,9 @@ enum {
 	OFFSET_BIT_SHIFT
 };
 
+#define XATTR_NODE_OFFSET	((((unsigned int)-1) << OFFSET_BIT_SHIFT) \
+				>> OFFSET_BIT_SHIFT)
+
 struct node_footer {
 	__le32 nid;		/* node id */
 	__le32 ino;		/* inode nunmber */
@@ -640,6 +643,7 @@ enum FILE_TYPE {
 	F2FS_FT_MAX,
 	/* added for fsck */
 	F2FS_FT_ORPHAN,
+	F2FS_FT_XATTR,
 };
 
 /* from f2fs/segment.h */
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
