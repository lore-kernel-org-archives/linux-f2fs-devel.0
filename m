Return-Path: <SRS0=yNny=5L=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A64C43331
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Mar 2020 05:45:51 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553622070A;
	Thu, 26 Mar 2020 05:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="JfTPZcsv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="LUXuNPSE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPY4OHuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553622070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jHLKw-0000we-Tg; Thu, 26 Mar 2020 05:45:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jHLKw-0000wS-1W
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Mar 2020 05:45:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0o2EW1p2fiZ+RlIPmhS7SC8yN3uPT1nYq4wTd0lsavg=; b=JfTPZcsvtP+E6+ElDrswT8qQZf
 lcSvTsHGAOpN+gD5/1bOQ9wd2fz41CuiPepTytfbIh6IdjtbtHwrIHDDdHjOjq3N3gbMldPlxt/Ee
 Am44xcKCT83LTV6N+rp2pcK7S3cEI8ukrROhXahXSAnPo4xXjk0Qrgrbwoo6ULbIwd1s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0o2EW1p2fiZ+RlIPmhS7SC8yN3uPT1nYq4wTd0lsavg=; b=LUXuNPSEDjXe/neKFddaF9U9ip
 sXg5FpGP0RKLFK5HyL1mHrfkeDrAZ2LiHvV/2SatIdDUtSTZzv7psWrX9kNFS7q1cf5hf8ZrZ1zc+
 TIF7353XWmlkQCCP0sy8917JkugFteN383urWnQg4+RvVG8mWFx4tCNEgovoBGYUw4dQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jHLKq-007qP4-4r
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Mar 2020 05:45:49 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3BD722070A;
 Thu, 26 Mar 2020 05:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585201538;
 bh=YSqEiV8Q0V/gweaU5BWxLVtMdrabOmhnkS6bhf78yJk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RPY4OHuDLW8zJQHKTlA+e6EKMRnhN4YdbX1yCtrF70JzGjUeavucVWe5Z66JFcmcf
 IG/D2dv9WHdysNOPX0U9tTAu5sced/R0W0jXjk8eSoodeyTQSTpn2MBQ3MM6bJ+5ZQ
 9pOAVQflwj7dde/PKK4vYjBZ+2dULFF5I7aYdVrE=
Date: Wed, 25 Mar 2020 22:45:36 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20200326054536.GD858@sol.localdomain>
References: <20200326030702.223233-1-satyat@google.com>
 <20200326030702.223233-10-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200326030702.223233-10-satyat@google.com>
X-Headers-End: 1jHLKq-007qP4-4r
Subject: Re: [f2fs-dev] [PATCH v9 09/11] fscrypt: add inline encryption
 support
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
Cc: linux-scsi@vger.kernel.org, Kim Boojin <boojin.kim@samsung.com>,
 Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Mar 25, 2020 at 08:07:00PM -0700, Satya Tangirala wrote:
> +/* Enable inline encryption for this file if supported. */
> +void fscrypt_select_encryption_impl(struct fscrypt_info *ci)
> +{
> +	const struct inode *inode = ci->ci_inode;
> +	struct super_block *sb = inode->i_sb;
> +
> +	/* The file must need contents encryption, not filenames encryption */
> +	if (!fscrypt_needs_contents_encryption(inode))
> +		return;
> +
> +	/* blk-crypto must implement the needed encryption algorithm */
> +	if (ci->ci_mode->blk_crypto_mode == BLK_ENCRYPTION_MODE_INVALID)
> +		return;
> +
> +	/* The filesystem must be mounted with -o inlinecrypt */
> +	if (!(sb->s_flags & SB_INLINECRYPT))
> +		return;
> +
> +	ci->ci_inlinecrypt = true;
> +}

A bug I came across last week when writing a new test is that '-o inlinecrypt'
can break some fscrypt settings because it enables blk-crypto even when
CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is unset and the hardware doesn't support
the algorithm.  For example, adding '-o inlinecrypt' can make Adiantum-encrypted
files stop working, due to the hardware only supporting AES-XTS.

That's undesirable.  Adding '-o inlinecrypt' should just make inline encryption
be used where it can, and not break anything.

To fix this, we should make fscrypt_select_encryption_impl() only set
->ci_inlinecrypt if either blk-crypto-fallback is enabled or if all the
filesystem's devices support the algorithm.

In v7+ of this patchset, this is a bit tricky because now
blk_ksm_crypto_key_supported() takes in a 'struct blk_crypto_key', which
fscrypt_select_encryption_impl() doesn't have available yet.  Perhaps make
blk_ksm_crypto_key_supported() a wrapper around a function like
blk_ksm_crypto_setting_supported() that takes a new struct:

	struct blk_crypto_setting {
	        enum blk_crypto_mode_num crypto_mode;
		unsigned int data_unit_size;
		unsigned int dun_bytes;
	};

Then maybe add blk_crypto_setting_supported() which returns true if either
blk_ksm_crypto_key_supported() *or* blk-crypto-fallback is enabled.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
