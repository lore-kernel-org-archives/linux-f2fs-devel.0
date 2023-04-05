Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5538BC77B7F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Apr 2023 15:06:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pk4ib-0000M7-CJ;
	Wed, 05 Apr 2023 15:06:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1pk4ia-0000M0-4r
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 15:06:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8TW4zWFYwr/04tnxh6yiM60594MaxgbDYPp7QcjoihU=; b=Qn/x1CYcdzUCqV+aCw4M8Nxrla
 ayjm3QAzXVhrMzq5ItecWFtthY21h6oeLPXclNwjqv6GZyl2oKFIz/iCzU6BbMbMxYdW/Iyuv5MWB
 HILJGKaJIKyhLpTQ99cg1yOOrVJXnNPav41Zklzg6msvK7N/PPFIZNpfzniDuHEGiKcU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8TW4zWFYwr/04tnxh6yiM60594MaxgbDYPp7QcjoihU=; b=lStNDozhOdl2rHutuT2RQkfaSW
 Xqs67MxxDZ7sciPxtZJIWkLymjLi8qShFgBZ5DKPwDD5Ed4Nmpr3vN9SWc8M7Q5oJAYdbGqn5Kp0U
 noWd2KIHdI3GtabDmjXJtEZAb5Ho0ZdH9Ep6oJn7hccKZBspi+AN4miFrmkOE8AQPO4Q=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pk4iX-00G5V2-IZ for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 15:06:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2EFCB63E94;
 Wed,  5 Apr 2023 15:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90FCC4339E;
 Wed,  5 Apr 2023 15:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680707188;
 bh=mlni390c+gmIDMlX2RnZzsHsCPBkb+xutjeyTZL88LA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z0Y5O+66tWXrhcV6ndCx07PGooMOJap5OIdpqEdvYFYnMHN0z5WiLYrWuKcSeaXHl
 UcZpAG3fUrlrKjP5/sAagW6AWG69d+rXgg1WBgDW+rC9NaJekXCvMerJzsJkjRnsXH
 m4Q6uAO39XKLOFgPn03RBth+eXeK/rY/VE0Yu1qLMe93Au/pMBUkCWq3xQz6voM133
 knKAwxEb9wOgh0gF0jn6wi8T39XIQ/aCS62UgeWnfbPOpTkjgiMeytHY928u5OUjWN
 J9dEljNMTn2fktd2Sp1o8GdjUkAWHM/TRVCjrukbVy3Hv8BEKS4poWg1XrW7ftU4DI
 o6Z6xJuTGto9g==
Date: Wed, 5 Apr 2023 08:06:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Message-ID: <20230405150627.GC303486@frogsfrogsfrogs>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-10-aalbersh@redhat.com>
 <ZCxEHkWayQyGqnxL@infradead.org>
 <20230405110116.ia5wv3qxbnpdciui@aalbersh.remote.csb>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230405110116.ia5wv3qxbnpdciui@aalbersh.remote.csb>
X-Headers-End: 1pk4iX-00G5V2-IZ
Subject: Re: [f2fs-dev] [PATCH v2 09/23] iomap: allow filesystem to
 implement read path verification
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, linux-ext4@vger.kernel.org,
 agruenba@redhat.com, damien.lemoal@opensource.wdc.com,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com,
 xiang@kernel.org, jth@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Apr 05, 2023 at 01:01:16PM +0200, Andrey Albershteyn wrote:
> Hi Christoph,
> 
> On Tue, Apr 04, 2023 at 08:37:02AM -0700, Christoph Hellwig wrote:
> > >  	if (iomap_block_needs_zeroing(iter, pos)) {
> > >  		folio_zero_range(folio, poff, plen);
> > > +		if (iomap->flags & IOMAP_F_READ_VERITY) {
> > 
> > Wju do we need the new flag vs just testing that folio_ops and
> > folio_ops->verify_folio is non-NULL?
> 
> Yes, it can be just test, haven't noticed that it's used only here,
> initially I used it in several places.
> 
> > 
> > > -		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
> > > -				     REQ_OP_READ, gfp);
> > > +		ctx->bio = bio_alloc_bioset(iomap->bdev, bio_max_segs(nr_vecs),
> > > +				REQ_OP_READ, GFP_NOFS, &iomap_read_ioend_bioset);
> > 
> > All other callers don't really need the larger bioset, so I'd avoid
> > the unconditional allocation here, but more on that later.
> 
> Ok, make sense.
> 
> > 
> > > +		ioend = container_of(ctx->bio, struct iomap_read_ioend,
> > > +				read_inline_bio);
> > > +		ioend->io_inode = iter->inode;
> > > +		if (ctx->ops && ctx->ops->prepare_ioend)
> > > +			ctx->ops->prepare_ioend(ioend);
> > > +
> > 
> > So what we're doing in writeback and direct I/O, is to:
> > 
> >  a) have a submit_bio hook
> >  b) allow the file system to then hook the bi_end_io caller
> >  c) (only in direct O/O for now) allow the file system to provide
> >     a bio_set to allocate from
> 
> I see.
> 
> > 
> > I wonder if that also makes sense and keep all the deferral in the
> > file system.  We'll need that for the btrfs iomap conversion anyway,
> > and it seems more flexible.  The ioend processing would then move into
> > XFS.
> > 
> 
> Not sure what you mean here.

I /think/ Christoph is talking about allowing callers of iomap pagecache
operations to supply a custom submit_bio function and a bio_set so that
filesystems can add in their own post-IO processing and appropriately
sized (read: minimum you can get away with) bios.  I imagine btrfs has
quite a lot of (read) ioend processing they need to do, as will xfs now
that you're adding fsverity.

> > > @@ -156,6 +160,11 @@ struct iomap_folio_ops {
> > >  	 * locked by the iomap code.
> > >  	 */
> > >  	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
> > > +
> > > +	/*
> > > +	 * Verify folio when successfully read
> > > +	 */
> > > +	bool (*verify_folio)(struct folio *folio, loff_t pos, unsigned int len);

Any reason why we shouldn't return the usual negative errno?

> > Why isn't this in iomap_readpage_ops?
> > 
> 
> Yes, it can be. But it appears to me to be more relevant to
> _folio_ops, any particular reason to move it there? Don't mind
> moving it to iomap_readpage_ops.

I think the point is that this is a general "check what we just read"
hook, so it could be in readpage_ops since we're never going to need to
re-validate verity contents, right?  Hence it could be in readpage_ops
instead of the general iomap_folio_ops.

<shrug> Is there a use case for ->verify_folio that isn't a read post-
processing step?

--D

> -- 
> - Andrey
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
