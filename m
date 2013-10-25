From: Huajun Li <huajun.li.lee@gmail.com>
Subject: [f2fs-dev 2/5] f2fs: Add a new mount option: inline_data
Date: Sat, 26 Oct 2013 00:01:56 +0800
Message-ID: <1382716919-23345-3-git-send-email-huajun.li.lee@gmail.com>
References: <1382716919-23345-1-git-send-email-huajun.li.lee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382716919-23345-1-git-send-email-huajun.li.lee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Huajun Li <huajun.li@intel.com>, Haicheng Li <haicheng.li@linux.intel.com>, Weihong Xu <weihong.xu@intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Huajun Li <huajun.li@intel.com>

Add a mount option: inline_data. If the mount option is set,
data of New created small files can be stored in their inode.

Signed-off-by: Huajun Li <huajun.li@intel.com>
Signed-off-by: Haicheng Li <haicheng.li@linux.intel.com>
Signed-off-by: Weihong Xu <weihong.xu@intel.com>
---
 fs/f2fs/super.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e42351c..e8ad7f2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -50,6 +50,7 @@ enum {
 	Opt_active_logs,
 	Opt_disable_ext_identify,
 	Opt_inline_xattr,
+	Opt_inline_data,
 	Opt_err,
 };
 
@@ -65,6 +66,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_active_logs, "active_logs=%u"},
 	{Opt_disable_ext_identify, "disable_ext_identify"},
 	{Opt_inline_xattr, "inline_xattr"},
+	{Opt_inline_data, "inline_data"},
 	{Opt_err, NULL},
 };
 
@@ -311,6 +313,9 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_disable_ext_identify:
 			set_opt(sbi, DISABLE_EXT_IDENTIFY);
 			break;
+		case Opt_inline_data:
+			set_opt(sbi, INLINE_DATA);
+			break;
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
@@ -508,7 +513,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 #endif
 	if (test_opt(sbi, DISABLE_EXT_IDENTIFY))
 		seq_puts(seq, ",disable_ext_identify");
-
+	if (test_opt(sbi, INLINE_DATA))
+		seq_puts(seq, ",inline_data");
 	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
 
 	return 0;
-- 
1.7.9.5
