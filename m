Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7007AC44501
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2026 15:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mPh+DFoenHsFIvcdQKyvZlswHWOX0HBtMWUULwszOlI=; b=mahmT565vuDf71L0r0/vfT2U/C
	/LJGl7P06Erj/zwFvBxNcgPlKXivpigD4VnvO8ccx4mYu4rYIwJzQ3LY/UnjQ+/wcVOKwaPuy2Yir
	CDD/0VEBzqWYtLaqWi2KL0wSBf/QKCbc4gmIlfkRWYZ/lRxqozeshyUigeaVapJ6ZkZk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wiD3s-0000rv-Ak;
	Fri, 10 Jul 2026 15:22:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kbusch@kernel.org>) id 1wiD3r-0000ro-DH
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 15:22:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BZBmbz6+BQI2Kzh1iUDOvyORAvj/yICrOCZDo+Rp0kw=; b=IL9uTMUqhibIT3/kamhQhHc9bu
 J2b+FQKqqL534/aeRAZHSdTMGja0rVaqXmnR2QfJzjlfQv3H8Cby5taIbBEWXy6AzToUmfJxrkbkg
 6rN39IZYXDrUGSnbdyTgy5OpEZhh2/ChK9/omD9T2Epg8RYPrTNgy/XrS396fjCj1Wa4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BZBmbz6+BQI2Kzh1iUDOvyORAvj/yICrOCZDo+Rp0kw=; b=DYBil2bzgRkxLxnGT0rA0EXYKb
 Nslm20purA1e9vdOsRElLvfZ4QftWOWDlIUPpUM1rtayyjFojSC/mwDZoZzqfYJTOuyfv4f+6iKpK
 Dg+QOUbdEQEJ2zwpEmEO2dc5ZPVUab1Hdzqph8MTl3aXXMdXn0IryxwiBYJrwGsFwA78=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wiD3r-0005xM-NM for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 15:22:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D92A407E9;
 Fri, 10 Jul 2026 15:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83291F000E9;
 Fri, 10 Jul 2026 15:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783696953;
 bh=BZBmbz6+BQI2Kzh1iUDOvyORAvj/yICrOCZDo+Rp0kw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UClDCNbCQfNVRQhm1i8d0xb29cuN0tYD1gSYn7nGQxcwS7UY+Fj+hD+7dJGoKu6Zg
 5dYucbOrXi+v7T24cB56Kj8GAb1o3zBc9NpvUvN5qN3+YfFzwGuu96lk54Lzoit87D
 P/hGUwB9WQjR82lZLQWwQitL+/Bv5Y8BZH6R/S5wyEVMfzdFEcixq45ps9RC5QDPjc
 iSoPzj/1r4B8qaXm++3azwoC4Yb8dd/t/FKEfXkTGZYSqWjTHmfxIksx4hz8WTp+TP
 xjssz+2VAgXF7xqPMcYBg54aH6eutuE3PC4QXMK3tooi3O/AVmgdjEBLUn+HPAXBxF
 9d+WnwGLCmO8A==
Date: Fri, 10 Jul 2026 09:22:31 -0600
To: Christoph Hellwig <hch@lst.de>
Message-ID: <alEON9EQ3BAX_D35@kbusch-mbp>
References: <20260708011843.1036846-1-kbusch@meta.com>
 <20260709071352.GA20180@lst.de> <ak-mQqt-a-jy6ZoV@kbusch-mbp>
 <20260710043519.GA6205@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260710043519.GA6205@lst.de>
X-Headers-End: 1wiD3r-0005xM-NM
Subject: Re: [f2fs-dev] [PATCH] fs: report direct io constraints through
 file_getattr
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
From: Keith Busch via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, linux-xfs@vger.kernel.org, brauner@kernel.org,
 jack@suse.cz, Keith Busch <kbusch@meta.com>, cem@kernel.org,
 aalbersh@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, tytso@mit.edu, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jul 10, 2026 at 06:35:19AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 09, 2026 at 07:46:42AM -0600, Keith Busch wrote:
> > On Thu, Jul 09, 2026 at 09:13:52AM +0200, Christoph Hellwig wrote:
> > > On Tue, Jul 07, 2026 at 06:18:43PM -0700, Keith Busch wrote:
> > > 
> > > > +	fa->fsx_dio_mem_align = bdev_dma_alignment(bdev) + 1;
> > > > +	fa->fsx_dio_offset_align = bdev_logical_block_size(bdev);
> > > > +	fa->fsx_dio_read_offset_align = bdev_logical_block_size(bdev);
> > > > +	fa->fsx_dio_virt_boundary_align = bdev_virt_boundary_alignment(bdev);
> > > > +	fa->fsx_max_segments = bdev_max_segments(bdev);
> > > 
> > > How is the max_segments value defined in a way that is meaningful to
> > > userspace?
> > 
> > It tells you how many sub-sector vectors you can submit in your
> > readv/writev before it needs to add up to a logical block size.
> > 
> > Ex: 4k logical block size, 4 byte DMA, 256 max segments. You can define
> > 4-byte iov's in your command, but you'll hit the max segment count
> > before you have a valid IO if they're all that small.
> 
> Ah, makes sense.  But besides the missing documentation I think
> max_segments is a bit of a misleading name for that.
> 
> Something like max_vecs_per_block (although we don't expose blocks
> in the UAPI) or max_vecs_per_granularity (I think grammar wants a word
> with me for that, though...) might be a bit more suitable.

The granularity it has to add up to is defined by the
fsx_dio_offset_align attribute. This is a bit long, but to make that
relationship clear, how about:

  fsx_dio_max_vecs_per_offset_align


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
