From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: [PATCH] f2fs: enable fast symlink by utilizing inline data
Date: Thu, 19 Mar 2015 13:23:48 +0800
Message-ID: <1426742628-8028-1-git-send-email-wanpeng.li@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Changman Lee <cm224.lee@samsung.com>, Chao Yu <chao2.yu@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Wanpeng Li <wanpeng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Fast symlink can utilize inline data flow to avoid using any 
i_addr region, since we need to handle many cases such as 
truncation, roll-forward recovery, and fsck/dump tools.

Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
---
 fs/f2fs/inline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index d67bc0d..b7baad6 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -18,7 +18,7 @@ bool f2fs_may_inline(struct inode *inode)
 	if (f2fs_is_atomic_file(inode))
 		return false;
 
-	if (!S_ISREG(inode->i_mode))
+	if (!S_ISREG(inode->i_mode) && !S_ISLNK(inode->i_mode))
 		return false;
 
 	if (i_size_read(inode) > MAX_INLINE_DATA)
-- 
2.1.0
