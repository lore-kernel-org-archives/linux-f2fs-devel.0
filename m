From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2 1/3] f2fs: introduce
	__try_update_largest_extent
Date: Tue, 22 Sep 2015 21:07:47 +0800
Message-ID: <00d501d0f537$c4e17260$4ea45720$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZeNJq-0001d9-AE
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Sep 2015 13:09:14 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZeNJn-00063Y-HB
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Sep 2015 13:09:14 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NV202PH1XTYTR40@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Sep 2015 22:08:26 +0900 (KST)
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

This patch adds a new helper __try_update_largest_extent for cleanup.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
v2
 o cleanup parameter passed.
 fs/f2fs/extent_cache.c | 14 +++++---------
 fs/f2fs/f2fs.h         |  7 +++++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index c9d1cfd..a38ee9b 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -351,8 +351,7 @@ static struct extent_node *__try_merge_extent_node(struct f2fs_sb_info *sbi,
 	}
 
 	if (en) {
-		if (en->ei.len > et->largest.len)
-			et->largest = en->ei;
+		__try_update_largest_extent(et, en);
 		et->cached_en = en;
 	}
 	return en;
@@ -389,8 +388,7 @@ do_insert:
 	if (!en)
 		return NULL;
 
-	if (en->ei.len > et->largest.len)
-		et->largest = en->ei;
+	__try_update_largest_extent(et, en);
 	et->cached_en = en;
 	return en;
 }
@@ -476,12 +474,10 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 				: NULL;
 		}
 
-		if (parts) {
-			if (en->ei.len > et->largest.len)
-				et->largest = en->ei;
-		} else {
+		if (parts)
+			__try_update_largest_extent(et, en);
+		else
 			__detach_extent_node(sbi, et, en);
-		}
 
 		/*
 		 * if original extent is split into zero or two parts, extent
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 79c38ad..8d6681a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -492,6 +492,13 @@ static inline bool __is_front_mergeable(struct extent_info *cur,
 	return __is_extent_mergeable(cur, front);
 }
 
+static inline void __try_update_largest_extent(struct extent_tree *et,
+						struct extent_node *en)
+{
+	if (en->ei.len > et->largest.len)
+		et->largest = en->ei;
+}
+
 struct f2fs_nm_info {
 	block_t nat_blkaddr;		/* base disk address of NAT */
 	nid_t max_nid;			/* maximum possible node ids */
-- 
2.5.2



------------------------------------------------------------------------------
