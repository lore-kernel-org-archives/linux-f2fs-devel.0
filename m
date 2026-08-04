Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED1CC55184
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 17:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gi2MNEOVfqGLyMF8xmRStOnWG2Ks6GBlSES23hlg8z0=; b=fkH//qYBkE6F/EuQ3LONXY5Tks
	exgZixmHGXsaOCVRkBl2oIt/v5tDfGDIgLW0CKAVH2k2ypseuMLLCcfoncE+O6u3dFRNvDgwMpNTE
	sdfZ0VbI+NdX64ZxsDvlydEltjemgRUax7Z1aBbw32TKBwvNE0WD05aMX226UBGLD59w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrJBG-0002q9-NV;
	Tue, 04 Aug 2026 17:43:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wrJBF-0002q3-Kj
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 17:43:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sqJaGHn8Yv7O/sNEc6z1uzKmJ1iYCgpzWZ/oWwPMRQM=; b=gazINsGmFvM8LePa5t6QI8Z1cF
 Oz5jX0HLwBEGqU6Rk3IMWbnsp/gplh1Kl4gFTTVSAlPri4efZXS26g72FpPJQgki72InDS0LkidMA
 0dX2PY63JY1iVEuTzRVo8/vnHbdEQ3LKKOiz27nmgLKcOCK6/DCzerpS/LUh2NMSpSoo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sqJaGHn8Yv7O/sNEc6z1uzKmJ1iYCgpzWZ/oWwPMRQM=; b=Ue3xkc3fFmGRt4K/Vxa0bzHors
 alwROgDVyOpyWUP7GdlJqPhY0onNg/G2+eTRjAPmPvGXdujcbkc3xCGJA9DIGAMUBG07dkSUMx/zh
 4exGu/JVXCbiU2LhzjrwlNHDU3oN4mYmuwURPXTrbGyQNNENCQ19JnmGwQwUQsMreIUQ=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrJBE-0000uP-53 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 17:43:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 02A256732A; Tue,  4 Aug 2026 19:43:48 +0200 (CEST)
Date: Tue, 4 Aug 2026 19:43:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260804174347.GC14046@lst.de>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-12-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260803200820.393203-12-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wrJBE-0000uP-53
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Aug 03, 2026 at 10:08:01PM +0200, Andrey Albershteyn wrote:
> Sashiko.dev reported that while fsverity files falls back to the
> buffered IO for Direct I/O, they should not report non-zero values in
> dio_mem_align and dio_offset_align, meaning it's not supported.

This doesn't make much sense to me.  If we didn't want to report
we'd also want to not set STATX_DIOALIGN | STATX_DIO_READ_ALIGN.
But in the end there is very little upside of this while adding
extra special cases.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
