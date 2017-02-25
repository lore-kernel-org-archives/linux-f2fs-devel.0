From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 2/2] f2fs: avoid bggc->fggc when enough free
	segments are avaliable after cp
Date: Sat, 25 Feb 2017 03:57:39 +0000
Message-ID: <20170225035739.149680-2-houpengyang@huawei.com>
References: <20170225020733.GB50867@jaegeuk.local>
	<20170225035739.149680-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1chTUi-00023C-Ch
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 03:58:04 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1chTUe-0004Cd-5b
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 03:58:04 +0000
In-Reply-To: <20170225035739.149680-1-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: guoweichao@huawei.com, linux-f2fs-devel@lists.sourceforge.net

We use has_not_enough_free_secs to check if there are enough free segments,

    	(free_sections(sbi) + freed) <=
	        (node_secs + 2 * dent_secs + imeta_secs +
			         reserved_sections(sbi) + needed);

Under scenario with large number of dirty nodes, these nodes would be flushed during cp,
as a result, right side of the inequality would be decreased, while left side stays unchanged
if these nodes are flushed in SSR way, which means there are enough free segments after
this cp.

For this case, we just do a bggc instead of fggc.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/gc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ffff67ac..8cf751f 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -952,11 +952,16 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
 	}
 
 	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, sec_freed, 0)) {
-		gc_type = FG_GC;
 
+		/*
+		 * After cp, there may be enough free segments avaliable, In this case,
+		 * We just do a bggc instead of fggc.
+		 */
 		ret = write_checkpoint(sbi, &cpc);
 		if (ret)
 			goto stop;
+		if (has_not_enough_free_secs(sbi, sec_freed, 0))
+			gc_type = FG_GC;
 	} else if (gc_type == BG_GC && !background) {
 		/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
 		goto stop;
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
