From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/7] f2fs: rename free nid cache operation
Date: Wed, 12 Oct 2016 10:15:48 -0700
Message-ID: <20161012171548.GA98211@jaegeuk>
References: <20161011143136.2107-1-chao@kernel.org>
	<20161011143136.2107-3-chao@kernel.org>
	<20161011171903.GB82199@jaegeuk>
	<f1825a12-726f-4d79-b15b-3614d92d6897@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1buN8H-0003wq-Vk
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Oct 2016 17:15:57 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1buN8G-00061b-PQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Oct 2016 17:15:57 +0000
Content-Disposition: inline
In-Reply-To: <f1825a12-726f-4d79-b15b-3614d92d6897@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Wed, Oct 12, 2016 at 11:14:42PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2016/10/12 1:19, Jaegeuk Kim wrote:
> > Hi Chao,
> > 
> > On Tue, Oct 11, 2016 at 10:31:32PM +0800, Chao Yu wrote:
> >> From: Chao Yu <yuchao0@huawei.com>
> >>
> >> Rename free nid cache operation for readability, no functionality change.
> > 
> > Well, I don't think this can be a *cache*, since there is no cache-related
> > operations such as reordering by cache hit, whereas it is more likely to
> 
> This is because we do not record any nids which has been allocated to node
> blocks, otherwise we will recored the status of nid in the cache and also it can
> be hitted during lookup.
> 
> In original patches, free_nid_list is split to two separate lists: free_nid_list
> and alloc_nid_list, __lookup_free_nid_list looks like just search the first one,
> so in order to avoid misunderstanding, I proposal this change.
> 
> Anyway, what about using __{lookup,insert_to,remove_from}_nid_list instead?

Then, how about this one?

>From 4f4b48de34ffaf94baa2065bcd5d44566f8d25b9 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Wed, 12 Oct 2016 10:09:59 -0700
Subject: [PATCH] f2fs: clean up free nid list operations

This patch cleans up to use consistent free nid list ops.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 56 ++++++++++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 54d1c49..3d2e259 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1698,25 +1698,26 @@ static struct free_nid *__lookup_free_nid_list(struct f2fs_nm_info *nm_i,
 	return radix_tree_lookup(&nm_i->free_nid_root, n);
 }
 
-static void __del_from_free_nid_list(struct f2fs_nm_info *nm_i,
-						struct free_nid *i)
-{
-	radix_tree_delete(&nm_i->free_nid_root, i->nid);
-}
-
-static void __insert_nid_to_list(struct f2fs_sb_info *sbi,
-					struct free_nid *i, enum nid_list list)
+static int __insert_nid_to_list(struct f2fs_sb_info *sbi,
+			struct free_nid *i, enum nid_list list, bool new)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 
+	if (new) {
+		int err = radix_tree_insert(&nm_i->free_nid_root, i->nid, i);
+		if (err)
+			return err;
+	}
+
 	f2fs_bug_on(sbi, list == FREE_NID_LIST ? i->state != NID_NEW :
 						i->state != NID_ALLOC);
 	nm_i->nid_cnt[list]++;
 	list_add_tail(&i->list, &nm_i->nid_list[list]);
+	return 0;
 }
 
 static void __remove_nid_from_list(struct f2fs_sb_info *sbi,
-					struct free_nid *i, enum nid_list list)
+			struct free_nid *i, enum nid_list list, bool reuse)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 
@@ -1724,6 +1725,8 @@ static void __remove_nid_from_list(struct f2fs_sb_info *sbi,
 						i->state != NID_ALLOC);
 	nm_i->nid_cnt[list]--;
 	list_del(&i->list);
+	if (!reuse)
+		radix_tree_delete(&nm_i->free_nid_root, i->nid);
 }
 
 static int add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
@@ -1731,6 +1734,7 @@ static int add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i;
 	struct nat_entry *ne;
+	int err;
 
 	if (!available_free_memory(sbi, FREE_NIDS))
 		return -1;
@@ -1757,15 +1761,13 @@ static int add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 	}
 
 	spin_lock(&nm_i->nid_list_lock);
-	if (radix_tree_insert(&nm_i->free_nid_root, i->nid, i)) {
-		spin_unlock(&nm_i->nid_list_lock);
-		radix_tree_preload_end();
+	err = __insert_nid_to_list(sbi, i, FREE_NID_LIST, true);
+	spin_unlock(&nm_i->nid_list_lock);
+	radix_tree_preload_end();
+	if (err) {
 		kmem_cache_free(free_nid_slab, i);
 		return 0;
 	}
-	__insert_nid_to_list(sbi, i, FREE_NID_LIST);
-	spin_unlock(&nm_i->nid_list_lock);
-	radix_tree_preload_end();
 	return 1;
 }
 
@@ -1778,8 +1780,7 @@ static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
 	spin_lock(&nm_i->nid_list_lock);
 	i = __lookup_free_nid_list(nm_i, nid);
 	if (i && i->state == NID_NEW) {
-		__remove_nid_from_list(sbi, i, FREE_NID_LIST);
-		__del_from_free_nid_list(nm_i, i);
+		__remove_nid_from_list(sbi, i, FREE_NID_LIST, false);
 		need_free = true;
 	}
 	spin_unlock(&nm_i->nid_list_lock);
@@ -1899,9 +1900,9 @@ retry:
 					struct free_nid, list);
 		*nid = i->nid;
 
-		__remove_nid_from_list(sbi, i, FREE_NID_LIST);
+		__remove_nid_from_list(sbi, i, FREE_NID_LIST, true);
 		i->state = NID_ALLOC;
-		__insert_nid_to_list(sbi, i, ALLOC_NID_LIST);
+		__insert_nid_to_list(sbi, i, ALLOC_NID_LIST, false);
 		spin_unlock(&nm_i->nid_list_lock);
 		return true;
 	}
@@ -1923,8 +1924,7 @@ void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid)
 	spin_lock(&nm_i->nid_list_lock);
 	i = __lookup_free_nid_list(nm_i, nid);
 	f2fs_bug_on(sbi, !i);
-	__remove_nid_from_list(sbi, i, ALLOC_NID_LIST);
-	__del_from_free_nid_list(nm_i, i);
+	__remove_nid_from_list(sbi, i, ALLOC_NID_LIST, false);
 	spin_unlock(&nm_i->nid_list_lock);
 
 	kmem_cache_free(free_nid_slab, i);
@@ -1946,14 +1946,13 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 	i = __lookup_free_nid_list(nm_i, nid);
 	f2fs_bug_on(sbi, !i);
 
-	__remove_nid_from_list(sbi, i, ALLOC_NID_LIST);
-
 	if (!available_free_memory(sbi, FREE_NIDS)) {
-		__del_from_free_nid_list(nm_i, i);
+		__remove_nid_from_list(sbi, i, ALLOC_NID_LIST, false);
 		need_free = true;
 	} else {
+		__remove_nid_from_list(sbi, i, ALLOC_NID_LIST, true);
 		i->state = NID_NEW;
-		__insert_nid_to_list(sbi, i, FREE_NID_LIST);
+		__insert_nid_to_list(sbi, i, FREE_NID_LIST, false);
 	}
 	spin_unlock(&nm_i->nid_list_lock);
 
@@ -1980,9 +1979,7 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 				nm_i->nid_cnt[FREE_NID_LIST] <= MAX_FREE_NIDS)
 			break;
 
-		__remove_nid_from_list(sbi, i, FREE_NID_LIST);
-		__del_from_free_nid_list(nm_i, i);
-
+		__remove_nid_from_list(sbi, i, FREE_NID_LIST, false);
 		kmem_cache_free(free_nid_slab, i);
 		nr_shrink--;
 	}
@@ -2369,8 +2366,7 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
 	spin_lock(&nm_i->nid_list_lock);
 	list_for_each_entry_safe(i, next_i, &nm_i->nid_list[FREE_NID_LIST],
 									list) {
-		__remove_nid_from_list(sbi, i, FREE_NID_LIST);
-		__del_from_free_nid_list(nm_i, i);
+		__remove_nid_from_list(sbi, i, FREE_NID_LIST, false);
 		spin_unlock(&nm_i->nid_list_lock);
 		kmem_cache_free(free_nid_slab, i);
 		spin_lock(&nm_i->nid_list_lock);
-- 
2.8.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
