From: "LiFan" <fanofcode.li@samsung.com>
Subject: [PATCH] f2fs: fix concurrent problem for updating free
 bitmap
Date: Mon, 13 Nov 2017 21:06:43 +0800
Message-ID: <006b01d35c80$6648c250$32da46f0$@samsung.com>
References: <CGME20171113130746epcas5p48964ff4d424b19d1de816bb7468957f2@epcas5p4.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <fanofcode.li@samsung.com>) id 1eEET1-0006OZ-IS
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 13 Nov 2017 13:07:59 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eEESy-0003YG-FR
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 13 Nov 2017 13:07:59 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20171113130749epoutp014c00c5491485d773437f02bbb356e4ee~2px07wjb50652406524epoutp01B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 13 Nov 2017 13:07:49 +0000 (GMT)
Content-Language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Chao Yu' <chao@kernel.org>, 'Chao Yu' <yuchao0@huawei.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

alloc_nid_failed and scan_nat_page can be called at the same time,
and we haven't protected add_free_nid and update_free_nid_bitmap
with the same nid_list_lock. That could lead to

Thread A				Thread B
- __build_free_nids
 - scan_nat_page				
  - add_free_nid
					- alloc_nid_failed
					 - update_free_nid_bitmap
  - update_free_nid_bitmap

scan_nat_page will clear the free bitmap since the nid is PREALLOC_NID,
but alloc_nid_failed needs to set the free bitmap. This results in
free nid with free bitmap cleared.
This patch update the bitmap under the same nid_list_lock in add_free_nid.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/node.c | 82
++++++++++++++++++++++++++++++----------------------------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b965a53..0a217d2 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1811,8 +1811,33 @@ static void __move_free_nid(struct f2fs_sb_info *sbi,
struct free_nid *i,
 	}
 }
 
+static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
+							bool set, bool
build)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	unsigned int nat_ofs = NAT_BLOCK_OFFSET(nid);
+	unsigned int nid_ofs = nid - START_NID(nid);
+
+	if (!test_bit_le(nat_ofs, nm_i->nat_block_bitmap))
+		return;
+
+	if (set) {
+		if (test_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]))
+			return;
+		__set_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
+		nm_i->free_nid_count[nat_ofs]++;
+	} else {
+		if (!test_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]))
+			return;
+		__clear_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
+		if (!build)
+			nm_i->free_nid_count[nat_ofs]--;
+	}
+}
+
 /* return if the nid is recognized as free */
-static bool add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
+static bool add_free_nid(struct f2fs_sb_info *sbi,
+				nid_t nid, bool build, bool update)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i, *e;
@@ -1870,6 +1895,11 @@ static bool add_free_nid(struct f2fs_sb_info *sbi,
nid_t nid, bool build)
 	ret = true;
 	err = __insert_free_nid(sbi, i, FREE_NID);
 err_out:
+	if (update) {
+		update_free_nid_bitmap(sbi, nid, ret, build);
+		if (!build)
+			nm_i->available_nids++;
+	}
 	spin_unlock(&nm_i->nid_list_lock);
 	radix_tree_preload_end();
 err:
@@ -1896,30 +1926,6 @@ static void remove_free_nid(struct f2fs_sb_info *sbi,
nid_t nid)
 		kmem_cache_free(free_nid_slab, i);
 }
 
-static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
-							bool set, bool
build)
-{
-	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	unsigned int nat_ofs = NAT_BLOCK_OFFSET(nid);
-	unsigned int nid_ofs = nid - START_NID(nid);
-
-	if (!test_bit_le(nat_ofs, nm_i->nat_block_bitmap))
-		return;
-
-	if (set) {
-		if (test_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]))
-			return;
-		__set_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
-		nm_i->free_nid_count[nat_ofs]++;
-	} else {
-		if (!test_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]))
-			return;
-		__clear_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
-		if (!build)
-			nm_i->free_nid_count[nat_ofs]--;
-	}
-}
-
 static void scan_nat_page(struct f2fs_sb_info *sbi,
 			struct page *nat_page, nid_t start_nid)
 {
@@ -1937,18 +1943,18 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
 	i = start_nid % NAT_ENTRY_PER_BLOCK;
 
 	for (; i < NAT_ENTRY_PER_BLOCK; i++, start_nid++) {
-		bool freed = false;
-
 		if (unlikely(start_nid >= nm_i->max_nid))
 			break;
 
 		blk_addr = le32_to_cpu(nat_blk->entries[i].block_addr);
 		f2fs_bug_on(sbi, blk_addr == NEW_ADDR);
-		if (blk_addr == NULL_ADDR)
-			freed = add_free_nid(sbi, start_nid, true);
-		spin_lock(&NM_I(sbi)->nid_list_lock);
-		update_free_nid_bitmap(sbi, start_nid, freed, true);
-		spin_unlock(&NM_I(sbi)->nid_list_lock);
+		if (blk_addr == NULL_ADDR) {
+			add_free_nid(sbi, start_nid, true, true);
+		} else {
+			spin_lock(&NM_I(sbi)->nid_list_lock);
+			update_free_nid_bitmap(sbi, start_nid, false, true);
+			spin_unlock(&NM_I(sbi)->nid_list_lock);
+		}
 	}
 }
 
@@ -1974,7 +1980,7 @@ static void scan_free_nid_bits(struct f2fs_sb_info
*sbi)
 				break;
 
 			nid = i * NAT_ENTRY_PER_BLOCK + idx;
-			add_free_nid(sbi, nid, true);
+			add_free_nid(sbi, nid, true, false);
 
 			if (nm_i->nid_cnt[FREE_NID] >= MAX_FREE_NIDS)
 				goto out;
@@ -1988,7 +1994,7 @@ static void scan_free_nid_bits(struct f2fs_sb_info
*sbi)
 		addr = le32_to_cpu(nat_in_journal(journal, i).block_addr);
 		nid = le32_to_cpu(nid_in_journal(journal, i));
 		if (addr == NULL_ADDR)
-			add_free_nid(sbi, nid, true);
+			add_free_nid(sbi, nid, true, false);
 		else
 			remove_free_nid(sbi, nid);
 	}
@@ -2053,7 +2059,7 @@ static void __build_free_nids(struct f2fs_sb_info
*sbi, bool sync, bool mount)
 		addr = le32_to_cpu(nat_in_journal(journal, i).block_addr);
 		nid = le32_to_cpu(nid_in_journal(journal, i));
 		if (addr == NULL_ADDR)
-			add_free_nid(sbi, nid, true);
+			add_free_nid(sbi, nid, true, false);
 		else
 			remove_free_nid(sbi, nid);
 	}
@@ -2499,11 +2505,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info
*sbi,
 		nat_reset_flag(ne);
 		__clear_nat_cache_dirty(NM_I(sbi), set, ne);
 		if (nat_get_blkaddr(ne) == NULL_ADDR) {
-			add_free_nid(sbi, nid, false);
-			spin_lock(&NM_I(sbi)->nid_list_lock);
-			NM_I(sbi)->available_nids++;
-			update_free_nid_bitmap(sbi, nid, true, false);
-			spin_unlock(&NM_I(sbi)->nid_list_lock);
+			add_free_nid(sbi, nid, false, true);
 		} else {
 			spin_lock(&NM_I(sbi)->nid_list_lock);
 			update_free_nid_bitmap(sbi, nid, false, false);
-- 
2.7.4



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
