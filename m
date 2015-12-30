From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: init variable total_zombie_tree
Date: Wed, 30 Dec 2015 15:28:08 +0800
Message-ID: <1451460488-16730-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1aEBA1-0006sw-1E
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 07:27:05 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aEB9v-0005y8-38
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 07:27:04 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, chao2.yu@samsung.com

This patch init total_zombie_tree in init_extent_cache_info.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/extent_cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 23e7c82..b37184f 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -737,6 +737,7 @@ void init_extent_cache_info(struct f2fs_sb_info *sbi)
 	INIT_LIST_HEAD(&sbi->extent_list);
 	spin_lock_init(&sbi->extent_lock);
 	atomic_set(&sbi->total_ext_tree, 0);
+	atomic_set(&sbi->total_zombie_tree, 0);
 	atomic_set(&sbi->total_ext_node, 0);
 }
 
-- 
1.9.1


------------------------------------------------------------------------------
