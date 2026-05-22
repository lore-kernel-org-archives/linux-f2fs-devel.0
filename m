Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7CBCD5BAF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 May 2026 04:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4HYvLM7o+MFGXYMOgitKy5Vl72hOkDBhHtK0ozJzJOg=; b=iSERhi8DEfR5EPWMFCMNg1qO0I
	iFZabZt1006ne91Vtcc1Qc5zWWWETjWnF1EqdYnGmNtRPlktR+r0RqxXv2xP1dBOeYV3aNhUOQ2kz
	hbekk+kJn/m+uSqnZjETsSBxAztwOoQ03XCVEbtHP2zdKQr2OGUXAomYGgMloNjyoLW4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wQH5b-0004DQ-Fc;
	Fri, 22 May 2026 04:02:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wQH5Y-0004DI-Jz
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 04:02:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GFwLqtBegPrYOeSN0ye6SbCQz3TQv1Qmus2tJiQyxPs=; b=WZ8rU+pcCdkf1gBSuprkf4wvwl
 urD/+CPq9OGzNfuA30Ed3qVLSDgX629x7Ut/Mqnkws3rmrq0sExPJoy0iogGEP0/zLW1SnnB6gJqT
 KsDSkBKWKewErWhBtHj3CZCFlgBM0MnuZPFXVZ9mp3DA4kIIjNx0ZPEGoSKNMOs1toDA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GFwLqtBegPrYOeSN0ye6SbCQz3TQv1Qmus2tJiQyxPs=; b=mpvCQk8lmxnKmcZGJFOCSmQaGL
 Gs9LzbM6Z5SAhom+yEoS9FdIa7ExKfuTOD3sqm/fQA0plVEiIqtjGtFOjnUdyPjs1fQYtF4Np+t0z
 QzrMOAHmYtuuzagpqoMBh528N4pGaFDww48lzcPMDU7NML7SQ1i9TAhwGTM5dVv/33hQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wQH5W-0005o2-Ep for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 04:02:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E6676014B;
 Fri, 22 May 2026 04:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80681F000E9;
 Fri, 22 May 2026 04:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779422527;
 bh=GFwLqtBegPrYOeSN0ye6SbCQz3TQv1Qmus2tJiQyxPs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=V5U8pIq9CYVjKN1M26c9b9NKyxbKNnsst43BpYHw1DsITUIVizoffTmheov44CS5q
 RC4YKVuVcJV1HeIny7fKMAPNUaVudn/uTOVvE44fxeitC4tGQLrVW5VFS7IbGno+H+
 cT2aATaZRzZsglm4rt0Y9AF1jrW8fI5GyXvQw0rIyoOyDQW+I92HQ7KEz4K8PpOoiP
 83HyHOFnC80JpiUmO6zQ2C4JY4DUjKUow0IeN7OzXJfPEspGNm+1XkSkX6RsNMyFZx
 hWGUUq+V+NminNRePBFveQW0fsFFOrqS7G+6Qjvo70M6y6660opAlN7QRmJHAlwatb
 Ezhvlm7T0Nwlg==
Date: Fri, 22 May 2026 04:02:05 +0000
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <ag_VPae3w2z_SXD9@google.com>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com> <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com> <20260522035331.GE5937@quark>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260522035331.GE5937@quark>
X-Headers-End: 1wQH5W-0005o2-Ep
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
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Akilesh Kailash <akailash@google.com>,
 Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 05/21, Eric Biggers via Linux-f2fs-devel wrote:
> On Fri, May 22, 2026 at 03:32:39AM +0000, Jaegeuk Kim wrote:
> > On 05/21, Theodore Tso wrote:
> > > On Thu, May 21, 2026 at 01:51:08AM -0700, Christoph Hellwig wrote:
> > > > > You haven't sent a proposal.  This is a reply to a reply to a reply of a
> > > > > patch.  There's no justification for why f2fs is so special that it
> > > > > needs this.  What the hell is going on?  You know this is not the way to
> > > > > get code merged into Linux.
> > > > 
> > > > None of this got properly answers, and this broken interface now landed
> > > > in linux-next. IT is offloading a user.* xattr which is free-form
> > > > user data with semantics that are weird to say it very nicely.
> > > > 
> > > > All this was done against the advice in the mailing list discussion.
> > > 
> > > So let me get this straight.  This is a magic xattr interface which is
> > > not even persisted in the file system, but instead sets a 32-bit
> > > bitmask in the struct inode which disappears once the inode gets
> > > flushed from the inode stack.  And it uses a generic xattr name,
> > > "user.fadvise".
> > > 
> > > There's no way in *hell* any other file system is likely to adopt such
> > > a broken interface, so why didn't you just use an ioctl to set this
> > > magic f2fs-specific flag?
> > 
> > I went this route because Android heavily restricts ioctl() permissions
> > and we needed broader access for this to work within the framework.
> 
> It's straightforward (2 lines I think) to update Android's SELinux
> policy to allow an ioctl in all domains.  So that doesn't seem like a
> reason to not use an ioctl.  In fact this is actually a reason *to* use
> an ioctl, as it shows that ioctls can be allowed/denied independently as
> needed, whereas xattrs just use the file write permission.

Ok, that's also great news to me.

> 
> - Eric
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
