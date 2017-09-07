From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs-tools: support CP_CRC_RECOVERY_FLAG check
Date: Thu, 7 Sep 2017 22:24:57 +0800
Message-ID: <1504794297-150702-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fsck/fsck.c  | 3 +++
 fsck/mount.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index cb341ba..f63a609 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1786,6 +1786,9 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 	set_cp(cp_pack_total_block_count, 8 + orphan_blks + get_sb(cp_payload));
 
 	flags = update_nat_bits_flags(sb, cp, flags);
+
+	if (is_set_ckpt_flags(cp, CP_CRC_RECOVERY_FLAG))
+		flags |= CP_CRC_RECOVERY_FLAG;
 	set_cp(ckpt_flags, flags);
 
 	set_cp(free_segment_count, get_free_segments(sbi));
diff --git a/fsck/mount.c b/fsck/mount.c
index 7a8aeae..0d77cce 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1902,6 +1902,9 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 	set_cp(cp_pack_total_block_count, 8 + orphan_blks + get_sb(cp_payload));
 
 	flags = update_nat_bits_flags(sb, cp, flags);
+
+	if (is_set_ckpt_flags(cp, CP_CRC_RECOVERY_FLAG))
+		flags |= CP_CRC_RECOVERY_FLAG;
 	set_cp(ckpt_flags, flags);
 
 	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CHECKSUM_OFFSET);
-- 
1.8.5.2
