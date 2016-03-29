From: Shuoran Liu <liushuoran@huawei.com>
Subject: [PATCH] f2fs: retrieve IO write stat from the right place
Date: Tue, 29 Mar 2016 18:00:15 +0800
Message-ID: <1459245615-21023-1-git-send-email-liushuoran@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liushuoran@huawei.com>) id 1akqXC-0001tL-8t
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Mar 2016 10:06:02 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1akqX3-0005He-Fk
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Mar 2016 10:06:02 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao2.yu@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

In the following patch,

    f2fs: split journal cache from curseg cache

journal cache is split from curseg cache. So IO write statistics should be
retrived from journal cache but not curseg->sum_blk. Otherwise, it will
get 0, and the stat is lost.

Signed-off-by: Shuoran Liu <liushuoran@huawei.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 15bb81f..e2787c8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1442,7 +1442,7 @@ try_onemore:
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
 	if (__exist_node_summaries(sbi))
 		sbi->kbytes_written =
-			le64_to_cpu(seg_i->sum_blk->journal.info.kbytes_written);
+			le64_to_cpu(seg_i->journal->info.kbytes_written);
 
 	build_gc_manager(sbi);
 
-- 
1.9.1


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785471&iu=/4140
