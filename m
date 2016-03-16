From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] fsck.f2fs: refactor extent info verification flow
Date: Wed, 16 Mar 2016 11:07:07 +0800
Message-ID: <01b701d17f31$118fd920$34af8b60$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ag1or-0002QL-Ti
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Mar 2016 03:08:21 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ag1op-0001Wu-Jx
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Mar 2016 03:08:21 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O4402SGZ3D7BO80@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Mar 2016 12:08:11 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

There are some issues in original approach:
- memory allocated in i_extent.map will leak
- do not convert fields in i_ext from on-disk format to cpu format
- do not support checking file offset with extent info

This patch refactors the flow for fixing above issues and supporting
file offset check.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fsck/fsck.c | 120 ++++++++++++++++++++++++++++++++++++++----------------------
 fsck/fsck.h |  28 +++++++-------
 fsck/main.c |   2 +-
 3 files changed, 93 insertions(+), 57 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index acdd5d4..aaaa95b 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -494,8 +494,7 @@ out:
 
 int fsck_chk_node_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		u32 nid, u8 *name, enum FILE_TYPE ftype, enum NODE_TYPE ntype,
-		u32 *blk_cnt, struct child_info *child,
-		struct extent_info *i_ext)
+		u32 *blk_cnt, struct child_info *child)
 {
 	struct node_info ni;
 	struct f2fs_node *node_blk = NULL;
@@ -514,19 +513,19 @@ int fsck_chk_node_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			f2fs_set_main_bitmap(sbi, ni.blk_addr,
 							CURSEG_WARM_NODE);
 			fsck_chk_dnode_blk(sbi, inode, nid, ftype, node_blk,
-					blk_cnt, child, &ni, i_ext);
+					blk_cnt, child, &ni);
 			break;
 		case TYPE_INDIRECT_NODE:
 			f2fs_set_main_bitmap(sbi, ni.blk_addr,
 							CURSEG_COLD_NODE);
 			fsck_chk_idnode_blk(sbi, inode, ftype, node_blk,
-					blk_cnt, child, i_ext);
+					blk_cnt, child);
 			break;
 		case TYPE_DOUBLE_INDIRECT_NODE:
 			f2fs_set_main_bitmap(sbi, ni.blk_addr,
 							CURSEG_COLD_NODE);
 			fsck_chk_didnode_blk(sbi, inode, ftype, node_blk,
-					blk_cnt, child, i_ext);
+					blk_cnt, child);
 			break;
 		default:
 			ASSERT(0);
@@ -539,24 +538,62 @@ err:
 	return -EINVAL;
 }
 
-static void update_i_extent(struct extent_info *i_ext, block_t blkaddr)
+static inline void get_extent_info(struct extent_info *ext,
+					struct f2fs_extent *i_ext)
 {
-	block_t end_addr;
+	ext->fofs = le32_to_cpu(i_ext->fofs);
+	ext->blk = le32_to_cpu(i_ext->blk_addr);
+	ext->len = le32_to_cpu(i_ext->len);
+}
+
+static void check_extent_info(struct child_info *child,
+						block_t blkaddr, int last)
+{
+	struct extent_info *ei = &child->ei;
+	u32 pgofs = child->pgofs;
+	int is_hole = 0;
+
+	if (!ei->len)
+		return;
 
-	if (!i_ext)
+	if (child->state & FSCK_UNMATCHED_EXTENT)
 		return;
 
-	end_addr = i_ext->ext.blk_addr + i_ext->ext.len;
+	if (last) {
+		/* hole exist in the back of extent */
+		if (child->last_blk != ei->blk + ei->len - 1)
+			child->state |= FSCK_UNMATCHED_EXTENT;
+		return;
+	}
 
-	/* TODO: check its file offset later */
-	if (blkaddr >= i_ext->ext.blk_addr && blkaddr < end_addr) {
-		unsigned int offset = blkaddr - i_ext->ext.blk_addr;
+	if (blkaddr == NULL_ADDR || blkaddr == NEW_ADDR)
+		is_hole = 1;
 
-		if (f2fs_set_bit(offset, i_ext->map))
-			i_ext->fail = 1;
-		else
-			i_ext->len--;
+	if (pgofs >= ei->fofs && pgofs < ei->fofs + ei->len) {
+		/* unmatched blkaddr */
+		if (is_hole || (blkaddr != pgofs - ei->fofs + ei->blk))
+			goto unmatched;
+
+		if (!child->last_blk) {
+			/* hole exists in the front of extent */
+			if (pgofs != ei->fofs)
+				goto unmatched;
+		} else if (child->last_blk + 1 != blkaddr) {
+			/* hole exists in the middle of extent */
+			goto unmatched;
+		}
+		child->last_blk = blkaddr;
+		return;
 	}
+
+	if (is_hole)
+		return;
+
+	if (blkaddr < ei->blk || blkaddr >= ei->blk + ei->len)
+		return;
+	/* unmatched file offset */
+unmatched:
+	child->state |= FSCK_UNMATCHED_EXTENT;
 }
 
 /* start with valid nid and blkaddr */
@@ -565,14 +602,13 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		u32 *blk_cnt, struct node_info *ni)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
-	struct child_info child = {2, 0, 0, 0};
+	struct child_info child = {0, 2, 0, 0, 0, 0};
 	enum NODE_TYPE ntype;
 	u32 i_links = le32_to_cpu(node_blk->i.i_links);
 	u64 i_blocks = le64_to_cpu(node_blk->i.i_blocks);
 	child.p_ino = nid;
 	child.pp_ino = le32_to_cpu(node_blk->i.i_pino);
 	child.dir_level = node_blk->i.i_dir_level;
-	struct extent_info i_extent;
 	unsigned int idx = 0;
 	int need_fix = 0;
 	int ret;
@@ -670,20 +706,18 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		}
 	}
 
-	i_extent.ext = node_blk->i.i_ext;
-	i_extent.len = le32_to_cpu(i_extent.ext.len);
-	i_extent.fail = 0;
-	if (i_extent.len) {
-		/* max 126KB */
-		i_extent.map = calloc(i_extent.len, 1);
-		ASSERT(i_extent.map != NULL);
-	}
+	/* init extent info */
+	get_extent_info(&child.ei, &node_blk->i.i_ext);
+	child.last_blk = 0;
 
 	/* check data blocks in inode */
 	for (idx = 0; idx < ADDRS_PER_INODE(&node_blk->i);
 						idx++, child.pgofs++) {
 		block_t blkaddr = le32_to_cpu(node_blk->i.i_addr[idx]);
 
+		/* check extent info */
+		check_extent_info(&child, blkaddr, 0);
+
 		if (blkaddr != 0) {
 			ret = fsck_chk_data_blk(sbi,
 					blkaddr,
@@ -692,7 +726,6 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 					file_is_encrypt(node_blk->i.i_advise));
 			if (!ret) {
 				*blk_cnt = *blk_cnt + 1;
-				update_i_extent(&i_extent, blkaddr);
 			} else if (config.fix_on) {
 				node_blk->i.i_addr[idx] = 0;
 				need_fix = 1;
@@ -719,8 +752,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 
 		ret = fsck_chk_node_blk(sbi, &node_blk->i,
 				blkaddr,
-				NULL, ftype, ntype, blk_cnt, &child,
-				&i_extent);
+				NULL, ftype, ntype, blk_cnt, &child);
 		if (!ret) {
 			*blk_cnt = *blk_cnt + 1;
 		} else if (ret == -EINVAL) {
@@ -740,9 +772,13 @@ skip:
 		}
 
 	}
-	if (i_extent.len || i_extent.fail) {
-		ASSERT_MSG("ino: 0x%x has wrong ext: untouched=%d, overlap=%d",
-					nid, i_extent.len, i_extent.fail);
+
+	/* check uncovered range in the back of extent */
+	check_extent_info(&child, 0, 1);
+
+	if (child.state & FSCK_UNMATCHED_EXTENT) {
+		ASSERT_MSG("ino: 0x%x has wrong ext: [pgofs:%u, blk:%u, len:%u]",
+				nid, child.ei.fofs, child.ei.blk, child.ei.len);
 		if (config.fix_on)
 			need_fix = 1;
 	}
@@ -814,8 +850,7 @@ skip_blkcnt_fix:
 
 int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		u32 nid, enum FILE_TYPE ftype, struct f2fs_node *node_blk,
-		u32 *blk_cnt, struct child_info *child, struct node_info *ni,
-		struct extent_info *i_ext)
+		u32 *blk_cnt, struct child_info *child, struct node_info *ni)
 {
 	int idx, ret;
 	int need_fix = 0;
@@ -825,6 +860,8 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 	for (idx = 0; idx < ADDRS_PER_BLOCK; idx++, child->pgofs++) {
 		block_t blkaddr = le32_to_cpu(node_blk->dn.addr[idx]);
 
+		check_extent_info(child, blkaddr, 0);
+
 		if (blkaddr == 0x0)
 			continue;
 		ret = fsck_chk_data_blk(sbi,
@@ -834,7 +871,6 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			file_is_encrypt(inode->i_advise));
 		if (!ret) {
 			*blk_cnt = *blk_cnt + 1;
-			update_i_extent(i_ext, blkaddr);
 		} else if (config.fix_on) {
 			node_blk->dn.addr[idx] = 0;
 			need_fix = 1;
@@ -850,7 +886,7 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 
 int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		enum FILE_TYPE ftype, struct f2fs_node *node_blk, u32 *blk_cnt,
-		struct child_info *child, struct extent_info *i_ext)
+		struct child_info *child)
 {
 	int need_fix = 0, ret;
 	int i = 0;
@@ -860,8 +896,7 @@ int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			goto skip;
 		ret = fsck_chk_node_blk(sbi, inode,
 				le32_to_cpu(node_blk->in.nid[i]), NULL,
-				ftype, TYPE_DIRECT_NODE, blk_cnt, child,
-				i_ext);
+				ftype, TYPE_DIRECT_NODE, blk_cnt, child);
 		if (!ret)
 			*blk_cnt = *blk_cnt + 1;
 		else if (ret == -EINVAL) {
@@ -891,7 +926,7 @@ skip:
 
 int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		enum FILE_TYPE ftype, struct f2fs_node *node_blk, u32 *blk_cnt,
-		struct child_info *child, struct extent_info *i_ext)
+		struct child_info *child)
 {
 	int i = 0;
 	int need_fix = 0, ret = 0;
@@ -901,8 +936,7 @@ int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			goto skip;
 		ret = fsck_chk_node_blk(sbi, inode,
 				le32_to_cpu(node_blk->in.nid[i]), NULL,
-				ftype, TYPE_INDIRECT_NODE, blk_cnt, child,
-				i_ext);
+				ftype, TYPE_INDIRECT_NODE, blk_cnt, child);
 		if (!ret)
 			*blk_cnt = *blk_cnt + 1;
 		else if (ret == -EINVAL) {
@@ -1295,7 +1329,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 		blk_cnt = 1;
 		ret = fsck_chk_node_blk(sbi,
 				NULL, le32_to_cpu(dentry[i].ino), name,
-				ftype, TYPE_INODE, &blk_cnt, NULL, NULL);
+				ftype, TYPE_INODE, &blk_cnt, NULL);
 
 		if (ret && config.fix_on) {
 			int j;
@@ -1461,7 +1495,7 @@ void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 			blk_cnt = 1;
 			ret = fsck_chk_node_blk(sbi, NULL, ino, NULL,
 					F2FS_FT_ORPHAN, TYPE_INODE, &blk_cnt,
-					NULL, NULL);
+					NULL);
 			if (!ret)
 				new_blk->ino[new_entry_count++] =
 							orphan_blk->ino[j];
diff --git a/fsck/fsck.h b/fsck/fsck.h
index b92a1e0..45e4366 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -13,13 +13,22 @@
 
 #include "f2fs.h"
 
+#define FSCK_UNMATCHED_EXTENT		0x00000001
+
 /* fsck.c */
 struct orphan_info {
 	u32 nr_inodes;
 	u32 *ino_list;
 };
 
+struct extent_info {
+	u32 fofs;		/* start offset in a file */
+	u32 blk;		/* start block address of the extent */
+	u32 len;		/* length of the extent */
+};
+
 struct child_info {
+	u32 state;
 	u32 links;
 	u32 files;
 	u32 pgofs;
@@ -27,13 +36,8 @@ struct child_info {
 	u8 dir_level;
 	u32 p_ino;		/*parent ino*/
 	u32 pp_ino;		/*parent parent ino*/
-};
-
-struct extent_info {
-	struct f2fs_extent ext;
-	char *map;
-	int len;
-	int fail;
+	struct extent_info ei;
+	u32 last_blk;
 };
 
 struct f2fs_fsck {
@@ -99,18 +103,16 @@ enum seg_type {
 extern void fsck_chk_orphan_node(struct f2fs_sb_info *);
 extern int fsck_chk_node_blk(struct f2fs_sb_info *, struct f2fs_inode *, u32,
 		u8 *, enum FILE_TYPE, enum NODE_TYPE, u32 *,
-		struct child_info *, struct extent_info *);
+		struct child_info *);
 extern void fsck_chk_inode_blk(struct f2fs_sb_info *, u32, enum FILE_TYPE,
 		struct f2fs_node *, u32 *, struct node_info *);
 extern int fsck_chk_dnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
 		u32, enum FILE_TYPE, struct f2fs_node *, u32 *,
-		struct child_info *, struct node_info *, struct extent_info *);
+		struct child_info *, struct node_info *);
 extern int fsck_chk_idnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
-		enum FILE_TYPE, struct f2fs_node *, u32 *, struct child_info *,
-		struct extent_info *);
+		enum FILE_TYPE, struct f2fs_node *, u32 *, struct child_info *);
 extern int fsck_chk_didnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
-		enum FILE_TYPE, struct f2fs_node *, u32 *, struct child_info *,
-		struct extent_info *);
+		enum FILE_TYPE, struct f2fs_node *, u32 *, struct child_info *);
 extern int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32, struct child_info *,
 		int, enum FILE_TYPE, u32, u16, u8, int);
 extern int fsck_chk_dentry_blk(struct f2fs_sb_info *, u32, struct child_info *,
diff --git a/fsck/main.c b/fsck/main.c
index 54dbb2d..0e23c81 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -218,7 +218,7 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 	/* Traverse all block recursively from root inode */
 	blk_cnt = 1;
 	fsck_chk_node_blk(sbi, NULL, sbi->root_ino_num, (u8 *)"/",
-			F2FS_FT_DIR, TYPE_INODE, &blk_cnt, NULL, NULL);
+			F2FS_FT_DIR, TYPE_INODE, &blk_cnt, NULL);
 	fsck_verify(sbi);
 	fsck_free(sbi);
 }
-- 
2.7.0



------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785231&iu=/4140
