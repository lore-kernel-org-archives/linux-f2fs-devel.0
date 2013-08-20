From: Zhao Hongjiang <zhaohongjiang@huawei.com>
Subject: [PATCH] f2fs: fix memory leak when init f2fs filesystem
	fail
Date: Tue, 20 Aug 2013 16:49:51 +0800
Message-ID: <52132DAF.5050507@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhaohongjiang@huawei.com>) id 1VBhdm-0008Dl-LC
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Aug 2013 08:50:14 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps
	(TLSv1:DES-CBC3-SHA:168) (Exim 4.76) id 1VBhdj-0001F0-Hw
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Aug 2013 08:50:14 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

When any of the caches create fails in init_f2fs_fs(), the other caches which are
create successful should be free.

Signed-off-by: Zhao Hongjiang <zhaohongjiang@huawei.com>
---
 fs/f2fs/super.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 75c7dc3..d9ad1ba 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -841,17 +841,26 @@ static int __init init_f2fs_fs(void)
 		goto fail;
 	err = create_node_manager_caches();
 	if (err)
-		goto fail;
+		goto free_inodecache;
 	err = create_gc_caches();
 	if (err)
-		goto fail;
+		goto free_node_manager_caches;
 	err = create_checkpoint_caches();
 	if (err)
-		goto fail;
+		goto free_gc_caches;
 	err = register_filesystem(&f2fs_fs_type);
 	if (err)
-		goto fail;
+		goto free_checkpoint_caches;
 	f2fs_create_root_stats();
+
+free_checkpoint_caches:
+	destroy_checkpoint_caches();
+free_gc_caches:
+	destroy_gc_caches();
+free_node_manager_caches:
+	destroy_node_manager_caches();
+free_inodecache:
+	destroy_inodecache();
 fail:
 	return err;
 }
-- 
1.8.2.2


------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
