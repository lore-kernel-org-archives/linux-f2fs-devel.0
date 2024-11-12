Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545D5D597A9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 Nov 2024 21:39:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tAybv-0006O0-Nq;
	Tue, 12 Nov 2024 21:39:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1tAybu-0006Nu-N2
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 Nov 2024 21:39:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xv+CIBxq32u5eMcnJVV7GN8pxNVjhiPFhuJUCZHhsjI=; b=FPBa79eYzqWrn6+c9y9yshLHIf
 WrQEGkQoASPsqdYBJwLSpzfi4VZKAyOThGKqQQZcRnV5MvjP2W9j9qAHvQt5BoMULxMvrws2ixBP0
 pGtXJm1iQT+EhFvoEenR1HwlKkuBLIGA0pfRS26yNRHKENIP2z5Aadix81xGwWlgriKc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Xv+CIBxq32u5eMcnJVV7GN8pxNVjhiPFhuJUCZHhsjI=; b=d5q4BTPghjqjbOtByCLEbupNZu
 AhyuX8vqw8Ul/NsSuFd0jmOqLl0d2wNL9NGoaLHmqxQuSsG8Yeu8oej+yk5fBVZay7jqe1FHJoi7b
 6/QClFWwD/Kvma4KNciB6qT+0b4RNZeFIe5hvUZhazq4io03xsZRvq8o8DBXcaZ/5q38=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tAybt-0004ZV-Ea for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 Nov 2024 21:39:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BC25E5C4993;
 Tue, 12 Nov 2024 21:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9302CC4CECD;
 Tue, 12 Nov 2024 21:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1731447570;
 bh=9pk1AsME6rZGiOxewMrICrzKTyHvu3xjCllKNiqeHVo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KjP5qwzqavKkOvy0mCyR8hsndiZ4/WlOLOngrc8Z0VDnOAruNdaL9uE8I8ElrRksZ
 iR6EUBppMV1CT1Qfq79vftI8TJjSGPSXGmktKjCVkkdaRv2mMkNuSAq1n4ox8VHSBZ
 xZfXOyRcXXc8Yp4zq8UdH0xyB4G5gFtnkxts7BrjGmWCAJDyKbbkN9gtuDghFtav5L
 viyEOfg2IfemHHwl+iFtnZ2p4bgrMtxTO6KRBt8EajPqpITC01dOukTN9IuIDYWNGk
 Dy380jDeR3T4MFPD8od+bCk1oUIfFpQN8MR6oaCSfEgsl3PMcaFvR7b70ktDAnrt92
 Q4x21nhRoKSuw==
Date: Tue, 12 Nov 2024 21:39:28 +0000
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Message-ID: <ZzPLELITeOeBsYdi@google.com>
References: <20241112010820.2788822-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241112010820.2788822-1-jaegeuk@kernel.org>
X-Headers-End: 1tAybt-0004ZV-Ea
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: remove unreachable lazytime
 mount option parsing"
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Eric Sandeen <sandeen@redhat.com>, Daniel Rosenberg <drosen@google.com>,
 stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Eric,

Could you please check this revert as it breaks the mount()?
It seems F2FS needs to implement new mount support.

Thanks,

On 11/12, Jaegeuk Kim wrote:
> This reverts commit 54f43a10fa257ad4af02a1d157fefef6ebcfa7dc.
> 
> The above commit broke the lazytime mount, given
> 
> mount("/dev/vdb", "/mnt/test", "f2fs", 0, "lazytime");
> 
> CC: stable@vger.kernel.org # 6.11+
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/super.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 49519439b770..35c4394e4fc6 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -150,6 +150,8 @@ enum {
>  	Opt_mode,
>  	Opt_fault_injection,
>  	Opt_fault_type,
> +	Opt_lazytime,
> +	Opt_nolazytime,
>  	Opt_quota,
>  	Opt_noquota,
>  	Opt_usrquota,
> @@ -226,6 +228,8 @@ static match_table_t f2fs_tokens = {
>  	{Opt_mode, "mode=%s"},
>  	{Opt_fault_injection, "fault_injection=%u"},
>  	{Opt_fault_type, "fault_type=%u"},
> +	{Opt_lazytime, "lazytime"},
> +	{Opt_nolazytime, "nolazytime"},
>  	{Opt_quota, "quota"},
>  	{Opt_noquota, "noquota"},
>  	{Opt_usrquota, "usrquota"},
> @@ -922,6 +926,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  			f2fs_info(sbi, "fault_type options not supported");
>  			break;
>  #endif
> +		case Opt_lazytime:
> +			sb->s_flags |= SB_LAZYTIME;
> +			break;
> +		case Opt_nolazytime:
> +			sb->s_flags &= ~SB_LAZYTIME;
> +			break;
>  #ifdef CONFIG_QUOTA
>  		case Opt_quota:
>  		case Opt_usrquota:
> -- 
> 2.47.0.277.g8800431eea-goog


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
