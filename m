Return-Path: <SRS0=dVfM=V3=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487E1C32750
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Jul 2019 20:40:31 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132D52087F;
	Tue, 30 Jul 2019 20:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ZbTILJPt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="AZMdVLxz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZibkTTH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132D52087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hsYv8-0003yJ-Fa; Tue, 30 Jul 2019 20:40:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1hsYv6-0003yB-JE
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 30 Jul 2019 20:40:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g5OBQC5fvjXqcFlY/yJ+dNTSh6COiJYheFMclYiT6t0=; b=ZbTILJPtvO8aaiACwAjJcRX51a
 z0mnH+bgB4VwEeqi52kKvaqpQe1Uf9haW+g0iBjyG9QxrSA6lBosGPprluo8mZY+CRO5Dl6sqlC6D
 r3Fg/KXJxlxpnvmwN/axnTjVP1E5JQ/M1A2k7jr7s/cxuHejXhOxEFBDDwFAu4vOfG0g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=g5OBQC5fvjXqcFlY/yJ+dNTSh6COiJYheFMclYiT6t0=; b=AZMdVLxzH+aajV1xo9AbAJHI2a
 6AAeQVN+RHFYMa0BrgKil9WVHPUXziEDsZGzVl2J+2vsNn5wMz3woK9sItckHM5ylKBF31zW5h9FA
 urIPeAYiDa7f0JX3azjawOP6aewLkUDm+r+juu4vxnb/WrOnTcyCxg35f68yRxiA0ja4=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hsYv5-001Vfl-7D
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 30 Jul 2019 20:40:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1564519221;
 bh=ugWXpsFhigfjuYJ4dltnK0ERMdeDSNvAi6z+BURK244=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=ZibkTTH+jISGoqZ2U9iBBmZy2zBTY3VYqfjjEQvkvTc+nWgPhdQSfhV5+hZqo4m+0
 tddt/6HH5/HbJbMwAuSYCJT6CjdkdqWdSjMAeoOhDVo/yN0kmRc8bFQU8e73POhhV4
 DNriAnArnvWrHxpo2PA2K4AlcYfViy9iC4ecOJtc=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190730174653.GA76478@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190730174653.GA76478@jaegeuk-macbookpro.roam.corp.google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190730174653.GA76478@jaegeuk-macbookpro.roam.corp.google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-5.4-rc3
X-PR-Tracked-Commit-Id: 38fb6d0ea34299d97b031ed64fe994158b6f8eb3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0572d7668a58794059030b88945f78dfb94e3325
Message-Id: <156451922159.18459.4858636766003450241.pr-tracker-bot@kernel.org>
Date: Tue, 30 Jul 2019 20:40:21 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1hsYv5-001Vfl-7D
Subject: Re: [f2fs-dev] [GIT PULL] f2fs-for-5.4-rc3
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

The pull request you sent on Tue, 30 Jul 2019 10:46:53 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0572d7668a58794059030b88945f78dfb94e3325

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
