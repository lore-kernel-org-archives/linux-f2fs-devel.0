Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56301C6379F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Feb 2023 21:12:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pUDS3-0004e4-GL;
	Mon, 20 Feb 2023 21:11:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1pUDS2-0004dx-RM
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Feb 2023 21:11:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q/4ywDOqdSfqCMs/nYI3XYEAcoy//zFaYI7bNWwN9Yg=; b=WbvMUiFAOHR3C24C/QrATsojIT
 AFGDWh0p93rAYRHDGZ9QZURs/mrSMGxePz36pa5dJMk75DiN+n9tClenHogl2xgyog48QAeGaw5cO
 KcKpU1mTqQdfL4wNgGYsGqRbxk6FC3vj3C46FJ+0ayiEj8k1c39RThSloFSTJmBLx6mg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q/4ywDOqdSfqCMs/nYI3XYEAcoy//zFaYI7bNWwN9Yg=; b=E6OydGLFGLInHWa6Wb0jEeoWsk
 wTiihBZEhHJ47FdQ4iSHGMUgUxFWsvV0LGIG0Qe7UMPoYssKJTUqS7kyoaRy6y7uatrFvQLvx+jx4
 vnuG/atJ1YhYnGMWHsC1ock6wEmLEGMbA27fMMfDUkK/cOR5dk/NKUXzelJYkviIF4cE=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pUDRy-00Ba9t-JA for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Feb 2023 21:11:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E8326B80DD0;
 Mon, 20 Feb 2023 21:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9B9FC4339C;
 Mon, 20 Feb 2023 21:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1676927502;
 bh=oB6qB+JT3J5TQqi0FNch335QjTT3i7Zn5WpYlg3Yf6E=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=anRalbWUo1j9wtS0/JpN7o64WicfLpl/Kk1dkNFpe2RhLO1DQ5zzBTll1ureP7qiR
 ldhSJtbq33f+VWjgHK5UWHFPtgQrBrrz39K62SxKzUPXy8xkwkTgNIWpFDlXvj1JFD
 JPaHXgjx5GNesoRJNngDzUctXzjeDiDbD1OTcM27BuYWlVXUGxDXyD9L3xxn7pGhLs
 7cRQgvyYof6wC/KChq/IW0dFoBobOtoEWtk1uiWCWbeQp/7KEiJlh5EAeRjJfFLLD7
 Lwd2Xs40ZRs71V+zS2vPaCnFEXg8Pc5smyK4d/5+YZyLA5oj/e3EBB1dCY86sU3/TZ
 b/BTRs5AETdag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 8FF0FC43161; Mon, 20 Feb 2023 21:11:42 +0000 (UTC)
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y/KIgw8gAI/gtN8E@sol.localdomain>
References: <Y/KIgw8gAI/gtN8E@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/KIgw8gAI/gtN8E@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/linux.git
 tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 097d7c1fcb8d4b52c62a36f94b8f18bc21a24934
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f18f9845f2f10d3d1fc63e4ad16ee52d2d9292fa
Message-Id: <167692750258.16986.9650885696006716532.pr-tracker-bot@kernel.org>
Date: Mon, 20 Feb 2023 21:11:42 +0000
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1pUDRy-00Ba9t-JA
Subject: Re: [f2fs-dev] [GIT PULL] fscrypt updates for 6.3
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
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The pull request you sent on Sun, 19 Feb 2023 12:37:23 -0800:

> https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f18f9845f2f10d3d1fc63e4ad16ee52d2d9292fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
