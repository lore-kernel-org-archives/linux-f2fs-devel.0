From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] resize.f2fs: fix wrong offset calculation
Date: Wed,  2 Nov 2016 17:01:46 -0700
Message-ID: <20161103000146.64292-2-jaegeuk@kernel.org>
References: <20161103000146.64292-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c25Tj-0008As-6X
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 00:01:59 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c25Ti-0006CC-Az
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 00:01:59 +0000
In-Reply-To: <20161103000146.64292-1-jaegeuk@kernel.org>
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

When we move whole main area into new expanded area, we do not change its
segment numbers from sit and ssa.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/resize.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/fsck/resize.c b/fsck/resize.c
index b8d3f39..6a645e3 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -206,14 +206,20 @@ static void migrate_ssa(struct f2fs_sb_info *sbi,
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	block_t old_sum_blkaddr = get_sb(ssa_blkaddr);
 	block_t new_sum_blkaddr = get_newsb(ssa_blkaddr);
-	int segno;
+	unsigned int segno;
 
-	if (new_sum_blkaddr < old_sum_blkaddr + offset) {
-		for (segno = offset; segno < TOTAL_SEGS(sbi); segno++)
+	if (offset && new_sum_blkaddr < old_sum_blkaddr + offset) {
+		segno = offset;
+		while (segno != TOTAL_SEGS(sbi)) {
 			move_ssa(sbi, segno, new_sum_blkaddr + segno - offset);
+			segno++;
+		}
 	} else {
-		for (segno = TOTAL_SEGS(sbi) - 1; segno >= offset; segno--)
+		segno = TOTAL_SEGS(sbi) - 1;
+		while (segno != offset - 1) {
 			move_ssa(sbi, segno, new_sum_blkaddr + segno - offset);
+			segno--;
+		}
 	}
 
 	DBG(0, "Info: Done to migrate SSA blocks: sum_blkaddr = 0x%x -> 0x%x\n",
@@ -531,7 +537,8 @@ int f2fs_resize(struct f2fs_sb_info *sbi)
 	struct f2fs_super_block new_sb_raw;
 	struct f2fs_super_block *new_sb = &new_sb_raw;
 	block_t end_blkaddr, old_main_blkaddr, new_main_blkaddr;
-	unsigned int offset, offset_seg;
+	unsigned int offset;
+	unsigned int offset_seg = 0;
 	int err = -1;
 
 	/* flush NAT/SIT journal entries */
@@ -565,13 +572,12 @@ int f2fs_resize(struct f2fs_sb_info *sbi)
 	}
 
 	err = -EAGAIN;
-	offset_seg = offset >> get_sb(log_blocks_per_seg);
-
 	if (new_main_blkaddr < end_blkaddr) {
 		err = f2fs_defragment(sbi, old_main_blkaddr, offset,
 						new_main_blkaddr, 0);
-		if (err)
-			MSG(0, "Skip defragement\n");
+		if (!err)
+			offset_seg = offset >> get_sb(log_blocks_per_seg);
+		MSG(0, "Try to do defragement: %s\n", err ? "Skip": "Done");
 	}
 	/* move whole data region */
 	if (err)
-- 
2.8.3


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
