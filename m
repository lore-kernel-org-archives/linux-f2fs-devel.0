From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 2/5] f2fs: convert dev_valid_block_count to void
Date: Tue, 19 Nov 2013 18:03:27 +0800
Message-ID: <528B376F.7080105@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim <jaegeuk.kim@samsung.com>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net


Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/f2fs.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 94fbec3..d0c6738 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -585,7 +585,7 @@ static inline bool inc_valid_block_count(struct f2fs_sb_info *sbi,
 	return true;
 }
 
-static inline int dec_valid_block_count(struct f2fs_sb_info *sbi,
+static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 						struct inode *inode,
 						blkcnt_t count)
 {
@@ -595,7 +595,6 @@ static inline int dec_valid_block_count(struct f2fs_sb_info *sbi,
 	inode->i_blocks -= count;
 	sbi->total_valid_block_count -= (block_t)count;
 	spin_unlock(&sbi->stat_lock);
-	return 0;
 }
 
 static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
-- 
1.7.7
