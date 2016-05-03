From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 01/11] f2fs: introduce macros for proc entries
Date: Tue,  3 May 2016 11:21:38 -0700
Message-ID: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This adds macros to be used multiple proc entries.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 19a85cf..b006de6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -745,19 +745,22 @@ static int segment_info_seq_show(struct seq_file *seq, void *offset)
 	return 0;
 }
 
-static int segment_info_open_fs(struct inode *inode, struct file *file)
-{
-	return single_open(file, segment_info_seq_show, PDE_DATA(inode));
-}
-
-static const struct file_operations f2fs_seq_segment_info_fops = {
-	.owner = THIS_MODULE,
-	.open = segment_info_open_fs,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
+#define F2FS_PROC_FILE_DEF(_name)					\
+static int _name##_open_fs(struct inode *inode, struct file *file)	\
+{									\
+	return single_open(file, _name##_seq_show, PDE_DATA(inode));	\
+}									\
+									\
+static const struct file_operations f2fs_seq_##_name##_fops = {		\
+	.owner = THIS_MODULE,						\
+	.open = _name##_open_fs,					\
+	.read = seq_read,						\
+	.llseek = seq_lseek,						\
+	.release = single_release,					\
 };
 
+F2FS_PROC_FILE_DEF(segment_info);
+
 static void default_options(struct f2fs_sb_info *sbi)
 {
 	/* init some FS parameters */
-- 
2.6.3
