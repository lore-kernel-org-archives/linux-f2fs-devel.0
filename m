From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] fsck.f2fs: assign checkpoint pointer
	correctly
Date: Fri, 15 Jan 2016 10:33:40 -0800
Message-ID: <1452882821-61713-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aK9C3-0007ZO-An
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Jan 2016 18:33:51 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aK9C2-00077I-Bu for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Jan 2016 18:33:51 +0000
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

This patch fixes a bug that cp pointer is not assigned correctly.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 002a7cb..c4dfb0a 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1725,6 +1725,7 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 		ERR_MSG("Checkpoint is polluted\n");
 		return -1;
 	}
+	cp = F2FS_CKPT(sbi);
 
 	print_ckpt_info(sbi);
 
@@ -1739,7 +1740,6 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 
 	config.bug_on = 0;
 
-	cp = F2FS_CKPT(sbi);
 	sbi->total_valid_node_count = get_cp(valid_node_count);
 	sbi->total_valid_inode_count = get_cp(valid_inode_count);
 	sbi->user_block_count = get_cp(user_block_count);
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
