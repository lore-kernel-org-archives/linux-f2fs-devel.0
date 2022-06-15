Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E720AC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Jun 2022 20:31:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o1Zfp-0005oZ-Jq; Wed, 15 Jun 2022 20:31:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <pavel@ucw.cz>) id 1o1Zfe-0005oK-K7
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Jun 2022 20:31:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NBOSxsjf4geWyn3kqFG32w9bSdjm0Pf2RMJqTf6FUps=; b=T47tXBzb8NfUhEnSjZhaCJ9EgM
 HiTPs1CDKcGB24IQzVmchqf5doG7NihfAUMFXqrXsDO3adICE2x1/9wUthDWzrJyOHLYSh5fRCNhY
 MpXNWpzsU7CfdNeQJkqeza5UPA5CvIOhrvt+zngcEAG+FCP1Knfsy1GjVfTF1JRZsVeo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NBOSxsjf4geWyn3kqFG32w9bSdjm0Pf2RMJqTf6FUps=; b=UXLpJS39Q1km9Q8o1UPwXuPhCT
 +EiWe1C3g6cBtyAz0q2VsmwKofA962CCxYrSmSf4xzqXrBm+J+Upq1QTyKA0NkADdBLgYVExEUVbh
 g5i4H3KUFP293883ADO6pR2VqcysIk5TQOhfaWaHZ+eBceK9YmT0zqHw5Cubkro2E1uo=;
Received: from jabberwock.ucw.cz ([46.255.230.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o1Zfb-0038iJ-Ew
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Jun 2022 20:31:23 +0000
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 08FE01C0BC7; Wed, 15 Jun 2022 22:13:20 +0200 (CEST)
Date: Wed, 15 Jun 2022 22:13:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <20220615201318.GA1194@bug>
References: <YjjihIZuvZpUjaSs@google.com>
 <CAHk-=wgsmvoJFKFWxQ2orEVUOWH1agk9iUNZ=-DFh5OXZL=Ldw@mail.gmail.com>
 <51cded74-3135-eed8-06d3-0b2165e3b379@redhat.com>
 <CAHk-=wi=Xsekgj7zfw_vpOM673CG24vznmz-yx9G05rWSAAYXg@mail.gmail.com>
 <Yjo4fg4HRzEVDr7o@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yjo4fg4HRzEVDr7o@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Headers-End: 1o1Zfb-0038iJ-Ew
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

Hi!

> > > AFAICS, the read-unfair rwsem code is created to resolve a potential
> > > lock starvation problem that they found on linux-5.10.y stable tree. I
> > > believe I have fixed that in the v5.11 kernel, see commit 2f06f702925
> > > ("locking/rwsem: Prevent potential lock starvation").
> > 
> > Ahh.
> > 
> > Adding Tim Murray to the cc, since he was the source of that odd
> > reader-unfair thing.
> > 
> > I really *really* dislike people thinking they can do locking
> > primitives, because history has taught us that they are wrong.
> > 
> > Even when people get the semantics and memory ordering right (which is
> > not always the case, but at least the f2fs code uses real lock
> > primitives - just oddly - and should thus be ok), it invariably tends
> > to be a sign of something else being very wrong.
> > 
> > And I can easily believe that in this case it's due to a rmsem issue
> > that was already fixed long long ago as per Waiman.
> > 
> > Can people please test with the actual modern rwsem code and with the
> > odd reader-unfair locks disabled?
> 
> The pain point is 1) we don't have a specific test to reproduce the issue,
> but got some foundings from field only, 2) in order to test the patches, we
> need to merge the patches into Android kernel [1] through LTS, 3) but, LTS
> wants to see any test results [2].
> 
> [1] https://android-review.googlesource.com/q/topic:rwsem_unfair
> [2] https://lore.kernel.org/stable/988fd9b5-8e89-03ae-3858-85320382792e@redhat.com/

Wait, what? Normally, patches are tested before going to mainline, and especially
before being backported to stable.

If you can't reproduce issue on mainline kernel, there's something very wrong
with trying to fix it on mainline kernel. You should not be merging untested fixes
so that they can make it into mainline and then into stable and then into android kernel
to be tested.

If there's no other way, you should be able to backport those patches to android kernel and
test them _before_ merging them. Android phones are rather cheap. Some should even run mainline
kernels -- see for example Oneplus 4T -- if you don't need all the features.

It looks hch was right NAKing the patches.

Best regards,

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
