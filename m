From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: fix stack overflow when reading out
 nat block
Date: Fri, 20 Apr 2018 19:15:46 -0700
Message-ID: <20180421021546.73327-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1f9i4B-0002va-Aw
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 21 Apr 2018 02:15:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f9i49-005XEI-VV
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 21 Apr 2018 02:15:55 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

The size of nat_block is less then 4KB, resulting in stack overflow by dev_read.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index b374b46..7e936dc 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -907,7 +907,7 @@ static int f2fs_init_nid_bitmap(struct f2fs_sb_info *sbi)
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_summary_block *sum = curseg->sum_blk;
 	struct f2fs_journal *journal = &sum->journal;
-	struct f2fs_nat_block nat_block;
+	struct f2fs_nat_block *nat_block;
 	block_t start_blk;
 	nid_t nid;
 	int i;
@@ -922,18 +922,22 @@ static int f2fs_init_nid_bitmap(struct f2fs_sb_info *sbi)
 	/* arbitrarily set 0 bit */
 	f2fs_set_bit(0, nm_i->nid_bitmap);
 
-	memset((void *)&nat_block, 0, sizeof(struct f2fs_nat_block));
+	nat_block = malloc(F2FS_BLKSIZE);
+	if (!nat_block) {
+		free(nm_i->nid_bitmap);
+		return -ENOMEM;
+	}
 
 	for (nid = 0; nid < nm_i->max_nid; nid++) {
 		if (!(nid % NAT_ENTRY_PER_BLOCK)) {
 			int ret;
 
 			start_blk = current_nat_addr(sbi, nid);
-			ret = dev_read_block((void *)&nat_block, start_blk);
+			ret = dev_read_block(nat_block, start_blk);
 			ASSERT(ret >= 0);
 		}
 
-		if (nat_block.entries[nid % NAT_ENTRY_PER_BLOCK].block_addr)
+		if (nat_block->entries[nid % NAT_ENTRY_PER_BLOCK].block_addr)
 			f2fs_set_bit(nid, nm_i->nid_bitmap);
 	}
 
@@ -945,6 +949,7 @@ static int f2fs_init_nid_bitmap(struct f2fs_sb_info *sbi)
 		if (addr != NULL_ADDR)
 			f2fs_set_bit(nid, nm_i->nid_bitmap);
 	}
+	free(nat_block);
 	return 0;
 }
 
-- 
2.17.0.484.g0c8726318c-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
