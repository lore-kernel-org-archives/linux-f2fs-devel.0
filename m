From: Kaixu Xia <xiakaixu@huawei.com>
Subject: [PATCH] f2fs: show the fault injection mount option
Date: Fri, 27 Jan 2017 09:35:37 +0800
Message-ID: <1485480937-21008-1-git-send-email-xiakaixu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: yuchao0@huawei.com, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, xiakaixu@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch shows the fault injection mount option in
f2fs_show_options().

Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
---
 fs/f2fs/super.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 46fd30d..47880b4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -540,6 +540,7 @@ static int parse_options(struct super_block *sb, char *options)
 				return -EINVAL;
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 			f2fs_build_fault_attr(sbi, arg);
+			set_opt(sbi, FAULT_INJECTION);
 #else
 			f2fs_msg(sb, KERN_INFO,
 				"FAULT_INJECTION was not selected");
@@ -918,6 +919,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (test_opt(sbi, LFS))
 		seq_puts(seq, "lfs");
 	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (test_opt(sbi, FAULT_INJECTION))
+		seq_puts(seq, ",fault_injection");
+#endif
 
 	return 0;
 }
-- 
1.7.10.4
