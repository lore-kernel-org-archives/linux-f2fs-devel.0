From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: try grabbing node page lock aggressively
 in sync scenario
Date: Wed, 4 Jul 2018 18:04:10 +0800
Message-ID: <20180704100410.20777-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1faef5-0008O7-2I
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Jul 2018 10:05:23 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1faef3-00Cj1y-9u
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Jul 2018 10:05:23 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In synchronous scenario, like in checkpoint(), we are going to flush
dirty node pages to device synchronously, we can easily failed
writebacking node page due to trylock_page() failure, especially in
condition of intensive lock competition, which can cause long latency
of checkpoint(). So let's use lock_page() in synchronous scenario to
avoid this issue.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index eeee582cee32..237d19eb13b5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1651,7 +1651,9 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 						!is_cold_node(page)))
 				continue;
 lock_node:
-			if (!trylock_page(page))
+			if (wbc->sync_mode == WB_SYNC_ALL)
+				lock_page(page);
+			else if (!trylock_page(page))
 				continue;
 
 			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
-- 
2.18.0.rc1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
