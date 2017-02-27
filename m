From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: remove redundant set_page_dirty()
Date: Mon, 27 Feb 2017 18:59:53 +0800
Message-ID: <20170227105953.799-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1ciIyS-00024s-8I
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 10:56:12 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ciIyQ-00060Q-Jo
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 10:56:12 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

This patch remove redundant set_page_dirty in truncate_blocks

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 36c1565..c6ca00c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -567,8 +567,7 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 	}
 
 	if (f2fs_has_inline_data(inode)) {
-		if (truncate_inline_inode(ipage, from))
-			set_page_dirty(ipage);
+		truncate_inline_inode(ipage, from);
 		if (from == 0)
 			clear_inode_flag(inode, FI_DATA_EXIST);
 		f2fs_put_page(ipage, 1);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
