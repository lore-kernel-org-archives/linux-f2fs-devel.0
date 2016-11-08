From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH] fsck: refactor build_nat_area_bitmap to speed up
	fsck
Date: Tue, 8 Nov 2016 08:48:10 +0800
Message-ID: <1478566090-18871-1-git-send-email-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhengjunling@huawei.com>) id 1c3unf-0002nh-TI
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Nov 2016 01:02:07 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c3unY-0004Ph-4k
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 08 Nov 2016 01:02:07 +0000
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

Refactor build_nat_area_bitmap, move out lookup_nat_in_journal from the
dual loops. Instead of looking up all nids in journals, we traverse nat
journals, whose entries are used to replace the NAT entries with the
corresponding nid to reduce the time build_nat_area_bitmap costs.

For "fsck -p 1", it reduces over half of the time.

		Empty		Fragmented Entirely
32G(ms):
  original	625.8		727.3
  improved	226.3		298.2
64G(ms):
  original	1159		1637.7
  improved	515.8		676.7

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 fsck/mount.c | 118 ++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 64 insertions(+), 54 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 21a96a7..9fcb008 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1792,10 +1792,13 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 
 void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 {
+	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
+	struct f2fs_journal *journal = &curseg->sum_blk->journal;
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct f2fs_nat_block *nat_block;
+	struct node_info ni;
 	u32 nid, nr_nat_blks;
 	pgoff_t block_off;
 	pgoff_t block_addr;
@@ -1834,8 +1837,6 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 
 		nid = block_off * NAT_ENTRY_PER_BLOCK;
 		for (i = 0; i < NAT_ENTRY_PER_BLOCK; i++) {
-			struct f2fs_nat_entry raw_nat;
-			struct node_info ni;
 			ni.nid = nid + i;
 
 			if ((nid + i) == F2FS_NODE_INO(sbi) ||
@@ -1851,63 +1852,72 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 				continue;
 			}
 
-			if (lookup_nat_in_journal(sbi, nid + i,
-							&raw_nat) >= 0) {
-				node_info_from_raw_nat(&ni, &raw_nat);
-				if ((ni.ino == 0x0 && ni.blk_addr != 0x0))
-					ASSERT_MSG("\tError: ino[0x%8x] or blk_addr[0x%16x]"
-						" is invalid\n",
-						ni.ino, ni.blk_addr);
-				if (ni.ino == (nid + i) && ni.blk_addr != 0) {
-					fsck->nat_valid_inode_cnt++;
-					DBG(3, "ino[0x%8x] maybe is inode\n",
-								ni.ino);
-				}
-				if (ni.blk_addr != 0x0) {
-					f2fs_set_bit(nid + i,
-							fsck->nat_area_bitmap);
-					fsck->chk.valid_nat_entry_cnt++;
-					DBG(3, "nid[0x%x] in nat cache\n",
-								nid + i);
-				}
+			node_info_from_raw_nat(&ni, &nat_block->entries[i]);
+			if (ni.blk_addr == 0x0)
+				continue;
+			if (ni.ino == 0x0) {
+				ASSERT_MSG("\tError: ino[0x%8x] or blk_addr[0x%16x]"
+					" is invalid\n", ni.ino, ni.blk_addr);
+			}
+			if (ni.ino == (nid + i)) {
+				fsck->nat_valid_inode_cnt++;
+				DBG(3, "ino[0x%8x] maybe is inode\n", ni.ino);
+			}
+			if (nid + i == 0) {
+				/*
+				 * nat entry [0] must be null.  If
+				 * it is corrupted, set its bit in
+				 * nat_area_bitmap, fsck_verify will
+				 * nullify it
+				 */
+				ASSERT_MSG("Invalid nat entry[0]: "
+					"blk_addr[0x%x]\n", ni.blk_addr);
+				c.fix_on = 1;
+				fsck->chk.valid_nat_entry_cnt--;
+			}
 
-				fsck->entries[nid + i] = raw_nat;
-			} else {
-				node_info_from_raw_nat(&ni,
-						&nat_block->entries[i]);
-				if ((ni.ino == 0x0 && ni.blk_addr != 0x0))
-					ASSERT_MSG("\tError: ino[0x%8x] or blk_addr[0x%16x]"
-						" is invalid\n",
-						ni.ino, ni.blk_addr);
-				if (ni.ino == (nid + i) && ni.blk_addr != 0) {
-					fsck->nat_valid_inode_cnt++;
-					DBG(3, "ino[0x%8x] maybe is inode\n",
-								ni.ino);
-				}
-				if (ni.blk_addr == 0)
-					continue;
-				if (nid + i == 0) {
-					/*
-					 * nat entry [0] must be null.  If
-					 * it is corrupted, set its bit in
-					 * nat_area_bitmap, fsck_verify will
-					 * nullify it
-					 */
-					ASSERT_MSG("Invalid nat entry[0]: "
-						"blk_addr[0x%x]\n",
-						ni.blk_addr);
-					c.fix_on = 1;
-					fsck->chk.valid_nat_entry_cnt--;
-				}
+			DBG(3, "nid[0x%8x] addr[0x%16x] ino[0x%8x]\n",
+				nid + i, ni.blk_addr, ni.ino);
+			f2fs_set_bit(nid + i, fsck->nat_area_bitmap);
+			fsck->chk.valid_nat_entry_cnt++;
+
+			fsck->entries[nid + i] = nat_block->entries[i];
+		}
+	}
+
+	/* Traverse nat journal, update the corresponding entries */
+	for (i = 0; i < nats_in_cursum(journal); i++) {
+		struct f2fs_nat_entry raw_nat;
+		nid = le32_to_cpu(nid_in_journal(journal, i));
+		ni.nid = nid;
 
-				DBG(3, "nid[0x%8x] addr[0x%16x] ino[0x%8x]\n",
-					nid + i, ni.blk_addr, ni.ino);
-				f2fs_set_bit(nid + i, fsck->nat_area_bitmap);
-				fsck->chk.valid_nat_entry_cnt++;
+		DBG(3, "==> Found nid [0x%x] in nat cache, update it\n", nid);
 
-				fsck->entries[nid + i] = nat_block->entries[i];
+		/* Clear the original bit and count */
+		if (fsck->entries[nid].block_addr != 0x0) {
+			fsck->chk.valid_nat_entry_cnt--;
+			f2fs_clear_bit(nid, fsck->nat_area_bitmap);
+			if (fsck->entries[nid].ino == nid)
+				fsck->nat_valid_inode_cnt--;
+		}
+
+		/* Use nat entries in journal */
+		memcpy(&raw_nat, &nat_in_journal(journal, i),
+					sizeof(struct f2fs_nat_entry));
+		node_info_from_raw_nat(&ni, &raw_nat);
+		if (ni.blk_addr != 0x0) {
+			if (ni.ino == 0x0)
+				ASSERT_MSG("\tError: ino[0x%8x] or blk_addr[0x%16x]"
+					" is invalid\n", ni.ino, ni.blk_addr);
+			if (ni.ino == nid) {
+				fsck->nat_valid_inode_cnt++;
+				DBG(3, "ino[0x%8x] maybe is inode\n", ni.ino);
 			}
+			f2fs_set_bit(nid, fsck->nat_area_bitmap);
+			fsck->chk.valid_nat_entry_cnt++;
+			DBG(3, "nid[0x%x] in nat cache\n", nid);
 		}
+		fsck->entries[nid] = raw_nat;
 	}
 	free(nat_block);
 
-- 
2.7.4


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
