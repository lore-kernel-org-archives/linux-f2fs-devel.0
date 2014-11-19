From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: write SSA pages under memory pressure
Date: Wed, 19 Nov 2014 14:35:10 -0800
Message-ID: <1416436510-6251-3-git-send-email-jaegeuk@kernel.org>
References: <1416436510-6251-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XrDqR-0005DS-T9
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Nov 2014 22:35:27 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XrDqR-0004SO-1u for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Nov 2014 22:35:27 +0000
In-Reply-To: <1416436510-6251-1-git-send-email-jaegeuk@kernel.org>
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

Under memory pressure, we don't need to skip SSA page writes.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 838e8ed..20a917b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -178,7 +178,7 @@ static int f2fs_write_meta_page(struct page *page,
 
 	if (unlikely(sbi->por_doing))
 		goto redirty_out;
-	if (wbc->for_reclaim)
+	if (wbc->for_reclaim && page->index < GET_SUM_BLOCK(sbi, 0))
 		goto redirty_out;
 	if (unlikely(f2fs_cp_error(sbi)))
 		goto redirty_out;
@@ -187,6 +187,9 @@ static int f2fs_write_meta_page(struct page *page,
 	write_meta_page(sbi, page);
 	dec_page_count(sbi, F2FS_DIRTY_META);
 	unlock_page(page);
+
+	if (wbc->for_reclaim)
+		f2fs_submit_merged_bio(sbi, META, WRITE);
 	return 0;
 
 redirty_out:
-- 
2.1.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
