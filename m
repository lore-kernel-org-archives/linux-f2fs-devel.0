From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: refactor __build_free_nids
Date: Thu, 30 Nov 2017 19:32:10 +0800
Message-ID: <20171130113211.62990-2-yuchao0@huawei.com>
References: <20171130113211.62990-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eKN53-0005FR-1M
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:32:37 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eKN4z-0000t6-SP
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:32:36 +0000
In-Reply-To: <20171130113211.62990-1-yuchao0@huawei.com>
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Previously, in __build_free_nids we try to load bitmap from
next_scan_nid pointed NAT block, but actually, due to nat_bits
bitmap, current NAT blocks readed can be already ran out, so
it makes __build_free_nids low efficiency.

This patch refactors __build_free_nids a bit to search
nat_block_bitmap first to find out which NAT blocks have not been
loaded yet, and then do loading bitmaps.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 54 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4c758747980c..fb52622727ea 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1865,13 +1865,13 @@ static void scan_curseg_cache(struct f2fs_sb_info *sbi, nid_t start_nid,
 	up_read(&curseg->journal_rwsem);
 }
 
-static void scan_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
+static void scan_nat_page(struct f2fs_sb_info *sbi, unsigned int nat_ofs)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct page *page;
 	struct f2fs_nat_block *nat_blk;
 	block_t blk_addr;
-	unsigned int nat_ofs = NAT_BLOCK_OFFSET(nid);
+	nid_t nid = nat_ofs * NAT_ENTRY_PER_BLOCK;
 	nid_t start_nid = nid;
 	int i;
 
@@ -1935,37 +1935,51 @@ static nid_t lookup_free_nid_bitmap(struct f2fs_sb_info *sbi)
 static void __build_free_nids(struct f2fs_sb_info *sbi, bool mount)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
-	int i = 0;
-	nid_t nid = nm_i->next_scan_nid;
+	unsigned int pos, start, end, max_cnt = nm_i->nat_blocks;
+	bool sync_ra = true;
 
-	if (unlikely(nid >= nm_i->max_nid))
-		nid = 0;
+	if (unlikely(nm_i->next_scan_nid >= nm_i->max_nid))
+		nm_i->next_scan_nid = 0;
 
 	/* Enough entries */
 	if (!mount && nm_i->available_free_nids >= NAT_ENTRY_PER_BLOCK)
 		return;
 
-	/* readahead nat pages to be scanned */
-	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), FREE_NID_PAGES,
-							META_NAT, true);
+	start = NAT_BLOCK_OFFSET(nm_i->next_scan_nid);
 
-	down_read(&nm_i->nat_tree_lock);
+readahead:
+	/* search unloaded bitmap in range of [start, max] */
+	pos = find_next_zero_bit_le(nm_i->nat_block_bitmap, max_cnt, start);
+	if (pos >= max_cnt) {
+		if (!start)
+			return;
+		/* search unloaded bitmap in range of [0, start] */
+		pos = find_next_zero_bit_le(nm_i->nat_block_bitmap, start, 0);
+		if (pos >= start)
+			return;
+	}
 
-	do {
-		scan_nat_page(sbi, nid);
+	end = find_next_bit_le(nm_i->nat_block_bitmap, max_cnt, pos);
+	end = min(end, start + FREE_NID_PAGES);
 
-		nid += (NAT_ENTRY_PER_BLOCK - (nid % NAT_ENTRY_PER_BLOCK));
-		if (unlikely(nid >= nm_i->max_nid))
-			nid = 0;
-	} while (++i < FREE_NID_PAGES);
+	/* readahead nat pages to be scanned */
+	ra_meta_pages(sbi, pos, end - pos, META_NAT, sync_ra);
 
-	/* go to the next free nat pages to find free nids abundantly */
-	nm_i->next_scan_nid = nid;
+	if (!sync_ra)
+		return;
 
+	down_read(&nm_i->nat_tree_lock);
+	for (; pos < end; pos++)
+		scan_nat_page(sbi, pos);
 	up_read(&nm_i->nat_tree_lock);
 
-	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nm_i->next_scan_nid),
-					nm_i->ra_nid_pages, META_NAT, false);
+	/* go to the next free nat pages to find free nids abundantly */
+	nm_i->next_scan_nid = end * NAT_ENTRY_PER_BLOCK;
+
+	/* do async readahead for continual nid allocation */
+	start = NAT_BLOCK_OFFSET(nm_i->next_scan_nid);
+	sync_ra = false;
+	goto readahead;
 }
 
 void build_free_nids(struct f2fs_sb_info *sbi, bool mount)
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
