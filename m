From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] f2fs: use true and false for boolean values
Date: Wed, 1 Aug 2018 19:51:38 -0500
Message-ID: <20180802005138.GA25569@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Return statements in functions returning bool should use true or false
instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/f2fs/f2fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 955a2d5..fdf60b8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1334,7 +1334,7 @@ static inline bool is_idle(struct f2fs_sb_info *sbi)
 	struct request_list *rl = &q->root_rl;
 
 	if (rl->count[BLK_RW_SYNC] || rl->count[BLK_RW_ASYNC])
-		return 0;
+		return false;
 
 	return f2fs_time_over(sbi, REQ_TIME);
 }
@@ -3395,7 +3395,7 @@ static inline bool f2fs_may_encrypt(struct inode *inode)
 
 	return (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode));
 #else
-	return 0;
+	return false;
 #endif
 }
 
-- 
2.7.4
