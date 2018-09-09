From: Zhikang Zhang <zhangzhikang1@huawei.com>
Subject: [PATCH v2] f2fs: remove sleep from atomic lock
Date: Sun, 9 Sep 2018 12:05:11 +0800
Message-ID: <1536465911-23016-1-git-send-email-zhangzhikang1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhangzhikang1@huawei.com>) id 1fyqyO-00053p-OM
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 09 Sep 2018 04:05:20 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fyqyL-00CRrc-H6
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 09 Sep 2018 04:05:20 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

In the call trace below, we might sleep in function dput().

So in order to avoid sleeping in atomic lock, we remove f2fs_mark_inode_dirty_sync
in __try_update_largest_extent && __drop_largest_extent.

BUG: sleeping function called from invalid context at fs/dcache.c:796
Call trace:
	dump_backtrace+0x0/0x3f4
	show_stack+0x24/0x30
	dump_stack+0xe0/0x138
	___might_sleep+0x2a8/0x2c8
	__might_sleep+0x78/0x10c
	dput+0x7c/0x750
	block_dump___mark_inode_dirty+0x120/0x17c
	__mark_inode_dirty+0x344/0x11f0
	f2fs_mark_inode_dirty_sync+0x40/0x50
	__insert_extent_tree+0x2e0/0x2f4
	f2fs_update_extent_tree_range+0xcf4/0xde8
	f2fs_update_extent_cache+0x114/0x12c
	f2fs_update_data_blkaddr+0x40/0x50
	write_data_page+0x150/0x314
	do_write_data_page+0x648/0x2318
	__write_data_page+0xdb4/0x1640
	f2fs_write_cache_pages+0x768/0xafc
	__f2fs_write_data_pages+0x590/0x1218
	f2fs_write_data_pages+0x64/0x74
	do_writepages+0x74/0xe4
	__writeback_single_inode+0xdc/0x15f0
	writeback_sb_inodes+0x574/0xc98
	__writeback_inodes_wb+0x190/0x204
	wb_writeback+0x730/0xf14
	wb_check_old_data_flush+0x1bc/0x1c8
	wb_workfn+0x554/0xf74
	process_one_work+0x440/0x118c
	worker_thread+0xac/0x974
	kthread+0x1a0/0x1c8
	ret_from_fork+0x10/0x1c
---
 fs/f2fs/extent_cache.c | 31 ++++++++++++++++---------------
 fs/f2fs/f2fs.h         |  8 +++-----
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 231b77e..8cc5cba 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -313,10 +313,8 @@ static void __drop_largest_extent(struct inode *inode,
 {
 	struct extent_info *largest = &F2FS_I(inode)->extent_tree->largest;
 
-	if (fofs < largest->fofs + largest->len && fofs + len > largest->fofs) {
+	if (fofs < largest->fofs + largest->len && fofs + len > largest->fofs)
 		largest->len = 0;
-		f2fs_mark_inode_dirty_sync(inode, true);
-	}
 }
 
 /* return true, if inode page is changed */
@@ -416,12 +414,11 @@ static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 	return ret;
 }
 
-static struct extent_node *__try_merge_extent_node(struct inode *inode,
+static struct extent_node *__try_merge_extent_node(struct f2fs_sb_info *sbi,
 				struct extent_tree *et, struct extent_info *ei,
 				struct extent_node *prev_ex,
 				struct extent_node *next_ex)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_node *en = NULL;
 
 	if (prev_ex && __is_back_mergeable(ei, &prev_ex->ei)) {
@@ -443,7 +440,7 @@ static struct extent_node *__try_merge_extent_node(struct inode *inode,
 	if (!en)
 		return NULL;
 
-	__try_update_largest_extent(inode, et, en);
+	__try_update_largest_extent(et, en);
 
 	spin_lock(&sbi->extent_lock);
 	if (!list_empty(&en->list)) {
@@ -454,12 +451,11 @@ static struct extent_node *__try_merge_extent_node(struct inode *inode,
 	return en;
 }
 
-static struct extent_node *__insert_extent_tree(struct inode *inode,
+static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
 				struct extent_tree *et, struct extent_info *ei,
 				struct rb_node **insert_p,
 				struct rb_node *insert_parent)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct rb_node **p;
 	struct rb_node *parent = NULL;
 	struct extent_node *en = NULL;
@@ -476,7 +472,7 @@ static struct extent_node *__insert_extent_tree(struct inode *inode,
 	if (!en)
 		return NULL;
 
-	__try_update_largest_extent(inode, et, en);
+	__try_update_largest_extent(et, en);
 
 	/* update in global extent list */
 	spin_lock(&sbi->extent_lock);
@@ -497,6 +493,7 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 	struct rb_node **insert_p = NULL, *insert_parent = NULL;
 	unsigned int end = fofs + len;
 	unsigned int pos = (unsigned int)fofs;
+	unsigned int old_largest = et->largest.len;
 
 	if (!et)
 		return;
@@ -550,7 +547,7 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 				set_extent_info(&ei, end,
 						end - dei.fofs + dei.blk,
 						org_end - end);
-				en1 = __insert_extent_tree(inode, et, &ei,
+				en1 = __insert_extent_tree(sbi, et, &ei,
 							NULL, NULL);
 				next_en = en1;
 			} else {
@@ -570,7 +567,7 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 		}
 
 		if (parts)
-			__try_update_largest_extent(inode, et, en);
+			__try_update_largest_extent(et, en);
 		else
 			__release_extent_node(sbi, et, en);
 
@@ -590,15 +587,15 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 	if (blkaddr) {
 
 		set_extent_info(&ei, fofs, blkaddr, len);
-		if (!__try_merge_extent_node(inode, et, &ei, prev_en, next_en))
-			__insert_extent_tree(inode, et, &ei,
+		if (!__try_merge_extent_node(sbi, et, &ei, prev_en, next_en))
+			__insert_extent_tree(sbi, et, &ei,
 						insert_p, insert_parent);
 
 		/* give up extent_cache, if split and small updates happen */
 		if (dei.len >= 1 &&
 				prev.len < F2FS_MIN_EXTENT_LEN &&
 				et->largest.len < F2FS_MIN_EXTENT_LEN) {
-			__drop_largest_extent(inode, 0, UINT_MAX);
+			et->largest.len = 0;
 			set_inode_flag(inode, FI_NO_EXTENT);
 		}
 	}
@@ -607,6 +604,9 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 		__free_extent_tree(sbi, et);
 
 	write_unlock(&et->lock);
+
+	if (old_largest != et->largest.len)
+		f2fs_mark_inode_dirty_sync(inode, true);
 }
 
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
@@ -713,8 +713,9 @@ void f2fs_drop_extent_tree(struct inode *inode)
 
 	write_lock(&et->lock);
 	__free_extent_tree(sbi, et);
-	__drop_largest_extent(inode, 0, UINT_MAX);
+	et->largest.len = 0;
 	write_unlock(&et->lock);
+	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
 void f2fs_destroy_extent_tree(struct inode *inode)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index abf9256..eef3016 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -754,13 +754,11 @@ static inline bool __is_front_mergeable(struct extent_info *cur,
 }
 
 extern void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync);
-static inline void __try_update_largest_extent(struct inode *inode,
-			struct extent_tree *et, struct extent_node *en)
+static inline void __try_update_largest_extent(struct extent_tree *et,
+						struct extent_node *en)
 {
-	if (en->ei.len > et->largest.len) {
+	if (en->ei.len > et->largest.len)
 		et->largest = en->ei;
-		f2fs_mark_inode_dirty_sync(inode, true);
-	}
 }
 
 /*
-- 
2.7.4
