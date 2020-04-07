Return-Path: <SRS0=ePYt=5X=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419C0C2BB54
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Apr 2020 21:05:28 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A122082F;
	Tue,  7 Apr 2020 21:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Lw0FG6vW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="KE9jvqUw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmX5OVHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A122082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jLvPT-0007Ei-8Z; Tue, 07 Apr 2020 21:05:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1jLvPR-0007Ea-Da
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Apr 2020 21:05:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oFOILjPXNtbyzUoAndseMtoUceHaf0B/r5tjBQTrDfo=; b=Lw0FG6vWhnXgiAhzbUyDA0hxUd
 Mng/+LUcoq2NrR727aM+THhI5tefMPhY0/KtCqxw6365cR7NwhghEccLiS53TDQhFtghshluV6C2P
 PgphLEj5PXSnR1jaezBWEoYmV+sxehlJsztm+ZWehnuSnle0w3i98cAcWaRxh8waQY7w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oFOILjPXNtbyzUoAndseMtoUceHaf0B/r5tjBQTrDfo=; b=KE9jvqUwFaGPLjndeL77Nnzw4K
 +6DjuPArN5oxwhcol5yKn1BNt5AKrttgZAv9jxqS0va+usRBOcoUsZXaMBBTDAa85k4qvnscj/RsI
 M1erd2eC8Tq/syQBZAFrpSUmRgAiFuuzITOjUyYCDHoZsnuhvm1cXCu8Zno4CrzttD24=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jLvPN-006dgd-6E
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Apr 2020 21:05:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586293509;
 bh=pvmHCQ2cmTRceXWYDcPbXLhXd1UfxQq9lm0jyvFB9+c=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=XmX5OVHgRfs3WrWlcGT6y0yy3Pv+vhkGkBfX4Cb7cw9489YdO1WQ9vvxakEXeivL5
 qmHEvUpYkB+u3XrqatEEp7Tt+NNCypN9hX9wBr6MNRyyzCvOYlQT0wEldM85J+slDV
 lr7i2LXwwrQKyZHSqtbeRqKQ8NYd0PrVCkRbz6TI=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200311162735.GA152176@google.com>
References: <20200311162735.GA152176@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200311162735.GA152176@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-5.6-rc6
X-PR-Tracked-Commit-Id: 2536ac6872e5265b4d9d263122cee02e3d5cae1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6d5789bea5187c2716959f8954a1e00b8a7835d
Message-Id: <158629350986.19531.17911572712226508781.pr-tracker-bot@kernel.org>
Date: Tue, 07 Apr 2020 21:05:09 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1jLvPN-006dgd-6E
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 5.6-rc6
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

The pull request you sent on Wed, 11 Mar 2020 09:27:35 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6d5789bea5187c2716959f8954a1e00b8a7835d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
