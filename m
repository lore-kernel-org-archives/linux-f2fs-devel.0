From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 1/3] f2fs: avoid opened loop codes in
 __add_ino_entry
Date: Tue, 7 Nov 2017 13:41:42 +0800
Message-ID: <20171107054142.6242-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eBwfD-0002Ua-Ts
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Nov 2017 05:43:07 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eBwfB-0004q3-O8
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Nov 2017 05:43:07 +0000
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
Cc: mhocko@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We will keep __add_ino_entry success all the time, for ENOMEM failure
case, we have already handled it by using  __GFP_NOFAIL flag, so we
don't have to use additional opened loop codes here, remove them.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
As Michal Hocko suggested, with __GFP_NOFAIL, MM will do all it can for
memory allocation including access memory reserves, so it's better to
use it rather than opened loop code, update this patch for it.
 fs/f2fs/checkpoint.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 98777c1ae70c..80b90146cff2 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -405,20 +405,21 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
 {
 	struct inode_management *im = &sbi->im[type];
 	struct ino_entry *e, *tmp;
+	bool preloaded;
+	int err;
 
 	tmp = f2fs_kmem_cache_alloc(ino_entry_slab, GFP_NOFS);
-retry:
-	radix_tree_preload(GFP_NOFS | __GFP_NOFAIL);
+
+	preloaded = !radix_tree_preload(GFP_NOFS | __GFP_NOFAIL);
+	f2fs_bug_on(sbi, !preloaded);
 
 	spin_lock(&im->ino_lock);
 	e = radix_tree_lookup(&im->ino_root, ino);
 	if (!e) {
 		e = tmp;
-		if (radix_tree_insert(&im->ino_root, ino, e)) {
-			spin_unlock(&im->ino_lock);
-			radix_tree_preload_end();
-			goto retry;
-		}
+		err = radix_tree_insert(&im->ino_root, ino, e);
+		f2fs_bug_on(sbi, err);
+
 		memset(e, 0, sizeof(struct ino_entry));
 		e->ino = ino;
 
@@ -431,7 +432,9 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
 		f2fs_set_bit(devidx, (char *)&e->dirty_device);
 
 	spin_unlock(&im->ino_lock);
-	radix_tree_preload_end();
+
+	if (preloaded)
+		radix_tree_preload_end();
 
 	if (e != tmp)
 		kmem_cache_free(ino_entry_slab, tmp);
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
