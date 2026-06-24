Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD35DCD4F26
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2026 01:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:References:In-Reply-To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2qeIhqcgZvQnSF3Oig3kW0z6i0gQYtG3A4CAcQNkziY=; b=fTlUMPuLDOZiXnOt+nArO2PHEq
	g+PyRfU7QEVIKY6wsDkQJeWlF2b3/pcz4ftqtWzabJDLeu+e5VdI8LTN3g+lObSihEp7HvEWtBW7s
	4wN4wO/MkoEv537OaRIkIjhmtQ3Bh+JFkrX3hoX3ATN4I3RkT9KnUbLLglkEPm1o5moI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcCmN-00007C-Mc;
	Wed, 24 Jun 2026 01:51:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1wcCmM-00006y-8S
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 01:51:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fAO2JeiSojqrbF34Es/gkv0pM3UixrmG8s10gKD+H2g=; b=XyWqTd8I265FygZf2jfJDwRr69
 QiWMJSBlZPN2uKIc/dx6ouM3S1tdk54gTsMoJDKjkL81dY2ZFRilV0qh1OJLZTIZM+w6vcNPmmHh7
 +hb0Q0U/mLKJZSqRgPJFLw480IxUwyEEZrsZUXuZNyakCCWzeiDlL/E6DUm1O67wbH0g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fAO2JeiSojqrbF34Es/gkv0pM3UixrmG8s10gKD+H2g=; b=bJH1L7XcXgBe7ngiNlgp2gMZ8Q
 SAQM981xDbXVB7WT44wePD60Q8D4hbHY2j5BtbFGQXlRhDN57Us+qrrH6cPav432pMLC/kf+sURyL
 R7+Qjj/mCf1fZIirAkDK/SVHoddUJHrj+Gyj33pAWlGh5iUvdZ5s0QxOIqhim+b0q1S0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcCmL-0005Lg-Rp for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 01:51:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 09436601D8;
 Wed, 24 Jun 2026 01:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58E21F000E9;
 Wed, 24 Jun 2026 01:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782265903;
 bh=fAO2JeiSojqrbF34Es/gkv0pM3UixrmG8s10gKD+H2g=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=JFWqzxATFsTL2dPk5swpmZdkzxeJtontNAVtZoIhO02cUpn1lv8s4zoFOFG0gJr56
 u0gbiN2I13Upjsjm6fB77e9QQv/EXqAX9MFNe8qXyZQibtf21TOhX2icrEDFsTBblv
 t1eW7fHQDYMGcZIVt5fGml4TTUtf64ZErpB7x7rxPl3XMYBvN6607UDcCrdejraou/
 jjm+NTLPTzPcZaOcQY3U/3BijvCWrizF5u+GUjqSWcucaOpaiQjWRPcuXLLqR/zDYY
 otkulc+oKKz40PPvNLroU/sp0LyNtpNI/oNOsicHVMYcj69b0vFVtGNlRfQr+KMA1B
 ch0RSAme11HNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 1C806393102A; Wed, 24 Jun 2026 01:51:34 +0000 (UTC)
In-Reply-To: <ajrLmn16uMPcc4Lv@google.com>
References: <ajrLmn16uMPcc4Lv@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ajrLmn16uMPcc4Lv@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-7.2-rc1
X-PR-Tracked-Commit-Id: 4275b59673eb60b02eec3997816c83f1f4b909c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09ca8dc7d634f69d0b43f82c244add44cf7885b4
Message-Id: <178226589373.2503468.6602733890959222251.pr-tracker-bot@kernel.org>
Date: Wed, 24 Jun 2026 01:51:33 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1wcCmL-0005Lg-Rp
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 7.2-rc1
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

The pull request you sent on Tue, 23 Jun 2026 18:08:26 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09ca8dc7d634f69d0b43f82c244add44cf7885b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
