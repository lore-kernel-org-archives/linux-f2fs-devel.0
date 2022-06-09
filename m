Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF176C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  9 Jun 2022 12:46:58 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nzHYt-0006KW-MU; Thu, 09 Jun 2022 12:46:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <david@redhat.com>) id 1nzHYs-0006KQ-Pf
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Jun 2022 12:46:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zufIRXqzWNkS/vBQ6LnlofDt3t0aO0GgELLgxZEV3qM=; b=VU+qTFkCjmB0qGrsmtUvUrOZ2r
 BKKi1/f64+6wjEJzqHesU2wGc7/URWqc/TvRSNDZz8YMG0ts0pKJrpIOYWTu8oXbQGcUbr/AgdQNr
 c25SjaTF3njMfGvwjjkoTmjDJoawR9m+nPpAkjZiqZr1PJA8j5PGytYXNCreKJfggQGY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zufIRXqzWNkS/vBQ6LnlofDt3t0aO0GgELLgxZEV3qM=; b=IJOf/C9GTerWxG0gzm5fkir+em
 uEq/gJXw27erGE8SAGbF7/ZuLxn2p8pSDdjtUUbaVCjxeYTtyif/fxdrlceENjqyXs2o8og1e7C6p
 pr80e2Mlejbm7YMDT+1zsEI3IufG7fLG3qPyCtCT65M4sfcuG6s42ka2Qjqa5RKu5o0o=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nzHYK-0004CJ-Sp
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Jun 2022 12:46:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654778775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zufIRXqzWNkS/vBQ6LnlofDt3t0aO0GgELLgxZEV3qM=;
 b=VGZsBrLCDUGucota6u0ppSg4dENr59/5LV6as6RlGw2FDbFCrTYy90pqYKfzoN90C7aIxN
 8/9mbLt3ugnVsg6/wxiSV1S1rsjWAk9Z78U/nYY8qN3fHvg+0aBG/2SG9h1AFIx4FwHL1L
 SZjWoQM54qNvylt98NRupHDSI2W4RSs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-3sThPFhKP0SbucWreJPK9g-1; Thu, 09 Jun 2022 08:46:14 -0400
X-MC-Unique: 3sThPFhKP0SbucWreJPK9g-1
Received: by mail-wm1-f71.google.com with SMTP id
 o2-20020a05600c510200b0039747b0216fso15965857wms.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 09 Jun 2022 05:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=zufIRXqzWNkS/vBQ6LnlofDt3t0aO0GgELLgxZEV3qM=;
 b=mjjKt5vCXvIgPD9PJQ8zYC8sj8wyO0wiGUybO0NmM5vR7K+YtznD2+a8pre52iK+Uh
 2DTYyCSYY/e80CvG8zHunfu5ErrBK7sI/ksexm8Vqd+X4ehhlkYO84XeUVyX1HzZd6Lw
 Dl+fKWzGjZIGSiQoIM8Hxd6an6MnTLFmAPC6dj1h5/bomi1ZKf02K66EZbcDU+qrgQ3+
 9vk/Z3nWaZzZysi2Lan9xGyZafhDAPXnoIvyrTqY2ks1P0SEd59jcm19oi9N4D59HjUL
 HjlLLTUUjkFUfwPBjtiovq8+AL6W4eAGYtKlp3eXM6w2P2Pq0fP4nn/M96OJUAWeEza+
 5fLQ==
X-Gm-Message-State: AOAM531mc8ccl4KyHUGT1l6LpIiTQTh/5HECca8O6GqFa7yXikl2GK2i
 Jwl18JpAB32T4Ona0IETHFK9C34Kgt84evxycJ4MHolGSuZUt8DNxP44Et7cWkKgNBZ/nyuS3gi
 Vr9FNjAByKd7Zs/e5XpD8Ii9T7Xhkei6N6tB2DQ==
X-Received: by 2002:a05:6000:168b:b0:218:54da:90ba with SMTP id
 y11-20020a056000168b00b0021854da90bamr12022147wrd.283.1654778773728; 
 Thu, 09 Jun 2022 05:46:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFg5i2EPJ88Gv87gtw7EHVrLhSwsyQAltgpPZk1DxRKIUlDObIOhdmhH9jKki5ThpOI9Vqng==
X-Received: by 2002:a05:6000:168b:b0:218:54da:90ba with SMTP id
 y11-20020a056000168b00b0021854da90bamr12022117wrd.283.1654778773451; 
 Thu, 09 Jun 2022 05:46:13 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8?
 ([2a09:80c0:192:0:20af:34be:985b:b6c8])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a05600c224700b0039c693a54ecsm3854607wmm.23.2022.06.09.05.46.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jun 2022 05:46:12 -0700 (PDT)
Message-ID: <c204c627-ec6b-cd8c-412d-57c8f55c61fa@redhat.com>
Date: Thu, 9 Jun 2022 14:46:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org
References: <20220608150249.3033815-1-willy@infradead.org>
 <20220608150249.3033815-2-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220608150249.3033815-2-willy@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Headers-End: 1nzHYK-0004CJ-Sp
Subject: Re: [f2fs-dev] [PATCH v2 01/19] secretmem: Remove isolate_page
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

On 08.06.22 17:02, Matthew Wilcox (Oracle) wrote:
> The isolate_page operation is never called for filesystems, only
> for device drivers which call SetPageMovable.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/secretmem.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 206ed6b40c1d..1c7f1775b56e 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -133,11 +133,6 @@ static const struct file_operations secretmem_fops = {
>  	.mmap		= secretmem_mmap,
>  };
>  
> -static bool secretmem_isolate_page(struct page *page, isolate_mode_t mode)
> -{
> -	return false;
> -}
> -
>  static int secretmem_migratepage(struct address_space *mapping,
>  				 struct page *newpage, struct page *page,
>  				 enum migrate_mode mode)
> @@ -155,7 +150,6 @@ const struct address_space_operations secretmem_aops = {
>  	.dirty_folio	= noop_dirty_folio,
>  	.free_folio	= secretmem_free_folio,
>  	.migratepage	= secretmem_migratepage,
> -	.isolate_page	= secretmem_isolate_page,
>  };
>  
>  static int secretmem_setattr(struct user_namespace *mnt_userns,

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
