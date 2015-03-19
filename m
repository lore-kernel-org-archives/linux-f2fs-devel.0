From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: [PATCH] f2fs: enable inline data by default
Date: Thu, 19 Mar 2015 13:11:35 +0800
Message-ID: <1426741895-7647-1-git-send-email-wanpeng.li@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Changman Lee <cm224.lee@samsung.com>, Chao Yu <chao2.yu@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Wanpeng Li <wanpeng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Enable inline_data feature by default since it brings us better 
performance and space utilization and now has already stable.

Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
---
 Documentation/filesystems/f2fs.txt |  2 --
 fs/f2fs/f2fs.h                     | 11 +++++------
 fs/f2fs/inline.c                   |  3 ---
 fs/f2fs/super.c                    |  7 -------
 4 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 48e2123..6c9c947 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -122,8 +122,6 @@ active_logs=%u         Support configuring the number of active logs. In the
 disable_ext_identify   Disable the extension list configured by mkfs, so f2fs
                        does not aware of cold files such as media files.
 inline_xattr           Enable the inline xattrs feature.
-inline_data            Enable the inline data feature: New created small(<~3.4k)
-                       files can be written into inode block.
 inline_dentry          Enable the inline dir feature: data in new created
                        directory entries can be written into inode block. The
                        space of inode block which is used to store inline
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f2909c6..5849520 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -45,12 +45,11 @@
 #define F2FS_MOUNT_POSIX_ACL		0x00000020
 #define F2FS_MOUNT_DISABLE_EXT_IDENTIFY	0x00000040
 #define F2FS_MOUNT_INLINE_XATTR		0x00000080
-#define F2FS_MOUNT_INLINE_DATA		0x00000100
-#define F2FS_MOUNT_INLINE_DENTRY	0x00000200
-#define F2FS_MOUNT_FLUSH_MERGE		0x00000400
-#define F2FS_MOUNT_NOBARRIER		0x00000800
-#define F2FS_MOUNT_FASTBOOT		0x00001000
-#define F2FS_MOUNT_EXTENT_CACHE		0x00002000
+#define F2FS_MOUNT_INLINE_DENTRY	0x00000100
+#define F2FS_MOUNT_FLUSH_MERGE		0x00000200
+#define F2FS_MOUNT_NOBARRIER		0x00000400
+#define F2FS_MOUNT_FASTBOOT		0x00000800
+#define F2FS_MOUNT_EXTENT_CACHE		0x00001000
 
 #define clear_opt(sbi, option)	(sbi->mount_opt.opt &= ~F2FS_MOUNT_##option)
 #define set_opt(sbi, option)	(sbi->mount_opt.opt |= F2FS_MOUNT_##option)
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index d3e0599..d67bc0d 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -15,9 +15,6 @@
 
 bool f2fs_may_inline(struct inode *inode)
 {
-	if (!test_opt(F2FS_I_SB(inode), INLINE_DATA))
-		return false;
-
 	if (f2fs_is_atomic_file(inode))
 		return false;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fc6857f..f008222 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -52,7 +52,6 @@ enum {
 	Opt_active_logs,
 	Opt_disable_ext_identify,
 	Opt_inline_xattr,
-	Opt_inline_data,
 	Opt_inline_dentry,
 	Opt_flush_merge,
 	Opt_nobarrier,
@@ -74,7 +73,6 @@ static match_table_t f2fs_tokens = {
 	{Opt_active_logs, "active_logs=%u"},
 	{Opt_disable_ext_identify, "disable_ext_identify"},
 	{Opt_inline_xattr, "inline_xattr"},
-	{Opt_inline_data, "inline_data"},
 	{Opt_inline_dentry, "inline_dentry"},
 	{Opt_flush_merge, "flush_merge"},
 	{Opt_nobarrier, "nobarrier"},
@@ -354,9 +352,6 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_disable_ext_identify:
 			set_opt(sbi, DISABLE_EXT_IDENTIFY);
 			break;
-		case Opt_inline_data:
-			set_opt(sbi, INLINE_DATA);
-			break;
 		case Opt_inline_dentry:
 			set_opt(sbi, INLINE_DENTRY);
 			break;
@@ -594,8 +589,6 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 #endif
 	if (test_opt(sbi, DISABLE_EXT_IDENTIFY))
 		seq_puts(seq, ",disable_ext_identify");
-	if (test_opt(sbi, INLINE_DATA))
-		seq_puts(seq, ",inline_data");
 	if (test_opt(sbi, INLINE_DENTRY))
 		seq_puts(seq, ",inline_dentry");
 	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, FLUSH_MERGE))
-- 
2.1.0
