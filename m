From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: disable f2fs_check_rb_tree_consistence
Date: Fri, 22 Jun 2018 16:06:59 +0800
Message-ID: <20180622080659.10469-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fWH76-0002HN-ON
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jun 2018 08:08:12 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fWH74-003AbY-Lc
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jun 2018 08:08:12 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

If there is millions of discard entries cached in rb tree, each
sanity check of it can cause very long latency as held cmd_lock
blocking other lock grabbers.

In other aspect, we have enabled the check very long time, as
we see, there is no such inconsistent condition caused by bugs.

But still we do not choose to kill it directly, instead, adding
an flag to disable the check now, if there is related code change,
we can reuse it to detect bugs.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2: use unlikely suggested by Jaegeuk.
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 99ad25513b4c..5302bad1566b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -309,6 +309,7 @@ struct discard_cmd_control {
 	atomic_t issing_discard;		/* # of issing discard */
 	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
 	struct rb_root root;			/* root of discard rb-tree */
+	bool rbtree_check;			/* config for consistence check */
 };
 
 /* for the list of fsync inodes, used only during recovery */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 553075973be4..f7eaefe8b1d1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1199,8 +1199,9 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 		mutex_lock(&dcc->cmd_lock);
 		if (list_empty(pend_list))
 			goto next;
-		f2fs_bug_on(sbi,
-			!f2fs_check_rb_tree_consistence(sbi, &dcc->root));
+		if (unlikely(dcc->rbtree_check))
+			f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
+								&dcc->root));
 		blk_start_plug(&plug);
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
@@ -1752,6 +1753,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
 	dcc->undiscard_blks = 0;
 	dcc->root = RB_ROOT;
+	dcc->rbtree_check = false;
 
 	init_waitqueue_head(&dcc->discard_wait_queue);
 	SM_I(sbi)->dcc_info = dcc;
@@ -2381,7 +2383,9 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 	issued = 0;
 
 	mutex_lock(&dcc->cmd_lock);
-	f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi, &dcc->root));
+	if (unlikely(dcc->rbtree_check))
+		f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
+								&dcc->root));
 
 	dc = (struct discard_cmd *)f2fs_lookup_rb_tree_ret(&dcc->root,
 					NULL, start,
-- 
2.18.0.rc1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
