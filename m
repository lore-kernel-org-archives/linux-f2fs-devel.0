From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/2] f2fs: clean up with a macro
Date: Tue, 04 Feb 2014 13:46:44 +0900
Message-ID: <1391489204-19695-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1391489204-19695-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WAXvu-0005a7-0d
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 04 Feb 2014 04:48:26 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WAXvq-0005OV-Pi
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 04 Feb 2014 04:48:25 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N0G00FMMG0E9YD0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 04 Feb 2014 13:48:14 +0900 (KST)
In-reply-to: <1391489204-19695-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds GET_BLKOFF_FROM_SEG0 to clean up some codes.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/recovery.c |  3 +--
 fs/f2fs/segment.c  | 11 ++++-------
 fs/f2fs/segment.h  |  3 +++
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index f1b0b89..bda04a0 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -218,8 +218,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 {
 	struct seg_entry *sentry;
 	unsigned int segno = GET_SEGNO(sbi, blkaddr);
-	unsigned short blkoff = GET_SEGOFF_FROM_SEG0(sbi, blkaddr) &
-					(sbi->blocks_per_seg - 1);
+	unsigned short blkoff = GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
 	struct f2fs_summary sum;
 	nid_t ino, nid;
 	void *kaddr;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fba510b..e87946a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -405,7 +405,7 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 
 	se = get_seg_entry(sbi, segno);
 	new_vblocks = se->valid_blocks + del;
-	offset = GET_SEGOFF_FROM_SEG0(sbi, blkaddr) & (sbi->blocks_per_seg - 1);
+	offset = GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
 
 	f2fs_bug_on((new_vblocks >> (sizeof(unsigned short) << 3) ||
 				(new_vblocks > sbi->blocks_per_seg)));
@@ -987,8 +987,7 @@ void recover_data_page(struct f2fs_sb_info *sbi,
 		change_curseg(sbi, type, true);
 	}
 
-	curseg->next_blkoff = GET_SEGOFF_FROM_SEG0(sbi, new_blkaddr) &
-					(sbi->blocks_per_seg - 1);
+	curseg->next_blkoff = GET_BLKOFF_FROM_SEG0(sbi, new_blkaddr);
 	__add_sum_entry(sbi, type, sum);
 
 	refresh_sit_entry(sbi, old_blkaddr, new_blkaddr);
@@ -1026,8 +1025,7 @@ void rewrite_node_page(struct f2fs_sb_info *sbi,
 		curseg->next_segno = segno;
 		change_curseg(sbi, type, true);
 	}
-	curseg->next_blkoff = GET_SEGOFF_FROM_SEG0(sbi, new_blkaddr) &
-					(sbi->blocks_per_seg - 1);
+	curseg->next_blkoff = GET_BLKOFF_FROM_SEG0(sbi, new_blkaddr);
 	__add_sum_entry(sbi, type, sum);
 
 	/* change the current log to the next block addr in advance */
@@ -1035,8 +1033,7 @@ void rewrite_node_page(struct f2fs_sb_info *sbi,
 		curseg->next_segno = next_segno;
 		change_curseg(sbi, type, true);
 	}
-	curseg->next_blkoff = GET_SEGOFF_FROM_SEG0(sbi, next_blkaddr) &
-					(sbi->blocks_per_seg - 1);
+	curseg->next_blkoff = GET_BLKOFF_FROM_SEG0(sbi, next_blkaddr);
 
 	/* rewrite node page */
 	set_page_writeback(page);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5731682..4024546 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -57,6 +57,9 @@
 	((blk_addr) - SM_I(sbi)->seg0_blkaddr)
 #define GET_SEGNO_FROM_SEG0(sbi, blk_addr)				\
 	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) >> sbi->log_blocks_per_seg)
+#define GET_BLKOFF_FROM_SEG0(sbi, blk_addr)				\
+	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) & (sbi->blocks_per_seg - 1))
+
 #define GET_SEGNO(sbi, blk_addr)					\
 	(((blk_addr == NULL_ADDR) || (blk_addr == NEW_ADDR)) ?		\
 	NULL_SEGNO : GET_L2R_SEGNO(FREE_I(sbi),			\
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
