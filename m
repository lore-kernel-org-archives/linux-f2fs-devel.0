From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: add proc entry to monitor current usage of segments
Date: Fri, 05 Jul 2013 17:42:29 +0900
Message-ID: <1373013749-10370-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

You can monitor valid block counts of whole segments in:
  /proc/fs/f2fs/sdb1/segment_info.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 82e187f..e3a611d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -365,6 +365,7 @@ enum page_type {
 
 struct f2fs_sb_info {
 	struct super_block *sb;			/* pointer to VFS super block */
+	struct proc_dir_entry *s_proc;		/* proc entry */
 	struct buffer_head *raw_super_buf;	/* buffer head of raw sb */
 	struct f2fs_super_block *raw_super;	/* raw super block pointer */
 	int s_dirty;				/* dirty flag for checkpoint */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d48d995..1ed0279 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -18,6 +18,7 @@
 #include <linux/parser.h>
 #include <linux/mount.h>
 #include <linux/seq_file.h>
+#include <linux/proc_fs.h>
 #include <linux/random.h>
 #include <linux/exportfs.h>
 #include <linux/blkdev.h>
@@ -31,6 +32,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/f2fs.h>
 
+static struct proc_dir_entry *f2fs_proc_root;
 static struct kmem_cache *f2fs_inode_cachep;
 
 enum {
@@ -404,6 +406,11 @@ static void f2fs_put_super(struct super_block *sb)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 
+	if (sbi->s_proc) {
+		remove_proc_entry("segment_info", sbi->s_proc);
+		remove_proc_entry(sb->s_id, f2fs_proc_root);
+	}
+
 	f2fs_destroy_stats(sbi);
 	stop_gc_thread(sbi);
 
@@ -521,6 +528,36 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
+static int segment_info_seq_show(struct seq_file *seq, void *offset)
+{
+	struct super_block *sb = seq->private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	unsigned int total_segs = le32_to_cpu(sbi->raw_super->segment_count_main);
+	int i;
+
+	for (i = 0; i < total_segs; i++) {
+		seq_printf(seq, "%u", get_valid_blocks(sbi, i, 1));
+		if (i != 0 && (i % 10) == 0)
+			seq_puts(seq, "\n");
+		else
+			seq_puts(seq, " ");
+	}
+	return 0;
+}
+
+static int segment_info_open_fs(struct inode *inode, struct file *file)
+{
+	return single_open(file, segment_info_seq_show, PDE_DATA(inode));
+}
+
+static const struct file_operations f2fs_seq_segment_info_fops = {
+	.owner = THIS_MODULE,
+	.open = segment_info_open_fs,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
 static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -947,6 +984,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		goto fail;
 
+	if (f2fs_proc_root)
+		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
+
+	if (sbi->s_proc)
+		proc_create_data("segment_info", S_IRUGO, sbi->s_proc,
+				 &f2fs_seq_segment_info_fops, sb);
+
 	if (test_opt(sbi, DISCARD)) {
 		struct request_queue *q = bdev_get_queue(sb->s_bdev);
 		if (!blk_queue_discard(q))
@@ -1033,12 +1077,14 @@ static int __init init_f2fs_fs(void)
 	if (err)
 		goto fail;
 	f2fs_create_root_stats();
+	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
 fail:
 	return err;
 }
 
 static void __exit exit_f2fs_fs(void)
 {
+	remove_proc_entry("fs/f2fs", NULL);
 	f2fs_destroy_root_stats();
 	unregister_filesystem(&f2fs_fs_type);
 	destroy_checkpoint_caches();
-- 
1.8.3.1.437.g0dbd812
