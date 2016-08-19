From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: clean up foreground GC flow
Date: Fri, 19 Aug 2016 23:13:46 +0800
Message-ID: <1471619627-4174-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1balWe-0003BW-5H
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Aug 2016 15:16:04 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1balWc-0002Td-0s
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Aug 2016 15:16:04 +0000
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch changes to check valid block number of one GCed section
directly instead of checking the number in all segments of section
one by one in order to clean up codes of foreground GC.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 8f7fa32..c1599b4 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -815,7 +815,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	struct blk_plug plug;
 	unsigned int segno = start_segno;
 	unsigned int end_segno = start_segno + sbi->segs_per_sec;
-	int seg_freed = 0;
+	int sec_freed = 0;
 	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
 						SUM_TYPE_DATA : SUM_TYPE_NODE;
 
@@ -871,22 +871,20 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 	blk_finish_plug(&plug);
 
-	if (gc_type == FG_GC) {
-		while (start_segno < end_segno)
-			if (get_valid_blocks(sbi, start_segno++, 1) == 0)
-				seg_freed++;
-	}
+	if (gc_type == FG_GC &&
+		get_valid_blocks(sbi, start_segno, sbi->segs_per_sec) == 0)
+		sec_freed = 1;
 
 	stat_inc_call_count(sbi->stat_info);
 
-	return seg_freed;
+	return sec_freed;
 }
 
 int f2fs_gc(struct f2fs_sb_info *sbi, bool sync)
 {
 	unsigned int segno;
 	int gc_type = sync ? FG_GC : BG_GC;
-	int sec_freed = 0, seg_freed;
+	int sec_freed = 0;
 	int ret = -EINVAL;
 	struct cp_control cpc;
 	struct gc_inode_list gc_list = {
@@ -925,9 +923,8 @@ gc_more:
 		goto stop;
 	ret = 0;
 
-	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type);
-
-	if (gc_type == FG_GC && seg_freed == sbi->segs_per_sec)
+	if (do_garbage_collect(sbi, segno, &gc_list, gc_type) &&
+			gc_type == FG_GC)
 		sec_freed++;
 
 	if (gc_type == FG_GC)
-- 
2.7.2


------------------------------------------------------------------------------
