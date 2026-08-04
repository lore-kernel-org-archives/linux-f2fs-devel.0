Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7E8C55822
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 18:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j4K6WUYSUagG623Ei0oLQ87SZ2PNd32hIJpgibpPbnA=; b=a04Ic2gMjtXTRv9z4yQ+BHsP1B
	GyBbvb0ntOA4pdSt3bBiYPjmgwSOLZMhFrJmZ8giBzRYgaZ+/5jD9NA/lycnDIApSh2bR8aBitFCI
	fNtbd6TtNy7Ip7Q1DGIBrHrKZWU6IMiuLKJhvA6LSmmatckmLrOWJYWE3qbmfcfcujEM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrKK7-00052w-Pl;
	Tue, 04 Aug 2026 18:57:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wrKK6-00052q-Lp
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 18:57:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uhwOVppSRbXMKKCTiEx73huPloNqZB23NIsD+UJKgS4=; b=A4QuhCsdkvuyFh/anDIieqMnfN
 I3Ie8l3AGLH9IGtpnPbGJzpoV27pxcwBddQGWWM/7XsiN7Vu5tXnpi3TLz7zEzr+YZoStwVS+bbBm
 KLiCaWcc95JWQiO8Xx9St3ZBO4OvCm4zgTV/CUtqkG6Lk+tWCdfZF/+tMLwQfQRgAGUw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uhwOVppSRbXMKKCTiEx73huPloNqZB23NIsD+UJKgS4=; b=EPErdGa2v0ocd7HVKjyIGddqi0
 7B3Je9we2kJUkxvtJp0KegIEmQiCl1TO8QrVwjn2IB2p4ofQbmH3JBSwG1fk6gGSROZmP7487x7B4
 sAaAGIDUlU71CovQ1FLKGMiVs9YEPKG1JK96fAJfd9YXJXrDt020J9j18ptCUbh5bgS4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrKK3-0003Vh-P6 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 18:57:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3C79260AAC;
 Tue,  4 Aug 2026 18:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD491F000E9;
 Tue,  4 Aug 2026 18:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785869822;
 bh=uhwOVppSRbXMKKCTiEx73huPloNqZB23NIsD+UJKgS4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bTBfxSVxHNSSiTMy+XjmV9JBgdMXcWkEebXrsyCKAkbJNr8hufQTkhA6FGGPT2uzo
 iZYvyjT3K2TFnrn3clOypQEb4II+OrC8nJvvox9oLcUqGhJfIEUvW/+P+vFJZ6xMK+
 gFxLsdaYceaMJzuiWoV+70e6FHCwN8TL33ngig3OwaoZEawbkDLSE5snIUptVic/Bt
 GCABBSFvEra2BcEDwDwK5/5LASdWsesh/FNkh9B8Hgdnf1J+VnTqbAtpf9Gylcsmct
 dgSVt7rxeCQPVfNr6yaiMTOj3KxtKb9jzMjxe54cdXAPZAcE7PQoB8FxDk+43jgl3B
 5evwlyUajkuCg==
Date: Tue, 4 Aug 2026 18:57:00 +0000
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260804185700.GE2904385@google.com>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-6-aalbersh@kernel.org>
 <20260804174223.GB14046@lst.de>
 <20260804183752.GC2904385@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260804183752.GC2904385@google.com>
X-Headers-End: 1wrKK3-0003Vh-P6
Subject: Re: [f2fs-dev] [PATCH v14 05/21] fsverity: improve flushing
 performance of fsverity_fill_zerohash
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, Andrey Albershteyn <aalbersh@kernel.org>,
 djwong@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Aug 04, 2026 at 06:37:52PM +0000, Eric Biggers wrote:
> On Tue, Aug 04, 2026 at 07:42:23PM +0200, Christoph Hellwig wrote:
> > On Mon, Aug 03, 2026 at 10:07:55PM +0200, Andrey Albershteyn wrote:
> > > The current version calls flush_dcache_folio(), in memcpy_to_folio(), to
> > > flush whole folio on every digest (which is 128 for 4k) on the HIGHMEM
> > > systems. Open code folio mapping and flushing to copy all digests at
> > > once.
> > 
> > This looks correct, although to me optimizing for this feels like
> > premature optimizations not worth the ugly code unless we have numbers
> > to justify it.
> > 
> > If Eric wants it:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > 
> > > +		if (folio_test_partial_kmap(folio) &&
> > > +		    off > PAGE_SIZE - offset_in_page(offset))
> > > +			off = PAGE_SIZE - offset_in_page(offset);
> > > +		for (; to < (vaddr + off); to += vi->tree_params.digest_size)
> > 
> > Style nitpick: no need for braces when comparing with simple
> > integer arithmetics like this.
> > 
> > > +	for (off = offset; off < (offset + len);
> > 
> > Same here.
> 
> Well I didn't ask for it per se, but I pointed it out and asked whether
> anyone will care about the combination of XFS && FS_VERITY && HIGHMEM.
> Based on Darrick's email it seems the answer may be no?
> 
> If it's kept as-is, adding a comment mentioning that it doesn't need to
> be optimized for HIGHMEM would help preempt any questions about it.

Note that the explanation in the commit message seems to be confusing
people as well.  It only mentions flush_dcache_folio(), when the actual
performance problem on HIGHMEM would be the mapping and unmapping.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
