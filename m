Return-Path: <SRS0=2C9g=AV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42444C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2020 03:03:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5FB20720;
	Fri, 10 Jul 2020 03:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="e7JrqJkc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="BVUipEVg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqHGwKlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5FB20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jtjJU-0007jx-M0; Fri, 10 Jul 2020 03:03:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jtjJS-0007jp-P4
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Jul 2020 03:02:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kV7rruElF/IgUZx86OxA5KP7g2V8JdHogkFMVAYJgD4=; b=e7JrqJkcOGCf6ZLkpAgxftcMUN
 wKC+Xsu/t9GIRD3HMZ0phfxO/GkXI33EuvXJesa9ypZxDmW5K4JPWiVJk5Wq27I7rl08DBIy0qdyr
 oCbx9vQ4KrRtlHMxhlT09tKdZMx/gTNSwYh9qgHeX0jHZ4d/V2nejDoP/FWKBeJlIe9s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kV7rruElF/IgUZx86OxA5KP7g2V8JdHogkFMVAYJgD4=; b=BVUipEVg+rcH33gOkMgkWlWkWu
 v1CL/V2SpfPFOV8VKZu4EZVh/f0S0ePS48PbdaGahs686zT2yFwnorFwG8IA0uvhOgOy4znAEFsKc
 RwN9El5RqePnE5sLnKSGdr4nn9DdhJHhSmhetgb80qsq/zD6vNXfsEDHxr5IbFyYwyqw=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jtjJM-00Fnll-Jz
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Jul 2020 03:02:58 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 295B82073A;
 Fri, 10 Jul 2020 03:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594350167;
 bh=kAsBqQZRZQ5C/sbtKjmCiPtuu3wHYS/cK2L+QzdWOnc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tqHGwKlTh3pB/U89lbrCjuUTdiwUZEC2BCFgH+77JglaOhDpyn9Q8CuHHd8esUQEm
 ubL9ago1UFinysqXO7P8lb65P0L5AgHWks6mT7aNQ5MKO3FwNJYLot71b9/i2GwuPo
 FqTJYk/VtPS+E0m9qU/WNpqoI/rn+hin3jwpm3Qc=
Date: Thu, 9 Jul 2020 20:02:46 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Daeho Jeong <daeho43@gmail.com>
Message-ID: <20200710030246.GA545837@google.com>
References: <20200710021505.2405872-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200710021505.2405872-1-daeho43@gmail.com>
X-Headers-End: 1jtjJM-00Fnll-Jz
Subject: Re: [f2fs-dev] [PATCH] f2fs: change the way of handling range.len
 in F2FS_IOC_SEC_TRIM_FILE
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

On 07/10, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Changed the way of handling range.len of F2FS_IOC_SEC_TRIM_FILE.
>  1. Added -1 value support for range.len to signify the end of file.
>  2. If the end of the range passes over the end of file, it means until
>     the end of file.
>  3. ignored the case of that range.len is zero to prevent the function
>     from making end_addr zero and triggering different behaviour of
>     the function.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/file.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 368c80f8e2a1..1c4601f99326 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3813,21 +3813,19 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
>  	file_start_write(filp);
>  	inode_lock(inode);
>  
> -	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
> +	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) ||
> +			range.start >= inode->i_size) {
>  		ret = -EINVAL;
>  		goto err;
>  	}
>  
> -	if (range.start >= inode->i_size) {
> -		ret = -EINVAL;
> +	if (range.len == 0)
>  		goto err;
> -	}
>  
> -	if (inode->i_size - range.start < range.len) {
> -		ret = -E2BIG;
> -		goto err;
> -	}
> -	end_addr = range.start + range.len;
> +	if (range.len == (u64)-1 || inode->i_size - range.start < range.len)
> +		end_addr = inode->i_size;

Hmm, what if there are blocks beyond i_size? Do we need to check i_blocks for
ending criteria?

> +	else
> +		end_addr = range.start + range.len;
>  
>  	to_end = (end_addr == inode->i_size);
>  	if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
> -- 
> 2.27.0.383.g050319c2ae-goog
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
