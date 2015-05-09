From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 08/18] f2fs crypto: add encryption key management
	facilities
Date: Fri,  8 May 2015 21:20:43 -0700
Message-ID: <1431145253-2019-8-git-send-email-jaegeuk@kernel.org>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YqwGX-0007h6-H5
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:29 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqwGW-0004er-CP for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:29 +0000
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

This patch copies from encrypt_key.c in ext4, and modifies for f2fs.

Use GFP_NOFS, since _f2fs_get_encryption_info is called under f2fs_lock_op.

Signed-off-by: Michael Halcrow <mhalcrow@google.com>
Signed-off-by: Ildar Muslukhov <muslukhovi@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/Makefile      |   2 +-
 fs/f2fs/crypto_key.c  | 200 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h        |  22 ++++++
 fs/f2fs/f2fs_crypto.h |   3 +
 4 files changed, 226 insertions(+), 1 deletion(-)
 create mode 100644 fs/f2fs/crypto_key.c

diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
index a79907b..b08925d 100644
--- a/fs/f2fs/Makefile
+++ b/fs/f2fs/Makefile
@@ -6,4 +6,4 @@ f2fs-$(CONFIG_F2FS_STAT_FS) += debug.o
 f2fs-$(CONFIG_F2FS_FS_XATTR) += xattr.o
 f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) += acl.o
 f2fs-$(CONFIG_F2FS_IO_TRACE) += trace.o
-f2fs-$(CONFIG_F2FS_FS_ENCRYPTION) += crypto_policy.o crypto.o
+f2fs-$(CONFIG_F2FS_FS_ENCRYPTION) += crypto_policy.o crypto.o crypto_key.o
diff --git a/fs/f2fs/crypto_key.c b/fs/f2fs/crypto_key.c
new file mode 100644
index 0000000..aec7e17
--- /dev/null
+++ b/fs/f2fs/crypto_key.c
@@ -0,0 +1,200 @@
+/*
+ * linux/fs/f2fs/crypto_key.c
+ *
+ * Copied from linux/fs/f2fs/crypto_key.c
+ *
+ * Copyright (C) 2015, Google, Inc.
+ *
+ * This contains encryption key functions for f2fs
+ *
+ * Written by Michael Halcrow, Ildar Muslukhov, and Uday Savagaonkar, 2015.
+ */
+#include <keys/encrypted-type.h>
+#include <keys/user-type.h>
+#include <linux/random.h>
+#include <linux/scatterlist.h>
+#include <uapi/linux/keyctl.h>
+#include <crypto/hash.h>
+#include <linux/f2fs_fs.h>
+
+#include "f2fs.h"
+#include "xattr.h"
+
+static void derive_crypt_complete(struct crypto_async_request *req, int rc)
+{
+	struct f2fs_completion_result *ecr = req->data;
+
+	if (rc == -EINPROGRESS)
+		return;
+
+	ecr->res = rc;
+	complete(&ecr->completion);
+}
+
+/**
+ * f2fs_derive_key_aes() - Derive a key using AES-128-ECB
+ * @deriving_key: Encryption key used for derivatio.
+ * @source_key:   Source key to which to apply derivation.
+ * @derived_key:  Derived key.
+ *
+ * Return: Zero on success; non-zero otherwise.
+ */
+static int f2fs_derive_key_aes(char deriving_key[F2FS_AES_128_ECB_KEY_SIZE],
+				char source_key[F2FS_AES_256_XTS_KEY_SIZE],
+				char derived_key[F2FS_AES_256_XTS_KEY_SIZE])
+{
+	int res = 0;
+	struct ablkcipher_request *req = NULL;
+	DECLARE_F2FS_COMPLETION_RESULT(ecr);
+	struct scatterlist src_sg, dst_sg;
+	struct crypto_ablkcipher *tfm = crypto_alloc_ablkcipher("ecb(aes)", 0,
+								0);
+
+	if (IS_ERR(tfm)) {
+		res = PTR_ERR(tfm);
+		tfm = NULL;
+		goto out;
+	}
+	crypto_ablkcipher_set_flags(tfm, CRYPTO_TFM_REQ_WEAK_KEY);
+	req = ablkcipher_request_alloc(tfm, GFP_NOFS);
+	if (!req) {
+		res = -ENOMEM;
+		goto out;
+	}
+	ablkcipher_request_set_callback(req,
+			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
+			derive_crypt_complete, &ecr);
+	res = crypto_ablkcipher_setkey(tfm, deriving_key,
+				F2FS_AES_128_ECB_KEY_SIZE);
+	if (res < 0)
+		goto out;
+
+	sg_init_one(&src_sg, source_key, F2FS_AES_256_XTS_KEY_SIZE);
+	sg_init_one(&dst_sg, derived_key, F2FS_AES_256_XTS_KEY_SIZE);
+	ablkcipher_request_set_crypt(req, &src_sg, &dst_sg,
+					F2FS_AES_256_XTS_KEY_SIZE, NULL);
+	res = crypto_ablkcipher_encrypt(req);
+	if (res == -EINPROGRESS || res == -EBUSY) {
+		BUG_ON(req->base.data != &ecr);
+		wait_for_completion(&ecr.completion);
+		res = ecr.res;
+	}
+out:
+	if (req)
+		ablkcipher_request_free(req);
+	if (tfm)
+		crypto_free_ablkcipher(tfm);
+	return res;
+}
+
+void f2fs_free_encryption_info(struct inode *inode)
+{
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct f2fs_crypt_info *ci = fi->i_crypt_info;
+
+	if (!ci)
+		return;
+
+	if (ci->ci_keyring_key)
+		key_put(ci->ci_keyring_key);
+	crypto_free_ablkcipher(ci->ci_ctfm);
+	memzero_explicit(&ci->ci_raw, sizeof(ci->ci_raw));
+	kfree(ci);
+	fi->i_crypt_info = NULL;
+}
+
+int _f2fs_get_encryption_info(struct inode *inode)
+{
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct f2fs_crypt_info *crypt_info;
+	char full_key_descriptor[F2FS_KEY_DESC_PREFIX_SIZE +
+				(F2FS_KEY_DESCRIPTOR_SIZE * 2) + 1];
+	struct key *keyring_key = NULL;
+	struct f2fs_encryption_key *master_key;
+	struct f2fs_encryption_context ctx;
+	struct user_key_payload *ukp;
+	int res;
+
+	if (fi->i_crypt_info) {
+		if (!fi->i_crypt_info->ci_keyring_key ||
+			key_validate(fi->i_crypt_info->ci_keyring_key) == 0)
+			return 0;
+		f2fs_free_encryption_info(inode);
+	}
+
+	res = f2fs_getxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
+				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT,
+				&ctx, sizeof(ctx), NULL);
+	if (res < 0)
+		return res;
+	else if (res != sizeof(ctx))
+		return -EINVAL;
+	res = 0;
+
+	crypt_info = kmalloc(sizeof(struct f2fs_crypt_info), GFP_NOFS);
+	if (!crypt_info)
+		return -ENOMEM;
+
+	crypt_info->ci_flags = ctx.flags;
+	crypt_info->ci_data_mode = ctx.contents_encryption_mode;
+	crypt_info->ci_filename_mode = ctx.filenames_encryption_mode;
+	crypt_info->ci_ctfm = NULL;
+	memcpy(crypt_info->ci_master_key, ctx.master_key_descriptor,
+				sizeof(crypt_info->ci_master_key));
+	if (S_ISREG(inode->i_mode))
+		crypt_info->ci_mode = ctx.contents_encryption_mode;
+	else if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
+		crypt_info->ci_mode = ctx.filenames_encryption_mode;
+	else {
+		printk(KERN_ERR "f2fs crypto: Unsupported inode type.\n");
+		BUG();
+	}
+	crypt_info->ci_size = f2fs_encryption_key_size(crypt_info->ci_mode);
+	BUG_ON(!crypt_info->ci_size);
+
+	memcpy(full_key_descriptor, F2FS_KEY_DESC_PREFIX,
+					F2FS_KEY_DESC_PREFIX_SIZE);
+	sprintf(full_key_descriptor + F2FS_KEY_DESC_PREFIX_SIZE,
+					"%*phN", F2FS_KEY_DESCRIPTOR_SIZE,
+					ctx.master_key_descriptor);
+	full_key_descriptor[F2FS_KEY_DESC_PREFIX_SIZE +
+					(2 * F2FS_KEY_DESCRIPTOR_SIZE)] = '\0';
+	keyring_key = request_key(&key_type_logon, full_key_descriptor, NULL);
+	if (IS_ERR(keyring_key)) {
+		res = PTR_ERR(keyring_key);
+		keyring_key = NULL;
+		goto out;
+	}
+	BUG_ON(keyring_key->type != &key_type_logon);
+	ukp = ((struct user_key_payload *)keyring_key->payload.data);
+	if (ukp->datalen != sizeof(struct f2fs_encryption_key)) {
+		res = -EINVAL;
+		goto out;
+	}
+	master_key = (struct f2fs_encryption_key *)ukp->data;
+	BUILD_BUG_ON(F2FS_AES_128_ECB_KEY_SIZE !=
+				F2FS_KEY_DERIVATION_NONCE_SIZE);
+	BUG_ON(master_key->size != F2FS_AES_256_XTS_KEY_SIZE);
+	res = f2fs_derive_key_aes(ctx.nonce, master_key->raw,
+					crypt_info->ci_raw);
+out:
+	if (res < 0) {
+		if (res == -ENOKEY)
+			res = 0;
+		kfree(crypt_info);
+	} else {
+		fi->i_crypt_info = crypt_info;
+		crypt_info->ci_keyring_key = keyring_key;
+		keyring_key = NULL;
+	}
+	if (keyring_key)
+		key_put(keyring_key);
+	return res;
+}
+
+int f2fs_has_encryption_key(struct inode *inode)
+{
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+
+	return (fi->i_crypt_info != NULL);
+}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d586346..ef79ac8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1973,17 +1973,39 @@ int f2fs_decrypt(struct f2fs_crypto_ctx *, struct page *);
 int f2fs_decrypt_one(struct inode *, struct page *);
 void f2fs_end_io_crypto_work(struct f2fs_crypto_ctx *, struct bio *);
 
+/* crypto_key.c */
+void f2fs_free_encryption_info(struct inode *);
+int _f2fs_get_encryption_info(struct inode *inode);
+
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 void f2fs_restore_and_release_control_page(struct page **);
 void f2fs_restore_control_page(struct page *);
 
 int f2fs_init_crypto(void);
 void f2fs_exit_crypto(void);
+
+int f2fs_has_encryption_key(struct inode *);
+
+static inline int f2fs_get_encryption_info(struct inode *inode)
+{
+	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
+
+	if (!ci ||
+		(ci->ci_keyring_key &&
+		 (ci->ci_keyring_key->flags & ((1 << KEY_FLAG_INVALIDATED) |
+					       (1 << KEY_FLAG_REVOKED) |
+					       (1 << KEY_FLAG_DEAD)))))
+		return _f2fs_get_encryption_info(inode);
+	return 0;
+}
 #else
 static inline void f2fs_restore_and_release_control_page(struct page **p) { }
 static inline void f2fs_restore_control_page(struct page *p) { }
 
 static inline int f2fs_init_crypto(void) { return 0; }
 static inline void f2fs_exit_crypto(void) { }
+
+static inline int f2fs_has_encryption_key(struct inode *i) { return 0; }
+static inline int f2fs_get_encryption_info(struct inode *i) { return 0; }
 #endif
 #endif
diff --git a/fs/f2fs/f2fs_crypto.h b/fs/f2fs/f2fs_crypto.h
index cfc37c1..bad32e6 100644
--- a/fs/f2fs/f2fs_crypto.h
+++ b/fs/f2fs/f2fs_crypto.h
@@ -65,6 +65,9 @@ struct f2fs_encryption_context {
 #define F2FS_AES_256_XTS_KEY_SIZE 64
 #define F2FS_MAX_KEY_SIZE 64
 
+#define F2FS_KEY_DESC_PREFIX "f2fs:"
+#define F2FS_KEY_DESC_PREFIX_SIZE 5
+
 struct f2fs_encryption_key {
 	__u32 mode;
 	char raw[F2FS_MAX_KEY_SIZE];
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
