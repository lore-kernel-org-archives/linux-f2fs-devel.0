From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH] f2fs: avoid unnecessary fg_gc
Date: Fri, 24 Feb 2017 10:01:35 +0000
Message-ID: <20170224100135.70000-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1chChS-0007Ha-1U
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Feb 2017 10:02:06 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1chChO-0007yz-OE
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Feb 2017 10:02:06 +0000
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

Under scenerio with large number of dirty nodes, and these nodes are flushed
in SSR mode during cp. enough free segemts now, no need to do fggc.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6c996e3..41bdfb7 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -959,7 +959,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
 		 * garbage collections.
 		 */
 		ret = write_checkpoint(sbi, &cpc);
-		if (ret)
+		if (ret || !has_not_enough_free_secs(sbi, sec_freed, 0))
 			goto stop;
 	} else if (gc_type == BG_GC && !background) {
 		/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
