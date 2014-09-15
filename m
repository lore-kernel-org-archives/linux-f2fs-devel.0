From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH 4/5] f2fs: fix to clean previous mount option when
 remount_fs
Date: Mon, 15 Sep 2014 18:04:44 +0800
Message-ID: <003001cfd0cc$96f9e8e0$c4edbaa0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In manual of mount, we descript remount as below:

"mount -o remount,rw /dev/foo /dir
After  this call all old mount options are replaced and arbitrary stuff from
fstab is ignored, except the loop= option which is internally generated and
maintained by the mount command."

Previously f2fs do not clear up old mount options when remount_fs, so we have no
chance of disabling previous option (e.g. flush_merge). Fix it.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 54444bb..90fcbe0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -616,6 +616,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	org_mount_opt = sbi->mount_opt;
 	active_logs = sbi->active_logs;
 
+	sbi->mount_opt.opt = 0;
+	sbi->active_logs = NR_CURSEG_TYPE;
+
 	/* parse mount options */
 	err = parse_options(sb, data);
 	if (err)
-- 
2.0.1.474.g72c7794
