Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E05CD4F5B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 May 2026 03:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FGzJFq7ngC1t8QFXG7PmGlCyCZSCI9CJ6rcNtVx7Bz8=; b=aGR1dWc8OpRmJSbqCnEsxKs22G
	1vAEP692PxLdAsP43ExyQJyFyfo0L3U9L/Bz/SxHo/2Uj01hSvDUItnPvmFvFmYvDXQYvUOKBA8Gb
	aKYK24JuVtePJQJEptlTZc7PIjBIYUgLfdMQRMoch8hpxM695chJofgc7dbWRrfrkt5w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wQGxI-0006Q9-2g;
	Fri, 22 May 2026 03:53:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wQGxG-0006Ps-5J
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 03:53:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kB9u/fd5oqOyzn/d56rzTMKcyf+Gut0U9mtxblKihAQ=; b=IHZsAAlg0J0a2xYNp01dd2+14s
 6ePRDWCpdf6ci8nkLzlkX/6Atqvt7Ip9T3bcPb1DTmNbxhOlSGXZryoA4KLZVtDRleuYUewvNOMl9
 ugq3vN/s60dR93ibYyYClslDF/9RevY2jupJPxNFHezgsKKAuaNpSac21smPs0VG240o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kB9u/fd5oqOyzn/d56rzTMKcyf+Gut0U9mtxblKihAQ=; b=m35C5Mw656fM3kGiZ/kXCnRJcS
 zg8toDVcRWm9gjWTzv4Yy2D6lIJJWcnBDETOuk4ZSAzDyOgXwdd/UgWisEdBRAoYslyj8jweWoUjn
 sjXX3V9899L6T2IetQuxMT5WygaRj7LaymaDXcsGn00WxpAxWwt5UHZTfTDUqGRTnBlg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wQGxE-0005D7-Qo for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 03:53:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6502060136;
 Fri, 22 May 2026 03:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CA61F000E9;
 Fri, 22 May 2026 03:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779422014;
 bh=kB9u/fd5oqOyzn/d56rzTMKcyf+Gut0U9mtxblKihAQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fld1ypw9APN84jvJm1OOVi3+ZHhpiCqzC8QK3ifg0qLQZgEH8RQwQdH9O+qgnCYrc
 Sl4P80xhdmTewu6/ueUPwz49MOXYxB6UBItK5OTQ0jNrXM+RhuWFzcbq8/AWs+iJAF
 sWwz/T9UUHbDSE6lBJmFzuV/C0rrwCCV/lVPg4G1C8T1NTPTVkDkijsvMe8RDW8nZA
 LZLL7Urvwe4SUWrAFQbjev8VcLMOGCOX2SkHENYXY+5glXf5Ca4NrlNsci9Of0Z5lp
 wuu95IWJCelZn/vv77Jo3iZBmgg6TAwqcTk9PAgwVxz35w1q73aBen2fJCrKohTcUa
 sPyncu6PC/Yqw==
Date: Thu, 21 May 2026 22:53:31 -0500
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <20260522035331.GE5937@quark>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com> <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ag_OVwPF49LSZ7rz@google.com>
X-Headers-End: 1wQGxE-0005D7-Qo
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Theodore Tso <tytso@mit.edu>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Akilesh Kailash <akailash@google.com>,
 Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, May 22, 2026 at 03:32:39AM +0000, Jaegeuk Kim wrote:
> On 05/21, Theodore Tso wrote:
> > On Thu, May 21, 2026 at 01:51:08AM -0700, Christoph Hellwig wrote:
> > > > You haven't sent a proposal.  This is a reply to a reply to a reply of a
> > > > patch.  There's no justification for why f2fs is so special that it
> > > > needs this.  What the hell is going on?  You know this is not the way to
> > > > get code merged into Linux.
> > > 
> > > None of this got properly answers, and this broken interface now landed
> > > in linux-next. IT is offloading a user.* xattr which is free-form
> > > user data with semantics that are weird to say it very nicely.
> > > 
> > > All this was done against the advice in the mailing list discussion.
> > 
> > So let me get this straight.  This is a magic xattr interface which is
> > not even persisted in the file system, but instead sets a 32-bit
> > bitmask in the struct inode which disappears once the inode gets
> > flushed from the inode stack.  And it uses a generic xattr name,
> > "user.fadvise".
> > 
> > There's no way in *hell* any other file system is likely to adopt such
> > a broken interface, so why didn't you just use an ioctl to set this
> > magic f2fs-specific flag?
> 
> I went this route because Android heavily restricts ioctl() permissions
> and we needed broader access for this to work within the framework.

It's straightforward (2 lines I think) to update Android's SELinux
policy to allow an ioctl in all domains.  So that doesn't seem like a
reason to not use an ioctl.  In fact this is actually a reason *to* use
an ioctl, as it shows that ioctls can be allowed/denied independently as
needed, whereas xattrs just use the file write permission.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
