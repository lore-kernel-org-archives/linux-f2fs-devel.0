From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] f2fs: drop duplicate radix tree lookup of
	nat_entry_set
Date: Tue, 28 Feb 2017 21:34:47 +0800
Message-ID: <b05202cc-286f-4a1a-99b9-f9c4756c2248@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cihvj-0001ze-0S
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Feb 2017 13:35:03 +0000
Received: from mail-io0-f195.google.com ([209.85.223.195])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cihvi-0003RM-AY
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Feb 2017 13:35:02 +0000
Received: by mail-io0-f195.google.com with SMTP id f84so1424690ioj.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 28 Feb 2017 05:35:02 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

The nat entry is listed from the set list for freeing, 
it's duplicate to do radix tree lookup again.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/node.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b3aead4..a0854d3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -177,18 +177,13 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
 }
 
 static void __clear_nat_cache_dirty(struct f2fs_nm_info *nm_i,
-						struct nat_entry *ne)
+		struct nat_entry_set *set, struct nat_entry *ne)
 {
-	nid_t set = NAT_BLOCK_OFFSET(ne->ni.nid);
-	struct nat_entry_set *head;
-
-	head = radix_tree_lookup(&nm_i->nat_set_root, set);
-	if (head) {
-		list_move_tail(&ne->list, &nm_i->nat_entries);
-		set_nat_flag(ne, IS_DIRTY, false);
-		head->entry_cnt--;
-		nm_i->dirty_nat_cnt--;
-	}
+	f2fs_bug_on(sbi, set == NULL);
+	list_move_tail(&ne->list, &nm_i->nat_entries);
+	set_nat_flag(ne, IS_DIRTY, false);
+	set->entry_cnt--;
+	nm_i->dirty_nat_cnt--;
 }
 
 static unsigned int __gang_lookup_nat_set(struct f2fs_nm_info *nm_i,
@@ -2462,7 +2457,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 		}
 		raw_nat_from_node_info(raw_ne, &ne->ni);
 		nat_reset_flag(ne);
-		__clear_nat_cache_dirty(NM_I(sbi), ne);
+		__clear_nat_cache_dirty(NM_I(sbi), set, ne);
 		if (nat_get_blkaddr(ne) == NULL_ADDR) {
 			add_free_nid(sbi, nid, false);
 			spin_lock(&NM_I(sbi)->nid_list_lock);
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
