Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE85FCD5BDE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 May 2026 06:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gkYQkp1xn/IiVkVJs++Fn3fdqyUaPUNPUrw0vsPiIJ8=; b=h1aovIIPPK5QM8c8GV/0m9IdFz
	33lOaVCogQEIMhs7i2xKpujm+4VQsESSswnKEc8twdG9ziTWcvZP1pLkiiqzPsEz9tvN22NY/UV5R
	rGLQSx8UqzEpcNSv2JIjlLVqJnikl2vxyS/RT/lwnItw5Zb+MCvSG5uP/v1F3NJq11WY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wS7jN-00088Y-4u;
	Wed, 27 May 2026 06:27:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+e9735a96feccf8b5d28d+8312+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wS7jG-00088C-ML for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 06:26:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8+XkHO39t4awUaNWWRttBXc0bFBVogyz9MOEaNzq0Ko=; b=YBDCOtarIV//54YsXVDXisoMyq
 v+Y01kHyD9YuQkGAtdiDTDcyqXvsPpBZ5xPymWFT58GgdednvuO6CBKIFUt9sOfyz7sPk6abwP0yy
 qfQnSNvkGuN/N5IwN7FetMAnR018Ca/OMo2bNf5OoWf1tnFOKu9u4UrO/Y3WmIETFUtI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8+XkHO39t4awUaNWWRttBXc0bFBVogyz9MOEaNzq0Ko=; b=VNYmLJX4WULtTLGeG4uwJKcoyM
 UWabhaeJXxJkIrUgnuYCDyVNHfE/uLK7CggjSvT4XtzoYvzKaOfKnVChgW43pqkBmbaFFy+9Wn/9J
 woBSzhMOx+LZpcXe10USyaRatbNaYEHy6XLHjRIT27tAK36/d8yoOIzuMRrn6SNBP9Yk=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wS7jF-0003GD-1B for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 06:26:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=8+XkHO39t4awUaNWWRttBXc0bFBVogyz9MOEaNzq0Ko=; b=oOdaSz4JzDOg+7gC5jF16HQGsX
 1mI1RwNcWbxdl0dt2+SrNDJko7kj/Xbtcn8RJd4xY8eNH5wiUNuZ5Af5Sn/UyQ5g5nNtD+1fgtXjk
 MrQ8HPP/p3A9eQnX7NzYbj68sfw171zIrY/jvQrXtTnm+ubXHYLLOOGAW/jp7q4RbrRxH0CMB0E4U
 ClthjAiJa7Do7xJpP8q3A2d/KQXxqRw/pbj+Y9kXsseteWmYh2uMIxNpxjjlnXVBgbUkUt6PgSQwK
 MoxMIsyFlNFIuIn2VHeoQJUANSe+aI+kPbznEt/2Hb5iudZSxKnuLFdpZsyQGkuFmadEMHFUO40dz
 PeNAEIxw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wS7j3-00000003Opo-11Tj;
 Wed, 27 May 2026 06:26:45 +0000
Date: Tue, 26 May 2026 23:26:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <ahaOpdw7NgsWe8J4@infradead.org>
References: <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag9D6_7dttbDGHZ6@casper.infradead.org>
 <ag_UsW_OrlXD9dWX@google.com>
 <ahBSXyOi9b1jxNkX@casper.infradead.org>
 <ahBii6bk0KbK_NHV@google.com> <ahPffhaOi2CBtWof@infradead.org>
 <ahT1nT3xsMGkyJab@google.com>
 <ahUF7HqSKFJ422bU@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahUF7HqSKFJ422bU@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wS7jF-0003GD-1B
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
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
Cc: Theodore Tso <tytso@mit.edu>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 Akilesh Kailash <akailash@google.com>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, May 26, 2026 at 03:31:08AM +0100, Matthew Wilcox wrote:
> > > And what are you trying to say us with that?
> > 
> > This means, high-order pages were used up by EROFS which sets large folio by
> > default. So, I wanted to say the concern was based on actual data which was what
> > Mattew asked.
> 
> This isn't that though.  What you actually need is to show that high order
> allocations are _failing_.

Exactly.

> If what you want is large folios readily available, then what you want
> is large folios used _everywhere_ because then they're easy to get!

Yes.

> If there's small folios in use, you need to reclaim a lot of memory in
> order to reassemble large folios (it's the birthday paradox, similar to
> the hash collision problem).

Yeah.  Although it seems we have an issue with > order costly folios
at the moment, but we should fix this.

And f2fs really needs to up the game and support large folios fully
so that we can run that kind of analysis there as well, without this
all this is just piling hacks on top of other hacks.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
