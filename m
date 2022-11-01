Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5855C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Nov 2022 15:15:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1opsz7-0004sH-5B;
	Tue, 01 Nov 2022 15:15:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1opsyr-0004s4-AY
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Nov 2022 15:15:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/kuUJC2mI+fKkTEVjFb2OgMTlWwHvNf8VjkQ1rMO1Uo=; b=dkMGsaKkmFWtv+6c1hFzImOSwD
 SneD53i4lA+P+48qSqCSvXUZIkAkKjmzR5ZPmaIkN0TZ8tpMrpDkTh8KKHwgEXVFCwU9wQlGOyxBO
 Ljqtgu7/cIrLe+sgSqHcBdD0bEhcXdb1WZ+LPXO9KYmNfwl50dpRdfSkXEDDMuucr7Kg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From:
 References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/kuUJC2mI+fKkTEVjFb2OgMTlWwHvNf8VjkQ1rMO1Uo=; b=aCBbXQ975FlOqjy7+9PpHpfS8E
 AjuKqhGuRw27troDxfINmtL82hwowSNIsX5MvEJIaBsWICeRPUiKVIpx44YyoXXmA0IRU5W36lRvs
 1chQL5SssZEjv6HaLdVNuhusuDaKo/eM3MFBTFXlTLAcFxT66Hq8hrpq4VQiWZBKP0uE=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1opsym-0001TK-V7 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Nov 2022 15:15:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id AD658B81E6C;
 Tue,  1 Nov 2022 15:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37745C433D6;
 Tue,  1 Nov 2022 15:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667315697;
 bh=K8l71rqgkflfcqzq6zpcUJabx7k/R95mzZKRenQ/V7E=;
 h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
 b=CEApPlBaOEfvrN+B5Y/YD+KhxDbZyu5IKXn1LsohCm/9EHmCJ11tswKkahg5g/0Dy
 Ursqdi8IgdjtQOFw1Ve40wg7hNMbjTGqfeYPTYNbkXOX6PjG5RUNqh+Hrg4vmCv5hO
 RIw3JWBUGlXbMpT6PklTqFAAxAtbNp0Y238qv9ZMeY8GWxD6MmyHb0OzJFQLPrjzdN
 500I3zcQHm+FOZDgSmOGbqsAQ5QxjaLhc4Eitfl2Q9hmwUghk6eIJ+eSZgE4fMo4gr
 sGbLxItM9EpYjRTbq1izCxR6pGZfwuAXSl0u7AEVtwfUOEGffPqlUhaGp5GS4xfxde
 WKgaoNWKV5ODQ==
Message-ID: <af41e68c-4f78-0934-1041-974e44bd3825@kernel.org>
Date: Tue, 1 Nov 2022 23:14:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To: qixiaoyu1 <qxy65535@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20221021023136.22863-1-qixiaoyu1@xiaomi.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221021023136.22863-1-qixiaoyu1@xiaomi.com>
X-Headers-End: 1opsym-0001TK-V7
Subject: Re: [f2fs-dev] [PATCH] f2fs: separate IPU policy for fdatasync from
 F2FS_IPU_FSYNC
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
Cc: qixiaoyu1 <qixiaoyu1@xiaomi.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/10/21 10:31, qixiaoyu1 wrote:
> Currently IPU policy for fdatasync is coupled with F2FS_IPU_FSYNC.
> Fix to apply it to all IPU policy.

Xiaoyu,

Sorry for the delay.

I didn't get the point, can you please explain more about the
issue?

Thanks,

> 
> Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
> ---
>   fs/f2fs/data.c | 8 +++-----
>   fs/f2fs/file.c | 4 +++-
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a71e818cd67b..fec8e15fe820 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2518,6 +2518,9 @@ static inline bool check_inplace_update_policy(struct inode *inode,
>   	if (policy & (0x1 << F2FS_IPU_HONOR_OPU_WRITE) &&
>   			is_inode_flag_set(inode, FI_OPU_WRITE))
>   		return false;
> +	/* this is set by fdatasync or F2FS_IPU_FSYNC policy */
> +	if (is_inode_flag_set(inode, FI_NEED_IPU))
> +		return true;
>   	if (policy & (0x1 << F2FS_IPU_FORCE))
>   		return true;
>   	if (policy & (0x1 << F2FS_IPU_SSR) && f2fs_need_SSR(sbi))
> @@ -2538,11 +2541,6 @@ static inline bool check_inplace_update_policy(struct inode *inode,
>   			!IS_ENCRYPTED(inode))
>   		return true;
>   
> -	/* this is only set during fdatasync */
> -	if (policy & (0x1 << F2FS_IPU_FSYNC) &&
> -			is_inode_flag_set(inode, FI_NEED_IPU))
> -		return true;
> -
>   	if (unlikely(fio && is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
>   			!f2fs_is_checkpointed_data(sbi, fio->old_blkaddr)))
>   		return true;
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 82cda1258227..08091550cdf2 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -270,8 +270,10 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>   		goto go_write;
>   
>   	/* if fdatasync is triggered, let's do in-place-update */
> -	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
> +	if (datasync || (SM_I(sbi)->ipu_policy & (0x1 << F2FS_IPU_FSYNC) &&
> +			get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks))
>   		set_inode_flag(inode, FI_NEED_IPU);
> +
>   	ret = file_write_and_wait_range(file, start, end);
>   	clear_inode_flag(inode, FI_NEED_IPU);
>   


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
