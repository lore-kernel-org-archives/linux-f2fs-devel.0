From: Weichao Guo <guoweichao@huawei.com>
Subject: [PATCH] f2fs: fix BG_GC count stat & f2fs_gc return value
Date: Sat, 6 May 2017 02:07:28 +0800
Message-ID: <20170505180728.235186-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guoweichao@huawei.com>) id 1d6aBa-0006Jf-HK
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 05 May 2017 10:10:06 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d6aBV-0001t1-OH
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 05 May 2017 10:10:06 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Cc: huxinwei@huawei.com, Weichao Guo <guoweichao@huawei.com>

We should call stat_inc_bggc_count only after BG_GC has been performed
successfully. Otherwise, BG_GC count may be larger than total count when
f2fs_gc failed, e.g., no victim was selected.

By default, f2fs_gc returns EINVAL in some error cases, e.g., no victim was
selected. However, the default errno may be overwritten in the case of
BG_GC -> FG_GC.

Signed-off-by: Weichao Guo <guoweichao@huawei.com>
---
 fs/f2fs/gc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0265221..a42cafe 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -81,11 +81,11 @@ static int gc_thread_func(void *data)
 		else
 			increase_sleep_time(gc_th, &wait_ms);
 
-		stat_inc_bggc_count(sbi);
-
 		/* if return value is not zero, no victim was selected */
 		if (f2fs_gc(sbi, test_opt(sbi, FORCE_FG_GC), true, NULL_SEGNO))
 			wait_ms = gc_th->no_gc_sleep_time;
+		else
+			stat_inc_bggc_count(sbi);
 
 		trace_f2fs_background_gc(sbi->sb, wait_ms,
 				prefree_segments(sbi), free_segments(sbi));
@@ -987,6 +987,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 			gc_type = FG_GC;
 	}
 
+	ret = -EINVAL;
 	/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
 	if (gc_type == BG_GC && !background)
 		goto stop;
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
