From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs-tools: add debug message for checking xattr
Date: Wed, 07 Aug 2013 17:18:50 +0900
Message-ID: <1375863530-3537-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1V6yz4-00064e-FM
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Aug 2013 08:20:42 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V6yyy-0002P0-Po for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Aug 2013 08:20:42 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MR5007APJ56M7H0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Aug 2013 17:20:29 +0900 (KST)
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

This patch adds debug message to confirm xattr block is checked.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fsck/fsck.c |    5 +++--
 fsck/fsck.h |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 2a4d064..6a5f659 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -331,7 +331,7 @@ int fsck_chk_inode_blk(struct f2fs_sb_info *sbi,
 		ASSERT(0);
 	}
 
-	fsck_chk_xattr_blk(sbi, le32_to_cpu(node_blk->i.i_xattr_nid), blk_cnt);
+	fsck_chk_xattr_blk(sbi, nid, le32_to_cpu(node_blk->i.i_xattr_nid), blk_cnt);
 
 	/* check data blocks in inode */
 	for (idx = 0; idx < ADDRS_PER_INODE; idx++) {
@@ -694,7 +694,7 @@ int fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
-int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 x_nid, u32 *blk_cnt)
+int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 ino, u32 x_nid, u32 *blk_cnt)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct node_info ni;
@@ -721,6 +721,7 @@ int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 x_nid, u32 *blk_cnt)
 	}
 	f2fs_set_bit(BLKOFF_FROM_MAIN(sbi, ni.blk_addr), fsck->main_area_bitmap);
 
+	DBG(2, "ino[0x%x] x_nid[0x%x]\n", ino, x_nid);
 	return 0;
 }
 
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 94808b8..8c98c93 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -76,7 +76,7 @@ enum seg_type {
 	SEG_TYPE_MAX,
 };
 
-extern int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 x_nid, u32 *blk_cnt);
+extern int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 ino, u32 x_nid, u32 *blk_cnt);
 extern int fsck_chk_orphan_node(struct f2fs_sb_info *sbi);
 
 extern int fsck_chk_node_blk(struct f2fs_sb_info *sbi,
-- 
1.7.9.5


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
