Return-Path: <SRS0=4lPE=L5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9AEC07E98
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Jul 2021 08:57:13 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D7B613C2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Jul 2021 08:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D7B613C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m0KPf-0000Xu-9Z; Mon, 05 Jul 2021 08:57:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <jaegeuk@kernel.org>) id 1m0KPd-0000Xn-Ex
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Jul 2021 08:57:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=adsLoZYjyZMopXg1uCR2q4bhXinCptCX4JfdkoNW2SQ=; b=SydumdHV1cV5LVr5b8QnhDr15a
 J69FqYnY388QVJexCr38Pp8mbsHTyiXJZDHapYEdY5txL49nbhiSg/GMdI3XoAlgxZapTyhikBs6a
 mZbHOmkIGKrIJ5h8v6jUpFY+amxT+eERPUQ3obPlQG5aAaFSpCgDBCzd6vZIFkj/vXng=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=adsLoZYjyZMopXg1uCR2q4bhXinCptCX4JfdkoNW2SQ=; b=LuRqsMwmJLxSY3mSkb4o9LfYpc
 QC+mFbdrEDT1Gwvl/mw69qVxgYkePpVdYb8srPdVThaPYMtRxFQ1o4WwgrHvj/LphKmglgmHfM81G
 3JTDdOZ85eDHeCb6h9u8iaBJH2jSn5AVfkKcQPJTcvQ6JK0+ulkES/ph4dguW7x0vKiQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m0KPa-0006le-06
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Jul 2021 08:57:09 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 765A1613C2;
 Mon,  5 Jul 2021 08:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625475420;
 bh=ZqjV6RrWkA7theMbsvZ8YZrCke0QXHtvRo3wcNk+Upk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FDMrGP9js/MZtQ/Ho77/c6GRBbjraVZgGhojOtutaYSGt24I4xbHtiq1lif8985y9
 XFWGS7NOy5jhd8Ot4wjbzr9tWMk8qrleglrNJ/64p3/DDMB+05wlcmIXbsJ+eJAOkT
 sv6KEaC2gujt5FpQCFWRUp2t1+OLRgP0XKZk8ZrqrtQsbna8/f1UPK+6ZWjUBaFT4B
 bNMbqjxNUSWacN04vI3t/lt4l0zLx4ZUwygD1usCRyMkVNeWLkvpOcsg7LLJl3sGs9
 mAnQNtddAWQyjQNOdcAPCe0j71nwQzvi0o0t/uVdc+6nfc71Na0r0rQeOFKQG8QXPe
 DVrsLbBs3zfiw==
Date: Mon, 5 Jul 2021 01:56:59 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YOLJW0IgCagMk2tF@google.com>
References: <20210705052216.831989-1-jaegeuk@kernel.org>
 <c32642d6-6de2-eb2d-5771-c7cefa62fab5@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c32642d6-6de2-eb2d-5771-c7cefa62fab5@kernel.org>
X-Headers-End: 1m0KPa-0006le-06
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize page->private when using
 for our internal use
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
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/05, Chao Yu wrote:
> On 2021/7/5 13:22, Jaegeuk Kim wrote:
> > We need to guarantee it's initially zero. Otherwise, it'll hurt entire flag
> > operations.
> 
> Oops, I didn't get the point, shouldn't .private be zero after page was
> just allocated by filesystem? What's the case we will encounter stall
> private data left in page?

I'm seeing f2fs_migrate_page() has the newpage with some value without Private
flag. That causes a kernel panic later due to wrong private flag used in f2fs.

> 
> Cc Matthew Wilcox.
> 
> Thanks,
> 
> > 
> > Fixes: b763f3bedc2d ("f2fs: restructure f2fs page.private layout")
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/data.c | 2 ++
> >   fs/f2fs/f2fs.h | 5 ++++-
> >   2 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 3a01a1b50104..d2cf48c5a2e4 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -3819,6 +3819,8 @@ int f2fs_migrate_page(struct address_space *mapping,
> >   		get_page(newpage);
> >   	}
> > +	/* guarantee to start from no stale private field */
> > +	set_page_private(newpage, 0);
> >   	if (PagePrivate(page)) {
> >   		set_page_private(newpage, page_private(page));
> >   		SetPagePrivate(newpage);
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 65befc68d88e..ee8eb33e2c25 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1331,7 +1331,8 @@ enum {
> >   #define PAGE_PRIVATE_GET_FUNC(name, flagname) \
> >   static inline bool page_private_##name(struct page *page) \
> >   { \
> > -	return test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
> > +	return PagePrivate(page) && \
> > +		test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
> >   		test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
> >   }
> > @@ -1341,6 +1342,7 @@ static inline void set_page_private_##name(struct page *page) \
> >   	if (!PagePrivate(page)) { \
> >   		get_page(page); \
> >   		SetPagePrivate(page); \
> > +		set_page_private(page, 0); \
> >   	} \
> >   	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
> >   	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
> > @@ -1392,6 +1394,7 @@ static inline void set_page_private_data(struct page *page, unsigned long data)
> >   	if (!PagePrivate(page)) {
> >   		get_page(page);
> >   		SetPagePrivate(page);
> > +		set_page_private(page, 0);
> >   	}
> >   	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page));
> >   	page_private(page) |= data << PAGE_PRIVATE_MAX;
> > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
