From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: use sbi->blocks_per_seg to avoid
	unnecessary calculation
Date: Tue, 01 Dec 2015 11:56:52 +0800
Message-ID: <000101d12bec$6820eec0$3862cc40$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1a3c4U-0001LL-SD
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Dec 2015 03:57:42 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a3c4S-0005t9-Ka
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Dec 2015 03:57:42 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NYN0162OUZSG450@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Dec 2015 12:57:33 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Use sbi->blocks_per_seg directly to avoid unnecessary calculation when using 
1 << sbi->log_blocks_per_seg.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/debug.c | 2 +-
 fs/f2fs/f2fs.h  | 3 +--
 fs/f2fs/file.c  | 5 ++---
 fs/f2fs/gc.c    | 4 ++--
 fs/f2fs/node.h  | 2 +-
 5 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index b0966f3..8ce2fe3 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -105,7 +105,7 @@ static void update_sit_info(struct f2fs_sb_info *sbi)
 
 	bimodal = 0;
 	total_vblocks = 0;
-	blks_per_sec = sbi->segs_per_sec * (1 << sbi->log_blocks_per_seg);
+	blks_per_sec = sbi->segs_per_sec * sbi->blocks_per_seg;
 	hblks_per_sec = blks_per_sec / 2;
 	for (segno = 0; segno < MAIN_SEGS(sbi); segno += sbi->segs_per_sec) {
 		vblocks = get_valid_blocks(sbi, segno, sbi->segs_per_sec);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0831db2..0052ae8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1099,8 +1099,7 @@ static inline int get_dirty_pages(struct inode *inode)
 
 static inline int get_blocktype_secs(struct f2fs_sb_info *sbi, int block_type)
 {
-	unsigned int pages_per_sec = sbi->segs_per_sec *
-					(1 << sbi->log_blocks_per_seg);
+	unsigned int pages_per_sec = sbi->segs_per_sec * sbi->blocks_per_seg;
 	return ((get_pages(sbi, block_type) + pages_per_sec - 1)
 			>> sbi->log_blocks_per_seg) / sbi->segs_per_sec;
 }
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b38af30..a018ed3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1662,10 +1662,9 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	struct f2fs_map_blocks map;
 	struct extent_info ei;
 	pgoff_t pg_start, pg_end;
-	unsigned int blk_per_seg = 1 << sbi->log_blocks_per_seg;
+	unsigned int blk_per_seg = sbi->blocks_per_seg;
 	unsigned int total = 0, sec_num;
-	unsigned int pages_per_sec = sbi->segs_per_sec *
-					(1 << sbi->log_blocks_per_seg);
+	unsigned int pages_per_sec = sbi->segs_per_sec * blk_per_seg;
 	block_t blk_end = 0;
 	bool fragmented = false;
 	int err;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index fedbf67..ce350c4 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -173,9 +173,9 @@ static unsigned int get_max_cost(struct f2fs_sb_info *sbi,
 {
 	/* SSR allocates in a segment unit */
 	if (p->alloc_mode == SSR)
-		return 1 << sbi->log_blocks_per_seg;
+		return sbi->blocks_per_seg;
 	if (p->gc_mode == GC_GREEDY)
-		return (1 << sbi->log_blocks_per_seg) * p->ofs_unit;
+		return sbi->blocks_per_seg * p->ofs_unit;
 	else if (p->gc_mode == GC_CB)
 		return UINT_MAX;
 	else /* No other gc_mode */
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index e4fffd2..2de759a 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -183,7 +183,7 @@ static inline pgoff_t current_nat_addr(struct f2fs_sb_info *sbi, nid_t start)
 
 	block_addr = (pgoff_t)(nm_i->nat_blkaddr +
 		(seg_off << sbi->log_blocks_per_seg << 1) +
-		(block_off & ((1 << sbi->log_blocks_per_seg) - 1)));
+		(block_off & (sbi->blocks_per_seg - 1)));
 
 	if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
 		block_addr += sbi->blocks_per_seg;
-- 
2.6.3



------------------------------------------------------------------------------
Go from Idea to Many App Stores Faster with Intel(R) XDK
Give your users amazing mobile app experiences with Intel(R) XDK.
Use one codebase in this all-in-one HTML5 development environment.
Design, debug & build mobile apps & 2D/3D high-impact games for multiple OSs.
http://pubads.g.doubleclick.net/gampad/clk?id=254741911&iu=/4140
