Return-Path: <SRS0=4lPE=L5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF24C07E98
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Jul 2021 06:32:36 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57065613B0;
	Mon,  5 Jul 2021 06:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57065613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m0I9i-0003Y5-QH; Mon, 05 Jul 2021 06:32:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1m0I9h-0003Xy-QL
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Jul 2021 06:32:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:Cc:From:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x8J0j7OmS2fuJxo1gX039cHcd1v0Bwgar2+7b1qcsSQ=; b=GVi/tJn86ztYvO0kFusaqJHO4a
 x/UZRCbanIRrgiaMcb+LzYCXYGklDjvqHL+yG0Yq2rrL29pS1ouh+pVvk4ClqFpXVsdJon0r/k/D3
 6cJS0KNc9r04edv5tKdiDX2gen/8xfharRmyhtTlihfRTBc5PzDOsGSDSVTMZJ4qKk9Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:Cc:From:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=x8J0j7OmS2fuJxo1gX039cHcd1v0Bwgar2+7b1qcsSQ=; b=Pdbc2ONiYsk+xRLWwG2wCvm0yd
 SMd/ARgLYgpSPk+efB8VUoO8TFGyHB7BM+ihQ2uqGDJtMvTAqPRnrlsNbdMsXw7xBC3uik1VimKfg
 A7kd0Fmlzm6j7XtP2br2+mBZET/fYj1a+dJJWK3y4YV4gsJfmV7Ov4BprjIfm0obcLlQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m0I9Y-00AZki-8T
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Jul 2021 06:32:33 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33710613B1;
 Mon,  5 Jul 2021 06:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625466734;
 bh=qXNW2ZG7c5MVDWbUdh+dqGa/9/WrXi9VqrWCyzq3bU4=;
 h=Subject:To:References:From:Cc:Date:In-Reply-To:From;
 b=lkoAWC+H3zK6SxYfMtkBOd+wWpYxBXLd4f57oSQKBLVj1mUVp48lDe2z5yh7DktxD
 1ntPtNP5APymp1A9r0lrO3t5xW49q/ptdebZUpUHI1unI6w+FPWQYMrKI1UTt0Fkar
 /ik8umHQtCf182XDnn/RGGtWV/Hv8U0z9Z8w52qioxc41LMcLcby0IDNnE9VEAVHBW
 Z3iYdMU1uAH2VeqpY34kNdn9i/w4i51sPY8aid4ToBFxFvLV61DGV3V+bBkueXIGxF
 55O1xQe/kd2F0FlwUDQI14b/cXM0gCbYYGSnWYwBDUnS7b9cIyD5L3q/tH8YPAA4tc
 Huxi330aCPl3A==
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210705052216.831989-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
Message-ID: <c32642d6-6de2-eb2d-5771-c7cefa62fab5@kernel.org>
Date: Mon, 5 Jul 2021 14:32:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705052216.831989-1-jaegeuk@kernel.org>
Content-Language: en-US
X-Headers-End: 1m0I9Y-00AZki-8T
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize page->private when using
 for our internal use
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
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/7/5 13:22, Jaegeuk Kim wrote:
> We need to guarantee it's initially zero. Otherwise, it'll hurt entire flag
> operations.

Oops, I didn't get the point, shouldn't .private be zero after page was
just allocated by filesystem? What's the case we will encounter stall
private data left in page?

Cc Matthew Wilcox.

Thanks,

> 
> Fixes: b763f3bedc2d ("f2fs: restructure f2fs page.private layout")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/data.c | 2 ++
>   fs/f2fs/f2fs.h | 5 ++++-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 3a01a1b50104..d2cf48c5a2e4 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3819,6 +3819,8 @@ int f2fs_migrate_page(struct address_space *mapping,
>   		get_page(newpage);
>   	}
>   
> +	/* guarantee to start from no stale private field */
> +	set_page_private(newpage, 0);
>   	if (PagePrivate(page)) {
>   		set_page_private(newpage, page_private(page));
>   		SetPagePrivate(newpage);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 65befc68d88e..ee8eb33e2c25 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1331,7 +1331,8 @@ enum {
>   #define PAGE_PRIVATE_GET_FUNC(name, flagname) \
>   static inline bool page_private_##name(struct page *page) \
>   { \
> -	return test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
> +	return PagePrivate(page) && \
> +		test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
>   		test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
>   }
>   
> @@ -1341,6 +1342,7 @@ static inline void set_page_private_##name(struct page *page) \
>   	if (!PagePrivate(page)) { \
>   		get_page(page); \
>   		SetPagePrivate(page); \
> +		set_page_private(page, 0); \
>   	} \
>   	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
>   	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
> @@ -1392,6 +1394,7 @@ static inline void set_page_private_data(struct page *page, unsigned long data)
>   	if (!PagePrivate(page)) {
>   		get_page(page);
>   		SetPagePrivate(page);
> +		set_page_private(page, 0);
>   	}
>   	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page));
>   	page_private(page) |= data << PAGE_PRIVATE_MAX;
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
