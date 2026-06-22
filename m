Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE7CCD98F0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jun 2026 01:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7WNuvuHc4BOzYoqj2AFIDZmdTTHsTBkQFIrKWV1IZ9A=; b=AUdB3383iCSu2iIb2nRgkxL+8w
	6uIDGpzCRXU2hbennmJ+HKnnumKiw22l+jdZu3Etl0AHQ6p+2Rm3GSVwXPhWge1JX0BWbBllIWe8A
	jXKaj8WtqWpaKPWwgQDWSqToEytQzdgh+0FHfaG2M43/533QabddzVWHZ5z4CC5COu8E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wbTkJ-0006sL-8P;
	Mon, 22 Jun 2026 01:46:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wbTkH-0006sF-Fj
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 01:46:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s8d0wK3H8YgUvjSOLhu94Vxjd6l1lGx3XFz9Z10AdaE=; b=ahRaZKk20SUF0VAtn6O14l2Jmu
 hz8nFP7sLhxEetTF9cv52rAfXGwK/Q+f/EjTzRCyW/oOWZToul18RAqKefYykPb8CaNOPf3JQAVj2
 5DsSnuquWk0KAdEN3RdS3zB3mPjZe0LGCYdoEuBYhdTudhWZN4DTmlUsHA5XGjo7VYJM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=s8d0wK3H8YgUvjSOLhu94Vxjd6l1lGx3XFz9Z10AdaE=; b=ZT5M/4oQRgue9xO2asJT13Q1c2
 GLgT+Zqsw+3wQJvadVqeUa0TBJI5PQ8HPdeZanFUAZYO7xFmvSod+kgcL7XmVvIK7VDheCaVniS/0
 sR5aD9wzV4/c0rpGhSHSVMynGhDItlm7OQbI4eZrBDvfJz9JZxCIJhlOOplnQCETco3Y=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbTkF-0002zR-IL for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 01:46:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E63B460051;
 Mon, 22 Jun 2026 01:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59AE1F000E9;
 Mon, 22 Jun 2026 01:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782092788;
 bh=s8d0wK3H8YgUvjSOLhu94Vxjd6l1lGx3XFz9Z10AdaE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=W77ZZOHBS8gCVXnJijAIx3wZiwldPoeL5bBzb/7jLyGCbzSWX1pbRC5DN0uGwuesA
 tDconFwAHlWioK9KHJOcj+7ty7PBSHo5Mo8Lq/BU7ISWMAbjgV+eXFuBOCCP4JJNj0
 EdtwCGOh2DN4oNpcwtqBjzrA24N/HA8frrBsBbSzQqbk0tVtB3BT5IsxB8zVvwlhhF
 9VnNL/1gAxTSO/fMKRGNxKfoC4Xt7v88W+lBkwQVlfad/5eVcNgUH05aasdMI+HJb1
 a/tpeUFXVBThcokXb1gCukv4Q+ESqcLzjOp4xnM6xLOomyBFlYr8pcsDQERoPsD+6j
 dyEXnOAr1NSug==
Message-ID: <dffacd73-ebc2-4f35-9433-d569b48014be@kernel.org>
Date: Mon, 22 Jun 2026 09:46:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jiucheng.xu@amlogic.com, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260620-origin-dev-v1-1-3b2e639e794c@amlogic.com>
Content-Language: en-US
In-Reply-To: <20260620-origin-dev-v1-1-3b2e639e794c@amlogic.com>
X-Headers-End: 1wbTkF-0002zR-IL
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix FG GC failure when file in victim
 is pinned
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
Cc: tuan.zhang@amlogic.com, linux-kernel@vger.kernel.org,
 jianxin.pan@amlogic.com, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/20/26 17:34, Jiucheng Xu via B4 Relay wrote:
> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
> 
> When continuous write operations occur in the system, BG GC fails to
> work. This leads to large dirty_segments and small free_segments. If
> fallocate() is performed on a pinned file with the allocated space
> exceeding the free_segment, FG_GC reclamation fails.
> 
> The reason is that the file corresponding to the block in the victim is
> pinned, causing gc_data_segment() to fail. Since the condition sec_freed

Jiucheng,

pinned file should be aligned to section size, why there is fragmented blocks
of pinfile locates in dirty sections?

> < gc_control->nr_free_secs isn't satisfied, GC stops, resulting in the
> failure of f2fs_fallocate() allocation.
> 
> Setting gc_control->nr_free_secs = 1 make FG GC continue searching
> for new victim.

Maybe we can try this instead of changing f2fs_expand_inode_data() logic:
1. call fggc via ioctl or trigger urgent gc via sysfs
2. fallocate on pinfile, goto 1) if it failed

But, anyway, I suspect it's risk, if there is no normal dirty section,
FGGC will try to call f2fs_unpin_all_sections(), then migrate dirty section
which has pinned blocks, that will cause more damage.

Can you please figure out why pinfile is fragmented first...

Thanks,

> 
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> ---
>   fs/f2fs/file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 8acdd94272a0ced448e0ba21635d702cfec10682..3e49a73bbf3a184a314e97bff9509a66c27eac00 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1883,7 +1883,7 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
>   			.init_gc_type = FG_GC,
>   			.should_migrate_blocks = false,
>   			.err_gc_skipped = true,
> -			.nr_free_secs = 0 };
> +			.nr_free_secs = 1 };
>   	pgoff_t pg_start, pg_end;
>   	loff_t new_size;
>   	loff_t off_end;
> 
> ---
> base-commit: b51f606aa323d553d786ed681a213f134dc688d6
> change-id: 20260620-origin-dev-99cdccc83800
> 
> Best regards,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
