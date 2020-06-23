Return-Path: <SRS0=bwqY=AE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34021C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:35:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F390C2064B;
	Tue, 23 Jun 2020 09:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="PoH31jcm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="BQLiRUxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F390C2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jnfKu-0005GH-Nh; Tue, 23 Jun 2020 09:35:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jnfKt-0005GA-Hb
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Jun 2020 09:35:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zDLu6jMHmeCRw0Kx0RBFL5aPBk8wdfqYRdBGaStp5X0=; b=PoH31jcm3vxbfBR73agnwlBC2/
 A0wblhkoSyV+cxqyaQIawMYTVcbDPN79x9+WtbJC6KRP984+1i7iyJcEPSBlB3ulCvKrahv1NX4qI
 Ch1D11QqeIS9OS6com5Mca+hEyhx7fFUJC1a1W2okDliNGpw6udjQzopPTUTeAt1WW+g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zDLu6jMHmeCRw0Kx0RBFL5aPBk8wdfqYRdBGaStp5X0=; b=BQLiRUxk5/n+OpADmIClb6HgpI
 +7lJmZIs3+BgEN9TiYBIg/UTHZbFv4dJ/sNzwi1oMTDvqABYQsEAZIJ1pGq/sbBUIEHg0dUiDMFfl
 corOGouCVKK4SWQDLsL1Yo6Ctw9zIs4Rdl0QKSOg+oW16prCGT+7UI5bYbEX2n3C0zs8=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jnfKr-00F49A-Bb
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Jun 2020 09:35:23 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id E84F3FDA738BE5621311;
 Tue, 23 Jun 2020 17:34:58 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 23 Jun
 2020 17:34:52 +0800
To: z00520423 <zhangqilong3@huawei.com>, <jaegeuk@kernel.org>
References: <20200623071446.44106-1-zhangqilong3@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <45f5e30c-e8eb-b587-c029-57fafe4dcf4f@huawei.com>
Date: Tue, 23 Jun 2020 17:34:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200623071446.44106-1-zhangqilong3@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jnfKr-00F49A-Bb
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: add f2fs_gc exception handle in
 f2fs_ioc_gc_range
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/6/23 15:14, z00520423 wrote:
> From: Qilong Zhang <zhangqilong3@huawei.com>
> 
> When f2fs_ioc_gc_range performs multiple segments gc ops, the return
> value of f2fs_ioc_gc_range is determined by the last segment gc ops.
> If its ops failed, the f2fs_ioc_gc_range will be considered to be failed
> despite some of previous segments gc ops succeeded. Therefore, so we
> fix: only all of segments gc ops are finished will return success.
> 
> Signed-off-by: Qilong Zhang <zhangqilong3@huawei.com>
> ---
>  fs/f2fs/file.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 3268f8dd59bb..b81fcf9b123d 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2527,6 +2527,10 @@ static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
>  	}
>  
>  	ret = f2fs_gc(sbi, range.sync, true, GET_SEGNO(sbi, range.start));
> +	if (ret) {

-ENODATA means 1) target section has no valid blocks or 2) the section has valid blocks,
but it is opened segment, IMO, for 1) condition, we can wrap return value to zero,
continue to gc later sections, for 2) condition, we'd better to return -EBUSY as a hint
to user to call the interface later again.

get_victim_by_default():

	if (*result != NULL_SEGNO) {
		if (get_valid_blocks(sbi, *result, false) &&
			!sec_usage_check(sbi, GET_SEC_FROM_SEG(sbi, *result)))
			p.min_segno = *result;
		goto out;
	}

> +		ret = -EAGAIN;
> +		goto out;
> +	}
>  	range.start += BLKS_PER_SEC(sbi);
>  	if (range.start <= end)
>  		goto do_more;
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
