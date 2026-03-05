Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3854DF33A68
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7GyNaZ3luBHJgwos3G4AnosnYcRbZlO6pu0gq6AaQLE=; b=f1ZWgkSV/0Evhc2u5w84dBV9b3
	AWErGcMil1P93hNcqDyc595M8nQ0lbxgj6T+yxZLo3YWzmLQDLCHQTocHIwJQ4D+wvWhcK+OApd/W
	SSSliat0HtOuCuimJu/GrCxcqDb6xExPJWpSby0YcXg1TO0R5HH5mKrz9Cd+e0p0j/lg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vy9Ro-0003ZU-0n;
	Thu, 05 Mar 2026 14:13:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+2e11e6930e970eb8572e+8229+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1vy9Rl-0003ZO-VJ for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Mar 2026 14:13:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IO6QMfBHH8sMK+gsIVCR4BlKaz4fOls25p0dmnSxTg0=; b=gfsi96qHis5bcVIYYiQTbWbT3T
 rSNJnNshYAsyzmTReMQiCOrnZTpf/Z3HupIyDY6+1UJY/mzSPk+CeHEwlgmJZxGTwGQGR2P3ZH8xy
 IuX8RydASYzs0eMH8loaTKMkTzEfmEF5+yaNuNFS4dnwANERDktRgnD5Vr2OULapuItY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IO6QMfBHH8sMK+gsIVCR4BlKaz4fOls25p0dmnSxTg0=; b=Tv5Etk3F/l/AsStHpwbylQOIl+
 q88QgllwNQZz2v1Tq/fcWt7tvBC+mvKXVXF4iv9kDwnxGEWH3tPgfKz/wXLZa3w4oO9CUY2VBPTu8
 Tle4zEorwtY2WnaTAOqeqqcylj3lMZwwUiFlbaDMoOLV4SlhkZQK88fBldpMjHE9o2H8=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vy9Rl-0003Yb-6r for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Mar 2026 14:13:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=IO6QMfBHH8sMK+gsIVCR4BlKaz4fOls25p0dmnSxTg0=; b=EM5q36QGse8Eo0rdRyuwEK0kug
 POFFSpf0FFYzOJTVE5uLbRO3DCfB160ZZqk4rXNER8kLMqP6pjdqRGQdu3Wv1bUUUnJLpRiAL9/HQ
 jgUBJGbLO5UZ4bZSerntEBKkY/QRv4PNEv07OkOuskyR2pRgnsJjo9LBHTLEqBL/FNGQHc6Nm1cC/
 nNV8/XRfxLaZQunjXq1DcQwxccMR0XQVDaXcaBuvmW4zOUzPW16fx3b9qiKQmFTNVoxv9bekfTegc
 XUwq7ye1qckYMF7lOie+IMOP3XtMbX/ahMAqSi5tuPvP/4OSsf9HoHYYQJxRdS2F7Oobc9Lbh0x05
 uVpsHBRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1vy9RZ-00000001vWO-2ZpE;
 Thu, 05 Mar 2026 14:12:49 +0000
Date: Thu, 5 Mar 2026 06:12:49 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Message-ID: <aamPYU19Qdh-6R8m@infradead.org>
References: <20260304190424.291743-1-agruenba@redhat.com>
 <20260304190424.291743-2-agruenba@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260304190424.291743-2-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1vy9Rl-0003Yb-6r
Subject: Re: [f2fs-dev] [PATCH 1/4] block: consecutive blk_status_t error
 codes
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
Cc: Jens Axboe <axboe@kernel.dk>, dm-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Mar 04, 2026 at 08:04:06PM +0100, Andreas Gruenbacher wrote:
> Since commit 9da3d1e912f3 ("block: Add core atomic write support"),
> there is a gap in the blk_status_t codes and block status code 18 is
> unused.  This causes blk_status_to_errno() and blk_status_to_str() to
> return incorrect values for that code.  Make the blk_status_t codes
> consecutive again to avoid that.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
