From: "LiFan" <fanofcode.li@samsung.com>
Subject: [PATCH RESEND v3] f2fs: fix concurrent problem for
 updating free bitmap
Date: Wed, 22 Nov 2017 16:07:23 +0800
Message-ID: <001501d36369$0bb9d3c0$232d7b40$@samsung.com>
References: <CGME20171122080814epcas5p4694a196adb1a55eeb8ac086ca0aace05@epcas5p4.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <fanofcode.li@samsung.com>) id 1eHQ53-0003lQ-Mm
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Nov 2017 08:08:25 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eHQ50-0002E0-Ty
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Nov 2017 08:08:25 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20171122080815epoutp0386f8b87413d1c2c308710e4d8746cc0e~5Wf2WL_dc2807028070epoutp03V
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 22 Nov 2017 08:08:15 +0000 (GMT)
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
To: 'Chao Yu' <yuchao0@huawei.com>, 'Chao Yu' <chao@kernel.org>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
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
And use __GFP_NOFAIL to make sure to update status of free nid correctly.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/node.c | 85 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 43 insertions(+), 42 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fe1fc66..8d5a06b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1831,8 +1831,33 @@ static void __move_free_nid(struct f2fs_sb_info *sbi, struct free_nid *i,
 	}
 }
 
+static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
+							bool set, bool build)
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
@@ -1848,8 +1873,7 @@ static bool add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 	i->nid = nid;
 	i->state = FREE_NID;
 
-	if (radix_tree_preload(GFP_NOFS))
-		goto err;
+	radix_tree_preload(GFP_NOFS | __GFP_NOFAIL);
 
 	spin_lock(&nm_i->nid_list_lock);
 
@@ -1890,9 +1914,14 @@ static bool add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
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
-err:
+
 	if (err)
 		kmem_cache_free(free_nid_slab, i);
 	return ret;
@@ -1916,30 +1945,6 @@ static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
 		kmem_cache_free(free_nid_slab, i);
 }
 
-static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
-							bool set, bool build)
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
@@ -1957,18 +1962,18 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
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
 
@@ -1986,7 +1991,7 @@ static void scan_curseg_cache(struct f2fs_sb_info *sbi)
 		addr = le32_to_cpu(nat_in_journal(journal, i).block_addr);
 		nid = le32_to_cpu(nid_in_journal(journal, i));
 		if (addr == NULL_ADDR)
-			add_free_nid(sbi, nid, true);
+			add_free_nid(sbi, nid, true, false);
 		else
 			remove_free_nid(sbi, nid);
 	}
@@ -2013,7 +2018,7 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
 				break;
 
 			nid = i * NAT_ENTRY_PER_BLOCK + idx;
-			add_free_nid(sbi, nid, true);
+			add_free_nid(sbi, nid, true, false);
 
 			if (nm_i->nid_cnt[FREE_NID] >= MAX_FREE_NIDS)
 				goto out;
@@ -2516,11 +2521,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
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
