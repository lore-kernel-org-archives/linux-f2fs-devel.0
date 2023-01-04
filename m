Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA58C4708D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Jan 2023 20:17:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pDACs-000315-Ek;
	Wed, 04 Jan 2023 20:17:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1pDACr-00030v-8X
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Jan 2023 20:17:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AakK3+UXwg/FNguRztkM0CL4ASJ0bnTxfYQRPLQ3PN4=; b=b6Pczd0bEogLgov9PJuv7oR77T
 58qhZN19/VrAJQR9XlqqNUGhJwaK9sUo8FH0F9DIHKiasReeTk4b7NF7d4Xymp90hzQZhFwS9ogr9
 gss5CYpbCwkdIRcUidtNq9T+aMbi4DGlQr+RSIkjCHmHLuB1CyYyIglejfRjsJaSaSDw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AakK3+UXwg/FNguRztkM0CL4ASJ0bnTxfYQRPLQ3PN4=; b=Z7EyoIla1NSJKVR02bVRpuQTrW
 8ZxjWxlgL7PwJMyinst2XJU65dG0HblPOWJ7ZHO8EWIrnk8fJnz1bysRHlCYgKcD9mdSYWIj334eF
 bi6nm32lVWCeaWPPuzuU67+xykdJo/HKI+dQ2Zu8MwF0BhvU/U+zg89kptMbNmOUVt9w=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pDACq-004ysH-Ja for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Jan 2023 20:17:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 55470B818D6;
 Wed,  4 Jan 2023 20:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C549C433D2;
 Wed,  4 Jan 2023 20:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672863461;
 bh=V/h2BGMSlFlP8mJJwcYSUkI5kKvoGSa/rxCqiwWC9Rw=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=KcofHTeV6n2TWsRXHlGRg/3w7e3QraZA0Ko42wD3BPq5Ty94iEzAjjQGubX9M/TN8
 1sTh4ul5/KNJgmPke9ZBuOz9jdUU/3G16zpBkOp7iB74ye92NAZRdzJ2zUUbm4ZVRd
 AmqoDQ1tUZbUCQNWn0PlZOGKROX11wBQA4D9xQAqDL6Y7FL6P5XHgZZrnFa9NEBKI4
 lFzUkoFc5hysu/I8Q3w/2xl0VYqoFZklwcCFKGZWV4tNHNp4KcBQeHQ+nvk2V8qVL7
 8RnkTCcmBpax3Q4l+wR2+mNnw+QmJ9GU4xdgBwZEGhzvZ13UYt+Kr7+D/Y0yxt5++R
 o6GUyani4MH1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 DEDFEC395DF; Wed,  4 Jan 2023 20:17:40 +0000 (UTC)
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y7XH7fSoURcqoUQW@google.com>
References: <Y7XH7fSoURcqoUQW@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y7XH7fSoURcqoUQW@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-fix-6.2-rc3
X-PR-Tracked-Commit-Id: df9d44b645b83fffccfb4e28c1f93376585fdec8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ac44821a81612317f4451b765986d8b9695d5d5
Message-Id: <167286346090.24547.11166270720309340106.pr-tracker-bot@kernel.org>
Date: Wed, 04 Jan 2023 20:17:40 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1pDACq-004ysH-Ja
Subject: Re: [f2fs-dev] [GIT PULL] f2fs fix for 6.2-rc3
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

The pull request you sent on Wed, 4 Jan 2023 10:39:41 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-fix-6.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ac44821a81612317f4451b765986d8b9695d5d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
