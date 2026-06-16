Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2A5CD98DA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Jun 2026 03:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sY0kawjXQKe0Syhk8+kqvHtiGeNKdzFPG3Ph4doH2Z0=; b=MTC1iwEHV6FNbxW93aWUKbGg2n
	3nCvYu1JWNm0WecnXpuMo1xyiztvBqEve12XGPXptiW2A2Owr/Yrhw3uvpeipMz55t5P/T+jbWrtg
	kwL8irtb7qWaNym30b8DTwLoXR3hm1icpD3ZaJ+e610czLfXWKg4DwvZflyjXIGxAxVs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZKFK-000879-Hl;
	Tue, 16 Jun 2026 03:13:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wZKFJ-000873-Fm
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 03:13:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6SzLj0H5lE1aSt8vA/tXV7KwiKEOW7kAr1Sy+xAL6UU=; b=UERdhEtbEMi0QQC6UslUrGHNz/
 7gp7J3vqPFMJC4VkjG4IUy7128Fn00Aa5C4cWVicEw2UBPrVT6ovVpphSELhxdBtrqZ5EaydlcLJZ
 apCsyLkCtwzW/LYiS7tubv89yewSSnu6/Q+q237lL5BXfoUYyZAkmt2qFSenLdH5/yUk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6SzLj0H5lE1aSt8vA/tXV7KwiKEOW7kAr1Sy+xAL6UU=; b=N+J7au3cWDITnEw0hArqqfN45C
 WiZNpi/J02X/bpJ+57LGkomNmSztAIbVo+EWAdB/CbTfQBJcVTpFg4jVLSC0NIA0oYHcucQxq4wAN
 tepqj8isuEWCBgmMOi3Bxb06fD8pFLSXJT5thnbMXJN8uCGxNNSz7NYhJ7gZVu1GHYC4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZKFE-0003CW-Qz for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 03:13:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A66B5600AB;
 Tue, 16 Jun 2026 03:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E168D1F00A3A;
 Tue, 16 Jun 2026 03:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781579614;
 bh=6SzLj0H5lE1aSt8vA/tXV7KwiKEOW7kAr1Sy+xAL6UU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=VBZp+q7cLntxQLWUlgn8kfGaZXaCvFo7gisQUAj3YEfJ1SUUDo2TXxsbbBE30T7Zb
 JBcS6OUl6xvchbErPSOAs0RocrBWCorC/SOf5B3oAS7sPp/Xt+lyiaxPGxj6Fq3UI4
 bxwDSQU3Nw4w5WdWow8f19zhm6F05+GMgsFgt4vOPJnDR0w//H/akhlzUz9WxUjYgc
 cxJBdrgIbErN5t1Dz7oa5sHnkOa7tdwf1KJh0VKO+cZDvW2Vd6zmKkSOe+H+m+zqsU
 0o9QQbZbXAFzVLqWi+AUK1a2UKOM6olyjKjEkpvN0tjlRUteTBcRAXKwtRt1/aXY2Q
 Mx45Sh3qtbI1Q==
Message-ID: <8810431d-8364-44d6-bac5-d879e67529b2@kernel.org>
Date: Tue, 16 Jun 2026 11:13:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260616014742.67236-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260616014742.67236-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wZKFE-0003CW-Qz
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: use post-decrement count for
 cp_wait wakeup
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: qiwenjie@xiaomi.com, geoo115@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/16/26 09:47, Wenjie Qi wrote:
> f2fs_write_end_io() decrements the writeback page counter and then
> reads it again with get_pages() to decide whether the last
> F2FS_WB_CP_DATA completion should wake cp_wait.
> 
> Use atomic_dec_return() for F2FS_WB_CP_DATA completions so the wakeup
> decision is made from the value produced by the decrement itself. Keep
> the existing dec_page_count() path for other writeback counters.
> 

Missing Fixes and Cc lines? Otherwise it looks good to me.

Thanks

> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
> Changes in v3:
> - Drop the waitqueue protocol change from v2.
> - Use atomic_dec_return() directly for F2FS_WB_CP_DATA and wake cp_wait
>   when the returned count reaches zero.
> 
>  fs/f2fs/data.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d83a21998ec2..58d23eb74ec2 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -392,15 +392,17 @@ static void f2fs_write_end_io(struct bio *bio)
>  		if (f2fs_in_warm_node_list(folio))
>  			f2fs_del_fsync_node_entry(sbi, folio);
>  
> -		dec_page_count(sbi, type);
> -
>  		/*
>  		 * we should access sbi before folio_end_writeback() to
>  		 * avoid racing w/ kill_f2fs_super()
>  		 */
> -		if (type == F2FS_WB_CP_DATA && !get_pages(sbi, type) &&
> -				wq_has_sleeper(&sbi->cp_wait))
> -			wake_up(&sbi->cp_wait);
> +		if (type == F2FS_WB_CP_DATA) {
> +			if (!atomic_dec_return(&sbi->nr_pages[type]) &&
> +			    wq_has_sleeper(&sbi->cp_wait))
> +				wake_up(&sbi->cp_wait);
> +		} else {
> +			dec_page_count(sbi, type);
> +		}
>  
>  		folio_clear_f2fs_gcing(folio);
>  		folio_end_writeback(folio);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
