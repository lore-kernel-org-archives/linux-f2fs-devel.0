Return-Path: <SRS0=zfsZ=AK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB380C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jun 2020 18:23:05 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD677255C9;
	Mon, 29 Jun 2020 18:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="C2QI6ZsC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="hVedusKu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2WxZRsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD677255C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jpyQq-0000oa-ON; Mon, 29 Jun 2020 18:23:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jpyQq-0000oS-2p
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jun 2020 18:23:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JKkwG4X+bM+CrXtxwhsWt9CBs75yO/YVDrciqiniJZs=; b=C2QI6ZsCeBXtfc/AjSiAeN2Ksy
 3YNaN3m/+G6hJ0GFzuzV96tpybL20A1omnDqi5Uvpm8dMZbu+6VA3oO70zyYbi39U5+Ao2ua7AHxt
 xF+f2CIYZDv5G0Ni5n3C77+08TXd7HG1XVWghBLdV/lLDyeGMaVYJqHgGvLE8W9EJeFw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JKkwG4X+bM+CrXtxwhsWt9CBs75yO/YVDrciqiniJZs=; b=hVedusKumCSO3GeQjHufWTdery
 vMKE0yyf/QNlg+HoJRbMCfyjh1wbd/ieHkH6+kH6E4A8+fM/OFid4IJtvOePYAyZBSq5rCZy6ZuOB
 cJXG25AGzofWfR3K8RCTn1koNKY49KgsamMH28SVm7IHg3f0hNk2kDcUbiO6Vba4KbXo=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jpyQo-002IKX-Ns
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jun 2020 18:23:04 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 16B2A255BA;
 Mon, 29 Jun 2020 18:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593454972;
 bh=Y7LpjQLfAxhqBzjm0yYAEkclb4h+QWTLcv+9I/39AOQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f2WxZRsr3ztXYnZzBr4mn4P+cVb5g5ZFjuVs6Q7CP9OHMSAstoPLftkfQGr7XYarS
 gRb9BsrxNCmYy773wNWZK69W9ONwYM5OkVOGzd56ZWIrqYKwAflXXkTPrzKgK3PTCd
 Z5aGgScPalZ5l1nSTCvh0rTphGGTlBxpvGf0MhSc=
Date: Mon, 29 Jun 2020 11:22:50 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20200629182250.GD20492@sol.localdomain>
References: <20200629120405.701023-1-satyat@google.com>
 <20200629120405.701023-3-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200629120405.701023-3-satyat@google.com>
X-Headers-End: 1jpyQo-002IKX-Ns
Subject: Re: [f2fs-dev] [PATCH v2 2/4] fscrypt: add inline encryption support
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
Cc: linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jun 29, 2020 at 12:04:03PM +0000, Satya Tangirala via Linux-f2fs-devel wrote:
> diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> index 4fa18fff9c4e..1ea9369a7688 100644
> --- a/fs/crypto/bio.c
> +++ b/fs/crypto/bio.c
> @@ -41,6 +41,52 @@ void fscrypt_decrypt_bio(struct bio *bio)
>  }
>  EXPORT_SYMBOL(fscrypt_decrypt_bio);
>  
> +static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
> +					      pgoff_t lblk, sector_t pblk,
> +					      unsigned int len)
> +{
> +	const unsigned int blockbits = inode->i_blkbits;
> +	const unsigned int blocks_per_page = 1 << (PAGE_SHIFT - blockbits);
> +	struct bio *bio;
> +	int ret, err = 0;
> +	int num_pages = 0;
> +
> +	/* This always succeeds since __GFP_DIRECT_RECLAIM is set. */
> +	bio = bio_alloc(GFP_NOFS, BIO_MAX_PAGES);
> +
> +	while (len) {
> +		unsigned int blocks_this_page = min(len, blocks_per_page);
> +		unsigned int bytes_this_page = blocks_this_page << blockbits;
> +
> +		if (num_pages == 0) {
> +			fscrypt_set_bio_crypt_ctx(bio, inode, lblk, GFP_NOFS);
> +			bio_set_dev(bio, inode->i_sb->s_bdev);
> +			bio->bi_iter.bi_sector =
> +					pblk << (blockbits - SECTOR_SHIFT);
> +			bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> +		}
> +		ret = bio_add_page(bio, ZERO_PAGE(0), bytes_this_page, 0);
> +		if (WARN_ON(ret != bytes_this_page)) {
> +			err = -EIO;
> +			goto out;
> +		}
> +		num_pages++;
> +		len -= blocks_this_page;
> +		lblk += blocks_this_page;
> +		pblk += blocks_this_page;
> +		if (num_pages == BIO_MAX_PAGES || !len) {
> +			err = submit_bio_wait(bio);
> +			if (err)
> +				goto out;
> +			bio_reset(bio);
> +			num_pages = 0;
> +		}
> +	}
> +out:
> +	bio_put(bio);
> +	return err;
> +}

I just realized we missed something.

With the new IV_INO_LBLK_32 IV generation strategy, logically contiguous blocks
don't necessarily have contiguous IVs.

So we need to check fscrypt_mergeable_bio() here.

Also it *should* be checked once per block, not once per page.  However, that
means that ext4_mpage_readpages() and f2fs_mpage_readpages() are wrong too,
since they only check fscrypt_mergeable_bio() once per page.

Given that difficulty, and the fact that IV_INO_LBLK_32 only has limited use
cases on specific hardware, I suggest that for now we simply restrict inline
encryption with IV_INO_LBLK_32 to the blocksize == PAGE_SIZE case.

(Checking fscrypt_mergeable_bio() once per page is still needed.)

I.e., on top of this patch:

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 1ea9369a7688..b048a0e38516 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -74,7 +74,8 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 		len -= blocks_this_page;
 		lblk += blocks_this_page;
 		pblk += blocks_this_page;
-		if (num_pages == BIO_MAX_PAGES || !len) {
+		if (num_pages == BIO_MAX_PAGES || !len ||
+		    !fscrypt_mergeable_bio(bio, inode, lblk)) {
 			err = submit_bio_wait(bio);
 			if (err)
 				goto out;
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index ec514bc8ee86..097c5a565a21 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -84,6 +84,19 @@ int fscrypt_select_encryption_impl(struct fscrypt_info *ci)
 	if (!(sb->s_flags & SB_INLINECRYPT))
 		return 0;
 
+	/*
+	 * When a page contains multiple logically contiguous filesystem blocks,
+	 * some filesystem code only calls fscrypt_mergeable_bio() for the first
+	 * block in the page.  This is fine for most of fscrypt's IV generation
+	 * strategies, where contiguous blocks imply contiguous IVs.  But it
+	 * doesn't work with IV_INO_LBLK_32.  For now, simply exclude
+	 * IV_INO_LBLK_32 with blocksize != PAGE_SIZE from inline encryption.
+	 */
+	if ((fscrypt_policy_flags(&ci->ci_policy) &
+	     FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32) &&
+	    sb->s_blocksize != PAGE_SIZE)
+		return 0;
+


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
