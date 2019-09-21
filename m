Return-Path: <SRS0=1pqZ=XQ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B65C4360D
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 21 Sep 2019 21:50:41 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EDB721835;
	Sat, 21 Sep 2019 21:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="K4Wh1S1Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="aayXgRk6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRVf04bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDB721835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iBnH6-0005tQ-HR; Sat, 21 Sep 2019 21:50:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1iBnH5-0005tC-BQ
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 21 Sep 2019 21:50:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RGVr6Ie6FJ61+KIkQy65ve0StinipEho78pYZkl53RY=; b=K4Wh1S1YWZqFs5TrnkNfz2N049
 hCWknljxsn7uLgxjLrotNuiCCvfuaaDlVg16LwWYLBd/NqM+MpAf+V1TF2NqhoZUaArcO9kT/MZXr
 KuvWE9Er4m5JhMtYiyQt38Gre0j/TF6ljc6wXDb0F6WFduhhaLibSJ/djQzaJw77s7j4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RGVr6Ie6FJ61+KIkQy65ve0StinipEho78pYZkl53RY=; b=aayXgRk6ZPrKlaSZbDGuHvGhmP
 FeL8k1lttgi1E0ILlAZx7c286WMqq9WLXYqftaTSCLntUx/RK6fi5E2v3EO2QcqHl1MDlxZFlZcRf
 GQhg4NmxKrTSpTDeGAUE3xIFoY9rGWsrUnbw0Na9e7vAzwEoPnVjL4FTVGe0ef7DB6h0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iBnH4-0024eg-14
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 21 Sep 2019 21:50:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569102625;
 bh=FRICCBxIG2+cPRdX2HnJLSb/E67b62xdt0okJO51rDM=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=cRVf04bjPWLl4HyRtHXj7Xntp0uRsP0voDE5HUkNbon4Cqt1gWiQAXBqn3lUCfAqE
 SkufjRkdXR5Aer1JNvzNuH/tTE8Wz3mTuy0cOgiNDsbJz5qgkggSaXbq7Jy3kTM245
 3zaFKnSoYheMT0ZQLH/rG1sE02N9AVknEMuPfggU=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190920200107.GA57911@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190920200107.GA57911@jaegeuk-macbookpro.roam.corp.google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190920200107.GA57911@jaegeuk-macbookpro.roam.corp.google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-5.4
X-PR-Tracked-Commit-Id: fbbf779989d2ef9a51daaa4e53c0b2ecc8c55c4e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbc246a12aac27f7b25a37f9398bb3bc552cec92
Message-Id: <156910262496.18589.7479409845792193143.pr-tracker-bot@kernel.org>
Date: Sat, 21 Sep 2019 21:50:24 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1iBnH4-0024eg-14
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 5.4
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

The pull request you sent on Fri, 20 Sep 2019 13:01:07 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbc246a12aac27f7b25a37f9398bb3bc552cec92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
