From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: use rb-tree to track pending discard
	commands
Date: Fri, 14 Apr 2017 17:41:32 +0800
Message-ID: <20170414094132.12375-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cyxk9-0003vg-SP
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Apr 2017 09:42:17 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187]
	helo=dggrg01-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cyxk4-0004LQ-OV
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Apr 2017 09:42:17 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Introduce rb-tree based discard cache infrastructure to speed up lookup and
merge operation of discard entry.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/extent_cache.c |   6 +-
 fs/f2fs/f2fs.h         |  47 ++++++++++-
 fs/f2fs/segment.c      | 223 ++++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 230 insertions(+), 46 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 68e649a31c7d..4624e87d3843 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -49,7 +49,7 @@ static struct rb_entry *__lookup_rb_tree_slow(struct rb_root *root,
 	return NULL;
 }
 
-static struct rb_entry *__lookup_rb_tree(struct rb_root *root,
+struct rb_entry *__lookup_rb_tree(struct rb_root *root,
 				struct rb_entry *cached_re, unsigned int ofs)
 {
 	struct rb_entry *re;
@@ -61,7 +61,7 @@ static struct rb_entry *__lookup_rb_tree(struct rb_root *root,
 	return re;
 }
 
-static struct rb_node **__lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
+struct rb_node **__lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
 				struct rb_root *root, struct rb_node **parent,
 				unsigned int ofs)
 {
@@ -92,7 +92,7 @@ static struct rb_node **__lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
  * in order to simpfy the insertion after.
  * tree must stay unchanged between lookup and insertion.
  */
-static struct rb_entry *__lookup_rb_tree_ret(struct rb_root *root,
+struct rb_entry *__lookup_rb_tree_ret(struct rb_root *root,
 				struct rb_entry *cached_re,
 				unsigned int ofs,
 				struct rb_entry **prev_entry,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 562db8989a4e..17c492f0d5b9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -194,13 +194,26 @@ enum {
 	D_DONE,
 };
 
+struct discard_info {
+	block_t lstart;			/* logical start address */
+	block_t len;			/* length */
+	block_t start;			/* actual start address in dev */
+};
+
 struct discard_cmd {
+	struct rb_node rb_node;		/* rb node located in rb-tree */
+	union {
+		struct {
+			block_t lstart;	/* logical start address */
+			block_t len;	/* length */
+			block_t start;	/* actual start address in dev */
+		};
+		struct discard_info di;	/* discard info */
+
+	};
 	struct list_head list;		/* command list */
 	struct completion wait;		/* compleation */
 	struct block_device *bdev;	/* bdev */
-	block_t lstart;			/* logical start address */
-	block_t start;			/* actual start address in dev */
-	block_t len;			/* length */
 	int state;			/* state */
 	int error;			/* bio error */
 };
@@ -217,6 +230,7 @@ struct discard_cmd_control {
 	atomic_t issued_discard;		/* # of issued discard */
 	atomic_t issing_discard;		/* # of issing discard */
 	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
+	struct rb_root root;			/* root of discard rb-tree */
 };
 
 /* for the list of fsync inodes, used only during recovery */
@@ -517,6 +531,24 @@ static inline void set_extent_info(struct extent_info *ei, unsigned int fofs,
 	ei->len = len;
 }
 
+static inline bool __is_discard_mergeable(struct discard_info *back,
+						struct discard_info *front)
+{
+	return back->lstart + back->len == front->lstart;
+}
+
+static inline bool __is_discard_back_mergeable(struct discard_info *cur,
+						struct discard_info *back)
+{
+	return __is_discard_mergeable(back, cur);
+}
+
+static inline bool __is_discard_front_mergeable(struct discard_info *cur,
+						struct discard_info *front)
+{
+	return __is_discard_mergeable(cur, front);
+}
+
 static inline bool __is_extent_mergeable(struct extent_info *back,
 						struct extent_info *front)
 {
@@ -2573,6 +2605,15 @@ void f2fs_leave_shrinker(struct f2fs_sb_info *sbi);
 /*
  * extent_cache.c
  */
+struct rb_entry *__lookup_rb_tree(struct rb_root *root,
+				struct rb_entry *cached_re, unsigned int ofs);
+struct rb_node **__lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
+				struct rb_root *root, struct rb_node **parent,
+				unsigned int ofs);
+struct rb_entry *__lookup_rb_tree_ret(struct rb_root *root,
+		struct rb_entry *cached_re, unsigned int ofs,
+		struct rb_entry **prev_entry, struct rb_entry **next_entry,
+		struct rb_node ***insert_p, struct rb_node **insert_parent);
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink);
 bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext);
 void f2fs_drop_extent_tree(struct inode *inode);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 58cfbe3d4dc7..0057bdf99ed3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -672,7 +672,7 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 	mutex_unlock(&dirty_i->seglist_lock);
 }
 
-static void __add_discard_cmd(struct f2fs_sb_info *sbi,
+static struct discard_cmd *__create_discard_cmd(struct f2fs_sb_info *sbi,
 		struct block_device *bdev, block_t lstart,
 		block_t start, block_t len)
 {
@@ -689,18 +689,46 @@ static void __add_discard_cmd(struct f2fs_sb_info *sbi,
 	dc->state = D_PREP;
 	dc->error = 0;
 	init_completion(&dc->wait);
-
-	mutex_lock(&dcc->cmd_lock);
 	list_add_tail(&dc->list, pend_list);
-	mutex_unlock(&dcc->cmd_lock);
-
 	atomic_inc(&dcc->discard_cmd_cnt);
+
+	return dc;
+}
+
+static struct discard_cmd *__attach_discard_cmd(struct f2fs_sb_info *sbi,
+				struct block_device *bdev, block_t lstart,
+				block_t start, block_t len,
+				struct rb_node *parent, struct rb_node **p)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct discard_cmd *dc;
+
+	dc = __create_discard_cmd(sbi, bdev, lstart, start, len);
+
+	rb_link_node(&dc->rb_node, parent, p);
+	rb_insert_color(&dc->rb_node, &dcc->root);
+
+	return dc;
 }
 
-static void __remove_discard_cmd(struct f2fs_sb_info *sbi, struct discard_cmd *dc)
+static void __detach_discard_cmd(struct discard_cmd_control *dcc,
+							struct discard_cmd *dc)
 {
 	if (dc->state == D_DONE)
-		atomic_dec(&(SM_I(sbi)->dcc_info->issing_discard));
+		atomic_dec(&dcc->issing_discard);
+
+	list_del(&dc->list);
+	rb_erase(&dc->rb_node, &dcc->root);
+
+	kmem_cache_free(discard_cmd_slab, dc);
+
+	atomic_dec(&dcc->discard_cmd_cnt);
+}
+
+static void __remove_discard_cmd(struct f2fs_sb_info *sbi,
+							struct discard_cmd *dc)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 
 	if (dc->error == -EOPNOTSUPP)
 		dc->error = 0;
@@ -708,9 +736,7 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi, struct discard_cmd *d
 	if (dc->error)
 		f2fs_msg(sbi->sb, KERN_INFO,
 				"Issue discard failed, ret: %d", dc->error);
-	list_del(&dc->list);
-	kmem_cache_free(discard_cmd_slab, dc);
-	atomic_dec(&SM_I(sbi)->dcc_info->discard_cmd_cnt);
+	__detach_discard_cmd(dcc, dc);
 }
 
 static void f2fs_submit_discard_endio(struct bio *bio)
@@ -754,62 +780,178 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 	}
 }
 
-static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
-		struct block_device *bdev, block_t blkstart, block_t blklen)
+static struct discard_cmd *__insert_discard_tree(struct f2fs_sb_info *sbi,
+				struct block_device *bdev, block_t lstart,
+				block_t start, block_t len,
+				struct rb_node **insert_p,
+				struct rb_node *insert_parent)
 {
-	block_t lblkstart = blkstart;
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct rb_node **p = &dcc->root.rb_node;
+	struct rb_node *parent = NULL;
+	struct discard_cmd *dc = NULL;
 
-	trace_f2fs_issue_discard(bdev, blkstart, blklen);
+	if (insert_p && insert_parent) {
+		parent = insert_parent;
+		p = insert_p;
+		goto do_insert;
+	}
 
-	if (sbi->s_ndevs) {
-		int devi = f2fs_target_device_index(sbi, blkstart);
+	p = __lookup_rb_tree_for_insert(sbi, &dcc->root, &parent, lstart);
+do_insert:
+	dc = __attach_discard_cmd(sbi, bdev, lstart, start, len, parent, p);
+	if (!dc)
+		return NULL;
 
-		blkstart -= FDEV(devi).start_blk;
-	}
-	__add_discard_cmd(sbi, bdev, lblkstart, blkstart, blklen);
-	wake_up(&SM_I(sbi)->dcc_info->discard_wait_queue);
-	return 0;
+	return dc;
 }
 
 static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
 				struct discard_cmd *dc, block_t blkaddr)
 {
-	block_t end_block = START_BLOCK(sbi, GET_SEGNO(sbi, blkaddr) + 1);
+	struct discard_info di = dc->di;
+	bool modified = false;
 
-	if (dc->state == D_DONE || dc->lstart + dc->len <= end_block) {
+	if (dc->state == D_DONE || dc->len == 1) {
 		__remove_discard_cmd(sbi, dc);
 		return;
 	}
 
-	if (blkaddr - dc->lstart < dc->lstart + dc->len - end_block) {
-		dc->start += (end_block - dc->lstart);
-		dc->len -= (end_block - dc->lstart);
-		dc->lstart = end_block;
-	} else {
+	if (blkaddr > di.lstart) {
 		dc->len = blkaddr - dc->lstart;
+		modified = true;
+	}
+
+	if (blkaddr < di.lstart + di.len - 1) {
+		if (modified) {
+			__insert_discard_tree(sbi, dc->bdev, blkaddr + 1,
+					di.start + blkaddr + 1 - di.lstart,
+					di.lstart + di.len - 1 - blkaddr,
+					NULL, NULL);
+		} else {
+			dc->lstart++;
+			dc->len--;
+			dc->start++;
+		}
 	}
 }
 
-/* This should be covered by global mutex, &sit_i->sentry_lock */
-void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
+static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
+				struct block_device *bdev, block_t lstart,
+				block_t start, block_t len)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-	struct list_head *pend_list = &(dcc->discard_pend_list);
-	struct list_head *wait_list = &(dcc->discard_wait_list);
-	struct discard_cmd *dc, *tmp;
+	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
+	struct discard_cmd *dc;
+	struct discard_info di;
+	struct rb_node **insert_p = NULL, *insert_parent = NULL;
+	block_t end = lstart + len;
 
 	mutex_lock(&dcc->cmd_lock);
 
-	list_for_each_entry_safe(dc, tmp, pend_list, list) {
-		if (dc->lstart <= blkaddr && blkaddr < dc->lstart + dc->len)
-			__punch_discard_cmd(sbi, dc, blkaddr);
+	dc = (struct discard_cmd *)__lookup_rb_tree_ret(&dcc->root,
+					NULL, lstart,
+					(struct rb_entry **)&prev_dc,
+					(struct rb_entry **)&next_dc,
+					&insert_p, &insert_parent);
+	if (dc)
+		prev_dc = dc;
+
+	if (!prev_dc) {
+		di.lstart = lstart;
+		di.len = next_dc ? next_dc->lstart - lstart : len;
+		di.len = min(di.len, len);
+		di.start = start;
 	}
 
-	list_for_each_entry_safe(dc, tmp, wait_list, list) {
-		if (dc->lstart <= blkaddr && blkaddr < dc->lstart + dc->len) {
-			wait_for_completion_io(&dc->wait);
-			__punch_discard_cmd(sbi, dc, blkaddr);
+	while (1) {
+		struct rb_node *node;
+		bool merged = false;
+		struct discard_cmd *tdc = NULL;
+
+		if (prev_dc) {
+			di.lstart = prev_dc->lstart + prev_dc->len;
+			if (di.lstart < lstart)
+				di.lstart = lstart;
+			if (di.lstart >= end)
+				break;
+
+			if (!next_dc || next_dc->lstart > end)
+				di.len = end - di.lstart;
+			else
+				di.len = next_dc->lstart - di.lstart;
+			di.start = start + di.lstart - lstart;
+		}
+
+		if (!di.len)
+			goto next;
+
+		if (prev_dc && prev_dc->state == D_PREP &&
+			prev_dc->bdev == bdev &&
+			__is_discard_back_mergeable(&di, &prev_dc->di)) {
+			prev_dc->di.len += di.len;
+			di = prev_dc->di;
+			tdc = prev_dc;
+			merged = true;
+		}
+
+		if (next_dc && next_dc->state == D_PREP &&
+			next_dc->bdev == bdev &&
+			__is_discard_front_mergeable(&di, &next_dc->di)) {
+			next_dc->di.lstart = di.lstart;
+			next_dc->di.len += di.len;
+			next_dc->di.start = di.start;
+			if (tdc)
+				__remove_discard_cmd(sbi, tdc);
+
+			merged = true;
 		}
+
+		if (!merged)
+			__insert_discard_tree(sbi, bdev, di.lstart, di.start,
+							di.len, NULL, NULL);
+ next:
+		prev_dc = next_dc;
+		if (!prev_dc)
+			break;
+
+		node = rb_next(&prev_dc->rb_node);
+		next_dc = rb_entry_safe(node, struct discard_cmd, rb_node);
+	}
+
+	mutex_unlock(&dcc->cmd_lock);
+}
+
+static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
+		struct block_device *bdev, block_t blkstart, block_t blklen)
+{
+	block_t lblkstart = blkstart;
+
+	trace_f2fs_issue_discard(bdev, blkstart, blklen);
+
+	if (sbi->s_ndevs) {
+		int devi = f2fs_target_device_index(sbi, blkstart);
+
+		blkstart -= FDEV(devi).start_blk;
+	}
+	__update_discard_tree_range(sbi, bdev, lblkstart, blkstart, blklen);
+	wake_up(&SM_I(sbi)->dcc_info->discard_wait_queue);
+	return 0;
+}
+
+/* This should be covered by global mutex, &sit_i->sentry_lock */
+void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct discard_cmd *dc;
+
+	mutex_lock(&dcc->cmd_lock);
+
+	dc = (struct discard_cmd *)__lookup_rb_tree(&dcc->root, NULL, blkaddr);
+	if (dc) {
+		if (dc->state != D_PREP)
+			wait_for_completion_io(&dc->wait);
+		__punch_discard_cmd(sbi, dc, blkaddr);
 	}
 
 	mutex_unlock(&dcc->cmd_lock);
@@ -1178,6 +1320,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	atomic_set(&dcc->discard_cmd_cnt, 0);
 	dcc->nr_discards = 0;
 	dcc->max_discards = 0;
+	dcc->root = RB_ROOT;
 
 	init_waitqueue_head(&dcc->discard_wait_queue);
 	SM_I(sbi)->dcc_info = dcc;
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
