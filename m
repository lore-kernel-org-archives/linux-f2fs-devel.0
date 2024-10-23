Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576FDD2E008
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Oct 2024 02:42:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t3RKX-0004Kx-0D;
	Wed, 23 Oct 2024 02:42:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t3RKU-0004Kq-QY
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Oct 2024 02:42:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mDZI/C7vp+hCZhVGKpJ1IiCir/6LTD2QSKlBK2u430E=; b=ZsAeayLlmoZMBHY/BD+FFP/3qL
 2p1ELM8THNfMI1Ywb3OEmRKd/V6g78boAWcLLWoeK0N1HHKoHCuIgezPtp5VipaQhIzqp6Ra+j+4S
 E7LQ94NxmiaHdcUrZR6yJe9XXK9yTr1ywi0a6KXng7ZN33Uvl71oGrMcp8rllrF2h0vA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mDZI/C7vp+hCZhVGKpJ1IiCir/6LTD2QSKlBK2u430E=; b=VGpNuevfhwOb1UGi+mwrQraB0n
 MLCNAZysmimIKV9uaL6/fERtO2TiA5mzIY651XC3teBVfKn0EahLepvxCaQdYxZ5MQ9xtzboUzqJo
 pT/GQ1TIiHqH93QGuRiXMQHUsIrKdmu/XiFW+M1MdBNCrw1szbQwkIqR1dAnbLO77RBA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t3RKU-0004HD-4D for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Oct 2024 02:42:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 167C65C5E4F;
 Wed, 23 Oct 2024 02:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D22EC4CEE4;
 Wed, 23 Oct 2024 02:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729651348;
 bh=zmCAxVblrWxgvcfRLK0nZDoD+ZC3BM86UGf4ASXgOBY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=IoDhXfQfFC2mf8gvAAVjFcSlfHCpzeq9Z4wNPH2GOLJJLDW+PFkvCv/fA+cmoumZk
 x6DrvFLLwovMFNRlFxgWoRN9RliTdpr33kHVgizWexIVcYuFK5xbwAxGFP5aO9hidt
 nk8i69Oi6J9GLxjIjx45Bl8mOv5zBxPAGsSsl8n7teIxPAwgIfgB+hmZrzxSk+xDKK
 F1In2AZlH0KfYQeKcG0q2ETpyv32gg+820E6mqEALB+kF1/QuqI5k3RbSJRSLMkW5R
 AKYLdJmMSSXKjFZVaHR3uX3PcJqQH9TPBpGX7iMt3o6mcy7B+Yq778LMu74GyM0pF5
 YKZDdwt9JFBNw==
Message-ID: <28ad2c90-a95c-440a-ae6a-5fb19bacd252@kernel.org>
Date: Wed, 23 Oct 2024 10:42:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1729588481-29390-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
In-Reply-To: <1729588481-29390-1-git-send-email-zhiguo.niu@unisoc.com>
X-Headers-End: 1t3RKU-0004HD-4D
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid use GC_AT when setting
 gc_mode as GC_URGENT_MID
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Hao_hao.Wang@unisoc.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/10/22 17:14, Zhiguo Niu wrote:
> GC_URGENT_MID is introduced by commit
> d98af5f45520 ("f2fs: introduce gc_urgent_mid mode"), aim to does GC
> forcibly uses cost benefit GC approach, but if ATGC is enabled at
> the same time, Age-threshold approach will be selected, which can only
> do amount of GC and it is much less than the numbers of CB approach.

gc urgent low(2): lowers the bar of checking I/O idling in
		  order to process outstanding discard commands and GC a
		  little bit aggressively. uses cost benefit GC approach.

GC_URGENT_LOW uses CB algorithm as well?

Thanks,

> 
> some traces:
>    f2fs_gc-254:48-396     [007] ..... 2311600.684028: f2fs_gc_begin: dev = (254,48), gc_type = Background GC, no_background_GC = 0, nr_free_secs = 0, nodes = 1053, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:0
>    f2fs_gc-254:48-396     [007] ..... 2311600.684527: f2fs_get_victim: dev = (254,48), type = No TYPE, policy = (Background GC, LFS-mode, Age-threshold), victim = 10, cost = 4294364975, ofs_unit = 1, pre_victim_secno = -1, prefree = 0, free = 44898
>    f2fs_gc-254:48-396     [007] ..... 2311600.714835: f2fs_gc_end: dev = (254,48), ret = 0, seg_freed = 0, sec_freed = 0, nodes = 1562, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:0
>    f2fs_gc-254:48-396     [007] ..... 2311600.714843: f2fs_background_gc: dev = (254,48), wait_ms = 50, prefree = 0, free = 44898
>    f2fs_gc-254:48-396     [007] ..... 2311600.771785: f2fs_gc_begin: dev = (254,48), gc_type = Background GC, no_background_GC = 0, nr_free_secs = 0, nodes = 1562, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:
>    f2fs_gc-254:48-396     [007] ..... 2311600.772275: f2fs_gc_end: dev = (254,48), ret = -61, seg_freed = 0, sec_freed = 0, nodes = 1562, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:0
> 
> Fixes: d98af5f45520 ("f2fs: introduce gc_urgent_mid mode")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   fs/f2fs/gc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index e40bdd1..daecf69 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -257,6 +257,7 @@ static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)
>   
>   	switch (sbi->gc_mode) {
>   	case GC_IDLE_CB:
> +	case GC_URGENT_MID:
>   		gc_mode = GC_CB;
>   		break;
>   	case GC_IDLE_GREEDY:



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
