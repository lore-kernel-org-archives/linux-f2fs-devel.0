From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid a build warning
Date: Tue, 11 Aug 2015 16:45:41 -0700
Message-ID: <1439336741-21179-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZPJHV-0003o0-Dd
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Aug 2015 23:48:33 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZPJHU-00075R-Eh for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Aug 2015 23:48:33 +0000
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

If F2FS_CHECK_FS is turned off, we can get a build warning for unused variable.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index d0bd952..b6e4ed1 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -581,15 +581,11 @@ static inline void verify_block_addr(struct f2fs_sb_info *sbi, block_t blk_addr)
 static inline void check_block_count(struct f2fs_sb_info *sbi,
 		int segno, struct f2fs_sit_entry *raw_sit)
 {
+#ifdef CONFIG_F2FS_CHECK_FS
 	bool is_valid  = test_bit_le(0, raw_sit->valid_map) ? true : false;
 	int valid_blocks = 0;
 	int cur_pos = 0, next_pos;
 
-	/* check segment usage, and check boundary of a given segment number */
-	f2fs_bug_on(sbi, GET_SIT_VBLOCKS(raw_sit) > sbi->blocks_per_seg
-					|| segno > TOTAL_SEGS(sbi) - 1);
-
-#ifdef CONFIG_F2FS_CHECK_FS
 	/* check bitmap with valid block count */
 	do {
 		if (is_valid) {
@@ -606,6 +602,9 @@ static inline void check_block_count(struct f2fs_sb_info *sbi,
 	} while (cur_pos < sbi->blocks_per_seg);
 	BUG_ON(GET_SIT_VBLOCKS(raw_sit) != valid_blocks);
 #endif
+	/* check segment usage, and check boundary of a given segment number */
+	f2fs_bug_on(sbi, GET_SIT_VBLOCKS(raw_sit) > sbi->blocks_per_seg
+					|| segno > TOTAL_SEGS(sbi) - 1);
 }
 
 static inline pgoff_t current_sit_addr(struct f2fs_sb_info *sbi,
-- 
2.1.1


------------------------------------------------------------------------------
