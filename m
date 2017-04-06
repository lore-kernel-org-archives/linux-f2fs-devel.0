From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: add a rb tree for discard command
Date: Thu, 6 Apr 2017 21:21:38 +0800
Message-ID: <20170406132138.25889-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cw7ID-0005UF-E2
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 06 Apr 2017 13:17:41 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cw7IB-0004Bv-Mn
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 06 Apr 2017 13:17:41 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

This patch add a rb tree for discard command.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/f2fs.h    |  2 ++
 fs/f2fs/segment.c | 35 ++++++++++++++++++++++++++++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5a2b8cd..5bc80dc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -197,6 +197,7 @@ enum {
 
 struct discard_cmd {
 	struct list_head list;		/* command list */
+	struct rb_node rb_node;         /* rb node located in rb-tree */
 	struct completion wait;		/* compleation */
 	struct block_device *bdev;	/* bdev */
 	block_t lstart;			/* logical start address */
@@ -210,6 +211,7 @@ struct discard_cmd_control {
 	struct task_struct *f2fs_issue_discard;	/* discard thread */
 	struct list_head discard_entry_list;	/* 4KB discard entry list */
 	int nr_discards;			/* # of discards in the list */
+	struct rb_root root;            /* root of extent info rb-tree */
 	struct list_head discard_pend_list;	/* store pending entries */
 	struct list_head discard_wait_list;	/* store on-flushing entries */
 	wait_queue_head_t discard_wait_queue;	/* waiting queue for wake-up */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index eedbed6..d96f11a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -678,7 +678,9 @@ static void __add_discard_cmd(struct f2fs_sb_info *sbi,
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct list_head *pend_list = &(dcc->discard_pend_list);
-	struct discard_cmd *dc;
+	struct discard_cmd *dc, *tmp;
+	struct rb_node **p = &dcc->root.rb_node;
+	struct rb_node *parent = NULL;
 
 	dc = f2fs_kmem_cache_alloc(discard_cmd_slab, GFP_NOFS);
 	INIT_LIST_HEAD(&dc->list);
@@ -691,6 +693,20 @@ static void __add_discard_cmd(struct f2fs_sb_info *sbi,
 	init_completion(&dc->wait);
 
 	mutex_lock(&dcc->cmd_lock);
+	while (*p) {
+		parent = *p;
+		tmp = rb_entry_safe(parent, struct discard_cmd, rb_node);
+
+		if (dc->lstart + dc->len <= tmp->lstart)
+			p = &(*p)->rb_left;
+		else if (dc->lstart >= tmp->lstart + tmp->len)
+			p = &(*p)->rb_right;
+		else
+			f2fs_bug_on(sbi, 1);
+	}
+
+	rb_link_node(&dc->rb_node, parent, p);
+	rb_insert_color(&dc->rb_node, &dcc->root);
 	list_add_tail(&dc->list, pend_list);
 	mutex_unlock(&dcc->cmd_lock);
 
@@ -709,6 +725,7 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi, struct discard_cmd *d
 		f2fs_msg(sbi->sb, KERN_INFO,
 				"Issue discard failed, ret: %d", dc->error);
 	list_del(&dc->list);
+	rb_erase(&dc->rb_node, &(SM_I(sbi)->dcc_info->root));
 	kmem_cache_free(discard_cmd_slab, dc);
 	atomic_dec(&SM_I(sbi)->dcc_info->discard_cmd_cnt);
 }
@@ -794,16 +811,23 @@ static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
 void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-	struct list_head *pend_list = &(dcc->discard_pend_list);
-	struct discard_cmd *dc, *tmp;
+	struct discard_cmd *dc;
+	struct rb_node *node = dcc->root.rb_node;
 
 	mutex_lock(&dcc->cmd_lock);
 
-	list_for_each_entry_safe(dc, tmp, pend_list, list) {
-		if (dc->lstart <= blkaddr && blkaddr < dc->lstart + dc->len) {
+	while (node) {
+		dc = rb_entry_safe(node, struct discard_cmd, rb_node);
+
+		if (blkaddr < dc->lstart) {
+			node = node->rb_left;
+		} else if (blkaddr >= dc->lstart + dc->len) {
+			node = node->rb_right;
+		} else {
 			if (dc->state == D_SUBMIT)
 				wait_for_completion_io(&dc->wait);
 			__punch_discard_cmd(sbi, dc, blkaddr);
+			break;
 		}
 	}
 
@@ -1165,6 +1189,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	INIT_LIST_HEAD(&dcc->discard_entry_list);
 	INIT_LIST_HEAD(&dcc->discard_pend_list);
 	INIT_LIST_HEAD(&dcc->discard_wait_list);
+	dcc->root = RB_ROOT;
 	mutex_init(&dcc->cmd_lock);
 	atomic_set(&dcc->issued_discard, 0);
 	atomic_set(&dcc->issing_discard, 0);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
