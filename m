From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] fsck.f2fs: avoid build warnings
Date: Tue,  2 Sep 2014 22:03:27 -0700
Message-ID: <1409720608-73045-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XP2jI-00079s-Gq
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 Sep 2014 05:03:36 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XP2jH-0002Br-NS for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 Sep 2014 05:03:36 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/dump.c |  4 ++--
 fsck/fsck.c | 10 ++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 54f9a52..4bb906f 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -140,8 +140,8 @@ static void dump_node_blk(struct f2fs_sb_info *sbi, int ntype,
 {
 	struct node_info ni;
 	struct f2fs_node *node_blk;
-	u32 idx, skip = 0;
-	int i;
+	u32 skip = 0;
+	u32 i, idx;
 
 	switch (ntype) {
 	case TYPE_DIRECT_NODE:
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 560b541..3fd9784 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -454,12 +454,13 @@ check:
 				(u32)i_blocks);
 
 	if (i_blocks != *blk_cnt) {
-		ASSERT_MSG("ino: 0x%x has i_blocks: %lu, but has %u blocks",
+		ASSERT_MSG("ino: 0x%x has i_blocks: %08"PRIx64", "
+				"but has %u blocks",
 				nid, i_blocks, *blk_cnt);
 		if (config.fix_cnt) {
 			node_blk->i.i_blocks = cpu_to_le64(*blk_cnt);
 			need_fix = 1;
-			FIX_MSG("[0x%x] i_blocks=0x%lx -> 0x%x",
+			FIX_MSG("[0x%x] i_blocks=0x%08"PRIx64" -> 0x%x",
 					nid, i_blocks, *blk_cnt);
 		}
 	}
@@ -788,7 +789,7 @@ void fsck_init(struct f2fs_sb_info *sbi)
 static void fix_nat_entries(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
-	int i;
+	u32 i;
 
 	for (i = 0; i < fsck->nr_nat_entries; i++)
 		if (f2fs_test_bit(i, fsck->nat_area_bitmap) != 0)
@@ -801,7 +802,8 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 	struct f2fs_super_block *raw_sb = sbi->raw_super;
 	struct f2fs_checkpoint *ckp = F2FS_CKPT(sbi);
 	unsigned long long cp_blk_no;
-	int i, ret;
+	u32 i;
+	int ret;
 	u_int32_t crc = 0;
 
 	ckp->ckpt_flags = cpu_to_le32(CP_UMOUNT_FLAG);
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
