From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix to release inode page in
	get_new_data_page
Date: Thu, 09 Jul 2015 18:20:08 +0800
Message-ID: <00f301d0ba30$ebe95b80$c3bc1280$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZD8wr-0008WC-Cf
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 09 Jul 2015 10:20:57 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZD8wp-0000Pg-8o
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 09 Jul 2015 10:20:57 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NR700KGRU2NUE80@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 09 Jul 2015 19:20:47 +0900 (KST)
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

get_new_data_page should release inode page when we encounter any
error in its procedure, but there is one error path didn't cover
this, fix it.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 08dfdc6..ea8898b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -397,8 +397,10 @@ struct page *get_new_data_page(struct inode *inode,
 	int err;
 repeat:
 	page = grab_cache_page(mapping, index);
-	if (!page)
+	if (!page) {
+		f2fs_put_page(ipage, 1);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	set_new_dnode(&dn, inode, ipage, NULL, 0);
 	err = f2fs_reserve_block(&dn, index);
-- 
2.4.2



------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
