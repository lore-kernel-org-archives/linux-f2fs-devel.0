From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/7] f2fs: clean up nid list operation
Date: Tue, 11 Oct 2016 22:31:31 +0800
Message-ID: <20161011143136.2107-2-chao@kernel.org>
References: <20161011143136.2107-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bty86-0006mx-Oi
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:34:06 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bty85-0002OP-MQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:34:06 +0000
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

Introduce new help __insert_nid_to_list and __remove_nid_from_list to
clean up nid list related codes.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 66 ++++++++++++++++++++++++++++++++++++++++------------------
 fs/f2fs/node.h |  5 +++++
 2 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a1725a9..ea9ff8c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1698,10 +1698,40 @@ static struct free_nid *__lookup_free_nid_list(struct f2fs_nm_info *nm_i,
 static void __del_from_free_nid_list(struct f2fs_nm_info *nm_i,
 						struct free_nid *i)
 {
-	list_del(&i->list);
 	radix_tree_delete(&nm_i->free_nid_root, i->nid);
 }
 
+static void __insert_nid_to_list(struct f2fs_sb_info *sbi,
+					struct free_nid *i, enum nid_list list)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+
+	if (list == FREE_NID_LIST) {
+		f2fs_bug_on(sbi, i->state != NID_NEW);
+		nm_i->free_nid_cnt++;
+		list_add_tail(&i->list, &nm_i->free_nid_list);
+	} else {
+		f2fs_bug_on(sbi, i->state != NID_ALLOC);
+		nm_i->alloc_nid_cnt++;
+		list_add_tail(&i->list, &nm_i->alloc_nid_list);
+	}
+}
+
+static void __remove_nid_from_list(struct f2fs_sb_info *sbi,
+					struct free_nid *i, enum nid_list list)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+
+	if (list == FREE_NID_LIST) {
+		f2fs_bug_on(sbi, i->state != NID_NEW);
+		nm_i->free_nid_cnt--;
+	} else {
+		f2fs_bug_on(sbi, i->state != NID_ALLOC);
+		nm_i->alloc_nid_cnt--;
+	}
+	list_del(&i->list);
+}
+
 static int add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
@@ -1739,8 +1769,7 @@ static int add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 		kmem_cache_free(free_nid_slab, i);
 		return 0;
 	}
-	list_add_tail(&i->list, &nm_i->free_nid_list);
-	nm_i->free_nid_cnt++;
+	__insert_nid_to_list(sbi, i, FREE_NID_LIST);
 	spin_unlock(&nm_i->free_nid_list_lock);
 	radix_tree_preload_end();
 	return 1;
@@ -1755,8 +1784,8 @@ static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
 	spin_lock(&nm_i->free_nid_list_lock);
 	i = __lookup_free_nid_list(nm_i, nid);
 	if (i && i->state == NID_NEW) {
+		__remove_nid_from_list(sbi, i, FREE_NID_LIST);
 		__del_from_free_nid_list(nm_i, i);
-		nm_i->free_nid_cnt--;
 		need_free = true;
 	}
 	spin_unlock(&nm_i->free_nid_list_lock);
@@ -1867,12 +1896,11 @@ retry:
 		f2fs_bug_on(sbi, list_empty(&nm_i->free_nid_list));
 		i = list_first_entry(&nm_i->free_nid_list,
 					struct free_nid, list);
-		f2fs_bug_on(sbi, i->state != NID_NEW);
 		*nid = i->nid;
+
+		__remove_nid_from_list(sbi, i, FREE_NID_LIST);
 		i->state = NID_ALLOC;
-		nm_i->free_nid_cnt--;
-		nm_i->alloc_nid_cnt++;
-		list_move_tail(&i->list, &nm_i->alloc_nid_list);
+		__insert_nid_to_list(sbi, i, ALLOC_NID_LIST);
 		spin_unlock(&nm_i->free_nid_list_lock);
 		return true;
 	}
@@ -1895,9 +1923,9 @@ void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid)
 
 	spin_lock(&nm_i->free_nid_list_lock);
 	i = __lookup_free_nid_list(nm_i, nid);
-	f2fs_bug_on(sbi, !i || i->state != NID_ALLOC);
+	f2fs_bug_on(sbi, !i);
+	__remove_nid_from_list(sbi, i, ALLOC_NID_LIST);
 	__del_from_free_nid_list(nm_i, i);
-	nm_i->alloc_nid_cnt--;
 	spin_unlock(&nm_i->free_nid_list_lock);
 
 	kmem_cache_free(free_nid_slab, i);
@@ -1917,16 +1945,16 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 
 	spin_lock(&nm_i->free_nid_list_lock);
 	i = __lookup_free_nid_list(nm_i, nid);
-	f2fs_bug_on(sbi, !i || i->state != NID_ALLOC);
+	f2fs_bug_on(sbi, !i);
+
+	__remove_nid_from_list(sbi, i, ALLOC_NID_LIST);
+
 	if (!available_free_memory(sbi, FREE_NIDS)) {
-		nm_i->alloc_nid_cnt--;
 		__del_from_free_nid_list(nm_i, i);
 		need_free = true;
 	} else {
 		i->state = NID_NEW;
-		nm_i->free_nid_cnt++;
-		nm_i->alloc_nid_cnt--;
-		list_move_tail(&i->list, &nm_i->free_nid_list);
+		__insert_nid_to_list(sbi, i, FREE_NID_LIST);
 	}
 	spin_unlock(&nm_i->free_nid_list_lock);
 
@@ -1951,11 +1979,10 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 		if (nr_shrink <= 0 || nm_i->free_nid_cnt <= MAX_FREE_NIDS)
 			break;
 
-		f2fs_bug_on(sbi, i->state == NID_ALLOC);
-
+		__remove_nid_from_list(sbi, i, FREE_NID_LIST);
 		__del_from_free_nid_list(nm_i, i);
+
 		kmem_cache_free(free_nid_slab, i);
-		nm_i->free_nid_cnt--;
 		nr_shrink--;
 	}
 	spin_unlock(&nm_i->free_nid_list_lock);
@@ -2340,9 +2367,8 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
 	/* destroy free nid list */
 	spin_lock(&nm_i->free_nid_list_lock);
 	list_for_each_entry_safe(i, next_i, &nm_i->free_nid_list, list) {
-		f2fs_bug_on(sbi, i->state == NID_ALLOC);
+		__remove_nid_from_list(sbi, i, FREE_NID_LIST);
 		__del_from_free_nid_list(nm_i, i);
-		nm_i->free_nid_cnt--;
 		spin_unlock(&nm_i->free_nid_list_lock);
 		kmem_cache_free(free_nid_slab, i);
 		spin_lock(&nm_i->free_nid_list_lock);
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 66928d7..a4ee774 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -158,6 +158,11 @@ enum nid_state {
 	NID_ALLOC	/* it is allocated */
 };
 
+enum nid_list {
+	FREE_NID_LIST,
+	ALLOC_NID_LIST
+};
+
 struct free_nid {
 	struct list_head list;	/* for free node id list */
 	nid_t nid;		/* node id */
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
