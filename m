From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 07/10] fs crypto: add dentry revalidation facility in crypto
Date: Thu, 25 Feb 2016 11:26:05 -0800
Message-ID: <1456428368-41527-8-git-send-email-jaegeuk@kernel.org>
References: <1456428368-41527-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456428368-41527-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, tytso@mit.edu
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Al Viro <viro@ftp.linux.org.uk>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch is to support the following ext4 crypto change.

commit 28b4c263961c47da84ed8b5be0b5116bad1133eb
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Sun Feb 7 19:35:05 2016 -0500

    ext4 crypto: revalidate dentry after adding or removing the key

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Al Viro <viro@ftp.linux.org.uk>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/crypto/crypto.c       | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dcache.h   |  2 ++
 include/linux/fscrypto.h | 20 ++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 2aa6eee..ed17895 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -27,6 +27,7 @@
 #include <linux/scatterlist.h>
 #include <linux/ratelimit.h>
 #include <linux/bio.h>
+#include <linux/dcache.h>
 #include <linux/fscrypto.h>
 
 static unsigned int num_prealloc_crypto_pages = 32;
@@ -339,6 +340,54 @@ errout:
 EXPORT_SYMBOL(fscrypt_zeroout_range);
 
 /*
+ * Validate dentries for encrypted directories to make sure we aren't
+ * potentially caching stale data after a key has been added or
+ * removed.
+ */
+static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	struct inode *dir = d_inode(dentry->d_parent);
+	struct fscrypt_info *ci = dir->i_crypt_info;
+	int dir_has_key, cached_with_key;
+
+	if (!dir->i_sb->s_cop->is_encrypted(dir))
+		return 0;
+
+	if (ci && ci->ci_keyring_key &&
+	    (ci->ci_keyring_key->flags & ((1 << KEY_FLAG_INVALIDATED) |
+					  (1 << KEY_FLAG_REVOKED) |
+					  (1 << KEY_FLAG_DEAD))))
+		ci = NULL;
+
+	/* this should eventually be an flag in d_flags */
+	spin_lock(&dentry->d_lock);
+	cached_with_key = dentry->d_flags & DCACHE_ENCRYPTED_WITH_KEY;
+	spin_unlock(&dentry->d_lock);
+	dir_has_key = (ci != NULL);
+
+	/*
+	 * If the dentry was cached without the key, and it is a
+	 * negative dentry, it might be a valid name.  We can't check
+	 * if the key has since been made available due to locking
+	 * reasons, so we fail the validation so ext4_lookup() can do
+	 * this check.
+	 *
+	 * We also fail the validation if the dentry was created with
+	 * the key present, but we no longer have the key, or vice versa.
+	 */
+	if ((!cached_with_key && d_is_negative(dentry)) ||
+			(!cached_with_key && dir_has_key) ||
+			(cached_with_key && !dir_has_key))
+		return 0;
+	return 1;
+}
+
+const struct dentry_operations fscrypt_d_ops = {
+	.d_revalidate = fscrypt_d_revalidate,
+};
+EXPORT_SYMBOL(fscrypt_d_ops);
+
+/*
  * Call fscrypt_decrypt_page on every single page, reusing the encryption
  * context.
  */
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 7781ce11..c7bdfc5 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -228,6 +228,8 @@ struct dentry_operations {
 #define DCACHE_FALLTHRU			0x01000000 /* Fall through to lower layer */
 #define DCACHE_OP_SELECT_INODE		0x02000000 /* Unioned entry: dcache op selects inode */
 
+#define DCACHE_ENCRYPTED_WITH_KEY	0x04000000 /* dir is encrypted with a valid key */
+
 extern seqlock_t rename_lock;
 
 /*
diff --git a/include/linux/fscrypto.h b/include/linux/fscrypto.h
index 3387da3..3a1fbb6 100644
--- a/include/linux/fscrypto.h
+++ b/include/linux/fscrypto.h
@@ -237,6 +237,26 @@ static inline int fscrypt_has_encryption_key(struct inode *inode)
 #endif
 }
 
+static inline void fscrypt_set_encrypted_dentry(struct dentry *dentry)
+{
+#ifdef CONFIG_FS_ENCRYPTION
+	spin_lock(&dentry->d_lock);
+	dentry->d_flags |= DCACHE_ENCRYPTED_WITH_KEY;
+	spin_unlock(&dentry->d_lock);
+#endif
+}
+
+#ifdef CONFIG_FS_ENCRYPTION
+extern const struct dentry_operations fscrypt_d_ops;
+#endif
+
+static inline void fscrypt_set_d_op(struct dentry *dentry)
+{
+#ifdef CONFIG_FS_ENCRYPTION
+	d_set_d_op(dentry, &fscrypt_d_ops);
+#endif
+}
+
 /* crypto.c */
 extern struct kmem_cache *fscrypt_info_cachep;
 int fscrypt_initialize(void);
-- 
2.6.3
