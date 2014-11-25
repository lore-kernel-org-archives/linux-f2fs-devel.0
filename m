From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH 1/2] f2fs:  check dirty_nat_cnt before flushing nat entries in
 journal
Date: Tue, 25 Nov 2014 12:44:23 +0900
Message-ID: <1416887064-21207-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

It's meaningless to check dirty_nat_cnt after re-dirtying nat entries in
journal. And although there are rooms for dirty nat entires if dirty_nat_cnt
is zero, it's also meaningless to check __has_cursum_space.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/node.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index dbf49cc..f6bd222 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -171,7 +171,7 @@ retry:
 static void __clear_nat_cache_dirty(struct f2fs_nm_info *nm_i,
 						struct nat_entry *ne)
 {
-	nid_t set = ne->ni.nid / NAT_ENTRY_PER_BLOCK;
+	nid_t set = NAT_BLOCK_OFFSET(ne->ni.nid);
 	struct nat_entry_set *head;
 
 	head = radix_tree_lookup(&nm_i->nat_set_root, set);
@@ -1945,6 +1945,8 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
 	nid_t set_idx = 0;
 	LIST_HEAD(sets);
 
+	if (!nm_i->dirty_nat_cnt)
+		return;
 	/*
 	 * if there are no enough space in journal to store dirty nat
 	 * entries, remove all entries from journal and merge them
@@ -1953,9 +1955,6 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
 	if (!__has_cursum_space(sum, nm_i->dirty_nat_cnt, NAT_JOURNAL))
 		remove_nats_in_journal(sbi);
 
-	if (!nm_i->dirty_nat_cnt)
-		return;
-
 	while ((found = __gang_lookup_nat_set(nm_i,
 					set_idx, NATVEC_SIZE, setvec))) {
 		unsigned idx;
-- 
1.9.1

