From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3 RESEND] f2fs: fix race condition in between
	free nid allocator/initializer
Date: Wed, 22 Mar 2017 14:45:05 +0800
Message-ID: <20170322064505.88659-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cqa1g-0003bN-M9
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 06:45:44 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cqa1f-0006ko-AN
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 06:45:44 +0000
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In below concurrent case, allocated nid can be loaded into free nid cache
and be allocated again.

Thread A				Thread B
- f2fs_create
 - f2fs_new_inode
  - alloc_nid
   - __insert_nid_to_list(ALLOC_NID_LIST)
					- f2fs_balance_fs_bg
					 - build_free_nids
					  - __build_free_nids
					   - scan_nat_page
					    - add_free_nid
					     - __lookup_nat_cache
 - f2fs_add_link
  - init_inode_metadata
   - new_inode_page
    - new_node_page
     - set_node_addr
 - alloc_nid_done
  - __remove_nid_from_list(ALLOC_NID_LIST)
					     - __insert_nid_to_list(FREE_NID_LIST)

This patch makes nat cache lookup and free nid list operation being atomical
to avoid this race condition.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 63 +++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4f89478be683..6e87178d34a2 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1761,40 +1761,67 @@ static void __remove_nid_from_list(struct f2fs_sb_info *sbi,
 static bool add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	struct free_nid *i;
+	struct free_nid *i, *e;
 	struct nat_entry *ne;
-	int err;
+	int err = -EINVAL;
+	bool ret = false;
 
 	/* 0 nid should not be used */
 	if (unlikely(nid == 0))
 		return false;
 
-	if (build) {
-		/* do not add allocated nids */
-		ne = __lookup_nat_cache(nm_i, nid);
-		if (ne && (!get_nat_flag(ne, IS_CHECKPOINTED) ||
-				nat_get_blkaddr(ne) != NULL_ADDR))
-			return false;
-	}
-
 	i = f2fs_kmem_cache_alloc(free_nid_slab, GFP_NOFS);
 	i->nid = nid;
 	i->state = NID_NEW;
 
-	if (radix_tree_preload(GFP_NOFS)) {
-		kmem_cache_free(free_nid_slab, i);
-		return true;
-	}
+	if (radix_tree_preload(GFP_NOFS))
+		goto err;
 
 	spin_lock(&nm_i->nid_list_lock);
+
+	if (build) {
+		/*
+		 *   Thread A             Thread B
+		 *  - f2fs_create
+		 *   - f2fs_new_inode
+		 *    - alloc_nid
+		 *     - __insert_nid_to_list(ALLOC_NID_LIST)
+		 *                     - f2fs_balance_fs_bg
+		 *                      - build_free_nids
+		 *                       - __build_free_nids
+		 *                        - scan_nat_page
+		 *                         - add_free_nid
+		 *                          - __lookup_nat_cache
+		 *  - f2fs_add_link
+		 *   - init_inode_metadata
+		 *    - new_inode_page
+		 *     - new_node_page
+		 *      - set_node_addr
+		 *  - alloc_nid_done
+		 *   - __remove_nid_from_list(ALLOC_NID_LIST)
+		 *                         - __insert_nid_to_list(FREE_NID_LIST)
+		 */
+		ne = __lookup_nat_cache(nm_i, nid);
+		if (ne && (!get_nat_flag(ne, IS_CHECKPOINTED) ||
+				nat_get_blkaddr(ne) != NULL_ADDR))
+			goto err_out;
+
+		e = __lookup_free_nid_list(nm_i, nid);
+		if (e) {
+			if (e->state == NID_NEW)
+				ret = true;
+			goto err_out;
+		}
+	}
+	ret = true;
 	err = __insert_nid_to_list(sbi, i, FREE_NID_LIST, true);
+err_out:
 	spin_unlock(&nm_i->nid_list_lock);
 	radix_tree_preload_end();
-	if (err) {
+err:
+	if (err)
 		kmem_cache_free(free_nid_slab, i);
-		return true;
-	}
-	return true;
+	return ret;
 }
 
 static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
