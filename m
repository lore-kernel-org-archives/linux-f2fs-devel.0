From: Alexander Gordeev <alex@gordick.net>
Subject: [PATCH] f2fs: fix build for v3.10
Date: Mon, 15 Aug 2016 15:57:54 +0300
Message-ID: <1471265874-6941-1-git-send-email-alex@gordick.net>
References: <281281471258049@web6h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alex@gordick.net>) id 1bZHiX-0002El-M9
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 Aug 2016 13:14:13 +0000
Received: from forward19p.cmail.yandex.net ([77.88.31.22])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bZHiW-0003If-NG
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 15 Aug 2016 13:14:13 +0000
Received: from smtp1h.mail.yandex.net (smtp1h.mail.yandex.net
	[IPv6:2a02:6b8:0:f05::115])
	by forward19p.cmail.yandex.net (Yandex) with ESMTP id 3EAEF212F2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 15 Aug 2016 15:58:12 +0300 (MSK)
In-Reply-To: <281281471258049@web6h.yandex.ru>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Alexander Gordeev <alex@gordick.net>

kvfree() first appears in v3.15. f2fs_kvfree() should be used in the backport.

Signed-off-by: Alexander Gordeev <alex@gordick.net>
---
 fs/f2fs/file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 100594e..74d0523 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1036,7 +1036,7 @@ static int __exchange_data_block(struct inode *src_inode,
 
 		do_replace = f2fs_kvzalloc(sizeof(int) * olen, GFP_KERNEL);
 		if (!do_replace) {
-			kvfree(src_blkaddr);
+			f2fs_kvfree(src_blkaddr);
 			return -ENOMEM;
 		}
 
@@ -1054,15 +1054,15 @@ static int __exchange_data_block(struct inode *src_inode,
 		dst += olen;
 		len -= olen;
 
-		kvfree(src_blkaddr);
-		kvfree(do_replace);
+		f2fs_kvfree(src_blkaddr);
+		f2fs_kvfree(do_replace);
 	}
 	return 0;
 
 roll_back:
 	__roll_back_blkaddrs(src_inode, src_blkaddr, do_replace, src, len);
-	kvfree(src_blkaddr);
-	kvfree(do_replace);
+	f2fs_kvfree(src_blkaddr);
+	f2fs_kvfree(do_replace);
 	return ret;
 }
 
-- 
2.5.0


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. http://sdm.link/zohodev2dev
