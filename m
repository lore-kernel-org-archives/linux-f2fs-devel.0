From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 6/9] f2fs: Do not allow adaptive mode for host-managed zoned block devices
Date: Fri, 28 Oct 2016 16:55:34 +0900
Message-ID: <1477641337-12321-7-git-send-email-damien.lemoal@wdc.com>
References: <1477641337-12321-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1477641337-12321-1-git-send-email-damien.lemoal@wdc.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>, Damien Le Moal <damien.lemoal@wdc.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

The LFS mode is mandatory for host-managed zoned block devices as
update in place optimizations are not possible for segments in
sequential zones.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2c8a12e..58fd69d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -518,6 +518,13 @@ static int parse_options(struct super_block *sb, char *options)
 				return -ENOMEM;
 			if (strlen(name) == 8 &&
 					!strncmp(name, "adaptive", 8)) {
+				if (f2fs_sb_mounted_blkzoned(sb)) {
+					f2fs_msg(sb, KERN_WARNING,
+						 "adaptive mode is not allowed with "
+						 "zoned block device feature");
+					kfree(name);
+					return -EINVAL;
+				}
 				set_opt_mode(sbi, F2FS_MOUNT_ADAPTIVE);
 			} else if (strlen(name) == 3 &&
 					!strncmp(name, "lfs", 3)) {
-- 
2.7.4

