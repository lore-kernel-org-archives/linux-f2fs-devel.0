Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2561DEB64D7
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Jun 2023 20:02:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qDsQC-0007hq-RQ;
	Mon, 26 Jun 2023 20:02:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1qDsQ9-0007hk-65
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jun 2023 20:02:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bMxghTiaAGpCLEG3hv9ycQ7E1om8y1JXRBsvy97yJDI=; b=OSjPQuNx/qI8VQSwZgkmcsmCvv
 Twl6PPzBhs4ngyntnlejJ/zMeBNICka/bz2416UToCjjwuvPqIEn5zP809SuVkOPogQCmwKwoVx3u
 OejaBzpqS63EamHs7qR8UhKrP7D9PnCEpm1iFDNLM23Km24KbAw/C9W10dzNC1wlfaRM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bMxghTiaAGpCLEG3hv9ycQ7E1om8y1JXRBsvy97yJDI=; b=FG4Hwn61VJCzxK3Q2MgdkK5btB
 HrZLHyOVV1LsCYgreqQCeFjE5cIV1HctJ///ekNetCqlb5XUz0HY4BXxvZI0prATRHSyqQCI663eI
 w/K/SGVgxKVFhXtqF90HUArXcYeAvfgGzq+BGr5lif97Aqdu7uW8XkQVHKRAvFP/4Omo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qDsQ8-0007rc-VS for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jun 2023 20:02:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8F9556122F;
 Mon, 26 Jun 2023 20:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDF64C433C0;
 Mon, 26 Jun 2023 20:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687809759;
 bh=NxxnjZZAxPhJTnl5+BHG9TFV/wjyN/XPRp2AViKTMf8=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=cMm8pK+d6eXxtRqk/jrRlOFhw7pPyCTXL/gbz7yWi5bWYEVwz1SmPBkhUZUxua+d7
 wvFQ7rzw9nzDHaiE0byDaUobvJGwXHItEG2kBEACEphBj8w5VpygisndylpLxHXYsE
 9eLytnF7Q8p2fttQKr1h5m3RkMINVGvlPC+oY5lEaJ2Lz3U1JbfUoyzJdspt4PeRts
 BVWqo+gq7BEciZToZTm7XkiUItTv0gNUqf8T0Bd9O/QmhIHPL9/6DP2KmrlWEJCM4e
 9D4bcc5iQV0TeHZTuy9p0e8VKMCMBJ1DuRFKsh7raLFy5lRr3E/9FNGRoOxYPQEyjC
 qCt+NuMB/AXdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 D6C75C43170; Mon, 26 Jun 2023 20:02:38 +0000 (UTC)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230626015415.GB1024@sol.localdomain>
References: <20230626015415.GB1024@sol.localdomain>
X-PR-Tracked-List-Id: <fsverity.lists.linux.dev>
X-PR-Tracked-Message-Id: <20230626015415.GB1024@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fsverity/linux.git
 tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: 672d6ef4c775cfcd2e00172e23df34e77e495e85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74774e243c5ff0903df22dff67be01f2d4a7f00c
Message-Id: <168780975887.7651.4555094720412338997.pr-tracker-bot@kernel.org>
Date: Mon, 26 Jun 2023 20:02:38 +0000
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1qDsQ8-0007rc-VS
Subject: Re: [f2fs-dev] [GIT PULL] fsverity updates for 6.5
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
Cc: fsverity@lists.linux.dev, Theodore Ts'o <tytso@mit.edu>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Alexander Larsson <alexl@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The pull request you sent on Sun, 25 Jun 2023 18:54:15 -0700:

> https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74774e243c5ff0903df22dff67be01f2d4a7f00c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
