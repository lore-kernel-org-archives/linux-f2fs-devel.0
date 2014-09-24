From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH 2/6 v2] f2fs: add a new mount option for inline dir
Date: Wed, 24 Sep 2014 18:16:13 +0800
Message-ID: <003d01cfd7e0$ac6b40f0$0541c2d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Adds a new mount option 'inline_dentry' for inline dir.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bb6b568..9e03488 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -51,6 +51,7 @@ enum {
 	Opt_disable_ext_identify,
 	Opt_inline_xattr,
 	Opt_inline_data,
+	Opt_inline_dentry,
 	Opt_flush_merge,
 	Opt_nobarrier,
 	Opt_err,
@@ -69,6 +70,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_disable_ext_identify, "disable_ext_identify"},
 	{Opt_inline_xattr, "inline_xattr"},
 	{Opt_inline_data, "inline_data"},
+	{Opt_inline_dentry, "inline_dentry"},
 	{Opt_flush_merge, "flush_merge"},
 	{Opt_nobarrier, "nobarrier"},
 	{Opt_err, NULL},
@@ -340,6 +342,9 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_inline_data:
 			set_opt(sbi, INLINE_DATA);
 			break;
+		case Opt_inline_dentry:
+			set_opt(sbi, INLINE_DENTRY);
+			break;
 		case Opt_flush_merge:
 			set_opt(sbi, FLUSH_MERGE);
 			break;
@@ -560,6 +565,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",disable_ext_identify");
 	if (test_opt(sbi, INLINE_DATA))
 		seq_puts(seq, ",inline_data");
+	if (test_opt(sbi, INLINE_DENTRY))
+		seq_puts(seq, ",inline_dentry");
 	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, FLUSH_MERGE))
 		seq_puts(seq, ",flush_merge");
 	if (test_opt(sbi, NOBARRIER))
-- 
2.0.1.474.g72c7794
