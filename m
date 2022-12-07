Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB33C63703
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Dec 2022 23:09:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p33Xc-0002mh-86;
	Wed, 07 Dec 2022 23:09:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <mcgrof@infradead.org>) id 1p33Xb-0002mb-Qd
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Dec 2022 23:09:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UORhhcQqOaIvpRwHi0DMFterbhwvG2EXcBZ82YBwQMU=; b=Blzahlmri2nidA75xmayzLTntY
 4lZipgrUVLGwcU8qTkaCDamiR3bVQvxvFKy2X9xn+GbM/j5kNAvEUlo97vvsnfE7tcPzxI5n9/csu
 tMiqm4jDxFNwa733N1Cnjy7UgYvGlf0AUvWjr1DZ72t5titGJQ3/MeB2EIwstYVgN+4g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UORhhcQqOaIvpRwHi0DMFterbhwvG2EXcBZ82YBwQMU=; b=PxTIQvhn370gucJMKQMQT7W7VO
 fCxYc7V6dglNUcY/ICmLevNMTjTgoHUXf51Em9k8sz1vmYKW2cEi2OVMthVQFWQU0aoMBqOM4+fsS
 GsCDbiu0cOBXRGFUsRDg0eW8gybUkrM66yDxqHytCWz2TE9ZRKop2YvW05rVkWCJ3g7Y=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p33XY-009dVu-Sj for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Dec 2022 23:09:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=UORhhcQqOaIvpRwHi0DMFterbhwvG2EXcBZ82YBwQMU=; b=HB0cbntyJzwuDFdxDCnp+Vlwhk
 tSONA7EaFAT9b+ZkRhi8SCpbuaWYeyV5dX92dXFFQy0XLTwjZ8b+qZwY47nxK7r2JS3AhDY/Y2q18
 YQWeVOWuZLc56HAj71ksdMyTmxK6OQToCGUwu1P6WxiBWym+wp+/POSm1HgoJ8F5etqzNTjvaY9bB
 oumvoTFfM93KB+IZtwPw2qExrWTiQawM9qjY/9m+jEcmlrXCaa4To5UgSUoi6LVA0YsHiwMLJcwMm
 Txs6DUb29cPIuy/ivStLtb5yUJUpwXE8cCLBgzfJaZSs2U6XAo+6S6gBoGM5zgOeszjBtmgcza8E+
 ms0w9KNw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1p31Np-00CLcf-VD; Wed, 07 Dec 2022 20:51:14 +0000
Date: Wed, 7 Dec 2022 12:51:13 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>, Pankaj Raghav <p.raghav@samsung.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <Y5D8wYGpp/95ShTV@bombadil.infradead.org>
References: <Y4ZaBd1r45waieQs@casper.infradead.org>
 <20221130124804.79845-1-frank.li@vivo.com>
 <Y4d0UReDb+EmUJOz@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y4d0UReDb+EmUJOz@casper.infradead.org>
X-Headers-End: 1p33XY-009dVu-Sj
Subject: Re: [f2fs-dev] [PATCH] f2fs: Support enhanced hot/cold data
 separation for f2fs
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
Cc: Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, vishal.moola@gmail.com,
 linux-mm@kvack.org, Adam Manzanares <a.manzanares@samsung.com>,
 linux-fsdevel@vger.kernel.org,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Nov 30, 2022 at 03:18:41PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 30, 2022 at 08:48:04PM +0800, Yangtao Li wrote:
> > Hi,
> > 
> > > Thanks for reviewing this.  I think the real solution to this is
> > > that f2fs should be using large folios.  That way, the page cache
> > > will keep track of dirtiness on a per-folio basis, and if your folios
> > > are at least as large as your cluster size, you won't need to do the
> > > f2fs_prepare_compress_overwrite() dance.  And you'll get at least fifteen
> > > dirty folios per call instead of fifteen dirty pages, so your costs will
> > > be much lower.
> > >
> > > Is anyone interested in doing the work to convert f2fs to support
> > > large folios?  I can help, or you can look at the work done for XFS,
> > > AFS and a few other filesystems.
> > 
> > Seems like an interesting job. Not sure if I can be of any help.
> > What needs to be done currently to support large folio?
> > 
> > Are there any roadmaps and reference documents.
> 
> >From a filesystem point of view, you need to ensure that you handle folios
> larger than PAGE_SIZE correctly.  The easiest way is to spread the use
> of folios throughout the filesystem.  For example, today the first thing
> we do in f2fs_read_data_folio() is convert the folio back into a page.
> That works because f2fs hasn't told the kernel that it supports large
> folios, so the VFS won't create large folios for it.
> 
> It's a lot of subtle things.  Here's an obvious one:
>                         zero_user_segment(page, 0, PAGE_SIZE);
> There's a folio equivalent that will zero an entire folio.
> 
> But then there is code which assumes the number of blocks per page (maybe
> not in f2fs?) and so on.  Every filesystem will have its own challenges.
> 
> One way to approach this is to just enable large folios (see commit
> 6795801366da or 8549a26308f9) and see what breaks when you run xfstests
> over it.  Probably quite a lot!

Me and Pankaj are very interested in helping on this front. And so we'll
start to organize and talk every week about this to see what is missing.
First order of business however will be testing so we'll have to
establish a public baseline to ensure we don't regress. For this we intend
on using kdevops so that'll be done first.

If folks have patches they want to test in consideration for folio /
iomap enhancements feel free to Cc us :)

After we establish a baseline we can move forward with taking on tasks
which will help with this conversion.

[0] https://github.com/linux-kdevops/kdevops

  Luis


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
