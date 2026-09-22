Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9004C982FA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 07:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DBzXDo1EfIhKrM1eLsOAmmBL81JGAdO41N4xELTujdc=; b=m1Zy9oKEgpWQ2UYJxA3pHkwT2e
	a9oqfOG4XfknG1yf74N45mV1Sz1wVKighW6ZjchjTYxpeG9MoSEOwHXT35qAj5oUb+jedyZlb9NWK
	niiCwQ1m4+NyXHyWD8JRkJs34C0E9HgSX0ZUkHi9LlDV7bM8xCYoYGiw7GM55IHtQgSo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8unR-0007Bu-MA;
	Tue, 22 Sep 2026 07:20:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+a4e1fe537d2c1e8d4400+8430+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1x8unQ-0007Bh-17 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 07:20:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yQ8oqV+zlgKMQEWLXG1XYm7bo7EGuxG7SQtxvJVwPKc=; b=eMWhz39+AniwzIdw2Xi9wk/z2w
 HSQYvJmb/QTlSyFyiFhZOGVIucuiYHGk8jyIcVCJTvMKoiUUrNDkVCnNjzJjS9fgKQBbiYGc7uVDM
 V0OumaQv6FWDHculc5DecCW3DMDE/tlEaqb8t+ko8XJtkXutZT6hHGHtu1hEfMqIcVPQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yQ8oqV+zlgKMQEWLXG1XYm7bo7EGuxG7SQtxvJVwPKc=; b=RPpg/XzWcc9WUCxSEm8IGYfZdR
 KD0lt55EXIyK6wDPPW4wC0MvTEQwu9S2JK0fvQNUh+RboNjrkR87+04RVBjo2Dr4cQ8qy6Up+Yx1w
 I19pUx16xrfwjNQ5B+N5seuGslg9C0GpTXq/n7fMkFX3Og+c+rwmzvA/jCfbnojNSiIk=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8unP-0003QP-SK for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 07:20:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=yQ8oqV+zlgKMQEWLXG1XYm7bo7EGuxG7SQtxvJVwPKc=; b=GxiJCKr7C4bne9OfpP4kXFeMSZ
 inl1e1zaG0FpExyWIYbx+brAqIJfAKSYxn/Ir8m5qGEnp/7vvsNp0u9dWozoCIrnQTSYUpoeBmKL5
 yb9NP/nxDVnuMsj2X8bmrSA71aGeDiSH5tkh4UTTi69CHkSa4k+cw4J3BCuzDt8ItSqx58UxTNyxl
 PXpArosE9haK5cSQaWxxJjwGNhpQy7udgZ400gBwV4vcgauAtQthw4kvSti/30SOp3PgLVFtnE8Ej
 oqDTEJ0c8VLnq7Qg1KskUW3A6NArtFsaXzT2teeXyQ6DqgCWiiGYDZ3oSOdSG52QOZXB+Bd+MBjTq
 oAHXAjsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1x8unK-00000004UMT-2BLP;
 Tue, 22 Sep 2026 07:20:02 +0000
Date: Tue, 22 Sep 2026 00:20:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <arIsIhrWltHi9Aej@infradead.org>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-14-aalbersh@kernel.org>
 <20260922043402.GM2705364@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260922043402.GM2705364@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1x8unP-0003QP-SK
Subject: Re: [f2fs-dev] [PATCH v16 13/21] xfs: add XFS_BMAPI_UNWRITTEN to
 unmap unwritten extents in __xfs_bunmapi()
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Sep 21, 2026 at 09:34:02PM -0700, Darrick J. Wong wrote:
> > diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> > index cc48f6e20e80..7ba76017ae56 100644
> > --- a/fs/xfs/libxfs/xfs_bmap.c
> > +++ b/fs/xfs/libxfs/xfs_bmap.c
> > @@ -5280,6 +5280,10 @@ __xfs_bunmapi(
> >  		if (del.br_startoff + del.br_blockcount > end + 1)
> >  			del.br_blockcount = end + 1 - del.br_startoff;
> >  
> > +		if ((flags & XFS_BMAPI_UNWRITTEN) &&
> > +				del.br_state != XFS_EXT_UNWRITTEN)
> 
> Odd indentation?
> 
> 		if ((flags & XFS_BMAPI_UNWRITTEN) &&
> 		    del.br_state != XFS_EXT_UNWRITTEN)

Yeah.

> /me again wonders if bunmapi ought to have its own flags instaed of
> reusing *some* of bmapi.  But I concede that ought to be a different
> cleanup, because figuring out which flags are for bunmapi.  I think it's
> REMAP, ATTR_FORK, NODISCARD, and UNWRITTEN?

I think that would create more confusion than it helps.  OTOH asserting
the valid flag would be helful.

Sashiko complains about interactions with the weird rtextent bunmap
behavior.  Should we disallow fsverity with a larger than fsb
rtextensive to not bother with this?  Btw, did you test this series
with RT classic and or zoned?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
