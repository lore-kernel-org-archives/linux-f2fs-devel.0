From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/5] f2fs: show more info about superblock
	recovery
Date: Mon, 22 Feb 2016 18:33:20 +0800
Message-ID: <004801d16d5c$8adf16b0$a09d4410$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aXnof-0004ot-Np
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Feb 2016 10:34:09 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aXnoe-0001js-1W
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Feb 2016 10:34:09 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O2Y02F5W2O08M80@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Feb 2016 19:34:00 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch changes to show more info in message log about the recovery
of the corrupted superblock during ->mount, e.g. the index of corrupted
superblock and the result of recovery.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e1e69b9..46be3b4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1531,8 +1531,10 @@ try_onemore:
 
 	/* recover broken superblock */
 	if (recovery && !f2fs_readonly(sb) && !bdev_read_only(sb->s_bdev)) {
-		f2fs_msg(sb, KERN_INFO, "Recover invalid superblock");
-		f2fs_commit_super(sbi, true);
+		err = f2fs_commit_super(sbi, true);
+		f2fs_msg(sb, KERN_INFO,
+			"Try to recover %dth superblock, ret: %ld",
+			sbi->valid_super_block ? 1 : 2, err);
 	}
 
 	f2fs_update_time(sbi, CP_TIME);
-- 
2.7.0



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
