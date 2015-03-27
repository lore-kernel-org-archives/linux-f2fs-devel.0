From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6/6] fsck.f2fs: preserve orphan blocks
Date: Thu, 26 Mar 2015 17:03:09 -0700
Message-ID: <1427414589-66956-6-git-send-email-jaegeuk@kernel.org>
References: <1427414589-66956-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YbHkL-0000KI-37
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Mar 2015 00:03:33 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YbHkK-0003Eu-0C for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Mar 2015 00:03:33 +0000
In-Reply-To: <1427414589-66956-1-git-send-email-jaegeuk@kernel.org>
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

If fsck.f2fs found some orphan blocks, previously fsck.f2fs drops them and
fixes checkpoint, resulting in false alarm on corruption.
This patch preserves orphan blocks to avoid such the alarms.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 48 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 97bf6ce..6b687d8 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -946,8 +946,10 @@ void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 {
 	u32 blk_cnt = 0;
 	block_t start_blk, orphan_blkaddr, i, j;
-	struct f2fs_orphan_block *orphan_blk;
+	struct f2fs_orphan_block *orphan_blk, *new_blk;
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	u32 entry_count;
+	u32 new_entry_count = 0;
 
 	if (!is_set_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG))
 		return;
@@ -955,28 +957,43 @@ void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 	start_blk = __start_cp_addr(sbi) + 1 +
 		le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);
 	orphan_blkaddr = __start_sum_addr(sbi) - 1;
+
 	orphan_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(orphan_blk);
+
+	new_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(new_blk);
 
 	for (i = 0; i < orphan_blkaddr; i++) {
 		int ret = dev_read_block(orphan_blk, start_blk + i);
 
 		ASSERT(ret >= 0);
+		entry_count = le32_to_cpu(orphan_blk->entry_count);
 
-		for (j = 0; j < le32_to_cpu(orphan_blk->entry_count); j++) {
+		for (j = 0; j < entry_count; j++) {
 			nid_t ino = le32_to_cpu(orphan_blk->ino[j]);
 			DBG(1, "[%3d] ino [0x%x]\n", i, ino);
-			if (config.fix_on) {
-				FIX_MSG("Discard orphan inodes: ino [0x%x]",
-									ino);
-				continue;
-			}
 			blk_cnt = 1;
-			fsck_chk_node_blk(sbi, NULL, ino, NULL,
+			ret = fsck_chk_node_blk(sbi, NULL, ino, NULL,
 					F2FS_FT_ORPHAN, TYPE_INODE, &blk_cnt);
+			if (!ret)
+				new_blk->ino[new_entry_count++] =
+							orphan_blk->ino[j];
+			else if (ret && config.fix_on)
+				FIX_MSG("[0x%x] remove from orphan list", ino);
+			else if (ret)
+				ASSERT_MSG("[0x%x] wrong orphan inode", ino);
+		}
+		if (config.fix_on && entry_count != new_entry_count) {
+			new_blk->entry_count = cpu_to_le32(new_entry_count);
+			ret = dev_write_block(new_blk, start_blk + i);
+			ASSERT(ret >= 0);
 		}
 		memset(orphan_blk, 0, BLOCK_SZ);
+		memset(new_blk, 0, BLOCK_SZ);
 	}
 	free(orphan_blk);
+	free(new_blk);
 }
 
 void fsck_init(struct f2fs_sb_info *sbi)
@@ -1056,15 +1073,20 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 	struct f2fs_super_block *raw_sb = sbi->raw_super;
 	struct f2fs_checkpoint *ckp = F2FS_CKPT(sbi);
 	unsigned long long cp_blk_no;
+	u32 flags = CP_UMOUNT_FLAG;
+	block_t orphan_blks = 0;
 	u32 i;
 	int ret;
 	u_int32_t crc = 0;
 
-	ckp->ckpt_flags = cpu_to_le32(CP_UMOUNT_FLAG);
+	if (is_set_ckpt_flags(ckp, CP_ORPHAN_PRESENT_FLAG)) {
+		orphan_blks = __start_sum_addr(sbi) - 1;
+		flags |= CP_ORPHAN_PRESENT_FLAG;
+	}
+
+	ckp->ckpt_flags = cpu_to_le32(flags);
 	ckp->cp_pack_total_block_count =
-		cpu_to_le32(8 + le32_to_cpu(raw_sb->cp_payload));
-	ckp->cp_pack_start_sum = cpu_to_le32(1 +
-				le32_to_cpu(raw_sb->cp_payload));
+		cpu_to_le32(8 + orphan_blks + le32_to_cpu(raw_sb->cp_payload));
 
 	ckp->free_segment_count = cpu_to_le32(fsck->chk.free_segs);
 	ckp->valid_block_count = cpu_to_le32(fsck->chk.valid_blk_cnt);
@@ -1088,6 +1110,8 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 		ASSERT(ret >= 0);
 	}
 
+	cp_blk_no += orphan_blks;
+
 	for (i = 0; i < NO_CHECK_TYPE; i++) {
 		struct curseg_info *curseg = CURSEG_I(sbi, i);
 
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
