Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8488CDB479
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RikUClTN92u7vdeS/NMUrbI6KhiRsxwPpc7X1nGZLsU=; b=WnH2F7wBnGZpOWjxdYD/MS3SJF
	iJ+eK8khagadjxT4m7h13Z6nu6OigvHSYT5f5P73eEGS+HshjoZ4myJemJRiWA7E4KivsuTbgjvhy
	a66lXDB3coSeli3PwmyXViMWvr2TNbKE6/fbhrJ5jTruPOW/2NivmW+rHD3MxTN4U1e0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcFoj-0006XD-Ra;
	Wed, 24 Jun 2026 05:06:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wcFof-0006Vq-KD
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 05:06:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a0rfoABP8qHsael55vuEKeqreyLhGbch+zU0Femb/yQ=; b=ZnVUlmWMtFBOTvVh5DxZ0ajXPJ
 t9TRCbd4nOMYiHKWlqBTgjhl9OgNIFFJnRIxW2e5G+lzxswZZXwDQY+U3+Iad1VMSOLVPixNx0LUM
 RWC0WV9w4qe7YFNX8ZNUWV0xd/x98MCEp2035rqAsddy/2zW80Ro/hOA+uZ4ZIgpau5A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=a0rfoABP8qHsael55vuEKeqreyLhGbch+zU0Femb/yQ=; b=MieCXEkGYyrysDYoJOs55XnBLa
 l6XhzWF2R9cMMnJ+Q/zXgIQR4HZFgSgn3A9c2SGQFJ004lajS92dRxazaRm4BoUC8IbZ5NgQL9Gnn
 skXk2OOGW6EhZFS2HWufhVBQGz75Uo8kmLWcPZH9NcWrUjf/Lsk9j2T4qC169gBhzCg0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcFoe-0004nj-B4 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 05:06:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C579C601FD;
 Wed, 24 Jun 2026 05:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3071F00ACF;
 Wed, 24 Jun 2026 05:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782277568;
 bh=a0rfoABP8qHsael55vuEKeqreyLhGbch+zU0Femb/yQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GpeCtCKm1+KxA/+JlK/TB2Z9KftZjsAVf6UKvwJoGNGTkbdRyxGyQvA+q5mEwlBrR
 +KRAINLa1FHIF+VDCubrC4hJJuxB+nLDsxT2QMn2MfYIjUMKoBwBqK6MT0eMSEUmaf
 mbaWzwJywGZlnHtONi0zVG60ACMOlo6MPRNy7F0ugzmu0Ob8pbIhfDlUgK76tEjZYI
 RVn34EU1I5JNgpds+MiC35nzS+c+cJx+IkM3668t9c8snK6w9yUer0gvHvjzg8nUR7
 8Y2CtP5MLH9j4fgxpQwti3ZJxERRS987mZTguMVnRLtoSMyMsL3ecuwYSIE3HGiM3C
 umcEkdxPBMV4w==
To: linux-fscrypt@vger.kernel.org
Date: Tue, 23 Jun 2026 22:03:34 -0700
Message-ID: <20260624050334.124606-17-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624050334.124606-1-ebiggers@kernel.org>
References: <20260624050334.124606-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wcFoe-0004nj-B4
Subject: [f2fs-dev] [PATCH 16/16] fscrypt: Add safety checks to
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

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/crypto/crypto.c | 61 +++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 27663f4d8705..c91eda62f9a4 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -103,35 +103,44 @@ static int fscrypt_crypt_data_unit(const struct fscrypt_inode_info *ci,
 				   fscrypt_direction_t rw, u64 index,
 				   struct page *src_page,
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
 		return -EINVAL;
 
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
 			    (rw == FS_DECRYPT ? "De" : "En"), index, err);
 	return err;
@@ -151,11 +160,11 @@ static int fscrypt_crypt_data_unit(const struct fscrypt_inode_info *ci,
  *
  * In the bounce page, the ciphertext data will be located at the same offset at
  * which the plaintext data was located in the source page.  Any other parts of
  * the bounce page will be left uninitialized.
  *
- * This is for use by the filesystem's ->writepages() method.
+ * This is for use by the ->writepages() method of non-block-based filesystems.
  *
  * The bounce page allocation is mempool-backed, so it will always succeed when
  * @gfp_flags includes __GFP_DIRECT_RECLAIM, e.g. when it's GFP_NOFS.  However,
  * only the first page of each bio can be allocated this way.  To prevent
  * deadlocks, for any additional pages a mask like GFP_NOWAIT must be used.
@@ -165,18 +174,24 @@ static int fscrypt_crypt_data_unit(const struct fscrypt_inode_info *ci,
 struct page *fscrypt_encrypt_pagecache_blocks(struct folio *folio,
 		size_t len, size_t offs, gfp_t gfp_flags)
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
 
 	if (WARN_ON_ONCE(len <= 0 || !IS_ALIGNED(len | offs, du_size)))
@@ -213,11 +228,12 @@ EXPORT_SYMBOL(fscrypt_encrypt_pagecache_blocks);
  *
  * Encrypt a possibly-compressed filesystem block that is located in an
  * arbitrary page, not necessarily in the original pagecache page.  The @inode
  * and @lblk_num must be specified, as they can't be determined from @page.
  *
- * This is not compatible with fscrypt_operations::supports_subblock_data_units.
+ * This function only supports non-block-based filesystems that don't support
+ * sub-block data units (as indicated by the fscrypt_operations fields).
  *
  * Return: 0 on success; -errno on failure
  */
 int fscrypt_encrypt_block_inplace(const struct inode *inode, struct page *page,
 				  unsigned int len, unsigned int offs,
@@ -243,11 +259,12 @@ EXPORT_SYMBOL(fscrypt_encrypt_block_inplace);
  *
  * Decrypt a possibly-compressed filesystem block that is located in an
  * arbitrary page, not necessarily in the original pagecache page.  The @inode
  * and @lblk_num must be specified, as they can't be determined from @page.
  *
- * This is not compatible with fscrypt_operations::supports_subblock_data_units.
+ * This function only supports non-block-based filesystems that don't support
+ * sub-block data units (as indicated by the fscrypt_operations fields).
  *
  * Return: 0 on success; -errno on failure
  */
 int fscrypt_decrypt_block_inplace(const struct inode *inode, struct page *page,
 				  unsigned int len, unsigned int offs,
@@ -273,11 +290,11 @@ EXPORT_SYMBOL(fscrypt_decrypt_block_inplace);
 int fscrypt_initialize(struct super_block *sb)
 {
 	mempool_t *pool;
 
 	/* pairs with smp_store_release() below */
-	if (likely(smp_load_acquire(&fscrypt_bounce_page_pool)))
+	if (smp_load_acquire(&fscrypt_bounce_page_pool))
 		return 0;
 
 	/* No need to allocate a bounce page pool if this FS won't use it. */
 	if (!sb->s_cop->needs_bounce_pages)
 		return 0;
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
