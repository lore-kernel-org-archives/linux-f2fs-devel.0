Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4BEC43334
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  1 Jul 2022 00:50:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o74rm-0004ZC-I5; Fri, 01 Jul 2022 00:50:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1o74rc-0004Xs-Ud
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Jul 2022 00:50:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WEkclx18PYJphWSMM9XRdyATVjDYwESm2P8g+pIndEg=; b=W1CsbSqu9RJTCfYLP+OqkY+EkF
 9TOugG/RwxKOJeg1el7eAZNucHmqUefx3u/bgChXZHff57BBXVvur6nMv0vLGEqM6LATgjsxRKbI/
 fSjcuzRZ1SCix+I25at2aEc23aOWvltkHV65ly6+9onlIvaH/u+3zqDtDUbAGrjr/El4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WEkclx18PYJphWSMM9XRdyATVjDYwESm2P8g+pIndEg=; b=ddPb1BZIl9zoCdd5IuD94Lp4X5
 +SZ6C+bSDwGqw8F9gVVle35fxdbEEjaICbJ9dpcD6VqeavJ9FSwlA1U9c1Ue0kSUil29ycXG+ABtI
 45qe6z8SM1YluXdYv0ebwFdsdGVyZS5jF/Cydr/ZzqUjpzcd8aAD0U6uflR4761TSHf4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o74rV-00086p-T2
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Jul 2022 00:50:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7724C61F87;
 Fri,  1 Jul 2022 00:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94383C341C7;
 Fri,  1 Jul 2022 00:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656636607;
 bh=bxvdgd9kqA3Z8JrdSYeYKq3GX3TDNTe2VkSUMdkkC70=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RNuAM8tJNmv/t1c4/iTjobFlbqr57QjMc+Ywt3fx+l+LKPV+5H35MaW5BqW3OlYbj
 E9K/xMsmWkkhLBHWRtgCPLGzwedzaafmmLJZpWZB2bVOAEO+MJA8c/v23qMKAxJ9zm
 070CH3EKsOZ3zJkbW8IRIJUgyGrbqEQdd8F63FrkpGdNzZaaPPd+6kuPjVuei7XwNo
 DDJX+KHDHKIdkFrUZMXkJkbx2GyApHN6EPM4yfSum6sSwbWz6TFlNLlSLNLTPwMzoQ
 58eGGT+e8eF/1Pcq7obXDzL2B1hXz6aKgbUzHJH7o+Gs7M5FmCYBZNUeVVVbukqnBu
 LoRbHBiFfeD3g==
Message-ID: <a766299e-1a75-5293-dfeb-8f5d6c395644@kernel.org>
Date: Fri, 1 Jul 2022 08:50:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To: Guowei Du <duguoweisz@gmail.com>, jaegeuk@kernel.org
References: <20220630112629.6611-1-duguoweisz@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220630112629.6611-1-duguoweisz@gmail.com>
X-Headers-End: 1o74rV-00086p-T2
Subject: Re: [f2fs-dev] [PATCH 7/7] f2fs: optimize shrink count
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
Cc: linux-kernel@vger.kernel.org, duguowei <duguowei@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/6/30 19:26, Guowei Du wrote:
> From: duguowei <duguowei@xiaomi.com>
> 
> Remove the local variable 'run_no', add comments for better
> reading.

Not sure, I guess original implementation considers the race condition for
f2fs_shrink_scan vs f2fs_shrink_scan case? so it uses a local variable to
keep the per-round context info?

Jaegeuk, please help to check that.

Thanks,

> 
> Signed-off-by: duguowei <duguowei@xiaomi.com>
> ---
>   fs/f2fs/shrinker.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
> index dd3c3c7a90ec..7e439496dfca 100644
> --- a/fs/f2fs/shrinker.c
> +++ b/fs/f2fs/shrinker.c
> @@ -76,18 +76,18 @@ unsigned long f2fs_shrink_scan(struct shrinker *shrink,
>   	unsigned long nr = sc->nr_to_scan;
>   	struct f2fs_sb_info *sbi;
>   	struct list_head *p;
> -	unsigned int run_no;
>   	unsigned long freed = 0;
>   
>   	spin_lock(&f2fs_list_lock);
> -	do {
> -		run_no = ++shrinker_run_no;
> -	} while (run_no == 0);
> +	shrinker_run_no++;
> +	/* if overflow, next loop needs to skip number 0 */
> +	if (!shrinker_run_no)
> +		shrinker_run_no = 1;
>   	p = f2fs_list.next;
>   	while (p != &f2fs_list) {
>   		sbi = list_entry(p, struct f2fs_sb_info, s_list);
>   
> -		if (sbi->shrinker_run_no == run_no)
> +		if (sbi->shrinker_run_no == shrinker_run_no)
>   			break;
>   
>   		/* stop f2fs_put_super */
> @@ -97,7 +97,7 @@ unsigned long f2fs_shrink_scan(struct shrinker *shrink,
>   		}
>   		spin_unlock(&f2fs_list_lock);
>   
> -		sbi->shrinker_run_no = run_no;
> +		sbi->shrinker_run_no = shrinker_run_no;
>   
>   		/* shrink extent cache entries */
>   		freed += f2fs_shrink_extent_tree(sbi, nr >> 1);


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
