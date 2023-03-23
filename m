Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (unknown [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADAFC74A5B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Mar 2023 23:48:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pfUfA-00059g-4r;
	Thu, 23 Mar 2023 23:48:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pfUf5-00058V-Kp
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Mar 2023 23:48:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MfZizJIJ4p9gIRnDgX6QhtEohFogixPzPoki2Ep/vnE=; b=iC94T8ElMIK8a5JXi45hobtf6y
 OcinncjWUk9yoedUt8i3L3wCuRYNIY+KAmWwCoGnBZKvJ8+bbz9jDqM9fuUDfvrTZ5/pTus6J6cWj
 jUqMeiOMFHsanCs9umQO+gSOroP0PtZFrR/zMk8Cz7SnjD4JtlsqWB450XNysWaXnY0k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MfZizJIJ4p9gIRnDgX6QhtEohFogixPzPoki2Ep/vnE=; b=N5LZ2FxWiAMRNFs7vvAujCveBC
 cH4EiTkfKQJeh3Tbc2TWEh7w2jilBMJXS89anu5KIBWrRF0Pqtc8woyxzHtS5/tiJC1PcaTZKQG4z
 e0TIiTMIuNvQLZMXZdS+qXkra2k3jQMJdbmyfLR+xBub5/kdjxQ2bhLIVWJvJ7OO4Ogs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pfUf4-0008CN-TT for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Mar 2023 23:48:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4FD4562875;
 Thu, 23 Mar 2023 23:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF1BC433D2;
 Thu, 23 Mar 2023 23:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679615273;
 bh=738p3ibTqVlY5mo1Jphm9v6tZjFmkt3auqk1E27jx2E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YX7qSzBHOGjz+BQPpzLCv8yiAK0SsfYCgirUAoFcvlONRTp3PKeOdKIUisWMWvk1W
 M+/vWyIaPrJAA98QXQjryNlmcdT3D8ioXCPJz6E1kmJuOCwWl4zb6yoIWlQ098wVok
 0aCl1PW9aVeWI7FX8q9l6TGt2hySWekuX37e3gMQCtjsXdivfg9xCmGM5GtAIn18VX
 +dfH9pP80T66PSNS+sMHZ+3BHIDE+XzFOCksaDRExndCyRYXv8DBZBUPuxTD9uvF0Z
 fOA5dInQiforFZI81AoG2yQmXQ75L/lcSm3HVw/o4bBkXtYdukiRHq8SZmxdgbRkav
 ecLJ9DdTj7w6Q==
Date: Thu, 23 Mar 2023 16:47:51 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Yohan Joung <jyh429@gmail.com>
Message-ID: <ZBzlJ36kO5KvxODB@google.com>
References: <202303231039.GKLRE8O5-lkp@intel.com>
 <20230323072338.175-1-jyh429@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230323072338.175-1-jyh429@gmail.com>
X-Headers-End: 1pfUf4-0008CN-TT
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix align check for npo2
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
Cc: lkp@intel.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 03/23, Yohan Joung wrote:
> Fix alignment check to be correct in npo2 as well
> 
> Signed-off-by: Yohan Joung <yohan.joung@sk.com>
> ---
>  fs/f2fs/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 055e70e77aa2..46458085a8d0 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1858,7 +1858,7 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
>  		sector = SECTOR_FROM_BLOCK(blkstart);
>  		nr_sects = SECTOR_FROM_BLOCK(blklen);
>  
> -		if (sector & (bdev_zone_sectors(bdev) - 1) ||
> +		if (sector % bdev_zone_sectors(bdev) ||

Need to use div_u64_rem()?

>  				nr_sects != bdev_zone_sectors(bdev)) {
>  			f2fs_err(sbi, "(%d) %s: Unaligned zone reset attempted (block %x + %x)",
>  				 devi, sbi->s_ndevs ? FDEV(devi).path : "",
> 
> base-commit: d15180a8d1d72c7bddcb700d2c9ffdab7d2b9481
> -- 
> 2.25.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
