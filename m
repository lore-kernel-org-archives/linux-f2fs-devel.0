From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 4/5] f2fs: avoid unnecessary to_journal checking
Date: Sat, 20 May 2017 12:24:34 +0000
Message-ID: <20170520122435.17574-5-houpengyang@huawei.com>
References: <20170520122435.17574-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1dC3RO-0006lU-Hk
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 20 May 2017 12:25:02 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dC3RN-0000a4-Af
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 20 May 2017 12:25:02 +0000
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

There is no need to do __has_cursem_space checking everytime, this patch fixes it.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/node.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 340c33d..58b4f7a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2373,25 +2373,15 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 }
 
 static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
-		struct nat_entry_set *set, struct cp_control *cpc)
+		struct nat_entry_set *set, struct cp_control *cpc, bool to_journal)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_journal *journal = curseg->journal;
 	nid_t start_nid = set->set * NAT_ENTRY_PER_BLOCK;
-	bool to_journal = true;
 	struct f2fs_nat_block *nat_blk;
 	struct nat_entry *ne, *cur;
 	struct page *page = NULL;
 
-	/*
-	 * there are two steps to flush nat entries:
-	 * #1, flush nat entries to journal in current hot data summary block.
-	 * #2, flush nat entries to nat page.
-	 */
-	if (enabled_nat_bits(sbi, cpc) ||
-		!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))
-		to_journal = false;
-
 	if (to_journal) {
 		down_write(&curseg->journal_rwsem);
 	} else {
@@ -2459,6 +2449,7 @@ void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_journal *journal = curseg->journal;
 	struct nat_entry_set *set, *tmp;
+	bool to_journal = true;
 	int i;
 	LIST_HEAD(sets);
 
@@ -2476,9 +2467,19 @@ void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		!__has_cursum_space(journal, nm_i->dirty_nat_cnt, NAT_JOURNAL))
 		remove_nats_in_journal(sbi);
 
+	/*
+	 * there are two steps to flush nat entries:
+	 * #1, flush nat entries to journal in current hot data summary block.
+	 * #2, flush nat entries to nat page.
+	 */
 	for (i = 0; i <= NAT_ENTRY_PER_BLOCK; i++) {
-		list_for_each_entry_safe(set, tmp, &nm_i->dirty_set[i], set_list)
-			__flush_nat_entry_set(sbi, set, cpc);
+		list_for_each_entry_safe(set, tmp, &nm_i->dirty_set[i], set_list) {
+			if (to_journal && (enabled_nat_bits(sbi, cpc) ||
+				!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL)))
+				to_journal = false;
+
+			__flush_nat_entry_set(sbi, set, cpc, to_journal);
+		}
 		f2fs_bug_on(sbi, !list_empty(&nm_i->dirty_set[i]));
 	}
 
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
