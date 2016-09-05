From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix minor typo
Date: Mon, 5 Sep 2016 12:28:26 +0800
Message-ID: <20160905042827.114632-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bglWs-0004Xp-Dy
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Sep 2016 04:29:06 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bglWo-0003FX-Or
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Sep 2016 04:29:06 +0000
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Correct typo from 'destory' to 'destroy'.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 93c5e26..ff4b723 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2678,7 +2678,7 @@ int __init create_segment_manager_caches(void)
 	bio_entry_slab = f2fs_kmem_cache_create("bio_entry",
 			sizeof(struct bio_entry));
 	if (!bio_entry_slab)
-		goto destory_discard_entry;
+		goto destroy_discard_entry;
 
 	sit_entry_set_slab = f2fs_kmem_cache_create("sit_entry_set",
 			sizeof(struct sit_entry_set));
@@ -2695,7 +2695,7 @@ destroy_sit_entry_set:
 	kmem_cache_destroy(sit_entry_set_slab);
 destroy_bio_entry:
 	kmem_cache_destroy(bio_entry_slab);
-destory_discard_entry:
+destroy_discard_entry:
 	kmem_cache_destroy(discard_entry_slab);
 fail:
 	return -ENOMEM;
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
