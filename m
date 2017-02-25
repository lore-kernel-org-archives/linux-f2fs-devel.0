From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: avoid unnecessary fg_gc
Date: Sat, 25 Feb 2017 11:39:59 -0800
Message-ID: <20170225193959.GE51627@jaegeuk.local>
References: <20170224100135.70000-1-houpengyang@huawei.com>
	<0486c0d4-541c-ee21-c598-6656a291a274@huawei.com>
	<58B0E17C.1030306@huawei.com>
	<20170225020733.GB50867@jaegeuk.local>
	<ce5a4256-9275-eb89-e188-f5f200b8f77c@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1chiCQ-0004HJ-3G
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 19:40:10 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1chiCP-0002aN-3R
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 19:40:10 +0000
Content-Disposition: inline
In-Reply-To: <ce5a4256-9275-eb89-e188-f5f200b8f77c@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: heyunlei <heyunlei@huawei.com>
Cc: guoweichao@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 02/25, heyunlei wrote:
> Hi all,
> 
> I am really confused by the condition below use sec_freed, is it always equal to zero?

Seems it is always zero. Let's fix it together.

Pengyang,

I merged your patches and finally got this.
How do you think?

>From d1c2206e4f245a8fedec3a8f21ad522b3b1b2d0c Mon Sep 17 00:00:00 2001
From: Hou Pengyang <houpengyang@huawei.com>
Date: Sat, 25 Feb 2017 03:57:38 +0000
Subject: [PATCH] f2fs: avoid bggc->fggc when enough free segments are
 avaliable after cp

We use has_not_enough_free_secs to check if there are enough free segments,

    	(free_sections(sbi) + freed) <=
	        (node_secs + 2 * dent_secs + imeta_secs +
			         reserved_sections(sbi) + needed);

Under scenario with large number of dirty nodes, these nodes would be flushed
during cp, as a result, right side of the inequality would be decreased, while
left side stays unchanged if these nodes are flushed in SSR way, which means
there are enough free segments after this cp.

For this case, we just do a bggc instead of fggc.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 1af17c5af603..471ed899f639 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -954,21 +954,22 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
 		goto stop;
 	}
 
-	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, sec_freed, 0)) {
-		gc_type = FG_GC;
+	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) {
 		/*
-		 * If there is no victim and no prefree segment but still not
-		 * enough free sections, we should flush dent/node blocks and do
-		 * garbage collections.
+		 * For example, if there are many prefree_segments below given
+		 * threshold, we can make them free by checkpoint. Then, we
+		 * secure free segments which doesn't need fggc any more.
 		 */
 		ret = write_checkpoint(sbi, &cpc);
 		if (ret)
 			goto stop;
-	} else if (gc_type == BG_GC && !background) {
-		/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
-		goto stop;
+		if (has_not_enough_free_secs(sbi, 0, 0))
+			gc_type = FG_GC;
 	}
 
+	/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
+	if (gc_type == BG_GC && !background)
+		goto stop;
 	if (!__get_victim(sbi, &segno, gc_type))
 		goto stop;
 	ret = 0;
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
