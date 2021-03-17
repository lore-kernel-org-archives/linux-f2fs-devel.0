Return-Path: <SRS0=WiIO=IP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFA7C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Mar 2021 09:10:06 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3139B64F30
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Mar 2021 09:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3139B64F30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lMSBo-0004vi-G2; Wed, 17 Mar 2021 09:10:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1lMSBm-0004vR-PR
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Mar 2021 09:10:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nuCt0nHGdV2181I8HISOdeeOjaITPJuX5H4709bh3G8=; b=KRYfIHdJzvDdzVipWN+BgsG+a5
 r9yvpfEQtQ7N4nGTw1+uKrFEmSA12HKatHZJWtJ/Nz+lw4ntptRLbwYdzCmT2HDpSXZBcZW7Ag2+z
 UQEdtwtHaOVHmED/XODf2BpH4okN6+wPWos/ncBHrYg02E/k3YZcwQvsKBYHelwFY+nk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nuCt0nHGdV2181I8HISOdeeOjaITPJuX5H4709bh3G8=; b=bNp7Ol/Jtz/0ToeBJ38y4ymApI
 wG91ejOejTCv4A/8YCm/e74lUb0Edp+04CfGm0lEv9n7Mo0te2nthlahNiTJFi/gcJmGxdCJsGnTd
 sj39ssXrgJwagMZRmUtlgtqJjt/xcQXBSF5C+TPcGDw6bi6rpKkjHenFZ2OXm79UeSgs=;
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lMSBe-00038q-Be
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Mar 2021 09:10:02 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F0knK6V8FzNp5l;
 Wed, 17 Mar 2021 17:07:17 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 17 Mar
 2021 17:09:36 +0800
To: Weichao Guo <guoweichao@oppo.com>, <jaegeuk@kernel.org>, <chao@kernel.org>
References: <1615969728-21161-1-git-send-email-guoweichao@oppo.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <b1d2dc59-3e39-f31e-5678-a9f7ee693d1f@huawei.com>
Date: Wed, 17 Mar 2021 17:09:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1615969728-21161-1-git-send-email-guoweichao@oppo.com>
Content-Language: en-US
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
X-Headers-End: 1lMSBe-00038q-Be
Subject: Re: [f2fs-dev] [PATCH] f2fs: do not use AT_SSR mode in FG_GC & high
 urgent BG_GC
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
Cc: fh@oppo.com, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/3/17 16:28, Weichao Guo via Linux-f2fs-devel wrote:
> AT_SSR mode is introduced by age threshold based GC for better
> hot/cold data seperation and avoiding free segment cost. However,
> LFS write mode is preferred in the scenario of foreground or high
> urgent GC, which should be finished ASAP. Let's only use AT_SSR
> in background GC and not high urgent GC modes.
> 
> Signed-off-by: Weichao Guo <guoweichao@oppo.com>
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---

v2:
...

>   fs/f2fs/gc.c      | 3 ++-
>   fs/f2fs/segment.c | 4 +++-
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 86ba8ed..0f2c34f 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1120,7 +1120,8 @@ static int move_data_block(struct inode *inode, block_t bidx,
>   	block_t newaddr;
>   	int err = 0;
>   	bool lfs_mode = f2fs_lfs_mode(fio.sbi);
> -	int type = fio.sbi->am.atgc_enabled ?
> +	int type = fio.sbi->am.atgc_enabled && gc_type == BG_GC &&
> +				fio.sbi->gc_mode != GC_URGENT_HIGH ?
>   				CURSEG_ALL_DATA_ATGC : CURSEG_COLD_DATA;

Minor thing:

.. && (gc_type == BG_GC) &&
(fio.sbi->gc_mode != GC_URGENT_HIGH)

I guess it will be better to use parenthesis to improve readability,
so that we don't need to check priority from different operators.

>   
>   	/* do not read out */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 32b915e..81be3e9 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3264,7 +3264,9 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>   		struct inode *inode = fio->page->mapping->host;
>   
>   		if (is_cold_data(fio->page)) {
> -			if (fio->sbi->am.atgc_enabled)
> +			if (fio->sbi->am.atgc_enabled &&
> +				fio->io_type == FS_DATA_IO &&
> +				fio->sbi->gc_mode != GC_URGENT_HIGH)

Ditto,

Otherwise, it looks good to me, you can add below tag in next version:

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>   				return CURSEG_ALL_DATA_ATGC;
>   			else
>   				return CURSEG_COLD_DATA;



> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
