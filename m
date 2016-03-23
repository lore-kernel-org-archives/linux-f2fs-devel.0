From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 7/7] fsck.f2fs: check sanity of superblock and
	fix any misalignment
Date: Wed, 23 Mar 2016 13:41:21 -0700
Message-ID: <1458765681-24123-7-git-send-email-jaegeuk@kernel.org>
References: <1458765681-24123-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aipb0-0008EX-I6
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Mar 2016 20:41:38 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aipaz-00021Q-JP
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Mar 2016 20:41:38 +0000
In-Reply-To: <1458765681-24123-1-git-send-email-jaegeuk@kernel.org>
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

This patch detects any corrupted superblock and fix misalignment when it finds,
which is synced with the f2fs kernel module.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 2 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 37a0025..67c681e 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -265,7 +265,90 @@ void print_sb_state(struct f2fs_super_block *sb)
 	MSG(0, "\n");
 }
 
-int sanity_check_raw_super(struct f2fs_super_block *sb)
+static inline int sanity_check_area_boundary(struct f2fs_super_block *sb,
+							u64 offset)
+{
+	u32 segment0_blkaddr = get_sb(segment0_blkaddr);
+	u32 cp_blkaddr = get_sb(cp_blkaddr);
+	u32 sit_blkaddr = get_sb(sit_blkaddr);
+	u32 nat_blkaddr = get_sb(nat_blkaddr);
+	u32 ssa_blkaddr = get_sb(ssa_blkaddr);
+	u32 main_blkaddr = get_sb(main_blkaddr);
+	u32 segment_count_ckpt = get_sb(segment_count_ckpt);
+	u32 segment_count_sit = get_sb(segment_count_sit);
+	u32 segment_count_nat = get_sb(segment_count_nat);
+	u32 segment_count_ssa = get_sb(segment_count_ssa);
+	u32 segment_count_main = get_sb(segment_count_main);
+	u32 segment_count = get_sb(segment_count);
+	u32 log_blocks_per_seg = get_sb(log_blocks_per_seg);
+	u64 main_end_blkaddr = main_blkaddr +
+				(segment_count_main << log_blocks_per_seg);
+	u64 seg_end_blkaddr = segment0_blkaddr +
+				(segment_count << log_blocks_per_seg);
+
+	if (segment0_blkaddr != cp_blkaddr) {
+		MSG(0, "\tMismatch segment0(%u) cp_blkaddr(%u)\n",
+				segment0_blkaddr, cp_blkaddr);
+		return -1;
+	}
+
+	if (cp_blkaddr + (segment_count_ckpt << log_blocks_per_seg) !=
+							sit_blkaddr) {
+		MSG(0, "\tWrong CP boundary, start(%u) end(%u) blocks(%u)\n",
+			cp_blkaddr, sit_blkaddr,
+			segment_count_ckpt << log_blocks_per_seg);
+		return -1;
+	}
+
+	if (sit_blkaddr + (segment_count_sit << log_blocks_per_seg) !=
+							nat_blkaddr) {
+		MSG(0, "\tWrong SIT boundary, start(%u) end(%u) blocks(%u)\n",
+			sit_blkaddr, nat_blkaddr,
+			segment_count_sit << log_blocks_per_seg);
+		return -1;
+	}
+
+	if (nat_blkaddr + (segment_count_nat << log_blocks_per_seg) !=
+							ssa_blkaddr) {
+		MSG(0, "\tWrong NAT boundary, start(%u) end(%u) blocks(%u)\n",
+			nat_blkaddr, ssa_blkaddr,
+			segment_count_nat << log_blocks_per_seg);
+		return -1;
+	}
+
+	if (ssa_blkaddr + (segment_count_ssa << log_blocks_per_seg) !=
+							main_blkaddr) {
+		MSG(0, "\tWrong SSA boundary, start(%u) end(%u) blocks(%u)\n",
+			ssa_blkaddr, main_blkaddr,
+			segment_count_ssa << log_blocks_per_seg);
+		return -1;
+	}
+
+	if (main_end_blkaddr > seg_end_blkaddr) {
+		MSG(0, "\tWrong MAIN_AREA, start(%u) end(%u) block(%u)\n",
+			main_blkaddr,
+			segment0_blkaddr +
+				(segment_count << log_blocks_per_seg),
+			segment_count_main << log_blocks_per_seg);
+		return -1;
+	} else if (main_end_blkaddr < seg_end_blkaddr) {
+		int err;
+
+		set_sb(segment_count, (main_end_blkaddr -
+				segment0_blkaddr) >> log_blocks_per_seg);
+
+		err = dev_write(sb, offset, sizeof(struct f2fs_super_block));
+		MSG(0, "Info: Fix alignment: %s, start(%u) end(%u) block(%u)\n",
+			err ? "failed": "done",
+			main_blkaddr,
+			segment0_blkaddr +
+				(segment_count << log_blocks_per_seg),
+			segment_count_main << log_blocks_per_seg);
+	}
+	return 0;
+}
+
+int sanity_check_raw_super(struct f2fs_super_block *sb, u64 offset)
 {
 	unsigned int blocksize;
 
@@ -279,6 +362,15 @@ int sanity_check_raw_super(struct f2fs_super_block *sb)
 	if (F2FS_BLKSIZE != blocksize)
 		return -1;
 
+	/* check log blocks per segment */
+	if (get_sb(log_blocks_per_seg) != 9)
+		return -1;
+
+	if (get_sb(log_sectorsize) > F2FS_MAX_LOG_SECTOR_SIZE ||
+			get_sb(log_sectorsize) < F2FS_MIN_LOG_SECTOR_SIZE)
+		return -1;
+
+	/* Currently, support 512/1024/2048/4096 bytes sector size */
 	if (get_sb(log_sectorsize) > F2FS_MAX_LOG_SECTOR_SIZE ||
 			get_sb(log_sectorsize) < F2FS_MIN_LOG_SECTOR_SIZE)
 		return -1;
@@ -287,6 +379,13 @@ int sanity_check_raw_super(struct f2fs_super_block *sb)
 						F2FS_MAX_LOG_SECTOR_SIZE)
 		return -1;
 
+	/* check reserved ino info */
+	if (get_sb(node_ino) != 1 || get_sb(meta_ino) != 2 ||
+					get_sb(root_ino) != 3)
+		return -1;
+
+	if (sanity_check_area_boundary(sb, offset))
+		return -1;
 	return 0;
 }
 
@@ -304,7 +403,7 @@ int validate_super_block(struct f2fs_sb_info *sbi, int block)
 	if (dev_read(sbi->raw_super, offset, sizeof(struct f2fs_super_block)))
 		return -1;
 
-	if (!sanity_check_raw_super(sbi->raw_super)) {
+	if (!sanity_check_raw_super(sbi->raw_super, offset)) {
 		/* get kernel version */
 		if (config.kd >= 0) {
 			dev_read_version(config.version, 0, VERSION_LEN);
-- 
2.6.3


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
