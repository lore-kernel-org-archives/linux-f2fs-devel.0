From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH] f2fs: add error prints for debugging mount failure
Date: Thu, 23 May 2019 09:49:17 +0530
Message-ID: <1558585157-9349-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: Sahitya Tummala <stummala@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Add error prints to get more details on the mount failure.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/segment.c | 6 +++++-
 fs/f2fs/super.c   | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4896443..bdc6956 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3567,8 +3567,12 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
 
 	/* sanity check for summary blocks */
 	if (nats_in_cursum(nat_j) > NAT_JOURNAL_ENTRIES ||
-			sits_in_cursum(sit_j) > SIT_JOURNAL_ENTRIES)
+			sits_in_cursum(sit_j) > SIT_JOURNAL_ENTRIES) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+			"invalid journal entries nats %u sits %u\n",
+			nats_in_cursum(nat_j), sits_in_cursum(sit_j));
 		return -EINVAL;
+	}
 
 	return 0;
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 52f1497..2c9d4f7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3413,13 +3413,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	err = f2fs_build_segment_manager(sbi);
 	if (err) {
 		f2fs_msg(sb, KERN_ERR,
-			"Failed to initialize F2FS segment manager");
+			"Failed to initialize F2FS segment manager (%d)", err);
 		goto free_sm;
 	}
 	err = f2fs_build_node_manager(sbi);
 	if (err) {
 		f2fs_msg(sb, KERN_ERR,
-			"Failed to initialize F2FS node manager");
+			"Failed to initialize F2FS node manager (%d)", err);
 		goto free_nm;
 	}
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
