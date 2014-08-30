From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 13/17] fsck.f2fs: remove corrupted xattr block
Date: Fri, 29 Aug 2014 17:29:00 -0700
Message-ID: <1409358544-54740-13-git-send-email-jaegeuk@kernel.org>
References: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XNWYJ-0005gP-JB
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:59 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XNWYI-0004eU-N7 for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:59 +0000
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

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 65 ++++++++++++++++++++++++++++++++++---------------------------
 fsck/fsck.h |  1 -
 2 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 914dcb9..53a64b7 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -266,6 +266,34 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 	return 0;
 }
 
+static int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 ino,
+					u32 x_nid, u32 *blk_cnt)
+{
+	struct f2fs_node *node_blk = NULL;
+	struct node_info ni;
+	int ret = 0;
+
+	if (x_nid == 0x0)
+		return 0;
+
+	node_blk = (struct f2fs_node *)calloc(BLOCK_SZ, 1);
+	ASSERT(node_blk != NULL);
+
+	/* Sanity check */
+	if (sanity_check_nid(sbi, x_nid, node_blk,
+				F2FS_FT_XATTR, TYPE_XATTR, &ni)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	*blk_cnt = *blk_cnt + 1;
+	f2fs_set_main_bitmap(sbi, ni.blk_addr);
+	DBG(2, "ino[0x%x] x_nid[0x%x]\n", ino, x_nid);
+out:
+	free(node_blk);
+	return ret;
+}
+
 int fsck_chk_node_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		u32 nid, enum FILE_TYPE ftype, enum NODE_TYPE ntype,
 		u32 *blk_cnt)
@@ -354,8 +382,14 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		}
 	}
 
-	fsck_chk_xattr_blk(sbi, nid,
-			le32_to_cpu(node_blk->i.i_xattr_nid), blk_cnt);
+	if (fsck_chk_xattr_blk(sbi, nid,
+			le32_to_cpu(node_blk->i.i_xattr_nid), blk_cnt) &&
+			config.fix_cnt) {
+		node_blk->i.i_xattr_nid = 0;
+		need_fix = 1;
+		FIX_MSG("Remove xattr block: 0x%x, x_nid = 0x%x",
+				nid, le32_to_cpu(node_blk->i.i_xattr_nid));
+	}
 
 	if (ftype == F2FS_FT_CHRDEV || ftype == F2FS_FT_BLKDEV ||
 			ftype == F2FS_FT_FIFO || ftype == F2FS_FT_SOCK)
@@ -720,33 +754,6 @@ void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 	free(orphan_blk);
 }
 
-void fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 ino,
-		u32 x_nid, u32 *blk_cnt)
-{
-	struct f2fs_node *node_blk = NULL;
-	struct node_info ni;
-
-	if (x_nid == 0x0)
-		return;
-
-	node_blk = (struct f2fs_node *)calloc(BLOCK_SZ, 1);
-	ASSERT(node_blk != NULL);
-
-	/* Sanity check */
-	if (sanity_check_nid(sbi, x_nid, node_blk,
-				F2FS_FT_XATTR, TYPE_XATTR, &ni)) {
-		/* TODO: drop xattr node */
-		printf("drop xattr node\n");
-		goto out;
-	}
-
-	*blk_cnt = *blk_cnt + 1;
-	f2fs_set_main_bitmap(sbi, ni.blk_addr);
-	DBG(2, "ino[0x%x] x_nid[0x%x]\n", ino, x_nid);
-out:
-	free(node_blk);
-}
-
 void fsck_init(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
diff --git a/fsck/fsck.h b/fsck/fsck.h
index a3f03fd..85cc931 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -77,7 +77,6 @@ enum seg_type {
 	SEG_TYPE_MAX,
 };
 
-extern void fsck_chk_xattr_blk(struct f2fs_sb_info *, u32, u32, u32 *);
 extern void fsck_chk_orphan_node(struct f2fs_sb_info *);
 extern int fsck_chk_node_blk(struct f2fs_sb_info *, struct f2fs_inode *, u32,
 		enum FILE_TYPE, enum NODE_TYPE, u32 *);
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
