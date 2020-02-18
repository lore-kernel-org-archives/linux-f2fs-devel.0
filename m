Return-Path: <SRS0=tJjq=4G=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3874C3404B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:57:58 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C2324654;
	Tue, 18 Feb 2020 22:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Q9m2tp9Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="hSwZGJBg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MTyOyZdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C2324654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j4BoU-0002mf-1o; Tue, 18 Feb 2020 22:57:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jhubbard@nvidia.com>) id 1j4BoS-0002mB-6H
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Feb 2020 22:57:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FNMoOaZBBl3i9xCcuLKNCWIelNbWmCqc+hWHl4NpXdM=; b=Q9m2tp9YE78Ov/MOwWHlc2Gxoz
 WxPwsBK6SUbT5S6nMpC+8tkuhfd0679t3VKyS8ySxK6D5YX4QgqQsqDz2iY0sVzZueJXB6mZiGpBJ
 K6L/vDpyHKmA+MNBBH13LzTfTSyTlT/wCpfNXkoYRrWD0jHrWoxMJFOc3TYtaHoXQXmo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FNMoOaZBBl3i9xCcuLKNCWIelNbWmCqc+hWHl4NpXdM=; b=hSwZGJBgH8GJ943fy4aaqpmxO9
 i1WqkpHDdVSNyKhs0WMPmBxde8e+TqYQFLWc4QKGgCNLrJGrkKlh/IbwotZ4o9MWD1BgBLqztsOnH
 E5ZB/jVZLqLuubAbbC3iafpTEZ/wDKGHCwPC8iYK8xkaiUq3hzPgtjTZXUW5a1AvHEDE=;
Received: from hqnvemgate24.nvidia.com ([216.228.121.143])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j4BoQ-00H1Qa-AK
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Feb 2020 22:57:56 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e4c6ba10001>; Tue, 18 Feb 2020 14:56:33 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 18 Feb 2020 14:57:43 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 18 Feb 2020 14:57:43 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Feb
 2020 22:57:43 +0000
To: Matthew Wilcox <willy@infradead.org>, <linux-fsdevel@vger.kernel.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-6-willy@infradead.org>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <7691abe7-d0e9-e091-b158-764fb624c2d7@nvidia.com>
Date: Tue, 18 Feb 2020 14:57:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217184613.19668-6-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1582066593; bh=FNMoOaZBBl3i9xCcuLKNCWIelNbWmCqc+hWHl4NpXdM=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=MTyOyZdHZQkMODmo8rlMB/2qEg3HU5pqh9FgRxpYsmGRmONsz8OrRQrreEBM2NRJR
 0PWe6O9d1zufzQnZ7Nh6PXVGWI9FIG6u5Ry+tgMofrYVgsctLaciTGIvy+/cW27I6X
 ozy/zXaexJDMUc/Qb0NIOSo/IRTQ4YUAKJ8AfzrVP0G+gsALpSzt/WUyZkuZM9/H1b
 pEHxNVaE1Zn1djE6CJLbRxf6pW4SLxI0NCI/PFJCulvIoPdYakDv8H6EHgYany/KqQ
 +WVDcVH0cvTLVgLvT04N+CZ78lEclF8aBvkeqi/RwbOuHLAT3Vj6DHF81hAcdWMyIY
 Ygo2o7pN3aTag==
X-Headers-End: 1j4BoQ-00H1Qa-AK
Subject: Re: [f2fs-dev] [PATCH v6 04/16] mm: Tweak readahead loop slightly
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2/17/20 10:45 AM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Eliminate the page_offset variable which was just confusing;
> record the start of each consecutive run of pages in the


OK...presumably for the benefit of a following patch, since it is not 
actually consumed in this patch.

> readahead_control, and move the 'kick off a fresh batch' code to
> the end of the function for easier use in the next patch.


That last bit was actually done in the previous patch, rather than this
one, right?

> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/readahead.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 15329309231f..74791b96013f 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -154,7 +154,6 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  		unsigned long lookahead_size)
>  {
>  	struct inode *inode = mapping->host;
> -	struct page *page;
>  	unsigned long end_index;	/* The last page we want to read */
>  	LIST_HEAD(page_pool);
>  	int page_idx;
> @@ -163,6 +162,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  	struct readahead_control rac = {
>  		.mapping = mapping,
>  		.file = filp,
> +		._start = offset,
>  		._nr_pages = 0,
>  	};
>  
> @@ -175,32 +175,39 @@ void __do_page_cache_readahead(struct address_space *mapping,
>  	 * Preallocate as many pages as we will need.
>  	 */
>  	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
> -		pgoff_t page_offset = offset + page_idx;


You know...this ends up incrementing offset each time through the
loop, so yes, the behavior is the same as when using "offset + page_idx".
However, now it's a little harder to see that.

IMHO the page_offset variable is not actually a bad thing, here. I'd rather
keep it, all other things being equal (and I don't see any other benefits
here: line count is the same, for example).

What do you think?


thanks,
-- 
John Hubbard
NVIDIA

> +		struct page *page;
>  
> -		if (page_offset > end_index)
> +		if (offset > end_index)
>  			break;
>  
> -		page = xa_load(&mapping->i_pages, page_offset);
> +		page = xa_load(&mapping->i_pages, offset);
>  		if (page && !xa_is_value(page)) {
>  			/*
> -			 * Page already present?  Kick off the current batch of
> -			 * contiguous pages before continuing with the next
> -			 * batch.
> +			 * Page already present?  Kick off the current batch
> +			 * of contiguous pages before continuing with the
> +			 * next batch.  This page may be the one we would
> +			 * have intended to mark as Readahead, but we don't
> +			 * have a stable reference to this page, and it's
> +			 * not worth getting one just for that.
>  			 */
> -			if (readahead_count(&rac))
> -				read_pages(&rac, &page_pool, gfp_mask);
> -			rac._nr_pages = 0;
> -			continue;
> +			goto read;
>  		}
>  
>  		page = __page_cache_alloc(gfp_mask);
>  		if (!page)
>  			break;
> -		page->index = page_offset;
> +		page->index = offset;
>  		list_add(&page->lru, &page_pool);
>  		if (page_idx == nr_to_read - lookahead_size)
>  			SetPageReadahead(page);
>  		rac._nr_pages++;
> +		offset++;
> +		continue;
> +read:
> +		if (readahead_count(&rac))
> +			read_pages(&rac, &page_pool, gfp_mask);
> +		rac._nr_pages = 0;
> +		rac._start = ++offset;
>  	}
>  
>  	/*
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
