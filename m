Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68733C61DEB
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 21 Feb 2026 20:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V8dj4DP+6hTnPaCpGrW4EouB/+qFnYKkxOt1xx59+R8=; b=aIp2hml3tULF9/WxD6KqJZ6aV+
	Tr29OqehZGGyJnA/pNAbvGux/8EknQukjhmPVgivpaaxk1PLnSYqz9DRANZjGTWpA12CjJqhpthM+
	y6CrDBDu8CBE9D6naS4ZFN3UeoV83MPyjTfyluWRqJnvgD5Q4BlJHu1uTcKkxum4v1dQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vttBO-0005wq-0k;
	Sat, 21 Feb 2026 20:02:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vttB5-0005uz-0K
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 21 Feb 2026 20:02:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jiEOuJqnSLJuN4QxZKAQZ7nwPl5035Ck/wEiCECCbPE=; b=mfsvxj28rN7M1GEf+6f7m6W2w8
 KITNkctkBgfmrlJ9seOwlHLP3cxpoGIA5u8vFWR2WPNwpKzPEbTDJQCR1kjCwxZxvd8QqJs5qY3al
 pNnDyjDlZMgFrmk2pp6Wk8pbA7YSVMjo8LoBrqNm5wZVpurPLYw4yVSa8KODv2ihcsTY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jiEOuJqnSLJuN4QxZKAQZ7nwPl5035Ck/wEiCECCbPE=; b=J6YRl5Jnhh5ix3T8l5JJJti1ox
 lQuZZhXfFbumRid5i7SnvrUTL8/W+iFANfIY2J3i6o8YbXYg3O7nZSY7nMEh6WsgqanJ6aDF296EW
 hrY6ttEdJ5niLo4PSSf6eV0MRL4Yveu7dXFKOugpMYd4060+ekvqnEvo29RWoXUlru1w=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vtsyy-0002ze-Ki for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 21 Feb 2026 19:49:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3EDA3443C7;
 Sat, 21 Feb 2026 19:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C835FC4CEF7;
 Sat, 21 Feb 2026 19:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771703370;
 bh=Y6CakBup81NzTHNSAM8tNOwbYIAPWvfjsed/7M38DSo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c8RKHW3v646t0sP75rq0a6ORsgJc2TtU6IdLNp05j+GKNcxcOOOaOLy1FcWYGZeG7
 BmePywNnr0OAmdZfLZ+XsofQytwbivdBcOT8yDiiQwsSLS+/QnHLKjsudU5OKQxtBu
 FaSTYr69Iqi5W0kHpjcwgc/iXxgLnmG1D4Eld1qhXPceHcdfKkcamHzKWWAtinK38u
 HV4if1HmF3+cjMBXvGRjMew23/PKXEBcU7/7skxPh6Lj53bvsGXyJ/0Ujre2WL8DtG
 +Zlxc2wwIiWmQ+txYhSOz3oXZ8kAVgTjWVk8VinEp7BhTatcBNoyL76jM/4AqqH9Cg
 qdF+dIv5VUnRQ==
Date: Sat, 21 Feb 2026 11:49:22 -0800
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260221194922.GE2536@quark>
References: <20260218061531.3318130-1-hch@lst.de>
 <20260218061531.3318130-8-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260218061531.3318130-8-hch@lst.de>
X-Headers-End: 1vtsyy-0002ze-Ki
Subject: Re: [f2fs-dev] [PATCH 7/9] fscrypt: pass a byte offset to
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

On Wed, Feb 18, 2026 at 07:14:45AM +0100, Christoph Hellwig wrote:
> Logical offsets into an inode are usually expresssed as bytes in the VFS.
> Switch fscrypt_zeroout_range to that convention.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/crypto/bio.c         | 6 +++---
>  fs/ext4/inode.c         | 3 ++-
>  fs/f2fs/file.c          | 4 +++-
>  include/linux/fscrypt.h | 4 ++--
>  4 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> index 36025ce7a264..e41e605cf7e6 100644
> --- a/fs/crypto/bio.c
> +++ b/fs/crypto/bio.c
> @@ -113,7 +113,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
>  /**
>   * fscrypt_zeroout_range() - zero out a range of blocks in an encrypted file
>   * @inode: the file's inode
> - * @lblk: the first file logical block to zero out
> + * @pos: the first file logical offset (in bytes) to zero out
>   * @pblk: the first filesystem physical block to zero out
>   * @len: number of blocks to zero out
>   *
> @@ -127,7 +127,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
>   *
>   * Return: 0 on success; -errno on failure.
>   */
> -int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
> +int fscrypt_zeroout_range(const struct inode *inode, loff_t pos,
>  			  sector_t pblk, unsigned int len)
>  {
>  	const struct fscrypt_inode_info *ci = fscrypt_get_inode_info_raw(inode);
> @@ -135,7 +135,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
>  	const unsigned int du_size = 1U << du_bits;
>  	const unsigned int du_per_page_bits = PAGE_SHIFT - du_bits;
>  	const unsigned int du_per_page = 1U << du_per_page_bits;
> -	u64 du_index = (u64)lblk << (inode->i_blkbits - du_bits);
> +	u64 du_index = pos >> du_bits;
>  	u64 du_remaining = (u64)len << (inode->i_blkbits - du_bits);
>  	loff_t pos = (loff_t)lblk << inode->i_blkbits;

This is a bisection hazard because the 'pos' local variable isn't
removed until a later patch.  It needs to be removed in this patch.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
