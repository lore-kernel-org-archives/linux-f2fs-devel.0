Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35820CDB479
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KpCbbYhZpCnZoDamm7kK8ec6r5pmyqnaUBe1VXwsaLI=; b=DsEpFfWRkAcGabNk4qwLv7I+Vp
	o17hJkQ2pvvAVWsYVNntlFKDKkSoOIsDdF6kjFovPXD8LgM2mgPFOIleriqQ4Gwl9TXgWKcMAiR+c
	MItGNCjpmxOSMXFvU5LUBYQIRL6B/h+3PtFXQ3nLYnZPOD64AKB9TwhaGPkiGfS4m7OQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcFoi-00067X-Dr;
	Wed, 24 Jun 2026 05:06:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wcFoc-00066P-Ng
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 05:06:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EOXtI4rk3hbRP+YjSQO+HIVfHPyaAbXjRFafHmgVCOg=; b=mjAEbHWu/BKbvbMT7Y3K1odKyx
 HAMmuIlE4q64ZcUj+tSc6ITiCX/fPCV6Hi0Oo7g7tLzd4G0qx+SWuswIzH4LZGYJRmG+X1t1MCQim
 gyMrG0UTAeg2L5Xv+ZrD1ArLKw98JyJ4ZuVlsTSAc1RWSgC6/XSFAM33dHxsXJeUEZPY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EOXtI4rk3hbRP+YjSQO+HIVfHPyaAbXjRFafHmgVCOg=; b=B4P9+SffFXPldcZiMKGlkyQGrs
 oFBw4YO8FXRiiXa8o5xQ7zb5LFOxcoKsg198YuTzfu7UDT4yLDKIHrcEcmeGO/9vPQ3OemXYH2Tno
 /wuCkntneEioYG/q05tljb8GqhoKpyEllX8Uk3CW5kv29j8GCLd5nBEBjOIL4RK5tAFE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcFoY-0004n6-2Z for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 05:06:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9874260214;
 Wed, 24 Jun 2026 05:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49211F00A3E;
 Wed, 24 Jun 2026 05:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782277567;
 bh=EOXtI4rk3hbRP+YjSQO+HIVfHPyaAbXjRFafHmgVCOg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=geArDSFPMIxU3iBswfGLDdKq2kvZkVW/Rh7xCw14drC+CfxeEkSat+Xp3Qh3Cfmia
 DPOeDfXPEYNIyrkVBl8sRy7uk4XIL7efbrv7wBV198I+9SpPgRBFfYK9t9Goub2/2H
 sW1/scir9p/yvf7R0m6GQqAab0IOsd8xR4/R0tPqwO8lRZ6NA0oKm2YSKG4a7JjDYC
 oT72JhcWR8dvZNhLablIRFQQd5oACHU4VJ7njxfA3ls39WBX2nTjdEbn5DM+k+sXXt
 lazaibk/mXretG1LSxRbZM4bhFJ6dJslnaWNzxphwtlWNEObxLUU1PvuiZ6VMBQiXH
 3aSHYEhk+ts7Q==
To: linux-fscrypt@vger.kernel.org
Date: Tue, 23 Jun 2026 22:03:32 -0700
Message-ID: <20260624050334.124606-15-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624050334.124606-1-ebiggers@kernel.org>
References: <20260624050334.124606-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wcFoY-0004n6-2Z
Subject: [f2fs-dev] [PATCH 14/16] fscrypt: Remove unused functions and
 workqueue
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

Remove functions that are no longer used:

- fscrypt_decrypt_bio()
- fscrypt_decrypt_pagecache_blocks()
- fscrypt_inode_uses_fs_layer_crypto()
- fscrypt_inode_uses_inline_crypto()
- fscrypt_enqueue_decrypt_work()

This makes the decryption workqueue unused, so remove it too.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/crypto/bio.c         | 32 --------------------
 fs/crypto/crypto.c      | 65 -----------------------------------------
 include/linux/fscrypt.h | 47 -----------------------------
 3 files changed, 144 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 58b6b13eeedd..db095258cfca 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -13,42 +13,10 @@
 #include <linux/namei.h>
 #include <linux/pagemap.h>
 
 #include "fscrypt_private.h"
 
-/**
- * fscrypt_decrypt_bio() - decrypt the contents of a bio
- * @bio: the bio to decrypt
- *
- * Decrypt the contents of a "read" bio following successful completion of the
- * underlying disk read.  The bio must be reading a whole number of blocks of an
- * encrypted file directly into the page cache.  If the bio is reading the
- * ciphertext into bounce pages instead of the page cache (for example, because
- * the file is also compressed, so decompression is required after decryption),
- * then this function isn't applicable.  This function may sleep, so it must be
- * called from a workqueue rather than from the bio's bi_end_io callback.
- *
- * Return: %true on success; %false on failure.  On failure, bio->bi_status is
- *	   also set to an error status.
- */
-bool fscrypt_decrypt_bio(struct bio *bio)
-{
-	struct folio_iter fi;
-
-	bio_for_each_folio_all(fi, bio) {
-		int err = fscrypt_decrypt_pagecache_blocks(fi.folio, fi.length,
-							   fi.offset);
-
-		if (err) {
-			bio->bi_status = errno_to_blk_status(err);
-			return false;
-		}
-	}
-	return true;
-}
-EXPORT_SYMBOL(fscrypt_decrypt_bio);
-
 struct fscrypt_zero_done {
 	atomic_t		pending;
 	blk_status_t		status;
 	struct completion	done;
 };
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 8c4660429418..27663f4d8705 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -36,21 +36,14 @@ module_param(num_prealloc_crypto_pages, uint, 0444);
 MODULE_PARM_DESC(num_prealloc_crypto_pages,
 		"Number of crypto pages to preallocate");
 
 static mempool_t *fscrypt_bounce_page_pool = NULL;
 
-static struct workqueue_struct *fscrypt_read_workqueue;
 static DEFINE_MUTEX(fscrypt_init_mutex);
 
 struct kmem_cache *fscrypt_inode_info_cachep;
 
-void fscrypt_enqueue_decrypt_work(struct work_struct *work)
-{
-	queue_work(fscrypt_read_workqueue, work);
-}
-EXPORT_SYMBOL(fscrypt_enqueue_decrypt_work);
-
 static struct page *fscrypt_alloc_bounce_page(gfp_t gfp_flags)
 {
 	if (WARN_ON_ONCE(!fscrypt_bounce_page_pool)) {
 		/*
 		 * Oops, the filesystem called a function that uses the bounce
@@ -236,54 +229,10 @@ int fscrypt_encrypt_block_inplace(const struct inode *inode, struct page *page,
 				       FS_ENCRYPT, lblk_num, page, page, len,
 				       offs);
 }
 EXPORT_SYMBOL(fscrypt_encrypt_block_inplace);
 
-/**
- * fscrypt_decrypt_pagecache_blocks() - Decrypt data from a pagecache folio
- * @folio: the pagecache folio containing the data to decrypt
- * @len: size of the data to decrypt, in bytes
- * @offs: offset within @folio of the data to decrypt, in bytes
- *
- * Decrypt data that has just been read from an encrypted file.  The data must
- * be located in a pagecache folio that is still locked and not yet uptodate.
- * The length and offset of the data must be aligned to the file's crypto data
- * unit size.  Alignment to the filesystem block size fulfills this requirement,
- * as the filesystem block size is always a multiple of the data unit size.
- *
- * Return: 0 on success; -errno on failure
- */
-int fscrypt_decrypt_pagecache_blocks(struct folio *folio, size_t len,
-				     size_t offs)
-{
-	const struct inode *inode = folio->mapping->host;
-	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
-	const unsigned int du_bits = ci->ci_data_unit_bits;
-	const unsigned int du_size = 1U << du_bits;
-	u64 index = ((u64)folio->index << (PAGE_SHIFT - du_bits)) +
-		    (offs >> du_bits);
-	size_t i;
-	int err;
-
-	if (WARN_ON_ONCE(!folio_test_locked(folio)))
-		return -EINVAL;
-
-	if (WARN_ON_ONCE(len <= 0 || !IS_ALIGNED(len | offs, du_size)))
-		return -EINVAL;
-
-	for (i = offs; i < offs + len; i += du_size, index++) {
-		struct page *page = folio_page(folio, i >> PAGE_SHIFT);
-
-		err = fscrypt_crypt_data_unit(ci, FS_DECRYPT, index, page,
-					      page, du_size, i & ~PAGE_MASK);
-		if (err)
-			return err;
-	}
-	return 0;
-}
-EXPORT_SYMBOL(fscrypt_decrypt_pagecache_blocks);
-
 /**
  * fscrypt_decrypt_block_inplace() - Decrypt a filesystem block in-place
  * @inode:     The inode to which this block belongs
  * @page:      The page containing the block to decrypt
  * @len:       Size of block to decrypt.  This must be a multiple of
@@ -369,24 +318,10 @@ void fscrypt_msg(const struct inode *inode, const char *level,
 	va_end(args);
 }
 
 static int __init fscrypt_init(void)
 {
-	/*
-	 * Use an unbound workqueue to allow bios to be decrypted in parallel
-	 * even when they happen to complete on the same CPU.  This sacrifices
-	 * locality, but it's worthwhile since decryption is CPU-intensive.
-	 *
-	 * Also use a high-priority workqueue to prioritize decryption work,
-	 * which blocks reads from completing, over regular application tasks.
-	 */
-	fscrypt_read_workqueue = alloc_workqueue("fscrypt_read_queue",
-						 WQ_UNBOUND | WQ_HIGHPRI,
-						 num_online_cpus());
-	if (!fscrypt_read_workqueue)
-		panic("failed to allocate fscrypt_read_queue");
-
 	fscrypt_inode_info_cachep = KMEM_CACHE(fscrypt_inode_info,
 					       SLAB_RECLAIM_ACCOUNT |
 					       SLAB_PANIC);
 	fscrypt_init_keyring();
 	return 0;
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 43bafdd67dd7..acf5b28eb9d7 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -341,20 +341,17 @@ static inline void fscrypt_prepare_dentry(struct dentry *dentry,
 		spin_unlock(&dentry->d_lock);
 	}
 }
 
 /* crypto.c */
-void fscrypt_enqueue_decrypt_work(struct work_struct *);
 
 struct page *fscrypt_encrypt_pagecache_blocks(struct folio *folio,
 		size_t len, size_t offs, gfp_t gfp_flags);
 int fscrypt_encrypt_block_inplace(const struct inode *inode, struct page *page,
 				  unsigned int len, unsigned int offs,
 				  u64 lblk_num);
 
-int fscrypt_decrypt_pagecache_blocks(struct folio *folio, size_t len,
-				     size_t offs);
 int fscrypt_decrypt_block_inplace(const struct inode *inode, struct page *page,
 				  unsigned int len, unsigned int offs,
 				  u64 lblk_num);
 
 static inline bool fscrypt_is_bounce_page(struct page *page)
@@ -448,11 +445,10 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 bool fscrypt_match_name(const struct fscrypt_name *fname,
 			const u8 *de_name, u32 de_name_len);
 u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name);
 
 /* bio.c */
-bool fscrypt_decrypt_bio(struct bio *bio);
 int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
 			  sector_t sector, u64 len);
 
 /* hooks.c */
 int fscrypt_file_open(struct inode *inode, struct file *filp);
@@ -508,13 +504,10 @@ static inline void fscrypt_prepare_dentry(struct dentry *dentry,
 					  bool is_nokey_name)
 {
 }
 
 /* crypto.c */
-static inline void fscrypt_enqueue_decrypt_work(struct work_struct *work)
-{
-}
 
 static inline struct page *fscrypt_encrypt_pagecache_blocks(struct folio *folio,
 		size_t len, size_t offs, gfp_t gfp_flags)
 {
 	return ERR_PTR(-EOPNOTSUPP);
@@ -526,16 +519,10 @@ static inline int fscrypt_encrypt_block_inplace(const struct inode *inode,
 						unsigned int offs, u64 lblk_num)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int fscrypt_decrypt_pagecache_blocks(struct folio *folio,
-						   size_t len, size_t offs)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline int fscrypt_decrypt_block_inplace(const struct inode *inode,
 						struct page *page,
 						unsigned int len,
 						unsigned int offs, u64 lblk_num)
 {
@@ -749,14 +736,10 @@ static inline int fscrypt_d_revalidate(struct inode *dir, const struct qstr *nam
 {
 	return 1;
 }
 
 /* bio.c */
-static inline bool fscrypt_decrypt_bio(struct bio *bio)
-{
-	return true;
-}
 
 static inline int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
 					sector_t sector, u64 len)
 {
 	return -EOPNOTSUPP;
@@ -890,40 +873,10 @@ static inline u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk,
 {
 	return nr_blocks;
 }
 #endif /* !CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
 
-/**
- * fscrypt_inode_uses_inline_crypto() - test whether an inode uses inline
- *					encryption
- * @inode: an inode. If encrypted, its key must be set up.
- *
- * Return: true if the inode requires file contents encryption and if the
- *	   encryption should be done in the block layer via blk-crypto rather
- *	   than in the filesystem layer.
- */
-static inline bool fscrypt_inode_uses_inline_crypto(const struct inode *inode)
-{
-	return fscrypt_needs_contents_encryption(inode) &&
-	       inode->i_sb->s_cop->is_block_based;
-}
-
-/**
- * fscrypt_inode_uses_fs_layer_crypto() - test whether an inode uses fs-layer
- *					  encryption
- * @inode: an inode. If encrypted, its key must be set up.
- *
- * Return: true if the inode requires file contents encryption and if the
- *	   encryption should be done in the filesystem layer rather than in the
- *	   block layer via blk-crypto.
- */
-static inline bool fscrypt_inode_uses_fs_layer_crypto(const struct inode *inode)
-{
-	return fscrypt_needs_contents_encryption(inode) &&
-	       !inode->i_sb->s_cop->is_block_based;
-}
-
 /**
  * fscrypt_has_encryption_key() - check whether an inode has had its key set up
  * @inode: the inode to check
  *
  * Return: %true if the inode has had its encryption key set up, else %false.
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
