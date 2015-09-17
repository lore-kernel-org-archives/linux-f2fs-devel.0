From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH 1/2] f2fs: drop largest extent by range
Date: Thu, 17 Sep 2015 18:24:17 +0800
Message-ID: <002d01d0f133$17ef76e0$47ce64a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1ZcWND-00074H-Hq
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Sep 2015 10:25:03 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZcWNB-00080I-Hz
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Sep 2015 10:25:03 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NUT01AH5GXIA800@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Sep 2015 19:24:54 +0900 (KST)
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

now we update extent by range, fofs may not be on the largest
extent if the new extent overlaps with it. so add a new function
to drop largest extent properly.


Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/extent_cache.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 63068b7..2f013e2 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -155,11 +155,12 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 	return count - et->count;
 }

-static void __drop_largest_extent(struct inode *inode, pgoff_t fofs)
+static void __drop_largest_extent(struct inode *inode,
+					pgoff_t fofs, unsigned int len)
 {
 	struct extent_info *largest = &F2FS_I(inode)->extent_tree->largest;

-	if (largest->fofs <= fofs && largest->fofs + largest->len > fofs)
+	if (fofs < largest->fofs + largest->len && fofs + len > largest->fofs)
 		largest->len = 0;
 }

@@ -168,7 +169,7 @@ void f2fs_drop_largest_extent(struct inode *inode, pgoff_t fofs)
 	if (!f2fs_may_extent_tree(inode))
 		return;

-	__drop_largest_extent(inode, fofs);
+	__drop_largest_extent(inode, fofs, 1);
 }

 void f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
@@ -422,7 +423,7 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 	dei.len = 0;

 	/* we do not guarantee that the largest extent is cached all the time */
-	__drop_largest_extent(inode, fofs);
+	__drop_largest_extent(inode, fofs, len);

 	/* 1. lookup first extent node in range [fofs, fofs + len - 1] */
 	en = __lookup_extent_tree_ret(et, fofs, &prev_en, &next_en,
--
1.7.9.5


------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
