Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEA7EB64DA
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Jul 2023 21:21:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qH9vp-0003NG-0t;
	Wed, 05 Jul 2023 21:21:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1qH9vn-0003N2-4n
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Jul 2023 21:20:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ldx3M1Kfcnqy5MDSTrG6nNbs4jlsRugROs8esG6eKoQ=; b=Vq/8NrZWVU4V+akIiLedPIp+zM
 +soL1qEEA8QfNh491zcsqwpD5D0i8MSSypO9vgCJ05jo8hC2ByaE9JjW8JB4J4TVnm2yKI+pOTyub
 NRcPvxLEKhT7Vyc7nOT7ywhNu7apuyUYgaq2i/UdlkVwN6KsCE0c5bNhDQ6/JWAVsYMw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ldx3M1Kfcnqy5MDSTrG6nNbs4jlsRugROs8esG6eKoQ=; b=l5mwctXf/uXDqfyd5lIevBpWSD
 BmhFS6EqF8M6Zvi22vK+BatgmEcprJ9dpG6J9ubRfkr6+v9RlxZ55KY0MgICKxlCFGcOrMFyh1Lu6
 vCZrf2fsOkK6ky2ybsR86bJlAu2kmOwLIStXxDcZOtBcNZYxiSx/myQGwRA1u8WsLlXs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qH9vn-007bQs-0b for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Jul 2023 21:20:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B806F61767;
 Wed,  5 Jul 2023 21:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C24BC433C8;
 Wed,  5 Jul 2023 21:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1688592049;
 bh=KSgiO/w/Gi5NXxonRZeCrybTrwdp5GTmPjCEaLZp9uw=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=dM3sLTv5xiLxTWcS8VUHfw0GBXWGMhuZwtbHZPF0LNejko01hMWu8XEso0/Sjl1BL
 N39Hi6D6kwI+pD1ooVa6yBYqHAI7+UbAEZ1aPH5X6rqsxc0i/ZkUKviolAAKy4VoFH
 hPmZxY/dFyCyX/cJWHr8qjRoAqlt/EhhMKCSDYy+5U6Hddjs06TtqYKrf5u+Gekjfc
 0Sb9cyCgz74gBQjVpxK2++VP1O0jNG8flksONK9z6h/x42Oga56dBiyp/QxwAH/Efj
 USCyYQMJGSY7JW5AhvjvkVAHdeDOvlo6RPHFj6WRLkTDPVKFJXi0ojFIYhDUheJCLU
 ZFfHeimlMmbiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 0247AC395C5; Wed,  5 Jul 2023 21:20:49 +0000 (UTC)
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZKWuP6+mGdW/W0/P@google.com>
References: <ZKWuP6+mGdW/W0/P@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <ZKWuP6+mGdW/W0/P@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-6.5-rc1
X-PR-Tracked-Commit-Id: a6ec83786ab9f13f25fb18166dee908845713a95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73a3fcdaa73200e38e38f7e8a32c9b901c5b95b5
Message-Id: <168859204900.795.16142238222271277169.pr-tracker-bot@kernel.org>
Date: Wed, 05 Jul 2023 21:20:49 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1qH9vn-007bQs-0b
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 6.5
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The pull request you sent on Wed, 5 Jul 2023 10:54:07 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73a3fcdaa73200e38e38f7e8a32c9b901c5b95b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
