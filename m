Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49ACDD2ECF7
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Jan 2026 12:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=knUjhfczlkYkUBMRfU2/Nh2s7/as54P83FPC+/73qTU=; b=dG0/R+6FpxcsiAkhbUgtmaBC6n
	0zO5ZQJaHb61K60HzrA5K+Vp3bzzNYQ/0mSAWN7kegDMWu12v81doRZSgU3KOYBF+6Jlk6SpgfmkY
	ynmz8ulS2mij0jLxoYG5V+VhO7r8JH6dp7lGYDNQVmniQ8/DQ9GZiURxK9qbBCG4CJwo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1viB2N-0006FD-TD;
	Tue, 20 Jan 2026 12:40:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1viB2M-0006F7-9g
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 12:40:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+E2lhauMWIogjZbldtmI7V5A2yKCTg1723CtzkjcpKM=; b=Em47vpEOLBla0V9hz1OA+S14VJ
 EKjQJsu+lnRIFI7UuAK1t4Y/BOt9xjNDxOn0d8WZiR6A/vYRE1mKDPB4yJ78cWVCABzz2gEUITbKV
 cl2ihY8pFWsM8s9319AOozOr05bzh883kPJTNMq5C0rPE3ojDT9Jc1oOe/hULkvZXgns=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+E2lhauMWIogjZbldtmI7V5A2yKCTg1723CtzkjcpKM=; b=PhC3hulb3poM8TNGzr4Cm5URqY
 FYI+i296kaQxbLrJHgEA96Ku/rciQj1A6jWk3+RhINtELGZP9kfvegAQ/5zvUipzkpmvfMW9wYzJl
 1EsWH1EO87KXrkHQrjr+zAWlgz0kTDyohMLoblaD3NNXY4Mh+adIqeCOCcVUl0YJu91Q=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1viB2L-0002m1-PE for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 12:40:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1EA0460008
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 20 Jan 2026 12:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763F0C16AAE;
 Tue, 20 Jan 2026 12:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768912839;
 bh=qd4e/5NjQ+ychHUY5U3BEFVht7+iweMgKxWb82Ab90o=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=BWWX9TC3pfc/3BHW/pCYKjJiGUUEKMAyIUiQsN4GxU+CjINBBKU6WSRApd0vUlY2k
 dhVNRo9zEgmUg6YYZyUmN4S4/QovhYSyDUy6lY3f5JbsM7MfU1LSSzJUMxtrUIEkxh
 TmuMT9Jzs7ksLt4I0mfr8vHIS3ZDphb7b3lnXQ5BKBJxkDlLWhWdUW+Hu/drXWMatu
 Omk+sUmKCGhm6GrH5FKH094b5kG2QXS9pd4Z/8kIz6HDJQOMkZLpH8+AIlSlxkBQo4
 J8L0ZKQ6njwk8j6B5Q4M5WFSqAXvc5oLVyoLOCfFd0Tzg/HJX6T+PLdTSlo9KlSDW1
 +drsYcOyzYYiA==
Message-ID: <cde115c8-9652-482b-b342-29fbcf4905bf@kernel.org>
Date: Tue, 20 Jan 2026 20:40:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20260116215044.2565391-1-jaegeuk@kernel.org>
Content-Language: en-US
In-Reply-To: <20260116215044.2565391-1-jaegeuk@kernel.org>
X-Headers-End: 1viB2L-0002m1-PE
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: add timeout in
 f2fs_enable_checkpoint()"
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
Cc: stable@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 1/17/2026 5:50 AM, Jaegeuk Kim via Linux-f2fs-devel wrote:
> This reverts commit 4bc347779698b5e67e1514bab105c2c083e55502.
> 
> For stability, let's keep flushing all the data.
> 
> Cc: stable@kernel.org
> Fixes: 4bc347779698 (f2fs: add timeout in f2fs_enable_checkpoint()")

We don't need to add Cc stable and Fixes line due to there is no regression
issue, meanwhile it needs to change commit message a bit.

Otherwise, it looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/f2fs.h  |  2 --
>   fs/f2fs/super.c | 15 ++++-----------
>   2 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 90aa1d53722a..8c256fcdcf5b 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -311,7 +311,6 @@ enum {
>   #define DEF_CP_INTERVAL			60	/* 60 secs */
>   #define DEF_IDLE_INTERVAL		5	/* 5 secs */
>   #define DEF_DISABLE_INTERVAL		5	/* 5 secs */
> -#define DEF_ENABLE_INTERVAL		16	/* 16 secs */
>   #define DEF_DISABLE_QUICK_INTERVAL	1	/* 1 secs */
>   #define DEF_UMOUNT_DISCARD_TIMEOUT	5	/* 5 secs */
>   
> @@ -1482,7 +1481,6 @@ enum {
>   	DISCARD_TIME,
>   	GC_TIME,
>   	DISABLE_TIME,
> -	ENABLE_TIME,
>   	UMOUNT_DISCARD_TIMEOUT,
>   	MAX_TIME,
>   };
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 25f796232ad9..4869145531cc 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2686,7 +2686,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>   
>   static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
>   {
> -	unsigned int nr_pages = get_pages(sbi, F2FS_DIRTY_DATA) / 16;
> +	int retry = DEFAULT_RETRY_IO_COUNT;
>   	long long start, writeback, end;
>   	int ret;
>   	struct f2fs_lock_context lc;
> @@ -2696,22 +2696,16 @@ static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
>   					get_pages(sbi, F2FS_DIRTY_NODES),
>   					get_pages(sbi, F2FS_DIRTY_DATA));
>   
> -	f2fs_update_time(sbi, ENABLE_TIME);
> -
>   	start = ktime_get();
>   
>   	/* we should flush all the data to keep data consistency */
> -	while (get_pages(sbi, F2FS_DIRTY_DATA)) {
> -		writeback_inodes_sb_nr(sbi->sb, nr_pages, WB_REASON_SYNC);
> +	do {
> +		sync_inodes_sb(sbi->sb);
>   		f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
> +	} while (get_pages(sbi, F2FS_DIRTY_DATA) && retry--);
>   
> -		if (f2fs_time_over(sbi, ENABLE_TIME))
> -			break;
> -	}
>   	writeback = ktime_get();
>   
> -	sync_inodes_sb(sbi->sb);
> -
>   	if (unlikely(get_pages(sbi, F2FS_DIRTY_DATA)))
>   		f2fs_warn(sbi, "checkpoint=enable has some unwritten data: %lld",
>   					get_pages(sbi, F2FS_DIRTY_DATA));
> @@ -4335,7 +4329,6 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>   	sbi->interval_time[DISCARD_TIME] = DEF_IDLE_INTERVAL;
>   	sbi->interval_time[GC_TIME] = DEF_IDLE_INTERVAL;
>   	sbi->interval_time[DISABLE_TIME] = DEF_DISABLE_INTERVAL;
> -	sbi->interval_time[ENABLE_TIME] = DEF_ENABLE_INTERVAL;
>   	sbi->interval_time[UMOUNT_DISCARD_TIMEOUT] =
>   				DEF_UMOUNT_DISCARD_TIMEOUT;
>   	clear_sbi_flag(sbi, SBI_NEED_FSCK);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
