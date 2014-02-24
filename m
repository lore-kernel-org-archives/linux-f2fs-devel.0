From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/2] f2fs: introduce a radix_tree for the
	free_nid list
Date: Mon, 24 Feb 2014 16:18:03 +0900
Message-ID: <1393226284-22447-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WHppP-0003HR-Bg
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Feb 2014 07:19:51 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WHppL-00019q-No
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Feb 2014 07:19:51 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N1H00GDZOCSX740@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Feb 2014 16:19:40 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch introduces a radix tree for the list of free_nids, which enhances
the performance on free nid management.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/node.c | 36 +++++++++++++++++-------------------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c56e67b..11fd8be 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -247,6 +247,7 @@ struct f2fs_nm_info {
 	struct list_head dirty_nat_entries; /* cached nat entry list (dirty) */
 
 	/* free node ids management */
+	struct radix_tree_root free_nid_root;/* root of the free_nid cache */
 	struct list_head free_nid_list;	/* a list for free nids */
 	spinlock_t free_nid_list_lock;	/* protect free nid list */
 	unsigned int fcnt;		/* the number of free node id */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 431bcb4..1f9cf21 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1269,21 +1269,17 @@ const struct address_space_operations f2fs_node_aops = {
 	.releasepage	= f2fs_release_node_page,
 };
 
-static struct free_nid *__lookup_free_nid_list(nid_t n, struct list_head *head)
+static struct free_nid *__lookup_free_nid_list(struct f2fs_nm_info *nm_i,
+						nid_t n)
 {
-	struct list_head *this;
-	struct free_nid *i;
-	list_for_each(this, head) {
-		i = list_entry(this, struct free_nid, list);
-		if (i->nid == n)
-			return i;
-	}
-	return NULL;
+	return radix_tree_lookup(&nm_i->free_nid_root, n);
 }
 
-static void __del_from_free_nid_list(struct free_nid *i)
+static void __del_from_free_nid_list(struct f2fs_nm_info *nm_i,
+						struct free_nid *i)
 {
 	list_del(&i->list);
+	radix_tree_delete(&nm_i->free_nid_root, i->nid);
 	kmem_cache_free(free_nid_slab, i);
 }
 
@@ -1304,7 +1300,8 @@ static int add_free_nid(struct f2fs_nm_info *nm_i, nid_t nid, bool build)
 		/* do not add allocated nids */
 		read_lock(&nm_i->nat_tree_lock);
 		ne = __lookup_nat_cache(nm_i, nid);
-		if (ne && nat_get_blkaddr(ne) != NULL_ADDR)
+		if (ne &&
+			(!ne->checkpointed || nat_get_blkaddr(ne) != NULL_ADDR))
 			allocated = true;
 		read_unlock(&nm_i->nat_tree_lock);
 		if (allocated)
@@ -1316,7 +1313,7 @@ static int add_free_nid(struct f2fs_nm_info *nm_i, nid_t nid, bool build)
 	i->state = NID_NEW;
 
 	spin_lock(&nm_i->free_nid_list_lock);
-	if (__lookup_free_nid_list(nid, &nm_i->free_nid_list)) {
+	if (radix_tree_insert(&nm_i->free_nid_root, i->nid, i)) {
 		spin_unlock(&nm_i->free_nid_list_lock);
 		kmem_cache_free(free_nid_slab, i);
 		return 0;
@@ -1331,9 +1328,9 @@ static void remove_free_nid(struct f2fs_nm_info *nm_i, nid_t nid)
 {
 	struct free_nid *i;
 	spin_lock(&nm_i->free_nid_list_lock);
-	i = __lookup_free_nid_list(nid, &nm_i->free_nid_list);
+	i = __lookup_free_nid_list(nm_i, nid);
 	if (i && i->state == NID_NEW) {
-		__del_from_free_nid_list(i);
+		__del_from_free_nid_list(nm_i, i);
 		nm_i->fcnt--;
 	}
 	spin_unlock(&nm_i->free_nid_list_lock);
@@ -1457,9 +1454,9 @@ void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid)
 	struct free_nid *i;
 
 	spin_lock(&nm_i->free_nid_list_lock);
-	i = __lookup_free_nid_list(nid, &nm_i->free_nid_list);
+	i = __lookup_free_nid_list(nm_i, nid);
 	f2fs_bug_on(!i || i->state != NID_ALLOC);
-	__del_from_free_nid_list(i);
+	__del_from_free_nid_list(nm_i, i);
 	spin_unlock(&nm_i->free_nid_list_lock);
 }
 
@@ -1475,10 +1472,10 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 		return;
 
 	spin_lock(&nm_i->free_nid_list_lock);
-	i = __lookup_free_nid_list(nid, &nm_i->free_nid_list);
+	i = __lookup_free_nid_list(nm_i, nid);
 	f2fs_bug_on(!i || i->state != NID_ALLOC);
 	if (nm_i->fcnt > 2 * MAX_FREE_NIDS) {
-		__del_from_free_nid_list(i);
+		__del_from_free_nid_list(nm_i, i);
 	} else {
 		i->state = NID_NEW;
 		nm_i->fcnt++;
@@ -1812,6 +1809,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	nm_i->fcnt = 0;
 	nm_i->nat_cnt = 0;
 
+	INIT_RADIX_TREE(&nm_i->free_nid_root, GFP_ATOMIC);
 	INIT_LIST_HEAD(&nm_i->free_nid_list);
 	INIT_RADIX_TREE(&nm_i->nat_root, GFP_ATOMIC);
 	INIT_LIST_HEAD(&nm_i->nat_entries);
@@ -1865,7 +1863,7 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
 	spin_lock(&nm_i->free_nid_list_lock);
 	list_for_each_entry_safe(i, next_i, &nm_i->free_nid_list, list) {
 		f2fs_bug_on(i->state == NID_ALLOC);
-		__del_from_free_nid_list(i);
+		__del_from_free_nid_list(nm_i, i);
 		nm_i->fcnt--;
 	}
 	f2fs_bug_on(nm_i->fcnt);
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
