Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEA5CDE000
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/UDWPc8qcr8AFNmTStzJq9dxF5ftHDSShblC42jy43M=; b=MzQV4z0TWe1DdiyLNHjuiKt19R
	/88t3y/UFQWWKSoQjBR+4rAJ6sDSYoXk3nUP9HaB0m57MV352cg84PTrbsJ9zmdrozh+LtXTdRkeT
	ParwRv44XJc1HodHWLzKbEP9nIIA38mxz8Ui77wNPnfxO3klrbOtHrgvzfuSMy4CDvIs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcFof-0006Vw-NG;
	Wed, 24 Jun 2026 05:06:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wcFoZ-0006UW-JL
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 05:06:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=klO3I4gbr+5T+kAUtraramyA7ErT+tHz21v36Ugnnss=; b=N6BJcF+YMRorRPwqilxDffQVNw
 s65QJo6YjE3URQV8XA1J6rwVc1EKh3vFs2sKVZzOeCvWWv9cGbVEfIsFeaG6YUPwmmnFDNvqvon8C
 z4C1VgBTxARnlz/UnPn+9fja+er4JtLNjqPkXejMWH/saS5h1g66K/Ei5JNbMkaQdaoo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=klO3I4gbr+5T+kAUtraramyA7ErT+tHz21v36Ugnnss=; b=XbI2VRMXGiuSbQcM8jps//ehbZ
 MwdAPyGvDE4tMSJYUbTttwern3uNHuxTl6AcdlQN2O4lD6T8f0mbkFVdI+lsJjHWOnVfwRf04YhzC
 nlcUVlEx9yMjrYPebpkNByU8BB7f6DMkYwdAhqzn6i2j5hm/eYKuAnsIkojHzAh+DQrc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcFoY-0004n9-SP for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 05:06:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 34FA7601F8;
 Wed, 24 Jun 2026 05:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E5A1F00A3D;
 Wed, 24 Jun 2026 05:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782277567;
 bh=klO3I4gbr+5T+kAUtraramyA7ErT+tHz21v36Ugnnss=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DSFCnIkn/LtHel2fVHfieqJbYzfA/4Ksjer9jr5GWn153GtlnJpsDLXDtfF3xpEuN
 l3ZRbwi5NE51QIdNstm6/YjUnvcyQ7waZPpgElau/+Jre/ueNo15r7TPII/QIcTmu6
 UUZGUqgh+BhGZxMa0/6GsHEWKDhzJV7Hky+H9o8I8ZvP6lF0wRVGSmEp1BkChRbcv2
 j0CCnaepJAIMdhdCjg6M/1wvCI/Hwtf9Tp2tv9CcvvoTO61nQEfqM+aiBpHYbOZ37M
 9DPgVlyvIxZlGDUuDCoXhPv+sp4Ib3LbQjVs0G70EyKXGur0phOnN9scbKNrqmOuWF
 Qw8564P8Z3mdg==
To: linux-fscrypt@vger.kernel.org
Date: Tue, 23 Jun 2026 22:03:33 -0700
Message-ID: <20260624050334.124606-16-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624050334.124606-1-ebiggers@kernel.org>
References: <20260624050334.124606-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wcFoY-0004n9-SP
Subject: [f2fs-dev] [PATCH 15/16] fscrypt: Merge bio.c and inline_crypt.c
 into block.c
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Zhang Yi <yi.zhang@huawei.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, Baokun Li <libaokun@linux.alibaba.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Now that fscrypt always uses blk-crypto on block-based filesystems,
there's no meaningful difference between bio.c and inline_crypt.c.
Therefore merge the two files into one named block.c.

Note: I didn't carry over bio.c's "Copyright (C) 2015, Motorola
Mobility", as none of the code that applied to remained.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/crypto/Makefile                    |   3 +-
 fs/crypto/bio.c                       | 100 --------------------------
 fs/crypto/{inline_crypt.c => block.c} |  96 +++++++++++++++++++++++--
 fs/crypto/fscrypt_private.h           |   2 +-
 include/linux/fscrypt.h               |  22 +++---
 5 files changed, 101 insertions(+), 122 deletions(-)
 delete mode 100644 fs/crypto/bio.c
 rename fs/crypto/{inline_crypt.c => block.c} (79%)

diff --git a/fs/crypto/Makefile b/fs/crypto/Makefile
index 652c7180ec6d..b03e02f0f09d 100644
--- a/fs/crypto/Makefile
+++ b/fs/crypto/Makefile
@@ -8,7 +8,6 @@ fscrypto-y := crypto.o \
 	      keyring.o \
 	      keysetup.o \
 	      keysetup_v1.o \
 	      policy.o
 
-fscrypto-$(CONFIG_BLOCK) += bio.o
-fscrypto-$(CONFIG_FS_ENCRYPTION_INLINE_CRYPT) += inline_crypt.o
+fscrypto-$(CONFIG_BLOCK) += block.o
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
deleted file mode 100644
index db095258cfca..000000000000
--- a/fs/crypto/bio.c
+++ /dev/null
@@ -1,100 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Utility functions for file contents encryption/decryption on
- * block device-based filesystems.
- *
- * Copyright (C) 2015, Google, Inc.
- * Copyright (C) 2015, Motorola Mobility
- */
-
-#include <linux/bio.h>
-#include <linux/export.h>
-#include <linux/module.h>
-#include <linux/namei.h>
-#include <linux/pagemap.h>
-
-#include "fscrypt_private.h"
-
-struct fscrypt_zero_done {
-	atomic_t		pending;
-	blk_status_t		status;
-	struct completion	done;
-};
-
-static void fscrypt_zeroout_range_done(struct fscrypt_zero_done *done)
-{
-	if (atomic_dec_and_test(&done->pending))
-		complete(&done->done);
-}
-
-static void fscrypt_zeroout_range_end_io(struct bio *bio)
-{
-	struct fscrypt_zero_done *done = bio->bi_private;
-
-	if (bio->bi_status)
-		cmpxchg(&done->status, 0, bio->bi_status);
-	fscrypt_zeroout_range_done(done);
-	bio_put(bio);
-}
-
-/**
- * fscrypt_zeroout_range() - zero out a range of blocks in an encrypted file
- * @inode: the file's inode
- * @pos: the first file position (in bytes) to zero out
- * @sector: the first sector to zero out
- * @len: bytes to zero out
- *
- * Zero out filesystem blocks in an encrypted regular file on-disk, i.e. write
- * ciphertext blocks which decrypt to the all-zeroes block.  The blocks must be
- * both logically and physically contiguous.  It's also assumed that the
- * filesystem only uses a single block device, ->s_bdev.  @len must be a
- * multiple of the file system logical block size.
- *
- * Note that since each block uses a different IV, this involves writing a
- * different ciphertext to each block; we can't simply reuse the same one.
- *
- * Return: 0 on success; -errno on failure.
- */
-int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
-			  sector_t sector, u64 len)
-{
-	struct fscrypt_zero_done done = {
-		.pending	= ATOMIC_INIT(1),
-		.done		= COMPLETION_INITIALIZER_ONSTACK(done.done),
-	};
-
-	if (len == 0)
-		return 0;
-
-	do {
-		struct bio *bio;
-		unsigned int n;
-
-		bio = bio_alloc(inode->i_sb->s_bdev, BIO_MAX_VECS, REQ_OP_WRITE,
-				GFP_NOFS);
-		bio->bi_iter.bi_sector = sector;
-		bio->bi_private = &done;
-		bio->bi_end_io = fscrypt_zeroout_range_end_io;
-		fscrypt_set_bio_crypt_ctx(bio, inode, pos, GFP_NOFS);
-
-		for (n = 0; n < BIO_MAX_VECS; n++) {
-			unsigned int bytes_this_page = min(len, PAGE_SIZE);
-
-			__bio_add_page(bio, ZERO_PAGE(0), bytes_this_page, 0);
-			len -= bytes_this_page;
-			pos += bytes_this_page;
-			sector += (bytes_this_page >> SECTOR_SHIFT);
-			if (!len || !fscrypt_mergeable_bio(bio, inode, pos))
-				break;
-		}
-
-		atomic_inc(&done.pending);
-		blk_crypto_submit_bio(bio);
-	} while (len);
-
-	fscrypt_zeroout_range_done(&done);
-
-	wait_for_completion(&done.done);
-	return blk_status_to_errno(done.status);
-}
-EXPORT_SYMBOL(fscrypt_zeroout_range);
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/block.c
similarity index 79%
rename from fs/crypto/inline_crypt.c
rename to fs/crypto/block.c
index 3c3a46c5af42..60e687da7760 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/block.c
@@ -1,22 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Inline encryption support for fscrypt
+ * File contents en/decryption on block-based filesystems
  *
  * Copyright 2019 Google LLC
  */
 
 /*
- * With "inline encryption", the block layer handles the decryption/encryption
- * as part of the bio, instead of the filesystem doing the crypto itself via
- * crypto API.  See Documentation/block/inline-encryption.rst.  fscrypt still
- * provides the key and IV to use.
+ * This file implements fscrypt's file contents en/decryption using blk-crypto
+ * (Documentation/block/inline-encryption.rst).  fscrypt assigns a bio_crypt_ctx
+ * with a key and IV to each bio, and the block layer does the en/decryption.
+ *
+ * This file's exported functions are called only by block-based filesystems.
  */
 
 #include <linux/blk-crypto.h>
 #include <linux/blkdev.h>
-#include <linux/buffer_head.h>
 #include <linux/export.h>
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
 
@@ -338,5 +338,89 @@ u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk, u64 nr_blocks)
 	dun = ci->ci_hashed_ino + lblk;
 
 	return min_t(u64, nr_blocks, (u64)U32_MAX + 1 - dun);
 }
 EXPORT_SYMBOL_GPL(fscrypt_limit_io_blocks);
+
+struct fscrypt_zero_done {
+	atomic_t		pending;
+	blk_status_t		status;
+	struct completion	done;
+};
+
+static void fscrypt_zeroout_range_done(struct fscrypt_zero_done *done)
+{
+	if (atomic_dec_and_test(&done->pending))
+		complete(&done->done);
+}
+
+static void fscrypt_zeroout_range_end_io(struct bio *bio)
+{
+	struct fscrypt_zero_done *done = bio->bi_private;
+
+	if (bio->bi_status)
+		cmpxchg(&done->status, 0, bio->bi_status);
+	fscrypt_zeroout_range_done(done);
+	bio_put(bio);
+}
+
+/**
+ * fscrypt_zeroout_range() - zero out a range of blocks in an encrypted file
+ * @inode: the file's inode
+ * @pos: the first file position (in bytes) to zero out
+ * @sector: the first sector to zero out
+ * @len: bytes to zero out
+ *
+ * Zero out filesystem blocks in an encrypted regular file on-disk, i.e. write
+ * ciphertext blocks which decrypt to the all-zeroes block.  The blocks must be
+ * both logically and physically contiguous.  It's also assumed that the
+ * filesystem only uses a single block device, ->s_bdev.  @len must be a
+ * multiple of the file system logical block size.
+ *
+ * Note that since each block uses a different IV, this involves writing a
+ * different ciphertext to each block; we can't simply reuse the same one.
+ *
+ * Return: 0 on success; -errno on failure.
+ */
+int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
+			  sector_t sector, u64 len)
+{
+	struct fscrypt_zero_done done = {
+		.pending	= ATOMIC_INIT(1),
+		.done		= COMPLETION_INITIALIZER_ONSTACK(done.done),
+	};
+
+	if (len == 0)
+		return 0;
+
+	do {
+		struct bio *bio;
+		unsigned int n;
+
+		bio = bio_alloc(inode->i_sb->s_bdev, BIO_MAX_VECS, REQ_OP_WRITE,
+				GFP_NOFS);
+		bio->bi_iter.bi_sector = sector;
+		bio->bi_private = &done;
+		bio->bi_end_io = fscrypt_zeroout_range_end_io;
+		fscrypt_set_bio_crypt_ctx(bio, inode, pos, GFP_NOFS);
+
+		for (n = 0; n < BIO_MAX_VECS; n++) {
+			unsigned int bytes_this_page = min(len, PAGE_SIZE);
+
+			__bio_add_page(bio, ZERO_PAGE(0), bytes_this_page, 0);
+			len -= bytes_this_page;
+			pos += bytes_this_page;
+			sector += (bytes_this_page >> SECTOR_SHIFT);
+			if (!len || !fscrypt_mergeable_bio(bio, inode, pos))
+				break;
+		}
+
+		atomic_inc(&done.pending);
+		blk_crypto_submit_bio(bio);
+	} while (len);
+
+	fscrypt_zeroout_range_done(&done);
+
+	wait_for_completion(&done.done);
+	return blk_status_to_errno(done.status);
+}
+EXPORT_SYMBOL(fscrypt_zeroout_range);
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index da9040407d4a..74329e0953d1 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -393,11 +393,11 @@ void fscrypt_init_hkdf(struct hmac_sha512_key *hkdf, const u8 *master_key,
 
 void fscrypt_hkdf_expand(const struct hmac_sha512_key *hkdf, u8 context,
 			 const u8 *info, unsigned int infolen,
 			 u8 *okm, unsigned int okmlen);
 
-/* inline_crypt.c */
+/* block.c */
 #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
 static inline bool
 fscrypt_using_inline_encryption(const struct fscrypt_inode_info *ci)
 {
 	const struct inode *inode = ci->ci_inode;
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index acf5b28eb9d7..52ff014aeae6 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -444,14 +444,10 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 			      struct fscrypt_str *oname);
 bool fscrypt_match_name(const struct fscrypt_name *fname,
 			const u8 *de_name, u32 de_name_len);
 u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name);
 
-/* bio.c */
-int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
-			  sector_t sector, u64 len);
-
 /* hooks.c */
 int fscrypt_file_open(struct inode *inode, struct file *filp);
 int __fscrypt_prepare_link(struct inode *inode, struct inode *dir,
 			   struct dentry *dentry);
 int __fscrypt_prepare_rename(struct inode *old_dir, struct dentry *old_dentry,
@@ -735,18 +731,10 @@ static inline int fscrypt_d_revalidate(struct inode *dir, const struct qstr *nam
 				       struct dentry *dentry, unsigned int flags)
 {
 	return 1;
 }
 
-/* bio.c */
-
-static inline int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
-					sector_t sector, u64 len)
-{
-	return -EOPNOTSUPP;
-}
-
 /* hooks.c */
 
 static inline int fscrypt_file_open(struct inode *inode, struct file *filp)
 {
 	if (IS_ENCRYPTED(inode))
@@ -842,20 +830,22 @@ static inline void fscrypt_set_ops(struct super_block *sb,
 {
 }
 
 #endif	/* !CONFIG_FS_ENCRYPTION */
 
-/* inline_crypt.c */
+/* block.c */
 #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
 
 void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
 			       loff_t pos, gfp_t gfp_mask);
 
 bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 			   loff_t pos);
 
 u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk, u64 nr_blocks);
+int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
+			  sector_t sector, u64 len);
 
 #else /* CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
 
 static inline void fscrypt_set_bio_crypt_ctx(struct bio *bio,
 					     const struct inode *inode,
@@ -871,10 +861,16 @@ static inline bool fscrypt_mergeable_bio(struct bio *bio,
 static inline u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk,
 					  u64 nr_blocks)
 {
 	return nr_blocks;
 }
+
+static inline int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
+					sector_t sector, u64 len)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* !CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
 
 /**
  * fscrypt_has_encryption_key() - check whether an inode has had its key set up
  * @inode: the inode to check
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
