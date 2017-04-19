From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: assign allocation hint for warm/cold
	data
Date: Tue, 18 Apr 2017 18:45:20 -0700
Message-ID: <20170419014520.12536-3-jaegeuk@kernel.org>
References: <20170419014520.12536-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1d0egY-0000FF-Fi
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Apr 2017 01:45:34 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d0egW-0001OA-FU
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Apr 2017 01:45:34 +0000
In-Reply-To: <20170419014520.12536-1-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch gives slower device region to warm/cold data area more eagerly.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d988c1aaf132..eb1846a80da3 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1028,4 +1028,9 @@ void build_gc_manager(struct f2fs_sb_info *sbi)
 
 	sbi->fggc_threshold = div64_u64((main_count - ovp_count) *
 				BLKS_PER_SEC(sbi), (main_count - resv_count));
+
+	/* give warm/cold data area from slower device */
+	if (sbi->s_ndevs)
+		sbi->last_victim[ALLOC_NEXT] =
+				GET_SEGNO(sbi, FDEV(0).end_blk) + 1;
 }
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
