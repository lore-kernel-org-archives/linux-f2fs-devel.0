Return-Path: <SRS0=TvYq=ES=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE2CC2D0A3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2020 08:17:53 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A4D20870;
	Thu, 12 Nov 2020 08:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="eeChw8ba";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="K16TmTYP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dASG2/LA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A4D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kd7nd-0005Vu-Jj; Thu, 12 Nov 2020 08:17:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kd7nc-0005VY-7M
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Nov 2020 08:17:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4OAPoCL6BMAwulSnqvIazCGPuHGpt0QVV8bkS9ehujw=; b=eeChw8baNUa+jeS5sJjiPBH9/x
 11h+W7+Z1PeuRvQqFBJ+jyQtlVZqh4CpQdriS8br/1bLxuBfwR/wQUzcb6d+gxg/S5I1wuEpPkdOR
 R7zzGeEYc7yZiPUTi6QGKTjeqHXPztz+fUX3J40BPeLcVJ4fbEyE8BcPEcj9npOhLq20=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4OAPoCL6BMAwulSnqvIazCGPuHGpt0QVV8bkS9ehujw=; b=K16TmTYPieanl2Fth6uzIC34qZ
 +8ZpSl34HG6FsMZmwG6LKIJAUhfoxjEUsL/dLKTEqEkc8ZIOU4cRRBHvYTHMQTPFRpVp0OsUwZzKh
 kfkvs45pzMgQBhc3tAsWJ22oqunv9OB2EmiO1PSNEWsea499vRX8Uyt4WHEZEBYuBcnI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kd7nY-000FcC-LP
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Nov 2020 08:17:44 +0000
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net
 [172.10.235.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BE6942076E;
 Thu, 12 Nov 2020 08:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605169055;
 bh=60LD1GgC6+1u0vFCE0HU0a6eOMYhYnVT9GwcRHrKswU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dASG2/LAcoLoRbfyP0liXXIDOr6W2kT+KJBlGAKvj1TL6b9YUYUAsrCsVs6FLB0p9
 +OeuM64tWyk84maJYLufSnw15lVjqxHmx0UPIXIvPCaHD71QYPYKFrLpZdYzuFlRD0
 Lenf4Nh0Qoj4kzd1IIdZi7+61frI7qHSL11iZ7T4=
Date: Thu, 12 Nov 2020 00:17:33 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Hyeongseok Kim <hyeongseok@gmail.com>
Message-ID: <X6zvndTKKQfISlcj@sol.localdomain>
References: <20201112080201.149359-1-hyeongseok@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201112080201.149359-1-hyeongseok@gmail.com>
X-Headers-End: 1kd7nY-000FcC-LP
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix double free of unicode map
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
Cc: Daniel Rosenberg <drosen@google.com>, hyeongseok.kim@lge.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Nov 12, 2020 at 05:02:01PM +0900, Hyeongseok Kim wrote:
> In case of retrying fill_super with skip_recovery,
> s_encoding for casefold would not be loaded again even though it's
> already been freed because it's not NULL.
> Set NULL after free to prevent double freeing when unmount.
> 
> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
> ---
>  fs/f2fs/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 00eff2f51807..fef22e476c52 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3918,6 +3918,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  #ifdef CONFIG_UNICODE
>  	utf8_unload(sb->s_encoding);
> +	sb->s_encoding = NULL;
>  #endif
>  free_options:
>  #ifdef CONFIG_QUOTA
> -- 

This is:

Fixes: eca4873ee1b6 ("f2fs: Use generic casefolding support")

Right?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
