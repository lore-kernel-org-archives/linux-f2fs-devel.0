From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] resize.f2fs: fix access out-of memory boundary
Date: Fri, 23 Mar 2018 09:32:31 -0700
Message-ID: <20180323163231.40244-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1ezPcP-000780-9k
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Mar 2018 16:32:41 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail.kernel.org) by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1ezPcN-00GByd-Uz
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Mar 2018 16:32:41 +0000
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

This fixes out-of memory boundary on nat_bitmap, when resizing small to
large partition.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/f2fs.h  |  1 +
 fsck/mount.c | 13 +++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 8a5ce36..d0e08aa 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -50,6 +50,7 @@ struct node_info {
 
 struct f2fs_nm_info {
 	block_t nat_blkaddr;
+	block_t nat_blocks;
 	nid_t max_nid;
 	nid_t init_scan_nid;
 	nid_t next_scan_nid;
diff --git a/fsck/mount.c b/fsck/mount.c
index 545f862..a925bb9 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -998,7 +998,12 @@ void write_nat_bits(struct f2fs_sb_info *sbi,
 				(seg_off << get_sb(log_blocks_per_seg) << 1) +
 				(i & ((1 << get_sb(log_blocks_per_seg)) - 1)));
 
-		if (f2fs_test_bit(i, nm_i->nat_bitmap))
+		/*
+		 * Should consider new nat_blocks is larger than old
+		 * nm_i->nat_blocks, since nm_i->nat_bitmap is based on
+		 * old one.
+		 */
+		if (i < nm_i->nat_blocks && f2fs_test_bit(i, nm_i->nat_bitmap))
 			blkaddr += (1 << get_sb(log_blocks_per_seg));
 
 		ret = dev_read_block(nat_block, blkaddr);
@@ -1037,14 +1042,14 @@ int init_node_manager(struct f2fs_sb_info *sbi)
 	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	unsigned char *version_bitmap;
-	unsigned int nat_segs, nat_blocks;
+	unsigned int nat_segs;
 
 	nm_i->nat_blkaddr = get_sb(nat_blkaddr);
 
 	/* segment_count_nat includes pair segment so divide to 2. */
 	nat_segs = get_sb(segment_count_nat) >> 1;
-	nat_blocks = nat_segs << get_sb(log_blocks_per_seg);
-	nm_i->max_nid = NAT_ENTRY_PER_BLOCK * nat_blocks;
+	nm_i->nat_blocks = nat_segs << get_sb(log_blocks_per_seg);
+	nm_i->max_nid = NAT_ENTRY_PER_BLOCK * nm_i->nat_blocks;
 	nm_i->fcnt = 0;
 	nm_i->nat_cnt = 0;
 	nm_i->init_scan_nid = get_cp(next_free_nid);
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
