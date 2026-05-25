Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE416CD5BB1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 May 2026 12:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eai3M0BofrZUawpbf7l4JXPYk4CeaoDiIOQpleRsHMc=; b=VaKBB7eTJv5jvyc1Sd3AtjxHJK
	v4CjvYETWw3Bni54yrq5zHlmIjWVwh6Kogd3ucDtkkR8N+qdQ3biuxA08W4p7rmLnl41EfQZf3lZz
	CpzJTMZ+pIJcr8+79GY9gGHma7pJ0/AFtQglzuo/D+L9ibsOH3w7Yj7aOeVcyhatnxEk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRUDM-0007v4-C1;
	Mon, 25 May 2026 12:15:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wRUDK-0007uy-S3
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 12:15:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YwmYeBFlqqwtunb0YVMfJONsz3dZjRTkfJZWi8iMnMw=; b=EV72eXgSm+E9Iw4OMqTx9cYwUy
 PCf0cucj1LSsE6wNtY1OYb18U5gnM4UksGaQ3tdPrOo2V1LlJ/Qobs9Gp7Owec9FRgm7/rmLytyJz
 Qr4AzFf0tMicZIsuxU8zYhXVHWuMijwlXqVdP+1nDBDhe+IzAe8qHx/KRr/kvE7/NQxU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YwmYeBFlqqwtunb0YVMfJONsz3dZjRTkfJZWi8iMnMw=; b=bWyIRtfsHk+BdyKtbpAPuMumHh
 pzmf03yDYkuopjm71MLeb+0bDqR71WCW01k4Rj1gl2sEK6bq2+GSH9ErsSl3e09qyBA1ivuOqSZI5
 e2SE/zljsZVAFlL9AypgZjoqBsp1OEyGb9gSLEi398Yf/qkCuhBhaMdUvq33DZ6/RXxg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRUDJ-0002I6-K1 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 12:15:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BCA09444D7;
 Mon, 25 May 2026 12:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BCC1F000E9;
 Mon, 25 May 2026 12:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779711311;
 bh=YwmYeBFlqqwtunb0YVMfJONsz3dZjRTkfJZWi8iMnMw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=F+BYWNDJvexcMY4vpQ20WgvP6BSLXbGlElchCA4fjZ8TPmc/SOzoluHEum107N8+n
 g8TKf3tqqS4RFJW04LQlvVbGoOBGg5bevJEDTgbJ5lfuabw6GnDlcwJppNGWrUq/62
 9q2QGfLnGmEmRovowXTKaSGERu7BcD03nepm4b+8apur9MUD0NnLe6wutO9+vDuWe5
 ImtVxVWNFdi5fVwf9VlvbNhQIapqHRl7Nru3WVanPzOsfajJnPIvF8JlqLSjTmBXkQ
 wx3HRGHySjyzovqRerAsNeehQdO55MTP08UcSWuXjskKFTzK895f/zBa0BfvVGg5uF
 t7gOAsXSukE7A==
Message-ID: <6a5068fe-b62b-4f43-b0ae-ab1c7f70e078@kernel.org>
Date: Mon, 25 May 2026 20:15:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260525053016.169150-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260525053016.169150-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wRUDJ-0002I6-K1
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid cp_wait use-after-free in
 f2fs_write_end_io()
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
Cc: geoo115@gmail.com, yangyongpeng@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com, stable@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/25/26 13:30, Wenjie Qi wrote:
> f2fs_write_end_io() currently decrements the writeback page counter before
> waking sbi->cp_wait for the last F2FS_WB_CP_DATA completion.
> 
> That decrement can drop the F2FS_WB_CP_DATA count to zero. It can unblock
> a concurrent unmount path waiting in f2fs_wait_on_all_pages(). Unmount can
> continue through f2fs_put_super() and eventually free sbi while the end_io
> callback is still about to evaluate wq_has_sleeper() and wake_up() on
> sbi->cp_wait.
> 
> Commit 2d9c4a4ed4ee ("f2fs: fix UAF caused by decrementing sbi->nr_pages[]
> in f2fs_write_end_io()") fixed one post-decrement sbi access by moving the
> warm-node-list handling before dec_page_count(). The compressed writeback
> path follows the same rule and documents that dec_page_count() must be the
> last access to sbi when it can drop F2FS_WB_CP_DATA to zero.
> 
> Apply the same ordering rule to the cp_wait wakeup. Check whether this is
> the last F2FS_WB_CP_DATA completion and wake the waiter before the counter
> decrement. Then the callback no longer dereferences sbi->cp_wait after the
> lifetime boundary. A waiter that runs before the decrement may observe old
> count and sleep until the one-jiffy timeout, but correctness no longer
> depends on touching sbi after the counter reaches zero.
> 
> Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")
> Cc: stable@kernel.org
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
>   fs/f2fs/data.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d83a21998ec2..b1e9fb5ca159 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -392,16 +392,16 @@ static void f2fs_write_end_io(struct bio *bio)
>   		if (f2fs_in_warm_node_list(folio))
>   			f2fs_del_fsync_node_entry(sbi, folio);
>   
> -		dec_page_count(sbi, type);
> -
>   		/*
> -		 * we should access sbi before folio_end_writeback() to
> -		 * avoid racing w/ kill_f2fs_super()
> +		 * Access sbi before dec_page_count() and folio_end_writeback()
> +		 * to avoid racing w/ kill_f2fs_super().
>   		 */
> -		if (type == F2FS_WB_CP_DATA && !get_pages(sbi, type) &&
> -				wq_has_sleeper(&sbi->cp_wait))
> +		if (type == F2FS_WB_CP_DATA && get_pages(sbi, type) == 1 &&
> +		    wq_has_sleeper(&sbi->cp_wait))
>   			wake_up(&sbi->cp_wait);

If we call dec_page_count() after wake_up(), get_pages() in below function
may return true, and then ckpt thread may need to wait on cp_wait for another
DEFAULT_SCHEDULE_TIMEOUT?

void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
{
	DEFINE_WAIT(wait);

	for (;;) {
		if (!get_pages(sbi, type))
			break;

		if (unlikely(f2fs_cp_error(sbi) &&
			!is_sbi_flag_set(sbi, SBI_IS_CLOSE)))
			break;

		if (type == F2FS_DIRTY_META)
			f2fs_sync_meta_pages(sbi, LONG_MAX, FS_CP_META_IO);
		else if (type == F2FS_WB_CP_DATA)
			f2fs_submit_merged_write(sbi, DATA);

		prepare_to_wait(&sbi->cp_wait, &wait, TASK_UNINTERRUPTIBLE);
		io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
	}
	finish_wait(&sbi->cp_wait, &wait);
}

How about:

static inline int dec_return_page_count(struct f2fs_sb_info *sbi, int count_type)
{
	return atomic_dec_return(&sbi->nr_pages[count_type]);
}

f2fs_write_end_io()
{
...
	bool need_wakeup = false;

...

	if (type == F2FS_WB_CP_DATA)
		need_wakeup = !dec_return_page_count(sbi, type);
	else
		dec_page_count(sbi, type);


	if (need_wakeup && wq_has_sleeper(&sbi->cp_wait))
		wake_up(&sbi->cp_wait);
...
}

Thanks,

>   
> +		dec_page_count(sbi, type);
> +
>   		folio_clear_f2fs_gcing(folio);
>   		folio_end_writeback(folio);
>   	}



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
