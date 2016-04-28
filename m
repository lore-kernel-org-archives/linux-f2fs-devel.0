From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/4] f2fs: fix to clear private data in page
Date: Thu, 28 Apr 2016 23:13:48 +0800
Message-ID: <572228AC.30109@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1avndt-0006Ii-2d
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Apr 2016 15:14:13 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1avndl-00027X-NH
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Apr 2016 15:14:13 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Private data in page should be removed during ->releasepage or
->invalidatepage, otherwise garbage data would be remained in that page.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 38ce5d6..888f178 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1723,6 +1723,7 @@ void f2fs_invalidate_page(struct page *page, unsigned int
offset,
 	if (IS_ATOMIC_WRITTEN_PAGE(page))
 		return;

+	set_page_private(page, 0);
 	ClearPagePrivate(page);
 }

@@ -1736,6 +1737,7 @@ int f2fs_release_page(struct page *page, gfp_t wait)
 	if (IS_ATOMIC_WRITTEN_PAGE(page))
 		return 0;

+	set_page_private(page, 0);
 	ClearPagePrivate(page);
 	return 1;
 }
-- 
2.7.2


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
