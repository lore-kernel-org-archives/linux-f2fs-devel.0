From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 1/4] f2fs: add F2FS_IOC_RESIZE_FROM_END for compat_ioctl
Date: Tue,  9 Apr 2019 16:06:15 +0530
Message-ID: <1554806178-32728-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: Sahitya Tummala <stummala@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Add F2FS_IOC_RESIZE_FROM_END for f2fs_compat_ioctl() as well.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 42adfc2..0514935 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3159,6 +3159,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_GET_PIN_FILE:
 	case F2FS_IOC_SET_PIN_FILE:
 	case F2FS_IOC_PRECACHE_EXTENTS:
+	case F2FS_IOC_RESIZE_FROM_END:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
