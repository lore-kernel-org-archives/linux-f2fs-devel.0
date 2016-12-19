From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: fix a problem of using memory after free
Date: Mon, 19 Dec 2016 19:34:30 +0800
Message-ID: <20161219113430.15201-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cIw9n-0002Fy-09
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Dec 2016 11:31:03 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cIw9j-0007J3-CM
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Dec 2016 11:31:02 +0000
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
Cc: le@vger.kernel.org, heyunlei@huwei.com

This patch fix a problem of using memory after free
in the function __try_merge_extent_node.

Fixes: a03f01f2673 ("f2fs: reconstruct the code to free an extent_node")
Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/extent_cache.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 4db44da..e02c3d8 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -352,11 +352,12 @@ static struct extent_node *__try_merge_extent_node(struct inode *inode,
 	}
 
 	if (next_ex && __is_front_mergeable(ei, &next_ex->ei)) {
-		if (en)
-			__release_extent_node(sbi, et, prev_ex);
 		next_ex->ei.fofs = ei->fofs;
 		next_ex->ei.blk = ei->blk;
 		next_ex->ei.len += ei->len;
+		if (en)
+			__release_extent_node(sbi, et, prev_ex);
+
 		en = next_ex;
 	}
 
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
