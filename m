From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: avoid to calculate incorrect max orphan
	number
Date: Fri, 29 Nov 2013 16:37:00 +0800
Message-ID: <004701ceecde$49c7f8a0$dd57e9e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VmJaN-0008IL-BA
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 29 Nov 2013 08:38:03 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VmJaJ-0006wW-U6
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 29 Nov 2013 08:38:03 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MX000K1LNZ44Q40@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 29 Nov 2013 17:37:52 +0900 (KST)
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
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Because we will write node summaries when do_checkpoint with umount flag,
our number of max orphan blocks should minus NR_CURSEG_NODE_TYPE additional.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Shu Tan <shu.tan@samsung.com>
---
 fs/f2fs/checkpoint.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index b28e61b..32178f3 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -190,12 +190,13 @@ int acquire_orphan_inode(struct f2fs_sb_info *sbi)
 	int err = 0;
 
 	/*
-	 * considering 512 blocks in a segment 5 blocks are needed for cp
+	 * considering 512 blocks in a segment 8 blocks are needed for cp
 	 * and log segment summaries. Remaining blocks are used to keep
 	 * orphan entries with the limitation one reserved segment
-	 * for cp pack we can have max 1020*507 orphan entries
+	 * for cp pack we can have max 1020*504 orphan entries
 	 */
-	max_orphans = (sbi->blocks_per_seg - 5) * F2FS_ORPHANS_PER_BLOCK;
+	max_orphans = (sbi->blocks_per_seg - 2 - NR_CURSEG_TYPE)
+				* F2FS_ORPHANS_PER_BLOCK;
 	mutex_lock(&sbi->orphan_inode_mutex);
 	if (sbi->n_orphans >= max_orphans)
 		err = -ENOSPC;
-- 
1.7.9.5


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
