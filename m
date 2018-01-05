From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2 v3] f2fs: add reserved blocks for root user
Date: Thu, 4 Jan 2018 20:43:21 -0800
Message-ID: <20180105044321.GA48031@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180103185845.29953-1-jaegeuk@kernel.org>
 <20180103185845.29953-2-jaegeuk@kernel.org>
 <20180104065158.GB54234@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180104065158.GB54234@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch allows root to reserve some blocks via mount option.

"-o reserve_root=N" means N x 4KB-sized blocks for root only.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

Change log from v2:
 - fix overflow in statfs

 fs/f2fs/f2fs.h  | 20 ++++++++++++++++----
 fs/f2fs/super.c | 37 ++++++++++++++++++++++++++++++++++++-
 fs/f2fs/sysfs.c |  3 ++-
 3 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a52de99a34b9..4d255aac49bb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -95,6 +95,7 @@ extern char *fault_name[FAULT_MAX];
 #define F2FS_MOUNT_PRJQUOTA		0x00200000
 #define F2FS_MOUNT_QUOTA		0x00400000
 #define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00800000
+#define F2FS_MOUNT_RESERVE_ROOT		0x01000000
 
 #define clear_opt(sbi, option)	((sbi)->mount_opt.opt &= ~F2FS_MOUNT_##option)
 #define set_opt(sbi, option)	((sbi)->mount_opt.opt |= F2FS_MOUNT_##option)
@@ -1109,6 +1110,7 @@ struct f2fs_sb_info {
 	block_t last_valid_block_count;		/* for recovery */
 	block_t reserved_blocks;		/* configurable reserved blocks */
 	block_t current_reserved_blocks;	/* current reserved blocks */
+	block_t root_reserved_blocks;		/* root reserved blocks */
 
 	unsigned int nquota_files;		/* # of quota sysfile */
 
@@ -1590,11 +1592,17 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 	sbi->total_valid_block_count += (block_t)(*count);
 	avail_user_block_count = sbi->user_block_count -
 					sbi->current_reserved_blocks;
+
+	if (!(test_opt(sbi, RESERVE_ROOT) && capable(CAP_SYS_RESOURCE)))
+		avail_user_block_count -= sbi->root_reserved_blocks;
+
 	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
 		diff = sbi->total_valid_block_count - avail_user_block_count;
+		if (diff > *count)
+			diff = *count;
 		*count -= diff;
 		release = diff;
-		sbi->total_valid_block_count = avail_user_block_count;
+		sbi->total_valid_block_count -= diff;
 		if (!*count) {
 			spin_unlock(&sbi->stat_lock);
 			percpu_counter_sub(&sbi->alloc_valid_block_count, diff);
@@ -1783,9 +1791,13 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 
 	spin_lock(&sbi->stat_lock);
 
-	valid_block_count = sbi->total_valid_block_count + 1;
-	if (unlikely(valid_block_count + sbi->current_reserved_blocks >
-						sbi->user_block_count)) {
+	valid_block_count = sbi->total_valid_block_count +
+					sbi->current_reserved_blocks + 1;
+
+	if (!(test_opt(sbi, RESERVE_ROOT) && capable(CAP_SYS_RESOURCE)))
+		valid_block_count += sbi->root_reserved_blocks;
+
+	if (unlikely(valid_block_count > sbi->user_block_count)) {
 		spin_unlock(&sbi->stat_lock);
 		goto enospc;
 	}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f1300cda6bfd..4904d1644052 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -107,6 +107,7 @@ enum {
 	Opt_noextent_cache,
 	Opt_noinline_data,
 	Opt_data_flush,
+	Opt_reserve_root,
 	Opt_mode,
 	Opt_io_size_bits,
 	Opt_fault_injection,
@@ -157,6 +158,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_noextent_cache, "noextent_cache"},
 	{Opt_noinline_data, "noinline_data"},
 	{Opt_data_flush, "data_flush"},
+	{Opt_reserve_root, "reserve_root=%u"},
 	{Opt_mode, "mode=%s"},
 	{Opt_io_size_bits, "io_bits=%u"},
 	{Opt_fault_injection, "fault_injection=%u"},
@@ -191,6 +193,19 @@ void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...)
 	va_end(args);
 }
 
+static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
+{
+	block_t limit = (sbi->user_block_count << 1) / 1000;
+
+	/* limit is 0.2% */
+	if (test_opt(sbi, RESERVE_ROOT) && sbi->root_reserved_blocks > limit) {
+		sbi->root_reserved_blocks = limit;
+		f2fs_msg(sbi->sb, KERN_INFO,
+			"Reduce reserved blocks for root = %u",
+				sbi->root_reserved_blocks);
+	}
+}
+
 static void init_once(void *foo)
 {
 	struct f2fs_inode_info *fi = (struct f2fs_inode_info *) foo;
@@ -488,6 +503,18 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_data_flush:
 			set_opt(sbi, DATA_FLUSH);
 			break;
+		case Opt_reserve_root:
+			if (args->from && match_int(args, &arg))
+				return -EINVAL;
+			if (test_opt(sbi, RESERVE_ROOT)) {
+				f2fs_msg(sb, KERN_INFO,
+					"Preserve previous reserve_root=%u",
+					sbi->root_reserved_blocks);
+			} else {
+				sbi->root_reserved_blocks = arg;
+				set_opt(sbi, RESERVE_ROOT);
+			}
+			break;
 		case Opt_mode:
 			name = match_strdup(&args[0]);
 
@@ -1006,7 +1033,10 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_blocks = total_count - start_count;
 	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
 						sbi->current_reserved_blocks;
-	buf->f_bavail = buf->f_bfree;
+	if (buf->f_bfree > sbi->root_reserved_blocks)
+		buf->f_bavail = buf->f_bfree - sbi->root_reserved_blocks;
+	else
+		buf->f_bavail = 0;
 
 	avail_node_count = sbi->total_node_count - sbi->nquota_files -
 						F2FS_RESERVED_NODE_NUM;
@@ -1135,6 +1165,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (test_opt(sbi, LFS))
 		seq_puts(seq, "lfs");
 	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
+	if (test_opt(sbi, RESERVE_ROOT))
+		seq_printf(seq, ",reserve_root=%u",
+				sbi->root_reserved_blocks);
 	if (F2FS_IO_SIZE_BITS(sbi))
 		seq_printf(seq, ",io_size=%uKB", F2FS_IO_SIZE_KB(sbi));
 #ifdef CONFIG_F2FS_FAULT_INJECTION
@@ -1333,6 +1366,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 
+	limit_reserve_root(sbi);
 	return 0;
 restore_gc:
 	if (need_restart_gc) {
@@ -2569,6 +2603,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
 	sbi->reserved_blocks = 0;
 	sbi->current_reserved_blocks = 0;
+	limit_reserve_root(sbi);
 
 	for (i = 0; i < NR_INODE_TYPE; i++) {
 		INIT_LIST_HEAD(&sbi->inode_list[i]);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 7e15cbc5b8e1..41887e6ec1b3 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -162,7 +162,8 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 #endif
 	if (a->struct_type == RESERVED_BLOCKS) {
 		spin_lock(&sbi->stat_lock);
-		if (t > (unsigned long)sbi->user_block_count) {
+		if (t > (unsigned long)(sbi->user_block_count -
+					sbi->root_reserved_blocks)) {
 			spin_unlock(&sbi->stat_lock);
 			return -EINVAL;
 		}
-- 
2.15.0.531.g2ccb3012c9-goog
