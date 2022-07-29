Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAE1C00144
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 Jul 2022 13:27:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oHQ1S-0007ry-9i; Fri, 29 Jul 2022 13:27:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from
 <BATV+6b4ca9ee961ef62048b6+6914+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1oHQ1Q-0007rr-Hj
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Jul 2022 13:27:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eCHNh6LIA9gROqbDgmH+94ZUhQ9hP1NXx31IFuMdPWs=; b=BvlzmQHNBYlAgCDoNM9AmnoKPO
 bPO12Tiu+KfYAKlmkNo0WzfuFmJ3RJTqV8EqUPY4fna0ctdT1/oDI8BiABlMVKoIjTtZpq/AhjdiQ
 GJGmmwUqMSABAi6nX1gkGit7+XhcUpwC6Pb89sSHt/P+gThYxyKWg3NRCfMkt1DvZohw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eCHNh6LIA9gROqbDgmH+94ZUhQ9hP1NXx31IFuMdPWs=; b=YUpZ1uAkEBPpQgtDKcQoHkBxvu
 dJDMQkyn0VbK5AQp9S9N9ydR54Vnx5uThUgYetRi8IbIdjJ18c0t3cowfKHHBrClrtvKPIu2cbvSx
 1yHVYhcPD62O+9GIDSNCR9i0idi9xNHKG5Vqp3+DiycNGJjPB3nJEDBiH8zL/W7GbgGw=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oHQ1L-00027r-F4
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Jul 2022 13:27:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=eCHNh6LIA9gROqbDgmH+94ZUhQ9hP1NXx31IFuMdPWs=; b=YG0E8TX0Hjc5KOEydvltqdXoI7
 MxeSDaw5iUawZAp0Ro9zRcqvwAvICwC2vtcMbH+8AIw2zVvxJK42HEW1LFuwsZlhymKVgmvZ8e/z3
 7oChMqWHO6rmpbqlV05cTfb354oLhilwEaNI8JmfVxoicyfJp9zDI9smPAiZAMdj+owm5nsccPD+X
 bb+dvxcElbxtXB1y5qpV5NYEo1tChNpmhkRM4/6WmlkVg8nQdnJY6CBQD+c5bsJ/FLE0shF81dzvm
 1xpvAP2eWPoNh2oxeWJ2II4w/BLMWW0J0ewVIMjYA7xQ4aRAu7b2Bb3zgg9IsXjOsbK3mtUG/YOs4
 vJ2+Kw0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1oHQ12-0059BM-RJ; Fri, 29 Jul 2022 13:26:56 +0000
Date: Fri, 29 Jul 2022 06:26:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eunhee Rho <eunhee83.rho@samsung.com>
Message-ID: <YuPgIByYgc6WSPDE@infradead.org>
References: <CGME20220729002517epcms2p35eed262c3349287436c1848ab350c2d4@epcms2p3>
 <20220729002517epcms2p35eed262c3349287436c1848ab350c2d4@epcms2p3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220729002517epcms2p35eed262c3349287436c1848ab350c2d4@epcms2p3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1oHQ1L-00027r-F4
Subject: Re: [f2fs-dev] [PATCH v0] f2fs: allow direct read for zoned device
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
Cc: "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jul 29, 2022 at 09:25:17AM +0900, Eunhee Rho wrote:
> For zoned devices, f2fs forbids direct IO and forces buffered IO
> to serialize write IOs. However, the constraint does not apply to
> read IOs.

Asymetric capabilitis will cause a whole lot of problems for us.  Can
we figure out why direct writes to zoned devices are not supported and
just fix that instead?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
