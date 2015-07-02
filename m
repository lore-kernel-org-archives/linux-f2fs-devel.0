From: Chao Yu <yuchaochina@hotmail.com>
Subject: [PATCH] f2fs: reduce lock overhead of extent node
	releasing
Date: Thu, 2 Jul 2015 20:40:12 +0800
Message-ID: <COL402-EAS176E0D9A5A44C7C97F55904AB970@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchaochina@hotmail.com>) id 1ZAdmw-0000Fb-QZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Jul 2015 12:40:22 +0000
Received: from col004-omc1s17.hotmail.com ([65.55.34.27])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZAdmw-0006kn-0t
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Jul 2015 12:40:22 +0000
Content-Language: zh-cn
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

>From e5c6600d01c4462c4e1ee0c70ec1d9319862077d Mon Sep 17 00:00:00 2001
From: Chao Yu <chao2.yu@samsung.com>
Date: Thu, 2 Jul 2015 18:52:46 +0800
Subject: [PATCH] f2fs: reduce lock overhead of extent node releasing

Open and close critical section for each extent node when traversing rb-tree
results in high overhead of cpu, slows thing down.

This patch alternates to batch mode for removing extent nodes under spin lock.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6a706dd..7fb56a0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -441,19 +441,31 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 	struct extent_node *en;
 	unsigned int count = et->count;
 
-	node = rb_first(&et->root);
-	while (node) {
-		next = rb_next(node);
-		en = rb_entry(node, struct extent_node, rb_node);
+	if (!et->count)
+		return 0;
+
+	/* 1. remove all extent nodes in global lru list */
+	if (free_all) {
+		spin_lock(&sbi->extent_lock);
+		node = rb_first(&et->root);
+		while (node) {
+			next = rb_next(node);
+			en = rb_entry(node, struct extent_node, rb_node);
 
-		if (free_all) {
-			spin_lock(&sbi->extent_lock);
 			if (!list_empty(&en->list))
 				list_del_init(&en->list);
-			spin_unlock(&sbi->extent_lock);
+			node = next;
 		}
+		spin_unlock(&sbi->extent_lock);
+	}
+
+	/* 2. release all extent nodes which are not in global lru list */
+	node = rb_first(&et->root);
+	while (node) {
+		next = rb_next(node);
+		en = rb_entry(node, struct extent_node, rb_node);
 
-		if (free_all || list_empty(&en->list)) {
+		if (list_empty(&en->list)) {
 			__detach_extent_node(sbi, et, en);
 			kmem_cache_free(extent_node_slab, en);
 		}
-- 
2.4.2


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
