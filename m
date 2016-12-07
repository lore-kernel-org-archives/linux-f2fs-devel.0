From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: detect wrong layout
Date: Tue,  6 Dec 2016 17:16:24 -0800
Message-ID: <20161207011625.15591-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previous mkfs.f2fs allows small partition inappropriately, so f2fs should detect
that as well.

Refer this in f2fs-tools.

mkfs.f2fs: detect small partition by overprovision ratio and # of segments

Reported-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.h |  2 ++
 fs/f2fs/super.c   | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 89ab4301ef02..9d44ce83acb2 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -18,6 +18,8 @@
 #define DEF_RECLAIM_PREFREE_SEGMENTS	5	/* 5% over total segments */
 #define DEF_MAX_RECLAIM_PREFREE_SEGMENTS	4096	/* 8GB in maximum */
 
+#define F2FS_MIN_SEGMENTS	9 /* SB + 2 (CP + SIT + NAT) + SSA + MAIN */
+
 /* L: Logical segment # in volume, R: Relative segment # in main area */
 #define GET_L2R_SEGNO(free_i, segno)	(segno - free_i->start_segno)
 #define GET_R2L_SEGNO(free_i, segno)	(segno + free_i->start_segno)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7591d2d7b612..1a526474b332 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1452,6 +1452,7 @@ int sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	unsigned int total, fsmeta;
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	unsigned int ovp_segments, reserved_segments;
 
 	total = le32_to_cpu(raw_super->segment_count);
 	fsmeta = le32_to_cpu(raw_super->segment_count_ckpt);
@@ -1463,6 +1464,16 @@ int sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	if (unlikely(fsmeta >= total))
 		return 1;
 
+	ovp_segments = le32_to_cpu(ckpt->overprov_segment_count);
+	reserved_segments = le32_to_cpu(ckpt->rsvd_segment_count);
+
+	if (unlikely(fsmeta < F2FS_MIN_SEGMENTS ||
+			ovp_segments == 0 || reserved_segments == 0)) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+			"Wrong layout: check mkfs.f2fs version");
+		return 1;
+	}
+
 	if (unlikely(f2fs_cp_error(sbi))) {
 		f2fs_msg(sbi->sb, KERN_ERR, "A bug case: need to run fsck");
 		return 1;
-- 
2.11.0
