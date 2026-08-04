Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EDBC55182
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 00:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VB/zgSlC2tAIT/g4cYRAddivG9B8sOSoeNC5PW1ce8g=; b=i/mHUNX6AQzcaYKMZ14fAHMU8f
	6NbGP4tIrcIVmPV8OMB8xKOA5rRShSjeTNV/4a/5guIVTDAAd2TkRHn5mtfWNPJqDKAZtkEuloRoO
	BFRDgxTMHOcQiwdy2KXyPyAEKRdgEah2IZLCt39QepZXn6/EYLwahHdfCdAkJfolsaIQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wr2e3-0006XQ-2n;
	Tue, 04 Aug 2026 00:04:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wr2e1-0006XB-KO
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 00:04:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SnnYk1JHQwOvbacpIeV4zVA9juApMtgPEyOVr7ifN8g=; b=gUF6+ssGObYuHlgaWJBZvQ2Zyk
 spZeo65V54g++5dixq6dYbVgVKsQ77cPg45S8rZAyEHuYDjgZrTIaVfzymAIVqJaJ7tGBItdN5mAc
 /1HhgUX5no6MtWn93VTo8EN50QdLFDFXMzkaSnUI2nSf7uviMjIVejPJnVdTjZWg0w/c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SnnYk1JHQwOvbacpIeV4zVA9juApMtgPEyOVr7ifN8g=; b=FpFlvqUMKMRQWQoztc5620fHkg
 N41dLbkHMx6QuD1kJziMp//OB+72b7avI611oHqfWhSdeGXiLpXbTxFAWlPAB7NFBkogDZhQ349ab
 biDfJLDQA6QKmanMTmyhDGcrsdvHTjodWGj9ZClGX988ZirSTL5Jlb8ZoagHEHLQYoVU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wr2e5-0000qb-G6 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 00:04:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6181B60A60;
 Tue,  4 Aug 2026 00:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47C31F000E9;
 Tue,  4 Aug 2026 00:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785801868;
 bh=SnnYk1JHQwOvbacpIeV4zVA9juApMtgPEyOVr7ifN8g=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=abVAGg8Zm8mz9GXZcTTqixQbGiNcicni0cnj8rxiTVr6C3yp+pJ2lvVo4EuvQ0RBo
 Ws2yciw2s/nR9GCh1b+WFfbKQ1se4ow3ud06h3NoFdk3WEMjnGrQrQUstzjfFPq3lj
 l506zqUiZzhuizrE+bCpiFtgPxM5O5q7uTf8Uu/Av697v4cocPvegxZOk8ybtzA2ZO
 cIUWdbkoRuuNIECQ3EzhtXFDroZEusAPskSaQmxbDVmieBNrjCZCy3AMklqPYK+aK7
 JryICpkMOXLkLaI/O3uss/RPBa8bru7dhhFl7bJVIM62+Pr3jmZrvso6boePk4m1wd
 OAsGJO/+hggrQ==
Message-ID: <fdf53428-4ed6-46a2-b256-f7933aaccb86@kernel.org>
Date: Tue, 4 Aug 2026 08:04:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260803123251.1522864-1-qiwenjie@xiaomi.com>
 <20260803123251.1522864-2-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260803123251.1522864-2-qiwenjie@xiaomi.com>
X-Headers-End: 1wr2e5-0000qb-G6
Subject: Re: [f2fs-dev] [PATCH v3 2/2] f2fs: protect critical_task_priority
 updates with s_umount
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/3/26 20:32, Wenjie Qi wrote:
> The sysfs store path already takes s_umount for GC thread control
> entries, and ckpt_thread_ioprio is covered as well.
> 
> critical_task_priority also updates checkpoint or GC kthread scheduling
> state, but it is not covered by that serialization. It can race with
> remount or teardown paths that are stopping those threads.
> 
> Protect critical_task_priority sysfs writes with s_umount too.
> 

Missing fixes and Cc stable line, otherwise it looks good to me.

> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
> v3:
> - split this change out so patch 1 only fixes ckpt_thread_ioprio
> - keep this patch focused on critical_task_priority only
> 
>   fs/f2fs/sysfs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 0729b3670415..aa1621419932 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -1007,7 +1007,8 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
>   	ssize_t ret;
>   	bool gc_entry = (!strcmp(a->attr.name, "gc_urgent") ||
>   					a->struct_type == GC_THREAD);
> -	bool thread_entry = !strcmp(a->attr.name, "ckpt_thread_ioprio");
> +	bool thread_entry = !strcmp(a->attr.name, "ckpt_thread_ioprio") ||
> +			!strcmp(a->attr.name, "critical_task_priority");
>   
>   	if (gc_entry || thread_entry) {
>   		if (!down_read_trylock(&sbi->sb->s_umount))



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
