Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79C3FCC9A2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Mar 2026 00:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ytMt1Tj5/IgMZCNd0+NE4mpVYUg2EHwvjCzsSa2ufY=; b=EsyQswLgrtQPpFN7byyOWgLftR
	7yu2UJHNqRpOTMldrwgwQNIiqMtBV/Ief9uUxJS/9QjcAHYLnTQ03brQCgkMEvm54NrOq2X3cQqmr
	BH4Q7bMtgNrTd1T739mSKGIT1KBMj+bkH2+ZofAKdaRF0JqeOQQHfyd78ay/HRqlCMa8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vzlN0-0000St-5y;
	Tue, 10 Mar 2026 00:54:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1vzlMy-0000Sk-H2
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Mar 2026 00:54:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W+pKIwTJeS60djbGfq4Gxr0N407wNMctJMxR5iGP7kA=; b=N4tNMUyZHCWbmtSzFyBwsUkc0d
 CUul0Y3iYe5+BhN9OMk6hynlepP6wn54qy3ibFgzgi7ZA0fnROReKrEm/ic3gz3XfEi3RDkCI/exu
 pYxzN4Fg4M7QiLdBbOUvxL/g3ehIr1l8CgPCVt1X/VgcN267kNELCPenlRU0fb2gi1mk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=W+pKIwTJeS60djbGfq4Gxr0N407wNMctJMxR5iGP7kA=; b=HhtGodcK3WCc/1LW4k1uBTfZW5
 vNzjWKemFLgtCU3+nfooPbGglmKTFnDoKKbzOEH5AyUWgzn1Vk9yS6MVnw+3fs/kOrT506StAiKv2
 xL4eNnyM0qfSdMOgsNnn25HyfU4sm8TmY6HqNK9oIyjBMNUnbg/ier1lzzn1X3mennHQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vzlMx-0006jd-Oq for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Mar 2026 00:54:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 18582600AE;
 Tue, 10 Mar 2026 00:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D34C4CEF7;
 Tue, 10 Mar 2026 00:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773104072;
 bh=dD+yDAtPqSGN+bF1VISeh1X1ceJWh7z9IlEn5rSOH7s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=de78d+MnaW8U0E7l3cvBN4U2h6z25ueH/JD+bLWjeJ5i8/COdlU9RMWIwQ2vMl1eG
 UqdGxK760OqIVcJVwqj/YSJ3Qs7eHh2XvSxZmK9hgeCc/Iw9TSmalgWOLBP73Kk4Hq
 scbpdIcB5PHMsLzcajK9DZzyZ8mqiRijXbDL/TqNxGOTU5BKqZD1GoWsx6i4PS7wrR
 OOhFjlM/7/NMuM/NV72zht48rjUKr/l7/GN47nV+OYvmZB9YMo0dXI10g6+NluLzmI
 WEwl/XIuXdSd1a1Mqr5otnqUaTGRFonWqTxl+Lf2HC6AgKi2W7Y1SyWdyX8IZ3SOg9
 pN546PuLivhWw==
Date: Mon, 9 Mar 2026 17:54:32 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260310005432.GZ6033@frogsfrogsfrogs>
References: <20260309192355.176980-1-aalbersh@kernel.org>
 <20260309192355.176980-8-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260309192355.176980-8-aalbersh@kernel.org>
X-Headers-End: 1vzlMx-0006jd-Oq
Subject: Re: [f2fs-dev] [PATCH v4 07/25] iomap: introduce IOMAP_F_FSVERITY
 and teach writeback to handle fsverity
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

On Mon, Mar 09, 2026 at 08:23:22PM +0100, Andrey Albershteyn wrote:
> This flag indicates that I/O is for fsverity metadata.
> 
> In the write path skip i_size check and i_size updates as metadata is
> past EOF. In writeback don't update i_size and continue writeback if
> even folio is beyond EOF. In read path don't zero fsverity folios, again
> they are past EOF.
> 
> The iomap_block_needs_zeroing() is also called from write path. For
> folios of larger order we don't want to zero out pages in the folio as
> these could contain other merkle tree blocks. For fsverity, filesystem
> will request to read PAGE_SIZE memory regions. For data folios, iomap
> will zero the rest of the folio for anything which is beyond EOF. We
> don't want this for fsverity folios.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

This feels like a reasonable means to implement post-EOF data stashing
for fsverity having gone through many other merkle tree IO path designs
and discarded them all. :/

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Hey, at least some day we might get fscrypt+fsverity on xfs for free.

--D

> ---
>  fs/iomap/buffered-io.c | 34 +++++++++++++++++++++++++---------
>  fs/iomap/trace.h       |  3 ++-
>  include/linux/iomap.h  |  5 +++++
>  3 files changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 51a58a0bfe6c..530794dcdd91 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -344,9 +344,16 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
>  {
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  
> -	return srcmap->type != IOMAP_MAPPED ||
> -		(srcmap->flags & IOMAP_F_NEW) ||
> -		pos >= i_size_read(iter->inode);
> +	if (srcmap->type != IOMAP_MAPPED)
> +		return true;
> +
> +	if (srcmap->flags & IOMAP_F_NEW)
> +		return true;
> +
> +	if (srcmap->flags & IOMAP_F_FSVERITY)
> +		return false;
> +
> +	return pos >= i_size_read(iter->inode);
>  }
>  
>  /**
> @@ -1152,13 +1159,14 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
>  		 * unlock and release the folio.
>  		 */
>  		old_size = iter->inode->i_size;
> -		if (pos + written > old_size) {
> +		if (pos + written > old_size &&
> +		    !(iter->iomap.flags & IOMAP_F_FSVERITY)) {
>  			i_size_write(iter->inode, pos + written);
>  			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
>  		}
>  		__iomap_put_folio(iter, write_ops, written, folio);
>  
> -		if (old_size < pos)
> +		if (old_size < pos && !(iter->iomap.flags & IOMAP_F_FSVERITY))
>  			pagecache_isize_extended(iter->inode, old_size, pos);
>  
>  		cond_resched();
> @@ -1786,13 +1794,21 @@ static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
>   * Check interaction of the folio with the file end.
>   *
>   * If the folio is entirely beyond i_size, return false.  If it straddles
> - * i_size, adjust end_pos and zero all data beyond i_size.
> + * i_size, adjust end_pos and zero all data beyond i_size. Don't skip fsverity
> + * folios as those are beyond i_size.
>   */
> -static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
> -		u64 *end_pos)
> +static bool iomap_writeback_handle_eof(struct folio *folio,
> +				       struct iomap_writepage_ctx *wpc,
> +				       u64 *end_pos)
>  {
> +	struct inode *inode = wpc->inode;
>  	u64 isize = i_size_read(inode);
>  
> +	if (wpc->iomap.flags & IOMAP_F_FSVERITY) {
> +		WARN_ON_ONCE(folio_pos(folio) < isize);
> +		return true;
> +	}
> +
>  	if (*end_pos > isize) {
>  		size_t poff = offset_in_folio(folio, isize);
>  		pgoff_t end_index = isize >> PAGE_SHIFT;
> @@ -1858,7 +1874,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
>  
>  	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
>  
> -	if (!iomap_writeback_handle_eof(folio, inode, &end_pos))
> +	if (!iomap_writeback_handle_eof(folio, wpc, &end_pos))
>  		return 0;
>  	WARN_ON_ONCE(end_pos <= pos);
>  
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 532787277b16..5252051cc137 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -118,7 +118,8 @@ DEFINE_RANGE_EVENT(iomap_zero_iter);
>  	{ IOMAP_F_ATOMIC_BIO,	"ATOMIC_BIO" }, \
>  	{ IOMAP_F_PRIVATE,	"PRIVATE" }, \
>  	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }, \
> -	{ IOMAP_F_STALE,	"STALE" }
> +	{ IOMAP_F_STALE,	"STALE" }, \
> +	{ IOMAP_F_FSVERITY,	"FSVERITY" }
>  
>  
>  #define IOMAP_DIO_STRINGS \
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 531f9ebdeeae..dc39837b0d45 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -87,6 +87,11 @@ struct vm_fault;
>  #define IOMAP_F_INTEGRITY	0
>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>  
> +/*
> + * IO happens beyond inode EOF, fsverity metadata is stored there
> + */
> +#define IOMAP_F_FSVERITY	(1U << 10)
> +
>  /*
>   * Flag reserved for file system specific usage
>   */
> -- 
> 2.51.2
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
