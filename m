Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C842C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Jun 2022 17:02:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o1stA-0003tA-36; Thu, 16 Jun 2022 17:02:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1o1st8-0003t3-Bh
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Jun 2022 17:02:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tXl9ykhxuvt1NonatURdosz6fn5xpieEmXQk28FScFk=; b=lrqG1N5iGWT2/KcqvbpobH6Oup
 6XHgZ3qGPpeXe/B0pDQl9V8NKhzTQeKWDLkNGarhreePmZvnevzOxCAy86lDXcPL96/cpXrljHHXf
 3KPgyv+j8eZL09gvP9vNDet6bzu+yNqFzkAzi4AvHejyMOp31gJEcv1WUgn+0q4m1R9Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tXl9ykhxuvt1NonatURdosz6fn5xpieEmXQk28FScFk=; b=cAywsiWjQK9SS3IyhlcwyXsNKA
 Ozhoz6ciMvqO+mCaYnQgZx7Vwh5LBMqc3uI52+Qg8619KcwijJ9p0foY92ENewEOZEm9scWLF/L7x
 IEVZ/6hA+XsbKTDvTsVsk0sQsg24hYL6eiDsqNLD/hqHFu0dV40ue8l9tVxKeJ/dwM8A=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o1st5-004LGG-PB
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Jun 2022 17:02:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 77CA5B8251D;
 Thu, 16 Jun 2022 17:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6488C34114;
 Thu, 16 Jun 2022 17:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655398944;
 bh=XnVv4J01sdGBe11MNJIXMTTsXg4laIcwwL1T++aKoAY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RcWyAlCr0j8hyWym7NRFXVgQcYDBVCnYdfXopAy+sBmRw59Ei3RFI86S6eWFdDkRw
 yOT53lW3zswSA6EgeLsI+M9SgidiiobkmfeZOTGQykdcqq5AfotbvsMRhxJl0W2WAL
 re7TJCh1n6zpyyoaDwTlno3Odx9bfybDVjTaBOnD79wgzONbGehld0Ekqp9uenrbot
 uDqE/JODSJK3lW7gZgdqMqzZUBUxswtX1s+G4XE65kvJhxp24jLjOJ32WTUDyMb7fh
 Gv/gFzgOEErxTi2NMfM6K8bao92r8awJaNRKVI5DfiUOA5/4OhD0S4SVvdTy9sAUws
 Sir100L21DLqg==
Date: Thu, 16 Jun 2022 10:02:22 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Message-ID: <YqtiHmFTbWyrueq8@google.com>
References: <YjjihIZuvZpUjaSs@google.com>
 <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
 <51cded74-3135-eed8-06d3-0b2165e3b379@redhat.com>
 <CAHk-=wi=Xsekgj7zfw_vpOM673CG24vznmz-yx9G05rWSAAYXg@mail.gmail.com>
 <Yjo4fg4HRzEVDr7o@google.com> <20220615201318.GA1194@bug>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220615201318.GA1194@bug>
X-Headers-End: 1o1st5-004LGG-PB
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 5.18
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
Cc: Waiman Long <longman@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tim Murray <timmurray@google.com>,
 Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 06/15, Pavel Machek wrote:
> Hi!
> 
> > > > AFAICS, the read-unfair rwsem code is created to resolve a potential
> > > > lock starvation problem that they found on linux-5.10.y stable tree. I
> > > > believe I have fixed that in the v5.11 kernel, see commit 2f06f702925
> > > > ("locking/rwsem: Prevent potential lock starvation").
> > > 
> > > Ahh.
> > > 
> > > Adding Tim Murray to the cc, since he was the source of that odd
> > > reader-unfair thing.
> > > 
> > > I really *really* dislike people thinking they can do locking
> > > primitives, because history has taught us that they are wrong.
> > > 
> > > Even when people get the semantics and memory ordering right (which is
> > > not always the case, but at least the f2fs code uses real lock
> > > primitives - just oddly - and should thus be ok), it invariably tends
> > > to be a sign of something else being very wrong.
> > > 
> > > And I can easily believe that in this case it's due to a rmsem issue
> > > that was already fixed long long ago as per Waiman.
> > > 
> > > Can people please test with the actual modern rwsem code and with the
> > > odd reader-unfair locks disabled?
> > 
> > The pain point is 1) we don't have a specific test to reproduce the issue,
> > but got some foundings from field only, 2) in order to test the patches, we
> > need to merge the patches into Android kernel [1] through LTS, 3) but, LTS
> > wants to see any test results [2].
> > 
> > [1] https://android-review.googlesource.com/q/topic:rwsem_unfair
> > [2] https://lore.kernel.org/stable/988fd9b5-8e89-03ae-3858-85320382792e@redhat.com/
> 
> Wait, what? Normally, patches are tested before going to mainline, and especially
> before being backported to stable.
> 
> If you can't reproduce issue on mainline kernel, there's something very wrong
> with trying to fix it on mainline kernel. You should not be merging untested fixes
> so that they can make it into mainline and then into stable and then into android kernel
> to be tested.

What do you mean "untested fixes" here? As Tim mentioned [1], this F2FS patch
resolved the issue in our Pixel devices.

[1] https://lore.kernel.org/lkml/CAEe=Sxmcn5+YUXBQhxDpzZVJu_T6S6+EURDqrP9uUS-PHGyuSg@mail.gmail.com/

> 
> If there's no other way, you should be able to backport those patches to android kernel and
> test them _before_ merging them. Android phones are rather cheap. Some should even run mainline
> kernels -- see for example Oneplus 4T -- if you don't need all the features.

IIUC, the point here was whether we need another generic rwsem API to address
the issue or not. [1] said some rwsem fixes couldn't resolve our issue,
and Waiman wanted to test another patch [2]. In order to avoid endless
tests, I decided to get some results from Pixel using v5.15 (at least) by
turning CONFIG_F2FS_UNFAIR_RWSEM off as of now. If we can see v5.15
works, I'm happy to revert the F2FS patch. Otherwise, we need it for
our production.

[2] https://lore.kernel.org/lkml/5acaaf61-5419-178d-c805-62f979697653@redhat.com/#t

> 
> It looks hch was right NAKing the patches.
> 
> Best regards,
> 
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
