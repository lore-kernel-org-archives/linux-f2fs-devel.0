From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 6/6] f2fs: add noinline_dentry mount option
Date: Mon, 9 May 2016 19:56:35 +0800
Message-ID: <20160509115635.123946-6-yuchao0@huawei.com>
References: <20160509115635.123946-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160509115635.123946-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds noinline_dentry mount option.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/filesystems/f2fs.txt | 1 +
 fs/f2fs/super.c                    | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index e1c9f08..ee3a6c9 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -151,6 +151,7 @@ noinline_data          Disable the inline data feature, inline data feature is
                        enabled by default.
 data_flush             Enable data flushing before checkpoint in order to
                        persist data of regular and symlink.
+noextent_cache         Disable the inline dentry feature.
 
 ================================================================================
 DEBUGFS ENTRIES
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4a4f4bd..de2cb78 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -83,6 +83,7 @@ enum {
 	Opt_noinline_data,
 	Opt_data_flush,
 	Opt_fault_injection,
+	Opt_noinline_dentry,
 	Opt_err,
 };
 
@@ -109,6 +110,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_noinline_data, "noinline_data"},
 	{Opt_data_flush, "data_flush"},
 	{Opt_fault_injection, "fault_injection=%u"},
+	{Opt_noinline_dentry, "noinline_dentry"},
 	{Opt_err, NULL},
 };
 
@@ -463,6 +465,9 @@ static int parse_options(struct super_block *sb, char *options)
 				"FAULT_INJECTION was not selected");
 #endif
 			break;
+		case Opt_noinline_dentry:
+			clear_opt(sbi, INLINE_DENTRY);
+			break;
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
@@ -732,6 +737,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",noinline_data");
 	if (test_opt(sbi, INLINE_DENTRY))
 		seq_puts(seq, ",inline_dentry");
+	else
+		seq_puts(seq, ",noinline_dentry");
 	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, FLUSH_MERGE))
 		seq_puts(seq, ",flush_merge");
 	if (test_opt(sbi, NOBARRIER))
-- 
2.8.2.311.gee88674
