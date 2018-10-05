From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 2/2] f2fs: update REQ_TIME in f2fs_cross_rename()
Date: Fri,  5 Oct 2018 10:47:40 +0530
Message-ID: <1538716660-31572-2-git-send-email-stummala@codeaurora.org>
References: <1538716660-31572-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538716660-31572-1-git-send-email-stummala@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Update REQ_TIME in the missing path - f2fs_cross_rename().

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/namei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a146327..e37af23 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1154,6 +1154,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
 		f2fs_sync_fs(sbi->sb, 1);
+
+	f2fs_update_time(sbi, REQ_TIME);
 	return 0;
 out_new_dir:
 	if (new_dir_entry) {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
