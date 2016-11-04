From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 2/2] fsck.f2fs: Add a judgment after calloc
Date: Fri, 4 Nov 2016 17:34:11 +0800
Message-ID: <20161104093411.14921-2-heyunlei@huawei.com>
References: <20161104093411.14921-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1c2an6-0001iZ-0I
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 04 Nov 2016 09:28:04 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c2an0-0000pA-C0
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 04 Nov 2016 09:28:03 +0000
In-Reply-To: <20161104093411.14921-1-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huwei.com

This patch add a judgment after calloc avoid memory alloc
failure

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/mount.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index f2055e4..e4adb0e 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -777,6 +777,8 @@ int build_sit_info(struct f2fs_sb_info *sbi)
 	SM_I(sbi)->sit_info = sit_i;
 
 	sit_i->sentries = calloc(TOTAL_SEGS(sbi) * sizeof(struct seg_entry), 1);
+	if (!sit_i->sentries)
+		return -ENOMEM;
 
 	for (start = 0; start < TOTAL_SEGS(sbi); start++) {
 		sit_i->sentries[start].cur_valid_map
@@ -1022,9 +1024,11 @@ static struct f2fs_sit_block *get_current_sit_page(struct f2fs_sb_info *sbi,
 	struct sit_info *sit_i = SIT_I(sbi);
 	unsigned int offset = SIT_BLOCK_OFFSET(sit_i, segno);
 	block_t blk_addr = sit_i->sit_base_addr + offset;
-	struct f2fs_sit_block *sit_blk = calloc(BLOCK_SZ, 1);
+	struct f2fs_sit_block *sit_blk;
 	int ret;
 
+	sit_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(sit_blk);
 	check_seg_range(sbi, segno);
 
 	/* calculate sit block address */
@@ -1189,6 +1193,7 @@ static void get_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
 		return;
 
 	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
+	ASSERT(nat_block);
 
 	entry_off = nid % NAT_ENTRY_PER_BLOCK;
 	block_addr = current_nat_addr(sbi, nid);
@@ -1210,7 +1215,7 @@ void update_data_blkaddr(struct f2fs_sb_info *sbi, nid_t nid,
 	int ret;
 
 	node_blk = (struct f2fs_node *)calloc(BLOCK_SZ, 1);
-	ASSERT(node_blk != NULL);
+	ASSERT(node_blk);
 
 	get_node_info(sbi, nid, &ni);
 
@@ -1260,6 +1265,7 @@ void update_nat_blkaddr(struct f2fs_sb_info *sbi, nid_t ino,
 	int ret;
 
 	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
+	ASSERT(nat_block);
 
 	entry_off = nid % NAT_ENTRY_PER_BLOCK;
 	block_addr = current_nat_addr(sbi, nid);
@@ -1357,6 +1363,7 @@ void build_sit_area_bitmap(struct f2fs_sb_info *sbi)
 
 	fsck->sit_area_bitmap_sz = sm_i->main_segments * SIT_VBLOCK_MAP_SIZE;
 	fsck->sit_area_bitmap = calloc(1, fsck->sit_area_bitmap_sz);
+	ASSERT(fsck->sit_area_bitmap);
 	ptr = fsck->sit_area_bitmap;
 
 	ASSERT(fsck->sit_area_bitmap_sz == fsck->main_area_bitmap_sz);
@@ -1490,18 +1497,21 @@ static int flush_nat_journal_entries(struct f2fs_sb_info *sbi)
 	int ret;
 	int i = 0;
 
+	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
+	ASSERT(nat_block);
 next:
 	if (i >= nats_in_cursum(journal)) {
+		free(nat_block);
 		journal->n_nats = 0;
 		return i;
 	}
 
 	nid = le32_to_cpu(nid_in_journal(journal, i));
-	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
 
 	entry_off = nid % NAT_ENTRY_PER_BLOCK;
 	block_addr = current_nat_addr(sbi, nid);
 
+	memset((void *)&nat_block, 0, sizeof(struct f2fs_nat_block));
 	ret = dev_read_block(nat_block, block_addr);
 	ASSERT(ret >= 0);
 
@@ -1510,7 +1520,6 @@ next:
 
 	ret = dev_write_block(nat_block, block_addr);
 	ASSERT(ret >= 0);
-	free(nat_block);
 	i++;
 	goto next;
 }
@@ -1709,6 +1718,7 @@ void nullify_nat_entry(struct f2fs_sb_info *sbi, u32 nid)
 		}
 	}
 	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
+	ASSERT(nat_block);
 
 	entry_off = nid % NAT_ENTRY_PER_BLOCK;
 	block_addr = current_nat_addr(sbi, nid);
@@ -1803,7 +1813,7 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 	fsck->nr_nat_entries = nr_nat_blks * NAT_ENTRY_PER_BLOCK;
 	fsck->nat_area_bitmap_sz = (fsck->nr_nat_entries + 7) / 8;
 	fsck->nat_area_bitmap = calloc(fsck->nat_area_bitmap_sz, 1);
-	ASSERT(fsck->nat_area_bitmap != NULL);
+	ASSERT(fsck->nat_area_bitmap);
 
 	fsck->entries = calloc(sizeof(struct f2fs_nat_entry),
 					fsck->nr_nat_entries);
-- 
2.10.1


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
