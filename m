From: Zhang Zhen <zhenzhang.zhang@huawei.com>
Subject: [PATCH] fs/f2fs: replace open coded nofail allocation in
	__add_ino_entry
Date: Mon, 24 Aug 2015 11:39:55 +0800
Message-ID: <55DA920B.9040706@huawei.com>
References: <1440386638-40325-1-git-send-email-zhenzhang.zhang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhenzhang.zhang@huawei.com>) id 1ZTicY-000868-OB
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Aug 2015 03:40:30 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZTicR-0003ZC-PM
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Aug 2015 03:40:30 +0000
In-Reply-To: <1440386638-40325-1-git-send-email-zhenzhang.zhang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, cm224.lee@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

__add_ino_entry is looping around the allocation request and minics
__GFP_NOFAIL behavior without any allocation fallback strategy.
Here remove the open coded loop and replace it with __GFP_NOFAIL.

Signed-off-by: Zhang Zhen <zhenzhang.zhang@huawei.com>
---
 fs/f2fs/checkpoint.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index b70bbe1..d62363b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -337,12 +337,7 @@ retry:

 	e = radix_tree_lookup(&im->ino_root, ino);
 	if (!e) {
-		e = kmem_cache_alloc(ino_entry_slab, GFP_ATOMIC);
-		if (!e) {
-			spin_unlock(&im->ino_lock);
-			radix_tree_preload_end();
-			goto retry;
-		}
+		e = kmem_cache_alloc(ino_entry_slab, GFP_ATOMIC|__GFP_NOFAIL);
 		if (radix_tree_insert(&im->ino_root, ino, e)) {
 			spin_unlock(&im->ino_lock);
 			kmem_cache_free(ino_entry_slab, e);
-- 
1.9.1


.





------------------------------------------------------------------------------
