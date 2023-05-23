Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BCEC7EE26
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 May 2023 23:36:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q1bY0-0001iX-8J;
	Tue, 23 May 2023 23:36:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <david@fromorbit.com>) id 1q1bXy-0001iR-HE
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 May 2023 23:36:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o+Mu9QUDJUPxCQ+nxaGfODHItInO1Mx21+1cY8P0+ko=; b=YEL/8ojeQXqlWARCpcHYMtBxfy
 hsAElsfTkHq5+cGtL8KyzReBq9PWEdZoHKPNK/LzeVKEesEZ4wkeTFmRbtGiR0/goZO1bL5SAFbhg
 SDMXLkyF3LUE9USQlafxGaLGGkGDf7/X5xgrwScgwENmcuJyJfHcQaH4iua8OwYeA2SA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o+Mu9QUDJUPxCQ+nxaGfODHItInO1Mx21+1cY8P0+ko=; b=Z8FJEOBbkYpsjx+pIsNgCr31PS
 oV3a4qNGrbBUB/Dh19U6GgGq8ym2/UUELIhd78mVLBS1aoGTa0vQLGTxGNBH8HsM+ZmVQxOjd9XcN
 pqzVg0J+vXtptAhDe5qmRb7LtNeu00uKy07FFfBbU4/qiq6DsaZmDsHAhjkRrQHGNQJ4=;
Received: from mail-vk1-f177.google.com ([209.85.221.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1q1bXv-0002JM-3t for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 May 2023 23:36:06 +0000
Received: by mail-vk1-f177.google.com with SMTP id
 71dfb90a1353d-456ea0974bcso327427e0c.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 23 May 2023 16:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1684884957; x=1687476957;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o+Mu9QUDJUPxCQ+nxaGfODHItInO1Mx21+1cY8P0+ko=;
 b=bqz5XeJw8P8TTIb1Bxnv9oa1Nz9T6alk6hU2GterKgZ5JJQM1UjDHYsrrOZb1lrdaA
 CC4EG0j3+qb8lgbCj1XCa4AGY7IuWkO2XdjybVejInBQLPWA1JrOTrczAZH2Ik4KPc4Y
 /Jo5KUZWR+Y1HR/I5gpFVbONxQKmrwXgifHqZDYNDBRy+9go+fF1hYUVdy5rIJAdZpBX
 hvsp42AICsjvNRZkL2uy2KeOggalH5Jjz/DCDLMWyXmAZWBVlPHiViJjftr44Kypd3NR
 SAAmefRPyd/6c/Kfb5k3ThovNDlJyZGrwotJ+VZBCUuz79Zcegte9eHf1j0/FvHuAxhB
 1uQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684884957; x=1687476957;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+Mu9QUDJUPxCQ+nxaGfODHItInO1Mx21+1cY8P0+ko=;
 b=IzX0oklIGLeYaeziXId38xBW5DkWiyl92J2SxmCeicY5dwkcLLa5QwnziRFdK07WgC
 yeK1ntM4nsnnC7wK4c6EJ1VaP08nrry5cdOGHXGAUZiW/8UfqzKViDFigSICgsKlUD7P
 aBHIS5i+Lu0teyBtZJgHZvSR4P3kbrA/dFMBbDaUFb4Db5BU1JwPUnfPawZvptdE28vf
 GvasPN7r+OO/3wmwrg+5u1KWy2ZbEbCovHOP6dhZGrsN95Yn5xWW7+YbWR4lSM+Y/kZ1
 APL5wSHSFmJwSqSal7FzLrmpVOkxYr6E/ruNeCm7x8JTEKF2D6GOoR8SE/dkT1KK+xG6
 k/DQ==
X-Gm-Message-State: AC+VfDz7aNbVba/uMdkNBfA2e3MOjDMDCVnm2ijPg0Wib2Wz/Lq16IGx
 yk3GK6TiM6vdebMMgeBNCw9CiKSAzvlXyLH+cqg=
X-Google-Smtp-Source: ACHHUZ5+wDLkzWl5hqADeJv/K/pEdU5ftVoYvaXjN5yUsSSnEKzwjNvqAoa0WrZdkbq9aiPARCtcUw==
X-Received: by 2002:a05:6a20:3c8d:b0:10c:d5dd:c223 with SMTP id
 b13-20020a056a203c8d00b0010cd5ddc223mr1532145pzj.15.1684880837655; 
 Tue, 23 May 2023 15:27:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au.
 [49.179.0.188]) by smtp.gmail.com with ESMTPSA id
 d11-20020a63fd0b000000b005308b255502sm6443395pgh.68.2023.05.23.15.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 15:27:16 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
 (envelope-from <david@fromorbit.com>) id 1q1aTJ-0036Bu-2Z;
 Wed, 24 May 2023 08:27:13 +1000
Date: Wed, 24 May 2023 08:27:13 +1000
To: Hannes Reinecke <hare@suse.de>
Message-ID: <ZG09wR4WOI8zDxJK@dread.disaster.area>
References: <20230424054926.26927-1-hch@lst.de>
 <20230424054926.26927-17-hch@lst.de>
 <b96b397e-2f5e-7910-3bb3-7405d0e293a7@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b96b397e-2f5e-7910-3bb3-7405d0e293a7@suse.de>
X-Headers-End: 1q1bXv-0002JM-3t
Subject: Re: [f2fs-dev] [PATCH 16/17] block: use iomap for writes to block
 devices
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
From: Dave Chinner via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Dave Chinner <david@fromorbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nfs@vger.kernel.org, cluster-devel@redhat.com, linux-xfs@vger.kernel.org,
 Miklos Szeredi <miklos@szeredi.hu>, "Darrick J. Wong" <djwong@kernel.org>,
 ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, May 19, 2023 at 04:22:01PM +0200, Hannes Reinecke wrote:
> On 4/24/23 07:49, Christoph Hellwig wrote:
> > Use iomap in buffer_head compat mode to write to block devices.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >   block/Kconfig |  1 +
> >   block/fops.c  | 33 +++++++++++++++++++++++++++++----
> >   2 files changed, 30 insertions(+), 4 deletions(-)
> > 
> > diff --git a/block/Kconfig b/block/Kconfig
> > index 941b2dca70db73..672b08f0096ab4 100644
> > --- a/block/Kconfig
> > +++ b/block/Kconfig
> > @@ -5,6 +5,7 @@
> >   menuconfig BLOCK
> >          bool "Enable the block layer" if EXPERT
> >          default y
> > +       select IOMAP
> >          select SBITMAP
> >          help
> >   	 Provide block layer support for the kernel.
> > diff --git a/block/fops.c b/block/fops.c
> > index 318247832a7bcf..7910636f8df33b 100644
> > --- a/block/fops.c
> > +++ b/block/fops.c
> > @@ -15,6 +15,7 @@
> >   #include <linux/falloc.h>
> >   #include <linux/suspend.h>
> >   #include <linux/fs.h>
> > +#include <linux/iomap.h>
> >   #include <linux/module.h>
> >   #include "blk.h"
> > @@ -386,6 +387,27 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
> >   	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
> >   }
> > +static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> > +		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> > +{
> > +	struct block_device *bdev = I_BDEV(inode);
> > +	loff_t isize = i_size_read(inode);
> > +
> > +	iomap->bdev = bdev;
> > +	iomap->offset = ALIGN_DOWN(offset, bdev_logical_block_size(bdev));
> > +	if (WARN_ON_ONCE(iomap->offset >= isize))
> > +		return -EIO;
> 
> I'm hitting this during booting:
> [    5.016324]  <TASK>
> [    5.030256]  iomap_iter+0x11a/0x350
> [    5.030264]  iomap_readahead+0x1eb/0x2c0
> [    5.030272]  read_pages+0x5d/0x220
> [    5.030279]  page_cache_ra_unbounded+0x131/0x180
> [    5.030284]  filemap_get_pages+0xff/0x5a0

Why is filemap_get_pages() using unbounded readahead? Surely
readahead should be limited to reading within EOF....

> [    5.030292]  filemap_read+0xca/0x320
> [    5.030296]  ? aa_file_perm+0x126/0x500
> [    5.040216]  ? touch_atime+0xc8/0x150
> [    5.040224]  blkdev_read_iter+0xb0/0x150
> [    5.040228]  vfs_read+0x226/0x2d0
> [    5.040234]  ksys_read+0xa5/0xe0
> [    5.040238]  do_syscall_64+0x5b/0x80
> 
> Maybe we should consider this patch:
> 
> diff --git a/block/fops.c b/block/fops.c
> index 524b8a828aad..d202fb663f25 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -386,10 +386,13 @@ static int blkdev_iomap_begin(struct inode *inode,
> loff_t offset, loff_t length,
> 
>         iomap->bdev = bdev;
>         iomap->offset = ALIGN_DOWN(offset, bdev_logical_block_size(bdev));
> -       if (WARN_ON_ONCE(iomap->offset >= isize))
> -               return -EIO;
> -       iomap->type = IOMAP_MAPPED;
> -       iomap->addr = iomap->offset;
> +       if (WARN_ON_ONCE(iomap->offset >= isize)) {
> +               iomap->type = IOMAP_HOLE;
> +               iomap->addr = IOMAP_NULL_ADDR;
> +       } else {
> +               iomap->type = IOMAP_MAPPED;
> +               iomap->addr = iomap->offset;
> +       }

I think Christoph's code is correct. IMO, any attempt to read beyond
the end of the device should throw out a warning and return an
error, not silently return zeros.

If readahead is trying to read beyond the end of the device, then it
really seems to me like the problem here is readahead, not the iomap
code detecting the OOB read request....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
