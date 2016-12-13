From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: don't cache nat entry if out of memory
Date: Tue, 13 Dec 2016 18:54:59 +0800
Message-ID: <20161213105459.3431-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cGkkP-0002S8-0A
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 13 Dec 2016 10:55:49 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cGkkJ-0005JT-Vj
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 13 Dec 2016 10:55:48 +0000
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

If we run out of memory, in cache_nat_entry, it's better to avoid loop
for allocating memory to cache nat entry, so in low memory scenario, for
read path of node block, I expect this can avoid unneeded latency.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c1bbfdc..c1e267a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -245,12 +245,24 @@ bool need_inode_block_update(struct f2fs_sb_info *sbi, nid_t ino)
 	return need_update;
 }
 
-static struct nat_entry *grab_nat_entry(struct f2fs_nm_info *nm_i, nid_t nid)
+static struct nat_entry *grab_nat_entry(struct f2fs_nm_info *nm_i, nid_t nid,
+								bool no_fail)
 {
 	struct nat_entry *new;
 
-	new = f2fs_kmem_cache_alloc(nat_entry_slab, GFP_NOFS);
-	f2fs_radix_tree_insert(&nm_i->nat_root, nid, new);
+	if (no_fail) {
+		new = f2fs_kmem_cache_alloc(nat_entry_slab, GFP_NOFS);
+		f2fs_radix_tree_insert(&nm_i->nat_root, nid, new);
+	} else {
+		new = kmem_cache_alloc(nat_entry_slab, GFP_NOFS);
+		if (!new)
+			return NULL;
+		if (radix_tree_insert(&nm_i->nat_root, nid, new)) {
+			kmem_cache_free(nat_entry_slab, new);
+			return NULL;
+		}
+	}
+
 	memset(new, 0, sizeof(struct nat_entry));
 	nat_set_nid(new, nid);
 	nat_reset_flag(new);
@@ -267,8 +279,9 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
 
 	e = __lookup_nat_cache(nm_i, nid);
 	if (!e) {
-		e = grab_nat_entry(nm_i, nid);
-		node_info_from_raw_nat(&e->ni, ne);
+		e = grab_nat_entry(nm_i, nid, false);
+		if (e)
+			node_info_from_raw_nat(&e->ni, ne);
 	} else {
 		f2fs_bug_on(sbi, nat_get_ino(e) != le32_to_cpu(ne->ino) ||
 				nat_get_blkaddr(e) !=
@@ -286,7 +299,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 	down_write(&nm_i->nat_tree_lock);
 	e = __lookup_nat_cache(nm_i, ni->nid);
 	if (!e) {
-		e = grab_nat_entry(nm_i, ni->nid);
+		e = grab_nat_entry(nm_i, ni->nid, true);
 		copy_node_info(&e->ni, ni);
 		f2fs_bug_on(sbi, ni->blk_addr == NEW_ADDR);
 	} else if (new_blkaddr == NEW_ADDR) {
@@ -2152,7 +2165,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 
 		ne = __lookup_nat_cache(nm_i, nid);
 		if (!ne) {
-			ne = grab_nat_entry(nm_i, nid);
+			ne = grab_nat_entry(nm_i, nid, true);
 			node_info_from_raw_nat(&ne->ni, &raw_ne);
 		}
 
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
