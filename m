From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: setting discard option in parse_options()
Date: Mon, 08 Jun 2015 13:20:10 +0800
Message-ID: <004501d0a1aa$e4dfd150$ae9f73f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

For the first mount of f2fs image with realtime discard option, we will
disable discard option if device is not supported, but for remount
operation, our discard option can still be set, this should be avoided.

This patch moves configuring of discard option to parse_options() to fix
this issue.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/super.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fbbf785..a06b0b4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -258,6 +258,7 @@ static void init_once(void *foo)
 static int parse_options(struct super_block *sb, char *options)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	struct request_queue *q;
 	substring_t args[MAX_OPT_ARGS];
 	char *p, *name;
 	int arg = 0;
@@ -302,7 +303,14 @@ static int parse_options(struct super_block *sb, char *options)
 				return -EINVAL;
 			break;
 		case Opt_discard:
-			set_opt(sbi, DISCARD);
+			q = bdev_get_queue(sb->s_bdev);
+			if (blk_queue_discard(q)) {
+				set_opt(sbi, DISCARD);
+			} else {
+				f2fs_msg(sb, KERN_WARNING,
+					"mounting with \"discard\" option, but "
+					"the device does not support discard");
+			}
 			break;
 		case Opt_noheap:
 			set_opt(sbi, NOHEAP);
@@ -1237,16 +1245,6 @@ try_onemore:
 		proc_create_data("segment_info", S_IRUGO, sbi->s_proc,
 				 &f2fs_seq_segment_info_fops, sb);
 
-	if (test_opt(sbi, DISCARD)) {
-		struct request_queue *q = bdev_get_queue(sb->s_bdev);
-		if (!blk_queue_discard(q)) {
-			f2fs_msg(sb, KERN_WARNING,
-					"mounting with \"discard\" option, but "
-					"the device does not support discard");
-			clear_opt(sbi, DISCARD);
-		}
-	}
-
 	sbi->s_kobj.kset = f2fs_kset;
 	init_completion(&sbi->s_kobj_unregister);
 	err = kobject_init_and_add(&sbi->s_kobj, &f2fs_ktype, NULL,
-- 
2.4.2
