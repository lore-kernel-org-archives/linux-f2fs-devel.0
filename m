From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: allow quota to use reserved blocks
Date: Fri,  5 Jan 2018 16:03:24 -0800
Message-ID: <20180106000324.86753-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch allows quota to use reserved blocks all the time.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e5554b851fd8..827549077b81 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1571,10 +1571,13 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
 	return ofs == XATTR_NODE_OFFSET;
 }
 
-static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi)
+static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
+					struct inode *inode)
 {
 	if (!test_opt(sbi, RESERVE_ROOT))
 		return false;
+	if (IS_NOQUOTA(inode))
+		return true;
 	if (capable(CAP_SYS_RESOURCE))
 		return true;
 	if (uid_eq(sbi->s_resuid, current_fsuid()))
@@ -1615,7 +1618,7 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 	avail_user_block_count = sbi->user_block_count -
 					sbi->current_reserved_blocks;
 
-	if (!__allow_reserved_blocks(sbi))
+	if (!__allow_reserved_blocks(sbi, inode))
 		avail_user_block_count -= sbi->root_reserved_blocks;
 
 	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
@@ -1816,7 +1819,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 	valid_block_count = sbi->total_valid_block_count +
 					sbi->current_reserved_blocks + 1;
 
-	if (!__allow_reserved_blocks(sbi))
+	if (!__allow_reserved_blocks(sbi, inode))
 		valid_block_count += sbi->root_reserved_blocks;
 
 	if (unlikely(valid_block_count > sbi->user_block_count)) {
-- 
2.15.0.531.g2ccb3012c9-goog
