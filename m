Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77233C4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 28 Apr 2024 11:23:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s12d1-0000N5-5Y;
	Sun, 28 Apr 2024 11:23:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1s12cz-0000Mz-P3
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 28 Apr 2024 11:23:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=omsczfUp2PRD193Ej/snc5CN5dzLUiN3eOK3p09kAtE=; b=KCeOrLrL1shvJXxRhRQV6UGAuc
 g5/rFyX92BrOM76nfr52es250DVbWP6+HOB/OrkWRzhC2+isqTpQWW9miu58JAuqjSbsspV9XQdvm
 bBlfScFkJi5FCxI1tojO9mpvYuJ2WHm3wiCcedis17wgfHzRwUyXzGt5TTnLnJBw3xC0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=omsczfUp2PRD193Ej/snc5CN5dzLUiN3eOK3p09kAtE=; b=AjHboUOhpmJ9AjzHUHaal7eR2T
 I+Mq9yyozwELUT559yGsbQHhBquNxqU1pUy2yDxaw0hu2h7EB0MXzBsRPY+aJLTaJEOMX2fEFtqH9
 3U1srNFF+Q4y4DB5vv7A4fIZDmIZZXMKveYyhXZDicGy0IVt+kOSNuQTf51CGjrnXx4c=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s12cy-0008Kg-Qx for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 28 Apr 2024 11:23:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DE9476066C;
 Sun, 28 Apr 2024 11:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2643C113CC;
 Sun, 28 Apr 2024 11:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714303403;
 bh=qeSlEnULi1s8O4qV+q5O9CH7dsCvGcClXmiaLVpkARU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=a7+xVqZTUUSVCh78XU7dKkzK7vgpylcPKZADLwILLepCP75gkYNa0cI2nTDogIpTO
 7MsAUvTh+U2PbWMfKIpBsv20imwXHA8/xOY70KL01Jiv4dbbFdkaKDCveTiQldivav
 RWGTUoqd90ptzANwEvFV2ey6JNsnQb3UbjIu5/1fW5zaZAfnwfSUGHLIYAxeIZwk0U
 MyeY7ZweBumfxBDCy+lsDE4Kzr3G1UcZIag4u636Hmmc+D7I/9TQjVUya7t5BSPrB0
 hPB+3Zifi2ObG+g0yFEj57Uhql//uEHqlsz3O+YgaNtd3wUFgqfbQuHxEv+YpgnOU3
 7O6z4QV509KIg==
Message-ID: <7f97aae7-557d-4fac-854b-594e99939598@kernel.org>
Date: Sun, 28 Apr 2024 19:23:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20240428111457.17224-1-liaoyuanhong@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240428111457.17224-1-liaoyuanhong@vivo.com>
X-Headers-End: 1s12cy-0008Kg-Qx
Subject: Re: [f2fs-dev] [PATCH] f2fs:remove the restriction on zone sector
 being align to pow2
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
Cc: linux-kernel@vger.kernel.org, bo.wu@vivo.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/4/28 19:14, Liao Yuanhong wrote:
> For zoned-UFS, sector size may not aligned to pow2, so we need to remove
> the pow2 limitation.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>   drivers/md/dm-table.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 41f1d731ae5a..823f2f6a2d53 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c

Hi, please discuss this in dm-devel@lists.linux.dev, thanks.

Thanks,

> @@ -1663,10 +1663,6 @@ static int validate_hardware_zoned(struct dm_table *t, bool zoned,
>   		return -EINVAL;
>   	}
>   
> -	/* Check zone size validity and compatibility */
> -	if (!zone_sectors || !is_power_of_2(zone_sectors))
> -		return -EINVAL;
> -
>   	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {
>   		DMERR("%s: zone sectors is not consistent across all zoned devices",
>   		      dm_device_name(t->md));


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
