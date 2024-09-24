Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF01CF9C6B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:50:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1stEMY-00042G-Hl;
	Tue, 24 Sep 2024 22:50:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1stEMW-000429-Gn
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Sep 2024 22:50:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CSyBrRd5LmHSO/YdQaz5edlUqdnGi6YJOhHTeBQdWaY=; b=TIJyTVJI3KYKUiuN5O8CxI0SjM
 MoZDOBvDp6v5Ak6nI/OeNDvdfmRu/XKFHl1Ab0xgU738dQUtkJ8zkQcoaVT8s7N2CupDuCUrzIujS
 QrPOK1m65Dkupk8IIK/Sqf3ReBl0IUy3F26xjMzLC3xMOfBjusFCnMKQP5NG9usVM9Qg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CSyBrRd5LmHSO/YdQaz5edlUqdnGi6YJOhHTeBQdWaY=; b=QgPtQrB9FwSzTX8NmNzgiC6MY+
 Tld76s1qwsRI3O1jE9QoPavUkuTrdBzK6nAeQ4YzpjEuG7gsnqz/PEwxIWjqiBLtp2rddN9WsW1/j
 BkXx2ppvJiOmMsMoIx+SeDPeiau5mwufry1edTgkqJbrajBoL8ceugJ+6fzdtQexDfLg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1stEMV-0004qH-VU for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Sep 2024 22:50:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 197035C0266;
 Tue, 24 Sep 2024 22:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDC0C4CEC4;
 Tue, 24 Sep 2024 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727218216;
 bh=qkMkr0ApyqQAu30cC3Pg77vlyo7ZToman0ybIaWHkUM=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=lPIRLJoEoBy6PFfCV3pQ+5PRd2XYfZ7YWy1GV9zApX44C7r4K9WQGImTDLiJ3E9CK
 3ljPO1IacAWKgHZXp+XtxFXzeLyh2kLspL4JbH5oo+wO6y/lX3f26txLt0Pg5N38Ig
 THXi4Taf4JT0ZrBmg4cWOMzz4FvK2ue4ta23+gKiF+3AuryLIRsXq9MZoUnNYnxOEW
 kS3xmmXwrUnkuK/yBR1Th850cGFFdNFT8ynzYhmnh204KbCaBaTZRudpHC6YWof069
 Pg9rHso64Q+RjEJOP8ixew+c5mU54JvSWERlYjSh7zNfQXihOZh5LOhE7bZwjW7Vjp
 5Ub2hZwKetJZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3497D3806656; Tue, 24 Sep 2024 22:50:20 +0000 (UTC)
In-Reply-To: <ZvInHczHWvWeXEoF@google.com>
References: <ZvInHczHWvWeXEoF@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZvInHczHWvWeXEoF@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-6.12-rc1
X-PR-Tracked-Commit-Id: ae87b9c2dc9800e6ab52febd09341140599ff8e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79952bdcbcea53e57c2ca97e7448f8a6bdb6106a
Message-Id: <172721821882.30034.5554297247733064420.pr-tracker-bot@kernel.org>
Date: Tue, 24 Sep 2024 22:50:18 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1stEMV-0004qH-VU
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 6.12-rc1
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

The pull request you sent on Tue, 24 Sep 2024 02:42:37 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79952bdcbcea53e57c2ca97e7448f8a6bdb6106a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
