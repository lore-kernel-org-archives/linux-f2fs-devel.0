From: Chao Yu <chao@kernel.org>
Subject: [PATCH v2 2/6] f2fs: wrap discard policy
Date: Wed,  4 Oct 2017 09:08:33 +0800
Message-ID: <20171004010837.9809-2-chao@kernel.org>
References: <20171004010837.9809-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1dzYBA-0004YL-5y
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Oct 2017 01:08:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dzYB8-0001RY-U1
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Oct 2017 01:08:52 +0000
In-Reply-To: <20171004010837.9809-1-chao@kernel.org>
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

From: Chao Yu <yuchao0@huawei.com>

This patch wraps scattered optional parameters into discard policy as
below, later, with it we expect that we can adjust these parameters with
proper strategy in different scenario.

struct discard_policy {
	unsigned int min_interval;	/* used for candidates exist */
	unsigned int max_interval;	/* used for candidates not exist */
	unsigned int max_requests;	/* # of discards issued per round */
	unsigned int io_aware_gran;	/* minimum granularity discard not be aware of I/O */
	bool io_aware;			/* issue discard in idle time */
	bool sync;			/* submit discard with REQ_SYNC flag */
};

This patch doesn't change any logic of codes.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- rebase on last codes of Jaegeuk's dev-test branch.
 fs/f2fs/f2fs.h    | 12 +++++++++++-
 fs/f2fs/segment.c | 38 +++++++++++++++++++++++++++++---------
 2 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6d51e8342513..67dd6a317384 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -149,7 +149,7 @@ enum {
 #define BATCHED_TRIM_BLOCKS(sbi)	\
 		(BATCHED_TRIM_SEGMENTS(sbi) << (sbi)->log_blocks_per_seg)
 #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
-#define DISCARD_ISSUE_RATE		8
+#define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
 #define DEF_MIN_DISCARD_ISSUE_TIME	50	/* 50 ms, if exists */
 #define DEF_MAX_DISCARD_ISSUE_TIME	60000	/* 60 s, if no candidates */
 #define DEF_CP_INTERVAL			60	/* 60 secs */
@@ -245,6 +245,15 @@ struct discard_cmd {
 	int error;			/* bio error */
 };
 
+struct discard_policy {
+	unsigned int min_interval;	/* used for candidates exist */
+	unsigned int max_interval;	/* used for candidates not exist */
+	unsigned int max_requests;	/* # of discards issued per round */
+	unsigned int io_aware_gran;	/* minimum granularity discard not be aware of I/O */
+	bool io_aware;			/* issue discard in idle time */
+	bool sync;			/* submit discard with REQ_SYNC flag */
+};
+
 struct discard_cmd_control {
 	struct task_struct *f2fs_issue_discard;	/* discard thread */
 	struct list_head entry_list;		/* 4KB discard entry list */
@@ -263,6 +272,7 @@ struct discard_cmd_control {
 	atomic_t issing_discard;		/* # of issing discard */
 	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
 	struct rb_root root;			/* root of discard rb-tree */
+	struct discard_policy dpolicy;		/* current discard policy */
 };
 
 /* for the list of fsync inodes, used only during recovery */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a0a0a887fc31..5853187230e7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -879,6 +879,7 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 	struct list_head *wait_list = fstrim ? &(dcc->fstrim_list) :
 							&(dcc->wait_list);
 	struct bio *bio = NULL;
+	int flag = dcc->dpolicy.sync ? REQ_SYNC : 0;
 
 	if (dc->state != D_PREP)
 		return;
@@ -897,7 +898,7 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		if (bio) {
 			bio->bi_private = dc;
 			bio->bi_end_io = f2fs_submit_discard_endio;
-			bio->bi_opf |= REQ_SYNC;
+			bio->bi_opf |= flag;
 			submit_bio(bio);
 			list_move_tail(&dc->list, wait_list);
 			__check_sit_bitmap(sbi, dc->start, dc->start + dc->len);
@@ -1092,6 +1093,7 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
 	struct rb_node **insert_p = NULL, *insert_parent = NULL;
 	struct discard_cmd *dc;
+	struct discard_policy *dpolicy = &dcc->dpolicy;
 	struct blk_plug plug;
 	int issued;
 
@@ -1124,7 +1126,7 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 
 		__submit_discard_cmd(sbi, dc, true);
 
-		if (++issued >= DISCARD_ISSUE_RATE) {
+		if (++issued >= dpolicy->max_requests) {
 			start = dc->lstart + dc->len;
 
 			blk_finish_plug(&plug);
@@ -1152,6 +1154,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
 	struct list_head *pend_list;
 	struct discard_cmd *dc, *tmp;
 	struct blk_plug plug;
+	struct discard_policy *dpolicy = &dcc->dpolicy;
 	int iter = 0, issued = 0;
 	int i;
 	bool io_interrupted = false;
@@ -1179,14 +1182,16 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
 				continue;
 			}
 
-			if (is_idle(sbi)) {
-				__submit_discard_cmd(sbi, dc, false);
-				issued++;
-			} else {
+			if (dpolicy->io_aware && i < dpolicy->io_aware_gran &&
+								!is_idle(sbi)) {
 				io_interrupted = true;
+				goto skip;
 			}
 
-			if (++iter >= DISCARD_ISSUE_RATE)
+			__submit_discard_cmd(sbi, dc, false);
+			issued++;
+skip:
+			if (++iter >= dpolicy->max_requests)
 				goto out;
 		}
 		if (list_empty(pend_list) && dcc->pend_list_tag[i] & P_TRIM)
@@ -1335,6 +1340,7 @@ static int issue_discard_thread(void *data)
 	struct f2fs_sb_info *sbi = data;
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	wait_queue_head_t *q = &dcc->discard_wait_queue;
+	struct discard_policy *dpolicy = &dcc->dpolicy;
 	unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
 	int issued;
 
@@ -1361,9 +1367,9 @@ static int issue_discard_thread(void *data)
 		issued = __issue_discard_cmd(sbi, true);
 		if (issued) {
 			__wait_all_discard_cmd(sbi, true);
-			wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
+			wait_ms = dpolicy->min_interval;
 		} else {
-			wait_ms = DEF_MAX_DISCARD_ISSUE_TIME;
+			wait_ms = dpolicy->max_interval;
 		}
 
 		sb_end_intwrite(sbi->sb);
@@ -1648,6 +1654,18 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	wake_up_discard_thread(sbi, false);
 }
 
+static void inline init_discard_policy(struct discard_cmd_control *dcc)
+{
+	struct discard_policy *dpolicy = &dcc->dpolicy;
+
+	dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
+	dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
+	dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
+	dpolicy->io_aware_gran = MAX_PLIST_NUM;
+	dpolicy->io_aware = true;
+	dpolicy->sync = true;
+}
+
 static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 {
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
@@ -1681,6 +1699,8 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	dcc->undiscard_blks = 0;
 	dcc->root = RB_ROOT;
 
+	init_discard_policy(dcc);
+
 	init_waitqueue_head(&dcc->discard_wait_queue);
 	SM_I(sbi)->dcc_info = dcc;
 init_thread:
-- 
2.14.1.145.gb3622a4ee


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
