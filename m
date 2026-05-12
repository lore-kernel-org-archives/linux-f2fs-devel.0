Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA8FCD343F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 16:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V6k2FGmD/QABHK8jJI2NsevNDkAkCYkX1M91biYEfPU=; b=J4+g1jdBuLP03JhuDATc0Bkno5
	SBLk5xcYSUhigRz5wiSDTfAMosGn8yD5q+rcG+K/G2dBybYteTxPwfSEf6dkUi0eNf9Ku94JdQ2XA
	mV+KkHjrUaLfSG1FloLyEbbg/QoAfzj4GVjdrqJ9nu/LyoRN1lGdeUHlQZHU4EV8uOJs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMqFB-0001Xv-NQ;
	Tue, 12 May 2026 16:46:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wMqF9-0001Xp-Pz
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 16:46:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zU7gZAkNKhb92E+S2d+2ynnLov7xXLjK9tSHVkvMHEo=; b=i7GhCx2tGzZz2OjNyk8XIqrNF+
 rGXycElH58QxlKyDylpC8+NMS1+vCZsu5sDVN/hARJEtmCl8C6IGZWZFUK5zmNeK7e7Ie3e3NCu++
 7gTvNHAljnP/X0lLy/lWsUlEHCPyiEo326b0C2cwDHW2AKlFpBnWuKiVGgndD8P9wCBo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zU7gZAkNKhb92E+S2d+2ynnLov7xXLjK9tSHVkvMHEo=; b=BlgJi2T0s50AwhF79w6ho2awWs
 5XyYcr1HV4hcxdbnkpiRnvKysWL2nNnxQJvyXyWglLyizQn+IUfue9SIifpKeGloVXFrk+RQSwN5j
 a7rIqAqcaLzuOjbLhHokBmfYdQMm5tfvnhUHOFcHmdw7kAyip9/uV3FWG3jciRqFXXZI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMqF9-0007My-Jt for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 16:46:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 81E0A43CF3;
 Tue, 12 May 2026 16:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50240C2BCB0;
 Tue, 12 May 2026 16:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778604353;
 bh=AcAe4/elaHVR4qdaARIi+sqWloNOcTI2K7pOyCzPQJo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KTl8SWVyQT9eR0KJRerRA1Am+3qK8dO9BevMUKnMoH23CRP9mM5f3Wu8yquPkjamu
 iDhJafpxFURM/nRV7YIcdF2vJ6mMlLYTcDMvY4jbNiIkyUsF9ww8yELMptMTkRbEh4
 oMnRfp5DdCOcFHf+dy1yNxg//l2bSr3pQHtixqa4AlGaNF4Cxj1528N8RUtvReqe3h
 SBiA5b1rqJP4iqw7iclgX7NmxGE5ZBDhsuApEownA7rjZzSFO99rRbfwmVruqi3YO8
 sRA83twil/gSQfzUvwWP5wcTf/c5w5ehJsVY7Iboby7AQBhvuZnkU7BEEXnZxHnPWb
 xain+gAgQ2EFA==
Date: Tue, 12 May 2026 09:45:52 -0700
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260512164552.GH9555@frogsfrogsfrogs>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-8-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260512053625.2950900-8-hch@lst.de>
X-Headers-End: 1wMqF9-0007My-Jt
Subject: Re: [f2fs-dev] [PATCH 07/12] swap,
 block: limit swap file size to device size
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
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>,
 linux-mm@kvack.org, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 Namjae Jeon <linkinjeon@kernel.org>, Chris Li <chrisl@kernel.org>,
 linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>, Kairui Song <kasong@tencent.com>,
 Theodore Ts'o <tytso@mit.edu>, linux-cifs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>,
 linux-btrfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, May 12, 2026 at 07:35:23AM +0200, Christoph Hellwig wrote:
> Don't blindly pass the value from the swap header to swap_add_extent,
> but instead the device size rounded down to page granularity.  This
> activated the sanity checking in the core code that catches a too large
> value in the swap header.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/fops.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 453141801684..067e46299666 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -951,7 +951,9 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
>  
>  static int blkdev_swap_activate(struct file *file, struct swap_info_struct *sis)
>  {
> -	return add_swap_extent(sis, sis->max, 0);
> +	loff_t isize = i_size_read(bdev_file_inode(file));

Good catch!

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +
> +	return add_swap_extent(sis, div_u64(isize, PAGE_SIZE), 0);
>  }
>  
>  const struct file_operations def_blk_fops = {
> -- 
> 2.53.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
