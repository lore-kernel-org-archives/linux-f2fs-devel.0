From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/3] f2fs: skip releasing nodes in chindless extent tree
Date: Fri, 08 Jan 2016 20:24:00 +0800
Message-ID: <005b01d14a0f$8a600b10$9f202130$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

If there are no nodes in extent tree, let's skip releasing step to avoid
any overhead of grabbing/releasing extent tree lock.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/extent_cache.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 9febbc6..ccd5c63 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -570,9 +570,11 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 
 	/* 1. remove unreferenced extent tree */
 	list_for_each_entry_safe(et, next, &sbi->zombie_list, list) {
-		write_lock(&et->lock);
-		node_cnt += __free_extent_tree(sbi, et, true);
-		write_unlock(&et->lock);
+		if (atomic_read(&et->node_cnt)) {
+			write_lock(&et->lock);
+			node_cnt += __free_extent_tree(sbi, et, true);
+			write_unlock(&et->lock);
+		}
 
 		list_del_init(&et->list);
 		radix_tree_delete(&sbi->extent_tree_root, et->ino);
@@ -618,6 +620,9 @@ free_node:
 		for (i = 0; i < found; i++) {
 			struct extent_tree *et = treevec[i];
 
+			if (!atomic_read(&et->node_cnt))
+				continue;
+
 			if (write_trylock(&et->lock)) {
 				node_cnt += __free_extent_tree(sbi, et, false);
 				write_unlock(&et->lock);
@@ -641,7 +646,7 @@ unsigned int f2fs_destroy_extent_node(struct inode *inode)
 	struct extent_tree *et = F2FS_I(inode)->extent_tree;
 	unsigned int node_cnt = 0;
 
-	if (!et)
+	if (!et || !atomic_read(&et->node_cnt))
 		return 0;
 
 	write_lock(&et->lock);
-- 
2.6.3
