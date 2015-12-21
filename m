From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] defrag.f2fs: fix missing SSA updates
Date: Mon, 21 Dec 2015 09:44:51 -0800
Message-ID: <1450719892-10731-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aB4W6-00048X-1c
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Dec 2015 17:45:02 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aB4W5-0004Rd-0B for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Dec 2015 17:45:02 +0000
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

Previously SSA is updated if it is not included in current segment info.
But, defrag.f2fs doesn't handle current segment info during the process, and
instead lastly update the whole current segment info at a time.
So, we need to update summary entries all the time.
Otherwise, we can lose the SSA entry.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 79611e5..d2f1432 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -761,13 +761,16 @@ void update_sum_entry(struct f2fs_sb_info *sbi, block_t blk_addr,
 	sum_blk->footer.entry_type = IS_NODESEG(se->type) ? SUM_TYPE_NODE :
 							SUM_TYPE_DATA;
 
-	if (type == SEG_TYPE_NODE || type == SEG_TYPE_DATA ||
-					type == SEG_TYPE_MAX) {
+	/* write SSA all the time */
+	if (type < SEG_TYPE_MAX) {
 		u64 ssa_blk = GET_SUM_BLKADDR(sbi, segno);
 		ret = dev_write_block(sum_blk, ssa_blk);
 		ASSERT(ret >= 0);
-		free(sum_blk);
 	}
+
+	if (type == SEG_TYPE_NODE || type == SEG_TYPE_DATA ||
+					type == SEG_TYPE_MAX)
+		free(sum_blk);
 }
 
 static void restore_curseg_summaries(struct f2fs_sb_info *sbi)
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
