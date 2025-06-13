Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4E3C71135
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Jun 2025 06:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pYYQl2PW7r2Ayri85xnUor6ExwT8cy+LDRw45/T4onU=; b=Rufh1Mt3VxKiJPFvCiqJhCQG93
	RYx0q0zaDm+7N9vM7KH35Rx+taTxOfI+Cz47dCqRHR7Yn2w6RqjdQDj6DiP3lHFkymXRv9t3fzdwX
	x8di7ok82HWwsfTIkGGTrZQAsAVlri+7lC+GxohWOGBBLvRNmu6TACM80YF44suls5hE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uPxaC-0002Xd-Kn;
	Fri, 13 Jun 2025 06:08:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uPxaA-0002XT-Iu
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Jun 2025 06:08:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fLn2+7cHN++tboA+ISAF3MKSsA4eiZsY3VYu2x0Tv58=; b=Wv9pEKwOIjLGomu7ExWsOm/IS+
 Bzrti72vmlVC4tG5JDvPW5zpqNtZ47VzUGrcF1PFChz/2+CDDhMgaeFLNGxsdMdZ3yMgRYA+33GWI
 XANwM29ZhprXe14Lytk/esO0/oFmVJAfAQc/IYqp0BFJ7I2Vhyo9CEf+TNYGw6M5s29o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fLn2+7cHN++tboA+ISAF3MKSsA4eiZsY3VYu2x0Tv58=; b=DMD7nbNhmqAUBpE52nuJBkVRsN
 Y54TocI5MIsGtB1r3rrcvgia7Ly0mQeRyTln457hHr4X1B64MalFbSFXabXnQTL8sws51WBV/Kcm3
 yJmdI5m40JJqp6sJ6QWHfnnoHqVFnPh5qly2/4T3/8gdiVS4QbsCtk7wB2Abz4tTzQ5Q=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uPxaA-0002af-3a for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Jun 2025 06:08:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B56F7447C0;
 Fri, 13 Jun 2025 06:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590B5C4CEE3;
 Fri, 13 Jun 2025 06:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749794875;
 bh=Dnl5LmbiLQ4oVa5IhkMB7B1XNWmW640lVxVbTjDJv/8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=qaBby8a/qznZ8Iu+sAn3IWTnejn2Au0v5fj3VaIq0jjNCgQ7VbnfpFtRDYyow1TWF
 C2Wg1gtAbK9vZS5CDR0ZhEbGPEV/En4d+cx3CrS1hNOM35QXhmUzoaFM0CW69m3YbH
 FnVM75wXCQY/o1PAgrjt4by9HLs4xkAWWb+9KLHk3XHkhWTGmpgokxU02iXrZ5GXdz
 jp9HZWpjMZZvB8SxDbrNTAbguUkbZUrGh7/Af08l2YTCO7K2Q7A/mm63baF13Trc4B
 dWpsR1yBz3OX4dg0sIHMiDwUuWIBNK3+Y8cKqC+a0HgCplccBJ9afHj4CdOYrouYD2
 znnwzivO8jDBw==
Message-ID: <de9e00c2-c9c2-4284-af57-ed7e21b07622@kernel.org>
Date: Fri, 13 Jun 2025 14:08:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sheng Yong <shengyong2021@gmail.com>, jaegeuk@kernel.org
References: <20250610123743.667183-1-shengyong1@xiaomi.com>
 <20250610123743.667183-10-shengyong1@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20250610123743.667183-10-shengyong1@xiaomi.com>
X-Headers-End: 1uPxaA-0002af-3a
Subject: Re: [f2fs-dev] [RFC PATCH v2 09/32] inject.f2fs: fix and cleanup
 parsing numeric options
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
Cc: shengyong1@xiaomi.com, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2025/6/10 20:37, Sheng Yong wrote:
> From: Sheng Yong <shengyong1@xiaomi.com>
> 
> This patch fixes:
>    * parsing hex optarg of --idx option
>    * converting -1 to 0xff...ff of --val option
> and do a little cleanup of converting string to a long integer.
> 
> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
> ---
>   fsck/inject.c | 32 +++++++++++++++++---------------
>   1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/fsck/inject.c b/fsck/inject.c
> index 96817a806f8f..c879ca99c0d8 100644
> --- a/fsck/inject.c
> +++ b/fsck/inject.c
> @@ -236,8 +236,9 @@ int inject_parse_options(int argc, char *argv[], struct inject_option *opt)
>   
>   	while ((o = getopt_long(argc, argv, option_string,
>   				long_opt, NULL)) != EOF) {
> -		long nid, blk;
> +		long long val;
>   
> +		errno = 0;
>   		switch (o) {
>   		case 1:
>   			c.dry_run = 1;
> @@ -248,18 +249,19 @@ int inject_parse_options(int argc, char *argv[], struct inject_option *opt)
>   			MSG(0, "Info: inject member %s\n", optarg);
>   			break;
>   		case 3:
> -			if (!is_digits(optarg))
> -				return EWRONG_OPT;
> -			opt->idx = atoi(optarg);
> -			MSG(0, "Info: inject slot index %d\n", opt->idx);
> +			val = strtoll(optarg, &endptr, 0);
> +			if (errno != 0 || val >= UINT_MAX || val < 0 ||

UINT_MAX is a possible injectable value? if so, it need to use "val > UINT_MAX"?

> +			    *endptr != '\0')
> +				return -ERANGE;
> +			opt->idx = (unsigned int)val;
> +			MSG(0, "Info: inject slot index %u\n", opt->idx);
>   			break;
>   		case 4:
> -			opt->val = strtoll(optarg, &endptr, 0);
> -			if (opt->val == LLONG_MAX || opt->val == LLONG_MIN ||
> -			    *endptr != '\0')
> +			opt->val = strtoull(optarg, &endptr, 0);
> +			if (errno != 0 || *endptr != '\0')
>   				return -ERANGE;
>   			MSG(0, "Info: inject value %lld : 0x%llx\n", opt->val,
> -			    (unsigned long long)opt->val);
> +			    opt->val);
>   			break;
>   		case 5:
>   			opt->str = strdup(optarg);
> @@ -292,11 +294,11 @@ int inject_parse_options(int argc, char *argv[], struct inject_option *opt)
>   			MSG(0, "Info: inject nat pack %s\n", pack[opt->nat]);
>   			break;
>   		case 9:
> -			nid = strtol(optarg, &endptr, 0);
> -			if (nid >= UINT_MAX || nid < 0 ||
> +			val = strtoll(optarg, &endptr, 0);
> +			if (errno != 0 || val >= UINT_MAX || val < 0 ||
>   			    *endptr != '\0')
>   				return -ERANGE;
> -			opt->nid = nid;
> +			opt->nid = (nid_t)val;
>   			MSG(0, "Info: inject nid %u : 0x%x\n", opt->nid, opt->nid);
>   			break;
>   		case 10:
> @@ -308,11 +310,11 @@ int inject_parse_options(int argc, char *argv[], struct inject_option *opt)
>   			MSG(0, "Info: inject sit pack %s\n", pack[opt->sit]);
>   			break;
>   		case 11:
> -			blk = strtol(optarg, &endptr, 0);
> -			if (blk >= UINT_MAX || blk < 0 ||
> +			val = strtoll(optarg, &endptr, 0);
> +			if (errno != 0 || val >= UINT_MAX || val < 0 ||
>   			    *endptr != '\0')
>   				return -ERANGE;
> -			opt->blk = blk;
> +			opt->blk = (block_t)val;
>   			MSG(0, "Info: inject blkaddr %u : 0x%x\n", opt->blk, opt->blk);
>   			break;
>   		case 12:



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
