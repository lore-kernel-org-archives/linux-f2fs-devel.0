From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 4/9] f2fs: Suppress discard warning message for zoned block devices
Date: Fri, 28 Oct 2016 16:55:32 +0900
Message-ID: <1477641337-12321-5-git-send-email-damien.lemoal@wdc.com>
References: <1477641337-12321-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1477641337-12321-1-git-send-email-damien.lemoal@wdc.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>, Damien Le Moal <damien.lemoal@wdc.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

For zoned block devices, discard is replaced by zone reset. So
do not warn if the device does not supports discard.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c6e9b94..2313234 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -412,7 +412,7 @@ static int parse_options(struct super_block *sb, char *options)
 			q = bdev_get_queue(sb->s_bdev);
 			if (blk_queue_discard(q)) {
 				set_opt(sbi, DISCARD);
-			} else {
+			} else if (!f2fs_sb_mounted_blkzoned(sb)) {
 				f2fs_msg(sb, KERN_WARNING,
 					"mounting with \"discard\" option, but "
 					"the device does not support discard");
-- 
2.7.4

