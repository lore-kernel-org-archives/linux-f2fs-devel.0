From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs-tools: avoid build warnings
Date: Mon,  5 Jun 2017 18:34:56 -0700
Message-ID: <20170606013457.67454-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1dI3Ol-0006dJ-9L
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Jun 2017 01:35:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dI3Oj-0005X5-Gn
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Jun 2017 01:35:07 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch resolves warnings while building it in android.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c        | 20 ++++++++++----------
 fsck/fsck.h        |  2 +-
 fsck/main.c        |  4 ++--
 include/f2fs_fs.h  |  2 +-
 mkfs/f2fs_format.c |  2 +-
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 2a6546a..56336ad 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -347,7 +347,7 @@ err:
 static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 			struct f2fs_node *node_blk,
 			enum FILE_TYPE ftype, enum NODE_TYPE ntype,
-			struct node_info *ni, u8 *name)
+			struct node_info *ni)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	int ret;
@@ -470,7 +470,7 @@ static int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 ino,
 
 	/* Sanity check */
 	if (sanity_check_nid(sbi, x_nid, node_blk,
-				F2FS_FT_XATTR, TYPE_XATTR, &ni, NULL)) {
+				F2FS_FT_XATTR, TYPE_XATTR, &ni)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -484,7 +484,7 @@ out:
 }
 
 int fsck_chk_node_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
-		u32 nid, u8 *name, enum FILE_TYPE ftype, enum NODE_TYPE ntype,
+		u32 nid, enum FILE_TYPE ftype, enum NODE_TYPE ntype,
 		u32 *blk_cnt, struct child_info *child)
 {
 	struct node_info ni;
@@ -493,7 +493,7 @@ int fsck_chk_node_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 	node_blk = (struct f2fs_node *)calloc(BLOCK_SZ, 1);
 	ASSERT(node_blk != NULL);
 
-	if (sanity_check_nid(sbi, nid, node_blk, ftype, ntype, &ni, name))
+	if (sanity_check_nid(sbi, nid, node_blk, ftype, ntype, &ni))
 		goto err;
 
 	if (ntype == TYPE_INODE) {
@@ -748,7 +748,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 			goto skip;
 
 		ret = fsck_chk_node_blk(sbi, &node_blk->i, i_nid,
-				NULL, ftype, ntype, blk_cnt, &child);
+					ftype, ntype, blk_cnt, &child);
 		if (!ret) {
 			*blk_cnt = *blk_cnt + 1;
 		} else if (ret == -EINVAL) {
@@ -905,7 +905,7 @@ int fsck_chk_idnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		if (le32_to_cpu(node_blk->in.nid[i]) == 0x0)
 			goto skip;
 		ret = fsck_chk_node_blk(sbi, inode,
-				le32_to_cpu(node_blk->in.nid[i]), NULL,
+				le32_to_cpu(node_blk->in.nid[i]),
 				ftype, TYPE_DIRECT_NODE, blk_cnt, child);
 		if (!ret)
 			*blk_cnt = *blk_cnt + 1;
@@ -945,7 +945,7 @@ int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		if (le32_to_cpu(node_blk->in.nid[i]) == 0x0)
 			goto skip;
 		ret = fsck_chk_node_blk(sbi, inode,
-				le32_to_cpu(node_blk->in.nid[i]), NULL,
+				le32_to_cpu(node_blk->in.nid[i]),
 				ftype, TYPE_INDIRECT_NODE, blk_cnt, child);
 		if (!ret)
 			*blk_cnt = *blk_cnt + 1;
@@ -1325,7 +1325,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 
 		blk_cnt = 1;
 		ret = fsck_chk_node_blk(sbi,
-				NULL, le32_to_cpu(dentry[i].ino), name,
+				NULL, le32_to_cpu(dentry[i].ino),
 				ftype, TYPE_INODE, &blk_cnt, NULL);
 
 		if (ret && c.fix_on) {
@@ -1501,7 +1501,7 @@ int fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 				continue;
 			}
 
-			ret = fsck_chk_node_blk(sbi, NULL, ino, NULL,
+			ret = fsck_chk_node_blk(sbi, NULL, ino,
 					F2FS_FT_ORPHAN, TYPE_INODE, &blk_cnt,
 					NULL);
 			if (!ret)
@@ -1684,7 +1684,7 @@ static void fix_hard_links(struct f2fs_sb_info *sbi)
 	while (node) {
 		/* Sanity check */
 		if (sanity_check_nid(sbi, node->nid, node_blk,
-					F2FS_FT_MAX, TYPE_INODE, &ni, NULL))
+					F2FS_FT_MAX, TYPE_INODE, &ni))
 			FIX_MSG("Failed to fix, rerun fsck.f2fs");
 
 		node_blk->i.i_links = cpu_to_le32(node->actual_links);
diff --git a/fsck/fsck.h b/fsck/fsck.h
index b6c9cbd..c54eccb 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -119,7 +119,7 @@ struct selabel_handle;
 
 extern int fsck_chk_orphan_node(struct f2fs_sb_info *);
 extern int fsck_chk_node_blk(struct f2fs_sb_info *, struct f2fs_inode *, u32,
-		u8 *, enum FILE_TYPE, enum NODE_TYPE, u32 *,
+		enum FILE_TYPE, enum NODE_TYPE, u32 *,
 		struct child_info *);
 extern void fsck_chk_inode_blk(struct f2fs_sb_info *, u32, enum FILE_TYPE,
 		struct f2fs_node *, u32 *, struct node_info *);
diff --git a/fsck/main.c b/fsck/main.c
index 47d6966..c9411eb 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -80,7 +80,7 @@ void sload_usage()
 
 static int is_digits(char *optarg)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < strlen(optarg); i++)
 		if (!isdigit(optarg[i]))
@@ -447,7 +447,7 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 
 	/* Traverse all block recursively from root inode */
 	blk_cnt = 1;
-	fsck_chk_node_blk(sbi, NULL, sbi->root_ino_num, (u8 *)"/",
+	fsck_chk_node_blk(sbi, NULL, sbi->root_ino_num,
 			F2FS_FT_DIR, TYPE_INODE, &blk_cnt, NULL);
 	fsck_verify(sbi);
 	fsck_free(sbi);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 43760d4..2316869 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -306,7 +306,7 @@ struct f2fs_configuration {
 	/* sload parameters */
 	char *from_dir;
 	char *mount_point;
-} __attribute__((packed));
+};
 
 #ifdef CONFIG_64BIT
 #define BITS_PER_LONG	64
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 67965ed..ff1153a 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -748,7 +748,7 @@ static int f2fs_write_check_point_pack(void)
 
 	/* write NAT bits, if possible */
 	if (flags & CP_NAT_BITS_FLAG) {
-		int i;
+		uint32_t i;
 
 		*(__le64 *)nat_bits = get_cp_crc(cp);
 		empty_nat_bits = nat_bits + 8 + nat_bits_bytes;
-- 
2.13.0.rc1.294.g07d810a77f-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
