From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v4] f2fs: Separate nat entry mem alloc from
 nat_tree_locks
Date: Tue, 7 Nov 2017 17:36:20 +0800
Message-ID: <1510047380-7169-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1eC0VA-0000zP-IX
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Nov 2017 09:49:00 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eC0V8-0006ow-1D
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Nov 2017 09:49:00 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: ning.jia@huawei.com, heyunlei@huawei.com

This path separate nat_entry mem alloc from nat_tree_lock,
which will benefit in some low mem case.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/node.c | 55 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fef5c68..31909f8 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -257,22 +257,15 @@ static struct nat_entry *grab_nat_entry(struct f2fs_nm_info *nm_i, nid_t nid,
 
 	if (no_fail) {
 		new = f2fs_kmem_cache_alloc(nat_entry_slab, GFP_NOFS);
-		f2fs_radix_tree_insert(&nm_i->nat_root, nid, new);
 	} else {
 		new = kmem_cache_alloc(nat_entry_slab, GFP_NOFS);
 		if (!new)
 			return NULL;
-		if (radix_tree_insert(&nm_i->nat_root, nid, new)) {
-			kmem_cache_free(nat_entry_slab, new);
-			return NULL;
-		}
 	}
 
 	memset(new, 0, sizeof(struct nat_entry));
 	nat_set_nid(new, nid);
 	nat_reset_flag(new);
-	list_add_tail(&new->list, &nm_i->nat_entries);
-	nm_i->nat_cnt++;
 	return new;
 }
 
@@ -282,17 +275,31 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct nat_entry *e;
 
+#ifdef CONFIG_F2FS_CHECK_FS
+	down_read(&nm_i->nat_tree_lock);
 	e = __lookup_nat_cache(nm_i, nid);
-	if (!e) {
-		e = grab_nat_entry(nm_i, nid, false);
-		if (e)
-			node_info_from_raw_nat(&e->ni, ne);
-	} else {
+	if (e) {
 		f2fs_bug_on(sbi, nat_get_ino(e) != le32_to_cpu(ne->ino) ||
-				nat_get_blkaddr(e) !=
-					le32_to_cpu(ne->block_addr) ||
+			nat_get_blkaddr(e) != le32_to_cpu(ne->block_addr) ||
 				nat_get_version(e) != ne->version);
+		return;
+	}
+	up_read(&nm_i->nat_tree_lock);
+#endif
+	e = grab_nat_entry(nm_i, nid, false);
+	down_write(&nm_i->nat_tree_lock);
+	if (!e)
+		goto out;
+
+	if (!radix_tree_insert(&nm_i->nat_root, nid, e)) {
+		list_add_tail(&e->list, &nm_i->nat_entries);
+		nm_i->nat_cnt++;
+		node_info_from_raw_nat(&e->ni, ne);
+	} else {
+		kmem_cache_free(nat_entry_slab, e);
 	}
+out:
+	up_write(&nm_i->nat_tree_lock);
 }
 
 static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
@@ -300,11 +307,21 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct nat_entry *e;
+	struct nat_entry *new = grab_nat_entry(nm_i, ni->nid, true);
 
+retry:
 	down_write(&nm_i->nat_tree_lock);
 	e = __lookup_nat_cache(nm_i, ni->nid);
 	if (!e) {
-		e = grab_nat_entry(nm_i, ni->nid, true);
+		e = new;
+		if (radix_tree_insert(&nm_i->nat_root, ni->nid, e)) {
+			up_write(&nm_i->nat_tree_lock);
+			cond_resched();
+			goto retry;
+		}
+
+		list_add_tail(&e->list, &nm_i->nat_entries);
+		nm_i->nat_cnt++;
 		copy_node_info(&e->ni, ni);
 		f2fs_bug_on(sbi, ni->blk_addr == NEW_ADDR);
 	} else if (new_blkaddr == NEW_ADDR) {
@@ -315,6 +332,9 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 		 */
 		copy_node_info(&e->ni, ni);
 		f2fs_bug_on(sbi, ni->blk_addr != NULL_ADDR);
+		kmem_cache_free(nat_entry_slab, new);
+	} else {
+		kmem_cache_free(nat_entry_slab, new);
 	}
 
 	/* sanity check */
@@ -424,9 +444,7 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
 	f2fs_put_page(page, 1);
 cache:
 	/* cache nat entry */
-	down_write(&nm_i->nat_tree_lock);
 	cache_nat_entry(sbi, nid, &ne);
-	up_write(&nm_i->nat_tree_lock);
 }
 
 /*
@@ -2375,6 +2393,9 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 		ne = __lookup_nat_cache(nm_i, nid);
 		if (!ne) {
 			ne = grab_nat_entry(nm_i, nid, true);
+			f2fs_radix_tree_insert(&nm_i->nat_root, nid, ne);
+			list_add_tail(&ne->list, &nm_i->nat_entries);
+			nm_i->nat_cnt++;
 			node_info_from_raw_nat(&ne->ni, &raw_ne);
 		}
 
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
