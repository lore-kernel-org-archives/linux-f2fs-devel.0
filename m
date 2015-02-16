From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/4] f2fs: remove unused inline_dentry_addr
Date: Mon, 16 Feb 2015 16:15:44 +0800
Message-ID: <006401d049c0$dd65f720$9831e560$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

inline_dentry_addr is introduced with inline dentry feature without being used,
now we do not need to keep it for any reason, so remove it.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7fa3313..a978b65 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1290,12 +1290,6 @@ static inline int f2fs_has_inline_dentry(struct inode *inode)
 	return is_inode_flag_set(F2FS_I(inode), FI_INLINE_DENTRY);
 }
 
-static inline void *inline_dentry_addr(struct page *page)
-{
-	struct f2fs_inode *ri = F2FS_INODE(page);
-	return (void *)&(ri->i_addr[1]);
-}
-
 static inline void f2fs_dentry_kunmap(struct inode *dir, struct page *page)
 {
 	if (!f2fs_has_inline_dentry(dir))
-- 
2.2.1
