From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/6] f2fs: convert inline_data for punch_hole
Date: Fri, 27 Dec 2013 13:00:16 +0900
Message-ID: <1388116820-15038-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1388116820-15038-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VwOcU-0008Uy-5t
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 04:01:54 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VwOcT-0004oc-4o
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 04:01:54 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MYG00FDY5UL0F90@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 13:01:33 +0900 (KST)
In-reply-to: <1388116820-15038-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In the punch_hole(), let's convert inline_data all the time for simplicity and
to avoid potential deadlock conditions.
It is pretty much not a big deal to do this.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/file.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7ef2d6a..f64a1c8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -462,25 +462,9 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	loff_t off_start, off_end;
 	int ret = 0;
 
-	if (f2fs_has_inline_data(inode)) {
-		struct page *page;
-		unsigned flags = AOP_FLAG_NOFS;
-		page = grab_cache_page_write_begin(inode->i_mapping, 0, flags);
-		if (IS_ERR(page))
-			return PTR_ERR(page);
-		if (offset + len > MAX_INLINE_DATA) {
-			ret = f2fs_convert_inline_data(inode, page, flags);
-			f2fs_put_page(page, 1);
-			if (ret)
-				return ret;
-		} else {
-			zero_user_segment(page, offset, offset + len);
-			SetPageUptodate(page);
-			set_page_dirty(page);
-			f2fs_put_page(page, 1);
-			return ret;
-		}
-	}
+	ret = f2fs_convert_inline_data(inode, NULL, AOP_FLAG_NOFS);
+	if (ret)
+		return ret;
 
 	pg_start = ((unsigned long long) offset) >> PAGE_CACHE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_CACHE_SHIFT;
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
