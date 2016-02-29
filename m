From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH] f2fs: modify the readahead method in
	ra_node_page()
Date: Mon, 29 Feb 2016 14:29:51 +0800
Message-ID: <001f01d172ba$b7dde070$2799a150$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1aaHM6-0001LQ-BM
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Feb 2016 06:30:54 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aaHM4-0004GK-FX
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Feb 2016 06:30:54 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O3A00JTXQ384T80@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Feb 2016 15:30:44 +0900 (KST)
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
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

ra_node_page() is used to read ahead one node page. Comparing to regular
read, it's faster because it doesn't wait for IO completion.
But if it is called twice for reading the same block, and the IO request
from the first call hasn't been completed before the second call, the second
call will have to wait until the read is over.

Here use the code in __do_page_cache_readahead() to solve this problem.
It does nothing when someone else already puts the page in mapping. The
status of page should be assured by whoever puts it there.
This implement also prevents alteration of page reference count.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/node.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 511c0e7..6d8f107 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1080,12 +1080,11 @@ void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
                return;
        f2fs_bug_on(sbi, check_nid_range(sbi, nid));

-       apage = find_get_page(NODE_MAPPING(sbi), nid);
-       if (apage && PageUptodate(apage)) {
-               f2fs_put_page(apage, 0);
+       rcu_read_lock();
+       apage = radix_tree_lookup(&NODE_MAPPING(sbi)->page_tree, nid);
+       rcu_read_unlock();
+       if (apage)
                return;
-       }
-       f2fs_put_page(apage, 0);

        apage = grab_cache_page(NODE_MAPPING(sbi), nid);
        if (!apage)
-- 
1.7.9.5


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
