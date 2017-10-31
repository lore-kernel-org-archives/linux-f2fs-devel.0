From: Fan Li <fanofcode.li@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: modify the procedure of scan free nid
Date: Tue, 31 Oct 2017 21:37:24 +0800
Message-ID: <001401d3524d$7b411aa0$71c34fe0$@samsung.com>
References: <CGME20171031133806epcas2p3635a1d26726b94dd5f106d0171baaa74@epcas2p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Chao Yu' <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

In current version, we preserve 8 pages of nat blocks as free nids,
build bitmaps for it and use them to allocate nids until its number
drops below NAT_ENTRY_PER_BLOCK.

After that, we have a problem, scan_free_nid_bits will scan the same
8 pages trying to find more free nids, but in most cases the free nids
in these bitmaps are already in free list, scan them won't get us any
new nids.
Further more, after scan_free_nid_bits, the search is over if
nid_cnt[FREE_NID] != 0.
It causes that we scan the same pages over and over again, yet no new
free nids are found until nid_cnt[FREE_NID]==0.

This patch mark the range where new free nids could exist and keep scan
for free nids until nid_cnt[FREE_NID] >= NAT_ENTRY_PER_BLOCK.
The new vairable first_scan_block marks the start of the range, it's
initialized with NEW_ADDR, which means all free nids before next_scan_nid
are already in free list;
and use next_scan_nid as the end of the range since all free nids which
are scanned must be smaller next_scan_nid.


Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/node.c | 30 ++++++++++++++++++++++++++----
 2 files changed, 27 insertions(+), 4 deletions(-)

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
index 3d0d1be..7834097 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1950,10 +1950,23 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_journal *journal = curseg->journal;
 	unsigned int i, idx;
+	unsigned int max_blocks = NAT_BLOCK_OFFSET(nm_i->next_scan_nid);
 
-	down_read(&nm_i->nat_tree_lock);
+	/* every free nid in blocks scanned previously is in the free list */
+	if (nm_i->first_scan_block == NEW_ADDR)
+		return;
 
-	for (i = 0; i < nm_i->nat_blocks; i++) {
+	/*
+	 * TODO: "next_scan_nid == 0" means after searching every nat block,
+	 *       we still can't find enough free nids, there may not be any
+	 *       more nid left to be found, we should stop at somewhere
+	 *       instead of going through these all over again.
+	 */
+	if (max_blocks == 0)
+		max_blocks = nm_i->nat_blocks;
+
+	down_read(&nm_i->nat_tree_lock);
+	for (i = nm_i->first_scan_block; i < max_blocks; i++) {
 		if (!test_bit_le(i, nm_i->nat_block_bitmap))
 			continue;
 		if (!nm_i->free_nid_count[i])
@@ -1967,10 +1980,13 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
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
@@ -2010,7 +2026,7 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 		/* try to find free nids in free_nid_bitmap */
 		scan_free_nid_bits(sbi);
 
-		if (nm_i->nid_cnt[FREE_NID])
+		if (nm_i->nid_cnt[FREE_NID] >= NAT_ENTRY_PER_BLOCK)
 			return;
 	}
 
@@ -2163,6 +2179,7 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i, *next;
 	int nr = nr_shrink;
+	nid_t min_nid = nm_i->max_nid;
 
 	if (nm_i->nid_cnt[FREE_NID] <= MAX_FREE_NIDS)
 		return 0;
@@ -2176,11 +2193,15 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
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
@@ -2674,6 +2695,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	init_rwsem(&nm_i->nat_tree_lock);
 
 	nm_i->next_scan_nid = le32_to_cpu(sbi->ckpt->next_free_nid);
+	nm_i->first_scan_block = NEW_ADDR;
 	nm_i->bitmap_size = __bitmap_size(sbi, NAT_BITMAP);
 	version_bitmap = __bitmap_ptr(sbi, NAT_BITMAP);
 	if (!version_bitmap)
-- 
2.7.4
