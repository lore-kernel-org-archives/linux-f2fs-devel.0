From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [f2fs-dev] [PATCH RESEND] f2fs: Modify do_garbage_collect() to
 collect all the segs in once
Date: Fri, 12 Jul 2013 13:51:38 +0800
Message-ID: <51DF996A.4010803@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1UxWK2-0002jD-Lq
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 12 Jul 2013 05:55:14 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UxWK0-000191-MC for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 12 Jul 2013 05:55:14 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Current do_garbage_collect() collect per segment per time. If there are more
than one segments in section, we need to call do_garbage_collect() many times to
collect all the segments(current is a for loop). We can move the loop into the
do_garbage_collect(), so that we can collect all the segs of section in one time.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/gc.c |   59 ++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 35f9b1a..9589ffe 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -634,42 +634,50 @@ static int __get_victim(struct f2fs_sb_info *sbi, unsigned
int *victim,
 	return ret;
 }

-static void do_garbage_collect(struct f2fs_sb_info *sbi, unsigned int segno,
-				struct list_head *ilist, int gc_type)
+static void do_garbage_collect(struct f2fs_sb_info *sbi,
+		unsigned int start_segno, struct list_head *ilist, int gc_type)
 {
-	struct page *sum_page;
-	struct f2fs_summary_block *sum;
-	struct blk_plug plug;
+	unsigned int segno = start_segno;

-	/* read segment summary of victim */
-	sum_page = get_sum_page(sbi, segno);
-	if (IS_ERR(sum_page))
-		return;
+	for (; sbi->segs_per_sec--; segno++) {
+		struct page *sum_page;
+		struct f2fs_summary_block *sum;
+		struct blk_plug plug;

-	blk_start_plug(&plug);
+		/* read segment summary of victim */
+		sum_page = get_sum_page(sbi, segno);
+		if (IS_ERR(sum_page))
+			continue;

-	sum = page_address(sum_page);
+		blk_start_plug(&plug);

-	switch (GET_SUM_TYPE((&sum->footer))) {
-	case SUM_TYPE_NODE:
-		gc_node_segment(sbi, sum->entries, segno, gc_type);
-		break;
-	case SUM_TYPE_DATA:
-		gc_data_segment(sbi, sum->entries, ilist, segno, gc_type);
-		break;
-	}
-	blk_finish_plug(&plug);
+		sum = page_address(sum_page);

-	stat_inc_seg_count(sbi, GET_SUM_TYPE((&sum->footer)));
-	stat_inc_call_count(sbi->stat_info);
+		switch (GET_SUM_TYPE((&sum->footer))) {
+		case SUM_TYPE_NODE:
+			gc_node_segment(sbi, sum->entries,
+				segno, gc_type);
+			break;
+		case SUM_TYPE_DATA:
+			gc_data_segment(sbi, sum->entries, ilist,
+				segno, gc_type);
+			break;
+		default:
+			BUG();
+		}
+		blk_finish_plug(&plug);
+
+		stat_inc_seg_count(sbi, GET_SUM_TYPE((&sum->footer)));
+		stat_inc_call_count(sbi->stat_info);

-	f2fs_put_page(sum_page, 1);
+		f2fs_put_page(sum_page, 1);
+	}
 }

 int f2fs_gc(struct f2fs_sb_info *sbi)
 {
 	struct list_head ilist;
-	unsigned int segno, i;
+	unsigned int segno;
 	int gc_type = BG_GC;
 	int nfree = 0;
 	int ret = -1;
@@ -688,8 +696,7 @@ gc_more:
 		goto stop;
 	ret = 0;

-	for (i = 0; i < sbi->segs_per_sec; i++)
-		do_garbage_collect(sbi, segno + i, &ilist, gc_type);
+	do_garbage_collect(sbi, segno, &ilist, gc_type);

 	if (gc_type == FG_GC) {
 		sbi->cur_victim_sec = NULL_SEGNO;
-- 
1.7.7



------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
