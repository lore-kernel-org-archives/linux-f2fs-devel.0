Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD1CCD5BB1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 May 2026 10:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fHvc1JgwthTlR7c6kihnWt/WMsKfpWl9CTmZNgbGWJ4=; b=FlCC89zOtKnZ71aMqsTcRzBxN3
	BRJRdR/xYAFjYxoOSiTxZAnO29MkM4Xg2NDjiVxKoskc3TIoWa7Jc4ciVdI3dp+hlk6VPx6XSDtr8
	V37pPd7wLQgrwE15yL8XtCbbUWZgO1/dI+0LZj99EqrHjfBDRyi18+R74J/FBh9pMhRg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wQMhR-000509-FG;
	Fri, 22 May 2026 10:01:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1wQMhQ-000501-9z
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 10:01:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:References:In-Reply-To:Cc:To:From:
 Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZUJJoHYpPqVRUhbcG+UWt+HVEM6K0BEVeHttssE5XbE=; b=moN2qMzSST09uDc2h85RVxnxMQ
 GHfxQZ6r6LHs88MvErASsG4P2uxvyaSQDnL5d84BAxC94Nv1urc7wq0QgwnObiWKJkDMskKowoiIS
 JDAIu3SY3OlEhfZChZOAlHKMhQKL4zll6d+eL8jmdBULQ6y7yXIEIH2SzC292zdzGzNg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Message-Id:Date:References:In-Reply-To:Cc:To:From:Subject:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZUJJoHYpPqVRUhbcG+UWt+HVEM6K0BEVeHttssE5XbE=; b=RAqSx9Ck/a1VED5H+dvPtY/qtL
 262BJEQ3cDxpI5fd2cPoWbaoQx6mtM19Y8wivp9Rf96AJeqD7yU9Ani+/bgVH6b8EMlADuU0AKpkN
 e7hxz1CNnndjUqjKWJAVxiOi6O17cxAfp6a3ChjWzGnSLJMTflbcfB2tiZ7FmkgCgVY4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wQMhL-00018A-MY for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 10:01:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CF44A437CA;
 Fri, 22 May 2026 10:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9161F000E9;
 Fri, 22 May 2026 10:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779444093;
 bh=ZUJJoHYpPqVRUhbcG+UWt+HVEM6K0BEVeHttssE5XbE=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=DuTE1gQME7Jx//aKkceOJJnFYFECfnCnzPz6WQ0+Dp1jSLdzAgLScIoL2da/3pkoS
 0A6vEGBqorCPVj6OCamZ8Tfap/3bnyQX+QmtZGZYeab5qlRw2+vKDqPID9QGVpxLq7
 fAkTaGwnH25Eid1nQdCkxa0+qwbaG9XTztNh48zJNgAVodlmZKw3AJPnuoto5YaBSi
 as7U27VbiP6G7JIBlfB9UHDpgqrmCMlnWiimFah3MEIvnkTcLPk+KFFH3eIUn6YIM2
 yMbsk5vo9eYS0GYxc+yq2QBSOhiM0zrahxQlsLXfMFeVAsL+oJMd1SzAOMET+BPVGu
 4g0lyvd0Kh0cg==
MIME-Version: 1.0
To: Eric Biggers <ebiggers@kernel.org>
In-Reply-To: <20260522035331.GE5937@quark>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com> <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com> <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan> <ag_OVwPF49LSZ7rz@google.com>
 <20260522035331.GE5937@quark>
Date: Fri, 22 May 2026 12:01:29 +0200
Message-Id: <20260522-popkultur-spagat-beziffern-00f57ebc8fca@brauner>
X-Mailer: b4 0.16-dev-05c9c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1901; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1DLZ37kHhU1rHpEQEUMqDeqagX+iutwlVMzplz9dpLo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQJaFa9032xQZB1ooTgrtQMj6mneF33Vt/Y9yTNLOL2p
 qCTQa1fO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbir8bI8LJK6YxQ3bHfec9e
 ue9dfSWkodnjwV+3YsOzy9zq2uxnnmZkuDmb/9RHxd64GRJ/ebK9ktU0E/gn7vSzNhBZq2mq05j
 PDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Headers-End: 1wQMhL-00018A-MY
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
From: Christian Brauner via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: Theodore Tso <tytso@mit.edu>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, Akilesh Kailash <akailash@google.com>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-05-21 22:53 -0500, Eric Biggers wrote:
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

Thank you, I very much agree.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
