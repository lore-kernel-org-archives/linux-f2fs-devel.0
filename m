Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D883ECD5BAC
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 May 2026 09:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jyt6VOMjMrNjofCmtYl63N+xFiugfluqXFihFbi2MVM=; b=PFTNHW/Wdr2L9//8X8yXxH1lmK
	bVWFP3sTTpWoeuiPveLckH6/VmA9NC9Kmj/m76zjdEYaL56e1Mq/o9BQr+QLvslOsFlGuW6PSyl6r
	kdxwo0hxBoIK6LLZCDDIFtt7lLmG95A5iPNdiiaTCEZOr3H8c3YvS9ivn70pHxNWzzbk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wQMfX-0008Pt-9d;
	Fri, 22 May 2026 09:59:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1wQMfV-0008Pf-S8
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 09:59:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:References:In-Reply-To:Cc:To:From:
 Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8p0T4HNyPt2rtXXItCwHLCB30PYbM6+SRmeDyHpW9cw=; b=QkVmMxdb4APjK7QD45/WZ57IDc
 1lF3K9qC/TnF+//dnAlFMRXVkf0IwIQiVXoCAw2K2hJn5ro10P7bwOA5aPOE9Dge/UBfkfAOoSStj
 04ldx2uozMil/22RPn5y/ZD+xeSp88dP0thZtbxdJMDwfRiXzFbV/A4X0FtziaHp9IvU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Message-Id:Date:References:In-Reply-To:Cc:To:From:Subject:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8p0T4HNyPt2rtXXItCwHLCB30PYbM6+SRmeDyHpW9cw=; b=aUD3rgH0zf/l7Gwd+BnRAgz93f
 /jCHgVDcwvmMdY8STiNa+icmZj49tWT558b3LZ8qq/gkb1WYfV75v3ft1AUlgfc/ut0EWq5ZpM9/F
 gFHIBHGPrfe0zT04Ee8ppTwfF5cvpFXXuY410ADofsgoKB0P95u7hUZJPtG27uhmKi2U=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wQMfU-0000xm-EH for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 09:59:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D240B60136;
 Fri, 22 May 2026 09:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3190A1F000E9;
 Fri, 22 May 2026 09:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779443977;
 bh=8p0T4HNyPt2rtXXItCwHLCB30PYbM6+SRmeDyHpW9cw=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=KqGHgDrZsdOsieHVKysVXhcHgaodUEd3YW69EUjImDXu74JlBtzE+02Vun3dI1EPC
 9AdaM39GaGHFsm4W9fje1kSJnTeI+Bgsu4DfNFhXFRRQswSpxfNVxRjlw+HPqz8sa/
 1HeGG9B0JdvT705Ndutn8tb1FsaJdTsnGAPsQEzuEIr4WQk2TZmKtWrniq+cHcTEx8
 +h0XvbKl5qLScCnPomNuOS4jDsAhdrG9mZFrMkOd0T7N9F6zInDzfA3I4No0vUpmID
 Z9fCZ9Pgd1wPc4NJyYicruwHkBPpuI6VQbfbdi5lE4IS4inSNUq/8Kh3FFnJ45Y8K5
 S8PGC+EW4gutg==
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>
In-Reply-To: <20260521155748.GA79343@macsyma-wired.lan>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com> <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com> <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
Date: Fri, 22 May 2026 11:59:32 +0200
Message-Id: <20260522-stollen-fabuliert-helium-82376a109c5e@brauner>
X-Mailer: b4 0.16-dev-05c9c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1846; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YuVuEhwaHMb0Ugfecndd7/67rNAO5cvP1w5w6tDsGuw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQJaLJ9nsafzv/su3jKF497K1aGzw071/TmS38665l8H
 7/wtEWfOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyq5Hhf5qa1v/j2cyaK90u
 /pascZaX+2H0V3tm+4TPG0169h/25mJkeHl/+epvi1jLAjit1KbOXmerZxfQYFh8/urqWXN0vb/
 w8gMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Headers-End: 1wQMfU-0000xm-EH
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
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 Akilesh Kailash <akailash@google.com>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-05-21 11:57 -0400, Theodore Tso wrote:
> On Thu, May 21, 2026 at 01:51:08AM -0700, Christoph Hellwig wrote:
> > > You haven't sent a proposal.  This is a reply to a reply to a reply of a
> > > patch.  There's no justification for why f2fs is so special that it
> > > needs this.  What the hell is going on?  You know this is not the way to
> > > get code merged into Linux.
> > 
> > None of this got properly answers, and this broken interface now landed
> > in linux-next. IT is offloading a user.* xattr which is free-form
> > user data with semantics that are weird to say it very nicely.
> > 
> > All this was done against the advice in the mailing list discussion.
> 
> So let me get this straight.  This is a magic xattr interface which is
> not even persisted in the file system, but instead sets a 32-bit
> bitmask in the struct inode which disappears once the inode gets
> flushed from the inode stack.  And it uses a generic xattr name,
> "user.fadvise".
> 
> There's no way in *hell* any other file system is likely to adopt such
> a broken interface, so why didn't you just use an ioctl to set this
> magic f2fs-specific flag?
> 
> > I think at some point we just need to stop taking f2fs updates likes
> > this.
> 
> Well, that's ultiamtely up to Linus.  I'll say that if I were Linus
> (and I'm glad I'm not :-), and I saw this in a pull request, I'd
> reject it out of hand.  But whether it's worth making a huge fuss and
> asking escalating this mess to Linus, we probably should get a bit
> more community consensus before taking such a drastic step.
> 
> Christian, since you're one of the VFS maintaienrs, what's your
> opinion about escalating this to Linus?

I think we don't need to involve Linus.
The interface as is is broken. Using xattrs for this makes no sense
whatsoever.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
