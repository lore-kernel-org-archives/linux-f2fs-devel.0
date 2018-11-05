From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] f2fs: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date: Mon,  5 Nov 2018 09:41:48 -0500
Message-ID: <20181105144148.6131-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 fs/f2fs/debug.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 214a968962a1..ef827c0d0379 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -428,18 +428,7 @@ static int stat_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int stat_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, stat_show, inode->i_private);
-}
-
-static const struct file_operations stat_fops = {
-	.owner = THIS_MODULE,
-	.open = stat_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(stat);
 
 int f2fs_build_stats(struct f2fs_sb_info *sbi)
 {
-- 
2.17.0
