From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: avoid to left uninitialized data in page
 when read inline data
Date: Sat, 28 Dec 2013 20:55:39 +0800
Message-ID: <000201cf03cc$30b2ce30$92186a90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VwtRI-0002IF-3C
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Dec 2013 12:56:24 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VwtRF-0003uu-Vl
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Dec 2013 12:56:24 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MYI00LH5P9QP590@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 28 Dec 2013 21:56:14 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We left uninitialized data in the tail of page when we read an inline data
page. So let's initialize left part of the page excluding inline data region.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/inline.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 0e940ce..eebda9b 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -48,8 +48,7 @@ int f2fs_read_inline_data(struct inode *inode, struct page *page)
 	if (IS_ERR(ipage))
 		return PTR_ERR(ipage);
 
-	zero_user_segment(page, INLINE_DATA_OFFSET,
-				INLINE_DATA_OFFSET + MAX_INLINE_DATA);
+ 	zero_user_segment(page, MAX_INLINE_DATA, PAGE_CACHE_SIZE);
 
 	/* Copy the whole inline data block */
 	src_addr = inline_data_addr(ipage);
-- 
1.7.9.5


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
