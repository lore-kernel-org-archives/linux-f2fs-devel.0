Return-Path: <SRS0=5IuM=EM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7E0C2D0A3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:37:59 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F672151B;
	Fri,  6 Nov 2020 17:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="VN50jd3C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ghWGr0cS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="O8ZZhEUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F672151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kb5gS-00024u-OX; Fri, 06 Nov 2020 17:37:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <josef@toxicpanda.com>) id 1kb5gS-00024i-15
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Nov 2020 17:37:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/T4V4t+QdvwoK1NFTGIFvOZHdTRgisoLRqVT8P2lJvo=; b=VN50jd3C+zYZpKyhAun7zXSTq8
 rzZ0aEcCCi7QoJBLrKjcaLUj46+KsNzM9E9g3VBGi3FA1cOI0Kv9rqPimNzRwLwp0KDHV5f/ltaMf
 iFzrN2s4fViDODAoQWAks0jeMD/mb7LkaTcRJEYUrcJdKFJfDv4w+HbRthZO2A9VtGIM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/T4V4t+QdvwoK1NFTGIFvOZHdTRgisoLRqVT8P2lJvo=; b=ghWGr0cSTAzd4qMl/oeyqCPD+f
 a86k8kYzSg6/fnaNEEGnQ89SuHSYLjb2va2jtUQXrq4MlH5vCzfI8cMt6ZaGYfj+vrSztYCbV9L2s
 YtEmgqxXwcY1IeQBWxv3ylfLU/uZ72lQ8yEEkqETsOt834rRl3RjqIxm3WVs/cLXVmPM=;
Received: from mail-qv1-f66.google.com ([209.85.219.66])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kb5gJ-00Bng7-OY
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Nov 2020 17:37:55 +0000
Received: by mail-qv1-f66.google.com with SMTP id i17so801413qvp.11
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2020 09:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/T4V4t+QdvwoK1NFTGIFvOZHdTRgisoLRqVT8P2lJvo=;
 b=O8ZZhEUu0ahk3vx3VEAynSB5X0BHcaeX65/n+GCfnMVQlCjjMM3p23k8VknqbUFUyG
 xS4iWwZ+m9Z6mkg5EpOdNoMXsSwme47E9SKHvzuTH2cbn6QNDJF2YiIdr4aqoE7iXB/k
 R26qVZFvuzWp9l9JFughus5JP/AB6TfuCX+HSeXdMTzkEtakFSXtNv9tzCAglH78ZTaw
 TxKQlv8W2NUJMBS609YgLTLtYOArXV3u02qTZ0YfEviaHGbm+YY/2p/KBah6FMWeQiQ3
 QQZnfhpfPbY0agR5AT7VNJeqCdJ5FGWJIUDioISdb0gQmdag4avVcFq3hR21efkD9fzo
 9fZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/T4V4t+QdvwoK1NFTGIFvOZHdTRgisoLRqVT8P2lJvo=;
 b=YhA7g7iGbyavHNl+IyOHsvDYxfBKuC15fvc/+5ESy5NCWR5zbQhANwXQdndOWWTu8n
 LLkPKhFLvJuf7zJFOai1unU+VksEny49IVXMyAVk3imAZP5wc0PQjcAR6urv0On6u11C
 l6JOa+9Eu/ekfvVUjtAoRsOBfAWkJ6ujvl5fXsiZeGlyrlvTBcSXTbLJeHY+gFHMF+9G
 dmcPdnA3ePHOOeh8A4nai3rqe2YXLRZtwsVJf2bYvWNGnw2/1B+ExBX7uGxeOItWXPWg
 HbiJni0pCKAl8mVYYFOFEE1nO5LPTTD1Z1W6zkAsosoTqb6JDnIr6C9Zwq4W7/lOg3Em
 WA7A==
X-Gm-Message-State: AOAM530/POQiSyaS9ZBDh1D8qu0O7HguP0GsNzKMD+uZbC2lavmodJ4I
 pzIfTzw491VEl9iVF2qBf4sd8jXfWbd7yd+E0Sk=
X-Google-Smtp-Source: ABdhPJwF/MdD1qNke+ECauvjnsTNgCBiugOoWghae9wdj3qkdlvkqshdqouzdfR5ybfqevB97gjCZQ==
X-Received: by 2002:a0c:e346:: with SMTP id a6mr2528444qvm.9.1604682651091;
 Fri, 06 Nov 2020 09:10:51 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com.
 [174.109.172.136])
 by smtp.gmail.com with ESMTPSA id n4sm799428qkf.42.2020.11.06.09.10.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 09:10:49 -0800 (PST)
To: Nick Terrell <nickrterrell@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20201103060535.8460-1-nickrterrell@gmail.com>
 <20201103060535.8460-6-nickrterrell@gmail.com>
From: Josef Bacik <josef@toxicpanda.com>
Message-ID: <b12254bc-7320-7170-f39d-e76afe1a7561@toxicpanda.com>
Date: Fri, 6 Nov 2020 12:10:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103060535.8460-6-nickrterrell@gmail.com>
Content-Language: en-US
X-Headers-End: 1kb5gJ-00Bng7-OY
Subject: Re: [f2fs-dev] [PATCH v5 5/9] btrfs: zstd: Switch to the zstd-1.4.6
 API
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
Cc: squashfs-devel@lists.sourceforge.net, Johannes Weiner <jweiner@fb.com>,
 Yann Collet <cyan@fb.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Petr Malat <oss@malat.biz>,
 Chris Mason <clm@fb.com>, Nick Terrell <terrelln@fb.com>,
 linux-crypto@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
 Niket Agarwal <niketa@fb.com>, linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 11/3/20 1:05 AM, Nick Terrell wrote:
> From: Nick Terrell <terrelln@fb.com>
> 
> Move away from the compatibility wrapper to the zstd-1.4.6 API. This
> code is functionally equivalent.
> 
> Signed-off-by: Nick Terrell <terrelln@fb.com>
> ---
>   fs/btrfs/zstd.c | 48 ++++++++++++++++++++++++++++--------------------
>   1 file changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index a7367ff573d4..6b466e090cd7 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -16,7 +16,7 @@
>   #include <linux/refcount.h>
>   #include <linux/sched.h>
>   #include <linux/slab.h>
> -#include <linux/zstd_compat.h>
> +#include <linux/zstd.h>
>   #include "misc.h"
>   #include "compression.h"
>   #include "ctree.h"
> @@ -159,8 +159,8 @@ static void zstd_calc_ws_mem_sizes(void)
>   			zstd_get_btrfs_parameters(level, ZSTD_BTRFS_MAX_INPUT);
>   		size_t level_size =
>   			max_t(size_t,
> -			      ZSTD_CStreamWorkspaceBound(params.cParams),
> -			      ZSTD_DStreamWorkspaceBound(ZSTD_BTRFS_MAX_INPUT));
> +			      ZSTD_estimateCStreamSize_usingCParams(params.cParams),
> +			      ZSTD_estimateDStreamSize(ZSTD_BTRFS_MAX_INPUT));
>   
>   		max_size = max_t(size_t, max_size, level_size);
>   		zstd_ws_mem_sizes[level - 1] = max_size;
> @@ -389,13 +389,23 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>   	*total_in = 0;
>   
>   	/* Initialize the stream */
> -	stream = ZSTD_initCStream(params, len, workspace->mem,
> -			workspace->size);
> +	stream = ZSTD_initStaticCStream(workspace->mem, workspace->size);
>   	if (!stream) {
> -		pr_warn("BTRFS: ZSTD_initCStream failed\n");
> +		pr_warn("BTRFS: ZSTD_initStaticCStream failed\n");
>   		ret = -EIO;
>   		goto out;
>   	}
> +	{
> +		size_t ret2;
> +
> +		ret2 = ZSTD_initCStream_advanced(stream, NULL, 0, params, len);
> +		if (ZSTD_isError(ret2)) {
> +			pr_warn("BTRFS: ZSTD_initCStream_advanced returned %s\n",
> +					ZSTD_getErrorName(ret2));
> +			ret = -EIO;
> +			goto out;
> +		}
> +	}

Please don't do this, you can just add size_t ret2 at the top and not put this 
in a block.  Other than that the code looks fine, once you fix that you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
