From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH trivial 7/7] fsck.f2fs: clean up duplicated code
Date: Fri, 15 Jul 2016 20:01:25 +0800
Message-ID: <1468584085-29090-7-git-send-email-shengyong1@huawei.com>
References: <1468584085-29090-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1bO1tH-0003y6-2w
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Jul 2016 12:06:47 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bO1tB-0001ZL-Rn
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Jul 2016 12:06:47 +0000
In-Reply-To: <1468584085-29090-1-git-send-email-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Xue Liu <liuxueliu.liu@huawei.com>

From: Xue Liu <liuxueliu.liu@huawei.com>

Call current_nat_addr() to calculate nat block address.

Signed-off-by: Xue Liu <liuxueliu.liu@huawei.com>
---
 fsck/mount.c | 56 ++++++++------------------------------------------------
 1 file changed, 8 insertions(+), 48 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 7af684f..3be60bb 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1168,11 +1168,9 @@ int get_sum_entry(struct f2fs_sb_info *sbi, u32 blk_addr,
 static void get_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
 				struct f2fs_nat_entry *raw_nat)
 {
-	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct f2fs_nat_block *nat_block;
-	pgoff_t block_off;
 	pgoff_t block_addr;
-	int seg_off, entry_off;
+	int entry_off;
 	int ret;
 
 	if (lookup_nat_in_journal(sbi, nid, raw_nat) >= 0)
@@ -1180,16 +1178,8 @@ static void get_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
 
 	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
 
-	block_off = nid / NAT_ENTRY_PER_BLOCK;
 	entry_off = nid % NAT_ENTRY_PER_BLOCK;
-
-	seg_off = block_off >> sbi->log_blocks_per_seg;
-	block_addr = (pgoff_t)(nm_i->nat_blkaddr +
-			(seg_off << sbi->log_blocks_per_seg << 1) +
-			(block_off & ((1 << sbi->log_blocks_per_seg) - 1)));
-
-	if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
-		block_addr += sbi->blocks_per_seg;
+	block_addr = current_nat_addr(sbi, nid);
 
 	ret = dev_read_block(nat_block, block_addr);
 	ASSERT(ret >= 0);
@@ -1252,25 +1242,15 @@ void update_data_blkaddr(struct f2fs_sb_info *sbi, nid_t nid,
 void update_nat_blkaddr(struct f2fs_sb_info *sbi, nid_t ino,
 					nid_t nid, block_t newaddr)
 {
-	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct f2fs_nat_block *nat_block;
-	pgoff_t block_off;
 	pgoff_t block_addr;
-	int seg_off, entry_off;
+	int entry_off;
 	int ret;
 
 	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
 
-	block_off = nid / NAT_ENTRY_PER_BLOCK;
 	entry_off = nid % NAT_ENTRY_PER_BLOCK;
-
-	seg_off = block_off >> sbi->log_blocks_per_seg;
-	block_addr = (pgoff_t)(nm_i->nat_blkaddr +
-			(seg_off << sbi->log_blocks_per_seg << 1) +
-			(block_off & ((1 << sbi->log_blocks_per_seg) - 1)));
-
-	if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
-		block_addr += sbi->blocks_per_seg;
+	block_addr = current_nat_addr(sbi, nid);
 
 	ret = dev_read_block(nat_block, block_addr);
 	ASSERT(ret >= 0);
@@ -1486,11 +1466,9 @@ static void flush_nat_journal_entries(struct f2fs_sb_info *sbi)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_journal *journal = &curseg->sum_blk->journal;
-	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct f2fs_nat_block *nat_block;
-	pgoff_t block_off;
 	pgoff_t block_addr;
-	int seg_off, entry_off;
+	int entry_off;
 	nid_t nid;
 	int ret;
 	int i = 0;
@@ -1504,16 +1482,8 @@ next:
 	nid = le32_to_cpu(nid_in_journal(journal, i));
 	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
 
-	block_off = nid / NAT_ENTRY_PER_BLOCK;
 	entry_off = nid % NAT_ENTRY_PER_BLOCK;
-
-	seg_off = block_off >> sbi->log_blocks_per_seg;
-	block_addr = (pgoff_t)(nm_i->nat_blkaddr +
-			(seg_off << sbi->log_blocks_per_seg << 1) +
-			(block_off & ((1 << sbi->log_blocks_per_seg) - 1)));
-
-	if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
-		block_addr += sbi->blocks_per_seg;
+	block_addr = current_nat_addr(sbi, nid);
 
 	ret = dev_read_block(nat_block, block_addr);
 	ASSERT(ret >= 0);
@@ -1704,11 +1674,9 @@ void nullify_nat_entry(struct f2fs_sb_info *sbi, u32 nid)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_journal *journal = &curseg->sum_blk->journal;
-	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct f2fs_nat_block *nat_block;
-	pgoff_t block_off;
 	pgoff_t block_addr;
-	int seg_off, entry_off;
+	int entry_off;
 	int ret;
 	int i = 0;
 
@@ -1723,16 +1691,8 @@ void nullify_nat_entry(struct f2fs_sb_info *sbi, u32 nid)
 	}
 	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
 
-	block_off = nid / NAT_ENTRY_PER_BLOCK;
 	entry_off = nid % NAT_ENTRY_PER_BLOCK;
-
-	seg_off = block_off >> sbi->log_blocks_per_seg;
-	block_addr = (pgoff_t)(nm_i->nat_blkaddr +
-			(seg_off << sbi->log_blocks_per_seg << 1) +
-			(block_off & ((1 << sbi->log_blocks_per_seg) - 1)));
-
-	if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
-		block_addr += sbi->blocks_per_seg;
+	block_addr = current_nat_addr(sbi, nid);
 
 	ret = dev_read_block(nat_block, block_addr);
 	ASSERT(ret >= 0);
-- 
2.7.1


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
