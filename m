Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16387C5B543
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 May 2025 17:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:References:In-Reply-To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qHLnCLnUdszV2P+Oce56QHdb7oBtbKZ1rLxavmsI8tg=; b=RjwV9XThUqPvEFGT+XRdOaJw7I
	3W//wBQx5zHL0b0lfhtqs6waMOtLCE0TRkfolfMGG1VoIO+r290d6Ifq1WDMFhO3aN2O3DEsiQJRh
	Z347Pn8H5p6E9NZ8o4hZiAM35UFI3W4NslSPi6tB/nbzzWLPgOUpWqM2H5OtYN7oA+3Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uL3XQ-0008NN-Qm;
	Fri, 30 May 2025 17:29:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1uL3XP-0008N9-FV
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 May 2025 17:28:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G3ktnaBCbtTT42SHebzkSODz/VCBwySMuiTJ/yHT1us=; b=EtsFNKktVWcA4i9Vz85qb47a5E
 ZmEIIrXifiJ9IxuXvO33Iv856GHyVzUPiXINmgsYFA+NgqLij5MT5OdFHoBpePrtnmDkZDNm9T9BM
 4+buUKvidKnwVNxCbyjnYkYxC17F8c9i3VHx+aHfQPPUNyyOUbMNCcYWeDwPkG+RTnBc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=G3ktnaBCbtTT42SHebzkSODz/VCBwySMuiTJ/yHT1us=; b=HwFYGNnaNxGUhbfuRXYbqWwmfB
 o5demAdDYzxG1c0zB/d4rYqtE4alRc3wTrw7E5sIw3SAyqYkXDELh3uB6indJcgn1iYkHdk4+N9LT
 LakTdywZm95ra7vvGCZpDUq7bMXP6MZQiHWLWkHRH0O+GS1Z03zQ1ZBgk8GByUXyFn3Q=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uL3XO-00049F-R9 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 May 2025 17:28:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 21ED2A4FB19;
 Fri, 30 May 2025 17:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BE3C4CEE9;
 Fri, 30 May 2025 17:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748626127;
 bh=CJv8XeOaSKZzbDemQJTWvxURny5ID3w1oNu4bbHZXW4=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=pfEtLLetyNELDcHHLdNITaCvubl6PlNBeheb1Uao6S2/VqLEJE4zmN9Vre7WU0G0u
 EFzU94T2UTG3utPFAxrl+i6zeBR8lP3jYgJbFxMoksKrv6KvhSDCjQt1Q6p4aZwe98
 PQpeLpeqfWwMAhHR8jo2SCr/FrBPzoeuvVxuhf5+KS+QOY7uLw17KqguJr0HdidcU+
 fg7gfzbamf2D8Ugp22K/nIa/I7eiLJLCF39ubsW9JugiKM0sQ195nFoUpjSdDT2OJT
 f5ESLNx4/2FjLbEaQ2pamj32CaKyLN4wunoxpjkdLs1eHKa25H483KoYNVaE0NuaXo
 2zxaZFbPQ8Pag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 70E0439F1DF2; Fri, 30 May 2025 17:29:22 +0000 (UTC)
In-Reply-To: <aDjQtZy0oknTlgmG@google.com>
References: <aDjQtZy0oknTlgmG@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aDjQtZy0oknTlgmG@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-6.16-rc1
X-PR-Tracked-Commit-Id: 9883494c45a13dc88d27dde4f988c04823b42a2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8441523f21375b11a4593a2d89942b407bcb44f
Message-Id: <174862616107.4033976.5337363842507357181.pr-tracker-bot@kernel.org>
Date: Fri, 30 May 2025 17:29:21 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1uL3XO-00049F-R9
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 6.16-rc1
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

The pull request you sent on Thu, 29 May 2025 21:25:09 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8441523f21375b11a4593a2d89942b407bcb44f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
