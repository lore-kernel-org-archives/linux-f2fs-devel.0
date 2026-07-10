Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C63C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2026 04:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GXtz+pfrB2ub+K3Eel0LVgGsqWdk8Znd5O/MIdwTw74=; b=INnc305utPtGde7WIfqqEESsu9
	sksGerUVaRw4zof4twK42WtB7Ue30m4c1Q16sbHB8Djyps/54Wu2QBxXC6b8NHO/6J+Eu54H6u6P1
	crrY4b87x7ry3drLfM7fiBw95h5H51c0j6RVAIZP1LLpU8h2nXBJ+YMy6489onY7bjis=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wi2xU-00088l-Kr;
	Fri, 10 Jul 2026 04:35:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wi2xT-00088Y-HM
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 04:35:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fY5PWMggrMPn2+fm3k6S1HRDCaH2tGrS2t4uIe0DxHQ=; b=JsKo6JmGJUf7KRFzQxD0TXZEd6
 u2pk0DvxUImXCYF7t76H/91lJA5NQlvKuZPETJ/UBYEvpRyj+LWTCNScQ4XX/VcVitAgN0cVkPbLR
 2PCecHUtLh/CySz4auZ5hX3NwjXGZD9owyQILE1I5hnXVvMqg4mE+q9lskMpqPxANSS4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fY5PWMggrMPn2+fm3k6S1HRDCaH2tGrS2t4uIe0DxHQ=; b=R1a4MQa7HkGbQJ8drk8d+Sk+Hv
 KVAKK17auagjKFxCVdJjGXeXT+opNyOceytEk1Gm55zkMUpcFP5cXhWQ7io1P6LieEEnV5BxYW7eA
 s/sePowKlvFgYORbISRjrSlo0C4uKc9U2hw40DU3UNUeV8mCq1DQFvLGT4LkqVDkumWQ=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wi2xT-0005xR-Ja for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 04:35:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B66A068B05; Fri, 10 Jul 2026 06:35:19 +0200 (CEST)
Date: Fri, 10 Jul 2026 06:35:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Message-ID: <20260710043519.GA6205@lst.de>
References: <20260708011843.1036846-1-kbusch@meta.com>
 <20260709071352.GA20180@lst.de> <ak-mQqt-a-jy6ZoV@kbusch-mbp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ak-mQqt-a-jy6ZoV@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wi2xT-0005xR-Ja
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
Cc: axboe@kernel.dk, linux-xfs@vger.kernel.org, brauner@kernel.org,
 jack@suse.cz, Keith Busch <kbusch@meta.com>, cem@kernel.org,
 aalbersh@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, tytso@mit.edu, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jul 09, 2026 at 07:46:42AM -0600, Keith Busch wrote:
> On Thu, Jul 09, 2026 at 09:13:52AM +0200, Christoph Hellwig wrote:
> > On Tue, Jul 07, 2026 at 06:18:43PM -0700, Keith Busch wrote:
> > 
> > > +	fa->fsx_dio_mem_align = bdev_dma_alignment(bdev) + 1;
> > > +	fa->fsx_dio_offset_align = bdev_logical_block_size(bdev);
> > > +	fa->fsx_dio_read_offset_align = bdev_logical_block_size(bdev);
> > > +	fa->fsx_dio_virt_boundary_align = bdev_virt_boundary_alignment(bdev);
> > > +	fa->fsx_max_segments = bdev_max_segments(bdev);
> > 
> > How is the max_segments value defined in a way that is meaningful to
> > userspace?
> 
> It tells you how many sub-sector vectors you can submit in your
> readv/writev before it needs to add up to a logical block size.
> 
> Ex: 4k logical block size, 4 byte DMA, 256 max segments. You can define
> 4-byte iov's in your command, but you'll hit the max segment count
> before you have a valid IO if they're all that small.

Ah, makes sense.  But besides the missing documentation I think
max_segments is a bit of a misleading name for that.

Something like max_vecs_per_block (although we don't expose blocks
in the UAPI) or max_vecs_per_granularity (I think grammar wants a word
with me for that, though...) might be a bit more suitable.

> > > @@ -145,6 +155,8 @@ static int file_attr_to_fileattr(const struct file_attr *fattr,
> > >  
> > >  	if (fattr->fa_xflags & ~mask)
> > >  		return -EINVAL;
> > > +	if (fattr->fa_pad)
> > > +		return -EINVAL;
> > 
> > How is this related?
> 
> I had to add a padding field to the struct to account for the implicit
> hole in 64-bit and to ensure the struct is the same size for 32-bit.
> It's a reserved field, so we have to ensure the current kernel doesn't
> support any value here in case we define this field for something else
> in the future.

Ah, right.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
