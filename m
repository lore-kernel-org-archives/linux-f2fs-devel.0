From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: freeze filesystem when fail to update meta
 page due to IO error
Date: Wed, 29 Jul 2015 17:33:13 +0800
Message-ID: <011b01d0c9e1$b82b3b90$2881b2b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZKNkc-0000Tj-GH
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 29 Jul 2015 09:34:14 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZKNka-0001uc-JM
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 29 Jul 2015 09:34:14 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NS801J74T8MYXD0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 29 Jul 2015 18:34:03 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In get_meta_page, we guarantee no failure for the returned page,
but sometimes, IO error from device will incur returning an
non-updated page.

Then, we still use this page as updated one, exception could happen
when using this kind of page.

So in this condition, we'd better freeze fs by making fs readonly and
and stop doing checkpoint.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 84e0dfe..c311176 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -79,6 +79,14 @@ repeat:
 		f2fs_put_page(page, 1);
 		goto repeat;
 	}
+
+	/*
+	 * if there is any IO error when accessing device, make our filesystem
+	 * readonly and make sure do not write checkpoint with non-uptodate
+	 * meta page.
+	 */
+	if (unlikely(!PageUptodate(page)))
+		f2fs_stop_checkpoint(sbi);
 out:
 	return page;
 }
-- 
2.4.2



------------------------------------------------------------------------------
