Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F89C61DFD
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 21 Feb 2026 20:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h8LjeI4UTFINC+3aA9T9Q/k0Id2Y/C6tX14kCJVnp0o=; b=AA5OgScgH65JToyjOc+kE8jCoN
	dWGnDrum6V+AV9K7ktoYjhgwrnhpVpwssVt/m7ms4eX6mokZVFSqzFcLBDiE/xlOr8rT2EEt6HLot
	mnK/A9UUXZp57c+6IqYKqDdGXxgXXWcnwRxnpyLdnFYwBG0x4KVMFe4CTPDsS3/ywNic=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vttBP-0002lS-B9;
	Sat, 21 Feb 2026 20:02:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vttB5-0002l3-Gn
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 21 Feb 2026 20:02:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dqtqeXWmm52zK+fttbgS+sdRATacSfUr/2xBW8VqtD8=; b=lKwXKA4iWi43iK+yeaiXgdqWUT
 O06E/BiVQr6sBBzhNIK08Kkc6+ARYx2Uxq2FpN6IXnSGb285E5KWQOeZE2Up4RLHW8PYQy6zwDYDI
 dflgFbTqzL0mbn9w6LK7qMXV2aNyrc6ztDCnq16Zc/kX+fywECOo5hzF1Te6hOTZMzfk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dqtqeXWmm52zK+fttbgS+sdRATacSfUr/2xBW8VqtD8=; b=P/h3hyK5RRQcTeI4jjWuFfrjV8
 cs8tqMj17A9G10uQeEwBxg7bAFC2KPW0c29YNny1rOrPrHdm+xE4g/uMRQLY/1yAGuY2loDDwJDky
 KDwUVWJuwLGHonW4Gx5GF6mTEMlWtUOX3fYQuKvg198jYX+JRBOWutHJv3eIk2xsQG3Q=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vtt5J-0003B2-Jc for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 21 Feb 2026 19:56:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 24B754442D;
 Sat, 21 Feb 2026 19:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A524EC4CEF7;
 Sat, 21 Feb 2026 19:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771703768;
 bh=R7/z9C7qpx7IpjmeTzkpHTTwUmtvP03YWgReVTnc/oc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n9ki9g1iZd2fKMZu/SNx0xP47FVGH4dM64Nvb9u3kkIZ4ZaECBGItZFJE0OD3vqFc
 kLT75lsM20kWZ1QfOXSHoMSp/UfxVBiloLPFWewMS7emZ5DcuBzNRJUNsju8gQ1zGL
 4MbTu8L2XlqDo6ELdq34K3bGkWdG1HwIQ+24/s8CBMwntTsSH54RMRmv3zK+96TN74
 Ida4hmcXT7iAlaI+EiwBIO/bvJn+Y5fKmtauovnGzK8QRF5ZSKDXVQTujPP1GDC1Aj
 Y2OkNX/EKRJsXSKfYs94nUhNOUErSp8BpzOSQ/Efde7cOrusfRkAf54gmH9kOo/Ekt
 58VcljSalnk4Q==
Date: Sat, 21 Feb 2026 11:56:05 -0800
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260221195605.GF2536@quark>
References: <20260218061531.3318130-1-hch@lst.de>
 <20260218061531.3318130-9-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260218061531.3318130-9-hch@lst.de>
X-Headers-End: 1vtt5J-0003B2-Jc
Subject: Re: [f2fs-dev] [PATCH 8/9] fscrypt: pass a byte length to
 fscrypt_zeroout_range
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
Cc: Christian Brauner <brauner@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Feb 18, 2026 at 07:14:46AM +0100, Christoph Hellwig wrote:
> Range lengths are usually expressed as bytes in the VFS, switch
> fscrypt_zeroout_range to this convention.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/crypto/bio.c | 6 +++---
>  fs/ext4/inode.c | 3 ++-
>  fs/f2fs/file.c  | 2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> index e41e605cf7e6..cea931620c04 100644
> --- a/fs/crypto/bio.c
> +++ b/fs/crypto/bio.c
> @@ -115,7 +115,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
>   * @inode: the file's inode
>   * @pos: the first file logical offset (in bytes) to zero out
>   * @pblk: the first filesystem physical block to zero out
> - * @len: number of blocks to zero out
> + * @len: bytes to zero out
>   *
>   * Zero out filesystem blocks in an encrypted regular file on-disk, i.e. write
>   * ciphertext blocks which decrypt to the all-zeroes block.  The blocks must be
> @@ -136,7 +136,7 @@ int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,

This should be accompanied by a change in the type of 'len' to u64 or
loff_t, and similarly in fscrypt_zeroout_range_inline_crypt().  It's
unclear that the callers always pass lengths <= U32_MAX bytes,
especially the one in f2fs.

Also, the comment for fscrypt_zeroout_range() should be updated to
mention that pos and len need to be multiples of the filesystem block
size, given that it will no longer be implied by the units.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
