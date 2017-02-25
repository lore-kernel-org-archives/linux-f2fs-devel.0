From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 1/2] remove stale comment info about cp before
	fggc
Date: Sat, 25 Feb 2017 03:57:38 +0000
Message-ID: <20170225035739.149680-1-houpengyang@huawei.com>
References: <20170225020733.GB50867@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1chTUi-0005EK-CS
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 03:58:04 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1chTUe-0003H3-Qq
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 03:58:04 +0000
In-Reply-To: <20170225020733.GB50867@jaegeuk.local>
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

In commit c026d3677 (f2fs: remove unnecessary condition check for write_checkpoint in f2fs_gc)
we have removed all the prefree segments/dirty segments checking before cp, remove related comment.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/gc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6c996e3..ffff67ac 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -953,11 +953,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
 
 	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, sec_freed, 0)) {
 		gc_type = FG_GC;
-		/*
-		 * If there is no victim and no prefree segment but still not
-		 * enough free sections, we should flush dent/node blocks and do
-		 * garbage collections.
-		 */
+
 		ret = write_checkpoint(sbi, &cpc);
 		if (ret)
 			goto stop;
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
