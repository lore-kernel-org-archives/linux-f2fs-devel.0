From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 6/7] f2fs: fix incorrect searching position when shrinking
 extent cache
Date: Fri, 11 Sep 2015 14:43:02 +0800
Message-ID: <000101d0ec5d$33294240$997bc6c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

When shrinking extent cache, we have two steps in the flow:
1) shrink objects which are unreferenced by inodes;
2) shrink objects from LRU list of extent cache.

In step 1, if we haven't shrunk enough number of objects, we will try
step 2, but before that we didn't update the searching position which
may point to last inode index in global extent tree, result in failing
to shrink objects by traversing the all inodes' extent tree.

In this patch, we reset searching position to beginning of global extent
tree for fixing.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/extent_cache.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 1cd6c6c..a8b9aa2 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -652,6 +652,11 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 	}
 	spin_unlock(&sbi->extent_lock);
 
+	/*
+	 * reset ino for searching victims from beginning of global extent tree.
+	 */
+	ino = F2FS_ROOT_INO(sbi);
+
 	while ((found = radix_tree_gang_lookup(root,
 				(void **)treevec, ino, EXT_TREE_VEC_SIZE))) {
 		unsigned i;
-- 
2.4.2
