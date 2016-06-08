From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/7] f2fs: skip clean segment for gc
Date: Wed,  8 Jun 2016 10:24:41 -0700
Message-ID: <20160608172444.60371-4-jaegeuk@kernel.org>
References: <20160608172444.60371-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bAhDu-0006dg-Aq
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jun 2016 17:24:58 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bAhDt-0001Wa-KA
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jun 2016 17:24:58 +0000
In-Reply-To: <20160608172444.60371-1-jaegeuk@kernel.org>
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

If a segment in a section is clean or prefreed, we don't need to get its summary
and do gc.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 67fd285..e1d274c 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -795,6 +795,10 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	}
 
 	for (segno = start_segno; segno < end_segno; segno++) {
+
+		if (get_valid_blocks(sbi, segno, 1) == 0)
+			continue;
+
 		/* find segment summary of victim */
 		sum_page = find_get_page(META_MAPPING(sbi),
 					GET_SUM_BLOCK(sbi, segno));
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
