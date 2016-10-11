From: Chao Yu <chao@kernel.org>
Subject: [PATCH 3/7] f2fs: rename free nid cache operation
Date: Tue, 11 Oct 2016 22:31:32 +0800
Message-ID: <20161011143136.2107-3-chao@kernel.org>
References: <20161011143136.2107-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bty8B-0006nJ-96
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:34:11 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bty8A-00076u-DJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:34:11 +0000
In-Reply-To: <20161011143136.2107-1-chao@kernel.org>
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

From: Chao Yu <yuchao0@huawei.com>

Rename free nid cache operation for readability, no functionality change.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ea9ff8c..92c9aa4 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1689,13 +1689,19 @@ const struct address_space_operations f2fs_node_aops = {
 #endif
 };
 
-static struct free_nid *__lookup_free_nid_list(struct f2fs_nm_info *nm_i,
+static struct free_nid *__lookup_free_nid_cache(struct f2fs_nm_info *nm_i,
 						nid_t n)
 {
 	return radix_tree_lookup(&nm_i->free_nid_root, n);
 }
 
-static void __del_from_free_nid_list(struct f2fs_nm_info *nm_i,
+static int __insert_to_free_nid_cache(struct f2fs_nm_info *nm_i,
+						struct free_nid *i)
+{
+	return radix_tree_insert(&nm_i->free_nid_root, i->nid, i);
+}
+
+static void __del_from_free_nid_cache(struct f2fs_nm_info *nm_i,
 						struct free_nid *i)
 {
 	radix_tree_delete(&nm_i->free_nid_root, i->nid);
@@ -1763,7 +1769,7 @@ static int add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 	}
 
 	spin_lock(&nm_i->free_nid_list_lock);
-	if (radix_tree_insert(&nm_i->free_nid_root, i->nid, i)) {
+	if (__insert_to_free_nid_cache(nm_i, i)) {
 		spin_unlock(&nm_i->free_nid_list_lock);
 		radix_tree_preload_end();
 		kmem_cache_free(free_nid_slab, i);
@@ -1782,10 +1788,10 @@ static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
 	bool need_free = false;
 
 	spin_lock(&nm_i->free_nid_list_lock);
-	i = __lookup_free_nid_list(nm_i, nid);
+	i = __lookup_free_nid_cache(nm_i, nid);
 	if (i && i->state == NID_NEW) {
 		__remove_nid_from_list(sbi, i, FREE_NID_LIST);
-		__del_from_free_nid_list(nm_i, i);
+		__del_from_free_nid_cache(nm_i, i);
 		need_free = true;
 	}
 	spin_unlock(&nm_i->free_nid_list_lock);
@@ -1922,10 +1928,10 @@ void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid)
 	struct free_nid *i;
 
 	spin_lock(&nm_i->free_nid_list_lock);
-	i = __lookup_free_nid_list(nm_i, nid);
+	i = __lookup_free_nid_cache(nm_i, nid);
 	f2fs_bug_on(sbi, !i);
 	__remove_nid_from_list(sbi, i, ALLOC_NID_LIST);
-	__del_from_free_nid_list(nm_i, i);
+	__del_from_free_nid_cache(nm_i, i);
 	spin_unlock(&nm_i->free_nid_list_lock);
 
 	kmem_cache_free(free_nid_slab, i);
@@ -1944,13 +1950,13 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 		return;
 
 	spin_lock(&nm_i->free_nid_list_lock);
-	i = __lookup_free_nid_list(nm_i, nid);
+	i = __lookup_free_nid_cache(nm_i, nid);
 	f2fs_bug_on(sbi, !i);
 
 	__remove_nid_from_list(sbi, i, ALLOC_NID_LIST);
 
 	if (!available_free_memory(sbi, FREE_NIDS)) {
-		__del_from_free_nid_list(nm_i, i);
+		__del_from_free_nid_cache(nm_i, i);
 		need_free = true;
 	} else {
 		i->state = NID_NEW;
@@ -1980,7 +1986,7 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 			break;
 
 		__remove_nid_from_list(sbi, i, FREE_NID_LIST);
-		__del_from_free_nid_list(nm_i, i);
+		__del_from_free_nid_cache(nm_i, i);
 
 		kmem_cache_free(free_nid_slab, i);
 		nr_shrink--;
@@ -2368,7 +2374,7 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
 	spin_lock(&nm_i->free_nid_list_lock);
 	list_for_each_entry_safe(i, next_i, &nm_i->free_nid_list, list) {
 		__remove_nid_from_list(sbi, i, FREE_NID_LIST);
-		__del_from_free_nid_list(nm_i, i);
+		__del_from_free_nid_cache(nm_i, i);
 		spin_unlock(&nm_i->free_nid_list_lock);
 		kmem_cache_free(free_nid_slab, i);
 		spin_lock(&nm_i->free_nid_list_lock);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
