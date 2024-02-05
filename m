Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281E0C48291
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Feb 2024 03:54:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rWq3l-00064Q-9J;
	Mon, 05 Feb 2024 03:54:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rWq3j-00064K-RJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Feb 2024 03:54:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NIMblecH94dKbifJIQdCku0oaetpmUq51tl7M7CUWnQ=; b=M7tg0j1otvo4+EvCEF1V1as0xL
 DBOvoPk/abQYmQdAj3GVuxaRySeKoGHRpo11awJhLohfxj5mKkhrrpolxW/MAXmjSW/JIv8HrtE4p
 Yi1bmS6tcipwRQpN1bAJn6MXPKNyp+KuqQ29J7zkKRn/UyroE9fUVh9OD7VO6Y0fYIpA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NIMblecH94dKbifJIQdCku0oaetpmUq51tl7M7CUWnQ=; b=hcIRHYRKgibCXZR9+XYwemZXKJ
 igwv1MVuRL3ud5XMTNw1Cy+iYcmN2iEEZ/4M+D4XM4Rt5AHYE8sVdxMpXqZvCIiSKdka6Tu/dQxIy
 +/Eitgqp87ibHuCbF+lhHuVSjyjsp6OrcPFkCyhBwaNKXVX3wNzgEe4i8ynsozZv3mqc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rWq3i-0005j9-Cv for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Feb 2024 03:54:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A4A9A60EA9;
 Mon,  5 Feb 2024 03:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99821C433C7;
 Mon,  5 Feb 2024 03:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707105249;
 bh=NDy4o5zUZsXsouBNLnngKThxIfRGRetmmftaWLSdkgE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=AQWmjfiXjHNhMQWtPaU5bT7lKzYWq+yzwwhAs+ZmVm47LMmJ4szfMwO3npvWUM/yj
 LDBy06039vhjUMb5kOILukqV90eL4vswH4E3+ZFYz6mmDjk7HDCUBAlTooi51p5Dqi
 vmV+ulfYDs2+z2ZfT+32MzM0pe2cRiZWkpnAsGcMAgve+OAMEVb/IlVM78NLfphTQr
 +fFthBImmgn+5H2mxNfWqEVIxQKhIh6gYtCCrn1BCwzBmXERg7bIlY4pX7HTlyx8gg
 DyAwKQ2z47eOBxZkkRLuNSlpuirr2PbYPm/fWP7XRIcvpHGnPwr3pgDXIjTzocd8lx
 c6Xgm1t5Vl/eg==
Message-ID: <793fd834-fe28-4647-b2cf-0012acb95b43@kernel.org>
Date: Mon, 5 Feb 2024 11:54:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20240205031415.557879-1-bo.wu@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240205031415.557879-1-bo.wu@vivo.com>
X-Headers-End: 1rWq3i-0005j9-Cv
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: stop allocating pinned
 sections if EAGAIN happens"
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
Cc: Wu Bo <wubo.oduw@gmail.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/2/5 11:14, Wu Bo wrote:
> This reverts commit 2e42b7f817acd6e8d78226445eb6fe44fe79c12a.
> 
> If the GC victim section has a pinned block when fallocate() trigger
> FG_GC, the section is not able to be recycled. And this will return
> -EAGAIN cause fallocate() failed, even though there are much spare space
> as user see. As the GC policy prone to chose the same victim,
> fallocate() may not successed at a long period.
> 
> This scenario has been found during Android OTA.
> 
> Link: https://lore.kernel.org/linux-f2fs-devel/20231030094024.263707-1-bo.wu@vivo.com/t/#u
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>   fs/f2fs/file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index b58ab1157b7e..19915faccee9 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1725,7 +1725,7 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
>   			f2fs_down_write(&sbi->gc_lock);
>   			stat_inc_gc_call_count(sbi, FOREGROUND);
>   			err = f2fs_gc(sbi, &gc_control);
> -			if (err && err != -ENODATA)
> +			if (err && err != -ENODATA && err != -EAGAIN)
>   				goto out_err;
>   		}

How about calling f2fs_balance_fs() to double check and make sure there is
enough free space for following allocation.

		if (has_not_enough_free_secs(sbi, 0,
			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
			f2fs_down_write(&sbi->gc_lock);
			stat_inc_gc_call_count(sbi, FOREGROUND);
			err = f2fs_gc(sbi, &gc_control);
			if (err == -EAGAIN)
				f2fs_balance_fs(sbi, true);
			if (err && err != -ENODATA)
				goto out_err;
		}

Thanks,

>   


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
