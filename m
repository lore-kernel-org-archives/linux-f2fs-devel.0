Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95319C5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Aug 2026 02:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xZ8UQzpPtS+8m0WR9J9N2DGpH2A01RiPnr/eQxoEvZU=; b=O2l0+sdsFompwkdENUADW/ADDH
	2MgmM64s4K8/9vhMB8YSDx7tsQnEU6bh6q1azw+kTcSooc5Sn6IN6oWh0sYUv26OB6dPfjEyc2cEp
	Z0HFd2qOVY1jnodt1Y/SahHvwexd0qWXGYZyAWB6rqYS/6S/Hvyifo5b4MazHcgzFn5s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwW8d-0004yb-El;
	Wed, 19 Aug 2026 02:34:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wwW8O-0004yM-P4
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 02:34:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8r4VBKabDA433cmhj+qWtxabqGu1maRWF+/47QrjGC4=; b=AE6xLG00uOXaY/4enVkWaCNoUE
 J7opvwEz7b+suPmSYt99sS7KmBL0ZNfpGHX/MjQ6Lg5ANdCXi/epG2w4PBVDrsHG/0Rp1Yt1aPnq2
 97bCG9K1U5ZpOtG8dIDlK7SnAI1LPdqHrFdT+HXYgfosI+3qdydQa/v66bM+KHCI+6gw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8r4VBKabDA433cmhj+qWtxabqGu1maRWF+/47QrjGC4=; b=kz8/qXSTzGq2Lw00/4zRNpAST7
 F4sJ4SjI2jbH4cXU4TUBbhyW7pYr7MNoQFgfEOtg1CsDotoq1MvvThr732fmMnWkcNJ1/cOwiS8aK
 hjyKqlUl1WgO/GKYyC2MDwkLx1NE9Z87uPF9tCx7aqCtsDCV48hHxp2qBOYIhTVXC3pI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwW8Q-00054Q-OA for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 02:34:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A2A88413E4;
 Wed, 19 Aug 2026 02:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1881F000E9;
 Wed, 19 Aug 2026 02:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787106865;
 bh=8r4VBKabDA433cmhj+qWtxabqGu1maRWF+/47QrjGC4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=C2dOcBEkfs6Niq415YM0S8ZoQ9wwAWO2+hueXbosYxRgqd/kvcmOtHTtC8iWkb23F
 5s3bxZ2PQfYOSAvaDNKb/mxLOKmyPZggyLZceeEvGJ4sR+BO0VXIo5lttLHmfe4pGL
 tU0M0OFuLE8Jmh8w+F4GrI8AYN8TAT5Sayp+DPdkFCt6zPj4D3tT7xCIxcsxBrBLbk
 HytE2zm32kT1wAgkIw89OhWSueWadsbu8pEIUAGEnPZakxpM7K1sXeZ3sgfPAPxtH0
 8u+PGdU6qRyrOTZm031cSHHQhUqsiM99vB6wQNXIpub1Mc/Ddvy9D24UTyHKbU1EEo
 DpO0+LW/SgJXA==
Message-ID: <6b55a4e9-e4a0-421c-9bb6-98ffc2c915c9@kernel.org>
Date: Wed, 19 Aug 2026 10:34:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260818170535.3190869-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260818170535.3190869-1-daeho43@gmail.com>
X-Headers-End: 1wwW8Q-00054Q-OA
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid setting SBI_NEED_FSCK on
 transient resize failure with -EAGAIN
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/19/26 01:05, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When f2fs_resize_fs() fails due to transient lock contention or retryable
> GC failure in free_segment_range() returning -EAGAIN, no filesystem
> metadata has been modified on-disk yet. The filesystem remains completely
> consistent and clean.

Any way to make sure EAGAIN is from free_segment_range(), in case we return
EAGAIN from 1) any other places that we may miss to check now or 2) we changed
the code to return EAGAIN in future.

Thanks,

> 
> However, the current error recovery path unconditionally sets the
> SBI_NEED_FSCK flag on any error, forcing an unnecessary and time-consuming
> fsck.f2fs repair on the subsequent mount/reboot.
> 
> Fix this by guarding set_sbi_flag(sbi, SBI_NEED_FSCK) with
> `if (err != -EAGAIN)`, avoiding false-positive filesystem corruption
> flags on transient resize retries.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
> ---
>  fs/f2fs/gc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 192b16ac02f8..787133ee2eb2 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -2446,8 +2446,10 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
>  recover_out:
>  	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
>  	if (err) {
> -		set_sbi_flag(sbi, SBI_NEED_FSCK);
> -		f2fs_err(sbi, "resize_fs failed, should run fsck to repair!");
> +		if (err != -EAGAIN) {
> +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> +			f2fs_err(sbi, "resize_fs failed, should run fsck to repair!");
> +		}
>  
>  		spin_lock(&sbi->stat_lock);
>  		sbi->user_block_count += shrunk_blocks;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
