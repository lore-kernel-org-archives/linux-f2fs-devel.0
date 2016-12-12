From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] resize.f2fs: remove unused parameters
Date: Mon, 12 Dec 2016 11:48:56 +0800
Message-ID: <20161212034856.10597-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cGHYU-0001JN-KX
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Dec 2016 03:45:34 +0000
Received: from [119.145.14.65] (helo=szxga02-in.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cGHYG-0008Ms-3b
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Dec 2016 03:45:34 +0000
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

This patch remove unused parameters in these three functions:
get_new_sb, migrate_main and rebuild_superblock

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/resize.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fsck/resize.c b/fsck/resize.c
index db14e61..29cb1c0 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -9,7 +9,7 @@
  */
 #include "fsck.h"
 
-static int get_new_sb(struct f2fs_sb_info *sbi, struct f2fs_super_block *sb)
+static int get_new_sb(struct f2fs_super_block *sb)
 {
 	u_int32_t zone_size_bytes, zone_align_start_offset;
 	u_int32_t blocks_for_sit, blocks_for_nat, blocks_for_ssa;
@@ -132,8 +132,7 @@ static int get_new_sb(struct f2fs_sb_info *sbi, struct f2fs_super_block *sb)
 	return 0;
 }
 
-static void migrate_main(struct f2fs_sb_info *sbi,
-		struct f2fs_super_block *new_sb, unsigned int offset)
+static void migrate_main(struct f2fs_sb_info *sbi, unsigned int offset)
 {
 	void *raw = calloc(BLOCK_SZ, 1);
 	struct seg_entry *se;
@@ -530,8 +529,7 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 	DBG(0, "Info: Done to rebuild checkpoint blocks\n");
 }
 
-static void rebuild_superblock(struct f2fs_sb_info *sbi,
-				struct f2fs_super_block *new_sb)
+static void rebuild_superblock(struct f2fs_super_block *new_sb)
 {
 	int index, ret;
 	u_int8_t *buf;
@@ -561,7 +559,7 @@ int f2fs_resize(struct f2fs_sb_info *sbi)
 	flush_journal_entries(sbi);
 
 	memcpy(new_sb, F2FS_RAW_SUPER(sbi), sizeof(*new_sb));
-	if (get_new_sb(sbi, new_sb))
+	if (get_new_sb(new_sb))
 		return -1;
 
 	/* check nat availability */
@@ -592,12 +590,12 @@ int f2fs_resize(struct f2fs_sb_info *sbi)
 	}
 	/* move whole data region */
 	if (err)
-		migrate_main(sbi, new_sb, offset);
+		migrate_main(sbi, offset);
 
 	migrate_ssa(sbi, new_sb, offset_seg);
 	migrate_nat(sbi, new_sb);
 	migrate_sit(sbi, new_sb, offset_seg);
 	rebuild_checkpoint(sbi, new_sb, offset_seg);
-	rebuild_superblock(sbi, new_sb);
+	rebuild_superblock(new_sb);
 	return 0;
 }
-- 
2.10.1


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today.http://sdm.link/xeonphi
