Return-Path: <SRS0=K3S8=XS=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632D8C3A5A6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Sep 2019 07:06:47 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3162E2064A;
	Mon, 23 Sep 2019 07:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="a8qzCjFo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Pkqj9Ke4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3162E2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iCIQo-0000hp-Qc; Mon, 23 Sep 2019 07:06:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1iCIQn-0000h2-1C
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Sep 2019 07:06:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:CC:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2lA1HOCaF2eOW9a0oSkgsIL4HWuFWH8nnC8N1zAFlO0=; b=a8qzCjFoF5RxGR8Z35vSw/z8d9
 jrOcg6dMrsdL6Qgs9cB/GTlL6kulDP0WwGp+s0U1Uf1sz6jlOGiDTbXEJs8xbroOmN2bDSlFba4kJ
 I9rkg3KYsZbCDxx/dmvi7LGHcbu99NZdCdsOf/+R1uEdf6PvFuH8KyrG2eImi3pjGL0w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:CC:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2lA1HOCaF2eOW9a0oSkgsIL4HWuFWH8nnC8N1zAFlO0=; b=Pkqj9Ke4IaD7iVNjS53lWd9mzr
 sWItWJUseGhp2U/MgnNBjB4rA6oVY2d0kEekaDOKKjQkeVHwd+ST0StahjD26c9Ue7dmz8MkCqHni
 P5Fm+yIiWYIkYaJVYxTELXa3PkjVAGpOk+lpUQsH/jaj9J3/TEXXAhsx8T1/L2Aa+rNk=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iCIQl-004uAe-IV
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Sep 2019 07:06:44 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 76095CCD52DBB59D8F9E;
 Mon, 23 Sep 2019 15:06:35 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 23 Sep
 2019 15:06:29 +0800
To: sunqiuyang <sunqiuyang@huawei.com>
References: <20190923042459.39377-1-sunqiuyang@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <d7f83357-a699-0ded-0d54-84fae054333c@huawei.com>
Date: Mon, 23 Sep 2019 15:06:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190923042459.39377-1-sunqiuyang@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1iCIQl-004uAe-IV
Subject: Re: [f2fs-dev] [PATCH 1/1] fsck.f2fs: check total_segments from
 devices in raw_super
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
Cc: jaegeuk@kernel.org, "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

+Cc f2fs mailing list

On 2019/9/23 12:24, sunqiuyang wrote:
> From: Qiuyang Sun <sunqiuyang@huawei.com>
> 
> For multi-device F2FS, we should check if the sum of total_segments from
> all devices matches segment_count.
> 
> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fsck/mount.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 4814dfe..7d268e3 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -782,6 +782,21 @@ int sanity_check_raw_super(struct f2fs_super_block *sb, enum SB_ADDR sb_addr)
>  		return 1;
>  	}
>  
> +	if (sb->devs[0].path[0]) {
> +		unsigned int dev_segs = le32_to_cpu(sb->devs[0].total_segments);
> +		int i = 1;
> +
> +		while (i < MAX_DEVICES && sb->devs[i].path[0]) {
> +			dev_segs += le32_to_cpu(sb->devs[i].total_segments);
> +			i++;
> +		}
> +		if (segment_count != dev_segs) {
> +			MSG(0, "Segment count (%u) mismatch with total segments from devices (%u)",
> +				segment_count, dev_segs);
> +			return 1;
> +		}
> +	}
> +
>  	if (secs_per_zone > total_sections || !secs_per_zone) {
>  		MSG(0, "Wrong secs_per_zone / total_sections (%u, %u)\n",
>  			secs_per_zone, total_sections);
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
