From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] defrag.f2fs: return error if there is no
	space
Date: Thu, 17 Dec 2015 09:23:03 -0800
Message-ID: <1450372983-84005-2-git-send-email-jaegeuk@kernel.org>
References: <1450372983-84005-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a9cGr-0003W8-En
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Dec 2015 17:23:17 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a9cGm-0002IS-RD for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Dec 2015 17:23:17 +0000
In-Reply-To: <1450372983-84005-1-git-send-email-jaegeuk@kernel.org>
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

This patch checks whether there is a space or not to allocate new blocks.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 735ed90..4b38df8 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -11,6 +11,20 @@
 #include "fsck.h"
 #include <locale.h>
 
+static u32 get_free_segments(struct f2fs_sb_info *sbi)
+{
+	u32 i, free_segs = 0;
+
+	for (i = 0; i < TOTAL_SEGS(sbi); i++) {
+		struct seg_entry *se = get_seg_entry(sbi, i);
+
+		if (se->valid_blocks == 0x0 &&
+				!IS_CUR_SEGNO(sbi, i, NO_CHECK_TYPE))
+			free_segs++;
+	}
+	return free_segs;
+}
+
 void print_inode_info(struct f2fs_inode *inode, int name)
 {
 	unsigned int i = 0;
@@ -1376,6 +1390,9 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
 	u32 segno;
 	u64 offset;
 
+	if (get_free_segments(sbi) <= SM_I(sbi)->reserved_segments + 1)
+		return -1;
+
 	while (*to >= SM_I(sbi)->main_blkaddr &&
 			*to < F2FS_RAW_SUPER(sbi)->block_count) {
 		segno = GET_SEGNO(sbi, *to);
@@ -1543,10 +1560,8 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	block_t orphan_blks = 0;
-	u32 free_segs = 0;
 	unsigned long long cp_blk_no;
 	u32 flags = CP_UMOUNT_FLAG;
-	unsigned int segno;
 	int i, ret;
 	u_int32_t crc = 0;
 
@@ -1557,14 +1572,7 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 
 	set_cp(ckpt_flags, flags);
 
-	for (segno = 0; segno < TOTAL_SEGS(sbi); segno++) {
-		struct seg_entry *se = get_seg_entry(sbi, segno);
-
-		if (se->valid_blocks == 0x0 &&
-				!IS_CUR_SEGNO(sbi, segno, NO_CHECK_TYPE))
-			free_segs++;
-	}
-	set_cp(free_segment_count, free_segs);
+	set_cp(free_segment_count, get_free_segments(sbi));
 	set_cp(cp_pack_total_block_count, 8 + orphan_blks + get_sb(cp_payload));
 
 	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CHECKSUM_OFFSET);
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
