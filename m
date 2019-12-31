Return-Path: <SRS0=KtvY=2V=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3524AC2D0C2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Dec 2019 12:53:14 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02258205ED
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Dec 2019 12:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="WczPIucz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Xlg94KBS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DjJ/f06O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02258205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1imH1N-0000Ea-2F; Tue, 31 Dec 2019 12:53:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1imH1L-0000EM-PU
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Dec 2019 12:53:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eK2vFgg397hCSVRa2xjSTfCRGKL3OTkCOPxpuJmtpSE=; b=WczPIucz5rVWF0RTI+ssLfC1we
 2aSjnMZMaprQxBg1txhq0HjimPQ2Y5oRdUcUVahYHbqfbaqb4hzrhmcbzqm1ePlhACtvDw4Vs0SIQ
 ki1aQkh+FuKzprYilL6xfdk0CAWN1tvi/jQzb8Gx4huaZqUThqjpLjjj0hG3aSx9vy5M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eK2vFgg397hCSVRa2xjSTfCRGKL3OTkCOPxpuJmtpSE=; b=Xlg94KBSd4q1EEBKlFFxCAzRvi
 C0xGSzSbRjwSN94UWBf8td/a4TvI2rvURAZ8+j2/t06T5bD2CuENwZvdL1SX+97N93JookeCXVNHw
 0gKziG/c9M2Q3f/EAm1wE5+MtdfWhOu/20Quf++fPPboVa2kVlOPncHySyazgoMS7x+A=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1imH14-003Wzg-Mz
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Dec 2019 12:53:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eK2vFgg397hCSVRa2xjSTfCRGKL3OTkCOPxpuJmtpSE=; b=DjJ/f06OTZ5u8SDIj0Ff5HvXz
 ygTGV4qmY5aq6TU4JxyyVRdg0n8i9ytHFmQ8VYH+TiHhezW7gzXMWpRspCJ/d02GgwDJGJRWqRRFE
 D0TSSWJWtKdO3oin5SmpqCxvIeNSN12oYILKltspjI4GpPLb2eIN1QkznHJtXe17B4VPLGBUg9HMZ
 dZ2hI9/CSHi5dOI1rSbiZLyGlr7M+mmGgc/PxU1f4ZOOAzXDKBI96FS8HoFt7bdE2n07+hcGAS0q5
 hpuyeL4yGK2MAaRLACjlMnFQvDYkRBXGULIm5mT/ldlsIqFnmdkt7LW0UYDDzErA0DRpekureSSlq
 r7DY7ZgIA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1imH0p-0001UC-6u; Tue, 31 Dec 2019 12:52:39 +0000
Date: Tue, 31 Dec 2019 04:52:39 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20191231125239.GC6788@bombadil.infradead.org>
References: <20191223040020.109570-1-yuchao0@huawei.com>
 <CAMuHMdUDMv_mMw_ZU4BtuRKX1OvMhjLWw2owTcAP-0D4j5XROw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdUDMv_mMw_ZU4BtuRKX1OvMhjLWw2owTcAP-0D4j5XROw@mail.gmail.com>
X-Headers-End: 1imH14-003Wzg-Mz
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce DEFAULT_IO_TIMEOUT_JIFFIES
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Dec 23, 2019 at 09:41:02AM +0100, Geert Uytterhoeven wrote:
> Hi,
> 
> CC linux-fsdevel
> 
> On Mon, Dec 23, 2019 at 5:01 AM Chao Yu <yuchao0@huawei.com> wrote:
> > As Geert Uytterhoeven reported:
> >
> > for parameter HZ/50 in congestion_wait(BLK_RW_ASYNC, HZ/50);
> >
> > On some platforms, HZ can be less than 50, then unexpected 0 timeout
> > jiffies will be set in congestion_wait().

It doesn't matter, congestion is broken and has been for years.

https://lore.kernel.org/linux-mm/20190923111900.GH15392@bombadil.infradead.org/


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
