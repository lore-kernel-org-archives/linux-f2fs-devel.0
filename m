From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 09/18] f2fs crypto: filename encryption facilities
Date: Fri,  8 May 2015 21:20:44 -0700
Message-ID: <1431145253-2019-9-git-send-email-jaegeuk@kernel.org>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YqwGc-0003w8-Ak
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:34 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqwGa-0003sN-KL for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:34 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Ildar Muslukhov <ildarm@google.com>, Michael Halcrow <mhalcrow@google.com>, Theodore Ts'o <tytso@mit.edu>, Uday Savagaonkar <savagaon@google.com>

This patch adds filename encryption infra.
Most of codes are copied from ext4 part, but changed to adjust f2fs
directory structure.

Signed-off-by: Uday Savagaonkar <savagaon@google.com>
Signed-off-by: Ildar Muslukhov <ildarm@google.com>
Signed-off-by: Michael Halcrow <mhalcrow@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/Makefile       |   3 +-
 fs/f2fs/crypto_fname.c | 490 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h         |  52 ++++++
 3 files changed, 544 insertions(+), 1 deletion(-)
 create mode 100644 fs/f2fs/crypto_fname.c

diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
index b08925d..396be1a 100644
--- a/fs/f2fs/Makefile
+++ b/fs/f2fs/Makefile
@@ -6,4 +6,5 @@ f2fs-$(CONFIG_F2FS_STAT_FS) += debug.o
 f2fs-$(CONFIG_F2FS_FS_XATTR) += xattr.o
 f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) += acl.o
 f2fs-$(CONFIG_F2FS_IO_TRACE) += trace.o
-f2fs-$(CONFIG_F2FS_FS_ENCRYPTION) += crypto_policy.o crypto.o crypto_key.o
+f2fs-$(CONFIG_F2FS_FS_ENCRYPTION) += crypto_policy.o crypto.o \
+		crypto_key.o crypto_fname.o
diff --git a/fs/f2fs/crypto_fname.c b/fs/f2fs/crypto_fname.c
new file mode 100644
index 0000000..8f3ff9b
--- /dev/null
+++ b/fs/f2fs/crypto_fname.c
@@ -0,0 +1,490 @@
+/*
+ * linux/fs/f2fs/crypto_fname.c
+ *
+ * Copied from linux/fs/ext4/crypto.c
+ *
+ * Copyright (C) 2015, Google, Inc.
+ * Copyright (C) 2015, Motorola Mobility
+ *
+ * This contains functions for filename crypto management in f2fs
+ *
+ * Written by Uday Savagaonkar, 2014.
+ *
+ * Adjust f2fs dentry structure
+ *	Jaegeuk Kim, 2015.
+ *
+ * This has not yet undergone a rigorous security audit.
+ */
+#include <crypto/hash.h>
+#include <crypto/sha.h>
+#include <keys/encrypted-type.h>
+#include <keys/user-type.h>
+#include <linux/crypto.h>
+#include <linux/gfp.h>
+#include <linux/kernel.h>
+#include <linux/key.h>
+#include <linux/list.h>
+#include <linux/mempool.h>
+#include <linux/random.h>
+#include <linux/scatterlist.h>
+#include <linux/spinlock_types.h>
+#include <linux/f2fs_fs.h>
+#include <linux/ratelimit.h>
+
+#include "f2fs.h"
+#include "f2fs_crypto.h"
+#include "xattr.h"
+
+/**
+ * f2fs_dir_crypt_complete() -
+ */
+static void f2fs_dir_crypt_complete(struct crypto_async_request *req, int res)
+{
+	struct f2fs_completion_result *ecr = req->data;
+
+	if (res == -EINPROGRESS)
+		return;
+	ecr->res = res;
+	complete(&ecr->completion);
+}
+
+bool f2fs_valid_filenames_enc_mode(uint32_t mode)
+{
+	return (mode == F2FS_ENCRYPTION_MODE_AES_256_CTS);
+}
+
+static unsigned max_name_len(struct inode *inode)
+{
+	return S_ISLNK(inode->i_mode) ? inode->i_sb->s_blocksize :
+					F2FS_NAME_LEN;
+}
+
+/**
+ * f2fs_fname_encrypt() -
+ *
+ * This function encrypts the input filename, and returns the length of the
+ * ciphertext. Errors are returned as negative numbers.  We trust the caller to
+ * allocate sufficient memory to oname string.
+ */
+static int f2fs_fname_encrypt(struct inode *inode,
+			const struct qstr *iname, struct f2fs_str *oname)
+{
+	u32 ciphertext_len;
+	struct ablkcipher_request *req = NULL;
+	DECLARE_F2FS_COMPLETION_RESULT(ecr);
+	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
+	struct crypto_ablkcipher *tfm = ci->ci_ctfm;
+	int res = 0;
+	char iv[F2FS_CRYPTO_BLOCK_SIZE];
+	struct scatterlist src_sg, dst_sg;
+	int padding = 4 << (ci->ci_flags & F2FS_POLICY_FLAGS_PAD_MASK);
+	char *workbuf, buf[32], *alloc_buf = NULL;
+	unsigned lim = max_name_len(inode);
+
+	if (iname->len <= 0 || iname->len > lim)
+		return -EIO;
+
+	ciphertext_len = (iname->len < F2FS_CRYPTO_BLOCK_SIZE) ?
+		F2FS_CRYPTO_BLOCK_SIZE : iname->len;
+	ciphertext_len = f2fs_fname_crypto_round_up(ciphertext_len, padding);
+	ciphertext_len = (ciphertext_len > lim) ? lim : ciphertext_len;
+
+	if (ciphertext_len <= sizeof(buf)) {
+		workbuf = buf;
+	} else {
+		alloc_buf = kmalloc(ciphertext_len, GFP_NOFS);
+		if (!alloc_buf)
+			return -ENOMEM;
+		workbuf = alloc_buf;
+	}
+
+	/* Allocate request */
+	req = ablkcipher_request_alloc(tfm, GFP_NOFS);
+	if (!req) {
+		printk_ratelimited(KERN_ERR
+			"%s: crypto_request_alloc() failed\n", __func__);
+		kfree(alloc_buf);
+		return -ENOMEM;
+	}
+	ablkcipher_request_set_callback(req,
+			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
+			f2fs_dir_crypt_complete, &ecr);
+
+	/* Copy the input */
+	memcpy(workbuf, iname->name, iname->len);
+	if (iname->len < ciphertext_len)
+		memset(workbuf + iname->len, 0, ciphertext_len - iname->len);
+
+	/* Initialize IV */
+	memset(iv, 0, F2FS_CRYPTO_BLOCK_SIZE);
+
+	/* Create encryption request */
+	sg_init_one(&src_sg, workbuf, ciphertext_len);
+	sg_init_one(&dst_sg, oname->name, ciphertext_len);
+	ablkcipher_request_set_crypt(req, &src_sg, &dst_sg, ciphertext_len, iv);
+	res = crypto_ablkcipher_encrypt(req);
+	if (res == -EINPROGRESS || res == -EBUSY) {
+		BUG_ON(req->base.data != &ecr);
+		wait_for_completion(&ecr.completion);
+		res = ecr.res;
+	}
+	kfree(alloc_buf);
+	ablkcipher_request_free(req);
+	if (res < 0) {
+		printk_ratelimited(KERN_ERR
+				"%s: Error (error code %d)\n", __func__, res);
+	}
+	oname->len = ciphertext_len;
+	return res;
+}
+
+/*
+ * f2fs_fname_decrypt()
+ *	This function decrypts the input filename, and returns
+ *	the length of the plaintext.
+ *	Errors are returned as negative numbers.
+ *	We trust the caller to allocate sufficient memory to oname string.
+ */
+static int f2fs_fname_decrypt(struct inode *inode,
+			const struct f2fs_str *iname, struct f2fs_str *oname)
+{
+	struct ablkcipher_request *req = NULL;
+	DECLARE_F2FS_COMPLETION_RESULT(ecr);
+	struct scatterlist src_sg, dst_sg;
+	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
+	struct crypto_ablkcipher *tfm = ci->ci_ctfm;
+	int res = 0;
+	char iv[F2FS_CRYPTO_BLOCK_SIZE];
+	unsigned lim = max_name_len(inode);
+
+	if (iname->len <= 0 || iname->len > lim)
+		return -EIO;
+
+	/* Allocate request */
+	req = ablkcipher_request_alloc(tfm, GFP_NOFS);
+	if (!req) {
+		printk_ratelimited(KERN_ERR
+			"%s: crypto_request_alloc() failed\n",  __func__);
+		return -ENOMEM;
+	}
+	ablkcipher_request_set_callback(req,
+		CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
+		f2fs_dir_crypt_complete, &ecr);
+
+	/* Initialize IV */
+	memset(iv, 0, F2FS_CRYPTO_BLOCK_SIZE);
+
+	/* Create decryption request */
+	sg_init_one(&src_sg, iname->name, iname->len);
+	sg_init_one(&dst_sg, oname->name, oname->len);
+	ablkcipher_request_set_crypt(req, &src_sg, &dst_sg, iname->len, iv);
+	res = crypto_ablkcipher_decrypt(req);
+	if (res == -EINPROGRESS || res == -EBUSY) {
+		BUG_ON(req->base.data != &ecr);
+		wait_for_completion(&ecr.completion);
+		res = ecr.res;
+	}
+	ablkcipher_request_free(req);
+	if (res < 0) {
+		printk_ratelimited(KERN_ERR
+			"%s: Error in f2fs_fname_decrypt (error code %d)\n",
+			__func__, res);
+		return res;
+	}
+
+	oname->len = strnlen(oname->name, iname->len);
+	return oname->len;
+}
+
+static const char *lookup_table =
+	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
+
+/**
+ * f2fs_fname_encode_digest() -
+ *
+ * Encodes the input digest using characters from the set [a-zA-Z0-9_+].
+ * The encoded string is roughly 4/3 times the size of the input string.
+ */
+static int digest_encode(const char *src, int len, char *dst)
+{
+	int i = 0, bits = 0, ac = 0;
+	char *cp = dst;
+
+	while (i < len) {
+		ac += (((unsigned char) src[i]) << bits);
+		bits += 8;
+		do {
+			*cp++ = lookup_table[ac & 0x3f];
+			ac >>= 6;
+			bits -= 6;
+		} while (bits >= 6);
+		i++;
+	}
+	if (bits)
+		*cp++ = lookup_table[ac & 0x3f];
+	return cp - dst;
+}
+
+static int digest_decode(const char *src, int len, char *dst)
+{
+	int i = 0, bits = 0, ac = 0;
+	const char *p;
+	char *cp = dst;
+
+	while (i < len) {
+		p = strchr(lookup_table, src[i]);
+		if (p == NULL || src[i] == 0)
+			return -2;
+		ac += (p - lookup_table) << bits;
+		bits += 6;
+		if (bits >= 8) {
+			*cp++ = ac & 0xff;
+			ac >>= 8;
+			bits -= 8;
+		}
+		i++;
+	}
+	if (ac)
+		return -1;
+	return cp - dst;
+}
+
+int f2fs_setup_fname_crypto(struct inode *inode)
+{
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct f2fs_crypt_info *ci = fi->i_crypt_info;
+	struct crypto_ablkcipher *ctfm;
+	int res;
+
+	/* Check if the crypto policy is set on the inode */
+	res = f2fs_encrypted_inode(inode);
+	if (res == 0)
+		return 0;
+
+	res = f2fs_get_encryption_info(inode);
+	if (res < 0)
+		return res;
+	ci = fi->i_crypt_info;
+
+	if (!ci || ci->ci_ctfm)
+		return 0;
+
+	if (ci->ci_mode != F2FS_ENCRYPTION_MODE_AES_256_CTS) {
+		printk_once(KERN_WARNING "f2fs: unsupported key mode %d\n",
+				ci->ci_mode);
+		return -ENOKEY;
+	}
+
+	ctfm = crypto_alloc_ablkcipher("cts(cbc(aes))", 0, 0);
+	if (!ctfm || IS_ERR(ctfm)) {
+		res = ctfm ? PTR_ERR(ctfm) : -ENOMEM;
+		printk(KERN_DEBUG "%s: error (%d) allocating crypto tfm\n",
+				__func__, res);
+		return res;
+	}
+	crypto_ablkcipher_clear_flags(ctfm, ~0);
+	crypto_tfm_set_flags(crypto_ablkcipher_tfm(ctfm),
+			     CRYPTO_TFM_REQ_WEAK_KEY);
+
+	res = crypto_ablkcipher_setkey(ctfm, ci->ci_raw, ci->ci_size);
+	if (res) {
+		crypto_free_ablkcipher(ctfm);
+		return -EIO;
+	}
+	ci->ci_ctfm = ctfm;
+	return 0;
+}
+
+/**
+ * f2fs_fname_crypto_round_up() -
+ *
+ * Return: The next multiple of block size
+ */
+u32 f2fs_fname_crypto_round_up(u32 size, u32 blksize)
+{
+	return ((size + blksize - 1) / blksize) * blksize;
+}
+
+/**
+ * f2fs_fname_crypto_alloc_obuff() -
+ *
+ * Allocates an output buffer that is sufficient for the crypto operation
+ * specified by the context and the direction.
+ */
+int f2fs_fname_crypto_alloc_buffer(struct inode *inode,
+				   u32 ilen, struct f2fs_str *crypto_str)
+{
+	unsigned int olen;
+	int padding = 16;
+	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
+
+	if (ci)
+		padding = 4 << (ci->ci_flags & F2FS_POLICY_FLAGS_PAD_MASK);
+	if (padding < F2FS_CRYPTO_BLOCK_SIZE)
+		padding = F2FS_CRYPTO_BLOCK_SIZE;
+	olen = f2fs_fname_crypto_round_up(ilen, padding);
+	crypto_str->len = olen;
+	if (olen < F2FS_FNAME_CRYPTO_DIGEST_SIZE * 2)
+		olen = F2FS_FNAME_CRYPTO_DIGEST_SIZE * 2;
+	/* Allocated buffer can hold one more character to null-terminate the
+	 * string */
+	crypto_str->name = kmalloc(olen + 1, GFP_NOFS);
+	if (!(crypto_str->name))
+		return -ENOMEM;
+	return 0;
+}
+
+/**
+ * f2fs_fname_crypto_free_buffer() -
+ *
+ * Frees the buffer allocated for crypto operation.
+ */
+void f2fs_fname_crypto_free_buffer(struct f2fs_str *crypto_str)
+{
+	if (!crypto_str)
+		return;
+	kfree(crypto_str->name);
+	crypto_str->name = NULL;
+}
+
+/**
+ * f2fs_fname_disk_to_usr() - converts a filename from disk space to user space
+ */
+int f2fs_fname_disk_to_usr(struct inode *inode,
+			f2fs_hash_t *hash,
+			const struct f2fs_str *iname,
+			struct f2fs_str *oname)
+{
+	const struct qstr qname = FSTR_TO_QSTR(iname);
+	char buf[24];
+	int ret;
+
+	if (is_dot_dotdot(&qname)) {
+		oname->name[0] = '.';
+		oname->name[iname->len - 1] = '.';
+		oname->len = iname->len;
+		return oname->len;
+	}
+
+	if (F2FS_I(inode)->i_crypt_info)
+		return f2fs_fname_decrypt(inode, iname, oname);
+
+	if (iname->len <= F2FS_FNAME_CRYPTO_DIGEST_SIZE) {
+		ret = digest_encode(iname->name, iname->len, oname->name);
+		oname->len = ret;
+		return ret;
+	}
+	if (hash) {
+		memcpy(buf, hash, 4);
+		memset(buf + 4, 0, 4);
+	} else
+		memset(buf, 0, 8);
+	memcpy(buf + 8, iname->name + iname->len - 16, 16);
+	oname->name[0] = '_';
+	ret = digest_encode(buf, 24, oname->name + 1);
+	oname->len = ret + 1;
+	return ret + 1;
+}
+
+/**
+ * f2fs_fname_usr_to_disk() - converts a filename from user space to disk space
+ */
+int f2fs_fname_usr_to_disk(struct inode *inode,
+			const struct qstr *iname,
+			struct f2fs_str *oname)
+{
+	int res;
+	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
+
+	if (is_dot_dotdot(iname)) {
+		oname->name[0] = '.';
+		oname->name[iname->len - 1] = '.';
+		oname->len = iname->len;
+		return oname->len;
+	}
+
+	if (ci) {
+		res = f2fs_fname_encrypt(inode, iname, oname);
+		return res;
+	}
+	/* Without a proper key, a user is not allowed to modify the filenames
+	 * in a directory. Consequently, a user space name cannot be mapped to
+	 * a disk-space name */
+	return -EACCES;
+}
+
+int f2fs_fname_setup_filename(struct inode *dir, const struct qstr *iname,
+			      int lookup, struct f2fs_filename *fname)
+{
+	struct f2fs_crypt_info *ci;
+	int ret = 0, bigname = 0;
+
+	memset(fname, 0, sizeof(struct f2fs_filename));
+	fname->usr_fname = iname;
+
+	if (!f2fs_encrypted_inode(dir) || is_dot_dotdot(iname)) {
+		fname->disk_name.name = (unsigned char *)iname->name;
+		fname->disk_name.len = iname->len;
+		goto out;
+	}
+	ret = f2fs_setup_fname_crypto(dir);
+	if (ret)
+		return ret;
+	ci = F2FS_I(dir)->i_crypt_info;
+	if (ci) {
+		ret = f2fs_fname_crypto_alloc_buffer(dir, iname->len,
+						     &fname->crypto_buf);
+		if (ret < 0)
+			goto out;
+		ret = f2fs_fname_encrypt(dir, iname, &fname->crypto_buf);
+		if (ret < 0)
+			goto out;
+		fname->disk_name.name = fname->crypto_buf.name;
+		fname->disk_name.len = fname->crypto_buf.len;
+		ret = 0;
+		goto out;
+	}
+	if (!lookup) {
+		ret = -EACCES;
+		goto out;
+	}
+
+	/* We don't have the key and we are doing a lookup; decode the
+	 * user-supplied name
+	 */
+	if (iname->name[0] == '_')
+		bigname = 1;
+	if ((bigname && (iname->len != 33)) ||
+	    (!bigname && (iname->len > 43))) {
+		ret = -ENOENT;
+	}
+	fname->crypto_buf.name = kmalloc(32, GFP_KERNEL);
+	if (fname->crypto_buf.name == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	ret = digest_decode(iname->name + bigname, iname->len - bigname,
+				fname->crypto_buf.name);
+	if (ret < 0) {
+		ret = -ENOENT;
+		goto out;
+	}
+	fname->crypto_buf.len = ret;
+	if (bigname) {
+		memcpy(&fname->hash, fname->crypto_buf.name, 4);
+	} else {
+		fname->disk_name.name = fname->crypto_buf.name;
+		fname->disk_name.len = fname->crypto_buf.len;
+	}
+	ret = 0;
+out:
+	return ret;
+}
+
+void f2fs_fname_free_filename(struct f2fs_filename *fname)
+{
+	kfree(fname->crypto_buf.name);
+	fname->crypto_buf.name = NULL;
+	fname->usr_fname = NULL;
+	fname->disk_name.name = NULL;
+}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ef79ac8..e99205b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -257,6 +257,25 @@ static inline bool __has_cursum_space(struct f2fs_summary_block *sum, int size,
  * For INODE and NODE manager
  */
 /* for directory operations */
+struct f2fs_str {
+	unsigned char *name;
+	u32 len;
+};
+
+struct f2fs_filename {
+	const struct qstr *usr_fname;
+	struct f2fs_str disk_name;
+	f2fs_hash_t hash;
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
+	struct f2fs_str crypto_buf;
+#endif
+};
+
+#define FSTR_INIT(n, l)		{ .name = n, .len = l }
+#define FSTR_TO_QSTR(f)		FSTR_INIT((f)->name, (f)->len)
+#define fname_name(p)		((p)->disk_name.name)
+#define fname_len(p)		((p)->disk_name.len)
+
 struct f2fs_dentry_ptr {
 	const void *bitmap;
 	struct f2fs_dir_entry *dentry;
@@ -1977,6 +1996,17 @@ void f2fs_end_io_crypto_work(struct f2fs_crypto_ctx *, struct bio *);
 void f2fs_free_encryption_info(struct inode *);
 int _f2fs_get_encryption_info(struct inode *inode);
 
+/* crypto_fname.c */
+bool f2fs_valid_filenames_enc_mode(uint32_t);
+u32 f2fs_fname_crypto_round_up(u32, u32);
+int f2fs_fname_crypto_alloc_buffer(struct inode *, u32, struct f2fs_str *);
+int f2fs_fname_disk_to_usr(struct inode *, f2fs_hash_t *,
+			const struct f2fs_str *, struct f2fs_str *);
+int f2fs_fname_disk_to_usr(struct inode *, f2fs_hash_t *,
+			const struct f2fs_str *, struct f2fs_str *);
+int f2fs_fname_usr_to_disk(struct inode *, const struct qstr *,
+			struct f2fs_str *);
+
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 void f2fs_restore_and_release_control_page(struct page **);
 void f2fs_restore_control_page(struct page *);
@@ -1998,6 +2028,12 @@ static inline int f2fs_get_encryption_info(struct inode *inode)
 		return _f2fs_get_encryption_info(inode);
 	return 0;
 }
+
+int f2fs_setup_fname_crypto(struct inode *);
+void f2fs_fname_crypto_free_buffer(struct f2fs_str *);
+int f2fs_fname_setup_filename(struct inode *, const struct qstr *,
+				int lookup, struct f2fs_filename *);
+void f2fs_fname_free_filename(struct f2fs_filename *);
 #else
 static inline void f2fs_restore_and_release_control_page(struct page **p) { }
 static inline void f2fs_restore_control_page(struct page *p) { }
@@ -2007,5 +2043,21 @@ static inline void f2fs_exit_crypto(void) { }
 
 static inline int f2fs_has_encryption_key(struct inode *i) { return 0; }
 static inline int f2fs_get_encryption_info(struct inode *i) { return 0; }
+
+static inline int f2fs_setup_fname_crypto(struct inode *i) { return 0; }
+static inline void f2fs_fname_crypto_free_buffer(struct f2fs_str *p) { }
+
+static inline int f2fs_fname_setup_filename(struct inode *dir,
+					const struct qstr *iname,
+					int lookup, struct f2fs_filename *fname)
+{
+	memset(fname, 0, sizeof(struct f2fs_filename));
+	fname->usr_fname = iname;
+	fname->disk_name.name = (unsigned char *)iname->name;
+	fname->disk_name.len = iname->len;
+	return 0;
+}
+
+static inline void f2fs_fname_free_filename(struct f2fs_filename *fname) { }
 #endif
 #endif
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
