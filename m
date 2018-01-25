From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: use GFP_F2FS_ZERO for cleanup
Date: Thu, 25 Jan 2018 18:57:25 +0800
Message-ID: <20180125105727.50357-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eefEC-0003dm-Ln
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Jan 2018 10:57:56 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eefEB-00007u-Dd
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Jan 2018 10:57:56 +0000
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

Clean up codes with GFP_F2FS_ZERO, no logic changes.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9822c9a34823..7cded843cf18 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -143,11 +143,9 @@ static struct nat_entry *__alloc_nat_entry(nid_t nid, bool no_fail)
 	struct nat_entry *new;
 
 	if (no_fail)
-		new = f2fs_kmem_cache_alloc(nat_entry_slab,
-						GFP_NOFS | __GFP_ZERO);
+		new = f2fs_kmem_cache_alloc(nat_entry_slab, GFP_F2FS_ZERO);
 	else
-		new = kmem_cache_alloc(nat_entry_slab,
-						GFP_NOFS | __GFP_ZERO);
+		new = kmem_cache_alloc(nat_entry_slab, GFP_F2FS_ZERO);
 	if (new) {
 		nat_set_nid(new, nid);
 		nat_reset_flag(new);
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
