Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5C8C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Jun 2022 07:36:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nyTlX-0006TI-U8; Tue, 07 Jun 2022 07:36:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <david@redhat.com>) id 1nyTlW-0006TB-4R
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Jun 2022 07:36:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=poSLf3SQpSQVqGAvfY9ZUAc4mDsdNw09sPQoA12+Xn0=; b=cipwIFo4w2r4Ri95Y98BhXKRTe
 dJMXlc/RcHtCAcITLNyEqZAmyK+bvOaUFvEFr5ZtsAw7qWXwxoCvW51/hwmOpNL25v81xCPsNjUia
 D6ytTTAJbVBp+JyyWMZ7Mgj0PWjjU8g4Z+XnzqYGpcEQmQCxTwRvfpAVg1ZXxmGaPs3E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=poSLf3SQpSQVqGAvfY9ZUAc4mDsdNw09sPQoA12+Xn0=; b=WlEUh0OJcQNSg0c9+/JcHg3gSz
 UWrlFcNzzWdyr27DqCMO6y7/shZKRp9PZlkgxQtfRCfS9VlyPDL3Dd6gkA3lNWvEZJrJQHIfgm6Am
 SxLrvOoMePLZjUhHAai2TIfaJAH/zqqYf6uK8qNbKPbJ33v9lpZ1fhifKYxR3Jf/uuiA=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nyTlQ-0007qk-Al
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Jun 2022 07:36:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654587386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=poSLf3SQpSQVqGAvfY9ZUAc4mDsdNw09sPQoA12+Xn0=;
 b=hfSm24hAkAxOtxAdK5RtalOFpv2znDhW0w8uprj18UcuDvaE1104doT8gg0EGQRE7IVVae
 Iv9ibPBqibKHQJSPOIOBqaEpuEYNNXoxMCplEm6QKG0vQjt/Q4MwCr3NAXeroafSH4Hism
 Hc6SSzDGX6eaNpnk8i7CZOns7zf1qCw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-EkWS5u0HM9ilRva_6NPadA-1; Tue, 07 Jun 2022 03:36:25 -0400
X-MC-Unique: EkWS5u0HM9ilRva_6NPadA-1
Received: by mail-wr1-f72.google.com with SMTP id
 o18-20020a5d4a92000000b00213b4eebc25so2930460wrq.21
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 07 Jun 2022 00:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=poSLf3SQpSQVqGAvfY9ZUAc4mDsdNw09sPQoA12+Xn0=;
 b=QtslzK2N99DliqC/Lb/eSR7KwxRqtdGZYyf21arzcL4wzasECDQI475iYjLdeQpw9g
 kNnIG/3tFtNLrQ6wYzUZ5rQNmxuVoFhnYs4srJDT+uG0QweM2qwhup3cjvbXTUYHXmOR
 wz3wsBCXGYIBb5Qt2Lx3WOVHKdSO+IsFmzkbmwTUFD3sE+52REmM+BzSw0sRowejntmg
 92kJhWOtZM+IBzRGc4CRvG62ZcgJ3VqTkADysk8KmpT9EOT7c/LpFfy6pXThCHmTQdWn
 5RGxPY1h5bHbxoVpPpfZQHnwuu3eXyudKrr0Zd/c6udLk2ae+yIanzqMi08Rh0SejBwQ
 elPA==
X-Gm-Message-State: AOAM53393W9upP73IVyFc9ON+TU5zirpUPb8bQYxOcnJdMxrSkxCnmVe
 /Fvx/KdY0F0isvlRtZ9Yr28Yz2KsuMHGonzl7Axqeyr8F2GnUSXMuWlENO8ULAW0iW55ei9lKng
 Goz+5AkyIks6libq9o0hbwYY6FgNhSS0mUxmzig==
X-Received: by 2002:a05:600c:4ec9:b0:397:750a:798a with SMTP id
 g9-20020a05600c4ec900b00397750a798amr56010315wmq.169.1654587384019; 
 Tue, 07 Jun 2022 00:36:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/TT1zDaD6ih4ST/0Z6l6/VJexv/LUjWrit9gRiSM2S633qB8aLjqIdjv8Hs+falCUt0H+YA==
X-Received: by 2002:a05:600c:4ec9:b0:397:750a:798a with SMTP id
 g9-20020a05600c4ec900b00397750a798amr56010293wmq.169.1654587383789; 
 Tue, 07 Jun 2022 00:36:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:500:4c8d:4886:f874:7b6f?
 (p200300cbc70905004c8d4886f8747b6f.dip0.t-ipconnect.de.
 [2003:cb:c709:500:4c8d:4886:f874:7b6f])
 by smtp.gmail.com with ESMTPSA id
 j37-20020a05600c1c2500b0039c235fb6a5sm19943141wms.8.2022.06.07.00.36.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jun 2022 00:36:22 -0700 (PDT)
Message-ID: <e4d017a4-556d-bb5f-9830-a8843591bc8d@redhat.com>
Date: Tue, 7 Jun 2022 09:36:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org
References: <20220606204050.2625949-1-willy@infradead.org>
 <20220606204050.2625949-16-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220606204050.2625949-16-willy@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Headers-End: 1nyTlQ-0007qk-Al
Subject: Re: [f2fs-dev] [PATCH 15/20] balloon: Convert to migrate_folio
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
 linux-ext4@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 06.06.22 22:40, Matthew Wilcox (Oracle) wrote:
> This is little more than changing the types over; there's no real work
> being done in this function.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/balloon_compaction.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index 4b8eab4b3f45..3f75b876ad76 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -230,11 +230,10 @@ static void balloon_page_putback(struct page *page)
>  
>  
>  /* move_to_new_page() counterpart for a ballooned page */
> -static int balloon_page_migrate(struct address_space *mapping,
> -		struct page *newpage, struct page *page,
> -		enum migrate_mode mode)
> +static int balloon_migrate_folio(struct address_space *mapping,
> +		struct folio *dst, struct folio *src, enum migrate_mode mode)
>  {
> -	struct balloon_dev_info *balloon = balloon_page_device(page);
> +	struct balloon_dev_info *balloon = balloon_page_device(&src->page);
>  
>  	/*
>  	 * We can not easily support the no copy case here so ignore it as it
> @@ -244,14 +243,14 @@ static int balloon_page_migrate(struct address_space *mapping,
>  	if (mode == MIGRATE_SYNC_NO_COPY)
>  		return -EINVAL;
>  
> -	VM_BUG_ON_PAGE(!PageLocked(page), page);
> -	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
> +	VM_BUG_ON_FOLIO(!folio_test_locked(src), src);
> +	VM_BUG_ON_FOLIO(!folio_test_locked(dst), dst);
>  
> -	return balloon->migratepage(balloon, newpage, page, mode);
> +	return balloon->migratepage(balloon, &dst->page, &src->page, mode);
>  }
>  
>  const struct address_space_operations balloon_aops = {
> -	.migratepage = balloon_page_migrate,
> +	.migrate_folio = balloon_migrate_folio,
>  	.isolate_page = balloon_page_isolate,
>  	.putback_page = balloon_page_putback,
>  };

I assume you're working on conversion of the other callbacks as well,
because otherwise, this ends up looking a bit inconsistent and confusing :)

Change LGTM.

-- 
Thanks,

David / dhildenb



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
