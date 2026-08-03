Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7F8C55175
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ODJKEm62tWF2csgiLdhtlAMbKV7T/9ySm19rSfPUGKw=; b=gbVxEBLMrAjHxLvb/epAEoA2Hr
	s2XvSoCgI92aHgiOR6nH/8dLca1ee/PzyN3hsV17ByVWPh94JNgwzcIe9o4cAlRIzyYjwbnaOXQ8x
	UKfwCYoWsCL3nsLcgp2aUyOZ0rexgoN3BhVx9hJuSIatYSXDuzA8B2kksRpHP0L6fBTo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqo5Z-0005pc-Ue;
	Mon, 03 Aug 2026 08:32:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqo5V-0005pP-SA
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 08:31:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DPiARhLzgbV1ijWyMAdiUKUG4TwdCKGwgqVX1k8T/ok=; b=Vr8Waw8PTNDYGRrLm4oawOWeAr
 gEw3lfZ5BVPeu3WunyByA32uOGghmuAyd6uoCO6GHRsIercIN203G+UHIC3LaP5RrBEzZft0zegu0
 T+6Dv//NC4I3tuepoc5R0aIiIquRtL0uckQraxZOWmvOyWZMkaBlCB2mOr7exPebTPm8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DPiARhLzgbV1ijWyMAdiUKUG4TwdCKGwgqVX1k8T/ok=; b=K5+cBzifBnRzpR9uqV5ijUAB9n
 /pFkMn2HYkti0QRglQAXcUPVNmlsGTRQQGmjwrjTLedZ27YtaH8PrAdSVLpz0ghUCTJJja/tg6Chw
 TbO6dW0hFnhfI1wDjA7vsFwGsrmGDpXJlIiaONXX/SoSsUHm0kppRLTzwB7oKYP/sHW4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqo5V-0000gM-0s for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 08:31:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D0835600FF;
 Mon,  3 Aug 2026 08:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F017E1F000E9;
 Mon,  3 Aug 2026 08:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785745910;
 bh=DPiARhLzgbV1ijWyMAdiUKUG4TwdCKGwgqVX1k8T/ok=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=LGexNPbBQXnSBoG4+anPlM8bf0Tc/Ja4Hec70fLlz4tQUPEFzHjp+ghTwu4Arwc4T
 9Cutu6LQhZWk4wiHBvCuLRI+eSmMSxJaeT2GHNH+8saYMAN6fkpmZhJKX1DowewjTU
 UrDSzqjGq4WjyqkkysNYfnGgis9695xfUbi2wV9Va3wwaGsb6VarcXYd+WUqq05P0J
 XfNpHDkDmlve7kEJrhhW5lyxg3AQS9+zGEd/UvroAjbNR34KfVj3BfJsSWTB9TqCKg
 khwm9TY6kefXyOCcdIEVkpnx+fh8qOcRq9V9tu97Z47GjSh17EVfPfahTAwgm1twn+
 F1sjtOvflKXJg==
Message-ID: <fbd2bbbb-4131-4cc5-ba7d-4e77b7bf8517@kernel.org>
Date: Mon, 3 Aug 2026 16:31:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260724135026.500859-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260724135026.500859-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wqo5V-0000gM-0s
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid stale FI_COMPRESS_RELEASED on
 release failure
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
Cc: stable@kernel.org, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/24/26 21:50, Wenjie Qi wrote:
> F2FS_IOC_RELEASE_COMPRESS_BLOCKS sets FI_COMPRESS_RELEASED before walking
> data nodes. If release_compress_blocks() fails before freeing any reserved
> block, the inode keeps the flag while i_compr_blocks is still non-zero.
> 
> Then F2FS_IOC_RESERVE_COMPRESS_BLOCKS returns success with zero reserved
> blocks, and regular writes keep failing with -EPERM.
> 
> Set the flag only after the ioctl succeeds, or after it has actually
> released some blocks. This preserves the existing partial-release error
> handling and leaves a failed zero-release attempt unchanged.
> 
> Fixes: ef8d563f184e ("f2fs: introduce F2FS_IOC_RELEASE_COMPRESS_BLOCKS")
> Cc: stable@kernel.org
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
> QEMU fault-injection test with FAULT_BLKADDR_VALIDITY:
> - before: release failed with -EFSCORRUPTED, reserve returned 0 blocks,
>    and pwrite kept failing with -EPERM after remount.
> - after: release still failed, reserve returned -EINVAL, and pwrite succeeded.
> - normal release/reserve still released and reserved 192 blocks.
> 
>   fs/f2fs/file.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index c54897a25981..dca1722f92b3 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3916,10 +3916,6 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
>   		goto out;
>   	}
>   
> -	set_inode_flag(inode, FI_COMPRESS_RELEASED);
> -	inode_set_ctime_current(inode);
> -	f2fs_mark_inode_dirty_sync(inode, true);
> -
>   	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
>   	filemap_invalidate_lock(inode->i_mapping);
>   
> @@ -3963,6 +3959,12 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
>   
>   	filemap_invalidate_unlock(inode->i_mapping);
>   	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> +
> +	if (ret >= 0 || released_blocks) {

We will set FI_COMPRESS_RELEASED if ret < 0 and released_blocks > 0?

Thanks,

> +		set_inode_flag(inode, FI_COMPRESS_RELEASED);
> +		inode_set_ctime_current(inode);
> +		f2fs_mark_inode_dirty_sync(inode, true);
> +	}
>   out:
>   	if (released_blocks)
>   		f2fs_update_time(sbi, REQ_TIME);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
