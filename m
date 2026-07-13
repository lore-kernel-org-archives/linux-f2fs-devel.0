Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C654EC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Jul 2026 02:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MBS0jq4eGC22zqHJE6Q8JH4+UGesfXE698Baf9vMH2Q=; b=ULT4SQKBmmsM6mhp9g1JxbV5YQ
	Ryz0nou5JVZDvlYjFXXkrG6F2OI2sBdJeygeHCWlUFXVIz43HbD8c1oq5mchbWEu6139FFnntqsSO
	5L7F8Avq2KJVPQonnbATlIAmFW9y+HR9yQAGVM0XwwqO3lHGbW8D+Bx/FJgjWpiIU5Uc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wj6at-0006iD-W1;
	Mon, 13 Jul 2026 02:40:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wj6aR-0006fn-NG
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 02:40:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bFQGGaiBgnFHj1j6zOR9VajfI9yzHquSbkVoCpEW8uE=; b=k0GW8YpizvyvyBcg8jcgJLtytN
 DUSxlae1iMYYyndOz/XwHeEYPitrzL3ss/+SSvLOeNQSX5ITTTc4lKRPoeKyeDQo2vTSJu+ik9Qfa
 06Ra4HD1vGynN0cXWv8exAps3V0Aw2cMbSq4iYQytXjLh0SZgeUNt/IMBVDYxrCWCxJM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bFQGGaiBgnFHj1j6zOR9VajfI9yzHquSbkVoCpEW8uE=; b=mIaGVExhJQo7nyeSF18oLKsJd+
 ZgHpde4ip1rbyMU4pxD2PdTJ1Ueu37sNuLPOyTrYYOAy0YdCDyaEPaO70yc8CRPaMuvIBMQoJO32V
 uNylj/8Osfr+kO8PALpDEgTyfH68GzNhaTULevG62qGIWcW3MHdob5LA3cRz77ja3rgo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wj6aQ-0003D6-LP for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 02:40:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1246E601DE;
 Mon, 13 Jul 2026 02:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA59B1F000E9;
 Mon, 13 Jul 2026 02:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783910396;
 bh=bFQGGaiBgnFHj1j6zOR9VajfI9yzHquSbkVoCpEW8uE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZB7peMqN6+Ra2/4j3S0pluWN3VH4V6Pxy+vq+kzcoTKWQxGFIkJFle52UsMDP7fzB
 wtRaMwaExML8UwLpUCpIyOlVcPOS0cDkDjIglwIVgfWaeK60h+p6tRDLhsqthazJP2
 KOADSS2GlG1x2JcA9NhrvDbeixyf2QaqYAE/YuzSagaS2hYYgslB4WRL17nJawYVrD
 BLvEPQuNPa0rt7qqHnj+wctsUYKi3qCLzKjHyVBPEg5p9RB0pT1CgwbEhY7XF8Hf2v
 iXVw5WZaCqw40Ajjtd8As1s9uQ3J4ORo9HJdPhSqfDo7b285kkxl6RkF/x2u4dyJK7
 BiAlsa+1+MNDw==
To: linux-fscrypt@vger.kernel.org
Date: Sun, 12 Jul 2026 22:37:08 -0400
Message-ID: <20260713023708.9245-18-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713023708.9245-1-ebiggers@kernel.org>
References: <20260713023708.9245-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wj6aQ-0003D6-LP
Subject: [f2fs-dev] [PATCH v3 17/17] fscrypt: Add safety checks to
 non-block-based en/decryption
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

fscrypt_encrypt_pagecache_blocks(), fscrypt_encrypt_block_inplace(),
fscrypt_decrypt_block_inplace() would dereference a NULL
fscrypt_inode_info pointer if they were to be called on a file that
hasn't been opened yet or on a block-based filesystem.  Since they have
the ability to report errors anyway, add WARN_ON_ONCE checks for this.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/crypto/crypto.c | 61 +++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 27663f4d8705..c91eda62f9a4 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -105,12 +105,17 @@ static int fscrypt_crypt_data_unit(const struct fscrypt_inode_info *ci,
 				   struct page *dest_page, unsigned int len,
 				   unsigned int offs)
 {
-	struct crypto_sync_skcipher *tfm = ci->ci_enc_key.tfm;
-	SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
+	struct crypto_sync_skcipher *tfm;
 	union fscrypt_iv iv;
 	struct scatterlist dst, src;
 	int err;
 
+	if (WARN_ON_ONCE(ci == NULL)) /* File hasn't been opened yet? */
+		return -ENOKEY;
+	tfm = ci->ci_enc_key.tfm;
+	if (WARN_ON_ONCE(tfm == NULL)) /* Called on block-based filesystem? */
+		return -ENOKEY;
+
 	if (WARN_ON_ONCE(len <= 0))
 		return -EINVAL;
 	if (WARN_ON_ONCE(len % FSCRYPT_CONTENTS_ALIGNMENT != 0))
@@ -118,18 +123,22 @@ static int fscrypt_crypt_data_unit(const struct fscrypt_inode_info *ci,
 
 	fscrypt_generate_iv(&iv, index, ci);
 
-	skcipher_request_set_callback(
-		req, CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
-		NULL, NULL);
-	sg_init_table(&dst, 1);
-	sg_set_page(&dst, dest_page, len, offs);
-	sg_init_table(&src, 1);
-	sg_set_page(&src, src_page, len, offs);
-	skcipher_request_set_crypt(req, &src, &dst, len, &iv);
-	if (rw == FS_DECRYPT)
-		err = crypto_skcipher_decrypt(req);
-	else
-		err = crypto_skcipher_encrypt(req);
+	{
+		SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
+		skcipher_request_set_callback(req,
+					      CRYPTO_TFM_REQ_MAY_BACKLOG |
+						      CRYPTO_TFM_REQ_MAY_SLEEP,
+					      NULL, NULL);
+		sg_init_table(&dst, 1);
+		sg_set_page(&dst, dest_page, len, offs);
+		sg_init_table(&src, 1);
+		sg_set_page(&src, src_page, len, offs);
+		skcipher_request_set_crypt(req, &src, &dst, len, &iv);
+		if (rw == FS_DECRYPT)
+			err = crypto_skcipher_decrypt(req);
+		else
+			err = crypto_skcipher_encrypt(req);
+	}
 	if (err)
 		fscrypt_err(ci->ci_inode,
 			    "%scryption failed for data unit %llu: %d",
@@ -153,7 +162,7 @@ static int fscrypt_crypt_data_unit(const struct fscrypt_inode_info *ci,
  * which the plaintext data was located in the source page.  Any other parts of
  * the bounce page will be left uninitialized.
  *
- * This is for use by the filesystem's ->writepages() method.
+ * This is for use by the ->writepages() method of non-block-based filesystems.
  *
  * The bounce page allocation is mempool-backed, so it will always succeed when
  * @gfp_flags includes __GFP_DIRECT_RECLAIM, e.g. when it's GFP_NOFS.  However,
@@ -167,14 +176,20 @@ struct page *fscrypt_encrypt_pagecache_blocks(struct folio *folio,
 {
 	const struct inode *inode = folio->mapping->host;
 	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
-	const unsigned int du_bits = ci->ci_data_unit_bits;
-	const unsigned int du_size = 1U << du_bits;
+	unsigned int du_bits;
+	unsigned int du_size;
 	struct page *ciphertext_page;
-	u64 index = ((u64)folio->index << (PAGE_SHIFT - du_bits)) +
-		    (offs >> du_bits);
+	u64 index;
 	unsigned int i;
 	int err;
 
+	if (WARN_ON_ONCE(ci == NULL)) /* File hasn't been opened yet? */
+		return ERR_PTR(-ENOKEY);
+
+	du_bits = ci->ci_data_unit_bits;
+	du_size = 1U << du_bits;
+	index = (folio_pos(folio) + offs) >> du_bits;
+
 	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
 	if (WARN_ON_ONCE(!folio_test_locked(folio)))
 		return ERR_PTR(-EINVAL);
@@ -215,7 +230,8 @@ EXPORT_SYMBOL(fscrypt_encrypt_pagecache_blocks);
  * arbitrary page, not necessarily in the original pagecache page.  The @inode
  * and @lblk_num must be specified, as they can't be determined from @page.
  *
- * This is not compatible with fscrypt_operations::supports_subblock_data_units.
+ * This function only supports non-block-based filesystems that don't support
+ * sub-block data units (as indicated by the fscrypt_operations fields).
  *
  * Return: 0 on success; -errno on failure
  */
@@ -245,7 +261,8 @@ EXPORT_SYMBOL(fscrypt_encrypt_block_inplace);
  * arbitrary page, not necessarily in the original pagecache page.  The @inode
  * and @lblk_num must be specified, as they can't be determined from @page.
  *
- * This is not compatible with fscrypt_operations::supports_subblock_data_units.
+ * This function only supports non-block-based filesystems that don't support
+ * sub-block data units (as indicated by the fscrypt_operations fields).
  *
  * Return: 0 on success; -errno on failure
  */
@@ -275,7 +292,7 @@ int fscrypt_initialize(struct super_block *sb)
 	mempool_t *pool;
 
 	/* pairs with smp_store_release() below */
-	if (likely(smp_load_acquire(&fscrypt_bounce_page_pool)))
+	if (smp_load_acquire(&fscrypt_bounce_page_pool))
 		return 0;
 
 	/* No need to allocate a bounce page pool if this FS won't use it. */
-- 
2.55.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
