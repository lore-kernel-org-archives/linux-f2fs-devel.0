From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 02/11] f2fs: add proc entry to show valid block bitmap
Date: Tue,  3 May 2016 11:21:39 -0700
Message-ID: <1462299708-67906-2-git-send-email-jaegeuk@kernel.org>
References: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds a new proc entry to show segment information in more detail.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b006de6..90d4b86 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -539,6 +539,7 @@ static void f2fs_put_super(struct super_block *sb)
 
 	if (sbi->s_proc) {
 		remove_proc_entry("segment_info", sbi->s_proc);
+		remove_proc_entry("segment_bits", sbi->s_proc);
 		remove_proc_entry(sb->s_id, f2fs_proc_root);
 	}
 	kobject_del(&sbi->s_kobj);
@@ -745,6 +746,30 @@ static int segment_info_seq_show(struct seq_file *seq, void *offset)
 	return 0;
 }
 
+static int segment_bits_seq_show(struct seq_file *seq, void *offset)
+{
+	struct super_block *sb = seq->private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	unsigned int total_segs =
+			le32_to_cpu(sbi->raw_super->segment_count_main);
+	int i, j;
+
+	seq_puts(seq, "format: segment_type|valid_blocks|bitmaps\n"
+		"segment_type(0:HD, 1:WD, 2:CD, 3:HN, 4:WN, 5:CN)\n");
+
+	for (i = 0; i < total_segs; i++) {
+		struct seg_entry *se = get_seg_entry(sbi, i);
+
+		seq_printf(seq, "%-10d", i);
+		seq_printf(seq, "%d|%-3u|", se->type,
+					get_valid_blocks(sbi, i, 1));
+		for (j = 0; j < SIT_VBLOCK_MAP_SIZE; j++)
+			seq_printf(seq, "%x ", se->cur_valid_map[j]);
+		seq_putc(seq, '\n');
+	}
+	return 0;
+}
+
 #define F2FS_PROC_FILE_DEF(_name)					\
 static int _name##_open_fs(struct inode *inode, struct file *file)	\
 {									\
@@ -760,6 +785,7 @@ static const struct file_operations f2fs_seq_##_name##_fops = {		\
 };
 
 F2FS_PROC_FILE_DEF(segment_info);
+F2FS_PROC_FILE_DEF(segment_bits);
 
 static void default_options(struct f2fs_sb_info *sbi)
 {
@@ -1541,9 +1567,12 @@ try_onemore:
 	if (f2fs_proc_root)
 		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
 
-	if (sbi->s_proc)
+	if (sbi->s_proc) {
 		proc_create_data("segment_info", S_IRUGO, sbi->s_proc,
 				 &f2fs_seq_segment_info_fops, sb);
+		proc_create_data("segment_bits", S_IRUGO, sbi->s_proc,
+				 &f2fs_seq_segment_bits_fops, sb);
+	}
 
 	sbi->s_kobj.kset = f2fs_kset;
 	init_completion(&sbi->s_kobj_unregister);
@@ -1619,6 +1648,7 @@ free_kobj:
 free_proc:
 	if (sbi->s_proc) {
 		remove_proc_entry("segment_info", sbi->s_proc);
+		remove_proc_entry("segment_bits", sbi->s_proc);
 		remove_proc_entry(sb->s_id, f2fs_proc_root);
 	}
 	f2fs_destroy_stats(sbi);
-- 
2.6.3
