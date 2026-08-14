Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134DEC5CFC1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K/Nq5wqD9Ein7jIgj6grhNWW4Lr1QYT/p2Ma8FjgMN8=; b=AKL75spF4xXLzcjHytAnh7O8zW
	jkRFWBKunYnJ0Qx4uTI7wN/aVtbPs3e8M2Z9AaNa0/DIjgdwDjBYTApJFRTb8rSgGzqJGIN2VFlDl
	lC/JWimgZjDqW4+i24P7VFa20Vy5rwrUYf9lup6CFW88DXgk8bW6duxUkZ5/C6K9ct+o=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wutbw-0000Ym-41;
	Fri, 14 Aug 2026 15:14:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wutbV-0000YE-Ah
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 15:13:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/KgPiqew/xPu1U7F+Angxp7pjTC09MZg7T4BSyNrCSI=; b=MAei4+fbigkLf4Xk5h1YqVME1r
 CaqLQaS+3G0vg0x+SaUB7PZc9UD2JItCCKGcbH9fPLDUQfJM7UXIqoeN13MNaooVUzAJfuKaARMnH
 k4+CmVmDt9GvLKMd+hHlzoJMWSJxFJbe603EVmYbN7Q7fnxGulrjEeAHEUxYXMWLP2ZI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/KgPiqew/xPu1U7F+Angxp7pjTC09MZg7T4BSyNrCSI=; b=VDHwk/MajVfCI5g9WF6/UiwKA7
 jj4O/+6rkR8Pj3Hg/wU7irpTHd//Wxs0tED0C9v/z/Jthd2Xusr5kqNJak3ATcXWrCvyq/hA4D9uR
 x5BX+XGg9bjzvk9lG5LTupCwcVYeBtgf8Cvj6tGo548cnFgktjgfkTl01KTbettrFSew=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wutbY-000555-2T for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 15:13:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with UTF8SMTP id B27E260120;
 Fri, 14 Aug 2026 15:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5A5701F00A3D;
 Fri, 14 Aug 2026 15:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786720426;
 bh=/KgPiqew/xPu1U7F+Angxp7pjTC09MZg7T4BSyNrCSI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HUMYZfClAIgTKe5Kt88p0xj6wI82y+f7yTwwOfpIWVsa+jQ8KPZZtwWbnBwjPYfQh
 EmoIC5bhNxmpvsSuK7M5ZhbnfnT8xRLXe7Wn32dtpOoNGMi7aKHYmHImNc1/RCvaxU
 mw9bNEAHIYjlmCesaLrXSAdY4oWlgfMTk/Kh31/G/Jcj2e8KLW1DYOz8aI0ryId/Ny
 1Dk7dT9cw/d1E01tBWqRxTTsKDruu3wXbzu/Al0tpGQ0uRWdC6z4lEg+z45dTTSHj2
 0YbNgBDrxF8pzhd5QpFNJrfv+8Nd8x48SGZaMN3OMUNNEG6DIa8jqHa5EWFtHHxZx+
 U87rPOuPqinxQ==
Date: Fri, 14 Aug 2026 08:13:45 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260814151345.GF3556460@frogsfrogsfrogs>
References: <20260814092448.1818082-1-aalbersh@kernel.org>
 <20260814092448.1818082-16-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260814092448.1818082-16-aalbersh@kernel.org>
X-Headers-End: 1wutbY-000555-2T
Subject: Re: [f2fs-dev] [PATCH v15 15/25] xfs: don't report dio_mem_align
 and dio_offset_align for fsverity files
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, fsverity@lists.linux.dev,
 linux-ext4@vger.kernel.org, Carlos Maiolino <cem@kernel.org>,
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Tal Zussman <tz2294@columbia.edu>, linux-xfs@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Aug 14, 2026 at 11:24:32AM +0200, Andrey Albershteyn wrote:
> Sashiko.dev reported that while fsverity files falls back to the
> buffered IO for Direct I/O, they should not report non-zero values in
> dio_mem_align and dio_offset_align, meaning it's not supported.
> 
> The STATX_DIOALIGN | STATX_DIO_READ_ALIGN flags are used to explicitly
> report if DIO is supported or not. They can not indicate that fallback
> to the buffered IO is used in this case. The zero alignment values also
> mean that DIO is not supported on this file, see statx(2).
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> Acked-by: Eric Biggers <ebiggers@kernel.org>

This is consistent with what I saw in the manpage, so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iops.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 55667cc762f8..70637cdcc299 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -35,6 +35,7 @@
>  #include <linux/security.h>
>  #include <linux/iversion.h>
>  #include <linux/fiemap.h>
> +#include <linux/fsverity.h>
>  
>  /*
>   * Directories have different lock order w.r.t. mmap_lock compared to regular
> @@ -580,6 +581,10 @@ xfs_report_dioalign(
>  	struct block_device	*bdev = target->bt_bdev;
>  
>  	stat->result_mask |= STATX_DIOALIGN | STATX_DIO_READ_ALIGN;
> +
> +	if (fsverity_active(VFS_I(ip)))
> +		return;
> +
>  	stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
>  
>  	/*
> -- 
> 2.54.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
