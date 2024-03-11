Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74732C5475B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 Mar 2024 03:54:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rjWk5-0002zN-Ce;
	Mon, 11 Mar 2024 03:54:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rjWk4-0002zE-De
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 Mar 2024 03:54:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hmrHm10wj4Tb0bGho1Z58ygYEQnvQVnCl3niDspRG9I=; b=lQ0+gXi4Co9xzfa4z0+iwoLyfC
 92vUa19RjxKl9mb3PigndpHLhlC5fo61yvsJdCQA9A4KrzfHq8YvVCGXKFKXYjOxjDJUQDwT52SNU
 dQ0rLWordSlAjCHde+2B0IKaiNtoKmBTLqWSztjn3t4g8uayRbwUbCZeuJxiUlDDi49k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hmrHm10wj4Tb0bGho1Z58ygYEQnvQVnCl3niDspRG9I=; b=VtrSCHPv8YIPRPkD0l/f090xC7
 K+7oFofmytHUq+j7EHqkDCnx4lig7cAbkgyu1WSHnB2diSc5TJKepXyvx1Ind12vnl9XG7NJQVHh5
 xbvgfEgOej6wdVmykWu79Rd6I66A7qEoQMw425vgDzvxxmZNJ3isfnyKzHhSZvhXtvhU=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rjWjt-0003Mb-8g for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 Mar 2024 03:54:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 923B3CE0B57;
 Mon, 11 Mar 2024 03:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBC6C433C7;
 Mon, 11 Mar 2024 03:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710129245;
 bh=1j9WPfieMKDOLQaDOS5Cyf1ofMxyJtJqnuJPUaavX2c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hZvzXiNjsjR/mLRkE/q4I81NWyTDrFo0xIdWF/5dizanAOB9U7zt0jTzGX1PypYTx
 R4EbNm3v2V6btBh4kiGSGeVqC4gO9kzuzOojCxCrsGCrUlmzSZnPoLAn/008qySkIR
 QfUjIgcqsR8G0NcF8B/b76dLWwHIXNb2+mGmEHVJdnwNzD3E0ARmDxHv23Sa1o95Bi
 9V/dCZ7w5Al9K/kpJP70kp7FvHOn3IvZq/Osv1uXq0BE+tvzEPX8ibzxZZZEYqyF7P
 vmzkiY7J3nU7fTBviIZpFFMgcNyCuXMzVAaC+2VFjgxUiQ5h7Lpgy/B38iD3dNsoId
 wWIhLVBq5OZiA==
Message-ID: <67a7f35d-5cc3-4b5f-968a-e4151c63eb74@kernel.org>
Date: Mon, 11 Mar 2024 11:54:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1709892753-27461-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1709892753-27461-1-git-send-email-zhiguo.niu@unisoc.com>
X-Headers-End: 1rjWjt-0003Mb-8g
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to remove f2fs_bug_on in
 add_bio_entry
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
Cc: hongyu.jin@unisoc.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/3/8 18:12, Zhiguo Niu wrote:
> add_bio_entry should not trigger system panic when bio_add_page fail,
> fix to remove it.
> 
> Fixes: 0b20fcec8651 ("f2fs: cache global IPU bio")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   fs/f2fs/data.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d9494b5..f8ae684 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -759,8 +759,10 @@ static void add_bio_entry(struct f2fs_sb_info *sbi, struct bio *bio,
>   	be->bio = bio;
>   	bio_get(bio);
>   
> -	if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE)
> -		f2fs_bug_on(sbi, 1);
> +	if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
> +		bio_put(bio);

I didn't get it, why new created bio has no space to store one page?

Thanks,

> +		return;
> +	}
>   
>   	f2fs_down_write(&io->bio_list_lock);
>   	list_add_tail(&be->list, &io->bio_list);


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
