From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH RESEND] f2fs: modify the procedure of scan free
 nid
Date: Fri, 03 Nov 2017 15:31:12 +0800
Message-ID: <001101d35475$f33d8b40$d9b8a1c0$@samsung.com>
References: <CGME20171103073249epcas1p4a6e7f7875d21ec575efd593c3b5bd970@epcas1p4.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <fanofcode.li@samsung.com>)
 id 1eAWTM-00037u-NN
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Nov 2017 07:33:00 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1eAWTK-0005wE-0P
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Nov 2017 07:33:00 +0000
Content-language: en-us
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Chao Yu' <chao@kernel.org>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In current version, we preserve 8 pages of nat blocks as free nids,
we build bitmaps for it and use them to allocate nids until its number
drops below NAT_ENTRY_PER_BLOCK.

After that, we have a problem, scan_free_nid_bits will scan the same
8 pages trying to find more free nids, but in most cases the free nids
in these bitmaps are already in free list, scan them won't get us any
new nids.
Further more, after scan_free_nid_bits, the scan is over if
nid_cnt[FREE_NID] != 0.
It causes that we scan the same pages over and over again, and no new
free nids are found until nid_cnt[FREE_NID]==0. While the scanned pages
increase, the problem grows worse.

This patch mark the range where new free nids could exist and keep scan
for free nids until nid_cnt[FREE_NID] >= NAT_ENTRY_PER_BLOCK.
The new vairable first_scan_block marks the start of the range, it's
initialized with NEW_ADDR, which means all free nids before next_scan_nid
are already in free list;
and use next_scan_nid as the end of the range since all free nids which
are scanned in scan_free_nid_bits must be smaller next_scan_nid.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/node.c | 42 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e0ef31c..ae1cf91 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -705,6 +705,7 @@ struct f2fs_nm_info {
 	nid_t max_nid;			/* maximum possible node ids */
 	nid_t available_nids;		/* # of available node ids */
 	nid_t next_scan_nid;		/* the next nid to be scanned */
+	block_t first_scan_block;       /* the first NAT block to be scanned */
 	unsigned int ram_thresh;	/* control the memory footprint */
 	unsigned int ra_nid_pages;	/* # of nid pages to be readaheaded */
 	unsigned int dirty_nats_ratio;	/* control dirty nats ratio threshold */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3d0d1be..f921e0c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1812,7 +1812,7 @@ static bool add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i, *e;
 	struct nat_entry *ne;
-	int err = -EINVAL;
+	int need_free = 1;
 	bool ret = false;
 
 	/* 0 nid should not be used */
@@ -1863,13 +1863,25 @@ static bool add_free_nid(struct f2fs_sb_info *sbi, nid_t nid, bool build)
 		}
 	}
 	ret = true;
-	err = __insert_free_nid(sbi, i, FREE_NID);
+	need_free = __insert_free_nid(sbi, i, FREE_NID);
 err_out:
 	spin_unlock(&nm_i->nid_list_lock);
 	radix_tree_preload_end();
 err:
-	if (err)
+	if (need_free)
 		kmem_cache_free(free_nid_slab, i);
+	/*
+	 * For nid that should be free but not in the free
+	 * structure, update the scan range in hope of adding
+	 * it in the next scan.
+	 */
+	if (!ret || need_free < 0) {
+		block_t tmp_block = NAT_BLOCK_OFFSET(nid);
+
+		if (tmp_block < nm_i->first_scan_block)
+			nm_i->first_scan_block = tmp_block;
+	}
+
 	return ret;
 }
 
@@ -1950,10 +1962,17 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_journal *journal = curseg->journal;
 	unsigned int i, idx;
+	unsigned int max_blocks = NAT_BLOCK_OFFSET(nm_i->next_scan_nid);
 
-	down_read(&nm_i->nat_tree_lock);
+	/* every free nid in blocks scanned previously is in the free list */
+	if (nm_i->first_scan_block == NEW_ADDR)
+		return;
 
-	for (i = 0; i < nm_i->nat_blocks; i++) {
+	if (max_blocks == 0)
+		max_blocks = nm_i->nat_blocks;
+
+	down_read(&nm_i->nat_tree_lock);
+	for (i = nm_i->first_scan_block; i < max_blocks; i++) {
 		if (!test_bit_le(i, nm_i->nat_block_bitmap))
 			continue;
 		if (!nm_i->free_nid_count[i])
@@ -1967,10 +1986,13 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
 			nid = i * NAT_ENTRY_PER_BLOCK + idx;
 			add_free_nid(sbi, nid, true);
 
-			if (nm_i->nid_cnt[FREE_NID] >= MAX_FREE_NIDS)
+			if (nm_i->nid_cnt[FREE_NID] >= MAX_FREE_NIDS) {
+				nm_i->first_scan_block = i;
 				goto out;
+			}
 		}
 	}
+	nm_i->first_scan_block = NEW_ADDR;
 out:
 	down_read(&curseg->journal_rwsem);
 	for (i = 0; i < nats_in_cursum(journal); i++) {
@@ -2010,7 +2032,7 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 		/* try to find free nids in free_nid_bitmap */
 		scan_free_nid_bits(sbi);
 
-		if (nm_i->nid_cnt[FREE_NID])
+		if (nm_i->nid_cnt[FREE_NID] >= NAT_ENTRY_PER_BLOCK)
 			return;
 	}
 
@@ -2163,6 +2185,7 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i, *next;
 	int nr = nr_shrink;
+	nid_t min_nid = nm_i->max_nid;
 
 	if (nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
 		return 0;
@@ -2176,11 +2199,15 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 				nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
 			break;
 
+		if (i->nid < min_nid)
+			min_nid = i->nid;
 		__remove_free_nid(sbi, i, FREE_NID);
 		kmem_cache_free(free_nid_slab, i);
 		nr_shrink--;
 	}
 	spin_unlock(&nm_i->nid_list_lock);
+	if (min_nid != nm_i->max_nid)
+		nm_i->first_scan_block = NAT_BLOCK_OFFSET(min_nid);
 	mutex_unlock(&nm_i->build_lock);
 
 	return nr - nr_shrink;
@@ -2674,6 +2701,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	init_rwsem(&nm_i->nat_tree_lock);
 
 	nm_i->next_scan_nid = le32_to_cpu(sbi->ckpt->next_free_nid);
+	nm_i->first_scan_block = NEW_ADDR;
 	nm_i->bitmap_size = __bitmap_size(sbi, NAT_BITMAP);
 	version_bitmap = __bitmap_ptr(sbi, NAT_BITMAP);
 	if (!version_bitmap)
-- 
2.7.4



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
