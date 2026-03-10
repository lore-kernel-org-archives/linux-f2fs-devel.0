Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFF8EA8550
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Mar 2026 09:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SyZ9Q3iMeBfPdvNncEJVEPRRbNLFTEwO1tBJzED259Y=; b=IW6GBglTQ77r4vwi+VXZ+qSEI5
	X0bH+FzETIasZgOrNQsyjGR9hcl4Zxapw6lTrx0uRFf2Bo7WT/Hz1WrwODzQH71vWLwkQfNC64+DV
	MdAWuRHzTRZobYJQ+Xc4nd/PJaVvsfSIFWV9X19iic/syrC0L1DY1C3jPE7GXieDZVsU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vztBA-0005tI-HX;
	Tue, 10 Mar 2026 09:15:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vztAu-0005s2-LE
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Mar 2026 09:14:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R+AVJERpy5tyNjrplbe2NQHHtBiw+nzAaWc5Dc4vCbs=; b=css7sCIerDRwz3JDzmXoIgQWL2
 IJdn8AVCAId2e+9cF7L/8iOhv0Iznf/WPVgZq0EXSqSv2L1wMkVxyqPnZs4viDrLNjQLtU2NcZaYN
 ZjR4VA8hfdFaYHC5/+p52Cl9qJVr/NaZQddxMz1L29XuXHATLlL9tr8cAzRKZP626DCM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=R+AVJERpy5tyNjrplbe2NQHHtBiw+nzAaWc5Dc4vCbs=; b=bLUNd4qTCdOp4thtDADE+GNVEH
 DAsarj11FIAtSAG+jxQhGGEW8gnBeAQU7pKcZXmFTjkQ2GEk1p9ixRlXMnhdQxTU1ZSKglD2bmK8C
 1+Uif2Fv0rvvUGzq8wItbUt7XEUDaDGbfCvSquZsDEBqzQbSx1v+mRH74Dc9b56w0Xb4=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vztAt-0001kN-P8 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Mar 2026 09:14:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9CFF868C4E; Tue, 10 Mar 2026 10:14:34 +0100 (CET)
Date: Tue, 10 Mar 2026 10:14:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260310091433.GB18959@lst.de>
References: <20260309192355.176980-1-aalbersh@kernel.org>
 <20260309192355.176980-11-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260309192355.176980-11-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vztAt-0001kN-P8
Subject: Re: [f2fs-dev] [PATCH v4 10/25] iomap: teach iomap to handle
 fsverity holes and verify data holes
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

On Mon, Mar 09, 2026 at 08:23:25PM +0100, Andrey Albershteyn wrote:
> +		/*
> +		 * Handling of fsverity "holes". We hit this for two case:
> +		 *   1. No need to go further, the hole after fsverity
> +		 *	descriptor is the end of the fsverity metadata.
> +		 *
> +		 *   2. This folio contains merkle tree blocks which need to be
> +		 *	synthesized. If we already have fsverity info (ctx->vi)
> +		 *	synthesize these blocks.
> +		 */
> +		if ((iomap->flags & IOMAP_F_FSVERITY) &&
> +		    iomap->type == IOMAP_HOLE) {
> +			/*
> +			 * Don't cause lookup if we already have fsverity
> +			 * context from the previous tree hole
> +			 */
> +			if (!ctx->vi)
> +				ctx->vi = fsverity_get_info(iter->inode);

This makes the ctx->vi rules really weird, as it;s only set for
the file data initially, but can later get set here for reading the
fsverity data.  I think it might be better to just always set it in
the higher level code if fsveirty is active, and then document how
our rules subtly differ from ext4/f2fs.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
