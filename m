From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 7/7] resize.f2fs: fill zeros for expanded ssa area
Date: Wed,  2 Nov 2016 22:28:46 -0700
Message-ID: <20161103052846.72244-7-jaegeuk@kernel.org>
References: <20161103052846.72244-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c2Aad-00062N-8X
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 05:29:27 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c2Aac-00056P-Cv
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 05:29:27 +0000
In-Reply-To: <20161103052846.72244-1-jaegeuk@kernel.org>
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

This will avoid wrong behavior after expanding volume.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/resize.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/fsck/resize.c b/fsck/resize.c
index 4813de7..7691524 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -206,24 +206,37 @@ static void migrate_ssa(struct f2fs_sb_info *sbi,
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	block_t old_sum_blkaddr = get_sb(ssa_blkaddr);
 	block_t new_sum_blkaddr = get_newsb(ssa_blkaddr);
-	unsigned int segno;
+	block_t end_sum_blkaddr = get_newsb(main_blkaddr);
+	block_t blkaddr;
+	void *zero_block = calloc(BLOCK_SZ, 1);
+
+	ASSERT(zero_block);
 
 	if (offset && new_sum_blkaddr < old_sum_blkaddr + offset) {
-		segno = offset;
-		while (segno != TOTAL_SEGS(sbi)) {
-			move_ssa(sbi, segno, new_sum_blkaddr + segno - offset);
-			segno++;
+		blkaddr = new_sum_blkaddr;
+		while (blkaddr < end_sum_blkaddr) {
+			if (blkaddr - new_sum_blkaddr < TOTAL_SEGS(sbi))
+				move_ssa(sbi, offset, blkaddr);
+			else
+				dev_write_block(zero_block, blkaddr);
+			offset++;
+			blkaddr++;
 		}
 	} else {
-		segno = TOTAL_SEGS(sbi) - 1;
-		while (segno != offset - 1) {
-			move_ssa(sbi, segno, new_sum_blkaddr + segno - offset);
-			segno--;
+		blkaddr = end_sum_blkaddr - 1;
+		offset = TOTAL_SEGS(sbi) - 1;
+		while (blkaddr >= new_sum_blkaddr) {
+			if (blkaddr >= TOTAL_SEGS(sbi) + new_sum_blkaddr)
+				dev_write_block(zero_block, blkaddr);
+			else
+				move_ssa(sbi, offset--, blkaddr);
+			blkaddr--;
 		}
 	}
 
 	DBG(0, "Info: Done to migrate SSA blocks: sum_blkaddr = 0x%x -> 0x%x\n",
 				old_sum_blkaddr, new_sum_blkaddr);
+	free(zero_block);
 }
 
 static int shrink_nats(struct f2fs_sb_info *sbi,
-- 
2.8.3


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
