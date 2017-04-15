From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: clean up discard_cmd_control structure
Date: Sat, 15 Apr 2017 14:09:36 +0800
Message-ID: <20170415060938.43694-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1czGuQ-0006DA-6P
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 15 Apr 2017 06:10:10 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187]
	helo=dggrg01-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1czGuL-0000a9-IT
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 15 Apr 2017 06:10:10 +0000
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

Avoid long variable name in discard_cmd_control structure, no logic
change.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    |  8 ++++----
 fs/f2fs/segment.c | 24 ++++++++++++------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 476e9459fa56..bc32c1b8ad67 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -220,12 +220,12 @@ struct discard_cmd {
 
 struct discard_cmd_control {
 	struct task_struct *f2fs_issue_discard;	/* discard thread */
-	struct list_head discard_entry_list;	/* 4KB discard entry list */
-	int nr_discards;			/* # of discards in the list */
-	struct list_head discard_pend_list;	/* store pending entries */
-	struct list_head discard_wait_list;	/* store on-flushing entries */
+	struct list_head entry_list;		/* 4KB discard entry list */
+	struct list_head pend_list;		/* store pending entries */
+	struct list_head wait_list;		/* store on-flushing entries */
 	wait_queue_head_t discard_wait_queue;	/* waiting queue for wake-up */
 	struct mutex cmd_lock;
+	int nr_discards;			/* # of discards in the list */
 	int max_discards;			/* max. discards to be issued */
 	atomic_t issued_discard;		/* # of issued discard */
 	atomic_t issing_discard;		/* # of issing discard */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c068dd6c016f..84648a716b01 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -677,7 +677,7 @@ static struct discard_cmd *__create_discard_cmd(struct f2fs_sb_info *sbi,
 		block_t start, block_t len)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-	struct list_head *pend_list = &(dcc->discard_pend_list);
+	struct list_head *pend_list = &(dcc->pend_list);
 	struct discard_cmd *dc;
 
 	dc = f2fs_kmem_cache_alloc(discard_cmd_slab, GFP_NOFS);
@@ -773,7 +773,7 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 			bio->bi_end_io = f2fs_submit_discard_endio;
 			bio->bi_opf |= REQ_SYNC;
 			submit_bio(bio);
-			list_move_tail(&dc->list, &dcc->discard_wait_list);
+			list_move_tail(&dc->list, &dcc->wait_list);
 		}
 	} else {
 		__remove_discard_cmd(sbi, dc);
@@ -961,8 +961,8 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-	struct list_head *pend_list = &(dcc->discard_pend_list);
-	struct list_head *wait_list = &(dcc->discard_wait_list);
+	struct list_head *pend_list = &(dcc->pend_list);
+	struct list_head *wait_list = &(dcc->wait_list);
 	struct discard_cmd *dc, *tmp;
 	struct blk_plug plug;
 
@@ -986,8 +986,8 @@ static int issue_discard_thread(void *data)
 	struct f2fs_sb_info *sbi = data;
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	wait_queue_head_t *q = &dcc->discard_wait_queue;
-	struct list_head *pend_list = &dcc->discard_pend_list;
-	struct list_head *wait_list = &dcc->discard_wait_list;
+	struct list_head *pend_list = &dcc->pend_list;
+	struct list_head *wait_list = &dcc->wait_list;
 	struct discard_cmd *dc, *tmp;
 	struct blk_plug plug;
 	int iter = 0;
@@ -1135,7 +1135,7 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
 	unsigned int start = 0, end = -1;
 	bool force = (cpc->reason == CP_DISCARD);
 	struct discard_entry *de = NULL;
-	struct list_head *head = &SM_I(sbi)->dcc_info->discard_entry_list;
+	struct list_head *head = &SM_I(sbi)->dcc_info->entry_list;
 	int i;
 
 	if (se->valid_blocks == max_blocks || !f2fs_discard_en(sbi))
@@ -1184,7 +1184,7 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
 
 void release_discard_addrs(struct f2fs_sb_info *sbi)
 {
-	struct list_head *head = &(SM_I(sbi)->dcc_info->discard_entry_list);
+	struct list_head *head = &(SM_I(sbi)->dcc_info->entry_list);
 	struct discard_entry *entry, *this;
 
 	/* drop caches */
@@ -1210,7 +1210,7 @@ static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
 
 void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
-	struct list_head *head = &(SM_I(sbi)->dcc_info->discard_entry_list);
+	struct list_head *head = &(SM_I(sbi)->dcc_info->entry_list);
 	struct discard_entry *entry, *this;
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	unsigned long *prefree_map = dirty_i->dirty_segmap[PRE];
@@ -1311,9 +1311,9 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	if (!dcc)
 		return -ENOMEM;
 
-	INIT_LIST_HEAD(&dcc->discard_entry_list);
-	INIT_LIST_HEAD(&dcc->discard_pend_list);
-	INIT_LIST_HEAD(&dcc->discard_wait_list);
+	INIT_LIST_HEAD(&dcc->entry_list);
+	INIT_LIST_HEAD(&dcc->pend_list);
+	INIT_LIST_HEAD(&dcc->wait_list);
 	mutex_init(&dcc->cmd_lock);
 	atomic_set(&dcc->issued_discard, 0);
 	atomic_set(&dcc->issing_discard, 0);
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
