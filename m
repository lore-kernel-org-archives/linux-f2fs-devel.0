Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5207EC761A6
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Apr 2023 15:37:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pjiik-00072D-Fz;
	Tue, 04 Apr 2023 15:37:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+8568051c7530f6265d9e+7163+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1pjiij-000725-GP for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 15:37:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RdOI5GFBXvz2+CG+FGj78+ixvujqTitirHZIon4ASxI=; b=cwIYp3JQbF/iDKvunrW05yV+Xx
 fm15yTeaVo5W4uT5/loXsA3sz3f5X9C58eWSHVd8fixMSUoxd0Q4Ywv2zvit6Hq06KoXGWY4oEaI/
 /21I/mqgIEMMlS8c/JQY+oXWH+ukUbnEkZk1iowqloXgB5oSbTu5CuqJzqPRb5VS8nlo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RdOI5GFBXvz2+CG+FGj78+ixvujqTitirHZIon4ASxI=; b=csZgiHAILuSOGINgitD9RLvQr+
 6yX0yVATjEIvekPNQpuXWeCuf5enBSRyOjvLjEUmLDCnmKrVbuhOXq9+MNCXoIHlrdC2BX4R8XKVX
 uQJzzEt6bdOGDrKXHVElKZNpq8/6p57ckAEygSXRjBLVIvdt3b/gh4m4wv/Ki3HLQtLw=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pjiih-0004qy-Sy for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 15:37:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=RdOI5GFBXvz2+CG+FGj78+ixvujqTitirHZIon4ASxI=; b=Ahkq88G655jnqkQwTcWuEN6RRq
 h8yjZsKe+Ya6vZx2aj5qznyop6e9Fzt7P3UjXbJv3YvhdNnBewCyzgwcmFuLfVIeeo8HxJITi6zqF
 VoJUTlDJH5weysUFBompr1TeaFJM8Cz/IkuTB8joY0PeYjQN3d5QSaNxM/Z9JSHb6bQ7wMMntt34l
 7HaqQ/BUxGKLrBBoO7LliRbNqk1tsSJOHBjuMuQ7qPPZJPANfHUxtfGJ6ugxXpXKnJP4ZjWXMUpqq
 uLWr5qtFE8Do8CSM76bQ0+Ns9i69roqtrrCuU0gAnh3o2vzYHSwZCxKjZFPcpTofIEqLTRS34odrA
 LrFUS5OQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1pjiiU-0021sG-0G; Tue, 04 Apr 2023 15:37:02 +0000
Date: Tue, 4 Apr 2023 08:37:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Message-ID: <ZCxEHkWayQyGqnxL@infradead.org>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-10-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230404145319.2057051-10-aalbersh@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1pjiih-0004qy-Sy
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, agruenba@redhat.com, hch@infradead.org,
 djwong@kernel.org, damien.lemoal@opensource.wdc.com,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com,
 xiang@kernel.org, jth@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

>  	if (iomap_block_needs_zeroing(iter, pos)) {
>  		folio_zero_range(folio, poff, plen);
> +		if (iomap->flags & IOMAP_F_READ_VERITY) {

Wju do we need the new flag vs just testing that folio_ops and
folio_ops->verify_folio is non-NULL?

> -		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
> -				     REQ_OP_READ, gfp);
> +		ctx->bio = bio_alloc_bioset(iomap->bdev, bio_max_segs(nr_vecs),
> +				REQ_OP_READ, GFP_NOFS, &iomap_read_ioend_bioset);

All other callers don't really need the larger bioset, so I'd avoid
the unconditional allocation here, but more on that later.

> +		ioend = container_of(ctx->bio, struct iomap_read_ioend,
> +				read_inline_bio);
> +		ioend->io_inode = iter->inode;
> +		if (ctx->ops && ctx->ops->prepare_ioend)
> +			ctx->ops->prepare_ioend(ioend);
> +

So what we're doing in writeback and direct I/O, is to:

 a) have a submit_bio hook
 b) allow the file system to then hook the bi_end_io caller
 c) (only in direct O/O for now) allow the file system to provide
    a bio_set to allocate from

I wonder if that also makes sense and keep all the deferral in the
file system.  We'll need that for the btrfs iomap conversion anyway,
and it seems more flexible.  The ioend processing would then move into
XFS.

> @@ -156,6 +160,11 @@ struct iomap_folio_ops {
>  	 * locked by the iomap code.
>  	 */
>  	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
> +
> +	/*
> +	 * Verify folio when successfully read
> +	 */
> +	bool (*verify_folio)(struct folio *folio, loff_t pos, unsigned int len);

Why isn't this in iomap_readpage_ops?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
