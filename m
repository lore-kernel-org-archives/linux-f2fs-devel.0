From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH v2] f2fs: introduce F2FS_FEATURE_LOST_FOUND
 feature
Date: Fri, 23 Feb 2018 11:23:33 +0800
Message-ID: <20180223032333.231870-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1ep3xr-0004Z4-RE
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Feb 2018 03:24:03 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ep3xp-0007Do-Oj
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Feb 2018 03:24:03 +0000
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
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

This patch introduces a new feature, F2FS_FEATURE_LOST_FOUND, which
is set by mkfs. It creates a directory named lost+found, which saves
unreachable files. If fsck finds a file which has no parent, or its
parent is removed by fsck, the file will be placed under lost+found
directory by fsck.

lost+found directory could not be encrypted. As a result, the root
directory cannot be encrypted too. So if LOST_FOUND feature is enabled,
let's avoid to encrypt root directory.

This patch also introduces a new mount option `test_dummy_context'
to allow fscrypt to create a fake fscrypt context. This is used by
xfstests.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
v2->v1:
 * introduce new mount option test_dummy_context
 * add sysfs entry for LOST_FOUND feature

 fs/f2fs/f2fs.h  |  6 ++++++
 fs/f2fs/super.c | 37 +++++++++++++++++++++++++++++++++++++
 fs/f2fs/sysfs.c |  7 +++++++
 3 files changed, 50 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8b251bc8d38c..3e9283b3b3f5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -125,6 +125,7 @@ struct f2fs_mount_info {
 #define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x0040
 #define F2FS_FEATURE_QUOTA_INO		0x0080
 #define F2FS_FEATURE_INODE_CRTIME	0x0100
+#define F2FS_FEATURE_LOST_FOUND		0x0200
 
 #define F2FS_HAS_FEATURE(sb, mask)					\
 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
@@ -1043,6 +1044,8 @@ enum {
 	WHINT_MODE_FS,		/* pass down hints with F2FS policy */
 };
 
+#define F2FS_MF_TEST_DUMMY_ENCRYPTION	0x0001
+
 struct f2fs_sb_info {
 	struct super_block *sb;			/* pointer to VFS super block */
 	struct proc_dir_entry *s_proc;		/* proc entry */
@@ -1228,6 +1231,8 @@ struct f2fs_sb_info {
 #endif
 	/* For which write hints are passed down to block layer */
 	int whint_mode;
+
+	unsigned int mount_flags;
 };
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
@@ -3202,6 +3207,7 @@ F2FS_FEATURE_FUNCS(inode_chksum, INODE_CHKSUM);
 F2FS_FEATURE_FUNCS(flexible_inline_xattr, FLEXIBLE_INLINE_XATTR);
 F2FS_FEATURE_FUNCS(quota_ino, QUOTA_INO);
 F2FS_FEATURE_FUNCS(inode_crtime, INODE_CRTIME);
+F2FS_FEATURE_FUNCS(lost_found, LOST_FOUND);
 
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline int get_blkz_type(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 338a8cb8a489..d2d2a2768b91 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -130,6 +130,7 @@ enum {
 	Opt_jqfmt_vfsv0,
 	Opt_jqfmt_vfsv1,
 	Opt_whint,
+	Opt_test_dummy_encryption,
 	Opt_err,
 };
 
@@ -184,6 +185,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_jqfmt_vfsv0, "jqfmt=vfsv0"},
 	{Opt_jqfmt_vfsv1, "jqfmt=vfsv1"},
 	{Opt_whint, "whint_mode=%s"},
+	{Opt_test_dummy_encryption, "test_dummy_encryption"},
 	{Opt_err, NULL},
 };
 
@@ -700,6 +702,18 @@ static int parse_options(struct super_block *sb, char *options)
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
+			f2fs(sb, KERN_INFO,
+					"Test dummy encryption mount option ignored");
+			break;
+#endif
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
@@ -1263,6 +1277,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",whint_mode=%s", "user-based");
 	else if (sbi->whint_mode == WHINT_MODE_FS)
 		seq_printf(seq, ",whint_mode=%s", "fs-based");
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
+	if (sbi->mount_flags & F2FS_MF_TEST_DUMMY_ENCRYPTION)
+		seq_puts(seq, ",test_dummy_encryption");
+#endif
 
 	return 0;
 }
@@ -1837,11 +1855,29 @@ static int f2fs_get_context(struct inode *inode, void *ctx, size_t len)
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
+	return (unlikely(F2FS_I_SB(inode)->mount_flags &
+				F2FS_MF_TEST_DUMMY_ENCRYPTION));
+}
+
 static unsigned f2fs_max_namelen(struct inode *inode)
 {
 	return S_ISLNK(inode->i_mode) ?
@@ -1852,6 +1888,7 @@ static const struct fscrypt_operations f2fs_cryptops = {
 	.key_prefix	= "f2fs:",
 	.get_context	= f2fs_get_context,
 	.set_context	= f2fs_set_context,
+	.dummy_context	= f2fs_dummy_context,
 	.empty_dir	= f2fs_empty_dir,
 	.max_namelen	= f2fs_max_namelen,
 };
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 374ee5c82f94..08129d48e032 100644
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
@@ -236,6 +239,7 @@ enum feat_id {
 	FEAT_FLEXIBLE_INLINE_XATTR,
 	FEAT_QUOTA_INO,
 	FEAT_INODE_CRTIME,
+	FEAT_LOST_FOUND,
 };
 
 static ssize_t f2fs_feature_show(struct f2fs_attr *a,
@@ -251,6 +255,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
 	case FEAT_FLEXIBLE_INLINE_XATTR:
 	case FEAT_QUOTA_INO:
 	case FEAT_INODE_CRTIME:
+	case FEAT_LOST_FOUND:
 		return snprintf(buf, PAGE_SIZE, "supported\n");
 	}
 	return 0;
@@ -329,6 +334,7 @@ F2FS_FEATURE_RO_ATTR(inode_checksum, FEAT_INODE_CHECKSUM);
 F2FS_FEATURE_RO_ATTR(flexible_inline_xattr, FEAT_FLEXIBLE_INLINE_XATTR);
 F2FS_FEATURE_RO_ATTR(quota_ino, FEAT_QUOTA_INO);
 F2FS_FEATURE_RO_ATTR(inode_crtime, FEAT_INODE_CRTIME);
+F2FS_FEATURE_RO_ATTR(lost_found, FEAT_LOST_FOUND);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -383,6 +389,7 @@ static struct attribute *f2fs_feat_attrs[] = {
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
