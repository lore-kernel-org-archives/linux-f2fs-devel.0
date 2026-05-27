Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033BACD5BD0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 May 2026 15:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Svwcs1ojNLBe76eZi6sjFGSt4hIjc/J1scB9GA7szd0=; b=OOOTIdGIpYXPGW9stdLQYXjXXH
	7MFQVlUu+/lc5yzXKA68IHRsCxI5ETSXdcAZBcfjLe9v400EtF5RLwiyR9Kl1W4+2PbC4QoqPd6LO
	Ns01HXLMCiEY0agtpi6QhEyOwngt6sk5vxcOnHRjuf5tJxOV1XReqrTWVDSCTzSUI3CE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wSGOv-0004KL-K6;
	Wed, 27 May 2026 15:42:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wSGOd-0004Jz-R1
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 15:42:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zMuKNG4HxYra3vlaS9CtWig32q9g8dK7SLHIEtEzN2g=; b=ZSkNZk2M6U2qPbKocCQNJttoKy
 pT5b/zAUoWPtNbMMGiMlNx7fkUfWhLaguqkeWVrDZJNdolt97Ux/HI/1T6bIHwB2iCrIUjgVtH67c
 R5zCxH1kGSnIyurzf83lmvixFZ0x2HSnWdIb8CCqgDTwBxqGIAL5K3zh7wK7p6PKbu60=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zMuKNG4HxYra3vlaS9CtWig32q9g8dK7SLHIEtEzN2g=; b=dDykJf7QocUWDnkq8rXjy6y+fo
 BIwwtxtiitflx2phk420614M05vsirINTYIwkDyJhPBksnj5jVP9wevw0JNwdOkXpwU1fj8KJXEPM
 VHrKdHILzIQInG2bdby1AwMBJk89iEg4yn3NNZmgWCCKI5+W9RzGAp0uz55IOMnA4t58=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSGOb-00008r-UX for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 15:42:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 159A441B27;
 Wed, 27 May 2026 15:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959161F000E9;
 Wed, 27 May 2026 15:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779896529;
 bh=zMuKNG4HxYra3vlaS9CtWig32q9g8dK7SLHIEtEzN2g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jRr7GJAhGlahPzN0bmeBXmtT0my8GCvw8BEnvoA0LHYmPZeF2NiGk/GoK4nW4iAI2
 ah3DD6/iXQ06gmV829oiq4bltVzTjc4l9q/dzZxerNzX0v35Ht2iMEHMJ2Emrqt67I
 MC9X0Ve2SmiTTeUv8lJORBTKQNvbigYOqlPLtBZtmWYaZSp8lVMgMDzjob8fkxb5hQ
 FvBEW+y9hVHlppwfRLE2LN/rhcRUt55KCb8XV4FkKz5AVg1tN2pOESYeRx/RNoE2m0
 aY4/qERt8Yjo9xLdjWHct8cXrh7SN9YUdfxwFBPRCtp+SF81vbpHlwAfuGPCj/WoLj
 oqBb9fXdQZb2Q==
Date: Wed, 27 May 2026 15:42:07 +0000
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <ahcQz9Z227RoWOFL@google.com>
References: <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag9D6_7dttbDGHZ6@casper.infradead.org>
 <ag_UsW_OrlXD9dWX@google.com>
 <ahBSXyOi9b1jxNkX@casper.infradead.org>
 <ahBii6bk0KbK_NHV@google.com> <ahPffhaOi2CBtWof@infradead.org>
 <ahT1nT3xsMGkyJab@google.com>
 <ahUF7HqSKFJ422bU@casper.infradead.org>
 <ahaOpdw7NgsWe8J4@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahaOpdw7NgsWe8J4@infradead.org>
X-Headers-End: 1wSGOb-00008r-UX
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Theodore Tso <tytso@mit.edu>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Akilesh Kailash <akailash@google.com>,
 Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 05/26, Christoph Hellwig wrote:
> On Tue, May 26, 2026 at 03:31:08AM +0100, Matthew Wilcox wrote:
> > > > And what are you trying to say us with that?
> > > 
> > > This means, high-order pages were used up by EROFS which sets large folio by
> > > default. So, I wanted to say the concern was based on actual data which was what
> > > Mattew asked.
> > 
> > This isn't that though.  What you actually need is to show that high order
> > allocations are _failing_.
> 
> Exactly.
> 
> > If what you want is large folios readily available, then what you want
> > is large folios used _everywhere_ because then they're easy to get!
> 
> Yes.
> 
> > If there's small folios in use, you need to reclaim a lot of memory in
> > order to reassemble large folios (it's the birthday paradox, similar to
> > the hash collision problem).
> 
> Yeah.  Although it seems we have an issue with > order costly folios
> at the moment, but we should fix this.
> 
> And f2fs really needs to up the game and support large folios fully
> so that we can run that kind of analysis there as well, without this
> all this is just piling hacks on top of other hacks.

Ok, I'll revisit the large folio support in f2fs, and try to revisit the
problem afterwards.

Thanks,

> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
