Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D39C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 18:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dCkiDFRyVhq+kvAcwR7FjkxPNYnioxsgEQO3f0rw+zo=; b=JqdPidJNaQmmEDi+hsJvEZI1TL
	rdPRscMaQkN753juZEQaP+lfnIVHbUjB9/j+ZLrc46dIHErCFP4I+yXijFxjPux1QxqBMw0EQOL1V
	lHlP6CP0leTDbboj0Jh2u0wXLK2Ifp2QoMUn8mp4MpkcVn1Dlmfb5FAlSokR3ZDo/HGQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrJtI-0001z5-Sf;
	Tue, 04 Aug 2026 18:29:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wrJtF-0001yy-VP
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 18:29:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Zp1skLnHqAyH/0d878nuE8/4QAieL1XOTvNWul4GB3A=; b=IxPPis0jwdS5TrgsSYWvMpDwr2
 NhI3Pmu1a2z59lw7Rl5fcKKGT6FO8qdxynSM4zalwnyXP6PFRto9UbkGs+ibAW+Ga5A0Bw5Wa+TSI
 dvvmj0fpdBVemsLAqE1R/vp4X6UpiGS7us0CBtvZGqMnx3C8DvSkPBiLBQ2hKjZQoKN8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Zp1skLnHqAyH/0d878nuE8/4QAieL1XOTvNWul4GB3A=; b=e4f4XlFf/q9AnEZL5zZwTzU+A6
 53+TsY01GXk36cXoDre/15nnrTbs3o8WkYQ4VoEKxoEvyAM97igenjdqaWhPYsAFikHKarCx0Tjui
 jZX86C/2UsvOoXAAr65paEH74h+Ih9E3WtXhNuVLcohFUaXVwKk10Fv3VegZrKCOmvlg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrJtH-00017G-E5 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 18:29:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1501060A78;
 Tue,  4 Aug 2026 18:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726B61F000E9;
 Tue,  4 Aug 2026 18:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785868157;
 bh=Zp1skLnHqAyH/0d878nuE8/4QAieL1XOTvNWul4GB3A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Zw+/ikYl/m71U0AU0WIiLOLp1Rmk0UUct9jU3Cybclv3feFqErVouNiFAdQhKG5Yi
 Eo1LXtn4+dlYvXUKbNdJlJrXpGBMvLAAavVAa7WMuYpfJsRSrYTK+1t7ldyRSac8+V
 k0dJSuBh3+LhAcLn3GmuYKb/Jg7YAc4YiYvj36cS4zEm5vGxiNqFlR7B1TLxx03KrX
 dSK0HHe2G4vyCU6shw8fuuNX/pmiLMvir7b1uqp3Sesdza1ztNszJNPZ8m+aYnl0cE
 RZTwTmGT9/LMbGZKvUIoS/t2IlPtUowxCuQB4IJwM9M6oZHM3mdeqlFWlGlbJ6NP+i
 HPD2jZU43ExCw==
Date: Tue, 4 Aug 2026 18:29:15 +0000
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <20260804182915.GB2904385@google.com>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-12-aalbersh@kernel.org>
 <20260804174347.GC14046@lst.de>
 <20260804175058.GH3556460@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260804175058.GH3556460@frogsfrogsfrogs>
X-Headers-End: 1wrJtH-00017G-E5
Subject: Re: [f2fs-dev] [PATCH v14 11/21] xfs: don't report dio_mem_align
 and dio_offset_align for fsverity files
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
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Aug 04, 2026 at 10:50:58AM -0700, Darrick J. Wong wrote:
> On Tue, Aug 04, 2026 at 07:43:47PM +0200, Christoph Hellwig wrote:
> > On Mon, Aug 03, 2026 at 10:08:01PM +0200, Andrey Albershteyn wrote:
> > > Sashiko.dev reported that while fsverity files falls back to the
> > > buffered IO for Direct I/O, they should not report non-zero values in
> > > dio_mem_align and dio_offset_align, meaning it's not supported.
> > 
> > This doesn't make much sense to me.  If we didn't want to report
> > we'd also want to not set STATX_DIOALIGN | STATX_DIO_READ_ALIGN.
> > But in the end there is very little upside of this while adding
> > extra special cases.
> 
> directio is supported; the implementation merely falls back to reading
> through the page cache.  Unless you're saying that xfs shouldn't
> shouldn't set FMODE_CAN_ODIRECT for fsverity files?  But that also
> doesn't sound right.
> 
> Personally I think sashaniko is full of it and this whole patch should
> be dropped.

The statx fields are meant to report real direct I/O support, not merely
accepting the O_DIRECT flag and silently falling back to buffered I/O.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
