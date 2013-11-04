From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: remove unnecessary TestClearPageError when
 wait pages writeback
Date: Mon, 04 Nov 2013 10:28:33 +0800
Message-ID: <000001ced905$c49eac00$4ddc0400$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Vd9vk-0003t0-M2
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Nov 2013 02:30:16 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vd9vi-0004I8-O3 for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Nov 2013 02:30:16 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MVP007X2W907WD0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Nov 2013 11:30:08 +0900 (KST)
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
To: 'Jaegeuk Kim' <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In wait_on_node_pages_writeback we will test and clear error flag for all pages in radix tree, but not necessary.
So we only do this for pages belong to the specified inode.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b527ed4..4ac4150 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1170,10 +1170,11 @@ int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
 			if (page->index > end)
 				continue;
 
-			if (ino && ino_of_node(page) == ino)
+			if (ino && ino_of_node(page) == ino) {
 				wait_on_page_writeback(page);
-			if (TestClearPageError(page))
-				ret = -EIO;
+				if (TestClearPageError(page))
+					ret = -EIO;
+			}
 		}
 		pagevec_release(&pvec);
 		cond_resched();
-- 
1.7.9.5


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
