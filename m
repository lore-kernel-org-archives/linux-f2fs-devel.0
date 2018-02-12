From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH RFC] f2fs: introduce a method to make nat journal
 more fresh
Date: Mon, 12 Feb 2018 14:55:59 +0800
Message-ID: <1518418559-14996-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1el8Ga-0003ga-7a
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 12 Feb 2018 07:11:08 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1el8GX-0001wr-9Q
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 12 Feb 2018 07:11:08 +0000
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
Cc: heyunlei@huawei.com

This patch introduce a method to make nat journal more fresh:
i.  sort set list using entry # plus cp version difference (last modify
set cp # and current cp #)
ii. if meet with cache hit, update last modify cp # to current cp #

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/f2fs.h |  2 ++
 fs/f2fs/node.c | 57 +++++++++++++++++++++++++++++++++++++++++----------------
 fs/f2fs/node.h |  2 ++
 3 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b7ba496..bd1e775 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -297,6 +297,8 @@ struct fsync_inode_entry {
 	block_t last_dentry;	/* block address locating the last dentry */
 };
 
+#define DEF_NAT_FACTOR 10
+
 #define nats_in_cursum(jnl)		(le16_to_cpu((jnl)->n_nats))
 #define sits_in_cursum(jnl)		(le16_to_cpu((jnl)->n_sits))
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ced986d..f3f89e3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -195,8 +195,8 @@ static void __del_from_nat_cache(struct f2fs_nm_info *nm_i, struct nat_entry *e)
 	__free_nat_entry(e);
 }
 
-static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
-						struct nat_entry *ne)
+static void __set_nat_cache_dirty(struct f2fs_sb_info *sbi, bool from_journal,
+			struct f2fs_nm_info *nm_i, struct nat_entry *ne)
 {
 	nid_t set = NAT_BLOCK_OFFSET(ne->ni.nid);
 	struct nat_entry_set *head;
@@ -209,9 +209,15 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
 		INIT_LIST_HEAD(&head->set_list);
 		head->set = set;
 		head->entry_cnt = 0;
+		head->to_journal = false;
+		head->cp_ver = cur_cp_version(F2FS_CKPT(sbi));
 		f2fs_radix_tree_insert(&nm_i->nat_set_root, set, head);
 	}
 
+	/* journal hit case, try to locate set in journal */
+	if (head->to_journal && !from_journal)
+		head->cp_ver = cur_cp_version(F2FS_CKPT(sbi));
+
 	if (get_nat_flag(ne, IS_DIRTY))
 		goto refresh_list;
 
@@ -359,7 +365,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 	nat_set_blkaddr(e, new_blkaddr);
 	if (new_blkaddr == NEW_ADDR || new_blkaddr == NULL_ADDR)
 		set_nat_flag(e, IS_CHECKPOINTED, false);
-	__set_nat_cache_dirty(nm_i, e);
+	__set_nat_cache_dirty(sbi, false, nm_i, e);
 
 	/* update fsync_mark if its inode nat entry is still alive */
 	if (ni->nid != ni->ino)
@@ -2397,14 +2403,30 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 			spin_unlock(&nm_i->nid_list_lock);
 		}
 
-		__set_nat_cache_dirty(nm_i, ne);
+		__set_nat_cache_dirty(sbi, true, nm_i, ne);
 	}
 	update_nats_in_cursum(journal, -i);
 	up_write(&curseg->journal_rwsem);
 }
 
-static void __adjust_nat_entry_set(struct nat_entry_set *nes,
-						struct list_head *head, int max)
+static bool cost_compare(struct f2fs_sb_info *sbi,
+			struct nat_entry_set *nes, struct nat_entry_set * cur)
+{
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	__u64 cost1 = nes->entry_cnt * DEF_NAT_FACTOR +
+			(nes->cp_ver <= cur_cp_version(ckpt)) ?
+			cur_cp_version(ckpt) - nes->cp_ver :
+			ULONG_MAX - nes->cp_ver + cur_cp_version(ckpt);
+	__u64 cost2 = cur->entry_cnt * DEF_NAT_FACTOR +
+			(cur->cp_ver <= cur_cp_version(ckpt)) ?
+			cur_cp_version(ckpt) - cur->cp_ver :
+			ULONG_MAX - cur->cp_ver + cur_cp_version(ckpt);
+
+	return cost1 <= cost2;
+}
+
+static void __adjust_nat_entry_set(struct f2fs_sb_info *sbi,
+			struct nat_entry_set *nes, struct list_head *head, int max)
 {
 	struct nat_entry_set *cur;
 
@@ -2412,7 +2434,7 @@ static void __adjust_nat_entry_set(struct nat_entry_set *nes,
 		goto add_out;
 
 	list_for_each_entry(cur, head, set_list) {
-		if (cur->entry_cnt >= nes->entry_cnt) {
+		if (cost_compare(sbi, nes, cur)) {
 			list_add(&nes->set_list, cur->set_list.prev);
 			return;
 		}
@@ -2460,7 +2482,6 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_journal *journal = curseg->journal;
 	nid_t start_nid = set->set * NAT_ENTRY_PER_BLOCK;
-	bool to_journal = true;
 	struct f2fs_nat_block *nat_blk;
 	struct nat_entry *ne, *cur;
 	struct page *page = NULL;
@@ -2470,11 +2491,13 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	 * #1, flush nat entries to journal in current hot data summary block.
 	 * #2, flush nat entries to nat page.
 	 */
+	set->to_journal = true;
+
 	if (enabled_nat_bits(sbi, cpc) ||
 		!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))
-		to_journal = false;
+		set->to_journal = false;
 
-	if (to_journal) {
+	if (set->to_journal) {
 		down_write(&curseg->journal_rwsem);
 	} else {
 		page = get_next_nat_page(sbi, start_nid);
@@ -2490,7 +2513,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 
 		f2fs_bug_on(sbi, nat_get_blkaddr(ne) == NEW_ADDR);
 
-		if (to_journal) {
+		if (set->to_journal) {
 			offset = lookup_journal_in_cursum(journal,
 							NAT_JOURNAL, nid, 1);
 			f2fs_bug_on(sbi, offset < 0);
@@ -2511,17 +2534,19 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 		}
 	}
 
-	if (to_journal) {
+	if (set->to_journal) {
 		up_write(&curseg->journal_rwsem);
 	} else {
 		__update_nat_bits(sbi, start_nid, page);
 		f2fs_put_page(page, 1);
 	}
 
-	/* Allow dirty nats by node block allocation in write_begin */
+	if (!set->to_journal || cpc->reason & CP_UMOUNT) {
+		radix_tree_delete(&NM_I(sbi)->nat_set_root, set->set);
+		kmem_cache_free(nat_entry_set_slab, set);
+	}
+
 	f2fs_bug_on(sbi, set->entry_cnt);
-	radix_tree_delete(&NM_I(sbi)->nat_set_root, set->set);
-	kmem_cache_free(nat_entry_set_slab, set);
 }
 
 /*
@@ -2557,7 +2582,7 @@ void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		unsigned idx;
 		set_idx = setvec[found - 1]->set + 1;
 		for (idx = 0; idx < found; idx++)
-			__adjust_nat_entry_set(setvec[idx], &sets,
+			__adjust_nat_entry_set(sbi, setvec[idx], &sets,
 						MAX_NAT_JENTRIES(journal));
 	}
 
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 081ef0d..aba5ada 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -149,6 +149,8 @@ struct nat_entry_set {
 	struct list_head entry_list;	/* link with dirty nat entries */
 	nid_t set;			/* set number*/
 	unsigned int entry_cnt;		/* the # of nat entries in set */
+	__u64 cp_ver; 			/* cp version of this set modify */
+	bool to_journal;		/* set flush to journal */
 };
 
 struct free_nid {
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
