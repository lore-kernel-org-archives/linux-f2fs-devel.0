From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/4] f2fs: don't track newly allocated nat entry
 in list
Date: Mon, 5 Jun 2017 18:29:08 +0800
Message-ID: <20170605102909.57625-3-yuchao0@huawei.com>
References: <20170605102909.57625-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1dHpGx-0004Qw-4x
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Jun 2017 10:30:07 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dHpGw-0001uU-5S
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Jun 2017 10:30:07 +0000
In-Reply-To: <20170605102909.57625-1-yuchao0@huawei.com>
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We will never persist newly allocated nat entries during checkpoint(), so
we don't need to track such nat entries in nat dirty list in order to
avoid:
- more latency during traversing dirty list;
- sorting nat sets incorrectly due to recording wrong entry_cnt in nat
entry set.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d22db8ce0a69..05700e54f91e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -158,9 +158,6 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
 	nid_t set = NAT_BLOCK_OFFSET(ne->ni.nid);
 	struct nat_entry_set *head;
 
-	if (get_nat_flag(ne, IS_DIRTY))
-		return;
-
 	head = radix_tree_lookup(&nm_i->nat_set_root, set);
 	if (!head) {
 		head = f2fs_kmem_cache_alloc(nat_entry_set_slab, GFP_NOFS);
@@ -171,10 +168,18 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
 		head->entry_cnt = 0;
 		f2fs_radix_tree_insert(&nm_i->nat_set_root, set, head);
 	}
-	list_move_tail(&ne->list, &head->entry_list);
+
+	if (get_nat_flag(ne, IS_DIRTY))
+		goto refresh_list;
+
 	nm_i->dirty_nat_cnt++;
 	head->entry_cnt++;
 	set_nat_flag(ne, IS_DIRTY, true);
+refresh_list:
+	if (nat_get_blkaddr(ne) == NEW_ADDR)
+		list_del_init(&ne->list);
+	else
+		list_move_tail(&ne->list, &head->entry_list);
 }
 
 static void __clear_nat_cache_dirty(struct f2fs_nm_info *nm_i,
@@ -2423,8 +2428,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 		nid_t nid = nat_get_nid(ne);
 		int offset;
 
-		if (nat_get_blkaddr(ne) == NEW_ADDR)
-			continue;
+		f2fs_bug_on(sbi, nat_get_blkaddr(ne) == NEW_ADDR);
 
 		if (to_journal) {
 			offset = lookup_journal_in_cursum(journal,
-- 
2.13.0.67.g10c78a162fa8


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
