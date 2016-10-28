From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 3/9] f2fs: Check zoned block feature for host-managed zoned block devices
Date: Fri, 28 Oct 2016 16:55:31 +0900
Message-ID: <1477641337-12321-4-git-send-email-damien.lemoal@wdc.com>
References: <1477641337-12321-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1477641337-12321-1-git-send-email-damien.lemoal@wdc.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>, Damien Le Moal <damien.lemoal@wdc.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

The F2FS_FEATURE_BLKZONED feature indicates that the drive was formatted
 with zone alignment optimization. This is optional for host-aware
devices, but mandatory for host-managed zoned block devices.
So check that the feature is set in this latter case.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/super.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a83df29..c6e9b94 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1642,6 +1642,26 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_fs_info = sbi;
 	sbi->raw_super = raw_super;
 
+	/*
+	 * The BLKZONED feature indicates that the drive was formatted with
+	 * zone alignment optimization. This is optional for host-aware
+	 * devices, but mandatory for host-managed zoned block devices.
+	 */
+#ifndef CONFIG_BLK_DEV_ZONED
+	if (f2fs_sb_mounted_blkzoned(sb)) {
+		f2fs_msg(sb, KERN_ERR,
+			 "Zoned block device support is not enabled\n");
+		goto free_sb_buf;
+	}
+#else
+	if (bdev_zoned_model(sb->s_bdev) == BLK_ZONED_HM &&
+	    !f2fs_sb_mounted_blkzoned(sb)) {
+		f2fs_msg(sb, KERN_ERR,
+			 "Zoned block device feature not enabled\n");
+		goto free_sb_buf;
+	}
+#endif
+
 	default_options(sbi);
 	/* parse mount options */
 	options = kstrdup((const char *)data, GFP_KERNEL);
-- 
2.7.4

