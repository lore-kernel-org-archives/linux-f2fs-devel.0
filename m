From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: move sysfs code from super.c to
 fs/f2fs/sysfs.c
Date: Wed, 14 Jun 2017 17:39:47 +0800
Message-ID: <20170614093947.12265-2-yuchao0@huawei.com>
References: <20170614093947.12265-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1dL4mu-0000Ra-2P
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 14 Jun 2017 09:40:32 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dL4mq-0006yQ-Jk
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 14 Jun 2017 09:40:32 +0000
In-Reply-To: <20170614093947.12265-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Codes related to sysfs and procfs are dispersive and mixed with sb
related codes, but actually these codes are independent from others,
so split them from super.c, and reorgnize and manger them in sysfs.c.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/Makefile |   2 +-
 fs/f2fs/f2fs.h   |   8 ++
 fs/f2fs/super.c  | 332 ----------------------------------------------------
 fs/f2fs/sysfs.c  | 350 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 359 insertions(+), 333 deletions(-)
 create mode 100644 fs/f2fs/sysfs.c

diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
index ca949ea7c02f..a0dc559b1b47 100644
--- a/fs/f2fs/Makefile
+++ b/fs/f2fs/Makefile
@@ -2,7 +2,7 @@ obj-$(CONFIG_F2FS_FS) += f2fs.o
 
 f2fs-y		:= dir.o file.o inode.o namei.o hash.o super.o inline.o
 f2fs-y		+= checkpoint.o gc.o data.o node.o segment.o recovery.o
-f2fs-y		+= shrinker.o extent_cache.o
+f2fs-y		+= shrinker.o extent_cache.o sysfs.o
 f2fs-$(CONFIG_F2FS_STAT_FS) += debug.o
 f2fs-$(CONFIG_F2FS_FS_XATTR) += xattr.o
 f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) += acl.o
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index da70964cbd74..dd5449423fd2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2673,6 +2673,14 @@ void init_extent_cache_info(struct f2fs_sb_info *sbi);
 int __init create_extent_cache(void);
 void destroy_extent_cache(void);
 
+/*
+ * sysfs.c
+ */
+int __init f2fs_register_sysfs(void);
+void f2fs_unregister_sysfs(void);
+int f2fs_init_sysfs(struct f2fs_sb_info *sbi);
+void f2fs_exit_sysfs(struct f2fs_sb_info *sbi);
+
 /*
  * crypto support
  */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6c04a5af455a..9081570bc616 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -35,9 +35,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/f2fs.h>
 
-static struct proc_dir_entry *f2fs_proc_root;
 static struct kmem_cache *f2fs_inode_cachep;
-static struct kset *f2fs_kset;
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 
@@ -146,225 +144,6 @@ static match_table_t f2fs_tokens = {
 	{Opt_err, NULL},
 };
 
-/* Sysfs support for f2fs */
-enum {
-	GC_THREAD,	/* struct f2fs_gc_thread */
-	SM_INFO,	/* struct f2fs_sm_info */
-	DCC_INFO,	/* struct discard_cmd_control */
-	NM_INFO,	/* struct f2fs_nm_info */
-	F2FS_SBI,	/* struct f2fs_sb_info */
-#ifdef CONFIG_F2FS_FAULT_INJECTION
-	FAULT_INFO_RATE,	/* struct f2fs_fault_info */
-	FAULT_INFO_TYPE,	/* struct f2fs_fault_info */
-#endif
-};
-
-struct f2fs_attr {
-	struct attribute attr;
-	ssize_t (*show)(struct f2fs_attr *, struct f2fs_sb_info *, char *);
-	ssize_t (*store)(struct f2fs_attr *, struct f2fs_sb_info *,
-			 const char *, size_t);
-	int struct_type;
-	int offset;
-};
-
-static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
-{
-	if (struct_type == GC_THREAD)
-		return (unsigned char *)sbi->gc_thread;
-	else if (struct_type == SM_INFO)
-		return (unsigned char *)SM_I(sbi);
-	else if (struct_type == DCC_INFO)
-		return (unsigned char *)SM_I(sbi)->dcc_info;
-	else if (struct_type == NM_INFO)
-		return (unsigned char *)NM_I(sbi);
-	else if (struct_type == F2FS_SBI)
-		return (unsigned char *)sbi;
-#ifdef CONFIG_F2FS_FAULT_INJECTION
-	else if (struct_type == FAULT_INFO_RATE ||
-					struct_type == FAULT_INFO_TYPE)
-		return (unsigned char *)&sbi->fault_info;
-#endif
-	return NULL;
-}
-
-static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
-		struct f2fs_sb_info *sbi, char *buf)
-{
-	struct super_block *sb = sbi->sb;
-
-	if (!sb->s_bdev->bd_part)
-		return snprintf(buf, PAGE_SIZE, "0\n");
-
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
-		(unsigned long long)(sbi->kbytes_written +
-			BD_PART_WRITTEN(sbi)));
-}
-
-static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
-			struct f2fs_sb_info *sbi, char *buf)
-{
-	unsigned char *ptr = NULL;
-	unsigned int *ui;
-
-	ptr = __struct_ptr(sbi, a->struct_type);
-	if (!ptr)
-		return -EINVAL;
-
-	ui = (unsigned int *)(ptr + a->offset);
-
-	return snprintf(buf, PAGE_SIZE, "%u\n", *ui);
-}
-
-static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
-			struct f2fs_sb_info *sbi,
-			const char *buf, size_t count)
-{
-	unsigned char *ptr;
-	unsigned long t;
-	unsigned int *ui;
-	ssize_t ret;
-
-	ptr = __struct_ptr(sbi, a->struct_type);
-	if (!ptr)
-		return -EINVAL;
-
-	ui = (unsigned int *)(ptr + a->offset);
-
-	ret = kstrtoul(skip_spaces(buf), 0, &t);
-	if (ret < 0)
-		return ret;
-#ifdef CONFIG_F2FS_FAULT_INJECTION
-	if (a->struct_type == FAULT_INFO_TYPE && t >= (1 << FAULT_MAX))
-		return -EINVAL;
-#endif
-	*ui = t;
-	return count;
-}
-
-static ssize_t f2fs_attr_show(struct kobject *kobj,
-				struct attribute *attr, char *buf)
-{
-	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
-								s_kobj);
-	struct f2fs_attr *a = container_of(attr, struct f2fs_attr, attr);
-
-	return a->show ? a->show(a, sbi, buf) : 0;
-}
-
-static ssize_t f2fs_attr_store(struct kobject *kobj, struct attribute *attr,
-						const char *buf, size_t len)
-{
-	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
-									s_kobj);
-	struct f2fs_attr *a = container_of(attr, struct f2fs_attr, attr);
-
-	return a->store ? a->store(a, sbi, buf, len) : 0;
-}
-
-static void f2fs_sb_release(struct kobject *kobj)
-{
-	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
-								s_kobj);
-	complete(&sbi->s_kobj_unregister);
-}
-
-#define F2FS_ATTR_OFFSET(_struct_type, _name, _mode, _show, _store, _offset) \
-static struct f2fs_attr f2fs_attr_##_name = {			\
-	.attr = {.name = __stringify(_name), .mode = _mode },	\
-	.show	= _show,					\
-	.store	= _store,					\
-	.struct_type = _struct_type,				\
-	.offset = _offset					\
-}
-
-#define F2FS_RW_ATTR(struct_type, struct_name, name, elname)	\
-	F2FS_ATTR_OFFSET(struct_type, name, 0644,		\
-		f2fs_sbi_show, f2fs_sbi_store,			\
-		offsetof(struct struct_name, elname))
-
-#define F2FS_GENERAL_RO_ATTR(name) \
-static struct f2fs_attr f2fs_attr_##name = __ATTR(name, 0444, name##_show, NULL)
-
-F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_min_sleep_time, min_sleep_time);
-F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_max_sleep_time, max_sleep_time);
-F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_no_gc_sleep_time, no_gc_sleep_time);
-F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_idle, gc_idle);
-F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, reclaim_segments, rec_prefree_segments);
-F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_small_discards, max_discards);
-F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
-F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
-F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ipu_util, min_ipu_util);
-F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_fsync_blocks, min_fsync_blocks);
-F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_hot_blocks, min_hot_blocks);
-F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
-F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ra_nid_pages, ra_nid_pages);
-F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, dirty_nats_ratio, dirty_nats_ratio);
-F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
-F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
-F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
-F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
-#ifdef CONFIG_F2FS_FAULT_INJECTION
-F2FS_RW_ATTR(FAULT_INFO_RATE, f2fs_fault_info, inject_rate, inject_rate);
-F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
-#endif
-F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
-
-#define ATTR_LIST(name) (&f2fs_attr_##name.attr)
-static struct attribute *f2fs_attrs[] = {
-	ATTR_LIST(gc_min_sleep_time),
-	ATTR_LIST(gc_max_sleep_time),
-	ATTR_LIST(gc_no_gc_sleep_time),
-	ATTR_LIST(gc_idle),
-	ATTR_LIST(reclaim_segments),
-	ATTR_LIST(max_small_discards),
-	ATTR_LIST(batched_trim_sections),
-	ATTR_LIST(ipu_policy),
-	ATTR_LIST(min_ipu_util),
-	ATTR_LIST(min_fsync_blocks),
-	ATTR_LIST(min_hot_blocks),
-	ATTR_LIST(max_victim_search),
-	ATTR_LIST(dir_level),
-	ATTR_LIST(ram_thresh),
-	ATTR_LIST(ra_nid_pages),
-	ATTR_LIST(dirty_nats_ratio),
-	ATTR_LIST(cp_interval),
-	ATTR_LIST(idle_interval),
-#ifdef CONFIG_F2FS_FAULT_INJECTION
-	ATTR_LIST(inject_rate),
-	ATTR_LIST(inject_type),
-#endif
-	ATTR_LIST(lifetime_write_kbytes),
-	NULL,
-};
-
-static const struct sysfs_ops f2fs_attr_ops = {
-	.show	= f2fs_attr_show,
-	.store	= f2fs_attr_store,
-};
-
-static struct kobj_type f2fs_ktype = {
-	.default_attrs	= f2fs_attrs,
-	.sysfs_ops	= &f2fs_attr_ops,
-	.release	= f2fs_sb_release,
-};
-
-int __init f2fs_register_sysfs(void)
-{
-	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
-
-	f2fs_kset = kset_create_and_add("f2fs", NULL, fs_kobj);
-	if (!f2fs_kset)
-		return -ENOMEM;
-	return 0;
-}
-
-void f2fs_unregister_sysfs(void)
-{
-	kset_unregister(f2fs_kset);
-	remove_proc_entry("fs/f2fs", NULL);
-}
-
 void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...)
 {
 	struct va_format vaf;
@@ -782,19 +561,6 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 	kfree(sbi->devs);
 }
 
-void f2fs_exit_sysfs(struct f2fs_sb_info *sbi)
-{
-	kobject_del(&sbi->s_kobj);
-	kobject_put(&sbi->s_kobj);
-	wait_for_completion(&sbi->s_kobj_unregister);
-
-	if (sbi->s_proc) {
-		remove_proc_entry("segment_info", sbi->s_proc);
-		remove_proc_entry("segment_bits", sbi->s_proc);
-		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
-	}
-}
-
 static void f2fs_put_super(struct super_block *sb)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -1013,104 +779,6 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
-static int segment_info_seq_show(struct seq_file *seq, void *offset)
-{
-	struct super_block *sb = seq->private;
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-	unsigned int total_segs =
-			le32_to_cpu(sbi->raw_super->segment_count_main);
-	int i;
-
-	seq_puts(seq, "format: segment_type|valid_blocks\n"
-		"segment_type(0:HD, 1:WD, 2:CD, 3:HN, 4:WN, 5:CN)\n");
-
-	for (i = 0; i < total_segs; i++) {
-		struct seg_entry *se = get_seg_entry(sbi, i);
-
-		if ((i % 10) == 0)
-			seq_printf(seq, "%-10d", i);
-		seq_printf(seq, "%d|%-3u", se->type,
-					get_valid_blocks(sbi, i, false));
-		if ((i % 10) == 9 || i == (total_segs - 1))
-			seq_putc(seq, '\n');
-		else
-			seq_putc(seq, ' ');
-	}
-
-	return 0;
-}
-
-static int segment_bits_seq_show(struct seq_file *seq, void *offset)
-{
-	struct super_block *sb = seq->private;
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-	unsigned int total_segs =
-			le32_to_cpu(sbi->raw_super->segment_count_main);
-	int i, j;
-
-	seq_puts(seq, "format: segment_type|valid_blocks|bitmaps\n"
-		"segment_type(0:HD, 1:WD, 2:CD, 3:HN, 4:WN, 5:CN)\n");
-
-	for (i = 0; i < total_segs; i++) {
-		struct seg_entry *se = get_seg_entry(sbi, i);
-
-		seq_printf(seq, "%-10d", i);
-		seq_printf(seq, "%d|%-3u|", se->type,
-					get_valid_blocks(sbi, i, false));
-		for (j = 0; j < SIT_VBLOCK_MAP_SIZE; j++)
-			seq_printf(seq, " %.2x", se->cur_valid_map[j]);
-		seq_putc(seq, '\n');
-	}
-	return 0;
-}
-
-#define F2FS_PROC_FILE_DEF(_name)					\
-static int _name##_open_fs(struct inode *inode, struct file *file)	\
-{									\
-	return single_open(file, _name##_seq_show, PDE_DATA(inode));	\
-}									\
-									\
-static const struct file_operations f2fs_seq_##_name##_fops = {		\
-	.open = _name##_open_fs,					\
-	.read = seq_read,						\
-	.llseek = seq_lseek,						\
-	.release = single_release,					\
-};
-
-F2FS_PROC_FILE_DEF(segment_info);
-F2FS_PROC_FILE_DEF(segment_bits);
-
-int f2fs_init_sysfs(struct f2fs_sb_info *sbi)
-{
-	struct super_block *sb = sbi->sb;
-	int err;
-
-	if (f2fs_proc_root)
-		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
-
-	if (sbi->s_proc) {
-		proc_create_data("segment_info", S_IRUGO, sbi->s_proc,
-				 &f2fs_seq_segment_info_fops, sb);
-		proc_create_data("segment_bits", S_IRUGO, sbi->s_proc,
-				 &f2fs_seq_segment_bits_fops, sb);
-	}
-
-	sbi->s_kobj.kset = f2fs_kset;
-	init_completion(&sbi->s_kobj_unregister);
-	err = kobject_init_and_add(&sbi->s_kobj, &f2fs_ktype, NULL,
-							"%s", sb->s_id);
-	if (err)
-		goto err_out;
-	return 0;
-err_out:
-	if (sbi->s_proc) {
-		remove_proc_entry("segment_info", sbi->s_proc);
-		remove_proc_entry("segment_bits", sbi->s_proc);
-		remove_proc_entry(sb->s_id, f2fs_proc_root);
-	}
-	return err;
-}
-
 static void default_options(struct f2fs_sb_info *sbi)
 {
 	/* init some FS parameters */
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
new file mode 100644
index 000000000000..714a3e47bbe8
--- /dev/null
+++ b/fs/f2fs/sysfs.c
@@ -0,0 +1,350 @@
+/*
+ * f2fs sysfs interface
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *             http://www.samsung.com/
+ * Copyright (c) 2017 Chao Yu <chao@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/proc_fs.h>
+#include <linux/f2fs_fs.h>
+
+#include "f2fs.h"
+#include "segment.h"
+#include "gc.h"
+
+static struct proc_dir_entry *f2fs_proc_root;
+static struct kset *f2fs_kset;
+
+/* Sysfs support for f2fs */
+enum {
+	GC_THREAD,	/* struct f2fs_gc_thread */
+	SM_INFO,	/* struct f2fs_sm_info */
+	DCC_INFO,	/* struct discard_cmd_control */
+	NM_INFO,	/* struct f2fs_nm_info */
+	F2FS_SBI,	/* struct f2fs_sb_info */
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	FAULT_INFO_RATE,	/* struct f2fs_fault_info */
+	FAULT_INFO_TYPE,	/* struct f2fs_fault_info */
+#endif
+};
+
+struct f2fs_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct f2fs_attr *, struct f2fs_sb_info *, char *);
+	ssize_t (*store)(struct f2fs_attr *, struct f2fs_sb_info *,
+			 const char *, size_t);
+	int struct_type;
+	int offset;
+};
+
+static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
+{
+	if (struct_type == GC_THREAD)
+		return (unsigned char *)sbi->gc_thread;
+	else if (struct_type == SM_INFO)
+		return (unsigned char *)SM_I(sbi);
+	else if (struct_type == DCC_INFO)
+		return (unsigned char *)SM_I(sbi)->dcc_info;
+	else if (struct_type == NM_INFO)
+		return (unsigned char *)NM_I(sbi);
+	else if (struct_type == F2FS_SBI)
+		return (unsigned char *)sbi;
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	else if (struct_type == FAULT_INFO_RATE ||
+					struct_type == FAULT_INFO_TYPE)
+		return (unsigned char *)&sbi->fault_info;
+#endif
+	return NULL;
+}
+
+static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	struct super_block *sb = sbi->sb;
+
+	if (!sb->s_bdev->bd_part)
+		return snprintf(buf, PAGE_SIZE, "0\n");
+
+	return snprintf(buf, PAGE_SIZE, "%llu\n",
+		(unsigned long long)(sbi->kbytes_written +
+			BD_PART_WRITTEN(sbi)));
+}
+
+static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
+			struct f2fs_sb_info *sbi, char *buf)
+{
+	unsigned char *ptr = NULL;
+	unsigned int *ui;
+
+	ptr = __struct_ptr(sbi, a->struct_type);
+	if (!ptr)
+		return -EINVAL;
+
+	ui = (unsigned int *)(ptr + a->offset);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", *ui);
+}
+
+static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
+			struct f2fs_sb_info *sbi,
+			const char *buf, size_t count)
+{
+	unsigned char *ptr;
+	unsigned long t;
+	unsigned int *ui;
+	ssize_t ret;
+
+	ptr = __struct_ptr(sbi, a->struct_type);
+	if (!ptr)
+		return -EINVAL;
+
+	ui = (unsigned int *)(ptr + a->offset);
+
+	ret = kstrtoul(skip_spaces(buf), 0, &t);
+	if (ret < 0)
+		return ret;
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (a->struct_type == FAULT_INFO_TYPE && t >= (1 << FAULT_MAX))
+		return -EINVAL;
+#endif
+	*ui = t;
+	return count;
+}
+
+static ssize_t f2fs_attr_show(struct kobject *kobj,
+				struct attribute *attr, char *buf)
+{
+	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
+								s_kobj);
+	struct f2fs_attr *a = container_of(attr, struct f2fs_attr, attr);
+
+	return a->show ? a->show(a, sbi, buf) : 0;
+}
+
+static ssize_t f2fs_attr_store(struct kobject *kobj, struct attribute *attr,
+						const char *buf, size_t len)
+{
+	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
+									s_kobj);
+	struct f2fs_attr *a = container_of(attr, struct f2fs_attr, attr);
+
+	return a->store ? a->store(a, sbi, buf, len) : 0;
+}
+
+static void f2fs_sb_release(struct kobject *kobj)
+{
+	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
+								s_kobj);
+	complete(&sbi->s_kobj_unregister);
+}
+
+#define F2FS_ATTR_OFFSET(_struct_type, _name, _mode, _show, _store, _offset) \
+static struct f2fs_attr f2fs_attr_##_name = {			\
+	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.show	= _show,					\
+	.store	= _store,					\
+	.struct_type = _struct_type,				\
+	.offset = _offset					\
+}
+
+#define F2FS_RW_ATTR(struct_type, struct_name, name, elname)	\
+	F2FS_ATTR_OFFSET(struct_type, name, 0644,		\
+		f2fs_sbi_show, f2fs_sbi_store,			\
+		offsetof(struct struct_name, elname))
+
+#define F2FS_GENERAL_RO_ATTR(name) \
+static struct f2fs_attr f2fs_attr_##name = __ATTR(name, 0444, name##_show, NULL)
+
+F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_min_sleep_time, min_sleep_time);
+F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_max_sleep_time, max_sleep_time);
+F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_no_gc_sleep_time, no_gc_sleep_time);
+F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_idle, gc_idle);
+F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, reclaim_segments, rec_prefree_segments);
+F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_small_discards, max_discards);
+F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
+F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
+F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ipu_util, min_ipu_util);
+F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_fsync_blocks, min_fsync_blocks);
+F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_hot_blocks, min_hot_blocks);
+F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
+F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ra_nid_pages, ra_nid_pages);
+F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, dirty_nats_ratio, dirty_nats_ratio);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+F2FS_RW_ATTR(FAULT_INFO_RATE, f2fs_fault_info, inject_rate, inject_rate);
+F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
+#endif
+F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
+
+#define ATTR_LIST(name) (&f2fs_attr_##name.attr)
+static struct attribute *f2fs_attrs[] = {
+	ATTR_LIST(gc_min_sleep_time),
+	ATTR_LIST(gc_max_sleep_time),
+	ATTR_LIST(gc_no_gc_sleep_time),
+	ATTR_LIST(gc_idle),
+	ATTR_LIST(reclaim_segments),
+	ATTR_LIST(max_small_discards),
+	ATTR_LIST(batched_trim_sections),
+	ATTR_LIST(ipu_policy),
+	ATTR_LIST(min_ipu_util),
+	ATTR_LIST(min_fsync_blocks),
+	ATTR_LIST(min_hot_blocks),
+	ATTR_LIST(max_victim_search),
+	ATTR_LIST(dir_level),
+	ATTR_LIST(ram_thresh),
+	ATTR_LIST(ra_nid_pages),
+	ATTR_LIST(dirty_nats_ratio),
+	ATTR_LIST(cp_interval),
+	ATTR_LIST(idle_interval),
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	ATTR_LIST(inject_rate),
+	ATTR_LIST(inject_type),
+#endif
+	ATTR_LIST(lifetime_write_kbytes),
+	NULL,
+};
+
+static const struct sysfs_ops f2fs_attr_ops = {
+	.show	= f2fs_attr_show,
+	.store	= f2fs_attr_store,
+};
+
+static struct kobj_type f2fs_ktype = {
+	.default_attrs	= f2fs_attrs,
+	.sysfs_ops	= &f2fs_attr_ops,
+	.release	= f2fs_sb_release,
+};
+
+static int segment_info_seq_show(struct seq_file *seq, void *offset)
+{
+	struct super_block *sb = seq->private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	unsigned int total_segs =
+			le32_to_cpu(sbi->raw_super->segment_count_main);
+	int i;
+
+	seq_puts(seq, "format: segment_type|valid_blocks\n"
+		"segment_type(0:HD, 1:WD, 2:CD, 3:HN, 4:WN, 5:CN)\n");
+
+	for (i = 0; i < total_segs; i++) {
+		struct seg_entry *se = get_seg_entry(sbi, i);
+
+		if ((i % 10) == 0)
+			seq_printf(seq, "%-10d", i);
+		seq_printf(seq, "%d|%-3u", se->type,
+					get_valid_blocks(sbi, i, false));
+		if ((i % 10) == 9 || i == (total_segs - 1))
+			seq_putc(seq, '\n');
+		else
+			seq_putc(seq, ' ');
+	}
+
+	return 0;
+}
+
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
+					get_valid_blocks(sbi, i, false));
+		for (j = 0; j < SIT_VBLOCK_MAP_SIZE; j++)
+			seq_printf(seq, " %.2x", se->cur_valid_map[j]);
+		seq_putc(seq, '\n');
+	}
+	return 0;
+}
+
+#define F2FS_PROC_FILE_DEF(_name)					\
+static int _name##_open_fs(struct inode *inode, struct file *file)	\
+{									\
+	return single_open(file, _name##_seq_show, PDE_DATA(inode));	\
+}									\
+									\
+static const struct file_operations f2fs_seq_##_name##_fops = {		\
+	.open = _name##_open_fs,					\
+	.read = seq_read,						\
+	.llseek = seq_lseek,						\
+	.release = single_release,					\
+};
+
+F2FS_PROC_FILE_DEF(segment_info);
+F2FS_PROC_FILE_DEF(segment_bits);
+
+int __init f2fs_register_sysfs(void)
+{
+	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
+
+	f2fs_kset = kset_create_and_add("f2fs", NULL, fs_kobj);
+	if (!f2fs_kset)
+		return -ENOMEM;
+	return 0;
+}
+
+void f2fs_unregister_sysfs(void)
+{
+	kset_unregister(f2fs_kset);
+	remove_proc_entry("fs/f2fs", NULL);
+}
+
+int f2fs_init_sysfs(struct f2fs_sb_info *sbi)
+{
+	struct super_block *sb = sbi->sb;
+	int err;
+
+	if (f2fs_proc_root)
+		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
+
+	if (sbi->s_proc) {
+		proc_create_data("segment_info", S_IRUGO, sbi->s_proc,
+				 &f2fs_seq_segment_info_fops, sb);
+		proc_create_data("segment_bits", S_IRUGO, sbi->s_proc,
+				 &f2fs_seq_segment_bits_fops, sb);
+	}
+
+	sbi->s_kobj.kset = f2fs_kset;
+	init_completion(&sbi->s_kobj_unregister);
+	err = kobject_init_and_add(&sbi->s_kobj, &f2fs_ktype, NULL,
+							"%s", sb->s_id);
+	if (err)
+		goto err_out;
+	return 0;
+err_out:
+	if (sbi->s_proc) {
+		remove_proc_entry("segment_info", sbi->s_proc);
+		remove_proc_entry("segment_bits", sbi->s_proc);
+		remove_proc_entry(sb->s_id, f2fs_proc_root);
+	}
+	return err;
+}
+
+void f2fs_exit_sysfs(struct f2fs_sb_info *sbi)
+{
+	kobject_del(&sbi->s_kobj);
+	kobject_put(&sbi->s_kobj);
+	wait_for_completion(&sbi->s_kobj_unregister);
+
+	if (sbi->s_proc) {
+		remove_proc_entry("segment_info", sbi->s_proc);
+		remove_proc_entry("segment_bits", sbi->s_proc);
+		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
+	}
+}
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
