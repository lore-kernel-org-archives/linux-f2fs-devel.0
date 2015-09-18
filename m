From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/3] f2fs: introduce __try_update_largest_extent
Date: Fri, 18 Sep 2015 16:53:07 +0800
Message-ID: <00cb01d0f1ef$8886fc90$9994f5b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZcrQb-0002o0-AV
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Sep 2015 08:53:57 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZcrQZ-0005Yk-Ro
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Sep 2015 08:53:57 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NUV01P857DKWQ70@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Sep 2015 17:53:48 +0900 (KST)
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
 fs/f2fs/extent_cache.c | 14 +++++---------
 fs/f2fs/f2fs.h         |  7 +++++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index c9d1cfd..31d5b48 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -351,8 +351,7 @@ static struct extent_node *__try_merge_extent_node(struct f2fs_sb_info *sbi,
 	}
 
 	if (en) {
-		if (en->ei.len > et->largest.len)
-			et->largest = en->ei;
+		__try_update_largest_extent(&et->largest, &en->ei);
 		et->cached_en = en;
 	}
 	return en;
@@ -389,8 +388,7 @@ do_insert:
 	if (!en)
 		return NULL;
 
-	if (en->ei.len > et->largest.len)
-		et->largest = en->ei;
+	__try_update_largest_extent(&et->largest, &en->ei);
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
+			__try_update_largest_extent(&et->largest, &en->ei);
+		else
 			__detach_extent_node(sbi, et, en);
-		}
 
 		/*
 		 * if original extent is split into zero or two parts, extent
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dbceb35..3342619 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -498,6 +498,13 @@ static inline bool __is_front_mergeable(struct extent_info *cur,
 	return __is_extent_mergeable(cur, front);
 }
 
+static inline void __try_update_largest_extent(struct extent_info *largest,
+						struct extent_info *cur)
+{
+	if (cur->len > largest->len)
+		*largest = *cur;
+}
+
 struct f2fs_nm_info {
 	block_t nat_blkaddr;		/* base disk address of NAT */
 	nid_t max_nid;			/* maximum possible node ids */
-- 
2.5.2



------------------------------------------------------------------------------
