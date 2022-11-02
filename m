Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AE8C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Nov 2022 02:06:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oq38j-000706-Pc;
	Wed, 02 Nov 2022 02:06:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1oq38i-0006zt-I7
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Nov 2022 02:06:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D7gi26O4qjVhs3o9RNmANM2exJ3Bov+rY/4aFA8be8s=; b=N5NO31LvkemhSen2YUFpxtNYRX
 DJxVvmusuvEZSM0imVJhk2OCYprhf0RujwHUCkDcRgzRs/ataRJUGlYuJ7fErOydOPTCGbBMJr99M
 W2BGfgo2Fqj/G4wexFVec9k8AsyzG9SDx6CgqQY0BeK2OKIxfDsfwVVo+qcDkMT06fk8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D7gi26O4qjVhs3o9RNmANM2exJ3Bov+rY/4aFA8be8s=; b=FTjkPxOrqn4bNcG1/hH9NaBvx5
 1wPY7e5/uGCRBKHGqgae4Zow5L3Zpi35I7GQRLeKWixCCX8RHiiNFJjvVVSLVm2ySuXHTE8feHGad
 kuAkJ89+KAR0mMzqApnWA37kj1l0RpsKIDbcY3N/Bz/m33yALEBl2vBUBhZ0Lwt4gcOI=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oq38h-00051W-Om for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Nov 2022 02:06:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6E307B8205E;
 Wed,  2 Nov 2022 02:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00649C433D7;
 Wed,  2 Nov 2022 02:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667354752;
 bh=Hn3Dot0ItNUymZHcHEbaJ3rd5VUjYwb+4Y5AN8Tl5KA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hQU1kXD17dO+n4EkUjsQfEBaNk6ZKUVTL8g1b7GIMPdVjRJUqUNaasU2uvfFQRmU3
 WQhxlUdBtcC1kWJUoPxl7tiXuQB11B1p9791Y31e1e6FEMEYQTe+ML0XurvvM80qjR
 /UZ4vLlzYsPVV7qsRvHYH4xboeExkqhBYEF6L1QOeHvWYDv83FAV5MOWaPcrR9fv9y
 OuDCuoVs057l2VN8PS2nI+YZFFDpyJYg9J7bWzTwlK3Piq8YGOIpfpgLXDK2Tz4xnr
 0r04VLX4q3arHOYUhHWSlsbQT2VLpmBnqCp1G7sQnGkLgDhWUvGRS4BR6mMS2SJynf
 6bgcwARaEbfaA==
Date: Tue, 1 Nov 2022 19:05:50 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Fengnan Chang <fengnanchang@gmail.com>
Message-ID: <Y2HQftXirAxvab6M@sol.localdomain>
References: <20220608134852.476876-1-fengnanchang@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220608134852.476876-1-fengnanchang@gmail.com>
X-Headers-End: 1oq38h-00051W-Om
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix hungtask when decompressed fail
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jun 08, 2022 at 09:48:52PM +0800, Fengnan Chang wrote:
> When decompressed failed, f2fs_prepare_compress_overwrite will enter
> endless loop, may casue hungtask.
> 
> [   14.088665] F2FS-fs (nvme0n1): lz4 decompress failed, ret:-4155
> [   14.089851] F2FS-fs (nvme0n1): lz4 decompress failed, ret:-4155
> 
> Signed-off-by: Fengnan Chang <fengnanchang@gmail.com>

This commit message only explains the problem, not the solution.  It should
explain the solution too.

Also, if it's fixing a bug, it needs 'Fixes' and 'Cc stable' tags.

> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 24824cd96f36..1764e3859262 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1060,7 +1060,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>  	sector_t last_block_in_bio;
>  	unsigned fgp_flag = FGP_LOCK | FGP_WRITE | FGP_CREAT;
>  	pgoff_t start_idx = start_idx_of_cluster(cc);
> -	int i, ret;
> +	int i, ret, retry_count = 3;
>  
>  retry:
>  	ret = f2fs_is_compressed_cluster(cc->inode, start_idx);
> @@ -1120,7 +1120,12 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>  			f2fs_put_rpages(cc);
>  			f2fs_unlock_rpages(cc, i + 1);
>  			f2fs_destroy_compress_ctx(cc, true);
> -			goto retry;
> +			retry_count--;
> +			if (PageError(page) && !retry_count) {
> +				ret = -EIO;
> +				goto out;
> +			} else

What is the purpose of using PG_error here?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
