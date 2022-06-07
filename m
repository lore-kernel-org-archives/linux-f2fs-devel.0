Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804ADC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Jun 2022 13:42:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nyZTM-0003yp-0j; Tue, 07 Jun 2022 13:42:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bfoster@redhat.com>) id 1nyZTJ-0003yj-VP
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Jun 2022 13:42:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U9GWchY9hZYcIJP7lDw5j1KYfu5h/jhdfCsZWPH40Q8=; b=PBDnxqao+2gCJIexxOP+fgA+hK
 c3iTnYKUZyWgFxclYfNq+bcTE+fE5ujwJChbfPym3nIrX4CQZgIc46Siu+2PWcsaqgAqINHi8CTMe
 2QDSEJtPcZnXYgBxeg2pzt87KK6k2bwAYXOfuWby/LL+OFFwAkhHLyGVuDexRkZgRxgc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U9GWchY9hZYcIJP7lDw5j1KYfu5h/jhdfCsZWPH40Q8=; b=WbThZ/CdojaAwhOON4qrt9C1SB
 gQkyUT46u2yuDAthj/EhQnsUKC4EIuKpusjzUu0ikRWDU+A88qZuEmrELWifWPS65B+S4px0Uy2Nj
 sp2FvjO8D4sYPa1Ag8Z40AKTMJnCpeeDZlGNToTIrq8Vz0ca/PLlE05GFRMEBKfezmQA=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nyZTE-008HLZ-5H
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Jun 2022 13:42:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654609322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U9GWchY9hZYcIJP7lDw5j1KYfu5h/jhdfCsZWPH40Q8=;
 b=GUkPRVvGUaOPnIf6DZL/xbvEbUulIJsi4e84BNLzLRFPmLgR9yyBwuILWOy/L68zsvLQ4W
 NA/y71u6QOWL/EA35pe1+dB0OyyL1DEoGWD4VkqL9VB2bVAcCe+4zzh+yvw3fhM7WfOxTp
 wTPxybpsRn/Ze/T5xon5LLk1IlB9AGY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-6X4fui0LOdagZbpkPEbYEg-1; Tue, 07 Jun 2022 09:42:01 -0400
X-MC-Unique: 6X4fui0LOdagZbpkPEbYEg-1
Received: by mail-qv1-f72.google.com with SMTP id
 kk8-20020a056214508800b004645738eff6so7743765qvb.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 07 Jun 2022 06:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=U9GWchY9hZYcIJP7lDw5j1KYfu5h/jhdfCsZWPH40Q8=;
 b=smlfxzGOUzxSDhai/t7JaMf8k1TcrBTYUrnCzfjQGStb25Ac78TwGLzluNv0vUXGY+
 7nE7M+Bq+OgkFE2b1Jc+byYpyJqK7jO3KMMaYerzJQsQrBrV9kVmdjbPld4ZGzgxmz7m
 GOvz//+B8a37sZHgjINw8Jg3fi5sywgXCFgCwB5fIsZuBR+50n8GCWuRzOCSBWcePj+a
 ipGNy4wQljhbddnW/L3aedOMSLWqbtBYABqEv52r8udE8QPN0Ds/TCmI22EzMNW8uiko
 doyGzIk+H+cfY2rhXAv41eIskg14hds0Wl6Yf9Nh0IB1PQcD62+OaABLyp3bv4J1RYtp
 F2Rg==
X-Gm-Message-State: AOAM533VEmGAE55wMvJzncXXUWxFWuS5FBxS97aw1WbzpLTdPNZqyXe4
 qN1AE2sdMvY2i+Gefdb8+krkl7QAmmon62jw1sJMlpvRK0WGDO7m0QxtvfIX1qrMkBBGBmy2GtC
 OQVyrfzrPdNT/Sakev+NauzFTERZtwvK9lzo6Lg==
X-Received: by 2002:ac8:5acc:0:b0:304:f75a:4a1d with SMTP id
 d12-20020ac85acc000000b00304f75a4a1dmr3015560qtd.120.1654609320539; 
 Tue, 07 Jun 2022 06:42:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyavNr4YW+NLtrlTYw3DwYvyx9zxVnBrVGsEoQi3F5ODngxQYCXvCvG44n4ArB8DEsaTyYSw==
X-Received: by 2002:ac8:5acc:0:b0:304:f75a:4a1d with SMTP id
 d12-20020ac85acc000000b00304f75a4a1dmr3015540qtd.120.1654609320271; 
 Tue, 07 Jun 2022 06:42:00 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
 by smtp.gmail.com with ESMTPSA id
 ay33-20020a05620a17a100b006a6f68c8a87sm148860qkb.126.2022.06.07.06.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jun 2022 06:41:59 -0700 (PDT)
Date: Tue, 7 Jun 2022 09:41:57 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Message-ID: <Yp9VpZDsUEAZHEuy@bfoster>
References: <20220606204050.2625949-1-willy@infradead.org>
 <20220606204050.2625949-6-willy@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20220606204050.2625949-6-willy@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bfoster@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1nyZTE-008HLZ-5H
Subject: Re: [f2fs-dev] [PATCH 05/20] mm/migrate: Convert
 expected_page_refs() to folio_expected_refs()
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
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jun 06, 2022 at 09:40:35PM +0100, Matthew Wilcox (Oracle) wrote:
> Now that both callers have a folio, convert this function to
> take a folio & rename it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/migrate.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 77b8c662c9ca..e0a593e5b5f9 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -337,13 +337,18 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
>  }
>  #endif
>  
> -static int expected_page_refs(struct address_space *mapping, struct page *page)
> +static int folio_expected_refs(struct address_space *mapping,
> +		struct folio *folio)
>  {
> -	int expected_count = 1;
> +	int refs = 1;
> +	if (!mapping)
> +		return refs;
>  
> -	if (mapping)
> -		expected_count += compound_nr(page) + page_has_private(page);
> -	return expected_count;
> +	refs += folio_nr_pages(folio);
> +	if (folio_get_private(folio))
> +		refs++;

Why not folio_has_private() (as seems to be used for later
page_has_private() conversions) here?

> +
> +	return refs;;

Nit: extra ;

Brian

>  }
>  
>  /*
> @@ -360,7 +365,7 @@ int folio_migrate_mapping(struct address_space *mapping,
>  	XA_STATE(xas, &mapping->i_pages, folio_index(folio));
>  	struct zone *oldzone, *newzone;
>  	int dirty;
> -	int expected_count = expected_page_refs(mapping, &folio->page) + extra_count;
> +	int expected_count = folio_expected_refs(mapping, folio) + extra_count;
>  	long nr = folio_nr_pages(folio);
>  
>  	if (!mapping) {
> @@ -670,7 +675,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>  		return migrate_page(mapping, &dst->page, &src->page, mode);
>  
>  	/* Check whether page does not have extra refs before we do more work */
> -	expected_count = expected_page_refs(mapping, &src->page);
> +	expected_count = folio_expected_refs(mapping, src);
>  	if (folio_ref_count(src) != expected_count)
>  		return -EAGAIN;
>  
> -- 
> 2.35.1
> 
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
