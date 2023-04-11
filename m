Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A41C77B6F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Apr 2023 16:58:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pmHK7-00077k-AK;
	Tue, 11 Apr 2023 16:58:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pmHK6-00077e-K4
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Apr 2023 16:58:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7oZZcUp3vFjkm0/WWzLsdBmvjJJ9vw72g75mgWvprts=; b=Y6UlR+x5YU6LpfDbYxY/mUPA5U
 uqW4qjz0F3ghRiNTwGl6xNRBi/rFd/Pfqb19P/YFcthz8AOimXjSCOiTlWNcz4ioBgUT+HEh8Upvp
 H8H0FfitGaZachrcnQIv1aCcGNKH3p1zMubGgue+YSwzo+Ek6QXCM3pVQSPJM8Z3YMMI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7oZZcUp3vFjkm0/WWzLsdBmvjJJ9vw72g75mgWvprts=; b=H6/LIqGlZHKat23WrQytAw51QK
 qRP9zM4PjOU6nFECFmnYMIpaJZKIqCwIyMZuqa0qth1WN5zzmTPtWa1m+Z/ZrZiNP5Mbw6v6JePj8
 dZiul+cDk250s1MyvVF3D159TtG9MFH5DCoQAiXe6J8DZoTAzq6HnFbGhFHthBMpIpkI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pmHK4-004G1y-UX for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Apr 2023 16:58:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8DD0362006
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Apr 2023 16:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4D4C433EF;
 Tue, 11 Apr 2023 16:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681232299;
 bh=PIuBueFuizxDxX4lJnpDE3pr3ApvuOEeLShaHwfYbOM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ed4aF71ezAFa0//i0i6fLWtruR3eUgmzyzzZVo7B7U++1fZqxukDN+qXRRRTL9hd4
 cZNQtNcTk9UKijEyNI586L4Qw1nItwW5XjeKtGZvVgkAhfBj+D8PFslSWjUNtW6Xws
 1bFHbTApAr0lrR1l114srXm8v2jmK3i9gWMevKEMrM0F+WQBLbEQ9zO0xMNFO0lncz
 p/yHdZ0cx7ItaJS0oN50mUB2vrS+mPfMH51IGC/C2nffdW+nOHta2l3MOa65EV+VWA
 9tWHW2ssE+9Yi7SORgriuMAdwRyQRsYc8pxsxt/9qc1hklt5DRdA/mrVg/mecA14m2
 MGqqyL08Cm1Eg==
Date: Tue, 11 Apr 2023 09:58:17 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <ZDWRqRgwuLpkR7qO@google.com>
References: <20230410022418.1843178-1-chao@kernel.org>
 <ZDRWdJxP6QzcIU7G@google.com>
 <b05d7ce8-ef98-a7ef-9873-4403ec0858c1@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b05d7ce8-ef98-a7ef-9873-4403ec0858c1@kernel.org>
X-Headers-End: 1pmHK4-004G1y-UX
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: remove folio_detach_private() in
 .invalidate_folio and .release_folio
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 04/11, Chao Yu wrote:
> On 2023/4/11 2:33, Jaegeuk Kim wrote:
> > On 04/10, Chao Yu wrote:
> > > We have maintain PagePrivate and page_private and page reference
> > > w/ {set,clear}_page_private_*, it doesn't need to call
> > > folio_detach_private() in the end of .invalidate_folio and
> > > .release_folio, remove it and use f2fs_bug_on instead.
> > > 
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > >   fs/f2fs/data.c | 7 +++++--
> > >   1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index 4946df6dd253..8b179b4bdc03 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -3737,7 +3737,8 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
> > >   			inode->i_ino == F2FS_COMPRESS_INO(sbi))
> > >   		clear_page_private_data(&folio->page);
> > > -	folio_detach_private(folio);
> > > +	f2fs_bug_on(sbi, PagePrivate(&folio->page));
> > > +	f2fs_bug_on(sbi, page_private(&folio->page));
> > 
> > I think we can just check page_private() only.
> 
> Why? how about the case PagePrivate was set, but page_private was't? It must
> be a bug as well?

Given the code, I think both are set all the time. My concern is someone is
not doing set/get properly. Actually, I got a panic on page_private() when
running fsstress overnight. I'm trying to reproduce it to find which bit was
set.

> 
> Thanks,
> 
> > 
> > >   }
> > >   bool f2fs_release_folio(struct folio *folio, gfp_t wait)
> > > @@ -3759,7 +3760,9 @@ bool f2fs_release_folio(struct folio *folio, gfp_t wait)
> > >   	clear_page_private_reference(&folio->page);
> > >   	clear_page_private_gcing(&folio->page);
> > > -	folio_detach_private(folio);
> > > +	f2fs_bug_on(sbi, PagePrivate(&folio->page));
> > > +	f2fs_bug_on(sbi, page_private(&folio->page));
> > > +
> > >   	return true;
> > >   }
> > > -- 
> > > 2.25.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
