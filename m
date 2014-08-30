From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 04/17] fsck.f2fs: handle IS_VALID_BLK_ADDR
Date: Fri, 29 Aug 2014 17:28:51 -0700
Message-ID: <1409358544-54740-4-git-send-email-jaegeuk@kernel.org>
References: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XNWXw-0005fB-FV
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:36 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XNWXv-0001ka-NU for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:36 +0000
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
 fsck/f2fs.h | 21 +++++++++++----------
 fsck/fsck.c | 14 +++++++++++---
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index aa43cdc..2adffd8 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -308,16 +308,17 @@ static inline bool IS_VALID_NID(struct f2fs_sb_info *sbi, u32 nid)
 			<< (sbi->log_blocks_per_seg - 1)));
 }
 
-#define IS_VALID_BLK_ADDR(sbi, addr)				\
-	do {							\
-		if (addr >= F2FS_RAW_SUPER(sbi)->block_count ||	 	\
-				addr < SM_I(sbi)->main_blkaddr)	\
-		{						\
-			DBG(0, "block addr [0x%x]\n", addr);	\
-			ASSERT(addr <  F2FS_RAW_SUPER(sbi)->block_count);	\
-			ASSERT(addr >= SM_I(sbi)->main_blkaddr);	\
-		}						\
-	} while (0);
+static inline bool IS_VALID_BLK_ADDR(struct f2fs_sb_info *sbi, u32 addr)
+{
+	if (addr >= F2FS_RAW_SUPER(sbi)->block_count ||
+				addr < SM_I(sbi)->main_blkaddr) {
+		DBG(0, "block addr [0x%x]\n", addr);
+		ASSERT(addr <  F2FS_RAW_SUPER(sbi)->block_count);
+		ASSERT(addr >= SM_I(sbi)->main_blkaddr);
+		return 0;
+	}
+	return 1;
+}
 
 static inline u64 BLKOFF_FROM_MAIN(struct f2fs_sb_info *sbi, u64 blk_addr)
 {
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 5c99385..5eab522 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -189,8 +189,10 @@ int fsck_chk_node_blk(struct f2fs_sb_info *sbi,
 	struct f2fs_node *node_blk = NULL;
 	int ret = 0;
 
-	if (!IS_VALID_NID(sbi, nid))
+	if (!IS_VALID_NID(sbi, nid)) {
 		ASSERT_MSG("nid is not valid. [0x%x]", nid);
+		return 0;
+	}
 
 	if (ftype != F2FS_FT_ORPHAN ||
 			f2fs_test_bit(nid, fsck->nat_area_bitmap) != 0x0)
@@ -213,7 +215,10 @@ int fsck_chk_node_blk(struct f2fs_sb_info *sbi,
 		return 0;
 	}
 
-	IS_VALID_BLK_ADDR(sbi, ni.blk_addr);
+	if (!IS_VALID_BLK_ADDR(sbi, ni.blk_addr)) {
+		ASSERT_MSG("blkaddres is not valid. [0x%x]", ni.blk_addr);
+		return 0;
+	}
 
 	is_valid_ssa_node_blk(sbi, nid, ni.blk_addr);
 
@@ -596,7 +601,10 @@ int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 		return 0;
 	}
 
-	IS_VALID_BLK_ADDR(sbi, blk_addr);
+	if (!IS_VALID_BLK_ADDR(sbi, blk_addr)) {
+		ASSERT_MSG("blkaddres is not valid. [0x%x]", blk_addr);
+		return 0;
+	}
 
 	is_valid_ssa_data_blk(sbi, blk_addr, parent_nid, idx_in_node, ver);
 
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
