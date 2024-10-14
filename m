Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E74D1813E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Oct 2024 19:23:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t0Qeu-00015l-Lf;
	Mon, 14 Oct 2024 19:23:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1t0Qet-00015e-Io
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Oct 2024 19:23:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4ozTeIaCff/tm3Au9HrkgFg98UeFNhet4fcrXiNOy4Y=; b=c1mD1cT2TyPe2ycRG25gFyvWYO
 cZ+Wu4LFnCrUVpRg849/rz8iMGO6ilXvp/tZQ2B9F4WiVpSzVpn+OmmvChl8a9oUbSvCOs+3+eIWT
 JIzLDeux61WUkg79hVccxlqpuuSY9TwgQCho6apWmBCUqT6q+jb61vVIdN4BpS6G6fKs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4ozTeIaCff/tm3Au9HrkgFg98UeFNhet4fcrXiNOy4Y=; b=mKe9rfgbCaZwcrusB9kp1bDTa7
 CRkqOggKPdiiNN2fWkg1+6ZBtUi4kGoll4cnAMowJPda2YixBh9UxV21C2dm9pJy7MU1nTC5jw8PC
 LfDUl2vQlK5KipNHLtcW/aZVtW+Bid6K7xUGMAj89hyPiujnhMxLXabthGTL3rULeedo=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t0Qes-0001Jc-UV for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Oct 2024 19:23:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 51229A4276F;
 Mon, 14 Oct 2024 19:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF26BC4CEC3;
 Mon, 14 Oct 2024 19:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1728933779;
 bh=giUBMqMhM85p1VFJtS/IemvmIo6qlEbJRvocNKG4rfI=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=tSN1BIuKZAkZA5H1YVMqw+tZi1Qvft6dkpwjj9HArLxJfOJb1TfMPn5q5xIW99UA3
 YzyXNHtmYCOoJU0SoVKZKwAjxqnM41TmpmS5JR59NkZtGhGuvSqVX8i8oeUf3+IW2g
 vmy4MLzwfZ9rrXBo4NW63lY4TgtQQdCkNTIXAAAxmB3wOa6p6xErjY2fMVq/ADeF0K
 iKAY5LzyL9wObzYH342XRNZDsci5veWVFZABpsSQxeUqqvrJAf3Xn/hCyWvkCEzfxR
 JJr6M0/v4UeshApCcaKGhZi6dQ/00AeJqiiB0IThwcqYHZu+sVITLZbspTMEpMpM7Y
 +XKBuoMq4I78g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33EAD3822E4C; Mon, 14 Oct 2024 19:23:06 +0000 (UTC)
In-Reply-To: <Zw1MHWwr3fRgJpLr@google.com>
References: <Zw1MHWwr3fRgJpLr@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <Zw1MHWwr3fRgJpLr@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-6.12-rc4
X-PR-Tracked-Commit-Id: 332fade75d0ecd88cd19556fce0f9cc8322de434
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eca631b8fe808748d7585059c4307005ca5c5820
Message-Id: <172893378472.615880.2394948685073284795.pr-tracker-bot@kernel.org>
Date: Mon, 14 Oct 2024 19:23:04 +0000
To: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
X-Headers-End: 1t0Qes-0001Jc-UV
Subject: Re: [f2fs-dev] [GIT PULL] f2fs fix for 6.12-rc4
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
From: pr-tracker-bot--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: pr-tracker-bot@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The pull request you sent on Mon, 14 Oct 2024 16:51:41 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-6.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eca631b8fe808748d7585059c4307005ca5c5820

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
