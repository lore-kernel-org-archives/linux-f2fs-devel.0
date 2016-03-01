From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 01/10] fs crypto: add basic definitions for per-file
 encryption
Date: Mon, 29 Feb 2016 17:35:36 -0800
Message-ID: <20160301013536.GA60850@jaegeuk.hsd1.ca.comcast.net>
References: <1456428368-41527-1-git-send-email-jaegeuk@kernel.org>
 <1456428368-41527-2-git-send-email-jaegeuk@kernel.org>
 <56D3DA02.4010705@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56D3DA02.4010705@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, tytso@mit.edu
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sun, Feb 28, 2016 at 09:41:22PM -0800, Randy Dunlap wrote:
> On 02/25/16 11:25, Jaegeuk Kim wrote:
> > This patch adds definitions for per-file encryption used by ext4 and f2fs.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  include/linux/fs.h       |   8 ++
> >  include/linux/fscrypto.h | 239 +++++++++++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/fs.h  |  18 ++++
> >  3 files changed, 265 insertions(+)
> >  create mode 100644 include/linux/fscrypto.h
> > 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index ae68100..d8f57cf 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -53,6 +53,8 @@ struct swap_info_struct;
> >  struct seq_file;
> >  struct workqueue_struct;
> >  struct iov_iter;
> > +struct fscrypt_info;
> > +struct fscrypt_operations;
> >  
> >  extern void __init inode_init(void);
> >  extern void __init inode_init_early(void);
> > @@ -678,6 +680,10 @@ struct inode {
> >  	struct hlist_head	i_fsnotify_marks;
> >  #endif
> >  
> > +#ifdef CONFIG_FS_ENCRYPTION
> > +	struct fscrypt_info	*i_crypt_info;
> > +#endif
> > +
> >  	void			*i_private; /* fs or device private pointer */
> >  };
> >  
> > @@ -1323,6 +1329,8 @@ struct super_block {
> >  #endif
> >  	const struct xattr_handler **s_xattr;
> >  
> > +	const struct fscrypt_operations	*s_cop;
> > +
> >  	struct hlist_bl_head	s_anon;		/* anonymous dentries for (nfs) exporting */
> >  	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
> >  	struct block_device	*s_bdev;
> > diff --git a/include/linux/fscrypto.h b/include/linux/fscrypto.h
> > new file mode 100644
> > index 0000000..b0aed92
> > --- /dev/null
> > +++ b/include/linux/fscrypto.h
> > @@ -0,0 +1,239 @@
> > +/*
> > + * General per-file encryption definition
> > + *
> > + * Copyright (C) 2015, Google, Inc.
> > + *
> > + * Written by Michael Halcrow, 2015.
> > + * Modified by Jaegeuk Kim, 2015.
> > + */
> > +
> > +#ifndef _LINUX_FSCRYPTO_H
> > +#define _LINUX_FSCRYPTO_H
> > +
> > +#include <linux/key.h>
> > +#include <linux/fs.h>
> > +#include <linux/mm.h>
> > +#include <linux/bio.h>
> > +#include <linux/dcache.h>
> > +#include <uapi/linux/fs.h>
> > +
> > +#define FS_KEY_DERIVATION_NONCE_SIZE		16
> > +#define FS_ENCRYPTION_CONTEXT_FORMAT_V1		1
> > +
> > +#define FS_POLICY_FLAGS_PAD_4		0x00
> > +#define FS_POLICY_FLAGS_PAD_8		0x01
> > +#define FS_POLICY_FLAGS_PAD_16		0x02
> > +#define FS_POLICY_FLAGS_PAD_32		0x03
> > +#define FS_POLICY_FLAGS_PAD_MASK	0x03
> > +#define FS_POLICY_FLAGS_VALID		0x03
> > +
> > +/* Encryption algorithms */
> > +#define FS_ENCRYPTION_MODE_INVALID		0
> > +#define FS_ENCRYPTION_MODE_AES_256_XTS		1
> > +#define FS_ENCRYPTION_MODE_AES_256_GCM		2
> > +#define FS_ENCRYPTION_MODE_AES_256_CBC		3
> > +#define FS_ENCRYPTION_MODE_AES_256_CTS		4
> > +
> > +/**
> > + * Encryption context for inode
> > + *
> > + * Protector format:
> > + *  1 byte: Protector format (1 = this version)
> > + *  1 byte: File contents encryption mode
> > + *  1 byte: File names encryption mode
> > + *  1 byte: Flags
> > + *  8 bytes: Master Key descriptor
> > + *  16 bytes: Encryption Key derivation nonce
> > + */
> > +struct fscrypt_context {
> > +	char format;
> > +	char contents_encryption_mode;
> > +	char filenames_encryption_mode;
> > +	char flags;
> > +	char master_key_descriptor[FS_KEY_DESCRIPTOR_SIZE];
> > +	char nonce[FS_KEY_DERIVATION_NONCE_SIZE];
> 
> how about u8 instead of char?

It seems that it needs to user u8 instead of char for other variables as well.
I'll take a look at all the usages.

Thanks,

> 
> > +} __packed;
> > +
> > +/* Encryption parameters */
> > +#define FS_XTS_TWEAK_SIZE		16
> > +#define FS_AES_128_ECB_KEY_SIZE		16
> > +#define FS_AES_256_GCM_KEY_SIZE		32
> > +#define FS_AES_256_CBC_KEY_SIZE		32
> > +#define FS_AES_256_CTS_KEY_SIZE		32
> > +#define FS_AES_256_XTS_KEY_SIZE		64
> > +#define FS_MAX_KEY_SIZE			64
> > +
> > +#define FS_KEY_DESC_PREFIX		"fscrypt:"
> > +#define FS_KEY_DESC_PREFIX_SIZE		8
> > +
> > +/* This is passed in from userspace into the kernel keyring */
> > +struct fscrypt_key {
> > +	__u32 mode;
> > +	char raw[FS_MAX_KEY_SIZE];
> > +	__u32 size;
> > +} __packed;
> > +
> > +struct fscrypt_info {
> > +	char ci_data_mode;
> > +	char ci_filename_mode;
> > +	char ci_flags;
> 
> ditto
> 
> > +	struct crypto_ablkcipher *ci_ctfm;
> > +	struct key *ci_keyring_key;
> > +	char ci_master_key[FS_KEY_DESCRIPTOR_SIZE];
> > +};
> > +
> > +#define FS_CTX_REQUIRES_FREE_ENCRYPT_FL		0x00000001
> > +#define FS_WRITE_PATH_FL			0x00000002
> > +
> > +struct fscrypt_ctx {
> > +	union {
> > +		struct {
> > +			struct page *bounce_page;	/* Ciphertext page */
> > +			struct page *control_page;	/* Original page  */
> > +		} w;
> > +		struct {
> > +			struct bio *bio;
> > +			struct work_struct work;
> > +		} r;
> > +		struct list_head free_list;	/* Free list */
> > +	};
> > +	char flags;				/* Flags */
> > +	char mode;				/* Encryption mode for tfm */
> > +};
> > +
> > +struct fscrypt_completion_result {
> > +	struct completion completion;
> > +	int res;
> > +};
> > +
> > +#define DECLARE_FS_COMPLETION_RESULT(ecr) \
> > +	struct fscrypt_completion_result ecr = { \
> > +		COMPLETION_INITIALIZER((ecr).completion), 0 }
> > +
> > +static inline int fscrypt_key_size(int mode)
> > +{
> > +	switch (mode) {
> > +	case FS_ENCRYPTION_MODE_AES_256_XTS:
> > +		return FS_AES_256_XTS_KEY_SIZE;
> > +	case FS_ENCRYPTION_MODE_AES_256_GCM:
> > +		return FS_AES_256_GCM_KEY_SIZE;
> > +	case FS_ENCRYPTION_MODE_AES_256_CBC:
> > +		return FS_AES_256_CBC_KEY_SIZE;
> > +	case FS_ENCRYPTION_MODE_AES_256_CTS:
> > +		return FS_AES_256_CTS_KEY_SIZE;
> > +	default:
> > +		BUG();
> > +	}
> > +	return 0;
> > +}
> > +
> > +#define FS_FNAME_NUM_SCATTER_ENTRIES	4
> > +#define FS_CRYPTO_BLOCK_SIZE		16
> > +#define FS_FNAME_CRYPTO_DIGEST_SIZE	32
> > +
> > +/**
> > + * For encrypted symlinks, the ciphertext length is stored at the beginning
> > + * of the string in little-endian format.
> > + */
> > +struct fscrypt_symlink_data {
> > +	__le16 len;
> > +	char encrypted_path[1];
> > +} __packed;
> > +
> > +/**
> > + * This function is used to calculate the disk space required to
> > + * store a filename of length l in encrypted symlink format.
> > + */
> > +static inline u32 fscrypt_symlink_data_len(u32 l)
> > +{
> > +	if (l < FS_CRYPTO_BLOCK_SIZE)
> > +		l = FS_CRYPTO_BLOCK_SIZE;
> > +	return (l + sizeof(struct fscrypt_symlink_data) - 1);
> > +}
> > +
> > +struct fscrypt_str {
> > +	unsigned char *name;
> > +	u32 len;
> > +};
> > +
> > +struct fscrypt_name {
> > +	const struct qstr *usr_fname;
> > +	struct fscrypt_str disk_name;
> > +	u32 hash;
> > +	u32 minor_hash;
> > +	struct fscrypt_str crypto_buf;
> > +};
> > +
> > +#define FSTR_INIT(n, l)		{ .name = n, .len = l }
> > +#define FSTR_TO_QSTR(f)		QSTR_INIT((f)->name, (f)->len)
> > +#define fname_name(p)		((p)->disk_name.name)
> > +#define fname_len(p)		((p)->disk_name.len)
> > +
> > +/*
> > + * crypto opertions for filesystems
> > + */
> > +struct fscrypt_operations {
> > +	int (*get_context)(struct inode *, void *, size_t);
> > +	int (*prepare_context)(struct inode *);
> > +	int (*set_context)(struct inode *, const void *, size_t, void *);
> > +	int (*dummy_context)(struct inode *);
> > +	bool (*is_encrypted)(struct inode *);
> > +	bool (*empty_dir)(struct inode *);
> > +	unsigned (*max_namelen)(struct inode *);
> > +};
> > +
> > +static inline bool fscrypt_dummy_context_enabled(struct inode *inode)
> > +{
> > +	if (inode->i_sb->s_cop->dummy_context &&
> > +				inode->i_sb->s_cop->dummy_context(inode))
> > +		return true;
> > +	return false;
> > +}
> > +
> > +static inline bool fscrypt_valid_contents_enc_mode(u32 mode)
> > +{
> > +	return (mode == FS_ENCRYPTION_MODE_AES_256_XTS);
> > +}
> > +
> > +static inline bool fscrypt_valid_filenames_enc_mode(u32 mode)
> > +{
> > +	return (mode == FS_ENCRYPTION_MODE_AES_256_CTS);
> > +}
> > +
> > +static inline u32 fscrypt_validate_encryption_key_size(u32 mode, u32 size)
> > +{
> > +	if (size == fscrypt_key_size(mode))
> > +		return size;
> > +	return 0;
> > +}
> > +
> > +static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
> > +{
> > +	if (str->len == 1 && str->name[0] == '.')
> > +		return true;
> > +
> > +	if (str->len == 2 && str->name[0] == '.' && str->name[1] == '.')
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +static inline struct page *fscrypt_control_page(struct page *page)
> > +{
> > +#ifdef CONFIG_FS_ENCRYPTION
> > +	return ((struct fscrypt_ctx *)page_private(page))->w.control_page;
> > +#else
> > +	WARN_ON_ONCE(1);
> > +	return ERR_PTR(-EINVAL);
> > +#endif
> > +}
> > +
> > +static inline int fscrypt_has_encryption_key(struct inode *inode)
> > +{
> > +#ifdef CONFIG_FS_ENCRYPTION
> > +	return (inode->i_crypt_info != NULL);
> > +#else
> > +	return 0;
> > +#endif
> > +}
> > +#endif	/* _LINUX_FSCRYPTO_H */
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 149bec8..1d26276 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -247,6 +247,24 @@ struct fsxattr {
> >  #define FS_IOC_FSSETXATTR		_IOW ('X', 32, struct fsxattr)
> >  
> >  /*
> > + * File system encryption support
> > + */
> > +/* Policy provided via an ioctl on the topmost directory */
> > +#define FS_KEY_DESCRIPTOR_SIZE	8
> > +
> > +struct fscrypt_policy {
> > +	char version;
> > +	char contents_encryption_mode;
> > +	char filenames_encryption_mode;
> > +	char flags;
> > +	char master_key_descriptor[FS_KEY_DESCRIPTOR_SIZE];
> 
> ditto
> 
> > +} __packed;
> > +
> > +#define FS_IOC_SET_ENCRYPTION_POLICY	_IOR('f', 19, struct fscrypt_policy)
> > +#define FS_IOC_GET_ENCRYPTION_PWSALT	_IOW('f', 20, __u8[16])
> > +#define FS_IOC_GET_ENCRYPTION_POLICY	_IOW('f', 21, struct fscrypt_policy)
> > +
> > +/*
> >   * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
> >   *
> >   * Note: for historical reasons, these flags were originally used and
> > 
> 
> 
> -- 
> ~Randy
