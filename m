Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A6BD1950F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Jan 2026 19:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IRjL8fU0bNYlMX8S4dD0ojZuP7eE1OrVisyfpEDSohw=; b=HYbhcLgUC0zB2TkB4VwB362hxl
	UFkfzQEORtmBBvd8iyDkTeKxx2fxLmxTcsk0YChm20OZs2KcEY8oXS+1Dh/dSMnFy/zGiTH4OJXDZ
	riMa6CLHOjvy2veN8E7PIq/ovybTjJSb1ZYRB3UKrqopUR7kHVwfDwlwlFAQDg9QQFfo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkRzV-0002kZ-So;
	Mon, 26 Jan 2026 19:11:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1vkRzV-0002kS-5i
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 19:11:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kANCAcwSQX5tPfsZejoVm/klUi4Y5pON/8WD+C5dABc=; b=AASSEZGScIpXiKRZapwRtRcw2U
 Q6QB4Qc3+6SuK4BXsxmJ7DAAJSxiM3kxy0/kyg0axoCaAE5fvupNBKF2l/nQdkMl04NnlmGL+ZrFZ
 pIvJ8WMC1fYjCkRcLXt4dVTdIS7B7nhgMpjxsVzad2SBBYNISrJ7r9RwBYsI7hauii/k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kANCAcwSQX5tPfsZejoVm/klUi4Y5pON/8WD+C5dABc=; b=I34N8s9WwBup8+r131Bnj5pQHF
 6VPATFdGvFPJsf7rxQlRHokTWpTyKfi1kQhyEOdvsNMalIurtr7dco0UDsMklZm04s9Ca1G/tHaJz
 aGhCL6O3iOabX+e+X1DyVJosa8nMpeiPzivw/N773I6uwv3kWfspjS7e0GTWZVI1+Ubw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkRzV-0005CV-IO for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 19:11:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 30BB7400A7;
 Mon, 26 Jan 2026 19:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080F1C116C6;
 Mon, 26 Jan 2026 19:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769454663;
 bh=VuNjk5JPQkuJHg0tkyb4Xhls+pw6q17FfG9hVadfPQ0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I2XZrOKpelUwXVo3uRwJuxY9weKtlh0PSlhPTaKfohUJ09qk2nF0eKyw3KYuGrzIq
 P2B/Fu4TmTWZxnZzSHDXYwnB8sqyQ5KFBcLuUQcrU8o8wPtOMsEY5Xax7z3T0L1fOI
 HtdeL0HHtZTqRh5vTqgL2vRquzGT8lg6eK0mo06sYgnpT0hAXrl7yy9phFAbxzl3iI
 26s9jlb8JuojngiEhqQOzF24Sm2mtFC+qtCLLETANb8fkiiKYtTT2B6YCQbwgbUWRW
 ZtzxW5iXUsC3TeHuPdY8R2BfYNcJrPOCwXEJS99N3zxxUgyVv1e9nNrSv9X8OKiucy
 S/XyKphCGnE0g==
Date: Mon, 26 Jan 2026 11:11:02 -0800
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260126191102.GO5910@frogsfrogsfrogs>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-8-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260126045212.1381843-8-hch@lst.de>
X-Headers-End: 1vkRzV-0005CV-IO
Subject: Re: [f2fs-dev] [PATCH 07/16] fsverity: don't issue readahead for
 non-ENOENT errors from __filemap_get_folio
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
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Andrey Albershteyn <aalbersh@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 26, 2026 at 05:50:53AM +0100, Christoph Hellwig wrote:
> Issuing more reads on errors is not a good idea, especially when the
> most common error here is -ENOMEM.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/verity/pagecache.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
> index 1efcdde20b73..63393f0f5834 100644
> --- a/fs/verity/pagecache.c
> +++ b/fs/verity/pagecache.c
> @@ -22,7 +22,8 @@ struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
>  	struct folio *folio;
>  
>  	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
> -	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
> +	if (PTR_ERR(folio) == -ENOENT ||
> +	    !(IS_ERR(folio) && !folio_test_uptodate(folio))) {

I don't understand this logic at all.  If @folio is actually an
ERR_PTR, then we dereference the non-folio to see if it's not uptodate?

I think (given the previous revisions) that what you want is to initiate
readahead if either there's no folio at all (ENOENT) or if there is a
folio but it's not uptodate?  But not if there's some other error
(ENOMEM, EL3HLT, EFSCORRUPTED, etc)?

So maybe you want:

	folio = __filemap_get_folio(...);
	if (!IS_ERR(folio)) {
		if (folio_test_uptodate(folio))
			return folio_file_page(folio);
		folio_put(folio);
	} else if (PTR_ERR(folio) == -ENOENT) {
		return ERR_CAST(folio);
	}

	if (num_ra_pages > 1)
		page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
	folio = read_mapping_folio(inode->i_mapping, index, NULL);
	if (IS_ERR(folio))
		return ERR_CAST(folio);

	return folio_file_page(folio);

<confused>

--D

>  		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
>  
>  		if (!IS_ERR(folio))
> -- 
> 2.47.3
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
