From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v2] f2fs: build free nid bitmap during flush nat
 entries
Date: Wed, 25 Apr 2018 15:44:28 +0800
Message-ID: <1524642268-10134-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1fBFKQ-0001Yf-Ld
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Apr 2018 07:59:02 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fBFKO-006YMK-Ef
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Apr 2018 07:59:02 +0000
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
Cc: zhangdianfang@huawei.com

This patch introduce free nid bitmap build during flush
nat entries in order to reduce synchronous read in the
process of build free nids.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/node.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f202398..681552b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1947,7 +1947,7 @@ static void remove_free_nid(struct f2fs_sb_info *sbi, nid_t nid)
 }
 
 static void scan_nat_page(struct f2fs_sb_info *sbi,
-			struct page *nat_page, nid_t start_nid)
+		struct page *nat_page, nid_t start_nid, bool in_build)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct f2fs_nat_block *nat_blk = page_address(nat_page);
@@ -1955,6 +1955,9 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
 	unsigned int nat_ofs = NAT_BLOCK_OFFSET(start_nid);
 	int i;
 
+	if (!test_bit_le(nat_ofs, nm_i->nat_block_bitmap))
+		return;
+
 	__set_bit_le(nat_ofs, nm_i->nat_block_bitmap);
 
 	i = start_nid % NAT_ENTRY_PER_BLOCK;
@@ -1966,7 +1969,8 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
 		blk_addr = le32_to_cpu(nat_blk->entries[i].block_addr);
 		f2fs_bug_on(sbi, blk_addr == NEW_ADDR);
 		if (blk_addr == NULL_ADDR) {
-			add_free_nid(sbi, start_nid, true, true);
+			if (in_build)
+				add_free_nid(sbi, start_nid, true, true);
 		} else {
 			spin_lock(&NM_I(sbi)->nid_list_lock);
 			update_free_nid_bitmap(sbi, start_nid, false, true);
@@ -2063,7 +2067,7 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 						nm_i->nat_block_bitmap)) {
 			struct page *page = get_current_nat_page(sbi, nid);
 
-			scan_nat_page(sbi, page, nid);
+			scan_nat_page(sbi, page, nid, true);
 			f2fs_put_page(page, 1);
 		}
 
@@ -2534,6 +2538,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	if (to_journal) {
 		up_write(&curseg->journal_rwsem);
 	} else {
+		scan_nat_page(sbi, page, start_nid, false);
 		__update_nat_bits(sbi, start_nid, page);
 		f2fs_put_page(page, 1);
 	}
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
