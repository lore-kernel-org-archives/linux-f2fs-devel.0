Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B968BCCA471
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  3 Oct 2025 21:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:References:In-Reply-To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Qj/XcNyOSLWK+ZcrHQ0ghOOWx6RGkg4rpKNVddXPbg=; b=a+J3DxeI6YJUhO4uUqWkpr4vGg
	C9c/tWadcBDtxq2LdmWrM836hOKqWCchMx33qlNelfDMX8+Dqlvb7C4eubMWP1JAe1uy7/xfJluBG
	hsMPm1LVFIb3BBRRmrNZ3BzXRvXW0jP3ECjHbGB+Qq6sSNk0bYhuwmpU969hHLtwF9o8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v4nPC-0002gP-Vc;
	Fri, 03 Oct 2025 21:33:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1v4nPC-0002gJ-Dz
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 03 Oct 2025 21:33:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ty/V5XxwatGJWq/MSOdqBeMUZ5W286LkVOz/b7pN8+4=; b=IvKuz6uNbghQgkzedUVMGlOy2b
 u1ucohq2AOqN/XMuJ1e+sqHoK8NKZB0Bt3bG+AGIx+32UaGlHfleYH8Yu8A+J7qPRwGpybf79WcWF
 VjXzhDi4tSzYLXNesKKbnHvvpzRlbG2o59toMSjGnRlhVA+B8juayX7LSGGCkwjhH14A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ty/V5XxwatGJWq/MSOdqBeMUZ5W286LkVOz/b7pN8+4=; b=ZroHUrQBWmQXkAzLQ722tqsIDT
 mzAsT1V5MrEvi+ZxJxTwtO1CdcfVZKa3LeH1r/9EN148ajHa1ihLGfdDVktlba6m+Wi7tlYKIWplt
 H/hfjeGn4lZgr6aDVTbZOawgwmGvoBXNR1XykRV+lYDh5nMjMp8gLph4eO2J/a6diCGo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v4nPB-0007Ge-RT for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 03 Oct 2025 21:33:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4269462621;
 Fri,  3 Oct 2025 21:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E834BC4CEF5;
 Fri,  3 Oct 2025 21:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759527202;
 bh=gFH+K0zTaB+S1SUCL7G/S6JbiAsQ2i1eXn/174rZBT4=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=JrgJ5YoRyz3maklzPKAMXQi5rHThOO2g9MNZkjKZszdcGsULGJdkhAR018CDHiABS
 VwnprP8VZgKnl91RGOqS4DCGJrzRXGfQI3mY+tg+2EyvxqlTq3zSOdaknmVdwQSZeJ
 W8o4VvkIcJIV82LWTlTQMdJeDCepheE0V/ImicxrzCwtMOlsTUPEtL1MYtNMI/CgxC
 fLeLPtpC5OxCpcQvSgc69llkiFvkQhAKk4EE9tSBZRHWcOXC5AMBmd7zHf/PJQKlNK
 Qx5OGQG7lKstvhqFsk/Bajt/RJPOusj15K6rt9d/mnmopSaesItm93h5RQw/rad/zn
 btIcW+WbUH9hQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 70C7839D0C1A; Fri,  3 Oct 2025 21:33:15 +0000 (UTC)
In-Reply-To: <aOAOS864BmSwjfGm@google.com>
References: <aOAOS864BmSwjfGm@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aOAOS864BmSwjfGm@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-6.18-rc1
X-PR-Tracked-Commit-Id: 4e715744bf7b4e5521cc3b77f310060f862cb719
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86d563ac5fb0c6f404e82692581bb67a6f35e5de
Message-Id: <175952719403.86168.1769122833708943464.pr-tracker-bot@kernel.org>
Date: Fri, 03 Oct 2025 21:33:14 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1v4nPB-0007Ge-RT
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 6.18-rc1
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

The pull request you sent on Fri, 3 Oct 2025 17:56:27 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86d563ac5fb0c6f404e82692581bb67a6f35e5de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
