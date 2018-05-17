From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH v2] f2fs: Fix deadlock in shutdown ioctl
Date: Thu, 17 May 2018 13:33:31 +0530
Message-ID: <1526544211-26218-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

f2fs_ioc_shutdown() ioctl gets stuck in the below path
when issued with F2FS_GOING_DOWN_FULLSYNC option.

__switch_to+0x90/0xc4
percpu_down_write+0x8c/0xc0
freeze_super+0xec/0x1e4
freeze_bdev+0xc4/0xcc
f2fs_ioctl+0xc0c/0x1ce0
f2fs_compat_ioctl+0x98/0x1f0

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v2:
remove lock coverage for only F2FS_GOING_DOWN_FULLSYNC case as suggested by Chao.

 fs/f2fs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6b94f19..5a132c9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1857,6 +1857,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 
 	switch (in) {
 	case F2FS_GOING_DOWN_FULLSYNC:
+		mnt_drop_write_file(filp);
 		sb = freeze_bdev(sb->s_bdev);
 		if (IS_ERR(sb)) {
 			ret = PTR_ERR(sb);
@@ -1894,7 +1895,8 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 
 	f2fs_update_time(sbi, REQ_TIME);
 out:
-	mnt_drop_write_file(filp);
+	if (in != F2FS_GOING_DOWN_FULLSYNC)
+		mnt_drop_write_file(filp);
 	return ret;
 }
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
