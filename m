From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/5] f2fs: fix wrong max cost initialization
Date: Sat, 25 Mar 2017 00:59:33 -0700
Message-ID: <20170325075933.21072-5-jaegeuk@kernel.org>
References: <20170325075933.21072-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1crgc5-0007eH-Ek
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Mar 2017 07:59:53 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1crgc4-0001LJ-I8
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Mar 2017 07:59:53 +0000
In-Reply-To: <20170325075933.21072-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, "# v4 . 10+" <stable@vger.kernel.org>

This patch fixes missing increased max cost caused by a patch that we increased
cose of data segments in greedy algorithm.

Cc: <stable@vger.kernel.org> # v4.10+
Fixes: b9cd20619 "f2fs: node segment is prior to data segment selected victim"
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 9d4158d55dbb..c52656ccbde5 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -186,7 +186,7 @@ static unsigned int get_max_cost(struct f2fs_sb_info *sbi,
 	if (p->alloc_mode == SSR)
 		return sbi->blocks_per_seg;
 	if (p->gc_mode == GC_GREEDY)
-		return sbi->blocks_per_seg * p->ofs_unit;
+		return 2 * sbi->blocks_per_seg * p->ofs_unit;
 	else if (p->gc_mode == GC_CB)
 		return UINT_MAX;
 	else /* No other gc_mode */
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
