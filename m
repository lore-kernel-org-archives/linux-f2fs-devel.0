From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 1/5] f2fs: use bucket sort to avoid tree lookup
	and list sort when nat flushing
Date: Sat, 20 May 2017 12:24:31 +0000
Message-ID: <20170520122435.17574-2-houpengyang@huawei.com>
References: <20170520122435.17574-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1dC3RL-0005kj-LK
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 20 May 2017 12:24:59 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dC3RJ-0000ZN-03
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 20 May 2017 12:24:59 +0000
In-Reply-To: <20170520122435.17574-1-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, chao@kernel.org, miaoxie@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

during flush_nat_entries, we do: 
1) gang_lookup a radix tree, find all the dirty nat_entry_set;
2) sort nat_entry_set by nat_entry_set->entry_cnt, in order to 
    write to journal as much as possible to avoid unnessary IO. 

This patch optimize the look_up & sort algorithm by introducing an array:

    f2fs_nm_info->dirty_set[NAT_ENTRY_PER_BLOCK+1];
    (struct list_head dirty_set[NAT_ENTRY_PER_BLOCK + 1]) 

dirty_set[1] links all nat_entry_set whose entry_cnt is 1
dirty_set[2] links all nat_entry_set whose entry_cnt is 2
......
dirty_set[N] links all nat_entry_set whose entry_cnt is N

as one NAT block has NAT_ENTRY_PER_BLOCK entries at MOST, so there should NOT 
be one nat_entry_set whose entry_cnt is larger than NAT_ENTRY_PER_BLOCK.

So it is enough for f2fs_nm_info->dirty_set to link all nat_entry_sets in system.

Update:
    we update nat_entry_set in real-time, e.g originally nat_entry_set->entry_cnt is
1, and licked by dirty_set[1]; then call __set_nat_cache_dirty to increase nat_entry'sentry_cnt, we move this nat_entry_set ot dirty_set[2]'s tail, no need to compare.

Flush:
    when flush dirty nat_entry_set, we just flush nat_entry_set from
f2fs_nm_info->dirty_set[0] to f2fs_nm_info->dirty_set[NAT_ENTRY_PER_BLOCK], where
gang_lookup and sort can be avoid.
    
footprint of this algorithm:  sizeof(struct list_head)*NAT_ENTRY_PER_BLOCK
                              = 8*455 = 3.6k bytes

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/f2fs.h |  2 ++
 fs/f2fs/node.c | 56 ++++++++++++++++++++++----------------------------------
 2 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 093d68a..88a96bb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -628,6 +628,8 @@ struct f2fs_nm_info {
 
 	/* for checkpoint */
 	char *nat_bitmap;		/* NAT bitmap pointer */
+	/* list dirty_set whose */
+	struct list_head dirty_set[NAT_ENTRY_PER_BLOCK + 1]; /* for */
 
 	unsigned int nat_bits_blocks;	/* # of nat bits blocks */
 	unsigned char *nat_bits;	/* NAT bits blocks */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d22db8c..340c33d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -174,13 +174,14 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
 	list_move_tail(&ne->list, &head->entry_list);
 	nm_i->dirty_nat_cnt++;
 	head->entry_cnt++;
+	list_move_tail(&head->set_list, &(nm_i->dirty_set[head->entry_cnt]));
 	set_nat_flag(ne, IS_DIRTY, true);
 }
 
 static void __clear_nat_cache_dirty(struct f2fs_nm_info *nm_i,
 		struct nat_entry_set *set, struct nat_entry *ne)
 {
-	list_move_tail(&ne->list, &nm_i->nat_entries);
+	list_move_tail(&ne->list, &nm_i->nat_entries); /* to be shrinked */
 	set_nat_flag(ne, IS_DIRTY, false);
 	set->entry_cnt--;
 	nm_i->dirty_nat_cnt--;
@@ -2340,24 +2341,6 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 	up_write(&curseg->journal_rwsem);
 }
 
-static void __adjust_nat_entry_set(struct nat_entry_set *nes,
-						struct list_head *head, int max)
-{
-	struct nat_entry_set *cur;
-
-	if (nes->entry_cnt >= max)
-		goto add_out;
-
-	list_for_each_entry(cur, head, set_list) {
-		if (cur->entry_cnt >= nes->entry_cnt) {
-			list_add(&nes->set_list, cur->set_list.prev);
-			return;
-		}
-	}
-add_out:
-	list_add_tail(&nes->set_list, head);
-}
-
 static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 						struct page *page)
 {
@@ -2460,9 +2443,11 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 
 	/* Allow dirty nats by node block allocation in write_begin */
 	if (!set->entry_cnt) {
+		list_del(&set->set_list);
 		radix_tree_delete(&NM_I(sbi)->nat_set_root, set->set);
 		kmem_cache_free(nat_entry_set_slab, set);
-	}
+	} else
+		f2fs_bug_on(sbi, 1);
 }
 
 /*
@@ -2473,10 +2458,8 @@ void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_journal *journal = curseg->journal;
-	struct nat_entry_set *setvec[SETVEC_SIZE];
 	struct nat_entry_set *set, *tmp;
-	unsigned int found;
-	nid_t set_idx = 0;
+	int i;
 	LIST_HEAD(sets);
 
 	if (!nm_i->dirty_nat_cnt)
@@ -2493,19 +2476,12 @@ void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		!__has_cursum_space(journal, nm_i->dirty_nat_cnt, NAT_JOURNAL))
 		remove_nats_in_journal(sbi);
 
-	while ((found = __gang_lookup_nat_set(nm_i,
-					set_idx, SETVEC_SIZE, setvec))) {
-		unsigned idx;
-		set_idx = setvec[found - 1]->set + 1;
-		for (idx = 0; idx < found; idx++)
-			__adjust_nat_entry_set(setvec[idx], &sets,
-						MAX_NAT_JENTRIES(journal));
+	for (i = 0; i <= NAT_ENTRY_PER_BLOCK; i++) {
+		list_for_each_entry_safe(set, tmp, &nm_i->dirty_set[i], set_list)
+			__flush_nat_entry_set(sbi, set, cpc);
+		f2fs_bug_on(sbi, !list_empty(&nm_i->dirty_set[i]));
 	}
 
-	/* flush dirty nats in nat entry set */
-	list_for_each_entry_safe(set, tmp, &sets, set_list)
-		__flush_nat_entry_set(sbi, set, cpc);
-
 	up_write(&nm_i->nat_tree_lock);
 	/* Allow dirty nats by node block allocation in write_begin */
 }
@@ -2668,6 +2644,15 @@ static int init_free_nid_cache(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
+static void init_dirty_set_list(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	int i;
+
+	for (i = 0; i <= NAT_ENTRY_PER_BLOCK; i++)
+		INIT_LIST_HEAD(&nm_i->dirty_set[i]);
+}
+
 int build_node_manager(struct f2fs_sb_info *sbi)
 {
 	int err;
@@ -2687,6 +2672,9 @@ int build_node_manager(struct f2fs_sb_info *sbi)
 	/* load free nid status from nat_bits table */
 	load_free_nid_bitmap(sbi);
 
+	/* init dirty set list */
+	init_dirty_set_list(sbi);
+
 	build_free_nids(sbi, true, true);
 	return 0;
 }
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
