From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 3/7] f2fs: use __GFP_ZERO to avoid appending
	set-NULL
Date: Fri, 11 Apr 2014 17:49:50 +0800
Message-ID: <5347BABE.7060105@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1WYYF3-0003wB-Ar
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Apr 2014 09:59:25 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WYYEz-00049E-DH for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Apr 2014 09:59:25 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kim <jaegeuk.kim@samsung.com>
Cc: fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/segment.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8a6fe2a..ff8f987 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -243,9 +243,7 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 	if (!test_opt(sbi, FLUSH_MERGE))
 		return blkdev_issue_flush(sbi->sb->s_bdev, GFP_KERNEL, NULL);
 
-	cmd = f2fs_kmem_cache_alloc(flush_cmd_slab, GFP_ATOMIC);
-	cmd->next = NULL;
-	cmd->ret = 0;
+	cmd = f2fs_kmem_cache_alloc(flush_cmd_slab, GFP_ATOMIC | __GFP_ZERO);
 	init_completion(&cmd->wait);
 
 	spin_lock(&sm_i->issue_lock);
-- 
1.7.7


------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
