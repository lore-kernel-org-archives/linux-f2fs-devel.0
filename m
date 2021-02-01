Return-Path: <SRS0=c5UM=HD=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C33C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  1 Feb 2021 22:34:16 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EBE364EC6;
	Mon,  1 Feb 2021 22:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBE364EC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1l6hlr-0006Zc-QA; Mon, 01 Feb 2021 22:34:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1l6hlq-0006ZI-7U
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Feb 2021 22:34:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jgMtkc5PRzjWid9HOM3Tvg9CniFTIMb2f9sl7ix7rsk=; b=cjJnFwp6KlsFbs9L6Hph+xiFCZ
 axtArouFhTwtPLqJuCGy87bE174c3oNB7/34X3eHvtIoNcSiSATCBXwje5blUiW9FFQOvF3xlxya+
 lDfacVMdht0UgXhL/wBQTpODgwvbJCa5CRqcKTBMpoixa+K577MoULmrnExy5wBG9eDE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jgMtkc5PRzjWid9HOM3Tvg9CniFTIMb2f9sl7ix7rsk=; b=gfYY+DYfGXyL7PdJIlCMSZ7t/U
 7cJMhr1HDZ29YyKpaSjImPb/VtYAAjo4Pvfc5WdV3q9Yt19H28iQwU8K6lZftfLMFzC/KVYqqzK3e
 iZzn7DKVPBZ9zkGTahtsFFiC1tGa0+NROHxLasbyWfZVw/hPpAoK8CNatmAbgKNcvcGk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1l6hlg-0005vO-Dh
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Feb 2021 22:34:09 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3685164E93;
 Mon,  1 Feb 2021 22:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612218830;
 bh=6ifs07SoPwNCF09AduweLP8VSa2eET6rB/VZr8wQPrU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hjc/+kX+QPWvs0PD/OViXtjsrmNHauL9Vd0DOYpMijrTS29Wm87KohdYqQqLWuwSm
 FhbIY4PvPkeCwz7nLF8fb6wbrFsrwuJCZPQ6ysZyFidn/W3lViZJ2Y5UhLHU7v9ag6
 TGExqJGtp6hFB4E8lVUp34nS5Z966yrYvM7CEZCVGJ6KLwFLKh17KMj8WpHHKx6LIa
 e+0HYVsvx05hKmsRIwpTLRyg3HaRo+znAXLOBj0On2a+LgO785NVNP7/jBWfSqVlVc
 A9HEIwpC2sYWsL3NRKzIT94yaabrSOsNo9IMatWOXf7TQTAG9OVqY7l9jffQIpSs3K
 s+Kcz1abhVeUw==
Date: Mon, 1 Feb 2021 14:33:48 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Daeho Jeong <daeho43@gmail.com>
Message-ID: <YBiBzP2YC3j1Q8Ry@google.com>
References: <20210201005749.2980575-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210201005749.2980575-1-daeho43@gmail.com>
X-Headers-End: 1l6hlg-0005vO-Dh
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent setting ioprio of thread not
 in merge mode
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Thanks.
Merged into the original patch.

On 02/01, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> It causes a crash to change the ioprio of checkpoint thread not in
> checkpoint=merge. I fixed that to prevent setting the ioprio of the
> thread when checkpoint=merge is not enabled.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/sysfs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 100608bcd517..e38a7f6921dd 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -357,8 +357,12 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>  			return -EINVAL;
>  
>  		cprc->ckpt_thread_ioprio = IOPRIO_PRIO_VALUE(class, data);
> -		ret = set_task_ioprio(cprc->f2fs_issue_ckpt,
> -				cprc->ckpt_thread_ioprio);
> +		if (test_opt(sbi, MERGE_CHECKPOINT)) {
> +			ret = set_task_ioprio(cprc->f2fs_issue_ckpt,
> +					cprc->ckpt_thread_ioprio);
> +			if (ret)
> +				return ret;
> +		}
>  
>  		return count;
>  	}
> -- 
> 2.30.0.365.g02bc693789-goog


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
