From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/8] fsck.f2fs: fix missing i_links
Date: Thu,  2 Apr 2015 10:50:52 -0700
Message-ID: <1427997055-10715-5-git-send-email-jaegeuk@kernel.org>
References: <1427997055-10715-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YdjGy-0002NF-Hi
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:51:20 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YdjGx-0002eK-Da for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:51:20 +0000
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

If a child is a directory, we should increase parent's i_links.
Previously, it counts direct dentry blocks excluding indirect blocks.
This patch fixes to count child_cnt correctly in order to get precise i_links.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 34 ++++++++++++++++++++--------------
 fsck/fsck.h |  8 ++++----
 fsck/main.c |  2 +-
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 828d889..2325e4a 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -426,7 +426,7 @@ out:
 
 int fsck_chk_node_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		u32 nid, u8 *name, enum FILE_TYPE ftype, enum NODE_TYPE ntype,
-		u32 *blk_cnt)
+		u32 *blk_cnt, u32 *child_cnt, u32 *child_files)
 {
 	struct node_info ni;
 	struct f2fs_node *node_blk = NULL;
@@ -445,19 +445,19 @@ int fsck_chk_node_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			f2fs_set_main_bitmap(sbi, ni.blk_addr,
 							CURSEG_WARM_NODE);
 			fsck_chk_dnode_blk(sbi, inode, nid, ftype, node_blk,
-					blk_cnt, &ni);
+					blk_cnt, child_cnt, child_files, &ni);
 			break;
 		case TYPE_INDIRECT_NODE:
 			f2fs_set_main_bitmap(sbi, ni.blk_addr,
 							CURSEG_COLD_NODE);
 			fsck_chk_idnode_blk(sbi, inode, ftype, node_blk,
-					blk_cnt);
+					blk_cnt, child_cnt, child_files);
 			break;
 		case TYPE_DOUBLE_INDIRECT_NODE:
 			f2fs_set_main_bitmap(sbi, ni.blk_addr,
 							CURSEG_COLD_NODE);
 			fsck_chk_didnode_blk(sbi, inode, ftype, node_blk,
-					blk_cnt);
+					blk_cnt, child_cnt, child_files);
 			break;
 		default:
 			ASSERT(0);
@@ -610,7 +610,8 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		if (le32_to_cpu(node_blk->i.i_nid[idx]) != 0) {
 			ret = fsck_chk_node_blk(sbi, &node_blk->i,
 					le32_to_cpu(node_blk->i.i_nid[idx]),
-					NULL, ftype, ntype, blk_cnt);
+					NULL, ftype, ntype, blk_cnt,
+					&child_cnt, &child_files);
 			if (!ret) {
 				*blk_cnt = *blk_cnt + 1;
 			} else if (config.fix_on) {
@@ -667,10 +668,10 @@ skip_blkcnt_fix:
 
 int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		u32 nid, enum FILE_TYPE ftype, struct f2fs_node *node_blk,
-		u32 *blk_cnt, struct node_info *ni)
+		u32 *blk_cnt, u32 *child_cnt, u32 *child_files,
+		struct node_info *ni)
 {
 	int idx, ret;
-	u32 child_cnt = 0, child_files = 0;
 	int need_fix = 0;
 
 	for (idx = 0; idx < ADDRS_PER_BLOCK; idx++) {
@@ -678,7 +679,7 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			continue;
 		ret = fsck_chk_data_blk(sbi,
 			le32_to_cpu(node_blk->dn.addr[idx]),
-			&child_cnt, &child_files,
+			child_cnt, child_files,
 			le64_to_cpu(inode->i_blocks) == *blk_cnt, ftype,
 			nid, idx, ni->version);
 		if (!ret) {
@@ -697,7 +698,8 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 }
 
 int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
-		enum FILE_TYPE ftype, struct f2fs_node *node_blk, u32 *blk_cnt)
+		enum FILE_TYPE ftype, struct f2fs_node *node_blk, u32 *blk_cnt,
+		u32 *child_cnt, u32 *child_files)
 {
 	int ret;
 	int i = 0;
@@ -707,7 +709,8 @@ int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			continue;
 		ret = fsck_chk_node_blk(sbi, inode,
 				le32_to_cpu(node_blk->in.nid[i]), NULL,
-				ftype, TYPE_DIRECT_NODE, blk_cnt);
+				ftype, TYPE_DIRECT_NODE, blk_cnt,
+				child_cnt, child_files);
 		if (!ret)
 			*blk_cnt = *blk_cnt + 1;
 		else if (ret == -EINVAL)
@@ -717,7 +720,8 @@ int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 }
 
 int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
-		enum FILE_TYPE ftype, struct f2fs_node *node_blk, u32 *blk_cnt)
+		enum FILE_TYPE ftype, struct f2fs_node *node_blk, u32 *blk_cnt,
+		u32 *child_cnt, u32 *child_files)
 {
 	int i = 0;
 	int ret = 0;
@@ -727,7 +731,8 @@ int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			continue;
 		ret = fsck_chk_node_blk(sbi, inode,
 				le32_to_cpu(node_blk->in.nid[i]), NULL,
-				ftype, TYPE_INDIRECT_NODE, blk_cnt);
+				ftype, TYPE_INDIRECT_NODE, blk_cnt,
+				child_cnt, child_files);
 		if (!ret)
 			*blk_cnt = *blk_cnt + 1;
 		else if (ret == -EINVAL)
@@ -896,7 +901,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, u32 *child_cnt,
 		blk_cnt = 1;
 		ret = fsck_chk_node_blk(sbi,
 				NULL, le32_to_cpu(dentry[i].ino), name,
-				ftype, TYPE_INODE, &blk_cnt);
+				ftype, TYPE_INODE, &blk_cnt, NULL, NULL);
 
 		if (ret && config.fix_on) {
 			int j;
@@ -1060,7 +1065,8 @@ void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 			DBG(1, "[%3d] ino [0x%x]\n", i, ino);
 			blk_cnt = 1;
 			ret = fsck_chk_node_blk(sbi, NULL, ino, NULL,
-					F2FS_FT_ORPHAN, TYPE_INODE, &blk_cnt);
+					F2FS_FT_ORPHAN, TYPE_INODE, &blk_cnt,
+					NULL, NULL);
 			if (!ret)
 				new_blk->ino[new_entry_count++] =
 							orphan_blk->ino[j];
diff --git a/fsck/fsck.h b/fsck/fsck.h
index ffb3ae2..a640ccf 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -81,16 +81,16 @@ enum seg_type {
 
 extern void fsck_chk_orphan_node(struct f2fs_sb_info *);
 extern int fsck_chk_node_blk(struct f2fs_sb_info *, struct f2fs_inode *, u32,
-		u8 *, enum FILE_TYPE, enum NODE_TYPE, u32 *);
+		u8 *, enum FILE_TYPE, enum NODE_TYPE, u32 *, u32 *, u32 *);
 extern void fsck_chk_inode_blk(struct f2fs_sb_info *, u32, enum FILE_TYPE,
 		struct f2fs_node *, u32 *, struct node_info *);
 extern int fsck_chk_dnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
-		u32, enum FILE_TYPE, struct f2fs_node *, u32 *,
+		u32, enum FILE_TYPE, struct f2fs_node *, u32 *, u32 *, u32 *,
 		struct node_info *);
 extern int fsck_chk_idnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
-		enum FILE_TYPE, struct f2fs_node *, u32 *);
+		enum FILE_TYPE, struct f2fs_node *, u32 *, u32 *, u32 *);
 extern int fsck_chk_didnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
-		enum FILE_TYPE, struct f2fs_node *, u32 *);
+		enum FILE_TYPE, struct f2fs_node *, u32 *, u32 *, u32 *);
 extern int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32, u32 *, u32 *,
 		int, enum FILE_TYPE, u32, u16, u8);
 extern int fsck_chk_dentry_blk(struct f2fs_sb_info *, u32, u32 *, u32 *, int);
diff --git a/fsck/main.c b/fsck/main.c
index e0b126b..ba76bf8 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -153,7 +153,7 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 	/* Traverse all block recursively from root inode */
 	blk_cnt = 1;
 	fsck_chk_node_blk(sbi, NULL, sbi->root_ino_num, (u8 *)"/",
-			F2FS_FT_DIR, TYPE_INODE, &blk_cnt);
+			F2FS_FT_DIR, TYPE_INODE, &blk_cnt, NULL, NULL);
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
