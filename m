Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB35C76196
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  1 Apr 2023 00:53:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1piPV1-0000st-N0;
	Sat, 01 Apr 2023 00:53:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1piPUz-0000sn-Lb
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 01 Apr 2023 00:53:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lBtzpYqnxJz8Ov7OLA9QfA6nDlEApgePZYUvczv9mRc=; b=FR74eUoqXR5DwIXy3kLK/SqzfJ
 wD6GgUT/7s5yTmPUnM3z6rpG0OSMj9aBqitsOZTgoGrWnnvL4agxqtN6jZ5QBoNCVqHLxNjmtCcfJ
 6rwjDvWWga4gcDsHD3YLiugZfuYf9JW2hGzBBc1oMXL68AvKeOSVsASl3VuSosT1uPwE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lBtzpYqnxJz8Ov7OLA9QfA6nDlEApgePZYUvczv9mRc=; b=kEHLPYaAISo/ro/M+eVVKNJ2vh
 FUShOYyGxHIPx7sB26uOwrcGiAFOalZv/lexKIJpBwrttmumLy/4EF7VJOKbA8S5jRxjCwdyXkCsN
 DlLp75LMskELMvaFZSgcEwztraMpmYuA3zLPyiAmXoZfiMlUUSSFeEZL1sbZgJyg8+HE=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1piPUx-0000PR-V8 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 01 Apr 2023 00:53:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A3747B8321E;
 Sat,  1 Apr 2023 00:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E05C433D2;
 Sat,  1 Apr 2023 00:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680310412;
 bh=tjj1t2PTYkZFmbtF1kyMqydk62CVEgDkZgmOGSTAPhM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=l8k6O9jpxq+f4XQI/SnWJhczCG4eHTK8BxXQ2hirUpQf7vYHBO4O4/dTdcXotCGhO
 0/Ba8QBDcEUhB0y8O1hY6KcqQWAV28h7H3ow2X/X3cr88D21K5ajedCoDqwTij6IfC
 YC49epT+pGYkWmkbFvthWkrgMYDeTkpem2Gx5exh/IfAf4HvYkI5eCJqouWIehQb0d
 mWyoo0brrvrJwnyYMwMh16J1vM+7Ve7pGq7VHQilU+3rDe0BwDfU2C4TyyzLYO3JNl
 NkaRMuF67VgNyZaS8taJUy+4PMuCHYGDKAxZsW10Lf/6TTRn2kRytLEjtAT0lCmwOi
 yNoUSAGh/vDoA==
Message-ID: <203ef118-30ca-0ce9-f73e-c5ee45f61369@kernel.org>
Date: Sat, 1 Apr 2023 08:53:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: Bo Ye <bo.ye@mediatek.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20230331092658.72386-1-bo.ye@mediatek.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230331092658.72386-1-bo.ye@mediatek.com>
X-Headers-End: 1piPUx-0000PR-V8
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix iostat lock protection
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
Cc: Qilin Tan <qilin.tan@mediatek.com>, yongdong.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, light.hsieh@mediatek.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-mediatek@lists.infradead.org,
 browse.zhang@mediatek.com, linux-arm-kernel@lists.infradead.org,
 peng.zhou@mediatek.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/3/31 17:26, Bo Ye wrote:
> From: Qilin Tan <qilin.tan@mediatek.com>
> 
> Made iostat lock irq safe to avoid potentinal deadlock.
> 
> Deadlock scenario:
> f2fs_attr_store
>    -> f2fs_sbi_store
>    -> _sbi_store
>    -> spin_lock(sbi->iostat_lock)
>      <interrupt request>
>      -> scsi_end_request
>      -> bio_endio
>      -> f2fs_dio_read_end_io
>      -> f2fs_update_iostat
>      -> spin_lock_irqsave(sbi->iostat_lock)  ===> Dead lock here
> 

Fixes: 61803e984307 ("f2fs: fix iostat related lock protection")
Fixes: a1e09b03e6f5 ("f2fs: use iomap for direct I/O")

> Signed-off-by: Qilin Tan <qilin.tan@mediatek.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> ---
>   fs/f2fs/sysfs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 0b19163c90d4..fd238a68017e 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -575,9 +575,9 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   	if (!strcmp(a->attr.name, "iostat_period_ms")) {
>   		if (t < MIN_IOSTAT_PERIOD_MS || t > MAX_IOSTAT_PERIOD_MS)
>   			return -EINVAL;
> -		spin_lock(&sbi->iostat_lock);
> +		spin_lock_irq(&sbi->iostat_lock);
>   		sbi->iostat_period_ms = (unsigned int)t;
> -		spin_unlock(&sbi->iostat_lock);
> +		spin_unlock_irq(&sbi->iostat_lock);
>   		return count;
>   	}
>   #endif


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
