From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH] f2fs: fix to update cached_en of extent tree
 properly
Date: Tue, 18 Aug 2015 17:13:13 +0800
Message-ID: <005101d0d996$3ab708a0$b02519e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1ZRcyL-0005cP-Kx
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Aug 2015 09:14:21 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZRcyI-0000Va-BK
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Aug 2015 09:14:21 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NT902WY2TNF6G50@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Aug 2015 18:14:05 +0900 (KST)
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

In f2fs_lookup_extent_tree, et->cached_en was read and updated with only
read lock held, 
it could cause __lookup_extent_tree within return entirely wrong
extent_node, if other 
thread update et->cached_en just before __lookup_extent_tree return.

However, there are two things about this patch that need to be noticed:
1. It does no good to arrange the order of concurrent read/write, the result
would still 
be random in such case.
2. It's built on this assumption: the mix up of reads and writes on a single
pointer would 
not make the pointer partially wrong at any time. Please let me know if I'm
wrong, thx.


Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/extent_cache.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c index
32fae8a..cea5813 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -85,13 +85,13 @@ static struct extent_node *__lookup_extent_tree(struct
extent_tree *et,
 							unsigned int fofs)
 {
 	struct rb_node *node = et->root.rb_node;
-	struct extent_node *en;
+	struct extent_node *en = et->cached_en;
 
-	if (et->cached_en) {
-		struct extent_info *cei = &et->cached_en->ei;
+	if (en) {
+		struct extent_info *cei = &en->ei;
 
 		if (cei->fofs <= fofs && cei->fofs + cei->len > fofs)
-			return et->cached_en;
+			return en;
 	}
 
 	while (node) {
--
1.7.9.5


------------------------------------------------------------------------------
