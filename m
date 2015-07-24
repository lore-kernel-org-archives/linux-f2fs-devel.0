From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/3] f2fs: fix inline data/dentry stat number leak
Date: Fri, 24 Jul 2015 18:24:45 +0800
Message-ID: <005f01d0c5fb$12c4b990$384e2cb0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

If we clear inline data/dentry flag in handle_failed_inode, we will fail
to decline the stat count of inline data/dentry in f2fs_evict_inode due
to no flag in inode. So remove the wrong clearing.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index cc4f108..8335443 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -390,8 +390,6 @@ void handle_failed_inode(struct inode *inode)
 	remove_inode_page(inode);
 
 	set_inode_flag(F2FS_I(inode), FI_FREE_NID);
-	clear_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
-	clear_inode_flag(F2FS_I(inode), FI_INLINE_DENTRY);
 	f2fs_unlock_op(sbi);
 
 	/* iput will drop the inode object */
-- 
2.4.2
