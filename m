Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C345FEC11F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H/3rv6jlmBH88aNmPnrCUcpzUk0FWeHFi9z2R/xlg80=; b=c21jZ3NFSWFUJhhiJHDzxUOuae
	bsgIhGFByKGPONtRLXqcQubpJwcS6Dtotvwd8cqOfpas6yPYdJ63aVMcs9a+WmtsGPdT40DNN5AHz
	wcqRfBkNAe0a4OPoR4SkDUvirLuRU9m8gHedsYB/J5E6UsNd1bDtZ1Yl2ID1elawqRqI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w5R7R-000522-ET;
	Wed, 25 Mar 2026 16:30:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1w5R78-00050x-9t
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 16:29:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zcHOs+kqpAMXLaPAu/3/tvO1Yj86VyjsTo/qRX3t/b4=; b=m6XuhmN6dSnzQcNqfcjCYF7dpF
 j4oUYwMryskDhvh+QjW4rqoqYCfMy5l4IlW81TRVRE7D00/gW1cNIXmZkG2TrjBJ6uxf0pS/JuNBE
 vRRaDVJowK3lz0qxlw988BAmQrplAOuDUsi1HhNsYjlRI0ajORIfQeqTUrgiRsEZFusM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zcHOs+kqpAMXLaPAu/3/tvO1Yj86VyjsTo/qRX3t/b4=; b=ZepymKfLe81nFBSWfijnCQZ/HL
 EHIW355UTA+vcI3kuAOn+/HQhRpU9hn6//wFEoweEV9bCRClxgGVyqe33QIb3sQeomLPLcShF0Pwl
 J8ppAT0/Zan9u7ZVJdszMKo1Crv/MoH/IgFaKCdmLCvGtJVQF3l4hmul+IVmSxjWQ//k=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w5R77-00064c-No for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 16:29:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5F55F440E1;
 Wed, 25 Mar 2026 16:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C85EC19423;
 Wed, 25 Mar 2026 16:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774456184;
 bh=n2gRWPCdrqEgD1r99jloHoyKEK1RWoOWxovpSSliabY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jRW8E5mS6J4EcMYEQr+bOsYTBewNb/a/XEOSvoeUK+BcjkBUTALNKJvYAhH9m1hmy
 y2XhkiI334saOIwU0QEv0tNnI9cee2HQUBLyTYa8zZhhmUSVRGG/4tVnfaKqhRsmsD
 fn3YGiAg43LeBruHIB5MKoFIuWT4yeujFECdfvfurLFHCXrnq5YlzKQS0IRSGPg/iH
 STDgmiMByFcawnk+ZHVvhuGfnrtmrqCpRLvHQpZu9HgnHnOD+rT+Xpnz7wSdw+Hgz0
 QZneJz8p1vYSEVtLpAmhGUVAvZTX2t4OIdVi8f4a6X0tu3kXDGjsopMgyupkFe1iNw
 9x+HPGlpHz32Q==
Date: Wed, 25 Mar 2026 09:29:43 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260325162943.GW6223@frogsfrogsfrogs>
References: <20260319170231.1455553-1-aalbersh@kernel.org>
 <20260319170231.1455553-11-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260319170231.1455553-11-aalbersh@kernel.org>
X-Headers-End: 1w5R77-00064c-No
Subject: Re: [f2fs-dev] [PATCH v5 10/25] iomap: teach iomap to handle
 fsverity holes and verify data holes
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

On Thu, Mar 19, 2026 at 06:01:57PM +0100, Andrey Albershteyn wrote:
> fsverity metadata has two kinds of holes - ones in merkle tree and one
> after fsverity descriptor.
> 
> Merkle tree holes are blocks full of hashes of zeroed data blocks. These
> are not stored on the disk but synthesized on the fly. This saves a bit
> of space for sparse files. Due to this iomap also need to lookup
> fsverity_info for folios with fsverity metadata. ->vi has a hash of the
> zeroed data block which will be used to fill the merkle tree block. This
> patch extends lookup of fsverity_info from just for file data but also
> for all fsverity metadata.
> 
> The hole past descriptor is interpreted as end of metadata region. As we
> don't have EOF here we use this hole as an indication that rest of the
> folio is empty. This patch marks rest of the folio beyond fsverity
> descriptor as uptodate.
> 
> For file data, fsverity needs to verify consistency of the whole file
> against the root hash, hashes of holes are included in the merkle tree.
> Verify them too.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/iomap/buffered-io.c | 40 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index a11e54975df8..fce748dfb2cf 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -551,9 +551,27 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>  		if (plen == 0)
>  			return 0;
>  
> -		/* zero post-eof blocks as the page may be mapped */
> -		if (iomap_block_needs_zeroing(iter, pos)) {
> +		/*
> +		 * Handling of fsverity "holes". We hit this for two case:
> +		 *   1. No need to go further, the hole after fsverity
> +		 *	descriptor is the end of the fsverity metadata.
> +		 *
> +		 *   2. This folio contains merkle tree blocks which need to be
> +		 *	synthesized. If we already have fsverity info (ctx->vi)
> +		 *	synthesize these blocks.
> +		 */
> +		if ((iomap->flags & IOMAP_F_FSVERITY) &&
> +		    iomap->type == IOMAP_HOLE) {
> +			if (ctx->vi)
> +				fsverity_folio_zero_hash(folio, poff, plen,
> +							 ctx->vi);

Let me nitpick one more time... should this ^^ function be named
fsverify_fill_zerohash, since it fills the folio with a repeating
pattern of the hash of a zeroed block?

(I'm nitpicking because zero is a noun and a verb)

Otherwise the logic looks fine to me, and like hch says this probably
ought to be rolled into patch 8.

--D

> +			iomap_set_range_uptodate(folio, poff, plen);
> +		} else if (iomap_block_needs_zeroing(iter, pos)) {
> +			/* zero post-eof blocks as the page may be mapped */
>  			folio_zero_range(folio, poff, plen);
> +			if (ctx->vi &&
> +			    !fsverity_verify_blocks(ctx->vi, folio, plen, poff))
> +				return -EIO;
>  			iomap_set_range_uptodate(folio, poff, plen);
>  		} else {
>  			if (!*bytes_submitted)
> @@ -600,9 +618,12 @@ void iomap_read_folio(const struct iomap_ops *ops,
>  
>  	trace_iomap_readpage(iter.inode, 1);
>  
> -	if (iter.pos < i_size_read(iter.inode))
> -		ctx->vi = fsverity_get_info(iter.inode);
> -	if (ctx->vi)
> +	/*
> +	 * Fetch fsverity_info for both data and fsverity metadata, as iomap
> +	 * needs zeroed hash for merkle tree block synthesis
> +	 */
> +	ctx->vi = fsverity_get_info(iter.inode);
> +	if (ctx->vi && iter.pos < i_size_read(iter.inode))
>  		fsverity_readahead(ctx->vi, folio->index,
>  				   folio_nr_pages(folio));
>  
> @@ -673,9 +694,12 @@ void iomap_readahead(const struct iomap_ops *ops,
>  
>  	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
>  
> -	if (iter.pos < i_size_read(iter.inode))
> -		ctx->vi = fsverity_get_info(iter.inode);
> -	if (ctx->vi)
> +	/*
> +	 * Fetch fsverity_info for both data and fsverity metadata, as iomap
> +	 * needs zeroed hash for merkle tree block synthesis
> +	 */
> +	ctx->vi = fsverity_get_info(iter.inode);
> +	if (ctx->vi && iter.pos < i_size_read(iter.inode))
>  		fsverity_readahead(ctx->vi, readahead_index(rac),
>  				readahead_count(rac));
>  
> -- 
> 2.51.2
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
