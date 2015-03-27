From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/6] fsck.f2fs: remove inconsistent named
	directories
Date: Thu, 26 Mar 2015 17:03:05 -0700
Message-ID: <1427414589-66956-2-git-send-email-jaegeuk@kernel.org>
References: <1427414589-66956-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YbHkC-00066L-D7
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Mar 2015 00:03:24 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YbHkB-0007cK-3p for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Mar 2015 00:03:24 +0000
In-Reply-To: <1427414589-66956-1-git-send-email-jaegeuk@kernel.org>
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

Each inode has its filename inside inode block.
For directory, the name should be matched all the time.
In other cases, it shouldn't, since there is able to be linked to other file
names.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 27 ++++++++++++++++++---------
 fsck/fsck.h |  2 +-
 fsck/main.c |  2 +-
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 1b27ae0..e803fa0 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -192,7 +192,7 @@ static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 			struct f2fs_node *node_blk,
 			enum FILE_TYPE ftype, enum NODE_TYPE ntype,
-			struct node_info *ni)
+			struct node_info *ni, u8 *name)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	int ret;
@@ -263,6 +263,15 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 		}
 	}
 
+	if (ntype == TYPE_INODE && ftype == F2FS_FT_DIR) {
+		u32 len = le32_to_cpu(node_blk->i.i_namelen);
+		if (name && memcmp(name, node_blk->i.i_name, len)) {
+			ASSERT_MSG("mismatch name [0x%x] [%s vs. %s]",
+					nid, name, node_blk->i.i_name);
+			return -EINVAL;
+		}
+	}
+
 	/* workaround to fix later */
 	if (ftype != F2FS_FT_ORPHAN ||
 			f2fs_test_bit(nid, fsck->nat_area_bitmap) != 0)
@@ -297,7 +306,7 @@ static int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 ino,
 
 	/* Sanity check */
 	if (sanity_check_nid(sbi, x_nid, node_blk,
-				F2FS_FT_XATTR, TYPE_XATTR, &ni)) {
+				F2FS_FT_XATTR, TYPE_XATTR, &ni, NULL)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -311,7 +320,7 @@ out:
 }
 
 int fsck_chk_node_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
-		u32 nid, enum FILE_TYPE ftype, enum NODE_TYPE ntype,
+		u32 nid, u8 *name, enum FILE_TYPE ftype, enum NODE_TYPE ntype,
 		u32 *blk_cnt)
 {
 	struct node_info ni;
@@ -320,7 +329,7 @@ int fsck_chk_node_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 	node_blk = (struct f2fs_node *)calloc(BLOCK_SZ, 1);
 	ASSERT(node_blk != NULL);
 
-	if (sanity_check_nid(sbi, nid, node_blk, ftype, ntype, &ni))
+	if (sanity_check_nid(sbi, nid, node_blk, ftype, ntype, &ni, name))
 		goto err;
 
 	if (ntype == TYPE_INODE) {
@@ -496,7 +505,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		if (le32_to_cpu(node_blk->i.i_nid[idx]) != 0) {
 			ret = fsck_chk_node_blk(sbi, &node_blk->i,
 					le32_to_cpu(node_blk->i.i_nid[idx]),
-					ftype, ntype, blk_cnt);
+					NULL, ftype, ntype, blk_cnt);
 			if (!ret) {
 				*blk_cnt = *blk_cnt + 1;
 			} else if (config.fix_on) {
@@ -591,7 +600,7 @@ int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		if (le32_to_cpu(node_blk->in.nid[i]) == 0x0)
 			continue;
 		ret = fsck_chk_node_blk(sbi, inode,
-				le32_to_cpu(node_blk->in.nid[i]),
+				le32_to_cpu(node_blk->in.nid[i]), NULL,
 				ftype, TYPE_DIRECT_NODE, blk_cnt);
 		if (!ret)
 			*blk_cnt = *blk_cnt + 1;
@@ -611,7 +620,7 @@ int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		if (le32_to_cpu(node_blk->in.nid[i]) == 0x0)
 			continue;
 		ret = fsck_chk_node_blk(sbi, inode,
-				le32_to_cpu(node_blk->in.nid[i]),
+				le32_to_cpu(node_blk->in.nid[i]), NULL,
 				ftype, TYPE_INDIRECT_NODE, blk_cnt);
 		if (!ret)
 			*blk_cnt = *blk_cnt + 1;
@@ -764,7 +773,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, u32 *child_cnt,
 
 		blk_cnt = 1;
 		ret = fsck_chk_node_blk(sbi,
-				NULL, le32_to_cpu(dentry[i].ino),
+				NULL, le32_to_cpu(dentry[i].ino), name,
 				ftype, TYPE_INODE, &blk_cnt);
 
 		if (ret && config.fix_on) {
@@ -927,7 +936,7 @@ void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 				continue;
 			}
 			blk_cnt = 1;
-			fsck_chk_node_blk(sbi, NULL, ino,
+			fsck_chk_node_blk(sbi, NULL, ino, NULL,
 					F2FS_FT_ORPHAN, TYPE_INODE, &blk_cnt);
 		}
 		memset(orphan_blk, 0, BLOCK_SZ);
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 98425c6..ff2b25d 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -80,7 +80,7 @@ enum seg_type {
 
 extern void fsck_chk_orphan_node(struct f2fs_sb_info *);
 extern int fsck_chk_node_blk(struct f2fs_sb_info *, struct f2fs_inode *, u32,
-		enum FILE_TYPE, enum NODE_TYPE, u32 *);
+		u8 *, enum FILE_TYPE, enum NODE_TYPE, u32 *);
 extern void fsck_chk_inode_blk(struct f2fs_sb_info *, u32, enum FILE_TYPE,
 		struct f2fs_node *, u32 *, struct node_info *);
 extern int fsck_chk_dnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
diff --git a/fsck/main.c b/fsck/main.c
index 16fab9c..e0b126b 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -152,7 +152,7 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 
 	/* Traverse all block recursively from root inode */
 	blk_cnt = 1;
-	fsck_chk_node_blk(sbi, NULL, sbi->root_ino_num,
+	fsck_chk_node_blk(sbi, NULL, sbi->root_ino_num, (u8 *)"/",
 			F2FS_FT_DIR, TYPE_INODE, &blk_cnt);
 	fsck_verify(sbi);
 	fsck_free(sbi);
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
