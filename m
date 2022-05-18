Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCCFC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 May 2022 22:35:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nrSGl-0005zn-FN; Wed, 18 May 2022 22:35:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1nrSGj-0005zh-MF
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 May 2022 22:35:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lp41b+iLQDBUE33amXeZw3Bv4+Ea7zlobtwTQcyHL58=; b=OwUTi4YL2rdxH8oI0Dt+ijklbu
 xaigJizg6VxEsuAsRMGwDZmWsLwmldNaM0nK5HtOsiSjWdO/Bgpi7qcLktTpqYQvrGIIUdkWJjSWK
 irChIT1DqIYijL6DHvG+JLPv3GaJ326/KUjX/3vV545ovNB9JM/6Mg+VjVSOMou2IHnM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Lp41b+iLQDBUE33amXeZw3Bv4+Ea7zlobtwTQcyHL58=; b=BPupKbGvi2hpf7dh74I09XbKdq
 nVXE3L0A6OyapWXASUThMymuYWF5Xk0cDnvQPr+l0Ih3leIEtIMIj3O6n/GMx/jwaOfFlwj4maIja
 2tZIIvh+mAX/W5k6hh+AJhYwxb7qh+lw6+w3IjQoNG1yz2FHFo+otaE5f68Q2w00SqAM=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nrSGe-0005RY-94
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 May 2022 22:35:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 41518B82221
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 18 May 2022 22:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6802C385A5;
 Wed, 18 May 2022 22:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652913331;
 bh=JsNUGeYCd9jl73VaIgc6JuqYsiBSisQYXVe0o/Ol3wg=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=KRV9qLcS8wCMGeqf4/VCUWDoXMQvZqsQNGFoU8yhXC7DAs7tO5jVMRSwU3X24XB3m
 viK843eqIrxzcULosTdfEHqYfFuPDc8SnE6eP8q0A/STIAuq5l9VpWLKpAPrUDzTbX
 jH/QIdoL31KWjFbEfmJp5TUUyz5MoHOx06bJEIUoRbBLs+9RgQAnxw/ylkL2qbTa7k
 umDIundqGtIhM+IoO6gFT7CdZIkLqaarONAMVYdrt9R/tHAOJiv+j3Nb91XjTZtNSU
 TipO4kOkEyBi4+8ExPY2+A+20jbb39HUbezHHDazLgw4JVz0GQFeieoGmJTJ6LVwxc
 pyXk4SvcilYzw==
Date: Wed, 18 May 2022 15:35:30 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Message-ID: <YoV0sm9W+2A644PZ@google.com>
References: <20220518175547.3284875-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220518175547.3284875-1-jaegeuk@kernel.org>
X-Headers-End: 1nrSGe-0005RY-94
Subject: Re: [f2fs-dev] [PATCH] f2fs: decompress data without workqueue
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

Please hold any test, since this patch has a bug.

On 05/18, Jaegeuk Kim wrote:
> Let's decompress data under the same context to avoid workqueue delay.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 54a7a8ad994d..37aa7ac5d463 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -285,10 +285,12 @@ static void f2fs_read_end_io(struct bio *bio)
>  		return;
>  	}
>  
> -	if (ctx && (ctx->enabled_steps & (STEP_DECRYPT | STEP_DECOMPRESS))) {
> +	if (ctx && (ctx->enabled_steps & STEP_DECRYPT)) {
>  		INIT_WORK(&ctx->work, f2fs_post_read_work);
>  		queue_work(ctx->sbi->post_read_wq, &ctx->work);
>  	} else {
> +		if (ctx && (ctx->enabled_steps & STEP_DECOMPRESS))
> +			f2fs_handle_step_decompress(ctx);
>  		f2fs_verify_and_finish_bio(bio);
>  	}
>  }
> -- 
> 2.36.1.124.g0e6072fb45-goog


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
