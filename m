From: Chao Yu <chao@kernel.org>
Subject: [PATCH v3 4/6] f2fs: support project quota
Date: Wed, 26 Jul 2017 00:01:41 +0800
Message-ID: <20170725160141.10662-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch adds to support plain project quota.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- update i_projid only if sb has feature of project_quota.
 Documentation/filesystems/f2fs.txt |  1 +
 fs/f2fs/f2fs.h                     | 29 +++++++++++++++++++++++++++++
 fs/f2fs/file.c                     | 13 -------------
 fs/f2fs/inode.c                    | 24 +++++++++++++++++++++++-
 fs/f2fs/namei.c                    | 31 +++++++++++++++++++++++++++++++
 fs/f2fs/node.c                     |  7 ++++++-
 fs/f2fs/super.c                    | 17 ++++++++++++++++-
 include/linux/f2fs_fs.h            |  3 +++
 8 files changed, 109 insertions(+), 16 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 273ccb26885e..b8f495a8b67d 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -164,6 +164,7 @@ io_bits=%u             Set the bit size of write IO requests. It should be set
                        with "mode=lfs".
 usrquota               Enable plain user disk quota accounting.
 grpquota               Enable plain group disk quota accounting.
+prjquota               Enable plain project quota accounting.
 
 ================================================================================
 DEBUGFS ENTRIES
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4426d7bcc860..1833eefe47b3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -91,6 +91,7 @@ extern char *fault_name[FAULT_MAX];
 #define F2FS_MOUNT_LFS			0x00040000
 #define F2FS_MOUNT_USRQUOTA		0x00080000
 #define F2FS_MOUNT_GRPQUOTA		0x00100000
+#define F2FS_MOUNT_PRJQUOTA		0x00200000
 
 #define clear_opt(sbi, option)	((sbi)->mount_opt.opt &= ~F2FS_MOUNT_##option)
 #define set_opt(sbi, option)	((sbi)->mount_opt.opt |= F2FS_MOUNT_##option)
@@ -114,6 +115,7 @@ struct f2fs_mount_info {
 #define F2FS_FEATURE_BLKZONED		0x0002
 #define F2FS_FEATURE_ATOMIC_WRITE	0x0004
 #define F2FS_FEATURE_EXTRA_ATTR		0x0008
+#define F2FS_FEATURE_PRJQUOTA		0x0010
 
 #define F2FS_HAS_FEATURE(sb, mask)					\
 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
@@ -569,6 +571,7 @@ struct f2fs_inode_info {
 	struct rw_semaphore i_mmap_sem;
 
 	int i_extra_isize;		/* size of extra space located in i_addr */
+	kprojid_t i_projid;		/* id for project quota */
 };
 
 static inline void get_extent_info(struct extent_info *ext,
@@ -1886,6 +1889,20 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 	*addr ^= mask;
 }
 
+#define F2FS_REG_FLMASK		(~(FS_DIRSYNC_FL | FS_TOPDIR_FL))
+#define F2FS_OTHER_FLMASK	(FS_NODUMP_FL | FS_NOATIME_FL)
+#define F2FS_FL_INHERITED	(FS_PROJINHERIT_FL)
+
+static inline __u32 f2fs_mask_flags(umode_t mode, __u32 flags)
+{
+	if (S_ISDIR(mode))
+		return flags;
+	else if (S_ISREG(mode))
+		return flags & F2FS_REG_FLMASK;
+	else
+		return flags & F2FS_OTHER_FLMASK;
+}
+
 /* used for f2fs_inode_info->flags */
 enum {
 	FI_NEW_INODE,		/* indicate newly allocated inode */
@@ -1915,6 +1932,7 @@ enum {
 	FI_NO_PREALLOC,		/* indicate skipped preallocated blocks */
 	FI_HOT_DATA,		/* indicate file is hot */
 	FI_EXTRA_ATTR,		/* indicate file has extra attribute */
+	FI_PROJ_INHERIT,	/* indicate file inherits projectid */
 };
 
 static inline void __mark_inode_dirty_flag(struct inode *inode,
@@ -2238,6 +2256,12 @@ static inline int get_extra_isize(struct inode *inode)
 	(offsetof(struct f2fs_inode, i_extra_end) -	\
 	offsetof(struct f2fs_inode, i_extra_isize))	\
 
+#define F2FS_OLD_ATTRIBUTE_SIZE	(offsetof(struct f2fs_inode, i_addr))
+#define F2FS_FITS_IN_INODE(f2fs_inode, extra_isize, field)		\
+		((offsetof(typeof(*f2fs_inode), field) +	\
+		sizeof((f2fs_inode)->field))			\
+		<= (F2FS_OLD_ATTRIBUTE_SIZE + extra_isize))	\
+
 /*
  * file.c
  */
@@ -2835,6 +2859,11 @@ static inline int f2fs_sb_has_extra_attr(struct super_block *sb)
 	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_EXTRA_ATTR);
 }
 
+static inline int f2fs_sb_has_project_quota(struct super_block *sb)
+{
+	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_PRJQUOTA);
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline int get_blkz_type(struct f2fs_sb_info *sbi,
 			struct block_device *bdev, block_t blkaddr)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ea26a3a5883d..e4a45f02cd4e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1502,19 +1502,6 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-#define F2FS_REG_FLMASK		(~(FS_DIRSYNC_FL | FS_TOPDIR_FL))
-#define F2FS_OTHER_FLMASK	(FS_NODUMP_FL | FS_NOATIME_FL)
-
-static inline __u32 f2fs_mask_flags(umode_t mode, __u32 flags)
-{
-	if (S_ISDIR(mode))
-		return flags;
-	else if (S_ISREG(mode))
-		return flags & F2FS_REG_FLMASK;
-	else
-		return flags & F2FS_OTHER_FLMASK;
-}
-
 static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 0a6699a23dfb..f15e663a1a15 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -114,6 +114,7 @@ static int do_read_inode(struct inode *inode)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct page *node_page;
 	struct f2fs_inode *ri;
+	projid_t i_projid;
 
 	/* Check if ino is within scope */
 	if (check_nid_range(sbi, inode->i_ino)) {
@@ -173,6 +174,16 @@ static int do_read_inode(struct inode *inode)
 	if (!need_inode_block_update(sbi, inode->i_ino))
 		fi->last_disk_size = inode->i_size;
 
+	if (fi->i_flags & FS_PROJINHERIT_FL)
+		set_inode_flag(inode, FI_PROJ_INHERIT);
+
+	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_project_quota(sbi->sb) &&
+			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize, i_projid))
+		i_projid = (projid_t)le32_to_cpu(ri->i_projid);
+	else
+		i_projid = F2FS_DEF_PROJID;
+	fi->i_projid = make_kprojid(&init_user_ns, i_projid);
+
 	f2fs_put_page(node_page, 1);
 
 	stat_inc_inline_xattr(inode);
@@ -299,9 +310,20 @@ int update_inode(struct inode *inode, struct page *node_page)
 	ri->i_generation = cpu_to_le32(inode->i_generation);
 	ri->i_dir_level = F2FS_I(inode)->i_dir_level;
 
-	if (f2fs_has_extra_attr(inode))
+	if (f2fs_has_extra_attr(inode)) {
 		ri->i_extra_isize = cpu_to_le16(F2FS_I(inode)->i_extra_isize);
 
+		if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)->sb) &&
+			F2FS_FITS_IN_INODE(ri, F2FS_I(inode)->i_extra_isize,
+								i_projid)) {
+			projid_t i_projid;
+
+			i_projid = from_kprojid(&init_user_ns,
+						F2FS_I(inode)->i_projid);
+			ri->i_projid = cpu_to_le32(i_projid);
+		}
+	}
+
 	__set_inode_rdev(inode, ri);
 	set_cold_node(inode, node_page);
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 26b4d2b54812..25d9452bc557 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -58,6 +58,13 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 		goto fail;
 	}
 
+	if (f2fs_sb_has_project_quota(sbi->sb) &&
+		(F2FS_I(dir)->i_flags & FS_PROJINHERIT_FL))
+		F2FS_I(inode)->i_projid = F2FS_I(dir)->i_projid;
+	else
+		F2FS_I(inode)->i_projid = make_kprojid(&init_user_ns,
+							F2FS_DEF_PROJID);
+
 	err = dquot_initialize(inode);
 	if (err)
 		goto fail_drop;
@@ -90,6 +97,12 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	stat_inc_inline_inode(inode);
 	stat_inc_inline_dir(inode);
 
+	F2FS_I(inode)->i_flags =
+		f2fs_mask_flags(mode, F2FS_I(dir)->i_flags & F2FS_FL_INHERITED);
+
+	if (F2FS_I(inode)->i_flags & FS_PROJINHERIT_FL)
+		set_inode_flag(inode, FI_PROJ_INHERIT);
+
 	trace_f2fs_new_inode(inode, 0);
 	return inode;
 
@@ -209,6 +222,11 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 			!fscrypt_has_permitted_context(dir, inode))
 		return -EPERM;
 
+	if (is_inode_flag_set(dir, FI_PROJ_INHERIT) &&
+			(!projid_eq(F2FS_I(dir)->i_projid,
+			F2FS_I(old_dentry->d_inode)->i_projid)))
+		return -EXDEV;
+
 	err = dquot_initialize(dir);
 	if (err)
 		return err;
@@ -729,6 +747,11 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto out;
 	}
 
+	if (is_inode_flag_set(new_dir, FI_PROJ_INHERIT) &&
+			(!projid_eq(F2FS_I(new_dir)->i_projid,
+			F2FS_I(old_dentry->d_inode)->i_projid)))
+		return -EXDEV;
+
 	err = dquot_initialize(old_dir);
 	if (err)
 		goto out;
@@ -917,6 +940,14 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 			 !fscrypt_has_permitted_context(old_dir, new_inode)))
 		return -EPERM;
 
+	if ((is_inode_flag_set(new_dir, FI_PROJ_INHERIT) &&
+			!projid_eq(F2FS_I(new_dir)->i_projid,
+			F2FS_I(old_dentry->d_inode)->i_projid)) ||
+	    (is_inode_flag_set(new_dir, FI_PROJ_INHERIT) &&
+			!projid_eq(F2FS_I(old_dir)->i_projid,
+			F2FS_I(new_dentry->d_inode)->i_projid)))
+		return -EXDEV;
+
 	err = dquot_initialize(old_dir);
 	if (err)
 		goto out;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 547b84fc10f6..11e2d49203b3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2265,8 +2265,13 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	dst->i_links = cpu_to_le32(1);
 	dst->i_xattr_nid = 0;
 	dst->i_inline = src->i_inline & (F2FS_INLINE_XATTR | F2FS_EXTRA_ATTR);
-	if (dst->i_inline & F2FS_EXTRA_ATTR)
+	if (dst->i_inline & F2FS_EXTRA_ATTR) {
 		dst->i_extra_isize = src->i_extra_isize;
+		if (f2fs_sb_has_project_quota(sbi->sb) &&
+			F2FS_FITS_IN_INODE(src, le16_to_cpu(src->i_extra_isize),
+								i_projid))
+			dst->i_projid = src->i_projid;
+	}
 
 	new_ni = old_ni;
 	new_ni.ino = ino;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b30097190605..1241739f4d54 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -109,6 +109,7 @@ enum {
 	Opt_nolazytime,
 	Opt_usrquota,
 	Opt_grpquota,
+	Opt_prjquota,
 	Opt_err,
 };
 
@@ -146,6 +147,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_nolazytime, "nolazytime"},
 	{Opt_usrquota, "usrquota"},
 	{Opt_grpquota, "grpquota"},
+	{Opt_prjquota, "prjquota"},
 	{Opt_err, NULL},
 };
 
@@ -392,9 +394,13 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_grpquota:
 			set_opt(sbi, GRPQUOTA);
 			break;
+		case Opt_prjquota:
+			set_opt(sbi, PRJQUOTA);
+			break;
 #else
 		case Opt_usrquota:
 		case Opt_grpquota:
+		case Opt_prjquota:
 			f2fs_msg(sb, KERN_INFO,
 					"quota operations not supported");
 			break;
@@ -814,6 +820,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",usrquota");
 	if (test_opt(sbi, GRPQUOTA))
 		seq_puts(seq, ",grpquota");
+	if (test_opt(sbi, PRJQUOTA))
+		seq_puts(seq, ",prjquota");
 #endif
 
 	return 0;
@@ -1172,6 +1180,12 @@ static void f2fs_quota_off_umount(struct super_block *sb)
 		f2fs_quota_off(sb, type);
 }
 
+int f2fs_get_projid(struct inode *inode, kprojid_t *projid)
+{
+	*projid = F2FS_I(inode)->i_projid;
+	return 0;
+}
+
 static const struct dquot_operations f2fs_quota_operations = {
 	.get_reserved_space = f2fs_get_reserved_space,
 	.write_dquot	= dquot_commit,
@@ -1181,6 +1195,7 @@ static const struct dquot_operations f2fs_quota_operations = {
 	.write_info	= dquot_commit_info,
 	.alloc_dquot	= dquot_alloc,
 	.destroy_dquot	= dquot_destroy,
+	.get_projid	= f2fs_get_projid,
 	.get_next_id	= dquot_get_next_id,
 };
 
@@ -1964,7 +1979,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 #ifdef CONFIG_QUOTA
 	sb->dq_op = &f2fs_quota_operations;
 	sb->s_qcop = &f2fs_quotactl_ops;
-	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP;
+	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
 #endif
 
 	sb->s_op = &f2fs_sops;
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 0c79ddd40b70..50f176683676 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -239,6 +239,7 @@ struct f2fs_inode {
 		struct {
 			__le16 i_extra_isize;	/* extra inode attribute size */
 			__le16 i_padding;	/* padding */
+			__le32 i_projid;	/* project id */
 			__le32 i_extra_end[0];	/* for attribute size calculation */
 		};
 		__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
@@ -522,4 +523,6 @@ enum {
 
 #define S_SHIFT 12
 
+#define	F2FS_DEF_PROJID		0	/* default project ID */
+
 #endif  /* _LINUX_F2FS_FS_H */
-- 
2.13.0.90.g1eb437020
