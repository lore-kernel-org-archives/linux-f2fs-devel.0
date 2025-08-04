Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7848C87FCB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 Aug 2025 23:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:References:In-Reply-To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BuaQoOOj52jQqz81DHuvcTokeKf8Q0LzalgJb57m37A=; b=ThXJoKG/Z5uyJQKUEUZEl41c19
	eU4HYIEzm6+ekbaF7Mein+fIDOzzrZXKrY4zEfxHXFesSwEn33hUOA286/FklqJHkoXyonjv47HMM
	oXaShpTep9CzfWSC4ZX5ROcsJ5WPc7ilX5QneoeSUCGYKk6x+Spr0g6n+7GPtKfBcEos=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uj50W-0001dL-Gg;
	Mon, 04 Aug 2025 23:54:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1uj4zt-0001cU-MP
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Aug 2025 23:53:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TT5srqwh7f16WBz+9tEeMxLqDBTHJjJyub0dDtCqCJA=; b=MkdzJmdAw+6qg1+FJLw2U70m/R
 oHXh7rdy3K0u7og9QMzRLOQXhencdQR5XL+fZw4xOm7+K9GlSLimJRWHjfNtILnQybiPkl027Nix4
 gmJj/4hxDPfMamQndVRUWPlRx54guB3j08e6HrROvYowosH4govVuA5LPxmLhxELDCmk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TT5srqwh7f16WBz+9tEeMxLqDBTHJjJyub0dDtCqCJA=; b=gwGeAYHusaPWtxq665yUfiAXoO
 p//GSrc3LyzH+HTQ6OwlhzSjCP/oX+SeE8czcdEyeYJ0Ye6QHRaOPDIC+pNIW+yP3PvONE2g76xFs
 +agoG4jegCigxjc9IveuwkWjIzDdF32s+H2asQq2R6VM3zJnUY/0GTmnAFYT6WZVvoNY=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uj4zt-0007aA-64 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Aug 2025 23:53:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 86438A559DF;
 Mon,  4 Aug 2025 23:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3050CC4CEE7;
 Mon,  4 Aug 2025 23:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754351615;
 bh=mYMLftyAT8QXp0pXfjxxCAHPluo5qRTQ7BK2PGulMz4=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=pWUR/4ntzrt6aPvlJU/A+kV02XbL06YkOXCFeip1pO2r5EUlZtBfbYzGW3Vl26ynl
 Wa0IzrzM7ZWNkusbsSNJVNlOLYwK7ZDxmtoYSGOZe/qUkiCVG8Bq4KA6sUP4YbTP/T
 /Q8B8q2U2Uks1t470+aHmQhDhHGx0B5z2bESefhFozpEGRD2l1Xbz4H6RJyGN758f1
 FamAGY2z9pYWhYVce4Wl7KPj7Eg+Xw7B4eXAbYp53m4OGETwPl55g4iuHma3KkZZO3
 r63AATYAzaZ3Ls3QEzsrjBrBBtxcNP2HfQoYYXENEqx7Y0doVuZc6+DOqZsPushyW4
 n3VCEhwKkeo3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 AE189383BF62; Mon,  4 Aug 2025 23:53:50 +0000 (UTC)
In-Reply-To: <aJEosjoG_mD0OgwK@google.com>
References: <aJEosjoG_mD0OgwK@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aJEosjoG_mD0OgwK@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-6.17-rc1
X-PR-Tracked-Commit-Id: 078cad8212ce4f4ebbafcc0936475b8215e1ca2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0974f486f3dde9df1ad979d4ff341dc9c2d545f5
Message-Id: <175435162930.1391353.4549206550965638397.pr-tracker-bot@kernel.org>
Date: Mon, 04 Aug 2025 23:53:49 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1uj4zt-0007aA-64
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 6.17-rc1
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

The pull request you sent on Mon, 4 Aug 2025 21:40:02 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0974f486f3dde9df1ad979d4ff341dc9c2d545f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
