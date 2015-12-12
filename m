From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/6] fsck.f2fs: sanity_check for extent_cache
	entry
Date: Fri, 11 Dec 2015 16:00:10 -0800
Message-ID: <1449878414-41254-2-git-send-email-jaegeuk@kernel.org>
References: <1449878414-41254-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a7Xbv-0006lT-IY
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Dec 2015 00:00:27 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a7Xbu-00039C-7s for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Dec 2015 00:00:27 +0000
In-Reply-To: <1449878414-41254-1-git-send-email-jaegeuk@kernel.org>
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

This patch adds to check the stored extent_cache entry is consistent or not.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++--------------
 fsck/fsck.h | 17 +++++++++---
 fsck/main.c |  2 +-
 3 files changed, 82 insertions(+), 24 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index c81dde9..adc61d2 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -468,7 +468,8 @@ out:
 
 int fsck_chk_node_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		u32 nid, u8 *name, enum FILE_TYPE ftype, enum NODE_TYPE ntype,
-		u32 *blk_cnt, struct child_info *child)
+		u32 *blk_cnt, struct child_info *child,
+		struct extent_info *i_ext)
 {
 	struct node_info ni;
 	struct f2fs_node *node_blk = NULL;
@@ -487,19 +488,19 @@ int fsck_chk_node_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			f2fs_set_main_bitmap(sbi, ni.blk_addr,
 							CURSEG_WARM_NODE);
 			fsck_chk_dnode_blk(sbi, inode, nid, ftype, node_blk,
-					blk_cnt, child, &ni);
+					blk_cnt, child, &ni, i_ext);
 			break;
 		case TYPE_INDIRECT_NODE:
 			f2fs_set_main_bitmap(sbi, ni.blk_addr,
 							CURSEG_COLD_NODE);
 			fsck_chk_idnode_blk(sbi, inode, ftype, node_blk,
-					blk_cnt, child);
+					blk_cnt, child, i_ext);
 			break;
 		case TYPE_DOUBLE_INDIRECT_NODE:
 			f2fs_set_main_bitmap(sbi, ni.blk_addr,
 							CURSEG_COLD_NODE);
 			fsck_chk_didnode_blk(sbi, inode, ftype, node_blk,
-					blk_cnt, child);
+					blk_cnt, child, i_ext);
 			break;
 		default:
 			ASSERT(0);
@@ -512,6 +513,26 @@ err:
 	return -EINVAL;
 }
 
+static void update_i_extent(struct extent_info *i_ext, block_t blkaddr)
+{
+	block_t end_addr;
+
+	if (!i_ext)
+		return;
+
+	end_addr = i_ext->ext.blk_addr + i_ext->ext.len;
+
+	/* TODO: check its file offset later */
+	if (blkaddr >= i_ext->ext.blk_addr && blkaddr < end_addr) {
+		unsigned int offset = blkaddr - i_ext->ext.blk_addr;
+
+		if (f2fs_set_bit(offset, i_ext->map))
+			i_ext->fail = 1;
+		else
+			i_ext->len--;
+	}
+}
+
 /* start with valid nid and blkaddr */
 void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		enum FILE_TYPE ftype, struct f2fs_node *node_blk,
@@ -522,6 +543,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	enum NODE_TYPE ntype;
 	u32 i_links = le32_to_cpu(node_blk->i.i_links);
 	u64 i_blocks = le64_to_cpu(node_blk->i.i_blocks);
+	struct extent_info i_extent;
 	unsigned int idx = 0;
 	int need_fix = 0;
 	int ret;
@@ -619,16 +641,28 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		}
 	}
 
+	i_extent.ext = node_blk->i.i_ext;
+	i_extent.len = le32_to_cpu(i_extent.ext.len);
+	i_extent.fail = 0;
+	if (i_extent.len) {
+		/* max 126KB */
+		i_extent.map = calloc(i_extent.len, 1);
+		ASSERT(i_extent.map != NULL);
+	}
+
 	/* check data blocks in inode */
 	for (idx = 0; idx < ADDRS_PER_INODE(&node_blk->i); idx++) {
-		if (le32_to_cpu(node_blk->i.i_addr[idx]) != 0) {
+		block_t blkaddr = le32_to_cpu(node_blk->i.i_addr[idx]);
+
+		if (blkaddr != 0) {
 			ret = fsck_chk_data_blk(sbi,
-					le32_to_cpu(node_blk->i.i_addr[idx]),
+					blkaddr,
 					&child, (i_blocks == *blk_cnt),
 					ftype, nid, idx, ni->version,
 					file_is_encrypt(node_blk->i.i_advise));
 			if (!ret) {
 				*blk_cnt = *blk_cnt + 1;
+				update_i_extent(&i_extent, blkaddr);
 			} else if (config.fix_on) {
 				node_blk->i.i_addr[idx] = 0;
 				need_fix = 1;
@@ -639,6 +673,8 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 
 	/* check node blocks in inode */
 	for (idx = 0; idx < 5; idx++) {
+		block_t blkaddr = le32_to_cpu(node_blk->i.i_nid[idx]);
+
 		if (idx == 0 || idx == 1)
 			ntype = TYPE_DIRECT_NODE;
 		else if (idx == 2 || idx == 3)
@@ -648,10 +684,11 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		else
 			ASSERT(0);
 
-		if (le32_to_cpu(node_blk->i.i_nid[idx]) != 0) {
+		if (blkaddr != 0) {
 			ret = fsck_chk_node_blk(sbi, &node_blk->i,
-					le32_to_cpu(node_blk->i.i_nid[idx]),
-					NULL, ftype, ntype, blk_cnt, &child);
+					blkaddr,
+					NULL, ftype, ntype, blk_cnt, &child,
+					&i_extent);
 			if (!ret) {
 				*blk_cnt = *blk_cnt + 1;
 			} else if (config.fix_on) {
@@ -661,6 +698,12 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 			}
 		}
 	}
+	if (i_extent.len || i_extent.fail) {
+		ASSERT_MSG("ino: 0x%x has wrong ext: untouched=%d, overlap=%d",
+					nid, i_extent.len, i_extent.fail);
+		if (config.fix_on)
+			need_fix = 1;
+	}
 check:
 	if (i_blocks != *blk_cnt) {
 		ASSERT_MSG("ino: 0x%x has i_blocks: %08"PRIx64", "
@@ -729,21 +772,25 @@ skip_blkcnt_fix:
 
 int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		u32 nid, enum FILE_TYPE ftype, struct f2fs_node *node_blk,
-		u32 *blk_cnt, struct child_info *child, struct node_info *ni)
+		u32 *blk_cnt, struct child_info *child, struct node_info *ni,
+		struct extent_info *i_ext)
 {
 	int idx, ret;
 	int need_fix = 0;
 
 	for (idx = 0; idx < ADDRS_PER_BLOCK; idx++) {
-		if (le32_to_cpu(node_blk->dn.addr[idx]) == 0x0)
+		block_t blkaddr = le32_to_cpu(node_blk->dn.addr[idx]);
+
+		if (blkaddr == 0x0)
 			continue;
 		ret = fsck_chk_data_blk(sbi,
-			le32_to_cpu(node_blk->dn.addr[idx]),
-			child, le64_to_cpu(inode->i_blocks) == *blk_cnt, ftype,
+			blkaddr, child,
+			le64_to_cpu(inode->i_blocks) == *blk_cnt, ftype,
 			nid, idx, ni->version,
 			file_is_encrypt(inode->i_advise));
 		if (!ret) {
 			*blk_cnt = *blk_cnt + 1;
+			update_i_extent(i_ext, blkaddr);
 		} else if (config.fix_on) {
 			node_blk->dn.addr[idx] = 0;
 			need_fix = 1;
@@ -759,7 +806,7 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 
 int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		enum FILE_TYPE ftype, struct f2fs_node *node_blk, u32 *blk_cnt,
-		struct child_info *child)
+		struct child_info *child, struct extent_info *i_ext)
 {
 	int ret;
 	int i = 0;
@@ -769,7 +816,8 @@ int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			continue;
 		ret = fsck_chk_node_blk(sbi, inode,
 				le32_to_cpu(node_blk->in.nid[i]), NULL,
-				ftype, TYPE_DIRECT_NODE, blk_cnt, child);
+				ftype, TYPE_DIRECT_NODE, blk_cnt, child,
+				i_ext);
 		if (!ret)
 			*blk_cnt = *blk_cnt + 1;
 		else if (ret == -EINVAL)
@@ -780,7 +828,7 @@ int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 
 int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		enum FILE_TYPE ftype, struct f2fs_node *node_blk, u32 *blk_cnt,
-		struct child_info *child)
+		struct child_info *child, struct extent_info *i_ext)
 {
 	int i = 0;
 	int ret = 0;
@@ -790,7 +838,8 @@ int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			continue;
 		ret = fsck_chk_node_blk(sbi, inode,
 				le32_to_cpu(node_blk->in.nid[i]), NULL,
-				ftype, TYPE_INDIRECT_NODE, blk_cnt, child);
+				ftype, TYPE_INDIRECT_NODE, blk_cnt, child,
+				i_ext);
 		if (!ret)
 			*blk_cnt = *blk_cnt + 1;
 		else if (ret == -EINVAL)
@@ -999,7 +1048,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 		blk_cnt = 1;
 		ret = fsck_chk_node_blk(sbi,
 				NULL, le32_to_cpu(dentry[i].ino), name,
-				ftype, TYPE_INODE, &blk_cnt, NULL);
+				ftype, TYPE_INODE, &blk_cnt, NULL, NULL);
 
 		if (ret && config.fix_on) {
 			int j;
@@ -1165,7 +1214,7 @@ void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 			blk_cnt = 1;
 			ret = fsck_chk_node_blk(sbi, NULL, ino, NULL,
 					F2FS_FT_ORPHAN, TYPE_INODE, &blk_cnt,
-					NULL);
+					NULL, NULL);
 			if (!ret)
 				new_blk->ino[new_entry_count++] =
 							orphan_blk->ino[j];
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 37a25ba..20dfe6b 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -25,6 +25,13 @@ struct child_info {
 	u8 dots;
 };
 
+struct extent_info {
+	struct f2fs_extent ext;
+	char *map;
+	int len;
+	int fail;
+};
+
 struct f2fs_fsck {
 	struct f2fs_sb_info sbi;
 
@@ -88,16 +95,18 @@ enum seg_type {
 extern void fsck_chk_orphan_node(struct f2fs_sb_info *);
 extern int fsck_chk_node_blk(struct f2fs_sb_info *, struct f2fs_inode *, u32,
 		u8 *, enum FILE_TYPE, enum NODE_TYPE, u32 *,
-		struct child_info *);
+		struct child_info *, struct extent_info *);
 extern void fsck_chk_inode_blk(struct f2fs_sb_info *, u32, enum FILE_TYPE,
 		struct f2fs_node *, u32 *, struct node_info *);
 extern int fsck_chk_dnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
 		u32, enum FILE_TYPE, struct f2fs_node *, u32 *,
-		struct child_info *, struct node_info *);
+		struct child_info *, struct node_info *, struct extent_info *);
 extern int fsck_chk_idnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
-		enum FILE_TYPE, struct f2fs_node *, u32 *, struct child_info *);
+		enum FILE_TYPE, struct f2fs_node *, u32 *, struct child_info *,
+		struct extent_info *);
 extern int fsck_chk_didnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
-		enum FILE_TYPE, struct f2fs_node *, u32 *, struct child_info *);
+		enum FILE_TYPE, struct f2fs_node *, u32 *, struct child_info *,
+		struct extent_info *);
 extern int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32, struct child_info *,
 		int, enum FILE_TYPE, u32, u16, u8, int);
 extern int fsck_chk_dentry_blk(struct f2fs_sb_info *, u32, struct child_info *,
diff --git a/fsck/main.c b/fsck/main.c
index 3db4a44..6b0d97e 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -155,7 +155,7 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 	/* Traverse all block recursively from root inode */
 	blk_cnt = 1;
 	fsck_chk_node_blk(sbi, NULL, sbi->root_ino_num, (u8 *)"/",
-			F2FS_FT_DIR, TYPE_INODE, &blk_cnt, NULL);
+			F2FS_FT_DIR, TYPE_INODE, &blk_cnt, NULL, NULL);
 	fsck_verify(sbi);
 	fsck_free(sbi);
 }
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
