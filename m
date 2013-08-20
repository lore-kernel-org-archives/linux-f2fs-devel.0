From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH] f2fs: fix memory leak when init f2fs
	filesystem fail
Date: Tue, 20 Aug 2013 19:03:39 +0900
Message-ID: <1376993019.2354.10.camel@kjgkr>
References: <52132DAF.5050507@huawei.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VBimw-0007Hu-N4
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Aug 2013 10:03:46 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VBimu-0004yq-Gz for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Aug 2013 10:03:46 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MRT00EALQM2HR90@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Aug 2013 19:03:38 +0900 (KST)
In-reply-to: <52132DAF.5050507@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Zhao Hongjiang <zhaohongjiang@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi,

I think you'd like to make a patch like below.
If no objection, I'll merge this.
Thank you,

Change log:
 o add return 0;
 o make a patch with the latest f2fs

>From 9890ff3f23ed78c63611f661006cd5ae38550f44 Mon Sep 17 00:00:00 2001
From: Zhao Hongjiang <zhaohongjiang@huawei.com>
Date: Tue, 20 Aug 2013 16:49:51 +0800
Subject: [PATCH] f2fs: fix memory leak when init f2fs filesystem fail
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
linux-f2fs-devel@lists.sourceforge.net

When any of the caches create fails in init_f2fs_fs(), the other caches
which are
create successful should be free.

Signed-off-by: Zhao Hongjiang <zhaohongjiang@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/super.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1d12e60..9e51e4f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1004,21 +1004,33 @@ static int __init init_f2fs_fs(void)
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
 	f2fs_kset = kset_create_and_add("f2fs", NULL, fs_kobj);
 	if (!f2fs_kset)
-		goto fail;
+		goto free_checkpoint_caches;
 	err = register_filesystem(&f2fs_fs_type);
 	if (err)
-		goto fail;
+		goto free_kset;
 	f2fs_create_root_stats();
 	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
+	return 0;
+
+free_kset:
+	kset_unregister(f2fs_kset);
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
1.8.3.1.437.g0dbd812


-- 
Jaegeuk Kim
Samsung


------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
