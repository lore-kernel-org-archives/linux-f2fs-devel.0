Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53356CD5BA4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 May 2026 08:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Bd6OoB0bp8+cMSf/o5zVTu7AcFn2JWlXyQGsr6f2b4=; b=jtd13tJhP8HEeAhd5jXDeBh1BA
	W+pqHcqHGkG1ryW73C/Qj9UM+TpmBsACPayxkPcKvvy8hzWyHmPY3Wam/bCPcoe+AUAzfZDhfWAJJ
	3PvD0zb+3LayZpTwGW7NerOlfy5PW5Vi+jwl8Sjv2AE9ieYL0B1RmMo9IkfjI0pWxneA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wPywl-0002Px-4e;
	Thu, 21 May 2026 08:40:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wPywj-0002PO-31
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 08:40:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=26uZD+IZUffG19NkVVVm9aNMMe6frsDq/dYJD1ulx+M=; b=MKreUstIo/Cn2/jNkyMugKhEc4
 ZPTd21HejJxzICTKCrY1mnXoEpKms7ZydxawI67mWzyXGARZF0Q/0pK/ss2oOEzMJTSk3popJa6/o
 k8VRx7oD1GRtlu6+YKe7ofT+0DTdVjRt2HBhnPemUh1Q7mOZB/b1I5ozVZLqpWXTu9G8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=26uZD+IZUffG19NkVVVm9aNMMe6frsDq/dYJD1ulx+M=; b=HDo64fgTI8cByt5dp3z4IQZVR/
 CVfWHQUnFyvQRx8wWK1uv0B63+QaeQP+lSP9Q1ZQNeOF/xA/UKXVkIyumkfRN0s5FSCIA5U3j9Yzo
 XUsgztf1xaRyCskXmg6VJJVevr+sgW0MpkVlrA5yzEkkVKKesxqPOTQ8uy+LLb4sE4OU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPywh-0005Sf-3J for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 May 2026 08:40:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EA3B6601F4;
 Thu, 21 May 2026 08:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3069E1F000E9;
 Thu, 21 May 2026 08:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779352788;
 bh=26uZD+IZUffG19NkVVVm9aNMMe6frsDq/dYJD1ulx+M=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=XsKuXJ2pmgYDcqANlFIkUGbH+mtk4upRMmishlZk5xbSSfi/B3/faoO9x3eOMPkvW
 +obbIUWpudmNKj+2OAVECaYH8+1+LxQ6WXOiTyrRRD/3EMXMlMH3rjq47ht1dTR73v
 +N/8/0Q9LvuqOjWEk0v4PrOBYsqNAFtAmC9CATqoAZl7DnWtkM6nHYyeUG2A2LFKDe
 5YQY5ywBzACm4MYddSxhTqxtSIF0xwrmxfdM0SdK1H42euTlN3j8HALNnPgFyurvmU
 NXK2ZileujkYoBmTU/Z1JDNclGLBa2Z2CdyNhOKXEz+gYVbqa0/A4raO7zYriN2zgV
 MxRyZWeWw05IQ==
Message-ID: <353a532f-6e22-4aed-8cf8-680c67685754@kernel.org>
Date: Thu, 21 May 2026 16:39:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260521053050.1785858-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260521053050.1785858-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wPywh-0005Sf-3J
Subject: Re: [f2fs-dev] [PATCH] f2fs: submit cached data bios before
 gc_merge GC
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
Cc: qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org, ruipengqi3@gmail.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

I've submitted the same fix previously as below:

https://lore.kernel.org/linux-f2fs-devel/20260519011438.1168155-1-chao@kernel.org

On 5/21/26 13:30, Wenjie Qi wrote:
> Commit fefdf0723650 ("f2fs: fix potential deadlock in f2fs_balance_fs()")
> added cached DATA bio submission before direct foreground GC in
> f2fs_balance_fs().
> 
> This avoids a deadlock between writeback and GC on cached data folios.
> However, when gc_merge is enabled, f2fs_balance_fs() does not execute
> foreground GC in the caller. It wakes the background GC thread and waits
> for that foreground request to finish.
> 
> That branch currently skips the cached DATA bio submission, so the same
> foreground GC request can still start with cached DATA bios pending.
> 
> Move the cached DATA bio submission before the gc_merge branch so both
> direct and merged foreground GC paths satisfy the same precondition.
> 
> Fixes: fefdf0723650 ("f2fs: fix potential deadlock in f2fs_balance_fs()")
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
>   fs/f2fs/segment.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 7c8ac62b1b0..1ef4edb7707 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -445,6 +445,13 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
>   	if (has_enough_free_secs(sbi, 0, 0))
>   		return;
>   
> +	/*
> +	 * Submit all cached OPU/IPU DATA bios before triggering
> +	 * foreground GC to avoid potential deadlocks.
> +	 */
> +	f2fs_submit_merged_write(sbi, DATA);
> +	f2fs_submit_all_merged_ipu_writes(sbi);
> +
>   	if (test_opt(sbi, GC_MERGE) && sbi->gc_thread &&
>   				sbi->gc_thread->f2fs_gc_task) {
>   		DEFINE_WAIT(wait);
> @@ -464,13 +471,6 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
>   			.err_gc_skipped = false,
>   			.nr_free_secs = 1 };
>   
> -		/*
> -		 * Submit all cached OPU/IPU DATA bios before triggering
> -		 * foreground GC to avoid potential deadlocks.
> -		 */
> -		f2fs_submit_merged_write(sbi, DATA);
> -		f2fs_submit_all_merged_ipu_writes(sbi);
> -
>   		f2fs_down_write_trace(&sbi->gc_lock, &gc_control.lc);
>   		stat_inc_gc_call_count(sbi, FOREGROUND);
>   		f2fs_gc(sbi, &gc_control);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
