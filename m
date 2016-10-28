From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 5/9] f2fs: Always enable discard for zoned blocks devices
Date: Fri, 28 Oct 2016 16:55:33 +0900
Message-ID: <1477641337-12321-6-git-send-email-damien.lemoal@wdc.com>
References: <1477641337-12321-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1477641337-12321-1-git-send-email-damien.lemoal@wdc.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>, Damien Le Moal <damien.lemoal@wdc.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Zone write pointer reset acts as discard for zoned block
devices. So if the zoned block device feature is enabled,
always declare that discard is enabled, even if the device
does not actually support the command.
For the same reason, prevent the use the "nodicard" mount
option.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/f2fs.h  | 14 +++++++-------
 fs/f2fs/super.c |  5 +++++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2fc771a..beb2093 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1105,13 +1105,6 @@ static inline void clear_ckpt_flags(struct f2fs_sb_info *sbi, unsigned int f)
 	spin_unlock(&sbi->cp_lock);
 }
 
-static inline bool f2fs_discard_en(struct f2fs_sb_info *sbi)
-{
-	struct request_queue *q = bdev_get_queue(sbi->sb->s_bdev);
-
-	return blk_queue_discard(q);
-}
-
 static inline void f2fs_lock_op(struct f2fs_sb_info *sbi)
 {
 	down_read(&sbi->cp_rwsem);
@@ -2417,6 +2410,13 @@ static inline int f2fs_sb_mounted_blkzoned(struct super_block *sb)
 	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_BLKZONED);
 }
 
+static inline bool f2fs_discard_en(struct f2fs_sb_info *sbi)
+{
+	struct request_queue *q = bdev_get_queue(sbi->sb->s_bdev);
+
+	return blk_queue_discard(q) || f2fs_sb_mounted_blkzoned(sbi->sb);
+}
+
 static inline void set_opt_mode(struct f2fs_sb_info *sbi, unsigned int mt)
 {
 	clear_opt(sbi, ADAPTIVE);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2313234..2c8a12e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -419,6 +419,11 @@ static int parse_options(struct super_block *sb, char *options)
 			}
 			break;
 		case Opt_nodiscard:
+			if (f2fs_sb_mounted_blkzoned(sb)) {
+				f2fs_msg(sb, KERN_WARNING,
+					"discard is required for zoned block devices");
+				return -EINVAL;
+			}
 			clear_opt(sbi, DISCARD);
 			break;
 		case Opt_noheap:
-- 
2.7.4

