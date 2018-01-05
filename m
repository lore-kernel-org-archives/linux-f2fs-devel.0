From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: add resgid and resuid to reserve root blocks
Date: Thu,  4 Jan 2018 22:18:43 -0800
Message-ID: <20180105061843.56096-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds mount options to reserve some blocks via resgid=%u,resuid=%u.
It only activates with reserve_root=%u.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  | 26 ++++++++++++++++++++++++--
 fs/f2fs/super.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4d255aac49bb..e5554b851fd8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -131,6 +131,12 @@ struct f2fs_mount_info {
 #define F2FS_CLEAR_FEATURE(sb, mask)					\
 	(F2FS_SB(sb)->raw_super->feature &= ~cpu_to_le32(mask))
 
+/*
+ * Default values for user and/or group using reserved blocks
+ */
+#define	F2FS_DEF_RESUID		0
+#define	F2FS_DEF_RESGID		0
+
 /*
  * For checkpoint manager
  */
@@ -1111,6 +1117,8 @@ struct f2fs_sb_info {
 	block_t reserved_blocks;		/* configurable reserved blocks */
 	block_t current_reserved_blocks;	/* current reserved blocks */
 	block_t root_reserved_blocks;		/* root reserved blocks */
+	kuid_t s_resuid;			/* reserved blocks for uid */
+	kgid_t s_resgid;			/* reserved blocks for gid */
 
 	unsigned int nquota_files;		/* # of quota sysfile */
 
@@ -1563,6 +1571,20 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
 	return ofs == XATTR_NODE_OFFSET;
 }
 
+static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi)
+{
+	if (!test_opt(sbi, RESERVE_ROOT))
+		return false;
+	if (capable(CAP_SYS_RESOURCE))
+		return true;
+	if (uid_eq(sbi->s_resuid, current_fsuid()))
+		return true;
+	if (!gid_eq(sbi->s_resgid, GLOBAL_ROOT_GID) &&
+					in_group_p(sbi->s_resgid))
+		return true;
+	return false;
+}
+
 static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
 static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 				 struct inode *inode, blkcnt_t *count)
@@ -1593,7 +1615,7 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 	avail_user_block_count = sbi->user_block_count -
 					sbi->current_reserved_blocks;
 
-	if (!(test_opt(sbi, RESERVE_ROOT) && capable(CAP_SYS_RESOURCE)))
+	if (!__allow_reserved_blocks(sbi))
 		avail_user_block_count -= sbi->root_reserved_blocks;
 
 	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
@@ -1794,7 +1816,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 	valid_block_count = sbi->total_valid_block_count +
 					sbi->current_reserved_blocks + 1;
 
-	if (!(test_opt(sbi, RESERVE_ROOT) && capable(CAP_SYS_RESOURCE)))
+	if (!__allow_reserved_blocks(sbi))
 		valid_block_count += sbi->root_reserved_blocks;
 
 	if (unlikely(valid_block_count > sbi->user_block_count)) {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4904d1644052..ef40bc3d91e8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -108,6 +108,8 @@ enum {
 	Opt_noinline_data,
 	Opt_data_flush,
 	Opt_reserve_root,
+	Opt_resgid,
+	Opt_resuid,
 	Opt_mode,
 	Opt_io_size_bits,
 	Opt_fault_injection,
@@ -159,6 +161,8 @@ static match_table_t f2fs_tokens = {
 	{Opt_noinline_data, "noinline_data"},
 	{Opt_data_flush, "data_flush"},
 	{Opt_reserve_root, "reserve_root=%u"},
+	{Opt_resgid, "resgid=%u"},
+	{Opt_resuid, "resuid=%u"},
 	{Opt_mode, "mode=%s"},
 	{Opt_io_size_bits, "io_bits=%u"},
 	{Opt_fault_injection, "fault_injection=%u"},
@@ -204,6 +208,15 @@ static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
 			"Reduce reserved blocks for root = %u",
 				sbi->root_reserved_blocks);
 	}
+	if (!test_opt(sbi, RESERVE_ROOT) &&
+		(!uid_eq(sbi->s_resuid,
+				make_kuid(&init_user_ns, F2FS_DEF_RESUID)) ||
+		!gid_eq(sbi->s_resgid,
+				make_kgid(&init_user_ns, F2FS_DEF_RESGID))))
+		f2fs_msg(sbi->sb, KERN_INFO,
+			"Ignore s_resuid=%u, s_resgid=%u w/o reserve_root",
+				from_kuid_munged(&init_user_ns, sbi->s_resuid),
+				from_kgid_munged(&init_user_ns, sbi->s_resgid));
 }
 
 static void init_once(void *foo)
@@ -336,6 +349,8 @@ static int parse_options(struct super_block *sb, char *options)
 	substring_t args[MAX_OPT_ARGS];
 	char *p, *name;
 	int arg = 0;
+	kuid_t uid;
+	kgid_t gid;
 #ifdef CONFIG_QUOTA
 	int ret;
 #endif
@@ -515,6 +530,28 @@ static int parse_options(struct super_block *sb, char *options)
 				set_opt(sbi, RESERVE_ROOT);
 			}
 			break;
+		case Opt_resuid:
+			if (args->from && match_int(args, &arg))
+				return -EINVAL;
+			uid = make_kuid(current_user_ns(), arg);
+			if (!uid_valid(uid)) {
+				f2fs_msg(sb, KERN_ERR,
+					"Invalid uid value %d", arg);
+				return -EINVAL;
+			}
+			sbi->s_resuid = uid;
+			break;
+		case Opt_resgid:
+			if (args->from && match_int(args, &arg))
+				return -EINVAL;
+			gid = make_kgid(current_user_ns(), arg);
+			if (!gid_valid(gid)) {
+				f2fs_msg(sb, KERN_ERR,
+					"Invalid gid value %d", arg);
+				return -EINVAL;
+			}
+			sbi->s_resgid = gid;
+			break;
 		case Opt_mode:
 			name = match_strdup(&args[0]);
 
@@ -1166,8 +1203,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, "lfs");
 	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
 	if (test_opt(sbi, RESERVE_ROOT))
-		seq_printf(seq, ",reserve_root=%u",
-				sbi->root_reserved_blocks);
+		seq_printf(seq, ",reserve_root=%u,resuid=%u,resgid=%u",
+				sbi->root_reserved_blocks,
+				from_kuid_munged(&init_user_ns, sbi->s_resuid),
+				from_kgid_munged(&init_user_ns, sbi->s_resgid));
 	if (F2FS_IO_SIZE_BITS(sbi))
 		seq_printf(seq, ",io_size=%uKB", F2FS_IO_SIZE_KB(sbi));
 #ifdef CONFIG_F2FS_FAULT_INJECTION
@@ -2455,6 +2494,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_fs_info = sbi;
 	sbi->raw_super = raw_super;
 
+	sbi->s_resuid = make_kuid(&init_user_ns, F2FS_DEF_RESUID);
+	sbi->s_resgid = make_kgid(&init_user_ns, F2FS_DEF_RESGID);
+
 	/* precompute checksum seed for metadata */
 	if (f2fs_sb_has_inode_chksum(sb))
 		sbi->s_chksum_seed = f2fs_chksum(sbi, ~0, raw_super->uuid,
-- 
2.15.0.531.g2ccb3012c9-goog
