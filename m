From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 07/10] fs crypto: add dentry revalidation
	facility in crypto
Date: Wed,  2 Mar 2016 10:31:15 -0800
Message-ID: <1456943478-11107-8-git-send-email-jaegeuk@kernel.org>
References: <1456943478-11107-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1abBZC-0001xw-RY
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 02 Mar 2016 18:32:10 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1abBZB-0004Vk-Qb
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 02 Mar 2016 18:32:10 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Al Viro <viro@ftp.linux.org.uk>

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
index 928a34b..96b18a7 100644
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
index 144541b..895cdac 100644
--- a/include/linux/fscrypto.h
+++ b/include/linux/fscrypto.h
@@ -237,6 +237,26 @@ static inline int fscrypt_has_encryption_key(struct inode *inode)
 #endif
 }
 
+static inline void fscrypt_set_encrypted_dentry(struct dentry *dentry)
+{
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
+	spin_lock(&dentry->d_lock);
+	dentry->d_flags |= DCACHE_ENCRYPTED_WITH_KEY;
+	spin_unlock(&dentry->d_lock);
+#endif
+}
+
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
+extern const struct dentry_operations fscrypt_d_ops;
+#endif
+
+static inline void fscrypt_set_d_op(struct dentry *dentry)
+{
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
+	d_set_d_op(dentry, &fscrypt_d_ops);
+#endif
+}
+
 #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
 /* crypto.c */
 extern struct kmem_cache *fscrypt_info_cachep;
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
