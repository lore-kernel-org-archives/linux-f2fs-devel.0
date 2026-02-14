Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C230CEF584E
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 14 Feb 2026 17:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:References:In-Reply-To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kgEAM8Jsoob7K0L1+Rpord6+6pXdnxNNyLrLk6cdS8M=; b=m4IhdvY7yT+R5CwlD+XiKZ3ROT
	pLru39S/+Gabp83UXCezTMXS3zQD0R/5Lfk516Vzda7quweN0UoCFf1nCfnaEPt7RROL0VwEaKtcB
	VdoWlJVGIJu/VGNT9Lto1Qt+406Vm9iKyaVNuf58/LHxXWcFCTorW8gQbEeYBzjp3e24=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vrJoX-0001iC-0O;
	Sat, 14 Feb 2026 17:52:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1vrJoV-0001i4-Bt
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 14 Feb 2026 17:52:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pAZeJDoq9jKKYbgmo+NG29Dc3S/DX9d1PfOPg5v3Rcw=; b=AiYNDck5OyWSnVecO7AkpajVOs
 tcYayWPCVyKmzD1dnq1UFyDAA7ytJTxUgjY5/qa0wBetAHja2mvwTu4gWXTKCm/mpHwMXf4E+o8ZR
 OymeAiOkwcYPNtIfVByv8qtjBhij1MuA0bSAovMKuMKao0J2g3VcV3ZFVUwWEC/XmWvY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pAZeJDoq9jKKYbgmo+NG29Dc3S/DX9d1PfOPg5v3Rcw=; b=B1PPsyo8t7RGZOKs9QD7fQegmV
 9J84nZIaKaJd7CbVgWAyhNSapUNUz8djmJWSjeWJiax09vn5jT6L8nAr3TVWe65aLHgf8ojxH+xN6
 YH4uBClcFJiHwWaqNJaVegIHWxVGuxN6JKQFvK+kbHAE9huAWCX4NpEmFFs/9R4LWjf0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vrJoU-0005Mp-Kn for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 14 Feb 2026 17:52:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1F52E43AB6;
 Sat, 14 Feb 2026 17:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A33C16AAE;
 Sat, 14 Feb 2026 17:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771091529;
 bh=qzaIwz+h83OUx9RLLADQ5QisACBiSoMil1a1Cd9pwRE=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=Pdun8Z526WbDSHqg1rdGpGwOW51uRhy8EiGTxNcqn6j3Qh7mCaOEv7+3DXt5C3c3V
 nFNq28gCBS06cSvMXgutqPFbQxvgOvxEfn5ILC1+sNysK3y1FC0Fp9J1lYL85cn+tN
 g/JrR7gRvdHObTs3I607jbiokvwG6TLeoWcTmJ9QmcB/xc6W3hQvKXumhH42CqMa26
 ZumCayil2d3+Ja6iXECyxjhLwmeMumxNhcPoM44dpZ6WAI7rNNGYWuW9b57LyzPO67
 +49cKg+wcWN311sv49g+Dso61eAQN14Lf5bEYotj/wS28tnjnozIYjWG9c18FoBw78
 NI78wS4wAefiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 855EB3930904; Sat, 14 Feb 2026 17:52:03 +0000 (UTC)
In-Reply-To: <aY_h1URe0wsXKl84@google.com>
References: <aY_h1URe0wsXKl84@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <aY_h1URe0wsXKl84@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-7.0-rc1
X-PR-Tracked-Commit-Id: 52190933c37a96164b271f3f30c16099d9eb8c09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e48a11675c50698374d4ac596fb506736eb1c53
Message-Id: <177109152225.2854784.15105552613870410078.pr-tracker-bot@kernel.org>
Date: Sat, 14 Feb 2026 17:52:02 +0000
To: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
X-Headers-End: 1vrJoU-0005Mp-Kn
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 7.0-rc1
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

The pull request you sent on Sat, 14 Feb 2026 02:45:41 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-7.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e48a11675c50698374d4ac596fb506736eb1c53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
