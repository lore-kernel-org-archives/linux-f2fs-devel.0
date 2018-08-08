From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix use-after-free of dicard command entry
Date: Wed, 8 Aug 2018 10:14:55 +0800
Message-ID: <20180808021455.109291-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

As Dan Carpenter reported:

The patch 20ee4382322c: "f2fs: issue small discard by LBA order" from
Jul 8, 2018, leads to the following Smatch warning:

	fs/f2fs/segment.c:1277 __issue_discard_cmd_orderly()
	warn: 'dc' was already freed.

See also:
fs/f2fs/segment.c:2550 __issue_discard_cmd_range() warn: 'dc' was already freed.

In order to fix this issue, let's get error from __submit_discard_cmd(),
and release current discard command after we referenced next one.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 79 +++++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 34 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index be1bf38400ca..8826ea683804 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -998,7 +998,7 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 				struct block_device *bdev, block_t lstart,
 				block_t start, block_t len);
 /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
-static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
+static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 						struct discard_policy *dpolicy,
 						struct discard_cmd *dc,
 						unsigned int *issued)
@@ -1015,10 +1015,10 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 	int err = 0;
 
 	if (dc->state != D_PREP)
-		return;
+		return 0;
 
 	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
-		return;
+		return 0;
 
 	trace_f2fs_issue_discard(bdev, dc->start, dc->len);
 
@@ -1057,43 +1057,44 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 					SECTOR_FROM_BLOCK(len),
 					GFP_NOFS, 0, &bio);
 submit:
-		if (!err && bio) {
-			/*
-			 * should keep before submission to avoid D_DONE
-			 * right away
-			 */
+		if (err) {
 			spin_lock_irqsave(&dc->lock, flags);
-			if (last)
+			if (dc->state == D_PARTIAL)
 				dc->state = D_SUBMIT;
-			else
-				dc->state = D_PARTIAL;
-			dc->bio_ref++;
 			spin_unlock_irqrestore(&dc->lock, flags);
 
-			atomic_inc(&dcc->issing_discard);
-			dc->issuing++;
-			list_move_tail(&dc->list, wait_list);
+			break;
+		}
 
-			/* sanity check on discard range */
-			__check_sit_bitmap(sbi, start, start + len);
+		f2fs_bug_on(sbi, !bio);
 
-			bio->bi_private = dc;
-			bio->bi_end_io = f2fs_submit_discard_endio;
-			bio->bi_opf |= flag;
-			submit_bio(bio);
+		/*
+		 * should keep before submission to avoid D_DONE
+		 * right away
+		 */
+		spin_lock_irqsave(&dc->lock, flags);
+		if (last)
+			dc->state = D_SUBMIT;
+		else
+			dc->state = D_PARTIAL;
+		dc->bio_ref++;
+		spin_unlock_irqrestore(&dc->lock, flags);
 
-			atomic_inc(&dcc->issued_discard);
+		atomic_inc(&dcc->issing_discard);
+		dc->issuing++;
+		list_move_tail(&dc->list, wait_list);
 
-			f2fs_update_iostat(sbi, FS_DISCARD, 1);
-		} else {
-			spin_lock_irqsave(&dc->lock, flags);
-			if (dc->state == D_PARTIAL)
-				dc->state = D_SUBMIT;
-			spin_unlock_irqrestore(&dc->lock, flags);
+		/* sanity check on discard range */
+		__check_sit_bitmap(sbi, start, start + len);
 
-			__remove_discard_cmd(sbi, dc);
-			err = -EIO;
-		}
+		bio->bi_private = dc;
+		bio->bi_end_io = f2fs_submit_discard_endio;
+		bio->bi_opf |= flag;
+		submit_bio(bio);
+
+		atomic_inc(&dcc->issued_discard);
+
+		f2fs_update_iostat(sbi, FS_DISCARD, 1);
 
 		lstart += len;
 		start += len;
@@ -1101,8 +1102,9 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		len = total_len;
 	}
 
-	if (len)
+	if (!err && len)
 		__update_discard_tree_range(sbi, bdev, lstart, start, len);
+	return err;
 }
 
 static struct discard_cmd *__insert_discard_tree(struct f2fs_sb_info *sbi,
@@ -1308,6 +1310,7 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 
 	while (dc) {
 		struct rb_node *node;
+		int err = 0;
 
 		if (dc->state != D_PREP)
 			goto next;
@@ -1318,12 +1321,14 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 		}
 
 		dcc->next_pos = dc->lstart + dc->len;
-		__submit_discard_cmd(sbi, dpolicy, dc, &issued);
+		err = __submit_discard_cmd(sbi, dpolicy, dc, &issued);
 
 		if (issued >= dpolicy->max_requests)
 			break;
 next:
 		node = rb_next(&dc->rb_node);
+		if (err)
+			__remove_discard_cmd(sbi, dc);
 		dc = rb_entry_safe(node, struct discard_cmd, rb_node);
 	}
 
@@ -2577,6 +2582,7 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 
 	while (dc && dc->lstart <= end) {
 		struct rb_node *node;
+		int err = 0;
 
 		if (dc->len < dpolicy->granularity)
 			goto skip;
@@ -2586,11 +2592,14 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 			goto skip;
 		}
 
-		__submit_discard_cmd(sbi, dpolicy, dc, &issued);
+		err = __submit_discard_cmd(sbi, dpolicy, dc, &issued);
 
 		if (issued >= dpolicy->max_requests) {
 			start = dc->lstart + dc->len;
 
+			if (err)
+				__remove_discard_cmd(sbi, dc);
+
 			blk_finish_plug(&plug);
 			mutex_unlock(&dcc->cmd_lock);
 			trimmed += __wait_all_discard_cmd(sbi, NULL);
@@ -2599,6 +2608,8 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 		}
 skip:
 		node = rb_next(&dc->rb_node);
+		if (err)
+			__remove_discard_cmd(sbi, dc);
 		dc = rb_entry_safe(node, struct discard_cmd, rb_node);
 
 		if (fatal_signal_pending(current))
-- 
2.18.0.rc1
