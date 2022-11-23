Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28DBC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Nov 2022 15:47:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oxrxq-00063p-7k;
	Wed, 23 Nov 2022 15:47:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oxrxg-00062o-SF
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Nov 2022 15:46:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LJu0TmhjDhWwiGMo+WxIxQJH39yu6QlaOnRKRR83GEU=; b=O7fyHElLa2S/QPHNc7tD3vsays
 lajB2z/9PcF+lwK0+qY2yfh6cEmdb/s7jElu4Y8hiv0g8yvaFFAw80mP306KruPnbpCcw5Zhc39lZ
 7K8DAS+mRhdVBdyWSmO5AcvzihzXdLvl5HdQN6nl/zXEdH5i6IYTKPnd2UJSiLKHQXIE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From:
 References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LJu0TmhjDhWwiGMo+WxIxQJH39yu6QlaOnRKRR83GEU=; b=USV7jJWxT9xIPdXBuPWeVDpR+r
 uXimcripCmpDiW0gG3r0Bw48si5qSvmw7Kf/b/bIFTFCsVrLW1vFPjMPTT+qTlJr3GpLkGsN5BVTa
 yMn3eCu7ll3yS7Y54UOcPaIJ5yShCa8jFj4zQ3XM6kc2TkEGqCKQU3vIXRUCYthATbCA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oxrxg-00GEjn-9p for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Nov 2022 15:46:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E343761DA0;
 Wed, 23 Nov 2022 15:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96649C433C1;
 Wed, 23 Nov 2022 15:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669218410;
 bh=fMHohl1y+955lLmTpi2tLvD/r7UkVxQuFIwe8yXhFKU=;
 h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
 b=kZ54ClvGRAcCRbo4yafEeK1LZ+WQvZGty/fSORkFZ6PEfvLkzVyHVTOf7G3NVOGjW
 lB83NmIgIjrbdCowUVihhcit5mfRHW98PK1dwP1e1y0WRZOmvI5EAczJDOHPm0qZ8/
 R1QfEnq8wDpPBzxf0HO7pRPfhUx1Vh5jTfwFPC+ONEHt3k+jcCh2XvgdK8vvSRUcXY
 JsjLXwQY9sG4L0tb5XOhL2pQ6KL9SwHnOhD26l6XjKtvpErzxSCuFjVfm9mI1Xhq1C
 yh6/wnCK+sAkLeaYlh1VDQKZrmDkScMvjynJvhDgsXKp+ho8Sdq2NUOjjWlsaRDlxz
 7X9FqAWzaO2pQ==
Message-ID: <6565e795-d0bb-1e96-7c8e-94409dfd69cb@kernel.org>
Date: Wed, 23 Nov 2022 23:46:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20221118180208.66578-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221118180208.66578-1-frank.li@vivo.com>
X-Headers-End: 1oxrxg-00GEjn-9p
Subject: Re: [f2fs-dev] [PATCH] f2fs: define
 DEFAULT_SMALL_VOLUME_DISCARD_GRANULARITY macro
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/11/19 2:02, Yangtao Li wrote:
> Do cleanup in f2fs_tuning_parameters(), let's use macro
> instead of number.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/f2fs.h  | 2 ++
>   fs/f2fs/super.c | 2 +-
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f0833638f59e..86c651884d26 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -329,6 +329,8 @@ struct discard_entry {
>   	unsigned char discard_map[SIT_VBLOCK_MAP_SIZE];	/* segment discard bitmap */
>   };
>   
> +/* default discard granularity for small device, unit: block count */
> +#define DEFAULT_SMALL_VOLUME_DISCARD_GRANULARITY 1

/* minimum discard granularity, unit: block count */
#define MIN_DISCARD_GRANULARITY		1

>   /* default discard granularity of inner discard thread, unit: block count */
>   #define DEFAULT_DISCARD_GRANULARITY		16
>   /* default maximum discard granularity of ordered discard, unit: block count */
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 31435c8645c8..7c32eabcf50c 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4080,7 +4080,7 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
>   	/* adjust parameters according to the volume size */
>   	if (MAIN_SEGS(sbi) <= SMALL_VOLUME_SEGMENTS) {
>   		if (f2fs_block_unit_discard(sbi))
> -			SM_I(sbi)->dcc_info->discard_granularity = 1;
> +			SM_I(sbi)->dcc_info->discard_granularity = DEFAULT_SMALL_VOLUME_DISCARD_GRANULARITY;

			SM_I(sbi)->dcc_info->discard_granularity =
						MIN_DISCARD_GRANULARITY;

Thanks,

>   		SM_I(sbi)->ipu_policy = 1 << F2FS_IPU_FORCE |
>   					1 << F2FS_IPU_HONOR_OPU_WRITE;
>   	}


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
