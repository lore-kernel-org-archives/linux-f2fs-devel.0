From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH v3] f2fs: introduce F2FS_FEATURE_LOST_FOUND
 feature
Date: Tue, 6 Mar 2018 11:39:04 +0800
Message-ID: <20180306033904.122540-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1et3Rv-003EJp-8D
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Mar 2018 03:39:35 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1et3Rr-001wiZ-Oo
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Mar 2018 03:39:35 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: ebiggers@google.com, miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

This patch introduces a new feature, F2FS_FEATURE_LOST_FOUND, which
is set by mkfs. It creates a directory named lost+found, which saves
unreachable files. If fsck finds a file which has no parent, or its
parent is removed by fsck, the file will be placed under lost+found
directory by fsck.

lost+found directory could not be encrypted. As a result, the root
directory cannot be encrypted too. So if LOST_FOUND feature is enabled,
let's avoid to encrypt root directory.

This patch also introduces a new mount option `test_dummy_encryption'
to allow fscrypt to create a fake fscrypt context. This is used by
xfstests.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
v3->v2:
 * fix test_dummy_encryption
v2->v1:
 * introduce new mount option test_dummy_encryption
 * add sysfs entry for LOST_FOUND feature

 fs/f2fs/dir.c   |  6 ++++--
 fs/f2fs/f2fs.h  | 17 +++++++++++++++++
 fs/f2fs/namei.c |  9 ++++++---
 fs/f2fs/super.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/f2fs/sysfs.c |  7 +++++++
 5 files changed, 85 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 797eb05cb538..7f908be8d525 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -361,6 +361,7 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 			struct page *dpage)
 {
 	struct page *page;
+	int encrypt = DUMMY_ENCRYPTION_ENABLED(F2FS_I_SB(dir));
 	int err;
 
 	if (is_inode_flag_set(inode, FI_NEW_INODE)) {
@@ -387,7 +388,8 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 		if (err)
 			goto put_error;
 
-		if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode)) {
+		if ((f2fs_encrypted_inode(dir) || encrypt) &&
+					f2fs_may_encrypt(inode)) {
 			err = fscrypt_inherit_context(dir, inode, page, false);
 			if (err)
 				goto put_error;
@@ -402,7 +404,7 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 
 	if (new_name) {
 		init_dent_inode(new_name, page);
-		if (f2fs_encrypted_inode(dir))
+		if (f2fs_encrypted_inode(dir) || encrypt)
 			file_set_enc_name(inode);
 	}
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f6dc70666ebb..77af79d0376b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -125,6 +125,7 @@ struct f2fs_mount_info {
 #define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x0040
 #define F2FS_FEATURE_QUOTA_INO		0x0080
 #define F2FS_FEATURE_INODE_CRTIME	0x0100
+#define F2FS_FEATURE_LOST_FOUND		0x0200
 
 #define F2FS_HAS_FEATURE(sb, mask)					\
 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
@@ -1052,6 +1053,15 @@ enum {
 	ALLOC_MODE_REUSE,	/* reuse segments as much as possible */
 };
 
+#define F2FS_MF_TEST_DUMMY_ENCRYPTION	0x0001
+
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
+#define DUMMY_ENCRYPTION_ENABLED(sbi) (unlikely((sbi)->mount_flags & \
+						F2FS_MF_TEST_DUMMY_ENCRYPTION))
+#else
+#define DUMMY_ENCRYPTION_ENABLED(sbi) (0)
+#endif
+
 struct f2fs_sb_info {
 	struct super_block *sb;			/* pointer to VFS super block */
 	struct proc_dir_entry *s_proc;		/* proc entry */
@@ -1241,6 +1251,8 @@ struct f2fs_sb_info {
 
 	/* segment allocation policy */
 	int alloc_mode;
+
+	unsigned int mount_flags;
 };
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
@@ -3201,6 +3213,10 @@ static inline bool f2fs_bio_encrypted(struct bio *bio)
 static inline int f2fs_sb_has_##name(struct super_block *sb) \
 { \
 	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_##flagname); \
+} \
+static inline int f2fs_sb_set_##name(struct super_block *sb) \
+{ \
+	return F2FS_SET_FEATURE(sb, F2FS_FEATURE_##flagname); \
 }
 
 F2FS_FEATURE_FUNCS(encrypt, ENCRYPT);
@@ -3211,6 +3227,7 @@ F2FS_FEATURE_FUNCS(inode_chksum, INODE_CHKSUM);
 F2FS_FEATURE_FUNCS(flexible_inline_xattr, FLEXIBLE_INLINE_XATTR);
 F2FS_FEATURE_FUNCS(quota_ino, QUOTA_INO);
 F2FS_FEATURE_FUNCS(inode_crtime, INODE_CRTIME);
+F2FS_FEATURE_FUNCS(lost_found, LOST_FOUND);
 
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline int get_blkz_type(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 318dfe870cb5..5dd6a112e13d 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -78,7 +78,8 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	set_inode_flag(inode, FI_NEW_INODE);
 
 	/* If the directory encrypted, then we should encrypt the inode. */
-	if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode))
+	if ((f2fs_encrypted_inode(dir) || DUMMY_ENCRYPTION_ENABLED(sbi)) &&
+				f2fs_may_encrypt(inode))
 		f2fs_set_encrypted_inode(inode);
 
 	if (f2fs_sb_has_extra_attr(sbi->sb)) {
@@ -788,10 +789,12 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
 
 static int f2fs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
-	if (unlikely(f2fs_cp_error(F2FS_I_SB(dir))))
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
+
+	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
 
-	if (f2fs_encrypted_inode(dir)) {
+	if (f2fs_encrypted_inode(dir) || DUMMY_ENCRYPTION_ENABLED(sbi)) {
 		int err = fscrypt_get_encryption_info(dir);
 		if (err)
 			return err;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 30b93ad44b9d..dd796bfb1004 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -131,6 +131,7 @@ enum {
 	Opt_jqfmt_vfsv1,
 	Opt_whint,
 	Opt_alloc,
+	Opt_test_dummy_encryption,
 	Opt_err,
 };
 
@@ -186,6 +187,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_jqfmt_vfsv1, "jqfmt=vfsv1"},
 	{Opt_whint, "whint_mode=%s"},
 	{Opt_alloc, "alloc_mode=%s"},
+	{Opt_test_dummy_encryption, "test_dummy_encryption"},
 	{Opt_err, NULL},
 };
 
@@ -719,6 +721,18 @@ static int parse_options(struct super_block *sb, char *options)
 			}
 			kfree(name);
 			break;
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
+		case Opt_test_dummy_encryption:
+			sbi->mount_flags |= F2FS_MF_TEST_DUMMY_ENCRYPTION;
+			f2fs_msg(sb, KERN_INFO,
+					"Test dummy encryption mode enabled");
+			break;
+#else
+		case Opt_test_dummy_encryption:
+			f2fs_msg(sb, KERN_INFO,
+					"Test dummy encryption mount option ignored");
+			break;
+#endif
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
@@ -1282,6 +1296,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",whint_mode=%s", "user-based");
 	else if (sbi->whint_mode == WHINT_MODE_FS)
 		seq_printf(seq, ",whint_mode=%s", "fs-based");
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
+	if (sbi->mount_flags & F2FS_MF_TEST_DUMMY_ENCRYPTION)
+		seq_puts(seq, ",test_dummy_encryption");
+#endif
 
 	if (sbi->alloc_mode == ALLOC_MODE_DEFAULT)
 		seq_printf(seq, ",alloc_mode=%s", "default");
@@ -1865,11 +1883,28 @@ static int f2fs_get_context(struct inode *inode, void *ctx, size_t len)
 static int f2fs_set_context(struct inode *inode, const void *ctx, size_t len,
 							void *fs_data)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+	/*
+	 * Encrypting the root directory is not allowed because fsck
+	 * expects lost+found directory to exist and remain unencrypted
+	 * if LOST_FOUND feature is enabled.
+	 *
+	 */
+	if (f2fs_sb_has_lost_found(sbi->sb) &&
+			inode->i_ino == F2FS_ROOT_INO(sbi))
+		return -EPERM;
+
 	return f2fs_setxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
 				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT,
 				ctx, len, fs_data, XATTR_CREATE);
 }
 
+static bool f2fs_dummy_context(struct inode *inode)
+{
+	return DUMMY_ENCRYPTION_ENABLED(F2FS_I_SB(inode));
+}
+
 static unsigned f2fs_max_namelen(struct inode *inode)
 {
 	return S_ISLNK(inode->i_mode) ?
@@ -1880,6 +1915,7 @@ static const struct fscrypt_operations f2fs_cryptops = {
 	.key_prefix	= "f2fs:",
 	.get_context	= f2fs_get_context,
 	.set_context	= f2fs_set_context,
+	.dummy_context	= f2fs_dummy_context,
 	.empty_dir	= f2fs_empty_dir,
 	.max_namelen	= f2fs_max_namelen,
 };
@@ -2696,6 +2732,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		}
 	}
 
+	if (DUMMY_ENCRYPTION_ENABLED(sbi) && !f2fs_readonly(sb) &&
+				!f2fs_sb_has_encrypt(sb)) {
+		f2fs_sb_set_encrypt(sb);
+		recovery = 1;
+	}
+
 	/* get an inode for meta space */
 	sbi->meta_inode = f2fs_iget(sb, F2FS_META_INO(sbi));
 	if (IS_ERR(sbi->meta_inode)) {
@@ -2870,12 +2912,16 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	}
 	kfree(options);
 
-	/* recover broken superblock */
+	/* recover broken superblock or enable encrypt feature */
 	if (recovery) {
-		err = f2fs_commit_super(sbi, true);
-		f2fs_msg(sb, KERN_INFO,
-			"Try to recover %dth superblock, ret: %d",
-			sbi->valid_super_block ? 1 : 2, err);
+		if (sbi->mount_flags & F2FS_MF_TEST_DUMMY_ENCRYPTION) {
+			f2fs_commit_super(sbi, false);
+		} else {
+			err = f2fs_commit_super(sbi, true);
+			f2fs_msg(sb, KERN_INFO,
+				"Try to recover %dth superblock, ret: %d",
+				sbi->valid_super_block ? 1 : 2, err);
+		}
 	}
 
 	f2fs_join_shrinker(sbi);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 23a2d8d66c43..53c6785c1916 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -116,6 +116,9 @@ static ssize_t features_show(struct f2fs_attr *a,
 	if (f2fs_sb_has_inode_crtime(sb))
 		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "inode_crtime");
+	if (f2fs_sb_has_lost_found(sb))
+		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
+				len ? ", " : "", "lost_found");
 	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
 	return len;
 }
@@ -292,6 +295,7 @@ enum feat_id {
 	FEAT_FLEXIBLE_INLINE_XATTR,
 	FEAT_QUOTA_INO,
 	FEAT_INODE_CRTIME,
+	FEAT_LOST_FOUND,
 };
 
 static ssize_t f2fs_feature_show(struct f2fs_attr *a,
@@ -307,6 +311,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
 	case FEAT_FLEXIBLE_INLINE_XATTR:
 	case FEAT_QUOTA_INO:
 	case FEAT_INODE_CRTIME:
+	case FEAT_LOST_FOUND:
 		return snprintf(buf, PAGE_SIZE, "supported\n");
 	}
 	return 0;
@@ -386,6 +391,7 @@ F2FS_FEATURE_RO_ATTR(inode_checksum, FEAT_INODE_CHECKSUM);
 F2FS_FEATURE_RO_ATTR(flexible_inline_xattr, FEAT_FLEXIBLE_INLINE_XATTR);
 F2FS_FEATURE_RO_ATTR(quota_ino, FEAT_QUOTA_INO);
 F2FS_FEATURE_RO_ATTR(inode_crtime, FEAT_INODE_CRTIME);
+F2FS_FEATURE_RO_ATTR(lost_found, FEAT_LOST_FOUND);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -441,6 +447,7 @@ static struct attribute *f2fs_feat_attrs[] = {
 	ATTR_LIST(flexible_inline_xattr),
 	ATTR_LIST(quota_ino),
 	ATTR_LIST(inode_crtime),
+	ATTR_LIST(lost_found),
 	NULL,
 };
 
-- 
2.14.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
