From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: read ahead nat blocks && flush more
 continuous nat io
Date: Wed, 31 Jan 2018 15:32:18 +0800
Message-ID: <1517383938-21055-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1egn6o-0005ML-Gu
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Jan 2018 07:47:06 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1egn6m-00049Q-UW
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Jan 2018 07:47:06 +0000
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
Cc: heyunlei@huawei.com, Wei Fang <fangwei1@huawei.com>

This patch including two changes:
1. We introduce nat journal to cache nat blocks which has less
dirty nat entries, nat entry sets are ranked by dirty nat entry
count if the count less than NAT_JOURNAL_ENTRIES. This method
will break the continuity of nat blocks write back order, and
this patch make a change of that prior to flush continuous nat
blocks.

2. Add read ahead nat blocks in case of a lot of serial synchronized
read as below:

336.785911: f2fs_write_checkpoint: dev = (259,44), checkpoint for Sync, state = start flush nat
336.785980: flush_nat_entries: flush sum = 278 dirty nat pages
336.786002: f2fs_submit_page_bio: dev = (259,44), ino = 2, page_index = 0x129f, oldaddr = 0x129f, newaddr = 0x129f rw = READ_SYNC(MP), type = META
336.791681: f2fs_submit_page_bio: dev = (259,44), ino = 2, page_index = 0x148e, oldaddr = 0x148e, newaddr = 0x148e rw = READ_SYNC(MP), type = META
336.797802: f2fs_submit_page_bio: dev = (259,44), ino = 2, page_index = 0x1482, oldaddr = 0x1482, newaddr = 0x1482 rw = READ_SYNC(MP), type = META
336.799155: f2fs_submit_page_bio: dev = (259,44), ino = 2, page_index = 0x1481, oldaddr = 0x1481, newaddr = 0x1481 rw = READ_SYNC(MP), type = META
336.800603: f2fs_submit_page_bio: dev = (259,44), ino = 2, page_index = 0x147f, oldaddr = 0x147f, newaddr = 0x147f rw = READ_SYNC(MP), type = META
336.802102: f2fs_submit_page_bio: dev = (259,44), ino = 2, page_index = 0x147b, oldaddr = 0x147b, newaddr = 0x147b rw = READ_SYNC(MP), type = META
336.803528: f2fs_submit_page_bio: dev = (259,44), ino = 2, page_index = 0x1474, oldaddr = 0x1474, newaddr = 0x1474 rw = READ_SYNC(MP), type = META
336.805026: f2fs_submit_page_bio: dev = (259,44), ino = 2, page_index = 0x1455, oldaddr = 0x1455, newaddr = 0x1455 rw = READ_SYNC(MP), type = META
336.806537: f2fs_submit_page_bio: dev = (259,44), ino = 2, page_index = 0xc1e, oldaddr = 0xc1e, newaddr = 0xc1e rw = READ_SYNC(MP), type = META
336.807864: f2fs_submit_page_bio: dev = (259,44), ino = 2, page_index = 0x1307, oldaddr = 0x1307, newaddr = 0x1307 rw = READ_SYNC(MP), type = META
336.833539: f2fs_write_checkpoint: dev = (259,44), checkpoint for Sync, state = end flush nat

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Wei Fang <fangwei1@huawei.com>
---
 fs/f2fs/node.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/f2fs/node.h |  1 +
 2 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 833b46b..3b29fcb 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -209,6 +209,7 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
 		INIT_LIST_HEAD(&head->set_list);
 		head->set = set;
 		head->entry_cnt = 0;
+		head->continue_io = false;
 		f2fs_radix_tree_insert(&nm_i->nat_set_root, set, head);
 	}
 
@@ -2403,16 +2404,50 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 	up_write(&curseg->journal_rwsem);
 }
 
-static void __adjust_nat_entry_set(struct nat_entry_set *nes,
-						struct list_head *head, int max)
+static bool nat_block_is_continuous(struct f2fs_nm_info *nm_i,
+					struct nat_entry_set *nes)
+{
+	unsigned int nat_index = nes->set;
+	unsigned char bit_cur =
+		f2fs_test_bit(nat_index, nm_i->nat_bitmap) ? 1 : 0;
+
+	if (nat_index && radix_tree_lookup(&nm_i->nat_set_root, nat_index - 1)) {
+		unsigned char bit_pre =
+			f2fs_test_bit(nat_index - 1, nm_i->nat_bitmap) ? 1 : 0;
+
+		if (bit_pre == bit_cur) {
+			nes->continue_io = true;
+			return true;
+		}
+	}
+
+	if (nat_index < nm_i->nat_blocks &&
+			radix_tree_lookup(&nm_i->nat_set_root, nat_index + 1)) {
+		unsigned char bit_next =
+			f2fs_test_bit(nat_index + 1, nm_i->nat_bitmap) ? 1 : 0;
+
+		if (bit_next == bit_cur) {
+			nes->continue_io = true;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static void __adjust_nat_entry_set(struct f2fs_nm_info *nm_i,
+			struct nat_entry_set *nes, struct list_head *head, int max)
 {
 	struct nat_entry_set *cur;
 
 	if (nes->entry_cnt >= max)
 		goto add_out;
 
+	if (nat_block_is_continuous(nm_i, nes))
+		goto add_out;
+
 	list_for_each_entry(cur, head, set_list) {
-		if (cur->entry_cnt >= nes->entry_cnt) {
+		if (cur->entry_cnt >= nes->entry_cnt || cur->continue_io) {
 			list_add(&nes->set_list, cur->set_list.prev);
 			return;
 		}
@@ -2471,7 +2506,8 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	 * #2, flush nat entries to nat page.
 	 */
 	if (enabled_nat_bits(sbi, cpc) ||
-		!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))
+		!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL) ||
+		set->continue_io)
 		to_journal = false;
 
 	if (to_journal) {
@@ -2536,6 +2572,7 @@ void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct nat_entry_set *setvec[SETVEC_SIZE];
 	struct nat_entry_set *set, *tmp;
 	unsigned int found;
+	unsigned int nats_to_journal = 0;
 	nid_t set_idx = 0;
 	LIST_HEAD(sets);
 
@@ -2558,10 +2595,23 @@ void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		unsigned idx;
 		set_idx = setvec[found - 1]->set + 1;
 		for (idx = 0; idx < found; idx++)
-			__adjust_nat_entry_set(setvec[idx], &sets,
+			__adjust_nat_entry_set(nm_i, setvec[idx], &sets,
 						MAX_NAT_JENTRIES(journal));
 	}
 
+	list_for_each_entry_safe(set, tmp, &sets, set_list) {
+		block_t blk_addr;
+
+		nats_to_journal += set->entry_cnt;
+
+		if (nats_to_journal > NAT_JOURNAL_ENTRIES ||
+						set->continue_io) {
+			blk_addr = current_nat_addr(sbi,
+					set->set * NAT_ENTRY_PER_BLOCK);
+			ra_meta_pages(sbi, blk_addr, 1, META_NAT, true);
+		}
+	}
+
 	/* flush dirty nats in nat entry set */
 	list_for_each_entry_safe(set, tmp, &sets, set_list)
 		__flush_nat_entry_set(sbi, set, cpc);
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 081ef0d..91414de 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -149,6 +149,7 @@ struct nat_entry_set {
 	struct list_head entry_list;	/* link with dirty nat entries */
 	nid_t set;			/* set number*/
 	unsigned int entry_cnt;		/* the # of nat entries in set */
+	bool continue_io;
 };
 
 struct free_nid {
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
