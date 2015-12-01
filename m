From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: kill f2fs_drop_largest_extent
Date: Tue, 01 Dec 2015 11:47:33 +0800
Message-ID: <000001d12beb$1b572560$52057020$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

For direct IO, f2fs only allocate new address for the block which is not
exist in the disk before, its mapping info should not exist in extent
cache previously, so here we do not need to call f2fs_drop_largest_extent
to drop related cache.

Due to no more callers for f2fs_drop_largest_extent now, kill it.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c         | 4 ----
 fs/f2fs/extent_cache.c | 8 --------
 fs/f2fs/f2fs.h         | 1 -
 3 files changed, 13 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5fc042f..e303212 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -492,10 +492,6 @@ alloc:
 	if (i_size_read(dn->inode) < ((loff_t)(fofs + 1) << PAGE_CACHE_SHIFT))
 		i_size_write(dn->inode,
 				((loff_t)(fofs + 1) << PAGE_CACHE_SHIFT));
-
-	/* direct IO doesn't use extent cache to maximize the performance */
-	f2fs_drop_largest_extent(dn->inode, fofs);
-
 	return 0;
 }
 
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 7ddba81..6cc9b88 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -164,14 +164,6 @@ static void __drop_largest_extent(struct inode *inode,
 		largest->len = 0;
 }
 
-void f2fs_drop_largest_extent(struct inode *inode, pgoff_t fofs)
-{
-	if (!f2fs_may_extent_tree(inode))
-		return;
-
-	__drop_largest_extent(inode, fofs, 1);
-}
-
 void f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fdb8ab8..95c4782 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2071,7 +2071,6 @@ void f2fs_leave_shrinker(struct f2fs_sb_info *);
  * extent_cache.c
  */
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *, int);
-void f2fs_drop_largest_extent(struct inode *, pgoff_t);
 void f2fs_init_extent_tree(struct inode *, struct f2fs_extent *);
 unsigned int f2fs_destroy_extent_node(struct inode *);
 void f2fs_destroy_extent_tree(struct inode *);
-- 
2.6.3
