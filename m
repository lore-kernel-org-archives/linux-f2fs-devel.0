From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v3 07/10] f2fs: add a mount option for rb-tree extent cache
Date: Thu, 05 Feb 2015 17:55:51 +0800
Message-ID: <000401d0412a$068b2ac0$13a18040$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds a mount option 'extent_cache' in f2fs.

It is try to use a rb-tree based extent cache to cache more mapping information
with less memory if this option is set, otherwise we will use the original one
extent info cache.

Suggested-by: Changman Lee <cm224.lee@samsung.com>
Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 Documentation/filesystems/f2fs.txt | 4 ++++
 fs/f2fs/f2fs.h                     | 1 +
 fs/f2fs/super.c                    | 7 +++++++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 6758aa3..d105c5b 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -140,6 +140,10 @@ nobarrier              This option can be used if underlying storage guarantees
 fastboot               This option is used when a system wants to reduce mount
                        time as much as possible, even though normal performance
 		       can be sacrificed.
+extent_cache           Enable an extent cache based on rb-tree, it can cache
+                       as many as extent which map between contiguous logical
+                       address and physical address per inode, resulting in
+                       increasing the cache hit ratio.
 
 ================================================================================
 DEBUGFS ENTRIES
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e184847..507e604 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -50,6 +50,7 @@
 #define F2FS_MOUNT_FLUSH_MERGE		0x00000400
 #define F2FS_MOUNT_NOBARRIER		0x00000800
 #define F2FS_MOUNT_FASTBOOT		0x00001000
+#define F2FS_MOUNT_EXTENT_CACHE		0x00002000
 
 #define clear_opt(sbi, option)	(sbi->mount_opt.opt &= ~F2FS_MOUNT_##option)
 #define set_opt(sbi, option)	(sbi->mount_opt.opt |= F2FS_MOUNT_##option)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8557582..07a5564 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -57,6 +57,7 @@ enum {
 	Opt_flush_merge,
 	Opt_nobarrier,
 	Opt_fastboot,
+	Opt_extent_cache,
 	Opt_err,
 };
 
@@ -78,6 +79,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_flush_merge, "flush_merge"},
 	{Opt_nobarrier, "nobarrier"},
 	{Opt_fastboot, "fastboot"},
+	{Opt_extent_cache, "extent_cache"},
 	{Opt_err, NULL},
 };
 
@@ -365,6 +367,9 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_fastboot:
 			set_opt(sbi, FASTBOOT);
 			break;
+		case Opt_extent_cache:
+			set_opt(sbi, EXTENT_CACHE);
+			break;
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
@@ -597,6 +602,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",nobarrier");
 	if (test_opt(sbi, FASTBOOT))
 		seq_puts(seq, ",fastboot");
+	if (test_opt(sbi, EXTENT_CACHE))
+		seq_puts(seq, ",extent_cache");
 	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
 
 	return 0;
-- 
2.2.1
