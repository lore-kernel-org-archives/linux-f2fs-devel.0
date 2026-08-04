Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8074EC55184
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 18:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m36OUwogK5ES+iJB/r5IscmcrwcvvLs6FAr1nkaap1E=; b=ADcC6wnsZsbXKQI3d9TRr35Uqg
	rVFfMmXUUMjSQyafk5R51AJLEPVVS5axiynYB0PrTWbh7WWavTTCD8yCXWyzhLBbuf8gUG+k2b7G1
	fgVsLV4860zZjktfIsN4JZpd8wpWj8CiEb5t7hpk6qb5tg8A6bnD/DHKAOu7l1jeqS/E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrJSD-0003EO-1n;
	Tue, 04 Aug 2026 18:01:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wrJSB-0003EH-CK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 18:01:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RSCZdlfHoN3MNNuFMvr7QIlKkJ47f+bwICwB/uhDA4Y=; b=U8idQRM5vTz4vk2mI3x/9h1iYr
 RvXJWmXfUSAdyLTVZKzgqWxg4SAF/LwE1wXij14mxcz7arVrew+nDuf93tgZrZphI0Dvi6jPaa4uU
 xbl5aNtmnSRiYTKDhUdieIP7wjEeGVaf9DRn14KqFmq0SU3/Mpz14VuvdDqXrw7eC/fU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RSCZdlfHoN3MNNuFMvr7QIlKkJ47f+bwICwB/uhDA4Y=; b=f4cGoDDtDX26tHifwne87c7UCz
 JtWMoJNtYjA5iUev/12o5PcmgxyrBztgC2CM+FCQVd2vVd0oBmd2RD4pRIWsBwGK33b9y5s0cEQUf
 pQQgozrv5rFIQKyYStuO/YVfvU8NxcWZlLoXay8zQ1w/GYHMvpr/nEDnwope+EBJTST4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrJSD-0008UD-FN for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 18:01:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with UTF8SMTP id 7F0B44337C;
 Tue,  4 Aug 2026 18:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 549B71F000E9;
 Tue,  4 Aug 2026 18:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785866480;
 bh=RSCZdlfHoN3MNNuFMvr7QIlKkJ47f+bwICwB/uhDA4Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nPfLkZ4uC1++e501adfyJeG5XBlMkJCQJrbKrS23H9Mjw345JgvBtH6qU3al983b7
 Ethpm/m0+i9ddrwk/suuKrr1w54NrTCGTZuK0n1x2zemEqczgexKrTGp1KpHMRy/IY
 q4PMEa7clRn3ObuGZ1v0bNSxl4MXSWVW+j8cQSg8XUl55tPBsoRtx5tFZLUChR0lsB
 uEGgbK/BslSqTxu/Z0hPy0cn4f6eNbjiTKSLWFXgbbfWGq5RMHIFuFxJLdXm0WNBRl
 mWvDPFJw+ghJuVPnaKObQCenvV/8BLnSxIu3cQkzoBMECywmXCsbbdaF1FnFQw/io2
 D/9zxSMt8KuTg==
Date: Tue, 4 Aug 2026 11:01:19 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260804180119.GJ3556460@frogsfrogsfrogs>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-6-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260803200820.393203-6-aalbersh@kernel.org>
X-Headers-End: 1wrJSD-0008UD-FN
Subject: Re: [f2fs-dev] [PATCH v14 05/21] fsverity: improve flushing
 performance of fsverity_fill_zerohash
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Aug 03, 2026 at 10:07:55PM +0200, Andrey Albershteyn wrote:
> The current version calls flush_dcache_folio(), in memcpy_to_folio(), to
> flush whole folio on every digest (which is 128 for 4k) on the HIGHMEM
> systems. Open code folio mapping and flushing to copy all digests at
> once.

Do we really have to care about HIGHMEM performance?  I thought that
was going soon anyway[1].  The code change *looks* reasonable but ugh
it adds more complexity and how many 32-bit phones and servers are
there?

(For Andrey: Why is this bolted onto an XFS patchset?  Nobody
should run XFS on 32-bit at all these days.)

--D

[1] https://lwn.net/Articles/1051010/

> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Link: https://lore.kernel.org/linux-fsdevel/20260401222717.GH2466@quark/
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/verity/pagecache.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
> index 9d82e6b74ba1..911207dc0ef7 100644
> --- a/fs/verity/pagecache.c
> +++ b/fs/verity/pagecache.c
> @@ -68,14 +68,38 @@ EXPORT_SYMBOL_GPL(generic_readahead_merkle_tree);
>  void fsverity_fill_zerohash(struct folio *folio, size_t offset, size_t len,
>  			      struct fsverity_info *vi)
>  {
> -	size_t off = offset;
> +	size_t off;
>  
>  	WARN_ON_ONCE(!IS_ALIGNED(offset, vi->tree_params.digest_size));
>  	WARN_ON_ONCE(!IS_ALIGNED(len, vi->tree_params.digest_size));
> +#ifdef CONFIG_HIGHMEM
> +	WARN_ON_ONCE(offset + len > folio_size(folio));
>  
> -	for (; off < (offset + len); off += vi->tree_params.digest_size)
> +	do {
> +		void *vaddr = kmap_local_folio(folio, offset);
> +		void *to = vaddr;
> +
> +		off = len;
> +
> +		if (folio_test_partial_kmap(folio) &&
> +		    off > PAGE_SIZE - offset_in_page(offset))
> +			off = PAGE_SIZE - offset_in_page(offset);
> +		for (; to < (vaddr + off); to += vi->tree_params.digest_size)
> +			memcpy(to, vi->tree_params.zero_digest,
> +				vi->tree_params.digest_size);
> +		kunmap_local(vaddr);
> +
> +		offset += off;
> +		len -= off;
> +	} while (len > 0);
> +
> +	flush_dcache_folio(folio);
> +#else
> +	for (off = offset; off < (offset + len);
> +			off += vi->tree_params.digest_size)
>  		memcpy_to_folio(folio, off, vi->tree_params.zero_digest,
>  				vi->tree_params.digest_size);
> +#endif
>  }
>  EXPORT_SYMBOL_GPL(fsverity_fill_zerohash);
>  
> -- 
> 2.54.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
