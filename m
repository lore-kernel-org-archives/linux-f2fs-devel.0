From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: No need to wait for data page writeback by
	force
Date: Wed, 21 Sep 2016 18:41:02 +0800
Message-ID: <1474454462-30527-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1bmesv-0000M0-EV
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 21 Sep 2016 10:36:13 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bmesq-0003Jy-0I
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 21 Sep 2016 10:36:13 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huwei.com

No need to wait for data page writeback, wait or not
can be decided by device.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e78501c..71e4a0f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1658,7 +1658,7 @@ void f2fs_wait_on_encrypted_page_writeback(struct f2fs_sb_info *sbi,
 
 	cpage = find_lock_page(META_MAPPING(sbi), blkaddr);
 	if (cpage) {
-		f2fs_wait_on_page_writeback(cpage, DATA, true);
+		f2fs_wait_on_page_writeback(cpage, DATA, false);
 		f2fs_put_page(cpage, 1);
 	}
 }
-- 
1.9.1


------------------------------------------------------------------------------
