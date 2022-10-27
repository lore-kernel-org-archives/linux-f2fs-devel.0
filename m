Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25CCFA3740
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Oct 2022 13:20:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oo2nk-0007CA-IQ;
	Thu, 27 Oct 2022 13:20:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oo2ni-0007C4-V7
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Oct 2022 13:20:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b1s3PLCfseNiQto07W8xv2qFrSHpOs0BnMrnq20lJxs=; b=QQuOF+51N6X7p+AfNOB8+vQEaL
 UlBlj1gtpbMPgoJlux54jF3Lq4pY8OwGojMLwkq83pHdIrnrGWa9md22ZzCabiu66xw5c7Lw/wJRv
 WJH0oQ50euaj3oI9QrF3IeSjrZkFPyufO48ycD4zwLSkbPyrl1kne7brCD+fwxfxU284=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=b1s3PLCfseNiQto07W8xv2qFrSHpOs0BnMrnq20lJxs=; b=ES8DjNk+QlHQMhkH/yrTix1h+a
 034br8ZEDTHSIMClk882LnyhWn/gY9lrr5hvVn+NBBWpzuvNvnH17f24pJ/J/fOc+vVkgWHS9dt+T
 KE73Z6bFWtpiZhzTZ8VImIMfsLsBHR5c2Q1Myk0asLoTsDZj1V8z9cTF/BrMopUHHEQQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oo2ne-000867-Nf for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Oct 2022 13:20:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AC406622E3;
 Thu, 27 Oct 2022 13:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F367C433D7;
 Thu, 27 Oct 2022 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666876787;
 bh=Synhsdq7aucXPF27l++LXoYHda67bqMcrjW8SAWdwL0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OmGZrQE6Hfm5Rpy/xlALCIt1kch5oV0oWlFhX74YaA0MLqfAQB+ZuMKNhmX5i9cZ0
 r4BvXAujrkUZeCz0M5+xT67EkvI4sLs3oR/X8ErntaWwbXnQEWqJHd9bJHcrCk+G/Z
 MRZAhjkfONUnLeH9OE0gEAs+TbVwu+4pGeiQef4EW2kiX+7NMQxzoMMezecCKojdkO
 DC6lWUGNfhgQzZtjP7JNlinZAJFJBAdeux+o7kBNWGvG2LohoR/uUdy1dlkuSY0ql/
 YpGiSK+w+I5b1AtQJiQHD1Eol/niTOPjKeDKI/HHTWbYTaDCn3BCzJsyEBX8ayX0TD
 /BTYwzQLbbpkg==
Message-ID: <38e9d711-a3c6-3f02-19c4-9d298d386e4c@kernel.org>
Date: Thu, 27 Oct 2022 21:19:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20221027102447.75708-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221027102447.75708-1-frank.li@vivo.com>
X-Headers-End: 1oo2ne-000867-Nf
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: cleanup in
 f2fs_create_flush_cmd_control() and f2fs_start_gc_thread()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/10/27 18:24, Yangtao Li wrote:
> Just cleanup for readable, no functional changes.

How about doing such cleanup in one patch?

Thanks,

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/gc.c      | 14 ++++++--------
>   fs/f2fs/segment.c |  3 +--
>   2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 674a905063db..85d16f4106de 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -171,13 +171,10 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
>   {
>   	struct f2fs_gc_kthread *gc_th;
>   	dev_t dev = sbi->sb->s_bdev->bd_dev;
> -	int err = 0;
>   
>   	gc_th = f2fs_kmalloc(sbi, sizeof(struct f2fs_gc_kthread), GFP_KERNEL);
> -	if (!gc_th) {
> -		err = -ENOMEM;
> -		goto out;
> -	}
> +	if (!gc_th)
> +		return -ENOMEM;
>   
>   	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
>   	gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
> @@ -192,12 +189,13 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
>   	sbi->gc_thread->f2fs_gc_task = kthread_run(gc_thread_func, sbi,
>   			"f2fs_gc-%u:%u", MAJOR(dev), MINOR(dev));
>   	if (IS_ERR(gc_th->f2fs_gc_task)) {
> -		err = PTR_ERR(gc_th->f2fs_gc_task);
> +		int err = PTR_ERR(gc_th->f2fs_gc_task);
>   		kfree(gc_th);
>   		sbi->gc_thread = NULL;
> +		return err;
>   	}
> -out:
> -	return err;
> +
> +	return 0;
>   }
>   
>   void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 282616e6852a..becceee8e337 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -638,7 +638,6 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
>   {
>   	dev_t dev = sbi->sb->s_bdev->bd_dev;
>   	struct flush_cmd_control *fcc;
> -	int err;
>   
>   	if (SM_I(sbi)->fcc_info) {
>   		fcc = SM_I(sbi)->fcc_info;
> @@ -662,7 +661,7 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
>   	fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
>   				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
>   	if (IS_ERR(fcc->f2fs_issue_flush)) {
> -		err = PTR_ERR(fcc->f2fs_issue_flush);
> +		int err = PTR_ERR(fcc->f2fs_issue_flush);
>   		kfree(fcc);
>   		SM_I(sbi)->fcc_info = NULL;
>   		return err;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
