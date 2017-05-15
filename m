From: Jin Qian <jinqian@google.com>
Subject: [PATCHv3 1/1] f2fs: sanity check checkpoint segno and blkoff
Date: Mon, 15 May 2017 10:45:08 -0700
Message-ID: <20170515174508.7800-1-jinqian@android.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org, jinqian@google.com, Jin Qian <jinqian@android.com>, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Make sure segno and blkoff read from raw image are valid.

Cc: stable@vger.kernel.org
Signed-off-by: Jin Qian <jinqian@google.com>
---
 fs/f2fs/super.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 83355ec4a92c..c41b48e4cc33 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1521,6 +1521,8 @@ int sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	unsigned int ovp_segments, reserved_segments;
+	unsigned int main_segs, blocks_per_seg;
+	int i;
 
 	total = le32_to_cpu(raw_super->segment_count);
 	fsmeta = le32_to_cpu(raw_super->segment_count_ckpt);
@@ -1542,6 +1544,22 @@ int sanity_check_ckpt(struct f2fs_sb_info *sbi)
 		return 1;
 	}
 
+	main_segs = le32_to_cpu(sbi->raw_super->segment_count_main);
+	blocks_per_seg = sbi->blocks_per_seg;
+
+	for (i = 0; i < NR_CURSEG_NODE_TYPE; i++) {
+		if (le32_to_cpu(ckpt->cur_node_segno[i]) >= main_segs ||
+		    le16_to_cpu(ckpt->cur_node_blkoff[i]) >= blocks_per_seg) {
+			return 1;
+		}
+	}
+	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
+		if (le32_to_cpu(ckpt->cur_data_segno[i]) >= main_segs ||
+		    le16_to_cpu(ckpt->cur_data_blkoff[i]) >= blocks_per_seg) {
+			return 1;
+		}
+	}
+
 	if (unlikely(f2fs_cp_error(sbi))) {
 		f2fs_msg(sbi->sb, KERN_ERR, "A bug case: need to run fsck");
 		return 1;
-- 
2.13.0.rc2.291.g57267f2277-goog
