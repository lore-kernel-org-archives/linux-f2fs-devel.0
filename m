From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 03/10] fs crypto: add policy.c to handle contexts
Date: Thu, 25 Feb 2016 11:26:01 -0800
Message-ID: <1456428368-41527-4-git-send-email-jaegeuk@kernel.org>
References: <1456428368-41527-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456428368-41527-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, tytso@mit.edu
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Michael Halcrow <mhalcrow@google.com>, Ildar Muslukhov <muslukhovi@gmail.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds policy.c supporting context management.

1. For ioctls:
 - fscrypt_process_policy
 - fscrypt_get_policy

2. For context permission
 - fscrypt_has_permitted_context
 - fscrypt_inherit_context

Signed-off-by: Michael Halcrow <mhalcrow@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ildar Muslukhov <muslukhovi@gmail.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/crypto/policy.c       | 229 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fscrypto.h |  30 +++++++
 2 files changed, 259 insertions(+)
 create mode 100644 fs/crypto/policy.c

diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
new file mode 100644
index 0000000..0f9961e
--- /dev/null
+++ b/fs/crypto/policy.c
@@ -0,0 +1,229 @@
+/*
+ * Encryption policy functions for per-file encryption support.
+ *
+ * Copyright (C) 2015, Google, Inc.
+ * Copyright (C) 2015, Motorola Mobility.
+ *
+ * Written by Michael Halcrow, 2015.
+ * Modified by Jaegeuk Kim, 2015.
+ */
+
+#include <linux/random.h>
+#include <linux/string.h>
+#include <linux/fscrypto.h>
+
+static int inode_has_encryption_context(struct inode *inode)
+{
+	if (!inode->i_sb->s_cop->get_context)
+		return 0;
+	return (inode->i_sb->s_cop->get_context(inode, NULL, 0L) > 0);
+}
+
+/*
+ * check whether the policy is consistent with the encryption context
+ * for the inode
+ */
+static int is_encryption_context_consistent_with_policy(struct inode *inode,
+				const struct fscrypt_policy *policy)
+{
+	struct fscrypt_context ctx;
+	int res;
+
+	if (!inode->i_sb->s_cop->get_context)
+		return 0;
+
+	res = inode->i_sb->s_cop->get_context(inode, &ctx, sizeof(ctx));
+	if (res != sizeof(ctx))
+		return 0;
+
+	return (memcmp(ctx.master_key_descriptor, policy->master_key_descriptor,
+			FS_KEY_DESCRIPTOR_SIZE) == 0 &&
+			(ctx.flags == policy->flags) &&
+			(ctx.contents_encryption_mode ==
+			 policy->contents_encryption_mode) &&
+			(ctx.filenames_encryption_mode ==
+			 policy->filenames_encryption_mode));
+}
+
+static int create_encryption_context_from_policy(struct inode *inode,
+				const struct fscrypt_policy *policy)
+{
+	struct fscrypt_context ctx;
+	int res;
+
+	if (!inode->i_sb->s_cop->set_context)
+		return -EOPNOTSUPP;
+
+	if (inode->i_sb->s_cop->prepare_context) {
+		res = inode->i_sb->s_cop->prepare_context(inode);
+		if (res)
+			return res;
+	}
+
+	ctx.format = FS_ENCRYPTION_CONTEXT_FORMAT_V1;
+	memcpy(ctx.master_key_descriptor, policy->master_key_descriptor,
+					FS_KEY_DESCRIPTOR_SIZE);
+
+	if (!fscrypt_valid_contents_enc_mode(
+				policy->contents_encryption_mode)) {
+		printk(KERN_WARNING
+		       "%s: Invalid contents encryption mode %d\n", __func__,
+			policy->contents_encryption_mode);
+		return -EINVAL;
+	}
+
+	if (!fscrypt_valid_filenames_enc_mode(
+				policy->filenames_encryption_mode)) {
+		printk(KERN_WARNING
+			"%s: Invalid filenames encryption mode %d\n", __func__,
+			policy->filenames_encryption_mode);
+		return -EINVAL;
+	}
+
+	if (policy->flags & ~FS_POLICY_FLAGS_VALID)
+		return -EINVAL;
+
+	ctx.contents_encryption_mode = policy->contents_encryption_mode;
+	ctx.filenames_encryption_mode = policy->filenames_encryption_mode;
+	ctx.flags = policy->flags;
+	BUILD_BUG_ON(sizeof(ctx.nonce) != FS_KEY_DERIVATION_NONCE_SIZE);
+	get_random_bytes(ctx.nonce, FS_KEY_DERIVATION_NONCE_SIZE);
+
+	return inode->i_sb->s_cop->set_context(inode, &ctx, sizeof(ctx), NULL);
+}
+
+int fscrypt_process_policy(struct inode *inode,
+				const struct fscrypt_policy *policy)
+{
+	if (policy->version != 0)
+		return -EINVAL;
+
+	if (!inode_has_encryption_context(inode)) {
+		if (!inode->i_sb->s_cop->empty_dir)
+			return -EOPNOTSUPP;
+		if (!inode->i_sb->s_cop->empty_dir(inode))
+			return -ENOTEMPTY;
+		return create_encryption_context_from_policy(inode, policy);
+	}
+
+	if (is_encryption_context_consistent_with_policy(inode, policy))
+		return 0;
+
+	printk(KERN_WARNING "%s: Policy inconsistent with encryption context\n",
+	       __func__);
+	return -EINVAL;
+}
+EXPORT_SYMBOL(fscrypt_process_policy);
+
+int fscrypt_get_policy(struct inode *inode, struct fscrypt_policy *policy)
+{
+	struct fscrypt_context ctx;
+	int res;
+
+	if (!inode->i_sb->s_cop->get_context ||
+			!inode->i_sb->s_cop->is_encrypted(inode))
+		return -ENODATA;
+
+	res = inode->i_sb->s_cop->get_context(inode, &ctx, sizeof(ctx));
+	if (res != sizeof(ctx))
+		return -ENODATA;
+	if (ctx.format != FS_ENCRYPTION_CONTEXT_FORMAT_V1)
+		return -EINVAL;
+
+	policy->version = 0;
+	policy->contents_encryption_mode = ctx.contents_encryption_mode;
+	policy->filenames_encryption_mode = ctx.filenames_encryption_mode;
+	policy->flags = ctx.flags;
+	memcpy(&policy->master_key_descriptor, ctx.master_key_descriptor,
+				FS_KEY_DESCRIPTOR_SIZE);
+	return 0;
+}
+EXPORT_SYMBOL(fscrypt_get_policy);
+
+int fscrypt_has_permitted_context(struct inode *parent, struct inode *child)
+{
+	struct fscrypt_info *parent_ci, *child_ci;
+	int res;
+
+	if ((parent == NULL) || (child == NULL)) {
+		printk(KERN_ERR	"parent %p child %p\n", parent, child);
+		BUG_ON(1);
+	}
+
+	/* no restrictions if the parent directory is not encrypted */
+	if (!parent->i_sb->s_cop->is_encrypted(parent))
+		return 1;
+	/* if the child directory is not encrypted, this is always a problem */
+	if (!parent->i_sb->s_cop->is_encrypted(child))
+		return 0;
+	res = fscrypt_get_encryption_info(parent);
+	if (res)
+		return 0;
+	res = fscrypt_get_encryption_info(child);
+	if (res)
+		return 0;
+	parent_ci = parent->i_crypt_info;
+	child_ci = child->i_crypt_info;
+	if (!parent_ci && !child_ci)
+		return 1;
+	if (!parent_ci || !child_ci)
+		return 0;
+
+	return (memcmp(parent_ci->ci_master_key,
+			child_ci->ci_master_key,
+			FS_KEY_DESCRIPTOR_SIZE) == 0 &&
+		(parent_ci->ci_data_mode == child_ci->ci_data_mode) &&
+		(parent_ci->ci_filename_mode == child_ci->ci_filename_mode) &&
+		(parent_ci->ci_flags == child_ci->ci_flags));
+}
+EXPORT_SYMBOL(fscrypt_has_permitted_context);
+
+/**
+ * fscrypt_inherit_context() - Sets a child context from its parent
+ * @parent: Parent inode from which the context is inherited.
+ * @child:  Child inode that inherits the context from @parent.
+ * @fs_data:  private data given by FS.
+ * @preload:  preload child i_crypt_info
+ *
+ * Return: Zero on success, non-zero otherwise
+ */
+int fscrypt_inherit_context(struct inode *parent, struct inode *child,
+						void *fs_data, bool preload)
+{
+	struct fscrypt_context ctx;
+	struct fscrypt_info *ci;
+	int res;
+
+	if (!parent->i_sb->s_cop->set_context)
+		return -EOPNOTSUPP;
+
+	res = fscrypt_get_encryption_info(parent);
+	if (res < 0)
+		return res;
+
+	ci = parent->i_crypt_info;
+	if (ci == NULL)
+		return -ENOKEY;
+
+	ctx.format = FS_ENCRYPTION_CONTEXT_FORMAT_V1;
+	if (fscrypt_dummy_context_enabled(parent)) {
+		ctx.contents_encryption_mode = FS_ENCRYPTION_MODE_AES_256_XTS;
+		ctx.filenames_encryption_mode = FS_ENCRYPTION_MODE_AES_256_CTS;
+		ctx.flags = 0;
+		memset(ctx.master_key_descriptor, 0x42, FS_KEY_DESCRIPTOR_SIZE);
+		res = 0;
+	} else {
+		ctx.contents_encryption_mode = ci->ci_data_mode;
+		ctx.filenames_encryption_mode = ci->ci_filename_mode;
+		ctx.flags = ci->ci_flags;
+		memcpy(ctx.master_key_descriptor, ci->ci_master_key,
+				FS_KEY_DESCRIPTOR_SIZE);
+	}
+	get_random_bytes(ctx.nonce, FS_KEY_DERIVATION_NONCE_SIZE);
+	res = parent->i_sb->s_cop->set_context(child, &ctx,
+						sizeof(ctx), fs_data);
+	if (res)
+		return res;
+	return preload ? fscrypt_get_encryption_info(child): 0;
+}
+EXPORT_SYMBOL(fscrypt_inherit_context);
diff --git a/include/linux/fscrypto.h b/include/linux/fscrypto.h
index 09fbcfb..5b18b89 100644
--- a/include/linux/fscrypto.h
+++ b/include/linux/fscrypto.h
@@ -251,6 +251,12 @@ void fscrypt_decrypt_bio_pages(struct fscrypt_ctx *, struct bio *);
 void fscrypt_pullback_bio_page(struct page **, bool);
 void fscrypt_restore_control_page(struct page *);
 int fscrypt_zeroout_range(struct inode *, pgoff_t, sector_t, unsigned int);
+
+/* policy.c */
+int fscrypt_process_policy(struct inode *, const struct fscrypt_policy *);
+int fscrypt_get_policy(struct inode *, struct fscrypt_policy *);
+int fscrypt_has_permitted_context(struct inode *, struct inode *);
+int fscrypt_inherit_context(struct inode *, struct inode *, void *, bool);
 #else
 /* crypto.c */
 static inline struct fscrypt_ctx *fscrypt_get_ctx(struct inode *i)
@@ -294,5 +300,29 @@ static inline int fscrypt_zeroout_range(struct inode *i, pgoff_t p,
 {
 	return -EOPNOTSUPP;
 }
+
+/* policy.c */
+static inline int fscrypt_process_policy(struct inode *i,
+				const struct fscrypt_policy *p)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int fscrypt_get_policy(struct inode *i, struct fscrypt_policy *p)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int fscrypt_has_permitted_context(struct inode *p,
+				struct inode *i)
+{
+	return 0;
+}
+
+static inline int fscrypt_inherit_context(struct inode *p, struct inode *i,
+				void *v, bool b)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 #endif	/* _LINUX_FSCRYPTO_H */
-- 
2.6.3
