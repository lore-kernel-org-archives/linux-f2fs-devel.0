Return-Path: <SRS0=Zvp+=JX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DFEC43462
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Apr 2021 15:41:07 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7395661076
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Apr 2021 15:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7395661076
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lb3MA-0001r9-Cm; Mon, 26 Apr 2021 15:41:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1lb3M8-0001qp-Kh
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Apr 2021 15:41:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CoxNInOjZOCOyMvfvquIsyQ8wWfp8Kl8mw++g1dHGiY=; b=cD5RtqnQEKyDbDruRS0fxkFPPx
 4bRpf07pNU2TVrvaQJLcYT48lKjH9vCcNoAyXiwK+kCeK0wfgo2zsPJ2DHgs9+TKy24UHi11zG4dW
 jViaUNPt3cGASkN4VVSNjrTU85rny5opKpatDK/lTakq8MWOwy+MRHOqR2PBUifOaQtw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CoxNInOjZOCOyMvfvquIsyQ8wWfp8Kl8mw++g1dHGiY=; b=bomeGWnej/mvEax3TC/uXpx/Wl
 PlhumQgLozcHbGreAUIGCn4sBiYC4yeXWthbpGAV0T3VrKXp9Hkt/6+SDh31yi4jRquOlPWUZ3bpD
 oOh6M8V4rfelIyKCBPrJea+fiTpIURmieszA3uWU8cx82D3hCmEJadg5cH+wJ6TlZpTo=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lb3Lv-00CLV3-PM
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Apr 2021 15:41:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=CoxNInOjZOCOyMvfvquIsyQ8wWfp8Kl8mw++g1dHGiY=; b=lEz+5hJKS15Nvyz9HeU2ArQu9t
 UJ7zK37zfzyvD+0OTzLyc/+EQkqOmNAPuuD3o2QCHAdlQYQJ0dajRGAXjXLBollfSE3nlQfIuPwG1
 Ev1rpoNR2mZfbKrsGhiGXT1WUCT9tWm6bzAzr/yk03Awz9EqOmP5Ez1QObzsINWV4xggzIuDn3okP
 KfGiRswsbsE2MiIGsxjFmSvyeDanc0jrrf47pcsLDsjFzonpFBFgQB8a5qLSNSpmvFQZ80lYKw3ag
 pyodFzxBicGEFlu6u5Wxy96Oxa+fRtNHjqy+bATLepP7JWWbUqnlbPB0ORTF7ICW4i9zvdK84iDN5
 AjmOCbFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lb3LR-005msd-Lj; Mon, 26 Apr 2021 15:40:26 +0000
Date: Mon, 26 Apr 2021 16:40:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20210426154021.GN235567@casper.infradead.org>
References: <20210426100908.109435-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210426100908.109435-1-yuchao0@huawei.com>
X-Headers-End: 1lb3Lv-00CLV3-PM
Subject: Re: [f2fs-dev] [RFC PATCH] f2fs: restructure f2fs page.private
 layout
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Apr 26, 2021 at 06:09:08PM +0800, Chao Yu wrote:
> Restruct f2fs page private layout for below reasons:
> 
> There are some cases that f2fs wants to set a flag in a page to
> indicate a specified status of page:
> a) page is in transaction list for atomic write
> b) page contains dummy data for aligned write
> c) page is migrating for GC
> d) page contains inline data for inline inode flush
> e) page is verified in merkle tree for fsverity

hm, why do you need to record that?  I would have thought that if a file
is marked as being protected by the merkle tree then any pages read in
would be !uptodate until the merkle tree verification had happened.

> f) page is dirty and has filesystem/inode reference count for writeback
> g) page is temporary and has decompress io context reference for compression
> 
> There are existed places in page structure we can use to store
> f2fs private status/data:
> - page.flags: PG_checked, PG_private
> - page.private
> 
> However it was a mess when we using them, which may cause potential
> confliction:
> 		page.private	PG_private	PG_checked
> a)		-1		set
> b)		-2
> c), d), e)					set
> f)		0		set
> g)		pointer		set
> 
> The other problem is page.flags has no free slot, if we can avoid set
> zero to page.private and set PG_private flag, then we use non-zero value
> to indicate PG_private status, so that we may have chance to reclaim
> PG_private slot for other usage. [1]
> 
> So in this patch let's restructure f2fs' page.private as below:
> 
> Layout A: lowest bit should be 1
> | bit0 = 1 | bit1 | bit2 | ... | bit MAX | private data .... |
>  bit 0	PAGE_PRIVATE_NOT_POINTER
>  bit 1	PAGE_PRIVATE_ATOMIC_WRITE
>  bit 2	PAGE_PRIVATE_DUMMY_WRITE
>  bit 3	PAGE_PRIVATE_ONGOING_MIGRATION
>  bit 4	PAGE_PRIVATE_INLINE_INODE
>  bit 5	PAGE_PRIVATE_REF_RESOURCE
>  bit 6-	f2fs private data
> 
> Layout B: lowest bit should be 0
>  page.private is a wrapped pointer.
> 
> After the change:
> 		page.private	PG_private	PG_checked
> a)		11		set
> b)		101
> c)		1001
> d)		10001
> e)						set
> f)		100001		set
> g)		pointer		set

Mmm ... this isn't enough to let us remove PG_private.  We'd need PG_private
to be set for b,c,d as well.

> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 817d0bcb5c67..e393a67a023c 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -444,7 +444,11 @@ static int f2fs_set_meta_page_dirty(struct page *page)
>  	if (!PageDirty(page)) {
>  		__set_page_dirty_nobuffers(page);
>  		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_META);
> -		f2fs_set_page_private(page, 0);
> +		set_page_private_reference(page);
> +		if (!PagePrivate(page)) {
> +			SetPagePrivate(page);
> +			get_page(page);
> +		}

I'm not a big fan of this pattern (which seems to be repeated quite often)
I think it should be buried within set_page_private_reference().  Also,
are the states abcdf all mutually exclusive, or can a page be in states
(eg) b and d at the same time?

> -		if (IS_DUMMY_WRITTEN_PAGE(page)) {
> -			set_page_private(page, (unsigned long)NULL);
> +		if (page_private_dummy(page)) {
> +			clear_page_private_dummy(page);
>  			ClearPagePrivate(page);

I think the ClearPagePrivate should be buried in the page_private_dummy()
macro too ... and shouldn't there be a put_page() for this too?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
