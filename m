From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH] f2fs: Fix deadlock in shutdown ioctl
Date: Thu, 10 May 2018 18:50:44 +0530
Message-ID: <1525958444-5579-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

f2fs_ioc_shutdown() ioctl gets stuck in the below path
when going down with full sync (F2FS_GOING_DOWN_FULLSYNC)
option.

__switch_to+0x90/0xc4
percpu_down_write+0x8c/0xc0
freeze_super+0xec/0x1e4
freeze_bdev+0xc4/0xcc
f2fs_ioctl+0xc0c/0x1ce0
f2fs_compat_ioctl+0x98/0x1f0

Fix this by not holding write access during this ioctl.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/file.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b926df7..2c2e61b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1835,10 +1835,6 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 	if (get_user(in, (__u32 __user *)arg))
 		return -EFAULT;
 
-	ret = mnt_want_write_file(filp);
-	if (ret)
-		return ret;
-
 	switch (in) {
 	case F2FS_GOING_DOWN_FULLSYNC:
 		sb = freeze_bdev(sb->s_bdev);
@@ -1878,7 +1874,6 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 
 	f2fs_update_time(sbi, REQ_TIME);
 out:
-	mnt_drop_write_file(filp);
 	return ret;
 }
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
