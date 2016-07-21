From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: get victim segment again after new cp
Date: Thu, 21 Jul 2016 21:30:29 +0800
Message-ID: <1469107829-20459-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1bQDzd-0004H9-F4
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 Jul 2016 13:26:25 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bQDza-0000cl-S0
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 Jul 2016 13:26:25 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao@huawei.com

previous segment selected may become free after write_checkpoint,
so here, we select victim again.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index de6c41c..704e2e1 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -914,7 +914,7 @@ gc_more:
 			write_checkpoint(sbi, &cpc);
 	}
 
-	if (segno == NULL_SEGNO && !__get_victim(sbi, &segno, gc_type))
+	if (!__get_victim(sbi, &segno, gc_type) && segno == NULL_SEGNO)
 		goto stop;
 	ret = 0;
 
-- 
1.9.1


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
