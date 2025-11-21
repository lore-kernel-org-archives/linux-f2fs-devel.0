Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E3ECFC29F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Nov 2025 19:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xaK+HQkIuUxnlaW5rTJTRQHVraDZGpeQ3Dj5dPXApHg=; b=dh4Y+Q/XmHQyT4FFcFPIgqdhMO
	2LF6CPdcCiDdBRrKF6fdfkZ+gA5p+YcRD608H8yNsxZqEW/147hPkEcZzoavLjRpZvuyH/R+cbj/G
	3Pe/SHIH0yARL3qn5UvLYH8eSuLqK9Bq8KW3LypvAH5NUkocXuP0qVN3IAXk17Ujg/zI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vMXGz-0004z8-SS;
	Fri, 21 Nov 2025 19:58:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1vMXGy-0004z2-4N
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Nov 2025 19:58:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FRRSYuqlrAkk9h3TXg+hRF8LC7wMdiwXNXcQSlHUBdI=; b=XKgD1eOvjGeMCfgwNPhxwHBzxH
 wK+QkUG3EybpXmgpxXFodnTUhEZTsni9sKupo9cNI7v4P4zDwnYwb8PC100TLYLSFkZQ5CEn3FDhf
 Si3iQ6A+NyPby9r7gAoodVR+4dCjRU/nOV/Bol5o52yhFBAImUdu7OWbScEoWmSNcwH8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FRRSYuqlrAkk9h3TXg+hRF8LC7wMdiwXNXcQSlHUBdI=; b=dipGlEHIakiDMJmD+BdD3izGmD
 9BHCpPPAluwmYHMSedWFphesswU3d/pEOltLHEavFbzRcjSUqhbo+nQA+al+v7H0Kcuf/dQop2gyX
 JLdkW9XDx1UYF4/yeYwSm//irvAn1UGRMOGUR4QjY3YvDl2MyvVCGrZbHdB4oJ7pRgNg=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vMXGx-0000Je-MO for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Nov 2025 19:58:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=FRRSYuqlrAkk9h3TXg+hRF8LC7wMdiwXNXcQSlHUBdI=; b=WxmAZd+8OfJZzOxRQwHSNUm8YS
 2yNqZW6VBLUlGu3afBnH8QNFxiQec2GHf4bmk6OSbIvI1jwr95yNDnCpK5Nr6/JkQJzSqgKTLctBr
 zQLZ/wi1EKI6MBkKQk4yJD6PS8GXfPx6H5fW6uJaVrjU/HTBJoq9ZAoC/e9CF97d3YJWElxfEZBPR
 lM/85yrXz2V+eVy+mRhX/5N54RzwJS3tHaLTxIZ3NqpACM2YhiLRw9MIJWnELzvlRRHuF//fyXjSW
 sbCS2dkjeuAGgCtc5kghEiZsAjlEogtNDsvLKhsoeLIYidX/j6M/AqYqQFaiebd2t03g+h9y70cEO
 J672CQ8g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1vMXGl-00000003O5z-1DBr;
 Fri, 21 Nov 2025 19:58:11 +0000
Date: Fri, 21 Nov 2025 19:58:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <aSDEU_C5QaSXD18x@casper.infradead.org>
References: <20251121032718.1993528-1-jaegeuk@kernel.org>
 <aR_pCGtcc7ASeA77@casper.infradead.org>
 <aR_ultJzXh1rmOKs@google.com>
 <aSB25FFkLaJkbVfT@casper.infradead.org>
 <aSCpKx9ITAJfoSlw@google.com> <aSDC4jlaKSaKgbvc@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aSDC4jlaKSaKgbvc@google.com>
X-Headers-End: 1vMXGx-0000Je-MO
Subject: Re: [f2fs-dev] [PATCH] [RFC] mm/fadvise: introduce POSIX_FADV_MLOCK
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
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Nov 21, 2025 at 07:52:02PM +0000, Jaegeuk Kim wrote:
> On 11/21, Jaegeuk Kim wrote:
> > On 11/21, Matthew Wilcox wrote:
> > > On Fri, Nov 21, 2025 at 04:46:14AM +0000, Jaegeuk Kim wrote:
> > > > On 11/21, Matthew Wilcox wrote:
> > > > > On Fri, Nov 21, 2025 at 03:27:18AM +0000, Jaegeuk Kim wrote:
> > > > > > This patch introduces a new POSIX_FADV_MLOCK which 1) invalidates the range of
> > > > > > cached pages, 2) sets the mapping as inaccessible, 3) POSIX_FADV_WILLNEED loads
> > > > > > pages directly to the inaccessible mapping.
> > > > > 
> > > > > ... what?
> > > > > 
> > > > > This seems like something which is completely different from mlock().
> > > > > So it needs a different name.
> > > > > 
> > > > > But I don't understand the point of this, whatever it's called.  Need
> > > > > more information.
> > > > 
> > > > So, the sequence that I'd like to optimize is mmap(MAP_POPULATE) followed
> > > > by  mlock(). For example, mmap() takes 1 second to load 4GB data, and mlock()
> > > > takes 330ms additionally in order to migrate all the pages into inaccessible
> > > > map, IIUC.
> > > 
> > > Oh, so the MLOCK part is right, but the inaccessible() part is wrong.
> > > Inaccessible is special weird guest_memfd crap that has all kinds of
> > > side-effects that you don't want.
> > > 
> > > Wouldn't you get the same effect by calling mlock2(MLOCK_ONFAULT) and
> > > then calling readahead() for the desired range?
> > 
> > Oh, thank you. Let me try.
> 
> After checking the code and experiment, I don't think that gives what we need.
> That flag skips populate_vma_page_range only, but we need to allocate pages
> in the inaccessible mapping and fill the pages afterwards.

Then either I don't understand what you're trying to do, or you don't
understand what the inaccessible mapping is for.  Is this just for
speeding up mlock() as you suggested earlier, or are you genuinely
trying to do something with the inaccessible mapping?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
