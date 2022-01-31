Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8F8C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Jan 2022 06:45:09 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nEQR3-0004nn-MG; Mon, 31 Jan 2022 06:45:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <hch@lst.de>) id 1nEQR0-0004nh-UI
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 31 Jan 2022 06:45:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DD/WKFEQukfGQTZoUNRul9nysyJ154q0Ki6QAc6t478=; b=Wm6tJyisGPm9F9vNxsLBtYd5l+
 6yGqZUOGM7l3n05ii7FKQxoQkOso0zpGGQdihd23hD+3rxBrTrxBLRZ5TMA+duftEolH4MUWf1G4T
 E3Ub1CPSMKj/u+d+BHMeuAZ/2D1HAEOmhdZi/W+k+GrQtEImOk1/ujv/rgnVZFoaHkvg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DD/WKFEQukfGQTZoUNRul9nysyJ154q0Ki6QAc6t478=; b=Dc10Wde8aOI1ZvX10RHWYY6rvC
 VfbDYmG31v9NxP74/joKdY6B0hlD/i2tAd5zuf1D3NrmK6/yAufzPKcTjiXICNHOZwUN1VIrEIDnV
 zwpaEVbklptbT6Khd0HNO6wqwD46Y5ERA2IG0lVDYthbpmx+bV0BeB0FutWrnlaQPl8w=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nEQQu-0004F3-UT
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 31 Jan 2022 06:45:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9117A68AFE; Mon, 31 Jan 2022 07:44:44 +0100 (CET)
Date: Mon, 31 Jan 2022 07:44:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <20220131064444.GA4745@lst.de>
References: <20220118065614.1241470-1-hch@lst.de>
 <87zgnp51wo.fsf@collabora.com> <20220124090855.GA23041@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220124090855.GA23041@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1nEQQu-0004F3-UT
Subject: Re: [f2fs-dev] [PATCH] unicode: clean up the Kconfig symbol
 confusion
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 24, 2022 at 10:08:55AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 20, 2022 at 08:10:47PM -0500, Gabriel Krisman Bertazi wrote:
> > > Fixes: 2b3d04787012 ("unicode: Add utf8-data module")
> > > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > I fixed the typo and pushed the patch to a linux-next visible branch
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git/commit/?h=for-next&id=5298d4bfe80f6ae6ae2777bcd1357b0022d98573
> > 
> > I'm also sending a patch series shortly turning IS_ENABLED into part of
> > the code flow where possible.
> 
> Thanks.  It might make sense to get the one patch to Linux for 5.17
> so that we don't have the new Kconfig symbol for just one release.

Can we try to get this into 5.17-rc, please to avoid adding the Kconfig
symbol Linus complained about in one release just to remove it again
in the next one?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
