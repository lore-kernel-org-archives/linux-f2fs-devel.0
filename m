From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH] f2fs: Change the timing of
 f2fs_wait_on_page_writeback
Date: Tue, 04 Aug 2015 13:27:51 +0800
Message-ID: <000901d0ce76$64916f60$2db44e20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1ZMUmD-0004fP-OL
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 04 Aug 2015 05:28:37 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZMUmB-0007LA-SL
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 04 Aug 2015 05:28:37 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NSJ00H2ELV9HQ80@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 04 Aug 2015 14:28:28 +0900 (KST)
Content-language: en-us
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

some backing devices need pages to be stable during writeback. It doesn't
matter if 
the page is completely overwritten or already uptodate, it needs to wait
before write.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/data.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c index 57042bd..364840f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1386,13 +1386,13 @@ put_next:
 	f2fs_put_dnode(&dn);
 	f2fs_unlock_op(sbi);
 
+	f2fs_wait_on_page_writeback(page, DATA);
+
 	if (len == PAGE_CACHE_SIZE)
 		goto out_update;
 	if (PageUptodate(page))
 		goto out_clear;
 
-	f2fs_wait_on_page_writeback(page, DATA);
-
 	if ((pos & PAGE_CACHE_MASK) >= i_size_read(inode)) {
 		unsigned start = pos & (PAGE_CACHE_SIZE - 1);
 		unsigned end = start + len;
--
1.7.9.5


------------------------------------------------------------------------------
