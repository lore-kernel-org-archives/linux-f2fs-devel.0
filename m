From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 03/18] f2fs crypto: declare some definitions for
	f2fs encryption feature
Date: Fri,  8 May 2015 21:20:38 -0700
Message-ID: <1431145253-2019-3-git-send-email-jaegeuk@kernel.org>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YqwGI-0003ti-6F
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:14 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqwGG-0003s0-Si for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:14 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This definitions will be used by inode and superblock for encyption.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h          |  54 ++++++++++++++++++
 fs/f2fs/f2fs_crypto.h   | 149 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/f2fs_fs.h |   4 +-
 3 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 fs/f2fs/f2fs_crypto.h

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 477e65f..c3c4deb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -70,6 +70,8 @@ struct f2fs_mount_info {
 	unsigned int	opt;
 };
 
+#define F2FS_FEATURE_ENCRYPT	0x0001
+
 #define F2FS_HAS_FEATURE(sb, mask)					\
 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
 #define F2FS_SET_FEATURE(sb, mask)					\
@@ -346,6 +348,7 @@ struct f2fs_map_blocks {
  */
 #define FADVISE_COLD_BIT	0x01
 #define FADVISE_LOST_PINO_BIT	0x02
+#define FADVISE_ENCRYPT_BIT	0x04
 
 #define file_is_cold(inode)	is_file(inode, FADVISE_COLD_BIT)
 #define file_wrong_pino(inode)	is_file(inode, FADVISE_LOST_PINO_BIT)
@@ -353,6 +356,16 @@ struct f2fs_map_blocks {
 #define file_lost_pino(inode)	set_file(inode, FADVISE_LOST_PINO_BIT)
 #define file_clear_cold(inode)	clear_file(inode, FADVISE_COLD_BIT)
 #define file_got_pino(inode)	clear_file(inode, FADVISE_LOST_PINO_BIT)
+#define file_is_encrypt(inode)	is_file(inode, FADVISE_ENCRYPT_BIT)
+#define file_set_encrypt(inode)	set_file(inode, FADVISE_ENCRYPT_BIT)
+#define file_clear_encrypt(inode) clear_file(inode, FADVISE_ENCRYPT_BIT)
+
+/* Encryption algorithms */
+#define F2FS_ENCRYPTION_MODE_INVALID		0
+#define F2FS_ENCRYPTION_MODE_AES_256_XTS	1
+#define F2FS_ENCRYPTION_MODE_AES_256_GCM	2
+#define F2FS_ENCRYPTION_MODE_AES_256_CBC	3
+#define F2FS_ENCRYPTION_MODE_AES_256_CTS	4
 
 #define DEF_DIR_LEVEL		0
 
@@ -380,6 +393,11 @@ struct f2fs_inode_info {
 	struct radix_tree_root inmem_root;	/* radix tree for inmem pages */
 	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
 	struct mutex inmem_lock;	/* lock for inmemory pages */
+
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
+	/* Encryption params */
+	struct f2fs_crypt_info *i_crypt_info;
+#endif
 };
 
 static inline void get_extent_info(struct extent_info *ext,
@@ -1891,4 +1909,40 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *, struct page *,
 						struct inode *, struct inode *);
 bool f2fs_empty_inline_dir(struct inode *);
 int f2fs_read_inline_dir(struct file *, struct dir_context *);
+
+/*
+ * crypto support
+ */
+static inline int f2fs_encrypted_inode(struct inode *inode)
+{
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
+	return file_is_encrypt(inode);
+#else
+	return 0;
+#endif
+}
+
+static inline void f2fs_set_encrypted_inode(struct inode *inode)
+{
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
+	file_set_encrypt(inode);
+#endif
+}
+
+static inline bool f2fs_bio_encrypted(struct bio *bio)
+{
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
+	return unlikely(bio->bi_private != NULL);
+#else
+	return false;
+#endif
+}
+
+static inline int f2fs_sb_has_crypto(struct super_block *sb)
+{
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
+	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_ENCRYPT);
+#else
+	return 0;
+#endif
 #endif
diff --git a/fs/f2fs/f2fs_crypto.h b/fs/f2fs/f2fs_crypto.h
new file mode 100644
index 0000000..cfc37c1
--- /dev/null
+++ b/fs/f2fs/f2fs_crypto.h
@@ -0,0 +1,149 @@
+/*
+ * linux/fs/f2fs/f2fs_crypto.h
+ *
+ * Copied from linux/fs/ext4/ext4_crypto.h
+ *
+ * Copyright (C) 2015, Google, Inc.
+ *
+ * This contains encryption header content for f2fs
+ *
+ * Written by Michael Halcrow, 2015.
+ * Modified by Jaegeuk Kim, 2015.
+ */
+#ifndef _F2FS_CRYPTO_H
+#define _F2FS_CRYPTO_H
+
+#include <linux/fs.h>
+
+#define F2FS_KEY_DESCRIPTOR_SIZE	8
+
+/* Policy provided via an ioctl on the topmost directory */
+struct f2fs_encryption_policy {
+	char version;
+	char contents_encryption_mode;
+	char filenames_encryption_mode;
+	char flags;
+	char master_key_descriptor[F2FS_KEY_DESCRIPTOR_SIZE];
+} __attribute__((__packed__));
+
+#define F2FS_ENCRYPTION_CONTEXT_FORMAT_V1	1
+#define F2FS_KEY_DERIVATION_NONCE_SIZE		16
+
+#define F2FS_POLICY_FLAGS_PAD_4		0x00
+#define F2FS_POLICY_FLAGS_PAD_8		0x01
+#define F2FS_POLICY_FLAGS_PAD_16	0x02
+#define F2FS_POLICY_FLAGS_PAD_32	0x03
+#define F2FS_POLICY_FLAGS_PAD_MASK	0x03
+#define F2FS_POLICY_FLAGS_VALID		0x03
+
+/**
+ * Encryption context for inode
+ *
+ * Protector format:
+ *  1 byte: Protector format (1 = this version)
+ *  1 byte: File contents encryption mode
+ *  1 byte: File names encryption mode
+ *  1 byte: Flags
+ *  8 bytes: Master Key descriptor
+ *  16 bytes: Encryption Key derivation nonce
+ */
+struct f2fs_encryption_context {
+	char format;
+	char contents_encryption_mode;
+	char filenames_encryption_mode;
+	char flags;
+	char master_key_descriptor[F2FS_KEY_DESCRIPTOR_SIZE];
+	char nonce[F2FS_KEY_DERIVATION_NONCE_SIZE];
+} __attribute__((__packed__));
+
+/* Encryption parameters */
+#define F2FS_XTS_TWEAK_SIZE 16
+#define F2FS_AES_128_ECB_KEY_SIZE 16
+#define F2FS_AES_256_GCM_KEY_SIZE 32
+#define F2FS_AES_256_CBC_KEY_SIZE 32
+#define F2FS_AES_256_CTS_KEY_SIZE 32
+#define F2FS_AES_256_XTS_KEY_SIZE 64
+#define F2FS_MAX_KEY_SIZE 64
+
+struct f2fs_encryption_key {
+	__u32 mode;
+	char raw[F2FS_MAX_KEY_SIZE];
+	__u32 size;
+} __attribute__((__packed__));
+
+struct f2fs_crypt_info {
+	unsigned char	ci_mode;
+	unsigned char	ci_size;
+	char		ci_data_mode;
+	char		ci_filename_mode;
+	char		ci_flags;
+	struct crypto_ablkcipher *ci_ctfm;
+	struct key	*ci_keyring_key;
+	char		ci_raw[F2FS_MAX_KEY_SIZE];
+	char		ci_master_key[F2FS_KEY_DESCRIPTOR_SIZE];
+};
+
+#define F2FS_CTX_REQUIRES_FREE_ENCRYPT_FL             0x00000001
+#define F2FS_BOUNCE_PAGE_REQUIRES_FREE_ENCRYPT_FL     0x00000002
+
+struct f2fs_crypto_ctx {
+	struct crypto_tfm *tfm;         /* Crypto API context */
+	struct page *bounce_page;       /* Ciphertext page on write path */
+	struct page *control_page;      /* Original page on write path */
+	struct bio *bio;                /* The bio for this context */
+	struct work_struct work;        /* Work queue for read complete path */
+	struct list_head free_list;     /* Free list */
+	int flags;                      /* Flags */
+	int mode;                       /* Encryption mode for tfm */
+};
+
+struct f2fs_completion_result {
+	struct completion completion;
+	int res;
+};
+
+#define DECLARE_F2FS_COMPLETION_RESULT(ecr) \
+	struct f2fs_completion_result ecr = { \
+		COMPLETION_INITIALIZER((ecr).completion), 0 }
+
+static inline int f2fs_encryption_key_size(int mode)
+{
+	switch (mode) {
+	case F2FS_ENCRYPTION_MODE_AES_256_XTS:
+		return F2FS_AES_256_XTS_KEY_SIZE;
+	case F2FS_ENCRYPTION_MODE_AES_256_GCM:
+		return F2FS_AES_256_GCM_KEY_SIZE;
+	case F2FS_ENCRYPTION_MODE_AES_256_CBC:
+		return F2FS_AES_256_CBC_KEY_SIZE;
+	case F2FS_ENCRYPTION_MODE_AES_256_CTS:
+		return F2FS_AES_256_CTS_KEY_SIZE;
+	default:
+		BUG();
+	}
+	return 0;
+}
+
+#define F2FS_FNAME_NUM_SCATTER_ENTRIES	4
+#define F2FS_CRYPTO_BLOCK_SIZE		16
+#define F2FS_FNAME_CRYPTO_DIGEST_SIZE	32
+
+/**
+ * For encrypted symlinks, the ciphertext length is stored at the beginning
+ * of the string in little-endian format.
+ */
+struct f2fs_encrypted_symlink_data {
+	__le16 len;
+	char encrypted_path[1];
+} __attribute__((__packed__));
+
+/**
+ * This function is used to calculate the disk space required to
+ * store a filename of length l in encrypted symlink format.
+ */
+static inline u32 encrypted_symlink_data_len(u32 l)
+{
+	if (l < F2FS_CRYPTO_BLOCK_SIZE)
+		l = F2FS_CRYPTO_BLOCK_SIZE;
+	return (l + sizeof(struct f2fs_encrypted_symlink_data) - 1);
+}
+#endif	/* _F2FS_CRYPTO_H */
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index d44e97f..920408a 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -91,7 +91,9 @@ struct f2fs_super_block {
 	__u8 version[VERSION_LEN];	/* the kernel version */
 	__u8 init_version[VERSION_LEN];	/* the initial kernel version */
 	__le32 feature;			/* defined features */
-	__u8 reserved[888];		/* valid reserved region */
+	__u8 encryption_level;		/* versioning level for encryption */
+	__u8 encrypt_pw_salt[16];	/* Salt used for string2key algorithm */
+	__u8 reserved[871];		/* valid reserved region */
 } __packed;
 
 /*
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
