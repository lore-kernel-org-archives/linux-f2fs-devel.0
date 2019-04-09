From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 2/4] f2fs: fix debugfs status to reflect the online resize changes
Date: Tue,  9 Apr 2019 16:06:16 +0530
Message-ID: <1554806178-32728-2-git-send-email-stummala@codeaurora.org>
References: <1554806178-32728-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554806178-32728-1-git-send-email-stummala@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: Sahitya Tummala <stummala@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

The main area segs/secs/zones will be updated/changed after an
online resize. Hence, update the struct f2fs_stat_info as well
accordingly to show correct status in debugfs.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/debug.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 99e9a5c..7706049 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -27,8 +27,15 @@
 static void update_general_status(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_stat_info *si = F2FS_STAT(sbi);
+	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	int i;
 
+	/* these will be changed if online resize is done */
+	si->main_area_segs = le32_to_cpu(raw_super->segment_count_main);
+	si->main_area_sections = le32_to_cpu(raw_super->section_count);
+	si->main_area_zones = si->main_area_sections /
+				le32_to_cpu(raw_super->secs_per_zone);
+
 	/* validation check of the segment numbers */
 	si->hit_largest = atomic64_read(&sbi->read_hit_largest);
 	si->hit_cached = atomic64_read(&sbi->read_hit_cached);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
