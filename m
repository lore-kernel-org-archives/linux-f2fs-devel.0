From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 04/10] fs crypto: add keyinfo.c to handle
	permissions
Date: Wed,  2 Mar 2016 10:31:12 -0800
Message-ID: <1456943478-11107-5-git-send-email-jaegeuk@kernel.org>
References: <1456943478-11107-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1abBZA-0003VO-R1
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 02 Mar 2016 18:32:08 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1abBZ5-0004Gh-Ut
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 02 Mar 2016 18:32:08 +0000
In-Reply-To: <1456943478-11107-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, tytso@mit.edu
Cc: Ildar Muslukhov <muslukhovi@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Michael Halcrow <mhalcrow@google.com>

This patch adds keyinfo.c supporting key management.

 - fscrypt_get_encryption_info
 - fscrypt_free_encryption_info

Signed-off-by: Michael Halcrow <mhalcrow@google.com>
Signed-off-by: Ildar Muslukhov <muslukhovi@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/crypto/keyinfo.c      | 278 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fscrypto.h |  16 +++
 2 files changed, 294 insertions(+)
 create mode 100644 fs/crypto/keyinfo.c

diff --git a/fs/crypto/keyinfo.c b/fs/crypto/keyinfo.c
new file mode 100644
index 0000000..cb61842
--- /dev/null
+++ b/fs/crypto/keyinfo.c
@@ -0,0 +1,278 @@
+/*
+ * key management facility for FS encryption support.
+ *
+ * Copyright (C) 2015, Google, Inc.
+ *
+ * This contains encryption key functions.
+ *
+ * Written by Michael Halcrow, Ildar Muslukhov, and Uday Savagaonkar, 2015.
+ */
+
+#include <keys/encrypted-type.h>
+#include <keys/user-type.h>
+#include <linux/random.h>
+#include <linux/scatterlist.h>
+#include <uapi/linux/keyctl.h>
+#include <crypto/hash.h>
+#include <linux/fscrypto.h>
+
+static void derive_crypt_complete(struct crypto_async_request *req, int rc)
+{
+	struct fscrypt_completion_result *ecr = req->data;
+
+	if (rc == -EINPROGRESS)
+		return;
+
+	ecr->res = rc;
+	complete(&ecr->completion);
+}
+
+/**
+ * derive_key_aes() - Derive a key using AES-128-ECB
+ * @deriving_key: Encryption key used for derivation.
+ * @source_key:   Source key to which to apply derivation.
+ * @derived_key:  Derived key.
+ *
+ * Return: Zero on success; non-zero otherwise.
+ */
+static int derive_key_aes(u8 deriving_key[FS_AES_128_ECB_KEY_SIZE],
+				u8 source_key[FS_AES_256_XTS_KEY_SIZE],
+				u8 derived_key[FS_AES_256_XTS_KEY_SIZE])
+{
+	int res = 0;
+	struct ablkcipher_request *req = NULL;
+	DECLARE_FS_COMPLETION_RESULT(ecr);
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
+					FS_AES_128_ECB_KEY_SIZE);
+	if (res < 0)
+		goto out;
+
+	sg_init_one(&src_sg, source_key, FS_AES_256_XTS_KEY_SIZE);
+	sg_init_one(&dst_sg, derived_key, FS_AES_256_XTS_KEY_SIZE);
+	ablkcipher_request_set_crypt(req, &src_sg, &dst_sg,
+					FS_AES_256_XTS_KEY_SIZE, NULL);
+	res = crypto_ablkcipher_encrypt(req);
+	if (res == -EINPROGRESS || res == -EBUSY) {
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
+static void put_crypt_info(struct fscrypt_info *ci)
+{
+	if (!ci)
+		return;
+
+	if (ci->ci_keyring_key)
+		key_put(ci->ci_keyring_key);
+	crypto_free_ablkcipher(ci->ci_ctfm);
+	kmem_cache_free(fscrypt_info_cachep, ci);
+}
+
+int get_crypt_info(struct inode *inode)
+{
+	struct fscrypt_info *crypt_info;
+	u8 full_key_descriptor[FS_KEY_DESC_PREFIX_SIZE +
+				(FS_KEY_DESCRIPTOR_SIZE * 2) + 1];
+	struct key *keyring_key = NULL;
+	struct fscrypt_key *master_key;
+	struct fscrypt_context ctx;
+	const struct user_key_payload *ukp;
+	struct crypto_ablkcipher *ctfm;
+	const char *cipher_str;
+	u8 raw_key[FS_MAX_KEY_SIZE];
+	u8 mode;
+	int res;
+
+	res = fscrypt_initialize();
+	if (res)
+		return res;
+
+	if (!inode->i_sb->s_cop->get_context)
+		return -EOPNOTSUPP;
+retry:
+	crypt_info = ACCESS_ONCE(inode->i_crypt_info);
+	if (crypt_info) {
+		if (!crypt_info->ci_keyring_key ||
+				key_validate(crypt_info->ci_keyring_key) == 0)
+			return 0;
+		fscrypt_put_encryption_info(inode, crypt_info);
+		goto retry;
+	}
+
+	res = inode->i_sb->s_cop->get_context(inode, &ctx, sizeof(ctx));
+	if (res < 0) {
+		if (!fscrypt_dummy_context_enabled(inode))
+			return res;
+		ctx.contents_encryption_mode = FS_ENCRYPTION_MODE_AES_256_XTS;
+		ctx.filenames_encryption_mode = FS_ENCRYPTION_MODE_AES_256_CTS;
+		ctx.flags = 0;
+	} else if (res != sizeof(ctx)) {
+		return -EINVAL;
+	}
+	res = 0;
+
+	crypt_info = kmem_cache_alloc(fscrypt_info_cachep, GFP_NOFS);
+	if (!crypt_info)
+		return -ENOMEM;
+
+	crypt_info->ci_flags = ctx.flags;
+	crypt_info->ci_data_mode = ctx.contents_encryption_mode;
+	crypt_info->ci_filename_mode = ctx.filenames_encryption_mode;
+	crypt_info->ci_ctfm = NULL;
+	crypt_info->ci_keyring_key = NULL;
+	memcpy(crypt_info->ci_master_key, ctx.master_key_descriptor,
+				sizeof(crypt_info->ci_master_key));
+	if (S_ISREG(inode->i_mode))
+		mode = crypt_info->ci_data_mode;
+	else if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
+		mode = crypt_info->ci_filename_mode;
+	else
+		BUG();
+
+	switch (mode) {
+	case FS_ENCRYPTION_MODE_AES_256_XTS:
+		cipher_str = "xts(aes)";
+		break;
+	case FS_ENCRYPTION_MODE_AES_256_CTS:
+		cipher_str = "cts(cbc(aes))";
+		break;
+	default:
+		printk_once(KERN_WARNING
+			    "%s: unsupported key mode %d (ino %u)\n",
+			    __func__, mode, (unsigned) inode->i_ino);
+		res = -ENOKEY;
+		goto out;
+	}
+	if (fscrypt_dummy_context_enabled(inode)) {
+		memset(raw_key, 0x42, FS_AES_256_XTS_KEY_SIZE);
+		goto got_key;
+	}
+	memcpy(full_key_descriptor, FS_KEY_DESC_PREFIX,
+					FS_KEY_DESC_PREFIX_SIZE);
+	sprintf(full_key_descriptor + FS_KEY_DESC_PREFIX_SIZE,
+					"%*phN", FS_KEY_DESCRIPTOR_SIZE,
+					ctx.master_key_descriptor);
+	full_key_descriptor[FS_KEY_DESC_PREFIX_SIZE +
+					(2 * FS_KEY_DESCRIPTOR_SIZE)] = '\0';
+	keyring_key = request_key(&key_type_logon, full_key_descriptor, NULL);
+	if (IS_ERR(keyring_key)) {
+		res = PTR_ERR(keyring_key);
+		keyring_key = NULL;
+		goto out;
+	}
+	crypt_info->ci_keyring_key = keyring_key;
+	if (keyring_key->type != &key_type_logon) {
+		printk_once(KERN_WARNING
+				"%s: key type must be logon\n", __func__);
+		res = -ENOKEY;
+		goto out;
+	}
+	down_read(&keyring_key->sem);
+	ukp = user_key_payload(keyring_key);
+	if (ukp->datalen != sizeof(struct fscrypt_key)) {
+		res = -EINVAL;
+		up_read(&keyring_key->sem);
+		goto out;
+	}
+	master_key = (struct fscrypt_key *)ukp->data;
+	BUILD_BUG_ON(FS_AES_128_ECB_KEY_SIZE != FS_KEY_DERIVATION_NONCE_SIZE);
+
+	if (master_key->size != FS_AES_256_XTS_KEY_SIZE) {
+		printk_once(KERN_WARNING
+				"%s: key size incorrect: %d\n",
+				__func__, master_key->size);
+		res = -ENOKEY;
+		up_read(&keyring_key->sem);
+		goto out;
+	}
+	res = derive_key_aes(ctx.nonce, master_key->raw, raw_key);
+	up_read(&keyring_key->sem);
+	if (res)
+		goto out;
+got_key:
+	ctfm = crypto_alloc_ablkcipher(cipher_str, 0, 0);
+	if (!ctfm || IS_ERR(ctfm)) {
+		res = ctfm ? PTR_ERR(ctfm) : -ENOMEM;
+		printk(KERN_DEBUG
+		       "%s: error %d (inode %u) allocating crypto tfm\n",
+		       __func__, res, (unsigned) inode->i_ino);
+		goto out;
+	}
+	crypt_info->ci_ctfm = ctfm;
+	crypto_ablkcipher_clear_flags(ctfm, ~0);
+	crypto_tfm_set_flags(crypto_ablkcipher_tfm(ctfm),
+					CRYPTO_TFM_REQ_WEAK_KEY);
+	res = crypto_ablkcipher_setkey(ctfm, raw_key, fscrypt_key_size(mode));
+	if (res)
+		goto out;
+
+	memzero_explicit(raw_key, sizeof(raw_key));
+	if (cmpxchg(&inode->i_crypt_info, NULL, crypt_info) != NULL) {
+		put_crypt_info(crypt_info);
+		goto retry;
+	}
+	return 0;
+
+out:
+	if (res == -ENOKEY)
+		res = 0;
+	put_crypt_info(crypt_info);
+	memzero_explicit(raw_key, sizeof(raw_key));
+	return res;
+}
+
+void fscrypt_put_encryption_info(struct inode *inode, struct fscrypt_info *ci)
+{
+	struct fscrypt_info *prev;
+
+	if (ci == NULL)
+		ci = ACCESS_ONCE(inode->i_crypt_info);
+	if (ci == NULL)
+		return;
+
+	prev = cmpxchg(&inode->i_crypt_info, ci, NULL);
+	if (prev != ci)
+		return;
+
+	put_crypt_info(ci);
+}
+EXPORT_SYMBOL(fscrypt_put_encryption_info);
+
+int fscrypt_get_encryption_info(struct inode *inode)
+{
+	struct fscrypt_info *ci = inode->i_crypt_info;
+
+	if (!ci ||
+		(ci->ci_keyring_key &&
+		 (ci->ci_keyring_key->flags & ((1 << KEY_FLAG_INVALIDATED) |
+					       (1 << KEY_FLAG_REVOKED) |
+					       (1 << KEY_FLAG_DEAD)))))
+		return get_crypt_info(inode);
+	return 0;
+}
+EXPORT_SYMBOL(fscrypt_get_encryption_info);
diff --git a/include/linux/fscrypto.h b/include/linux/fscrypto.h
index 880c81b..0720292 100644
--- a/include/linux/fscrypto.h
+++ b/include/linux/fscrypto.h
@@ -258,6 +258,10 @@ extern int fscrypt_get_policy(struct inode *, struct fscrypt_policy *);
 extern int fscrypt_has_permitted_context(struct inode *, struct inode *);
 extern int fscrypt_inherit_context(struct inode *, struct inode *,
 					void *, bool);
+/* keyinfo.c */
+extern int get_crypt_info(struct inode *);
+extern int fscrypt_get_encryption_info(struct inode *);
+extern void fscrypt_put_encryption_info(struct inode *, struct fscrypt_info *);
 #endif
 
 /* crypto.c */
@@ -328,4 +332,16 @@ static inline int fscrypt_notsupp_inherit_context(struct inode *p,
 {
 	return -EOPNOTSUPP;
 }
+
+/* keyinfo.c */
+static inline int fscrypt_notsupp_get_encryption_info(struct inode *i)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void fscrypt_notsupp_put_encryption_info(struct inode *i,
+					struct fscrypt_info *f)
+{
+	return;
+}
 #endif	/* _LINUX_FSCRYPTO_H */
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
