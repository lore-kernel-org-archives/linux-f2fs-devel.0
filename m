From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH 2/4] f2fs: introduce is_valid_blkaddr to cleanup
 codes in ra_meta_pages
Date: Mon, 08 Dec 2014 14:59:17 +0800
Message-ID: <001901d012b4$ab211670$01634350$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch does cleanup work, it introduces is_valid_blkaddr() to include
verification code for blkaddr with upper and down boundary value which were in
ra_meta_pages previous.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 53 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c32ed7c..e0ff75e 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -87,22 +87,36 @@ struct page *get_meta_page_ra(struct f2fs_sb_info *sbi, pgoff_t index)
 	return get_meta_page(sbi, index);
 }
 
-static inline block_t get_max_meta_blks(struct f2fs_sb_info *sbi, int type)
+static inline bool is_valid_blkaddr(struct f2fs_sb_info *sbi,
+						block_t blkaddr, int type)
 {
 	switch (type) {
 	case META_NAT:
-		return NM_I(sbi)->max_nid / NAT_ENTRY_PER_BLOCK;
+		break;
 	case META_SIT:
-		return SIT_BLK_CNT(sbi);
+		if (unlikely(blkaddr >= SIT_BLK_CNT(sbi)))
+			return false;
+		break;
 	case META_SSA:
-		return MAIN_BLKADDR(sbi);
+		if (unlikely(blkaddr >= MAIN_BLKADDR(sbi) ||
+			blkaddr < SM_I(sbi)->ssa_blkaddr))
+			return false;
+		break;
 	case META_CP:
-		return SM_I(sbi)->sit_info->sit_base_addr;
+		if (unlikely(blkaddr >= SIT_I(sbi)->sit_base_addr ||
+			blkaddr < __start_cp_addr(sbi)))
+			return false;
+		break;
 	case META_POR:
-		return MAX_BLKADDR(sbi);
+		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
+			blkaddr < MAIN_BLKADDR(sbi)))
+			return false;
+		break;
 	default:
 		BUG();
 	}
+
+	return true;
 }
 
 /*
@@ -113,7 +127,6 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages, int type
 	block_t prev_blk_addr = 0;
 	struct page *page;
 	block_t blkno = start;
-	block_t max_blks = get_max_meta_blks(sbi, type);
 
 	struct f2fs_io_info fio = {
 		.type = META,
@@ -123,18 +136,20 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages, int type
 	for (; nrpages-- > 0; blkno++) {
 		block_t blk_addr;
 
+		if (!is_valid_blkaddr(sbi, blkno, type))
+			goto out;
+
 		switch (type) {
 		case META_NAT:
-			/* get nat block addr */
-			if (unlikely(blkno >= max_blks))
+			if (unlikely(blkno >=
+					NAT_BLOCK_OFFSET(NM_I(sbi)->max_nid)))
 				blkno = 0;
+			/* get nat block addr */
 			blk_addr = current_nat_addr(sbi,
 					blkno * NAT_ENTRY_PER_BLOCK);
 			break;
 		case META_SIT:
 			/* get sit block addr */
-			if (unlikely(blkno >= max_blks))
-				goto out;
 			blk_addr = current_sit_addr(sbi,
 					blkno * SIT_ENTRY_PER_BLOCK);
 			if (blkno != start && prev_blk_addr + 1 != blk_addr)
@@ -142,24 +157,8 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages, int type
 			prev_blk_addr = blk_addr;
 			break;
 		case META_SSA:
-			if (unlikely(blkno >= max_blks))
-				goto out;
-			if (unlikely(blkno < SM_I(sbi)->ssa_blkaddr))
-				goto out;
-			blk_addr = blkno;
-			break;
 		case META_CP:
-			if (unlikely(blkno >= max_blks))
-				goto out;
-			if (unlikely(blkno < __start_cp_addr(sbi)))
-				goto out;
-			blk_addr = blkno;
-			break;
 		case META_POR:
-			if (unlikely(blkno >= max_blks))
-				goto out;
-			if (unlikely(blkno < MAIN_BLKADDR(sbi)))
-				goto out;
 			blk_addr = blkno;
 			break;
 		default:
-- 
2.1.2
