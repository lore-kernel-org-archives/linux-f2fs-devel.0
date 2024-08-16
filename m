Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B464C52D7C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Aug 2024 02:30:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1semjb-0004bp-6i;
	Fri, 16 Aug 2024 02:30:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1semja-0004bi-4T
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Aug 2024 02:30:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7SeoSU/PRu22uMkUFO6EkAXNfWasgRhCOGCVEjrCiXI=; b=PvQIeg7mZvpcL/nSFnBW2BxivG
 Tkd2F8K578WIfLv5e/Fha+67jv8RJJaWRN6jbWktHRJJDKdZ+EymfF4vgTWndmCpQgZscCLRgiSc5
 UURqnap8OdRWpl286/1Jvm9V5AGTKpO5BtrqqmCndfJXLtHoNiESydF0QULx6y9YHJlw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7SeoSU/PRu22uMkUFO6EkAXNfWasgRhCOGCVEjrCiXI=; b=eqGyt3yniXCUbXQi0zgMYLTEb6
 SDQccqID/zzs2sQJXGIL5vVQUn+IdjV7oHUiKTQC8DyOqqKFt0Ht3lNTnSbCBg5hY+EMIqvvJvIUf
 v1UDM+oRd0U5HsuH1B+xrpgvAyBlOIuhessrs64jk6OYQrdlWmrQbQfdm6isFYhgG2IM=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1semjY-0002Mj-GL for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Aug 2024 02:30:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 95262CE1EC9;
 Fri, 16 Aug 2024 02:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FCBC32786;
 Fri, 16 Aug 2024 02:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723775419;
 bh=RRKv6BK2uyxfKOpDGLdqG+hlBlBiteVFLDwYsyDuEFg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tsyhc8lDRwoayKHCxOD7MzDzsIankGc5cr704FHX0gzmB9Akmgfe1Qz1iUjYF4YAp
 JSlXQHuXtGolaj5gLVII7mH7uGh2nzAA7BluwC4Otq2zH8087K6HbT/z8HAvFvrJgR
 RvJKzMd42rkjnIb1lZoX0ZSS6LMPIniPL4y140uv1CujR+opgX9Vf7N8UpOt1jozFS
 x6hJ91TomIP9RmdYeUnkGLle2WSZc5scZ29szjJ6GxI8ApIwqdfXd1SlfU52pR8u/x
 Ad/oQSEAjJtz5o/IZUpBDifZBVtQH6f1fY/IVmbwIAV8RZBZqr8H6W/uhSVxWvXr4X
 5q89WaEjfwhBA==
Message-ID: <a4e822d5-9d3a-4d95-b568-8482385fa85c@kernel.org>
Date: Fri, 16 Aug 2024 11:30:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
References: <20240816022353.734136-1-shinichiro.kawasaki@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240816022353.734136-1-shinichiro.kawasaki@wdc.com>
X-Headers-End: 1semjY-0002Mj-GL
Subject: Re: [f2fs-dev] [PATCH] f2fs: check discard support for conventional
 zones
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
Cc: Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/16/24 11:23, Shin'ichiro Kawasaki wrote:
> As the helper function f2fs_bdev_support_discard() shows, f2fs checks if
> the target block devices support discard by calling
> bdev_max_discard_sectors() and bdev_is_zoned(). This check works good

s/good/well

> for most cases, but it does not work for conventional zones on zoned
> block devices. F2fs assumes that zoned block devices support discard,
> and calls __submit_discard_cmd(). When __submit_discard_cmd() is called
> for sequential write required zones, it works fine since
> __submit_discard_cmd() issues zone reset commands instead of discard
> commands. However, when __submit_discard_cmd() is called for
> conventional zones, __blkdev_issue_discard() is called even when the
> devices do not support discard.
> 
> The inappropriate __blkdev_issue_discard() call was not a problem before
> the commit 30f1e7241422 ("block: move discard checks into the ioctl
> handler") because __blkdev_issue_discard() checked if the target devices
> support discard or not. If not, it returned EOPNOTSUPP. After the
> commit, __blkdev_issue_discard() no longer checks it and always returns
> zero and sets NULL to the give bio pointer. This NULL pointer triggers
> f2fs_bug_on() in __submit_discard_cmd(). The BUG is recreated with the
> commands below at the umount step, where /dev/nullb0 is a zoned null_blk
> with 5GB total size, 128MB zone size and 10 conventional zones.
> 
> $ mkfs.f2fs -f -m /dev/nullb0
> $ mount /dev/nullb0 /mnt
> $ for ((i=0;i<5;i++)); do dd if=/dev/zero of=/mnt/test bs=65536 count=1600 conv=fsync; done
> $ umount /mnt
> 
> To fix the BUG, avoid the inappropriate __blkdev_issue_discard() call.
> When discard is requested for conventional zones, check if the device
> supports discard or not. If not, return EOPNOTSUPP.
> 
> Fixes: 30f1e7241422 ("block: move discard checks into the ioctl handler")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  fs/f2fs/segment.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 78c3198a6308..e10bf3c4eed5 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1281,6 +1281,8 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  			__submit_zone_reset_cmd(sbi, dc, flag,
>  						wait_list, issued);
>  			return 0;
> +		} else if (!bdev_max_discard_sectors(bdev)) {
> +			return -EOPNOTSUPP;
>  		}

You do not need the else here. And I suggest adding a comment as well:

		/*
		 * Issue discard for conventional zones only if the
		 * device supports discard.
		 */
		if (!bdev_max_discard_sectors(bdev))
			return -EOPNOTSUPP;

With that:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

>  	}
>  #endif

-- 
Damien Le Moal
Western Digital Research



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
