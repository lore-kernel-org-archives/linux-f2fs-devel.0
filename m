Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342A3C4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Apr 2024 23:34:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rzPf3-0006U7-NS;
	Tue, 23 Apr 2024 23:34:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1rzPf2-0006U0-OG
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Apr 2024 23:34:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6Mw9qRa/fhAF4JvfrAOSL34BTVFtitL+ibmRJ4b61UY=; b=jemzKW64g/b+2a0tHcZ2P22o3V
 LJHLWQpSNPo5USVU9VeH9/aNa28s49YwqDrKmYhM86StpArLvEiaLbQU0CBnynbYykUCDY9C4PKLj
 7nSl/XEAUBoelnyfR1oxS2iN4PISBGf+lmsBFqOCfs+cIkdR+4LaKw78MKY11Lpn00WY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6Mw9qRa/fhAF4JvfrAOSL34BTVFtitL+ibmRJ4b61UY=; b=FVw2ZoLOfexDAsuqN8tyUAp2p0
 lkhZetyhInq9XqxkCJ4P4nOF5LFwknTPTxFlPFlNHRo5gnKFALKoHPtYCRHuAeHVogLV9YrnGmf5k
 W3SbyYtnUSVMLgZmfobcRsVBgRfN1ZKSDgX/euwM5HK7CzMYQFVEa1iIkEquKIta3pp4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rzPf0-0001F5-EQ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Apr 2024 23:34:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E83C361750;
 Tue, 23 Apr 2024 23:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68753C3277B;
 Tue, 23 Apr 2024 23:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713915280;
 bh=LzAcy+XvCVX5N1spjFF+GDeLAm7nYydUoetmvgeGi/c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M/1ENwD6whocj16yE+tzly6+1EzemOrzDFOidz4hWg6YPzpZ71V7ES1bnNGqxg9PJ
 fA+oIyAFE99cmHim7k7KvUsyk+dcmKN0WIRnNEOVG1aUbqEwufskeV3UIi97C3236h
 /YjiKBCC/GMgnUNPiLCOYKpF9Qmf3QZUEUe6lAmbxCI32pbhhslIvTJC9I8w5daD4Y
 V6f+XG24TvcgcCwXu3BuVkCKFtYVSyUcePaDWoApXnLfm5cYTMGg+YMRa+PrMkexgn
 Sdv3fxNpFUqiO4gZxd1KOxNR0hZbsI26O5UblDywQmpVZinlNumBJdt2CqOeZgmfal
 2ydpow0owFuHw==
Date: Tue, 23 Apr 2024 16:34:38 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Message-ID: <20240423233438.GA32430@sol.localdomain>
References: <20240423225552.4113447-1-willy@infradead.org>
 <20240423225552.4113447-2-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240423225552.4113447-2-willy@infradead.org>
X-Headers-End: 1rzPf0-0001F5-EQ
Subject: Re: [f2fs-dev] [PATCH 1/6] fscrypt: Convert
 bh_get_inode_and_lblk_num to use a folio
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
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-fscrypt@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Apr 23, 2024 at 11:55:32PM +0100, Matthew Wilcox (Oracle) wrote:
> Remove uses of page->index, page_mapping() and b_page.  Saves a call
> to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/crypto/inline_crypt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
> index b4002aea7cdb..40de69860dcf 100644
> --- a/fs/crypto/inline_crypt.c
> +++ b/fs/crypto/inline_crypt.c
> @@ -284,7 +284,7 @@ static bool bh_get_inode_and_lblk_num(const struct buffer_head *bh,
>  				      const struct inode **inode_ret,
>  				      u64 *lblk_num_ret)
>  {
> -	struct page *page = bh->b_page;
> +	struct folio *folio = bh->b_folio;
>  	const struct address_space *mapping;
>  	const struct inode *inode;
>  
> @@ -292,13 +292,13 @@ static bool bh_get_inode_and_lblk_num(const struct buffer_head *bh,
>  	 * The ext4 journal (jbd2) can submit a buffer_head it directly created
>  	 * for a non-pagecache page.  fscrypt doesn't care about these.
>  	 */
> -	mapping = page_mapping(page);
> +	mapping = folio_mapping(folio);
>  	if (!mapping)
>  		return false;
>  	inode = mapping->host;
>  
>  	*inode_ret = inode;
> -	*lblk_num_ret = ((u64)page->index << (PAGE_SHIFT - inode->i_blkbits)) +
> +	*lblk_num_ret = ((u64)folio->index << (PAGE_SHIFT - inode->i_blkbits)) +
>  			(bh_offset(bh) >> inode->i_blkbits);
>  	return true;
>  }

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
