Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAEF10F930A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Mar 2026 23:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X9k9Qztdo5ZXrI/bgZKNUxSK3w3hCVKwAIUhilEppPg=; b=QGaZQoKPLxk/tuNweDo2wsqQBz
	78+n/kSIMb8Rqw+kEr8BaPvJU2StkkaGq7aRINdupk/MmyCnb/pisPnkd3iWDbqyjNM3LHNNQ0OXN
	oS9V928OgpafF3fYDWXVrPPUel3ZMMCK+lH2AVK/EDpcsWHFD6ckSX+H6qiKJ4tSivDc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w7iXi-0003PD-Qy;
	Tue, 31 Mar 2026 23:30:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1w7iXJ-0003Oo-2G
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Mar 2026 23:30:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z+9wvIkim6D+16GlswcjrmUtrVA95W3uukjNWN8x6Eo=; b=WFGaWcVOl/VQwwHK0NeZ9kDLrN
 wHFJ2jP57/cV+Jf2LLIK09EOKXxGaXLrXhuRV6fsmjHPnrpRAS7LYGS9RpgbnMMZ6usg1CA87TBfU
 FkQvK43T/l2w4uc269tjdtBiPABEb51XVV3DxwsEjJS6j5gZBtan1ncxKVMR8aYikJo0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=z+9wvIkim6D+16GlswcjrmUtrVA95W3uukjNWN8x6Eo=; b=YFd560rz6bH6sMssOxogPjxmIT
 tvbkQdf9xYH3gxTYw9rOuZTMzlKGyOoaZQkSTbQOVeDU9Ar2zofi44XGGuD6BN/Hf/FCcE6f60qRd
 f6EWqoWg87f5bBJZ8y1gcRUDZ9OQjtmZ84ZQT75+dS16V+R9uhnjKAbqPajavn1Cdhnc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w7iXI-0003GU-EB for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Mar 2026 23:30:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 20F5F40AA1;
 Tue, 31 Mar 2026 23:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BB9C19423;
 Tue, 31 Mar 2026 23:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774999811;
 bh=+V+WyUJsdAZxd0YciQPR+it333OzvBwbowGJoai7S4k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WULeSppid+u1WerQstzL2likh5hbtxCNamutWd//2mKCXde2RZ7tIa7xvV5WOYlJB
 OEsXKxwmeGDFhpLMkoyW2cdhKZFble51qaioEIdIIkfZAXkbsoaiZYuIXZs4ZW1Acd
 ggTiQLnRxVVZC6hbqGhKNrc8761o6GLomwnByoZAImKXMfy/TqQMLJSFq/9U2By8Vg
 FnAzzrKZ+mCLf2J+dcKvdT47q72nYfipoCVT0XeYA9KXVTbUfWd4WMvQfcqFrHMmED
 7ZKmhGYrbu0klNdeWH5gJ/rjDr5KPYbySC6ukOS87ezckhksEf86xGvfenHKXSOi5J
 0rU6Lr/nYh4rg==
Date: Tue, 31 Mar 2026 16:30:10 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260331233010.GF6223@frogsfrogsfrogs>
References: <20260331212827.2631020-1-aalbersh@kernel.org>
 <20260331212827.2631020-8-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260331212827.2631020-8-aalbersh@kernel.org>
X-Headers-End: 1w7iXI-0003GU-EB
Subject: Re: [f2fs-dev] [PATCH v6 07/22] iomap: teach iomap to read files
 with fsverity
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

On Tue, Mar 31, 2026 at 11:28:08PM +0200, Andrey Albershteyn wrote:
> Obtain fsverity info for folios with file data and fsverity metadata.
> Filesystem can pass vi down to ioend and then to fsverity for
> verification. This is different from other filesystems ext4, f2fs, btrfs
> supporting fsverity, these filesystems don't need fsverity_info for
> reading fsverity metadata. While reading merkle tree iomap requires
> fsverity info to synthesize hashes for zeroed data block.
> 
> fsverity metadata has two kinds of holes - ones in merkle tree and one
> after fsverity descriptor.
> 
> Merkle tree holes are blocks full of hashes of zeroed data blocks. These
> are not stored on the disk but synthesized on the fly. This saves a bit
> of space for sparse files. Due to this iomap also need to lookup
> fsverity_info for folios with fsverity metadata. ->vi has a hash of the
> zeroed data block which will be used to fill the merkle tree block.
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
> Issue reading of fsverity merkle tree on the fsverity inodes. This way
> metadata will be available at I/O completion time.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Still looks fine, thanks for reducing the patch count :)
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  include/linux/iomap.h  |  2 ++
>  2 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index a80fcb598cc8..7ac319618f8e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -9,6 +9,7 @@
>  #include <linux/swap.h>
>  #include <linux/migrate.h>
>  #include <linux/fserror.h>
> +#include <linux/fsverity.h>
>  #include "internal.h"
>  #include "trace.h"
>  
> @@ -561,9 +562,27 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
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
> +				fsverity_fill_zerohash(folio, poff, plen,
> +						       ctx->vi);
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
> @@ -614,6 +633,15 @@ void iomap_read_folio(const struct iomap_ops *ops,
>  
>  	trace_iomap_readpage(iter.inode, 1);
>  
> +	/*
> +	 * Fetch fsverity_info for both data and fsverity metadata, as iomap
> +	 * needs zeroed hash for merkle tree block synthesis
> +	 */
> +	ctx->vi = fsverity_get_info(iter.inode);
> +	if (ctx->vi && iter.pos < i_size_read(iter.inode))
> +		fsverity_readahead(ctx->vi, folio->index,
> +				   folio_nr_pages(folio));
> +
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
>  		iter.status = iomap_read_folio_iter(&iter, ctx,
>  				&bytes_submitted);
> @@ -681,6 +709,15 @@ void iomap_readahead(const struct iomap_ops *ops,
>  
>  	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
>  
> +	/*
> +	 * Fetch fsverity_info for both data and fsverity metadata, as iomap
> +	 * needs zeroed hash for merkle tree block synthesis
> +	 */
> +	ctx->vi = fsverity_get_info(iter.inode);
> +	if (ctx->vi && iter.pos < i_size_read(iter.inode))
> +		fsverity_readahead(ctx->vi, readahead_index(rac),
> +				readahead_count(rac));
> +
>  	while (iomap_iter(&iter, ops) > 0)
>  		iter.status = iomap_readahead_iter(&iter, ctx,
>  					&cur_bytes_submitted);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 4506a99d5285..4d9202cae29f 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -435,6 +435,7 @@ struct iomap_ioend {
>  	loff_t			io_offset;	/* offset in the file */
>  	sector_t		io_sector;	/* start sector of ioend */
>  	void			*io_private;	/* file system private data */
> +	struct fsverity_info	*io_vi;		/* fsverity info */
>  	struct bio		io_bio;		/* MUST BE LAST! */
>  };
>  
> @@ -509,6 +510,7 @@ struct iomap_read_folio_ctx {
>  	struct readahead_control *rac;
>  	void			*read_ctx;
>  	loff_t			read_ctx_file_offset;
> +	struct fsverity_info	*vi;
>  };
>  
>  struct iomap_read_ops {
> -- 
> 2.51.2
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
