From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH 1/4] f2fs: fix to enable readahead for SSA/CP blocks
Date: Mon, 08 Dec 2014 14:56:19 +0800
Message-ID: <001801d012b4$2ffb5c80$8ff21580$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

1.We use zero as upper boundary value for ra SSA/CP blocks, we will skip
readahead as verification failure with max number, it causes low performance.
2.Low boundary value is not accurate for SSA/CP/POR region verification, so
these values need to be redefined.

This patch fixes above issues.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 20a917b..c32ed7c 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -95,8 +95,9 @@ static inline block_t get_max_meta_blks(struct f2fs_sb_info *sbi, int type)
 	case META_SIT:
 		return SIT_BLK_CNT(sbi);
 	case META_SSA:
+		return MAIN_BLKADDR(sbi);
 	case META_CP:
-		return 0;
+		return SM_I(sbi)->sit_info->sit_base_addr;
 	case META_POR:
 		return MAX_BLKADDR(sbi);
 	default:
@@ -141,11 +142,23 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages, int type
 			prev_blk_addr = blk_addr;
 			break;
 		case META_SSA:
+			if (unlikely(blkno >= max_blks))
+				goto out;
+			if (unlikely(blkno < SM_I(sbi)->ssa_blkaddr))
+				goto out;
+			blk_addr = blkno;
+			break;
 		case META_CP:
+			if (unlikely(blkno >= max_blks))
+				goto out;
+			if (unlikely(blkno < __start_cp_addr(sbi)))
+				goto out;
+			blk_addr = blkno;
+			break;
 		case META_POR:
 			if (unlikely(blkno >= max_blks))
 				goto out;
-			if (unlikely(blkno < SEG0_BLKADDR(sbi)))
+			if (unlikely(blkno < MAIN_BLKADDR(sbi)))
 				goto out;
 			blk_addr = blkno;
 			break;
-- 
2.1.2
