Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1E3C982FA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 07:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SbmgHpPu1trNV39N5WfdzL09UnnhhsBrIMIPUsRsJ4w=; b=RHjpch9t/8Le+xoU/sS6r1lLNF
	QLuFsggKmAL/X0Cq+AgvsFiILt2dDPnkUjY3D47Q3PrSsrLL/mfRDHluDjRZdL1+yGgqmSzw3h+W1
	pphh+u96YFrmEJb8cZzW456Lz2Ve+jy+0sPQ4wP/00WHqfFg9Flp7k4yOfKhEBBY9wrA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8uls-0000Dz-4i;
	Tue, 22 Sep 2026 07:18:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+a4e1fe537d2c1e8d4400+8430+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1x8ulj-0000Dn-OP for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 07:18:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pe/ERqmYRi2QAlziIp0yfm8w1MPUF8QGYr12U1BWtJk=; b=PGw9nF2lNbXotr8yhA3sUIQx1+
 0+ZGmEQe58jcDH/h50CChvr9Z0lfIn8Ta67cF/Gwg31vCN8LGF7lluMC9adtRAsOR4vjnaQ/7PyOE
 GbC7IQllrcHe+kMzOBy35k+w5fqkP5yWoxkrLhHdCbnzAcyAbI99q7P4KysxVmdOijso=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Pe/ERqmYRi2QAlziIp0yfm8w1MPUF8QGYr12U1BWtJk=; b=h9sLH7MKJmPQ9PRvEeAHSHeM16
 yTfoq8BVUsfIm4CqWsnt5xTg7CR0mogb9OmluVbkT/URQMhBgKVwLnPJQOruioPKbaeOzhc9OfvrT
 lpqSVG+EjGRGDfbdmHW4AM7yKxxC90BR7KMyJGhLw1Vjywcf+p8Wv8cfFRaYkGljpkPY=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8ulf-0003Nz-Oj for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 07:18:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Pe/ERqmYRi2QAlziIp0yfm8w1MPUF8QGYr12U1BWtJk=; b=uGSDq1YqsMBNpr8mYK6BJAwp09
 KNTopK36KF1cx0X6vGoaatzYejBcY7nLZZMdRzy2+5cOnbGcIqwcF+gYVh/M8nF/Yu6Rv5TeuMnIj
 JKahf/LdpIJX04/FoHv5rkHUIwjIfHUxntMODRmLeFfe0wM+EURKa/pzAyTvfjQHX6oSFwoyhVib9
 Z3YJbp42BUUPBT2xEtw9qzeCmh0+3bJQE46BXRUVooFLh+SWia5F2fpxSHmALbcscQgSYwLh5BL7w
 M4uDgGA1q2YnhRtk37iF4goUVqMAZQFtOg4xdFBu9bu8EnjoxSEAIfDmHMZhnzGpQtYUv/mzdH90z
 PKudH8jA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1x8ula-00000004UAE-2QP2;
 Tue, 22 Sep 2026 07:18:14 +0000
Date: Tue, 22 Sep 2026 00:18:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <arIrtgZ3-9zNuru_@infradead.org>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-13-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260918111539.1003439-13-aalbersh@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1x8ulf-0003Nz-Oj
Subject: Re: [f2fs-dev] [PATCH v16 12/21] xfs: use read ioend for fsverity
 data verification
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, djwong@kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Sep 18, 2026 at 01:15:24PM +0200, Andrey Albershteyn wrote:
> +	if (IS_ENABLED(CONFIG_FS_VERITY) && !error && ioend->io_vi &&
> +			xfs_fsverity_is_file_data(ip, ioend->io_offset)) {
> +		if (ioend->io_flags & IOMAP_IOEND_INTEGRITY) {
> +			fsv_ioend = kmem_cache_zalloc(xfs_fsverity_ioend_cache,
> +					GFP_KERNEL);
> +			if (!fsv_ioend) {

This needs a mempool to be deadlock safe.

> +				iomap_finish_ioends(ioend, -ENOMEM);
> +				return;
> +			}
> +			fsv_ioend->ioend = ioend;
> +			INIT_WORK(&fsv_ioend->work, xfs_end_fsverity_io_read);
> +
> +			fsverity_enqueue_verify_work(&fsv_ioend->work);
> +			return;
> +		}
> +
> +		fsverity_verify_bio(ioend->io_vi, &ioend->io_bio);
> +		error = blk_status_to_errno(ioend->io_bio.bi_status);

And I think you always need to do the offload because fsverity can
synchronously read metadata.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
