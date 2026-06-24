Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74849CDE002
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S0vZe6hGVn0TUKxboU/p9EYUIZr5IDPyejqwJvrKowM=; b=WqRpBFoPcyZKSokrhrcPT9FTG4
	WisUYdguZHxML/4XQ0Bk+iESG5bAQzkcKEHTZKTbmQlHSSG2aOJBM1S6VSiG7OEBcKJ+wu+sjR4/m
	yKn7P9sf8Yaxpg7JXxA0p/PyOxSvB+I5gnpiCsth71Orksk3v/CSdsIOIUP+46hpMZQw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcFoi-0006th-F7;
	Wed, 24 Jun 2026 05:06:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wcFoY-0006sa-MY
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 05:06:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mn6lr6qCjRwiUrSp6jfp28uOZlKSNZU4XGVuJV9dOYg=; b=iic5QUf0xED7zV6BYW2NG2pk3O
 8M1Qyj+gqDS/28jZcbl13gfK9uq1ALruGBMWBpvM2EGOc35RFf/0Q9QaSVk1woUn04Vuh6wSoZ65W
 d7iNUWq44yzKsv7B8muP6PWNplvHvQPniG5WSULI/GOVxxC8WpvsfzdZRfcERobhKYbA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Mn6lr6qCjRwiUrSp6jfp28uOZlKSNZU4XGVuJV9dOYg=; b=JRxblxmLoxzPlcXpzgrzjE13nA
 dkmGIkM/57nLWPVVJhZcHRxYs57TtAdHDxifOji0zgcSb87wgw0C+msriDOj9rS1S8sAbkzqTxfnw
 O0thhi7+AjOf+g9A+TXZ3el3y6DiVJdj7JBZxBhmr7akoLn1ibacuKdXXRuTPy05NOWM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcFoW-0004mw-B1 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 05:06:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CFA3360211;
 Wed, 24 Jun 2026 05:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E7B1F00A3D;
 Wed, 24 Jun 2026 05:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782277565;
 bh=Mn6lr6qCjRwiUrSp6jfp28uOZlKSNZU4XGVuJV9dOYg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=deOzfmmEUqdYcKN2dPmZMd6/fcExt4/EhjfALy+7ri425ZGTchaHzk4OzqvrqGg+k
 MLuz6EshZhYz7N0KtGl6k1DqvgrSaz4/6uynrxAyuWWdKLM4SHRPw1bnAxiN5fKxmv
 NL0nZUpbGAQ0UIu3HGZswNGC3VU49e3o5sV8Hz/h6PSJ/cGXoYLN134rAwqRsYlgrT
 yqhaAZm45fbskswrhptzFLZRBD6aRaozUR94JWx9e86AaT7gVikJAIr6vyEiUF93kB
 KV26bcPITKbb9NJM5He03oSv+m/obJADyAX3IOqZ9m6A/7EKGSj3PlF4KNEpCnjclk
 4bUJdBA6JHRow==
To: linux-fscrypt@vger.kernel.org
Date: Tue, 23 Jun 2026 22:03:29 -0700
Message-ID: <20260624050334.124606-12-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624050334.124606-1-ebiggers@kernel.org>
References: <20260624050334.124606-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wcFoW-0004mw-B1
Subject: [f2fs-dev] [PATCH 11/16] fscrypt: Replace calls to
 fscrypt_inode_uses_inline_crypto()
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

Now that fscrypt's file contents en/decryption is always implemented
using blk-crypto when the filesystem is block-based, the calls to
fscrypt_inode_uses_inline_crypto() in fs/crypto/inline_crypt.c (which
contains functions that are called only from block-based filesystems)
are equivalent to checking whether the file is an encrypted regular
file, i.e. fscrypt_needs_contents_encryption().  Use that instead.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/crypto/inline_crypt.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index caf706215621..111ea45732f0 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -225,12 +225,12 @@ static void fscrypt_generate_dun(const struct fscrypt_inode_info *ci,
  * @inode: the file's inode
  * @pos: the first file position (in bytes) in the I/O
  * @gfp_mask: memory allocation flags - these must be a waiting mask so that
  *					bio_crypt_set_ctx can't fail.
  *
- * If the contents of the file should be encrypted (or decrypted) with inline
- * encryption, then assign the appropriate encryption context to the bio.
+ * If the contents of the file should be encrypted (or decrypted), then assign
+ * the appropriate encryption context to the bio.
  *
  * Normally the bio should be newly allocated (i.e. no pages added yet), as
  * otherwise fscrypt_mergeable_bio() won't work as intended.
  *
  * The encryption context will be freed automatically when the bio is freed.
@@ -239,11 +239,11 @@ void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
 			       loff_t pos, gfp_t gfp_mask)
 {
 	const struct fscrypt_inode_info *ci;
 	u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
 
-	if (!fscrypt_inode_uses_inline_crypto(inode))
+	if (!fscrypt_needs_contents_encryption(inode))
 		return;
 	ci = fscrypt_get_inode_info_raw(inode);
 
 	fscrypt_generate_dun(ci, pos, dun);
 	bio_crypt_set_ctx(bio, ci->ci_enc_key.blk_key, dun, gfp_mask);
@@ -254,16 +254,16 @@ EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx);
  * fscrypt_mergeable_bio() - test whether data can be added to a bio
  * @bio: the bio being built up
  * @inode: the inode for the next part of the I/O
  * @pos: the next file position (in bytes) in the I/O
  *
- * When building a bio which may contain data which should undergo inline
- * encryption (or decryption) via fscrypt, filesystems should call this function
- * to ensure that the resulting bio contains only contiguous data unit numbers.
- * This will return false if the next part of the I/O cannot be merged with the
- * bio because either the encryption key would be different or the encryption
- * data unit numbers would be discontiguous.
+ * When building a bio which may contain data which should undergo encryption
+ * (or decryption) via fscrypt, filesystems should call this function to ensure
+ * that the resulting bio contains only contiguous data unit numbers.  This will
+ * return false if the next part of the I/O cannot be merged with the bio
+ * because either the encryption key would be different or the encryption data
+ * unit numbers would be discontiguous.
  *
  * fscrypt_set_bio_crypt_ctx() must have already been called on the bio.
  *
  * This function isn't required in cases where crypto-mergeability is ensured in
  * another way, such as I/O targeting only a single file (and thus a single key)
@@ -276,11 +276,11 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 {
 	const struct bio_crypt_ctx *bc = bio->bi_crypt_context;
 	const struct fscrypt_inode_info *ci;
 	u64 next_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
 
-	if (!!bc != fscrypt_inode_uses_inline_crypto(inode))
+	if (!!bc != fscrypt_needs_contents_encryption(inode))
 		return false;
 	if (!bc)
 		return true;
 	ci = fscrypt_get_inode_info_raw(inode);
 
@@ -334,11 +334,11 @@ bool fscrypt_dio_supported(struct inode *inode)
 		 * Key unavailable or couldn't be set up.  This edge case isn't
 		 * worth worrying about; just report that DIO is unsupported.
 		 */
 		return false;
 	}
-	return fscrypt_inode_uses_inline_crypto(inode);
+	return true;
 }
 EXPORT_SYMBOL_GPL(fscrypt_dio_supported);
 
 /**
  * fscrypt_limit_io_blocks() - limit I/O blocks to avoid discontiguous DUNs
@@ -363,11 +363,11 @@ EXPORT_SYMBOL_GPL(fscrypt_dio_supported);
 u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk, u64 nr_blocks)
 {
 	const struct fscrypt_inode_info *ci;
 	u32 dun;
 
-	if (!fscrypt_inode_uses_inline_crypto(inode))
+	if (!fscrypt_needs_contents_encryption(inode))
 		return nr_blocks;
 
 	if (nr_blocks <= 1)
 		return nr_blocks;
 
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
