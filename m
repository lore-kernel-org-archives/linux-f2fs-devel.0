Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492F7CDB46B
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 20 Jun 2026 07:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lvV34bhIpVMjMOPZKyRjK7XPSqoYGT9PVREfW6FKsJw=; b=mJXBmO5kXm7eEoQlULP5YAh/UG
	wT10GpYe/zvt47HkyI6FEgnBmgTd0XISk8wn1MB7X+t50aBM+Gu7vpd93MQCoB1iPDgESFu8NK6bR
	8Cg6kOiTtl5g+xYhXa/OypQvWrx40Vv1nHgENANWzS6YrmvHXvBv0FwKIjXZ4BPFCdM8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1waqZo-0006NH-G6;
	Sat, 20 Jun 2026 07:57:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1waqZn-0006N5-H5
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 20 Jun 2026 07:57:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gHo00aZGG9TlBjDkx/VKiOqBtFoIJs+Yb9ZY2yZ5UZI=; b=bkhYAbYe/4FwmxLlu+K78fewQg
 rERoYH7UpVQKyHRV24X2sMSZGpD5Hcxfy91rwceZfk7pFh0C0YCP4fslc2PaivE7uevc6qOU9+apl
 WlLotd53FAXS6218MjR/8qawbuiq+W1wWkqnAn+rITCdteQ8/z5Wws9Fn8u0lLlzxGNs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gHo00aZGG9TlBjDkx/VKiOqBtFoIJs+Yb9ZY2yZ5UZI=; b=ErHMLM642aMqjcOL8X+ARFFxRA
 bG1ZZOfvDB/xphzxItRNYOwVsJI5InKWhOfZIpRNQgOFzIE9Zb5uogfTXAcyzWXLMLsKuHZ8ibFyT
 tWV3E+tBodLS43uFAIGukZIVnSvUivfgeKLwV20rXdfMwnimLZN1CCYf1EVYeQU2tKD0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1waqZn-0004M9-1O for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 20 Jun 2026 07:57:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E894D600AE;
 Sat, 20 Jun 2026 07:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FB11F000E9;
 Sat, 20 Jun 2026 07:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781942229;
 bh=gHo00aZGG9TlBjDkx/VKiOqBtFoIJs+Yb9ZY2yZ5UZI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=IJuPVECqtlSg9Dy6GKD129q8dm0hdzyH7acwAC9w66Aw0rFp6cxP/6X8y5p6sWTUt
 Wj/Ak3CMQC33ejZbG7HmJ4+sSxtjMOi0uI0H6srqdzCU/qaE4JtlT+snf4OgXlaHZL
 vLdkS5k8S2ppCQ7XrD9ltBfKLm3gZy81FZDHwlAz5DI/lcwriCM/DLfLlEI3T7kTP/
 miyqr4DOR75mVB8LSgGCVs3KaylwUqdzNY6/48/LfK276CXmNwxC6TWQ0v8kts+enP
 q533yBTSi8u9NEq1iC5cwEMGGs952hk70vPBU32f6ZF9aYUtq9tTOSPXQBZpU3sj84
 49a5eoeLabNUQ==
Message-ID: <4354654f-3aca-40a8-bc88-23e540ee5aec@kernel.org>
Date: Sat, 20 Jun 2026 15:57:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260618100503.2601790-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260618100503.2601790-1-qiwenjie@xiaomi.com>
X-Headers-End: 1waqZn-0004M9-1O
Subject: Re: [f2fs-dev] [PATCH v7] f2fs: use post-decrement count for
 cp_wait wakeup
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
Cc: geoo115@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/18/26 18:05, Wenjie Qi wrote:
> f2fs_write_end_io() decrements the writeback page counter and then reads
> it again with get_pages() to decide whether the last F2FS_WB_CP_DATA
> completion should wake cp_wait.
> 
> That second read can miss the zero transition as below:

Looks comments of v7 patch is quite different from the one of v1 patch?

Quoted from v1:

"f2fs_write_end_io() currently decrements the writeback page counter before
waking sbi->cp_wait for the last F2FS_WB_CP_DATA completion.

That decrement can drop the F2FS_WB_CP_DATA count to zero. It can unblock
a concurrent unmount path waiting in f2fs_wait_on_all_pages(). Unmount can
continue through f2fs_put_super() and eventually free sbi while the end_io
callback is still about to evaluate wq_has_sleeper() and wake_up() on
sbi->cp_wait.

Commit 2d9c4a4ed4ee ("f2fs: fix UAF caused by decrementing sbi->nr_pages[]
in f2fs_write_end_io()") fixed one post-decrement sbi access by moving the
warm-node-list handling before dec_page_count(). The compressed writeback
path follows the same rule and documents that dec_page_count() must be the
last access to sbi when it can drop F2FS_WB_CP_DATA to zero.

Apply the same ordering rule to the cp_wait wakeup. Check whether this is
the last F2FS_WB_CP_DATA completion and wake the waiter before the counter
decrement. Then the callback no longer dereferences sbi->cp_wait after the
lifetime boundary. A waiter that runs before the decrement may observe old
count and sleep until the one-jiffy timeout, but correctness no longer
depends on touching sbi after the counter reaches zero."

I may found something interesting: v7 codes try to fix UAF bug described in
v1 comment, however v7 comment tries to explain what v2 codes want to do.

I suspect your LLM goes another direction after prompted w/ my comments on
patch v1? Let me know I'm wrong. :P

Thanks,

> 
> checkpoint          end_io A              submitter B
> - f2fs_wait_on_all_pages
>   - get_pages() > 0
>   - prepare_to_wait(cp_wait)
>   - io_schedule_timeout
>                      - f2fs_write_end_io
>                       - dec_page_count
>                        : count 1 -> 0
>                                           - f2fs_submit_page_write
>                                            - inc_page_count
>                                             : count 0 -> 1
>                       - get_pages() > 0
>                         : skip wake_up(cp_wait)
> 
> The checkpoint thread can then keep sleeping until
> DEFAULT_SCHEDULE_TIMEOUT, even though end_io A completed the old last
> F2FS_WB_CP_DATA page.
> 
> Use the post-decrement value for F2FS_WB_CP_DATA completions so the wakeup
> decision is tied to this completion.  Keep the existing dec_page_count()
> path for other writeback counters.
> 
> Fixes: e234088758fc ("f2fs: avoid wait if IO end up when do_checkpoint for better performance")
> Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
>   fs/f2fs/data.c | 12 +++++++-----
>   fs/f2fs/f2fs.h |  6 ++++++
>   2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d83a21998ec2..2afdcd209d54 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -392,15 +392,17 @@ static void f2fs_write_end_io(struct bio *bio)
>   		if (f2fs_in_warm_node_list(folio))
>   			f2fs_del_fsync_node_entry(sbi, folio);
>   
> -		dec_page_count(sbi, type);
> -
>   		/*
>   		 * we should access sbi before folio_end_writeback() to
>   		 * avoid racing w/ kill_f2fs_super()
>   		 */
> -		if (type == F2FS_WB_CP_DATA && !get_pages(sbi, type) &&
> -				wq_has_sleeper(&sbi->cp_wait))
> -			wake_up(&sbi->cp_wait);
> +		if (type == F2FS_WB_CP_DATA) {
> +			if (!dec_page_count_return(sbi, type) &&
> +			    wq_has_sleeper(&sbi->cp_wait))
> +				wake_up(&sbi->cp_wait);
> +		} else {
> +			dec_page_count(sbi, type);
> +		}
>   
>   		folio_clear_f2fs_gcing(folio);
>   		folio_end_writeback(folio);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 9f24287de4c3..db750cef371d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2776,6 +2776,12 @@ static inline void dec_page_count(struct f2fs_sb_info *sbi, int count_type)
>   	atomic_dec(&sbi->nr_pages[count_type]);
>   }
>   
> +static inline int dec_page_count_return(struct f2fs_sb_info *sbi,
> +					int count_type)
> +{
> +	return atomic_dec_return(&sbi->nr_pages[count_type]);
> +}
> +
>   static inline void inode_dec_dirty_pages(struct inode *inode)
>   {
>   	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
> 
> base-commit: c0b65f6129c7fbb526e921dd60261650f1b2bef9



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
