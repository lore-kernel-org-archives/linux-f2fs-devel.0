From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: delete unnecessary wait for page writeback
Date: Tue, 2 Feb 2016 21:05:27 +0800
Message-ID: <1454418327-3537-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1aQacT-0001C8-8E
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 02 Feb 2016 13:03:45 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aQacP-0000Hg-5x
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 02 Feb 2016 13:03:45 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: chao2.yu@samsung.com, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

no need to wait inline file page writeback for no one
use it, so this patch delete unnecessary wait.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/inline.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index fc4d298..ec44640 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -124,8 +124,6 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 	if (err)
 		return err;
 
-	f2fs_wait_on_page_writeback(page, DATA, true);
-
 	if (PageUptodate(page))
 		goto no_update;
 
-- 
1.9.1


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
