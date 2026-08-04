Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737B3C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O/q35MOoUGXQ3F8OikhVDY7p5qBiA/YOhSheX5YzmVk=; b=aiT3OVkRGNynVVxRu1s6YQ1iSe
	BOC8zBJPI2K/3kzFXBuR934FfvGVHBc/Hjkb4/UrkTuaaRs2P+/e5UwP6NEwB+nmAA+xJQmp3RVdt
	ymyPS2D/ulXbahB5TCivAxCQm8ZdM6zpWKd4axL0pDkSVyBLxIvyZzMkzDFKE+foaHtc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrKNQ-0002ZI-2B;
	Tue, 04 Aug 2026 19:00:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wrKNO-0002ZA-HA
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 19:00:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oTbuw/euW+vCmgqmL6+mJcayXncOdyukRicUuH2+0kI=; b=Nc55HWRc0ArKHbew8AsEHbmFGu
 yfJDLnyvN3UPWd3wqcnHe/D1BCUndZ/1lWSuCylj1zN1uJIovV4URLwe7XHO1Z44L0tUUDaXpJCKn
 NtNEhIkaws7H+ap1u7MwvksM4mVJ6cawNwN+MLtQSjmJvQTsxS1zzspPn8OtCrgsW44o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oTbuw/euW+vCmgqmL6+mJcayXncOdyukRicUuH2+0kI=; b=KVdjA1ZUKZcNXlvFboDvyhGKP1
 op/XAYCFwKquj/TgDcLxJZTywBGXYl7eECBJvlspm51bNXi9FlCK8ooGPZ/hAMJZzn7y2QZyBjPxY
 Kxqms857yrREM7jZEfF01rfDutsRYbNUtf2QZr45Xy+Rers+ed/JJ/wPnkDNE1fvDBTw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrKNN-0003cx-E2 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 19:00:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with UTF8SMTP id CB84C60AAC;
 Tue,  4 Aug 2026 19:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 75F9D1F00A3D;
 Tue,  4 Aug 2026 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785870027;
 bh=oTbuw/euW+vCmgqmL6+mJcayXncOdyukRicUuH2+0kI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BnwpTPvvn3TIPcenIfDsdMZXWdypqmknhdx/u5JgPYdVJssvRi6efz4Ee+BETc6+d
 vSSkWiSMf5CvqIwFL770NKdjcAFcMaeeOTjxIl6JOLolmO3k/xMaXfZccvfvy9x0BU
 dCLeCU76Z8Yw9+w+qS9x9AQnrt3WilfeYvkKcL4uobYs2KAnhMXPlUTG6Z6kXQTUOC
 MEiEmZE45rmayhVfHemzGodB3Po5hFtBsnbPmpGTcmifbyfIweM9zETwYSljoX+0X2
 wJwuAuuG370yPZTs4dkSm5sKrOH3MyN3Mf0zTh0aF4a47z4Y4jduwqLjSGEbLzitAI
 KhMZ8ePtgux0Q==
Date: Tue, 4 Aug 2026 12:00:27 -0700
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260804190027.GQ3556460@frogsfrogsfrogs>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-6-aalbersh@kernel.org>
 <20260804174223.GB14046@lst.de>
 <20260804183752.GC2904385@google.com>
 <20260804185700.GE2904385@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260804185700.GE2904385@google.com>
X-Headers-End: 1wrKNN-0003cx-E2
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, Andrey Albershteyn <aalbersh@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Aug 04, 2026 at 06:57:00PM +0000, Eric Biggers wrote:
> On Tue, Aug 04, 2026 at 06:37:52PM +0000, Eric Biggers wrote:
> > On Tue, Aug 04, 2026 at 07:42:23PM +0200, Christoph Hellwig wrote:
> > > On Mon, Aug 03, 2026 at 10:07:55PM +0200, Andrey Albershteyn wrote:
> > > > The current version calls flush_dcache_folio(), in memcpy_to_folio(), to
> > > > flush whole folio on every digest (which is 128 for 4k) on the HIGHMEM
> > > > systems. Open code folio mapping and flushing to copy all digests at
> > > > once.
> > > 
> > > This looks correct, although to me optimizing for this feels like
> > > premature optimizations not worth the ugly code unless we have numbers
> > > to justify it.
> > > 
> > > If Eric wants it:
> > > 
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > 
> > > > +		if (folio_test_partial_kmap(folio) &&
> > > > +		    off > PAGE_SIZE - offset_in_page(offset))
> > > > +			off = PAGE_SIZE - offset_in_page(offset);
> > > > +		for (; to < (vaddr + off); to += vi->tree_params.digest_size)
> > > 
> > > Style nitpick: no need for braces when comparing with simple
> > > integer arithmetics like this.
> > > 
> > > > +	for (off = offset; off < (offset + len);
> > > 
> > > Same here.
> > 
> > Well I didn't ask for it per se, but I pointed it out and asked whether
> > anyone will care about the combination of XFS && FS_VERITY && HIGHMEM.
> > Based on Darrick's email it seems the answer may be no?
> > 
> > If it's kept as-is, adding a comment mentioning that it doesn't need to
> > be optimized for HIGHMEM would help preempt any questions about it.
> 
> Note that the explanation in the commit message seems to be confusing
> people as well.  It only mentions flush_dcache_folio(), when the actual
> performance problem on HIGHMEM would be the mapping and unmapping.

Ah.  In that case I definitely don't care to optimize it unless we get a
complaint from a real user.  XFS doesn't really support 32-bit anymore
because xfs_repair on large filesystems is known to run out of address
space for all of its temporary indexes and crash.

(I'd be fine with dropping this entirely.)

((Yes, we could increase the amount of address space by cheating with
memfds, but yuck.))

--D

> - Eric
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
