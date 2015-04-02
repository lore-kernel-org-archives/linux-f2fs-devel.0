From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6/8] fsck.f2fs: clean up child information
Date: Thu,  2 Apr 2015 10:50:53 -0700
Message-ID: <1427997055-10715-6-git-send-email-jaegeuk@kernel.org>
References: <1427997055-10715-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YdjH2-00028Z-1h
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:51:24 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YdjH0-0004lY-L6 for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:51:24 +0000
In-Reply-To: <1427997055-10715-1-git-send-email-jaegeuk@kernel.org>
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

This patch adds a child_info data structure to clean up dirty parameters.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 71 +++++++++++++++++++++++++++----------------------------------
 fsck/fsck.h | 22 ++++++++++++-------
 fsck/main.c |  2 +-
 3 files changed, 46 insertions(+), 49 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 2325e4a..d83f5a8 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -426,7 +426,7 @@ out:
 
 int fsck_chk_node_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		u32 nid, u8 *name, enum FILE_TYPE ftype, enum NODE_TYPE ntype,
-		u32 *blk_cnt, u32 *child_cnt, u32 *child_files)
+		u32 *blk_cnt, struct child_info *child)
 {
 	struct node_info ni;
 	struct f2fs_node *node_blk = NULL;
@@ -445,19 +445,19 @@ int fsck_chk_node_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			f2fs_set_main_bitmap(sbi, ni.blk_addr,
 							CURSEG_WARM_NODE);
 			fsck_chk_dnode_blk(sbi, inode, nid, ftype, node_blk,
-					blk_cnt, child_cnt, child_files, &ni);
+					blk_cnt, child, &ni);
 			break;
 		case TYPE_INDIRECT_NODE:
 			f2fs_set_main_bitmap(sbi, ni.blk_addr,
 							CURSEG_COLD_NODE);
 			fsck_chk_idnode_blk(sbi, inode, ftype, node_blk,
-					blk_cnt, child_cnt, child_files);
+					blk_cnt, child);
 			break;
 		case TYPE_DOUBLE_INDIRECT_NODE:
 			f2fs_set_main_bitmap(sbi, ni.blk_addr,
 							CURSEG_COLD_NODE);
 			fsck_chk_didnode_blk(sbi, inode, ftype, node_blk,
-					blk_cnt, child_cnt, child_files);
+					blk_cnt, child);
 			break;
 		default:
 			ASSERT(0);
@@ -476,7 +476,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		u32 *blk_cnt, struct node_info *ni)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
-	u32 child_cnt = 0, child_files = 0;
+	struct child_info child = {0, 0};
 	enum NODE_TYPE ntype;
 	u32 i_links = le32_to_cpu(node_blk->i.i_links);
 	u64 i_blocks = le64_to_cpu(node_blk->i.i_blocks);
@@ -556,8 +556,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	}
 	if((node_blk->i.i_inline & F2FS_INLINE_DENTRY)) {
 		DBG(3, "ino[0x%x] has inline dentry!\n", nid);
-		ret = fsck_chk_inline_dentries(sbi, node_blk,
-					&child_cnt, &child_files);
+		ret = fsck_chk_inline_dentries(sbi, node_blk, &child);
 		if (ret < 0) {
 			/* should fix this bug all the time */
 			need_fix = 1;
@@ -583,8 +582,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		if (le32_to_cpu(node_blk->i.i_addr[idx]) != 0) {
 			ret = fsck_chk_data_blk(sbi,
 					le32_to_cpu(node_blk->i.i_addr[idx]),
-					&child_cnt, &child_files,
-					(i_blocks == *blk_cnt),
+					&child, (i_blocks == *blk_cnt),
 					ftype, nid, idx, ni->version);
 			if (!ret) {
 				*blk_cnt = *blk_cnt + 1;
@@ -610,8 +608,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		if (le32_to_cpu(node_blk->i.i_nid[idx]) != 0) {
 			ret = fsck_chk_node_blk(sbi, &node_blk->i,
 					le32_to_cpu(node_blk->i.i_nid[idx]),
-					NULL, ftype, ntype, blk_cnt,
-					&child_cnt, &child_files);
+					NULL, ftype, ntype, blk_cnt, &child);
 			if (!ret) {
 				*blk_cnt = *blk_cnt + 1;
 			} else if (config.fix_on) {
@@ -639,21 +636,21 @@ skip_blkcnt_fix:
 				le32_to_cpu(node_blk->footer.ino),
 				node_blk->i.i_name,
 				le32_to_cpu(node_blk->i.i_current_depth),
-				child_files);
+				child.files);
 	if (ftype == F2FS_FT_ORPHAN)
 		DBG(1, "Orphan Inode: 0x%x [%s] i_blocks: %u\n\n",
 				le32_to_cpu(node_blk->footer.ino),
 				node_blk->i.i_name,
 				(u32)i_blocks);
 
-	if (ftype == F2FS_FT_DIR && i_links != child_cnt) {
+	if (ftype == F2FS_FT_DIR && i_links != child.links) {
 		ASSERT_MSG("ino: 0x%x has i_links: %u but real links: %u",
-				nid, i_links, child_cnt);
+				nid, i_links, child.links);
 		if (config.fix_on) {
-			node_blk->i.i_links = cpu_to_le32(child_cnt);
+			node_blk->i.i_links = cpu_to_le32(child.links);
 			need_fix = 1;
 			FIX_MSG("Dir: 0x%x i_links= 0x%x -> 0x%x",
-						nid, i_links, child_cnt);
+						nid, i_links, child.links);
 		}
 	}
 
@@ -668,8 +665,7 @@ skip_blkcnt_fix:
 
 int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		u32 nid, enum FILE_TYPE ftype, struct f2fs_node *node_blk,
-		u32 *blk_cnt, u32 *child_cnt, u32 *child_files,
-		struct node_info *ni)
+		u32 *blk_cnt, struct child_info *child, struct node_info *ni)
 {
 	int idx, ret;
 	int need_fix = 0;
@@ -679,8 +675,7 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			continue;
 		ret = fsck_chk_data_blk(sbi,
 			le32_to_cpu(node_blk->dn.addr[idx]),
-			child_cnt, child_files,
-			le64_to_cpu(inode->i_blocks) == *blk_cnt, ftype,
+			child, le64_to_cpu(inode->i_blocks) == *blk_cnt, ftype,
 			nid, idx, ni->version);
 		if (!ret) {
 			*blk_cnt = *blk_cnt + 1;
@@ -699,7 +694,7 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 
 int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		enum FILE_TYPE ftype, struct f2fs_node *node_blk, u32 *blk_cnt,
-		u32 *child_cnt, u32 *child_files)
+		struct child_info *child)
 {
 	int ret;
 	int i = 0;
@@ -709,8 +704,7 @@ int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			continue;
 		ret = fsck_chk_node_blk(sbi, inode,
 				le32_to_cpu(node_blk->in.nid[i]), NULL,
-				ftype, TYPE_DIRECT_NODE, blk_cnt,
-				child_cnt, child_files);
+				ftype, TYPE_DIRECT_NODE, blk_cnt, child);
 		if (!ret)
 			*blk_cnt = *blk_cnt + 1;
 		else if (ret == -EINVAL)
@@ -721,7 +715,7 @@ int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 
 int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		enum FILE_TYPE ftype, struct f2fs_node *node_blk, u32 *blk_cnt,
-		u32 *child_cnt, u32 *child_files)
+		struct child_info *child)
 {
 	int i = 0;
 	int ret = 0;
@@ -731,8 +725,7 @@ int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			continue;
 		ret = fsck_chk_node_blk(sbi, inode,
 				le32_to_cpu(node_blk->in.nid[i]), NULL,
-				ftype, TYPE_INDIRECT_NODE, blk_cnt,
-				child_cnt, child_files);
+				ftype, TYPE_INDIRECT_NODE, blk_cnt, child);
 		if (!ret)
 			*blk_cnt = *blk_cnt + 1;
 		else if (ret == -EINVAL)
@@ -782,8 +775,7 @@ static void print_dentry(__u32 depth, __u8 *name,
 				name, le32_to_cpu(dentry[idx].ino));
 }
 
-static int __chk_dentries(struct f2fs_sb_info *sbi, u32 *child_cnt,
-			u32* child_files,
+static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 			unsigned long *bitmap,
 			struct f2fs_dir_entry *dentry,
 			__u8 (*filenames)[F2FS_SLOT_LEN],
@@ -885,7 +877,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, u32 *child_cnt,
 							name_len == 2)) {
 				i++;
 				free(name);
-				*child_cnt = *child_cnt + 1;
+				child->links++;
 				continue;
 			}
 		}
@@ -901,7 +893,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, u32 *child_cnt,
 		blk_cnt = 1;
 		ret = fsck_chk_node_blk(sbi,
 				NULL, le32_to_cpu(dentry[i].ino), name,
-				ftype, TYPE_INODE, &blk_cnt, NULL, NULL);
+				ftype, TYPE_INODE, &blk_cnt, NULL);
 
 		if (ret && config.fix_on) {
 			int j;
@@ -915,9 +907,9 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, u32 *child_cnt,
 			fixed = 1;
 		} else if (ret == 0) {
 			if (ftype == F2FS_FT_DIR)
-				*child_cnt = *child_cnt + 1;
+				child->links++;
 			dentries++;
-			*child_files = *child_files + 1;
+			child->files++;
 		}
 
 		i += slots;
@@ -927,7 +919,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, u32 *child_cnt,
 }
 
 int fsck_chk_inline_dentries(struct f2fs_sb_info *sbi,
-		struct f2fs_node *node_blk, u32 *child_cnt, u32 *child_files)
+		struct f2fs_node *node_blk, struct child_info *child)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct f2fs_inline_dentry *de_blk;
@@ -937,7 +929,7 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *sbi,
 	ASSERT(de_blk != NULL);
 
 	fsck->dentry_depth++;
-	dentries = __chk_dentries(sbi, child_cnt, child_files,
+	dentries = __chk_dentries(sbi, child,
 			(unsigned long *)de_blk->dentry_bitmap,
 			de_blk->dentry, de_blk->filename,
 			NR_INLINE_DENTRY, 1);
@@ -955,7 +947,7 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *sbi,
 }
 
 int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
-		u32 *child_cnt, u32 *child_files, int last_blk)
+		struct child_info *child, int last_blk)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct f2fs_dentry_block *de_blk;
@@ -968,7 +960,7 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 	ASSERT(ret >= 0);
 
 	fsck->dentry_depth++;
-	dentries = __chk_dentries(sbi, child_cnt, child_files,
+	dentries = __chk_dentries(sbi, child,
 			(unsigned long *)de_blk->dentry_bitmap,
 			de_blk->dentry, de_blk->filename,
 			NR_DENTRY_IN_BLOCK, last_blk);
@@ -990,7 +982,7 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 }
 
 int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
-		u32 *child_cnt, u32 *child_files, int last_blk,
+		struct child_info *child, int last_blk,
 		enum FILE_TYPE ftype, u32 parent_nid, u16 idx_in_node, u8 ver)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
@@ -1024,8 +1016,7 @@ int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 
 	if (ftype == F2FS_FT_DIR) {
 		f2fs_set_main_bitmap(sbi, blk_addr, CURSEG_HOT_DATA);
-		return fsck_chk_dentry_blk(sbi, blk_addr, child_cnt,
-				child_files, last_blk);
+		return fsck_chk_dentry_blk(sbi, blk_addr, child, last_blk);
 	} else {
 		f2fs_set_main_bitmap(sbi, blk_addr, CURSEG_WARM_DATA);
 	}
@@ -1066,7 +1057,7 @@ void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 			blk_cnt = 1;
 			ret = fsck_chk_node_blk(sbi, NULL, ino, NULL,
 					F2FS_FT_ORPHAN, TYPE_INODE, &blk_cnt,
-					NULL, NULL);
+					NULL);
 			if (!ret)
 				new_blk->ino[new_entry_count++] =
 							orphan_blk->ino[j];
diff --git a/fsck/fsck.h b/fsck/fsck.h
index a640ccf..97e2385 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -19,6 +19,11 @@ struct orphan_info {
 	u32 *ino_list;
 };
 
+struct child_info {
+	u32 links;
+	u32 files;
+};
+
 struct f2fs_fsck {
 	struct f2fs_sb_info sbi;
 
@@ -81,21 +86,22 @@ enum seg_type {
 
 extern void fsck_chk_orphan_node(struct f2fs_sb_info *);
 extern int fsck_chk_node_blk(struct f2fs_sb_info *, struct f2fs_inode *, u32,
-		u8 *, enum FILE_TYPE, enum NODE_TYPE, u32 *, u32 *, u32 *);
+		u8 *, enum FILE_TYPE, enum NODE_TYPE, u32 *, struct child_info *);
 extern void fsck_chk_inode_blk(struct f2fs_sb_info *, u32, enum FILE_TYPE,
 		struct f2fs_node *, u32 *, struct node_info *);
 extern int fsck_chk_dnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
-		u32, enum FILE_TYPE, struct f2fs_node *, u32 *, u32 *, u32 *,
-		struct node_info *);
+		u32, enum FILE_TYPE, struct f2fs_node *, u32 *,
+		struct child_info *, struct node_info *);
 extern int fsck_chk_idnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
-		enum FILE_TYPE, struct f2fs_node *, u32 *, u32 *, u32 *);
+		enum FILE_TYPE, struct f2fs_node *, u32 *, struct child_info *);
 extern int fsck_chk_didnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
-		enum FILE_TYPE, struct f2fs_node *, u32 *, u32 *, u32 *);
-extern int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32, u32 *, u32 *,
+		enum FILE_TYPE, struct f2fs_node *, u32 *, struct child_info *);
+extern int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32, struct child_info *,
 		int, enum FILE_TYPE, u32, u16, u8);
-extern int fsck_chk_dentry_blk(struct f2fs_sb_info *, u32, u32 *, u32 *, int);
+extern int fsck_chk_dentry_blk(struct f2fs_sb_info *, u32, struct child_info *,
+		int);
 int fsck_chk_inline_dentries(struct f2fs_sb_info *, struct f2fs_node *,
-		u32 *, u32 *);
+		struct child_info *);
 
 void print_cp_state(u32);
 extern void print_node_info(struct f2fs_node *);
diff --git a/fsck/main.c b/fsck/main.c
index ba76bf8..b5ad46e 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -153,7 +153,7 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 	/* Traverse all block recursively from root inode */
 	blk_cnt = 1;
 	fsck_chk_node_blk(sbi, NULL, sbi->root_ino_num, (u8 *)"/",
-			F2FS_FT_DIR, TYPE_INODE, &blk_cnt, NULL, NULL);
+			F2FS_FT_DIR, TYPE_INODE, &blk_cnt, NULL);
 	fsck_verify(sbi);
 	fsck_free(sbi);
 }
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
