From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 06/18] f2fs crypto: add encryption policy and
	password salt support
Date: Fri,  8 May 2015 21:20:41 -0700
Message-ID: <1431145253-2019-6-git-send-email-jaegeuk@kernel.org>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YqwGR-0007gV-G7
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:23 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqwGP-0007iG-VG for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:23 +0000
In-Reply-To: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Ildar Muslukhov <muslukhovi@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Michael Halcrow <mhalcrow@google.com>, Theodore Ts'o <tytso@mit.edu>

This patch adds encryption policy and password salt support through ioctl
implementation.

It adds three ioctls:
 F2FS_IOC_SET_ENCRYPTION_POLICY,
 F2FS_IOC_GET_ENCRYPTION_POLICY,
 F2FS_IOC_GET_ENCRYPTION_PWSALT, which use xattr operations.

Note that, these definition and codes are taken from ext4 crypto support.
For f2fs, xattr operations and on-disk flags for superblock and inode were
changed.

Signed-off-by: Michael Halcrow <mhalcrow@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ildar Muslukhov <muslukhovi@gmail.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/Makefile        |   1 +
 fs/f2fs/crypto_policy.c | 206 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h          |  16 ++++
 fs/f2fs/file.c          |  91 +++++++++++++++++++++
 fs/f2fs/xattr.c         |   3 +
 5 files changed, 317 insertions(+)
 create mode 100644 fs/f2fs/crypto_policy.c

diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
index d923977..7864f4f 100644
--- a/fs/f2fs/Makefile
+++ b/fs/f2fs/Makefile
@@ -6,3 +6,4 @@ f2fs-$(CONFIG_F2FS_STAT_FS) += debug.o
 f2fs-$(CONFIG_F2FS_FS_XATTR) += xattr.o
 f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) += acl.o
 f2fs-$(CONFIG_F2FS_IO_TRACE) += trace.o
+f2fs-$(CONFIG_F2FS_FS_ENCRYPTION) += crypto_policy.o
diff --git a/fs/f2fs/crypto_policy.c b/fs/f2fs/crypto_policy.c
new file mode 100644
index 0000000..bef254b
--- /dev/null
+++ b/fs/f2fs/crypto_policy.c
@@ -0,0 +1,206 @@
+/*
+ * copied from linux/fs/ext4/crypto_policy.c
+ *
+ * Copyright (C) 2015, Google, Inc.
+ * Copyright (C) 2015, Motorola Mobility.
+ *
+ * This contains encryption policy functions for f2fs with some modifications
+ * to support f2fs-specific xattr APIs.
+ *
+ * Written by Michael Halcrow, 2015.
+ * Modified by Jaegeuk Kim, 2015.
+ */
+#include <linux/random.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/f2fs_fs.h>
+
+#include "f2fs.h"
+#include "xattr.h"
+
+static int f2fs_inode_has_encryption_context(struct inode *inode)
+{
+	int res = f2fs_getxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
+			F2FS_XATTR_NAME_ENCRYPTION_CONTEXT, NULL, 0, NULL);
+	return (res > 0);
+}
+
+/*
+ * check whether the policy is consistent with the encryption context
+ * for the inode
+ */
+static int f2fs_is_encryption_context_consistent_with_policy(
+	struct inode *inode, const struct f2fs_encryption_policy *policy)
+{
+	struct f2fs_encryption_context ctx;
+	int res = f2fs_getxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
+				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT, &ctx,
+				sizeof(ctx), NULL);
+
+	if (res != sizeof(ctx))
+		return 0;
+
+	return (memcmp(ctx.master_key_descriptor, policy->master_key_descriptor,
+				F2FS_KEY_DESCRIPTOR_SIZE) == 0 &&
+			(ctx.flags == policy->flags) &&
+			(ctx.contents_encryption_mode ==
+			 policy->contents_encryption_mode) &&
+			(ctx.filenames_encryption_mode ==
+			 policy->filenames_encryption_mode));
+}
+
+static int f2fs_create_encryption_context_from_policy(
+	struct inode *inode, const struct f2fs_encryption_policy *policy)
+{
+	struct f2fs_encryption_context ctx;
+
+	ctx.format = F2FS_ENCRYPTION_CONTEXT_FORMAT_V1;
+	memcpy(ctx.master_key_descriptor, policy->master_key_descriptor,
+			F2FS_KEY_DESCRIPTOR_SIZE);
+
+	if (!f2fs_valid_contents_enc_mode(policy->contents_encryption_mode)) {
+		printk(KERN_WARNING
+		       "%s: Invalid contents encryption mode %d\n", __func__,
+			policy->contents_encryption_mode);
+		return -EINVAL;
+	}
+
+	if (!f2fs_valid_filenames_enc_mode(policy->filenames_encryption_mode)) {
+		printk(KERN_WARNING
+		       "%s: Invalid filenames encryption mode %d\n", __func__,
+			policy->filenames_encryption_mode);
+		return -EINVAL;
+	}
+
+	if (policy->flags & ~F2FS_POLICY_FLAGS_VALID)
+		return -EINVAL;
+
+	ctx.contents_encryption_mode = policy->contents_encryption_mode;
+	ctx.filenames_encryption_mode = policy->filenames_encryption_mode;
+	ctx.flags = policy->flags;
+	BUILD_BUG_ON(sizeof(ctx.nonce) != F2FS_KEY_DERIVATION_NONCE_SIZE);
+	get_random_bytes(ctx.nonce, F2FS_KEY_DERIVATION_NONCE_SIZE);
+
+	return f2fs_setxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
+			F2FS_XATTR_NAME_ENCRYPTION_CONTEXT, &ctx,
+			sizeof(ctx), NULL, 0);
+}
+
+int f2fs_process_policy(const struct f2fs_encryption_policy *policy,
+			struct inode *inode)
+{
+	if (policy->version != 0)
+		return -EINVAL;
+
+	if (!f2fs_inode_has_encryption_context(inode)) {
+		if (!f2fs_empty_dir(inode))
+			return -ENOTEMPTY;
+		return f2fs_create_encryption_context_from_policy(inode,
+								  policy);
+	}
+
+	if (f2fs_is_encryption_context_consistent_with_policy(inode, policy))
+		return 0;
+
+	printk(KERN_WARNING "%s: Policy inconsistent with encryption context\n",
+	       __func__);
+	return -EINVAL;
+}
+
+int f2fs_get_policy(struct inode *inode, struct f2fs_encryption_policy *policy)
+{
+	struct f2fs_encryption_context ctx;
+	int res;
+
+	if (!f2fs_encrypted_inode(inode))
+		return -ENODATA;
+
+	res = f2fs_getxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
+				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT,
+				&ctx, sizeof(ctx), NULL);
+	if (res != sizeof(ctx))
+		return -ENODATA;
+	if (ctx.format != F2FS_ENCRYPTION_CONTEXT_FORMAT_V1)
+		return -EINVAL;
+
+	policy->version = 0;
+	policy->contents_encryption_mode = ctx.contents_encryption_mode;
+	policy->filenames_encryption_mode = ctx.filenames_encryption_mode;
+	policy->flags = ctx.flags;
+	memcpy(&policy->master_key_descriptor, ctx.master_key_descriptor,
+			F2FS_KEY_DESCRIPTOR_SIZE);
+	return 0;
+}
+
+int f2fs_is_child_context_consistent_with_parent(struct inode *parent,
+						struct inode *child)
+{
+	struct f2fs_crypt_info *parent_ci, *child_ci;
+	int res;
+
+	if ((parent == NULL) || (child == NULL)) {
+		pr_err("parent %p child %p\n", parent, child);
+		BUG_ON(1);
+	}
+
+	/* no restrictions if the parent directory is not encrypted */
+	if (!f2fs_encrypted_inode(parent))
+		return 1;
+	/* if the child directory is not encrypted, this is always a problem */
+	if (!f2fs_encrypted_inode(child))
+		return 0;
+	res = f2fs_get_encryption_info(parent);
+	if (res)
+		return 0;
+	res = f2fs_get_encryption_info(child);
+	if (res)
+		return 0;
+	parent_ci = F2FS_I(parent)->i_crypt_info;
+	child_ci = F2FS_I(child)->i_crypt_info;
+	if (!parent_ci && !child_ci)
+		return 1;
+	if (!parent_ci || !child_ci)
+		return 0;
+
+	return (memcmp(parent_ci->ci_master_key,
+			child_ci->ci_master_key,
+			F2FS_KEY_DESCRIPTOR_SIZE) == 0 &&
+		(parent_ci->ci_data_mode == child_ci->ci_data_mode) &&
+		(parent_ci->ci_filename_mode == child_ci->ci_filename_mode) &&
+		(parent_ci->ci_flags == child_ci->ci_flags));
+}
+
+/**
+ * f2fs_inherit_context() - Sets a child context from its parent
+ * @parent: Parent inode from which the context is inherited.
+ * @child:  Child inode that inherits the context from @parent.
+ *
+ * Return: Zero on success, non-zero otherwise
+ */
+int f2fs_inherit_context(struct inode *parent, struct inode *child,
+						struct page *ipage)
+{
+	struct f2fs_encryption_context ctx;
+	struct f2fs_crypt_info *ci;
+	int res;
+
+	res = f2fs_get_encryption_info(parent);
+	if (res < 0)
+		return res;
+
+	ci = F2FS_I(parent)->i_crypt_info;
+	BUG_ON(ci == NULL);
+
+	ctx.format = F2FS_ENCRYPTION_CONTEXT_FORMAT_V1;
+
+	ctx.contents_encryption_mode = ci->ci_data_mode;
+	ctx.filenames_encryption_mode = ci->ci_filename_mode;
+	ctx.flags = ci->ci_flags;
+	memcpy(ctx.master_key_descriptor, ci->ci_master_key,
+			F2FS_KEY_DESCRIPTOR_SIZE);
+
+	get_random_bytes(ctx.nonce, F2FS_KEY_DERIVATION_NONCE_SIZE);
+	return f2fs_setxattr(child, F2FS_XATTR_INDEX_ENCRYPTION,
+				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT, &ctx,
+				sizeof(ctx), ipage, 0);
+}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c3c4deb..d8ce158 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -229,6 +229,13 @@ static inline bool __has_cursum_space(struct f2fs_summary_block *sum, int size,
 #define F2FS_IOC_RELEASE_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 4)
 #define F2FS_IOC_ABORT_VOLATILE_WRITE	_IO(F2FS_IOCTL_MAGIC, 5)
 
+#define F2FS_IOC_SET_ENCRYPTION_POLICY					\
+		_IOR('f', 19, struct f2fs_encryption_policy)
+#define F2FS_IOC_GET_ENCRYPTION_PWSALT					\
+		_IOW('f', 20, __u8[16])
+#define F2FS_IOC_GET_ENCRYPTION_POLICY					\
+		_IOW('f', 21, struct f2fs_encryption_policy)
+
 /*
  * should be same as XFS_IOC_GOINGDOWN.
  * Flags for going down operation used by FS_IOC_GOINGDOWN
@@ -367,6 +374,8 @@ struct f2fs_map_blocks {
 #define F2FS_ENCRYPTION_MODE_AES_256_CBC	3
 #define F2FS_ENCRYPTION_MODE_AES_256_CTS	4
 
+#include "f2fs_crypto.h"
+
 #define DEF_DIR_LEVEL		0
 
 struct f2fs_inode_info {
@@ -1945,4 +1954,11 @@ static inline int f2fs_sb_has_crypto(struct super_block *sb)
 #else
 	return 0;
 #endif
+
+/* crypto_policy.c */
+int f2fs_is_child_context_consistent_with_parent(struct inode *,
+							struct inode *);
+int f2fs_inherit_context(struct inode *, struct inode *, struct page *);
+int f2fs_process_policy(const struct f2fs_encryption_policy *, struct inode *);
+int f2fs_get_policy(struct inode *, struct f2fs_encryption_policy *);
 #endif
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7293746..7236be4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -20,6 +20,7 @@
 #include <linux/uaccess.h>
 #include <linux/mount.h>
 #include <linux/pagevec.h>
+#include <linux/random.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -1347,6 +1348,90 @@ static int f2fs_ioc_fitrim(struct file *filp, unsigned long arg)
 	return 0;
 }
 
+static bool uuid_is_nonzero(__u8 u[16])
+{
+	int i;
+
+	for (i = 0; i < 16; i++)
+		if (u[i])
+			return true;
+	return false;
+}
+
+static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long arg)
+{
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
+	struct f2fs_encryption_policy policy;
+	struct inode *inode = file_inode(filp);
+
+	if (copy_from_user(&policy, (struct f2fs_encryption_policy __user *)arg,
+				sizeof(policy)))
+		return -EFAULT;
+
+	if (f2fs_has_inline_data(inode)) {
+		int ret = f2fs_convert_inline_inode(inode);
+		if (ret)
+			return ret;
+	}
+
+	return f2fs_process_policy(&policy, inode);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static int f2fs_ioc_get_encryption_policy(struct file *filp, unsigned long arg)
+{
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
+	struct f2fs_encryption_policy policy;
+	struct inode *inode = file_inode(filp);
+	int err;
+
+	err = f2fs_get_policy(inode, &policy);
+	if (err)
+		return err;
+
+	if (copy_to_user((void *)arg, &policy, sizeof(policy)))
+		return -EFAULT;
+	return 0;
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	int err;
+
+	if (!f2fs_sb_has_crypto(inode->i_sb))
+		return -EOPNOTSUPP;
+
+	if (uuid_is_nonzero(sbi->raw_super->encrypt_pw_salt))
+		goto got_it;
+
+	err = mnt_want_write_file(filp);
+	if (err)
+		return err;
+
+	/* update superblock with uuid */
+	generate_random_uuid(sbi->raw_super->encrypt_pw_salt);
+
+	err = f2fs_commit_super(sbi);
+
+	mnt_drop_write_file(filp);
+	if (err) {
+		/* undo new data */
+		memset(sbi->raw_super->encrypt_pw_salt, 0, 16);
+		return err;
+	}
+got_it:
+	if (copy_to_user((void *)arg, sbi->raw_super->encrypt_pw_salt, 16))
+		return -EFAULT;
+	return 0;
+}
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
@@ -1370,6 +1455,12 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_shutdown(filp, arg);
 	case FITRIM:
 		return f2fs_ioc_fitrim(filp, arg);
+	case F2FS_IOC_SET_ENCRYPTION_POLICY:
+		return f2fs_ioc_set_encryption_policy(filp, arg);
+	case F2FS_IOC_GET_ENCRYPTION_POLICY:
+		return f2fs_ioc_get_encryption_policy(filp, arg);
+	case F2FS_IOC_GET_ENCRYPTION_PWSALT:
+		return f2fs_ioc_get_encryption_pwsalt(filp, arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 9757f65..07449b98 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -584,6 +584,9 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 		inode->i_ctime = CURRENT_TIME;
 		clear_inode_flag(fi, FI_ACL_MODE);
 	}
+	if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
+			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
+		f2fs_set_encrypted_inode(inode);
 
 	if (ipage)
 		update_inode(inode, ipage);
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
