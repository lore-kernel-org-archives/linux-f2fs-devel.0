Return-Path: <SRS0=1yAE=CZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9219CC43461
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Sep 2020 02:57:27 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BA020708;
	Wed, 16 Sep 2020 02:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="O8YCfXEV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="OSAWVK2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BA020708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kINdM-0004vc-UN; Wed, 16 Sep 2020 02:57:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kINdM-0004vV-4g
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 Sep 2020 02:57:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q+26+mp7VnphMcUKWoEP2axhX3QPkQb0FK89P8qwoeA=; b=O8YCfXEV+WqP+v3xszW2QunHmc
 nDHcaplCXUxsoLlFem4Jjlht3zYY81zCZm4XzEP54pJYTLOf02hvcuLVA+cv2pDEMnePUltv5RA3i
 SIkGo8NMB/5xGmWPaKrZQ8JCwGOrjvgAyEK6bHi0bQE+58Lsm8Z2hPNjZkA+C1a67PbQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=q+26+mp7VnphMcUKWoEP2axhX3QPkQb0FK89P8qwoeA=; b=OSAWVK2Ys2tBylmVJs3C6E1hGo
 WMqXd3J18mOPfCfAsLw8FQowQgaJHwGkA69Lkl2113olE0YNuA2J+ufyGwezDTXZ4UHDTjlSSkzPM
 Mufpv6JuBgo8P0yEOOcpVD9lmtXEqS7V9+Dj7I6wZ/I2Xs+5C+6onZtAt+ygdm0qGooE=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kINdF-00AjsW-Hn
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 Sep 2020 02:57:24 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6DC556373FC5391D89B1;
 Wed, 16 Sep 2020 10:57:07 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 16 Sep
 2020 10:56:59 +0800
To: Xiaojun Wang <wangxiaojun11@huawei.com>, <jaegeuk@kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>
References: <20200916015410.4135737-1-wangxiaojun11@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <3041cb44-8666-1db2-7474-367cf19f46c7@huawei.com>
Date: Wed, 16 Sep 2020 10:56:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200916015410.4135737-1-wangxiaojun11@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1kINdF-00AjsW-Hn
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix wrong total_sections check
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/9/16 9:54, Xiaojun Wang wrote:
> Meta area is not included in section_count computation.
> The code in mkfs/f2fs_format.c is:
> 	total_zones = get_sb(segment_count) / (c.segs_per_zone) -
> 					total_meta_zones;
> 	set_sb(section_count, total_zones * c.secs_per_zone);
> 
> So the minimum total_sections is 1.
> 
> Signed-off-by: Xiaojun Wang <wangxiaojun11@huawei.com>
> ---
>   fs/f2fs/super.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index dfa072fa8081..a450c8589841 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2799,8 +2799,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>   		return -EFSCORRUPTED;
>   	}
>   
> -	if (total_sections > segment_count ||
> -			total_sections < F2FS_MIN_SEGMENTS ||
> +	if (total_sections > segment_count || total_sections < 1 ||
>   			segs_per_sec > segment_count || !segs_per_sec) {

Here, we try to check sanity on segs_per_sec config directly and indirectly:
- directly: check raw_super->segs_per_sec field
- indirectly: check whether segment_count / total_sections is less than 1

So I guess that first condition is wrong as well, should change it like?

if (total_sections > segment_count - 'total_meta_segment_count' ||

Thoughts?

Thanks,

>   		f2fs_info(sbi, "Invalid segment/section count (%u, %u x %u)",
>   			  segment_count, total_sections, segs_per_sec);
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
