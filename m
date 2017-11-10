From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3 1/3] f2fs: avoid opened loop codes in
 __add_ino_entry
Date: Fri, 10 Nov 2017 09:30:42 +0800
Message-ID: <20171110013042.85168-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eCyA9-0002gG-4c
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Nov 2017 01:31:17 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eCyA7-0005rs-6A
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Nov 2017 01:31:17 +0000
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

We will keep __add_ino_entry success all the time, for ENOMEM failure
case, we have already handled it by using  __GFP_NOFAIL flag, so we
don't have to use additional opened loop codes here, remove them.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- give compiler a hint with unlikely keyword.
- remove unneeded variable
 fs/f2fs/checkpoint.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 98777c1ae70c..a30024f2a567 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -407,18 +407,16 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
 	struct ino_entry *e, *tmp;
 
 	tmp = f2fs_kmem_cache_alloc(ino_entry_slab, GFP_NOFS);
-retry:
+
 	radix_tree_preload(GFP_NOFS | __GFP_NOFAIL);
 
 	spin_lock(&im->ino_lock);
 	e = radix_tree_lookup(&im->ino_root, ino);
 	if (!e) {
 		e = tmp;
-		if (radix_tree_insert(&im->ino_root, ino, e)) {
-			spin_unlock(&im->ino_lock);
-			radix_tree_preload_end();
-			goto retry;
-		}
+		if (unlikely(radix_tree_insert(&im->ino_root, ino, e)))
+			f2fs_bug_on(sbi, 1);
+
 		memset(e, 0, sizeof(struct ino_entry));
 		e->ino = ino;
 
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
