Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D7CCD4F21
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 17 May 2026 09:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xYXcWM+AqNDv3lAFlN4cviFzaOHRQT+EWDEKHXIKiwM=; b=lvm0dfprZxbaOOYEwmd6d+IojN
	9ToyLxxIlBnVWlhKf8oRmGtBJCj6KtN5puPozd3r0AGFXKhjwgYQkGiMcmPVwwgmD2wOcdcYGBb6R
	b0jlPQjTzzaenSCLGYRXoG8VlYaZMijbQPR5GknKqveOGxZAYGVaedo8Q436G7viPk3I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wOXhZ-0006tP-6Y;
	Sun, 17 May 2026 09:22:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wOXhY-0006tH-Bc
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 17 May 2026 09:22:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NNUSR95rCTF1ViFDsjXV6V/ta/h5ih6gw9t7wAWn3ak=; b=gB6mz1Tsy6PMOhYE0+yqJkBVm0
 G5UvW1kjfeJFW5QkXUaRrGGLL2kN+VXew0kpLPIKVXN69zrU1i2FQftW+KVxq18+ZYWGW0a85lhuh
 1Sd6NqsZvPOMzy353hVLLnE8fgasCsbKHci7BQNFM32X9XjAXOaahyneDYBZstTplaBE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NNUSR95rCTF1ViFDsjXV6V/ta/h5ih6gw9t7wAWn3ak=; b=QIjnKM3Qxb5YxrbFkjiJwgpFkk
 zKSzNi1j/WkP2kBFhkCkIAd+rmPzOtFUpuF6G6stWb7+k1LstCPu78Atzm9fqBQJ9AeJSD4Xin7cZ
 d5TWaSZiqAjYS9d6P4F5Jr6/zwI5LqDATvF9BatZS8mAGhq/FEZbXCkjNBNrSu7FyBAQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wOXhX-0002ld-MX for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 17 May 2026 09:22:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AF06E40922;
 Sun, 17 May 2026 09:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E47C2BCB0;
 Sun, 17 May 2026 09:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779009738;
 bh=pFCRIYmewKHusvusZYzm8Yz8hISgDPWeySFQX+oH4To=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=IzaI7QrciJ4L7EBZbXH+SwuqI+sdme/G+nYpiKhTLfwILxmtNjtarsVa+TlqZOvwi
 /NMPxOF9Fks6r/9vUooc8IBL+E9f2Hvk/c4uemiImcE2Uk2mubJIKwLC2Avhkt5jcO
 weTQXrC5utAFSjTrPo1RB3X6DrPhchCLc1/ii4v+Ld1tHqnIt9epQ4rZBPljmcH53O
 ovj7YP6rqGBwRdBCo3kDIfi7c6EN3azhc5n1SMeVBoqiSHtZQ3cWrybzB17QqSnyuc
 T5YS+5b10SC4qBz7ugw5Kw2IibmMwO/5BZWY56gSD9l3H8le3VlzotSKQmWkf1VpFB
 NCfnp0vo/mOIw==
Message-ID: <f48fd685-21ae-4f1d-9a16-0f926f5e0e61@kernel.org>
Date: Sun, 17 May 2026 17:22:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ziyu Zhang <ziyuzhang201@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260516035001.272335-1-ziyuzhang201@gmail.com>
Content-Language: en-US
In-Reply-To: <20260516035001.272335-1-ziyuzhang201@gmail.com>
X-Headers-End: 1wOXhX-0002ld-MX
Subject: Re: [f2fs-dev] [PATCH] f2fs: make gc_wake test-and-clear atomic
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
Cc: gality369@gmail.com, zhenghaoran154@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, baijiaju1990@gmail.com,
 zzzccc427@gmail.com, r33s3n6@gmail.com, hanguidong02@gmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/16/2026 11:50 AM, Ziyu Zhang wrote:
> gc_thread_func() tests gc_th->gc_wake and then clears it with
> separate plain accesses. sysfs gc_urgent writes set the same flag and
> wake the GC thread. If a sysfs writer stores true between the GC
> thread's load and store, the later store false can clear the new wake
> request.

I can accept calling "echo 1 > gc_urgent" multiple times, but f2fs only
trigger one time, because it's rare to change to urgent mode, and there
should be no multiple users of this mode in Android.

> 
> Store gc_wake as an atomic_t. Use atomic_read() for the wait
> condition, atomic_xchg(..., 0) in the GC thread, and atomic_set(..., 1)
> in the sysfs trigger paths. This makes the consume-and-clear operation
> atomic with respect to new wake requests: a set before the exchange is
> consumed by the current iteration, while a set after the exchange stays
> pending for the next wait.
> 
> Fixes: d9872a698c39 ("f2fs: introduce gc_urgent mode for background GC")
> Signed-off-by: Ziyu Zhang <ziyuzhang201@gmail.com>
> ---
>   fs/f2fs/gc.c    | 7 +++----
>   fs/f2fs/gc.h    | 2 +-
>   fs/f2fs/sysfs.c | 4 ++--
>   3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 098e9f71421e..71e40e4083ad 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -49,15 +49,14 @@ static int gc_thread_func(void *data)
>   		wait_event_freezable_timeout(*wq,
>   				kthread_should_stop() ||
>   				waitqueue_active(fggc_wq) ||
> -				gc_th->gc_wake,
> +				atomic_read(&gc_th->gc_wake),
>   				msecs_to_jiffies(wait_ms));
>   
>   		if (test_opt(sbi, GC_MERGE) && waitqueue_active(fggc_wq))
>   			foreground = true;

If we trigger gc_urgent before, and then trigger again here, atomic_xchg()
will clear the new wakeup request as well? unless we record the total request
count into atomic variable.

Thanks,

>   
>   		/* give it a try one time */
> -		if (gc_th->gc_wake)
> -			gc_th->gc_wake = false;
> +		atomic_xchg(&gc_th->gc_wake, 0);
>   
>   		if (f2fs_readonly(sbi->sb)) {
>   			stat_other_skip_bggc_count(sbi);
> @@ -214,7 +213,7 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
>   		gc_th->boost_zoned_gc_percent = 0;
>   	}
>   
> -	gc_th->gc_wake = false;
> +	atomic_set(&gc_th->gc_wake, 0);
>   
>   	sbi->gc_thread = gc_th;
>   	init_waitqueue_head(&sbi->gc_thread->gc_wait_queue_head);
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index 24e8b1c27acc..65e5b062a0d3 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -56,7 +56,7 @@ struct f2fs_gc_kthread {
>   	unsigned int no_gc_sleep_time;
>   
>   	/* for changing gc mode */
> -	bool gc_wake;
> +	atomic_t gc_wake;
>   
>   	/* for GC_MERGE mount option */
>   	wait_queue_head_t fggc_wq;		/*
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index f736052dea50..6ca5943450d5 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -586,7 +586,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		} else if (t == 1) {
>   			sbi->gc_mode = GC_URGENT_HIGH;
>   			if (sbi->gc_thread) {
> -				sbi->gc_thread->gc_wake = true;
> +				atomic_set(&sbi->gc_thread->gc_wake, 1);
>   				wake_up_interruptible_all(
>   					&sbi->gc_thread->gc_wait_queue_head);
>   				wake_up_discard_thread(sbi, true);
> @@ -596,7 +596,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		} else if (t == 3) {
>   			sbi->gc_mode = GC_URGENT_MID;
>   			if (sbi->gc_thread) {
> -				sbi->gc_thread->gc_wake = true;
> +				atomic_set(&sbi->gc_thread->gc_wake, 1);
>   				wake_up_interruptible_all(
>   					&sbi->gc_thread->gc_wait_queue_head);
>   			}



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
