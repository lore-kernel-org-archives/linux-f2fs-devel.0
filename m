Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363C7606A32C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FxKiCzKz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=InG4UTro;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cgP8vazE;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3fv1KoO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=x55FMpwzOkVdQX4sANa3d9E44DgEqwrm4Z9wK2rh9No=; b=FxKiCzKzA4fvkw
	S8T8w5jvngRSpfQoC3R6DU7bAT9vmDeMEbPMZMJcIsg6nFs0T5sj0wkKZumXxDiYEprXKiOavqHVp
	8RCIGemvpNKjxCdCDyAETuknShTYRWKRWAvSJBy434XtEoZrVB43IeoNhnGPp6gJuE4jxA5IlWq+h
	ekw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNhI6-000000008L1-1VOv;
	Mon, 02 Nov 2026 01:56:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xNhI5-000000008Kt-1Qw9
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 01:56:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0ZsByk/ZJvDZM0D6OTRlx2ROiNL3TXd4513hn09OUlE=; b=InG4UTro4jLkXE/2ovx/7w5xT/
 hXfeIn3wlehl/iOhnl3qZzyBshobiWG1weLkHTnX13asBQK1sKyt8IaoSNzirWH/BYt4RhB0AmM46
 EGzaQJcaeglfQBq8T8pLF+R/7fz8TvP1afLywCpMtaUcmnvlYMoyUxX397x6N+IBv4xc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0ZsByk/ZJvDZM0D6OTRlx2ROiNL3TXd4513hn09OUlE=; b=cgP8vazEmrh+7WAHgjCebHVJhq
 wBeMH4GNAIoATY3lvXZL1/axfR63Zr/92ZtowRrf7ZQmXeXLXdU0VCThB+zCrwhqnjbauS3gfe5pw
 HkHGHmuxgouWd6rCgsnzGaJpxevjStDZCEcBlfkl1yqSrSfA+mJAXq8tdHCmIv4Ei4JE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNhI3-000000007Nk-2nPT
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 01:56:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D86060098;
 Mon,  2 Nov 2026 01:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B0B1F000C1;
 Mon,  2 Nov 2026 01:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793584605;
 bh=0ZsByk/ZJvDZM0D6OTRlx2ROiNL3TXd4513hn09OUlE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=B3fv1KoOC5Oy3t6N1R6tSXDEqk0yIOuoGCfOg6mtvRQF4/w2KZulY7lXYGB4eykbN
 lFUcP9ORWfhzd4EpAUxmwfvZEZoUC9n/yxdFjofD8c1S6YAKfvN1UJqyev+Mzas9HV
 GD9Lfh+X13BKrGjsEfAOWSSX+vPwEeinm4hHoOrSn30XzAiV4kY3Prrz68muzSfDQA
 bJVZOu9/Eq9ZJv3wVyqXdzh2vvdaJp5T35bn6IpKoJ0BNyFxQOnH1aLfGz0ZCxAIMx
 uUyikVSa+NcNci18d6ILj9MPZVddynvoNOIQnLi57wwe6y2FpsGhfsrZPCyFBg3Zzp
 nVbgiMoAV8rFA==
Message-ID: <a096053d-3f01-42aa-a933-50145abb874d@kernel.org>
Date: Mon, 2 Nov 2026 09:56:41 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, jaegeuk@kernel.org
References: <20261030072423.197883-1-zhanxusheng1024@gmail.com>
 <20261030072423.197883-2-zhanxusheng1024@gmail.com>
Content-Language: en-US
In-Reply-To: <20261030072423.197883-2-zhanxusheng1024@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNhI3-000000007Nk-2nPT
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: free the quota file name that
 remount drops
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: sandeen@redhat.com, zhanxusheng@xiaomi.com,
 syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, lihongbo22@huawei.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 15:24, Zhan Xusheng wrote:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> Remounting with an empty journalled quota option such as "usrjquota="
> clears the name, but f2fs_apply_quota_options() overwrites the old
> string without freeing it, so every such remount leaks it.
> 
> Free it after a grace period, as f2fs_show_options() may still be
> reading it.
> 
> Fixes: d18535132523 ("f2fs: separate the options parsing and options checking")

BTW, shouldn't it be:

Fixes: ff11d8701b77 ("f2fs: fix to allow removing qf_name")

Thanks,

> Reported-by: syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6c000dea1a93b4f5905c
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
> Tested in QEMU with KASAN and kmemleak, remounting with "usrjquota="
> and "usrjquota=f2fs" in a loop while reading /proc/mounts: nothing is
> reported.  A plain kfree() here trips KASAN in f2fs_show_options().
> 
>   fs/f2fs/super.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 510df7998c18..d86ab25fbcc5 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1646,7 +1646,7 @@ static void f2fs_apply_quota_options(struct fs_context *fc,
>   	struct f2fs_fs_context *ctx = fc->fs_private;
>   	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>   	bool quota_feature = f2fs_sb_has_quota_ino(sbi);
> -	char *qname;
> +	char *qname, *old;
>   	int i;
>   
>   	if (quota_feature)
> @@ -1662,7 +1662,10 @@ static void f2fs_apply_quota_options(struct fs_context *fc,
>   					GFP_KERNEL | __GFP_NOFAIL);
>   			set_opt(sbi, QUOTA);
>   		}
> -		F2FS_OPTION(sbi).s_qf_names[i] = qname;
> +		old = F2FS_OPTION(sbi).s_qf_names[i];
> +		/* Pairs with READ_ONCE() in f2fs_show_quota_options() */
> +		smp_store_release(&F2FS_OPTION(sbi).s_qf_names[i], qname);
> +		kfree_rcu_mightsleep(old);
>   	}
>   
>   	if (ctx->spec_mask & F2FS_SPEC_jqfmt)



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
