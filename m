From: Fan Li <fanofcode.li@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: optimize the way of traversing
 free_nid_bitmap
Date: Tue, 07 Nov 2017 19:14:24 +0800
Message-ID: <002201d357b9$adf558a0$09e009e0$@samsung.com>
References: <CGME20171107111512epcas2p2bb846cc19c3d8fa6f2858874183c446c@epcas2p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: 'Chao Yu' <chao@kernel.org>, 'Chao Yu' <yuchao0@huawei.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

We call scan_free_nid_bits only when there isn't many
free nids left, it means that marked bits in free_nid_bitmap
are supposed to be few, use find_next_bit_le is more
efficient in such case.
According to my tests, use find_next_bit_le instead of
test_bit_le will cut down the traversal time to one
third of its original.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/node.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fef5c68..d234c6e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1955,6 +1955,7 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_journal *journal = curseg->journal;
 	unsigned int i, idx;
+	nid_t nid;
 
 	down_read(&nm_i->nat_tree_lock);
 
@@ -1964,10 +1965,10 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
 		if (!nm_i->free_nid_count[i])
 			continue;
 		for (idx = 0; idx < NAT_ENTRY_PER_BLOCK; idx++) {
-			nid_t nid;
-
-			if (!test_bit_le(idx, nm_i->free_nid_bitmap[i]))
-				continue;
+			idx = find_next_bit_le(nm_i->free_nid_bitmap[i],
+						NAT_ENTRY_PER_BLOCK, idx);
+			if (idx >= NAT_ENTRY_PER_BLOCK)
+				break;
 
 			nid = i * NAT_ENTRY_PER_BLOCK + idx;
 			add_free_nid(sbi, nid, true);
@@ -1980,7 +1981,6 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
 	down_read(&curseg->journal_rwsem);
 	for (i = 0; i < nats_in_cursum(journal); i++) {
 		block_t addr;
-		nid_t nid;
 
 		addr = le32_to_cpu(nat_in_journal(journal, i).block_addr);
 		nid = le32_to_cpu(nid_in_journal(journal, i));
-- 
2.7.4
