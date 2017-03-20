From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix race condition in between free nid
	allocator/initializer
Date: Mon, 20 Mar 2017 19:07:53 +0800
Message-ID: <20170320110753.53494-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cpvAs-000540-RB
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Mar 2017 11:08:30 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cpvAr-00048Z-5q
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Mar 2017 11:08:30 +0000
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

This patch uses build_lock covering free nid allocation and initialization
to avoid this race condition.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3bfffd744f87..ea45be031c9d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -22,8 +22,6 @@
 #include "trace.h"
 #include <trace/events/f2fs.h>
 
-#define on_build_free_nids(nmi) mutex_is_locked(&nm_i->build_lock)
-
 static struct kmem_cache *nat_entry_slab;
 static struct kmem_cache *free_nid_slab;
 static struct kmem_cache *nat_entry_set_slab;
@@ -1802,6 +1800,7 @@ static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
 	struct free_nid *i;
 	bool need_free = false;
 
+	mutex_lock(&nm_i->build_lock);
 	spin_lock(&nm_i->nid_list_lock);
 	i = __lookup_free_nid_list(nm_i, nid);
 	if (i && i->state == NID_NEW) {
@@ -1809,6 +1808,7 @@ static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
 		need_free = true;
 	}
 	spin_unlock(&nm_i->nid_list_lock);
+	mutex_unlock(&nm_i->build_lock);
 
 	if (need_free)
 		kmem_cache_free(free_nid_slab, i);
@@ -1999,15 +1999,18 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 		return false;
 	}
 #endif
+
+	mutex_lock(&nm_i->build_lock);
 	spin_lock(&nm_i->nid_list_lock);
 
 	if (unlikely(nm_i->available_nids == 0)) {
 		spin_unlock(&nm_i->nid_list_lock);
+		mutex_unlock(&nm_i->build_lock);
 		return false;
 	}
 
 	/* We should not use stale free nids created by build_free_nids */
-	if (nm_i->nid_cnt[FREE_NID_LIST] && !on_build_free_nids(nm_i)) {
+	if (nm_i->nid_cnt[FREE_NID_LIST]) {
 		f2fs_bug_on(sbi, list_empty(&nm_i->nid_list[FREE_NID_LIST]));
 		i = list_first_entry(&nm_i->nid_list[FREE_NID_LIST],
 					struct free_nid, list);
@@ -2021,9 +2024,11 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 		update_free_nid_bitmap(sbi, *nid, false, false);
 
 		spin_unlock(&nm_i->nid_list_lock);
+		mutex_unlock(&nm_i->build_lock);
 		return true;
 	}
 	spin_unlock(&nm_i->nid_list_lock);
+	mutex_unlock(&nm_i->build_lock);
 
 	/* Let's scan nat pages and its caches to get free nids */
 	build_free_nids(sbi, true, false);
@@ -2038,11 +2043,13 @@ void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i;
 
+	mutex_lock(&nm_i->build_lock);
 	spin_lock(&nm_i->nid_list_lock);
 	i = __lookup_free_nid_list(nm_i, nid);
 	f2fs_bug_on(sbi, !i);
 	__remove_nid_from_list(sbi, i, ALLOC_NID_LIST, false);
 	spin_unlock(&nm_i->nid_list_lock);
+	mutex_unlock(&nm_i->build_lock);
 
 	kmem_cache_free(free_nid_slab, i);
 }
@@ -2059,6 +2066,7 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 	if (!nid)
 		return;
 
+	mutex_lock(&nm_i->build_lock);
 	spin_lock(&nm_i->nid_list_lock);
 	i = __lookup_free_nid_list(nm_i, nid);
 	f2fs_bug_on(sbi, !i);
@@ -2077,6 +2085,7 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 	update_free_nid_bitmap(sbi, nid, true, false);
 
 	spin_unlock(&nm_i->nid_list_lock);
+	mutex_unlock(&nm_i->build_lock);
 
 	if (need_free)
 		kmem_cache_free(free_nid_slab, i);
@@ -2443,6 +2452,7 @@ void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	if (!nm_i->dirty_nat_cnt)
 		return;
 
+	mutex_lock(&nm_i->build_lock);
 	down_write(&nm_i->nat_tree_lock);
 
 	/*
@@ -2468,6 +2478,7 @@ void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		__flush_nat_entry_set(sbi, set, cpc);
 
 	up_write(&nm_i->nat_tree_lock);
+	mutex_unlock(&nm_i->build_lock);
 
 	f2fs_bug_on(sbi, nm_i->dirty_nat_cnt);
 }
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
