Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3042AF94CB0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Apr 2026 21:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:References:In-Reply-To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SVb49NaQjeAW9wGxwOaXb0KsKs4t3KxF67U0k0NZUgU=; b=mXVDommtlNJCXyOsHSdLar0H+9
	XG9RSO4/Xitg4NJ0Kao88Hs8LxiIw8IkUd4+5RbI0Ir0QfhH1ZnI90+9ako8Zk5MUb3iNDcah7VAJ
	IvmJC25h++oYXzKz9wjg2WhV2Xa6c/BTQFcxJTEemAzb2g0znrUHsJ9owSR0Qs6rZKYM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFJ6A-0004JU-3P;
	Tue, 21 Apr 2026 21:57:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1wFJ68-0004JO-7i
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Apr 2026 21:57:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=usbFQHanm5ASdnANlJvOb2aWQB0PSJG3pVRsDm28EeY=; b=fZYDw0ui4suS8SP7pXU0Nc5+mm
 uSaonJc9Q3Cv9Y2ud11owzMGUJvjQYJfgy5MmWHN7o58sb/qqLrb4o0fPdZsHvmLaN4hpx0pR/d1w
 QyJfdlwYkdNT+jq567aH7FrftuzVWY/xdx7hISppvXKDooLrA+ZSL1oMPRo3RkUztKwA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=usbFQHanm5ASdnANlJvOb2aWQB0PSJG3pVRsDm28EeY=; b=moKLzD2UnrrYRRn1s1n561aeW2
 io4vl3DevAwscTBz+xtBSNDPvMfV5Jnp6aH0HSSzO5m46SBntN2JsP6TvBEEy6kKYrtNDPG07cIgA
 XwmHd4beiKKoEJX1WdMoswF4QvOPnoCcEP48IGcBQfS8vWo3XIw9ePsZJ67x6gnrFjcc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFJ67-00062i-Ou for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Apr 2026 21:57:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 671AB406EB;
 Tue, 21 Apr 2026 21:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EDEC2BCB0;
 Tue, 21 Apr 2026 21:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776808645;
 bh=Kqp5yY63bZvQfjeOUohTEPZuOfeO4+xrdoVeh21DomE=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=Pe6e15MyPzEOnyztKQAaGqaJH4fVJ0hcNzoGfLBxCwUOUSaylesCmLC6+mwrDK/om
 1/UPo401UsoQLIKeGjgitly2+ZrUKuISu339EfafaLF7qDQ8b+yUwkHx9tOk8wAitp
 +UMfqEWshRDqBl2ML492GtWqW6CdY3IlUsYwkD2U7rInZovdzROSEkxsrUpCxzkLZe
 PbnMrVsHlaD6RVocAp1rFiLsaFxpkr5mHh5F0Nif2db4oPgZUycT58Iye/Xz1LcbQZ
 cLqarCcFLxu/O4NSeN7/ZnIOx+uEXGuBTUupPTg3wh96QPFEhA6i1wT2m7/fDbB3Sn
 on+8t7gWhK13Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 BA00F393020A; Tue, 21 Apr 2026 21:56:49 +0000 (UTC)
In-Reply-To: <aefw2uZrM9f-UfRa@google.com>
References: <aefw2uZrM9f-UfRa@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aefw2uZrM9f-UfRa@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-7.1-rc1
X-PR-Tracked-Commit-Id: cb8ff3ead9a3fc43727980be58c7099506f65261
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d46dd0d88341e45f8e0226fdef5462f5270898fc
Message-Id: <177680860843.3017017.6212381763813341453.pr-tracker-bot@kernel.org>
Date: Tue, 21 Apr 2026 21:56:48 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1wFJ67-00062i-Ou
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 7.1-rc1
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

The pull request you sent on Tue, 21 Apr 2026 21:49:14 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d46dd0d88341e45f8e0226fdef5462f5270898fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
