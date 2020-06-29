Return-Path: <SRS0=zfsZ=AK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA03C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jun 2020 18:25:12 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB48255EE;
	Mon, 29 Jun 2020 18:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="SzAAyg89";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="AJzBz7O1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Blp8tuH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB48255EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jpySt-0000HA-SH; Mon, 29 Jun 2020 18:25:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jpySs-0000H3-BD
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jun 2020 18:25:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FQRLqegFq54p9hBYp/teFoLm8sTZpJ+xZJvvDoHkzcA=; b=SzAAyg897OHUlqdNI4DYV156XZ
 JsunwaCYnOC06wnBo4UcB5rx7wjjG0kuU+z8ogJY8ysAHFWprGlLHZ8HPtVpSFKp0XhgPCVs3n0LR
 G5kM/ohYVWwMVLLlwwTvFpPDYhg+gsX3IMMCkJgLafMP/65tmeYqc6XgImxMOXFa46rU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FQRLqegFq54p9hBYp/teFoLm8sTZpJ+xZJvvDoHkzcA=; b=AJzBz7O1MEgmQ35bWOAh/PWbXF
 PlD+Rjwc+PII6aaXoJECMBTqGLXihf3SuL/8UXA5CLq+7pl+CJAApsbnu4upZmzhy99GTT0ZulEIU
 /GYZA5+9pxFynK2mD3wcC8zM3CmDYCHAhYVoRRt+wkHMa4gNuv6UMuE+Uq/Km7aCzgz0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jpySr-005GQz-75
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jun 2020 18:25:10 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AD7F8255E3;
 Mon, 29 Jun 2020 18:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593455103;
 bh=wkackI2rfYcaIhwqNMPcXwmVpxfvX7NY51JrPzFNKm0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Blp8tuH+v0xm4gkhx5A0ISpTqN77nf36qnKbOK9TmxsqaJhHMajqjfDivu7VSTh08
 aAMfNC9mUqwFGKrHwqGjavV7dxtzH2fuRo3vr3RAjjccgO++1NZ0z6FqxKMNjLrUNu
 8x9sfbWrIlUXPrEXqdshhQCQ/Xw0d+XMJG9z9c3w=
Date: Mon, 29 Jun 2020 11:25:02 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <20200629182502.GF20492@sol.localdomain>
References: <20200624012148.180050-1-jaegeuk@kernel.org>
 <20200629150323.GA3293033@google.com>
 <20200629160934.GA1752982@gmail.com>
 <20200629182414.GA1117827@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200629182414.GA1117827@google.com>
X-Headers-End: 1jpySr-005GQz-75
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid readahead race condition
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
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jun 29, 2020 at 11:24:14AM -0700, Jaegeuk Kim wrote:
> On 06/29, Eric Biggers wrote:
> > On Mon, Jun 29, 2020 at 08:03:23AM -0700, Jaegeuk Kim wrote:
> > > If two readahead threads having same offset enter in readpages, every read
> > > IOs are split and issued to the disk which giving lower bandwidth.
> > > 
> > > This patch tries to avoid redundant readahead calls.
> > > 
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > > v2:
> > >  - add missing code to bypass read
> > > 
> > >  fs/f2fs/data.c  | 18 +++++++++++++++++-
> > >  fs/f2fs/f2fs.h  |  1 +
> > >  fs/f2fs/super.c |  2 ++
> > >  3 files changed, 20 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index d6094b9f3916..9b69a159cc6c 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -2403,6 +2403,7 @@ int f2fs_mpage_readpages(struct address_space *mapping,
> > >  #endif
> > >  	unsigned max_nr_pages = nr_pages;
> > >  	int ret = 0;
> > > +	bool drop_ra = false;
> > >  
> > >  	map.m_pblk = 0;
> > >  	map.m_lblk = 0;
> > > @@ -2413,13 +2414,25 @@ int f2fs_mpage_readpages(struct address_space *mapping,
> > >  	map.m_seg_type = NO_CHECK_TYPE;
> > >  	map.m_may_create = false;
> > >  
> > > +	/*
> > > +	 * Two readahead threads for same address range can cause race condition
> > > +	 * which fragments sequential read IOs. So let's avoid each other.
> > > +	 */
> > > +	if (pages && is_readahead) {
> > > +		page = list_last_entry(pages, struct page, lru);
> > > +		if (F2FS_I(inode)->ra_offset == page_index(page))
> > > +			drop_ra = true;
> > > +		else
> > > +			F2FS_I(inode)->ra_offset = page_index(page);
> > > +	}
> > 
> > This is a data race because ra_offset can be read/written by different threads
> > concurrently.
> > 
> > It either needs locking, or READ_ONCE() and WRITE_ONCE() if races are okay.
> 
> I just wanted to keep zero overhead, since it doesn't matter either cases of
> skipping readahead or not.
> 

Okay, then it should use READ_ONCE() and WRITE_ONCE().

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
