From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/6] f2fs: add BUG cases to initiate fsck.f2fs
Date: Tue,  2 Sep 2014 22:02:32 -0700
Message-ID: <1409720554-72925-4-git-send-email-jaegeuk@kernel.org>
References: <1409720554-72925-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XP2iW-00078X-HP
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 Sep 2014 05:02:48 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XP2iV-0006Re-LA for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 Sep 2014 05:02:48 +0000
In-Reply-To: <1409720554-72925-1-git-send-email-jaegeuk@kernel.org>
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

This patch replaces BUG cases with f2fs_bug_on to remain fsck.f2fs information.
And it implements some void functions to initiate fsck.f2fs too.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c |  4 ++--
 fs/f2fs/segment.h | 38 +++++++++++++++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index abfbbca..46586d3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -526,10 +526,10 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 	/* Update valid block bitmap */
 	if (del > 0) {
 		if (f2fs_set_bit(offset, se->cur_valid_map))
-			BUG();
+			f2fs_bug_on(sbi, 1);
 	} else {
 		if (!f2fs_clear_bit(offset, se->cur_valid_map))
-			BUG();
+			f2fs_bug_on(sbi, 1);
 	}
 	if (!f2fs_test_bit(offset, se->ckpt_valid_map))
 		se->ckpt_valid_blocks += del;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 793ca27..d163fc8 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -583,9 +583,41 @@ static inline void check_block_count(struct f2fs_sb_info *sbi,
 	BUG_ON(GET_SIT_VBLOCKS(raw_sit) != valid_blocks);
 }
 #else
-#define check_seg_range(sbi, segno)
-#define verify_block_addr(sbi, blk_addr)
-#define check_block_count(sbi, segno, raw_sit)
+static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
+{
+	unsigned int end_segno = SM_I(sbi)->segment_count - 1;
+
+	if (segno > end_segno)
+		sbi->need_fsck = true;
+}
+
+static inline void verify_block_addr(struct f2fs_sb_info *sbi, block_t blk_addr)
+{
+	struct f2fs_sm_info *sm_info = SM_I(sbi);
+	block_t total_blks = sm_info->segment_count << sbi->log_blocks_per_seg;
+	block_t start_addr = sm_info->seg0_blkaddr;
+	block_t end_addr = start_addr + total_blks - 1;
+
+	if (blk_addr < start_addr || blk_addr > end_addr)
+		sbi->need_fsck = true;
+}
+
+/*
+ * Summary block is always treated as an invalid block
+ */
+static inline void check_block_count(struct f2fs_sb_info *sbi,
+		int segno, struct f2fs_sit_entry *raw_sit)
+{
+	unsigned int end_segno = SM_I(sbi)->segment_count - 1;
+
+	/* check segment usage */
+	if (GET_SIT_VBLOCKS(raw_sit) > sbi->blocks_per_seg)
+		sbi->need_fsck = true;
+
+	/* check boundary of a given segment number */
+	if (segno > end_segno)
+		sbi->need_fsck = true;
+}
 #endif
 
 static inline pgoff_t current_sit_addr(struct f2fs_sb_info *sbi,
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
