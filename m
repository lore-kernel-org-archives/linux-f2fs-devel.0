Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F40C55822
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 18:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fKT07NbTY+lC1TYMoSz/HuntskxXLgAXdu9sh/1ChVQ=; b=CwNi2fpry0p+DiVv4UTPRsknCm
	p6Bg5uiuMfaAfqormH2LPtgHwi7NsUB6XfimLbGN8D0jIoqzRi284J99MXWkmhsr9/l/nwnzrVXRA
	KM5F50WWhuPpTkZdugc2Qshetb3VPu4yOUn71hdJc2nh6kUlygIXShGlsJOr8d8Qwt+0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrK9V-0004DX-Au;
	Tue, 04 Aug 2026 18:46:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1wrK9S-0004DQ-T7
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 18:46:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YEg8nX4QR7Tnv1Pjl2JIvJuTWffr1MeWTUmFwQGwg3Q=; b=UcWYc2JKK5Zdzy1ywNDXFiLkvC
 JafIs8pg+I90W1eq6qvmSYMJzdsTQpySF8h8cyNfcaXGAXRd/k0H5OBz3Sp8Y+HljwMcODtpzd2Ej
 DWUNFng/0SicGW1uxyPK2Bzs5XTSz9Yv8jJsmpUikHDUYrGop3sVa+0OnotrB/c2yKnM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YEg8nX4QR7Tnv1Pjl2JIvJuTWffr1MeWTUmFwQGwg3Q=; b=kAfyXGiDGHT2VxFnrETX94vG3B
 AsbZkj7cNKinfqWWAobB8TY6zNy5JA7+6zY2Etnef33LhRgAm9pV60kbawH/jRj2aMtpiw4DPR9Kn
 q34y6AXm02rz/vPusF6d0C8oCTXjcAG/CwdGoHUSO8plSMAG3AE6XDTJQxZmDKnx3l4A=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrK9V-0001a6-SZ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 18:46:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=YEg8nX4QR7Tnv1Pjl2JIvJuTWffr1MeWTUmFwQGwg3Q=; b=S5gEwsVZR1pLMAenBZ15Zq/7rH
 wxFDRQqwxNXNaQ7AX1yKsc9SBc1k/SG44ZHUwpLoRvEeuPx/OjrX/pEXSCOJ1H5KXLblGcoswVXzu
 OEI7spEqXl2vUF5i7ATHNOmBfaKeiRygC1edO3wGpTEV91rggC/V1/7OQo4iCgvHN10ODQm5JOE/F
 gWQHqvYhrh4UlanIfxG3h8Io9FWh+G4upcuq8CZ/0sRvLUyKxp3pZ2AHd8UBcBHe4HaFlkj5nDY7D
 Sq9AY5JQTM6p1cgbblFFN6lJ9u785f/DNycwQw9uTJtREy3d95eLYx3tG0LQmWI0ef8IiMZn+V7rk
 C5+AfzlA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wrK9L-00000004Wkx-1OWC;
 Tue, 04 Aug 2026 18:46:03 +0000
Date: Tue, 4 Aug 2026 19:46:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <anIzawflI11C0FT2@casper.infradead.org>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-6-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260803200820.393203-6-aalbersh@kernel.org>
X-Headers-End: 1wrK9V-0001a6-SZ
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Aug 03, 2026 at 10:07:55PM +0200, Andrey Albershteyn wrote:
> The current version calls flush_dcache_folio(), in memcpy_to_folio(), to
> flush whole folio on every digest (which is 128 for 4k) on the HIGHMEM
> systems. Open code folio mapping and flushing to copy all digests at
> once.

Have you looked at the implementations of flush_dcache_folio()?  On
any architecture we actually care about, all it does is set one bit
in folio->flags noting that the folio will need to be flushed if
it's going to be accessed by userspace.

But, um, do we support mapping folios containing fsverity data into
userspace?  Can't we just delete the calls to flush_dcache_folio()?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
