From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: [PATCH v3 1/2] f2fs: enable inline data by default
Date: Tue, 24 Mar 2015 10:20:27 +0800
Message-ID: <1427163628-3840-1-git-send-email-wanpeng.li@linux.intel.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Changman Lee <cm224.lee@samsung.com>, Chao Yu <chao2.yu@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Wanpeng Li <wanpeng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Enable inline_data feature by default since it brings us better
performance and space utilization and now has already stable.
Add another option noinline_data to disable it during mount.

Suggested-by: Jaegeuk Kim <jaegeuk@kernel.org>
Suggested-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
---
v2 -> v3:
 * reuse F2FS_MOUNT_INLINE_DATA
 * fix show both options "inline_data,noinline_data" in ->show_options
v1 -> v2:
 * retain inline_data option and enable it by default
 * add another noinline_data option

 Documentation/filesystems/f2fs.txt | 2 ++
 fs/f2fs/super.c                    | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 48e2123..e9e750e 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -144,6 +144,8 @@ extent_cache           Enable an extent cache based on rb-tree, it can cache
                        as many as extent which map between contiguous logical
                        address and physical address per inode, resulting in
                        increasing the cache hit ratio.
+noinline_data          Disable the inline data feature, inline data feature is
+                       enabled by default.
 
 ================================================================================
 DEBUGFS ENTRIES
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fc6857f..45aa843 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -58,6 +58,7 @@ enum {
 	Opt_nobarrier,
 	Opt_fastboot,
 	Opt_extent_cache,
+	Opt_noinline_data,
 	Opt_err,
 };
 
@@ -80,6 +81,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_nobarrier, "nobarrier"},
 	{Opt_fastboot, "fastboot"},
 	{Opt_extent_cache, "extent_cache"},
+	{Opt_noinline_data, "noinline_data"},
 	{Opt_err, NULL},
 };
 
@@ -372,6 +374,9 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_extent_cache:
 			set_opt(sbi, EXTENT_CACHE);
 			break;
+		case Opt_noinline_data:
+			clear_opt(sbi, INLINE_DATA);
+			break;
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
@@ -596,6 +601,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",disable_ext_identify");
 	if (test_opt(sbi, INLINE_DATA))
 		seq_puts(seq, ",inline_data");
+	else
+		seq_puts(seq, ",noinline_data");
 	if (test_opt(sbi, INLINE_DENTRY))
 		seq_puts(seq, ",inline_dentry");
 	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, FLUSH_MERGE))
@@ -991,6 +998,7 @@ try_onemore:
 	sbi->active_logs = NR_CURSEG_TYPE;
 
 	set_opt(sbi, BG_GC);
+	set_opt(sbi, INLINE_DATA);
 
 #ifdef CONFIG_F2FS_FS_XATTR
 	set_opt(sbi, XATTR_USER);
-- 
2.1.0

