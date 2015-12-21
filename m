From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] fsck.f2fs: fix losing journal entries
Date: Mon, 21 Dec 2015 09:44:52 -0800
Message-ID: <1450719892-10731-2-git-send-email-jaegeuk@kernel.org>
References: <1450719892-10731-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aB4WB-0007hy-GV
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Dec 2015 17:45:07 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aB4W6-0005oA-46 for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Dec 2015 17:45:07 +0000
In-Reply-To: <1450719892-10731-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

If fsck.f2fs reports a bug, move_curseg_info tries to change the current
segment info.
When it changes the new summary block, it overwrites the existing journal
entries.
This patch fixes it not to overwrite journal entry space.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index d2f1432..fe68f37 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1438,6 +1438,7 @@ void move_curseg_info(struct f2fs_sb_info *sbi, u64 from)
 	/* update summary blocks having nullified journal entries */
 	for (i = 0; i < NO_CHECK_TYPE; i++) {
 		struct curseg_info *curseg = CURSEG_I(sbi, i);
+		struct f2fs_summary_block buf;
 		u32 old_segno;
 		u64 ssa_blk, to;
 
@@ -1457,9 +1458,11 @@ void move_curseg_info(struct f2fs_sb_info *sbi, u64 from)
 
 		/* update new segno */
 		ssa_blk = GET_SUM_BLKADDR(sbi, curseg->segno);
-		ret = dev_read_block(curseg->sum_blk, ssa_blk);
+		ret = dev_read_block(&buf, ssa_blk);
 		ASSERT(ret >= 0);
 
+		memcpy(curseg->sum_blk, &buf, SUM_ENTRIES_SIZE);
+
 		/* update se->types */
 		reset_curseg(sbi, i);
 
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
