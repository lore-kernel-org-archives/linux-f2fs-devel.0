Return-Path: <SRS0=CQ2X=4F=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7BDC3B1BF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Feb 2020 01:43:29 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A74220718;
	Mon, 17 Feb 2020 01:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fbGZDvo0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="eVHaB5oY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A74220718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j3VRY-0008IP-V3; Mon, 17 Feb 2020 01:43:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1j3VRW-0008IH-Ts
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 17 Feb 2020 01:43:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DGR19/jpPmB+7sgZk70tFWUnhSGXqbZWwR9/XcPUNDU=; b=fbGZDvo03csbv7xL3KeniyaMOT
 bmWxJNBDiMOObMEPMrL2JdektdkNKqnJNWq9Ra7Mr1xkaYAV9+TduDbh8xTnZrNrgRh1vvHtNGVwA
 TsJkERCNV9Sz7smKouALlwvrFjixPmoMXLKsUNS5fonVgAdcZqo+S+9tKcbzNPFeS9O4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DGR19/jpPmB+7sgZk70tFWUnhSGXqbZWwR9/XcPUNDU=; b=eVHaB5oYrv+1lFJD3kNncrU4pt
 8fGcrJBE8MsA48u6vDcggV2V+u5DW8MYlLDauPC+U/hRBM4O0Y8zBfQU6kIwietEJqiRMB9Qfol8c
 GHBM3m4Ci6UkMYv0zvK6OeNtYCodk6FTwVDUQd1QnychQ0YTshGAP8nci9Yd9MJGX/vA=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j3VRV-00601l-18
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 17 Feb 2020 01:43:26 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id E7242A1C8C2048FB5443;
 Mon, 17 Feb 2020 09:43:14 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 17 Feb
 2020 09:43:10 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>
References: <20200214185855.217360-1-jaegeuk@kernel.org>
 <20200214185855.217360-2-jaegeuk@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <8b66e722-202b-b3b8-1543-e74379319a7f@huawei.com>
Date: Mon, 17 Feb 2020 09:43:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200214185855.217360-2-jaegeuk@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1j3VRV-00601l-18
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: add migration count iff migration
 happens
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

BTW

f2fs: add migration count iff migration happens

typo: iff

On 2020/2/15 2:58, Jaegeuk Kim wrote:
> If first segment is empty and migration_granularity is 1, we can't move this
> at all.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/gc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 65c0687ee2bb..bbf4db3f6bb4 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1233,12 +1233,12 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>  							segno, gc_type);
>  
>  		stat_inc_seg_count(sbi, type, gc_type);
> +		migrated++;
>  
>  freed:
>  		if (gc_type == FG_GC &&
>  				get_valid_blocks(sbi, segno, false) == 0)
>  			seg_freed++;
> -		migrated++;
>  
>  		if (__is_large_section(sbi) && segno + 1 < end_segno)
>  			sbi->next_victim_seg[gc_type] = segno + 1;
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
