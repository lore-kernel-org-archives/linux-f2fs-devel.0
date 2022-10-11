Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9E2C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Oct 2022 03:43:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oi6Ar-0007LS-VB;
	Tue, 11 Oct 2022 03:43:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1oi6Aq-0007LM-Q9
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Oct 2022 03:43:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jSTExcuFIP/Db/EdiFhdo5RIkdNGcpj6Q84kZW9IO6Q=; b=kKrcLUFFXTTqUZ4TQIrPAMD8di
 sSi19jri4hhG4/yFgUOxRGaQRyVJrCpZ4m53Vsof4GahFS5YT1a4fXDJXkL2svb9Tz/Gj5N8D2u0y
 E+CnqLOXfmKU+qK57tg90QG56dBoet+MXKI1YyTqBo0DOrFKLTzHUWmRRel7PCAhrpwM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jSTExcuFIP/Db/EdiFhdo5RIkdNGcpj6Q84kZW9IO6Q=; b=c0NEQa5KB+oIrGJMlZk+QE7Dfy
 ldxrPA1/LubwK1PhlLRBwZDDRuoGXCTsO/DI+ZOVwWRmKSr/EwMsREBDvxvcVwXvPrW0elrSH8gW/
 VDiYeLvLm8utQ5bwSnhl7A1wlYk3WaFpvQjJv6qteMdPXkbJI/NBojE/T6DuVrtKm+SI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oi6Aq-0006l7-7w for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Oct 2022 03:43:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D48506106D;
 Tue, 11 Oct 2022 03:43:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46139C433D6;
 Tue, 11 Oct 2022 03:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1665459794;
 bh=V0Gw5eFHwWhdruihaitv8HhwZs38DRG6OiqYy/mi/y8=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=BuU7y0qhw5XwCtOFBiZDqVfxsJ0Jcvrr0Sfx5B1i3tQbbj5JLrYCkaoKvvKuOeTpA
 HImopIM49h8rYpzB3xkFz7WC95Q4fBGqdqtXuzKQl6e4ExnGKw+Chxxjaa2ClD1XUh
 VwDL89Ae+AiQbJnmSwKGsOqSOdzoyIVKPMgy2oqltoHye5pHA8sOkzJGyqNDjt8quI
 PZYj28ha1tDCnwDz/WmP2eqlAobT5Q02FpagTi6zvx7gUR8rsdFz42NW2+On9NHBbR
 hyrhutSpKPAMT13+yjqLvfCOntcZNFpKyiHFxhrx49XOwEYWXMtESW7two82X42FEI
 j56YkQEI6dsIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 3090AE270E4; Tue, 11 Oct 2022 03:43:14 +0000 (UTC)
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y0RV6kXCyXtqYuS4@google.com>
References: <Y0RV6kXCyXtqYuS4@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <Y0RV6kXCyXtqYuS4@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-6.1-rc1
X-PR-Tracked-Commit-Id: b4dac1203f39821c6119033cdeebcea83cf45786
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d170fe435e54cafa599a21521ea65fe9535f537
Message-Id: <166545979419.4678.7423127526476737144.pr-tracker-bot@kernel.org>
Date: Tue, 11 Oct 2022 03:43:14 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1oi6Aq-0006l7-7w
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 6.1-rc1
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

The pull request you sent on Mon, 10 Oct 2022 10:27:06 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d170fe435e54cafa599a21521ea65fe9535f537

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
