From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH] f2fs: fix f2fs_show_options to show nodiscard mount option
Date: Fri, 24 May 2019 14:38:39 +0530
Message-ID: <1558688919-561-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: Sahitya Tummala <stummala@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Fix f2fs_show_options to show nodiscard mount option.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2c9d4f7..353feda 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1410,6 +1410,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",disable_roll_forward");
 	if (test_opt(sbi, DISCARD))
 		seq_puts(seq, ",discard");
+	else
+		seq_puts(seq, ",nodiscard");
 	if (test_opt(sbi, NOHEAP))
 		seq_puts(seq, ",no_heap");
 	else
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
