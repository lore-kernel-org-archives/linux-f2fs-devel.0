From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/5] f2fs: retry gc if one section is not
	successfully reclaimed
Date: Tue, 18 Aug 2015 01:46:27 -0700
Message-ID: <1439887589-35190-3-git-send-email-jaegeuk@kernel.org>
References: <1439887589-35190-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZRcXX-0004Gl-TE
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Aug 2015 08:46:39 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZRcXW-0001r4-TV for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Aug 2015 08:46:39 +0000
In-Reply-To: <1439887589-35190-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

If FG_GC failed to reclaim one section, let's retry with another section
from the start, since we can get anoterh good candidate.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0a5d573..c40dda3 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -391,7 +391,7 @@ static int check_valid_map(struct f2fs_sb_info *sbi,
  * On validity, copy that node with cold status, otherwise (invalid node)
  * ignore that.
  */
-static void gc_node_segment(struct f2fs_sb_info *sbi,
+static int gc_node_segment(struct f2fs_sb_info *sbi,
 		struct f2fs_summary *sum, unsigned int segno, int gc_type)
 {
 	bool initial = true;
@@ -411,7 +411,7 @@ next_step:
 
 		/* stop BG_GC if there is not enough free sections. */
 		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0))
-			return;
+			return 0;
 
 		if (check_valid_map(sbi, segno, off) == 0)
 			continue;
@@ -461,13 +461,11 @@ next_step:
 		};
 		sync_node_pages(sbi, 0, &wbc);
 
-		/*
-		 * In the case of FG_GC, it'd be better to reclaim this victim
-		 * completely.
-		 */
-		if (get_valid_blocks(sbi, segno, 1) != 0)
-			goto next_step;
+		/* return 1 only if FG_GC succefully reclaimed one */
+		if (get_valid_blocks(sbi, segno, 1) == 0)
+			return 1;
 	}
+	return 0;
 }
 
 /*
@@ -649,7 +647,7 @@ out:
  * If the parent node is not valid or the data block address is different,
  * the victim data block is ignored.
  */
-static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
+static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		struct gc_inode_list *gc_list, unsigned int segno, int gc_type)
 {
 	struct super_block *sb = sbi->sb;
@@ -672,7 +670,7 @@ next_step:
 
 		/* stop BG_GC if there is not enough free sections. */
 		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0))
-			return;
+			return 0;
 
 		if (check_valid_map(sbi, segno, off) == 0)
 			continue;
@@ -737,15 +735,11 @@ next_step:
 	if (gc_type == FG_GC) {
 		f2fs_submit_merged_bio(sbi, DATA, WRITE);
 
-		/*
-		 * In the case of FG_GC, it'd be better to reclaim this victim
-		 * completely.
-		 */
-		if (get_valid_blocks(sbi, segno, 1) != 0) {
-			phase = 2;
-			goto next_step;
-		}
+		/* return 1 only if FG_GC succefully reclaimed one */
+		if (get_valid_blocks(sbi, segno, 1) == 0)
+			return 1;
 	}
+	return 0;
 }
 
 static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
@@ -761,12 +755,13 @@ static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
 	return ret;
 }
 
-static void do_garbage_collect(struct f2fs_sb_info *sbi, unsigned int segno,
+static int do_garbage_collect(struct f2fs_sb_info *sbi, unsigned int segno,
 				struct gc_inode_list *gc_list, int gc_type)
 {
 	struct page *sum_page;
 	struct f2fs_summary_block *sum;
 	struct blk_plug plug;
+	int nfree = 0;
 
 	/* read segment summary of victim */
 	sum_page = get_sum_page(sbi, segno);
@@ -786,10 +781,11 @@ static void do_garbage_collect(struct f2fs_sb_info *sbi, unsigned int segno,
 
 	switch (GET_SUM_TYPE((&sum->footer))) {
 	case SUM_TYPE_NODE:
-		gc_node_segment(sbi, sum->entries, segno, gc_type);
+		nfree = gc_node_segment(sbi, sum->entries, segno, gc_type);
 		break;
 	case SUM_TYPE_DATA:
-		gc_data_segment(sbi, sum->entries, gc_list, segno, gc_type);
+		nfree = gc_data_segment(sbi, sum->entries, gc_list,
+							segno, gc_type);
 		break;
 	}
 	blk_finish_plug(&plug);
@@ -798,6 +794,7 @@ static void do_garbage_collect(struct f2fs_sb_info *sbi, unsigned int segno,
 	stat_inc_call_count(sbi->stat_info);
 
 	f2fs_put_page(sum_page, 0);
+	return nfree;
 }
 
 int f2fs_gc(struct f2fs_sb_info *sbi)
@@ -836,11 +833,10 @@ gc_more:
 								META_SSA);
 
 	for (i = 0; i < sbi->segs_per_sec; i++)
-		do_garbage_collect(sbi, segno + i, &gc_list, gc_type);
+		nfree += do_garbage_collect(sbi, segno + i, &gc_list, gc_type);
 
 	if (gc_type == FG_GC) {
 		sbi->cur_victim_sec = NULL_SEGNO;
-		nfree++;
 		WARN_ON(get_valid_blocks(sbi, segno, sbi->segs_per_sec));
 	}
 
-- 
2.1.1


------------------------------------------------------------------------------
