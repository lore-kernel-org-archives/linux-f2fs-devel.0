Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8B7C61DBD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 19:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:References:In-Reply-To:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yo/FBRy7A35M3x76PRYyuw42NY+h5suDpv40OanMIbA=; b=Q7Wn6MyuKDNIAQoKdxYMbxE19q
	u8C5E4SMD/EKrNUb09iGVOATgra9l0ggagzATVZm7kd+X/wtwxBBbz6sq5fLxQH3uXLFVDrSVUAEQ
	HvAETqcxg6VTaHfNA9gDI9QLXnSxDARhTgruAnRAkGcjWUoIDmOWxP/zZb4kX6EJIHFQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x02bg-0001q9-AL;
	Fri, 28 Aug 2026 19:51:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1x02bP-0001pl-0u
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 19:51:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KrOkvvhJXdH71XnyI6lWrLUd1V39isxrCgjnW5vR5wk=; b=EetWtD9QeQ73KtDLpA/Spej5Gi
 WLEW/d1NYOelWOIHPu4de8XBzSqOsvkjTmiyxauU53nM7HaDNEFMh0g7vuSb7nR7BnjpKHFPKq/jh
 mHVV5neMZu7lpPOYkLjlpNNVoFbM3AMyDHZzyOpMXc8XaCixTQM603u5N+Q7SjTUmbMA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KrOkvvhJXdH71XnyI6lWrLUd1V39isxrCgjnW5vR5wk=; b=kq6UT2Uli56mIczhPDzkcScpgc
 dIrgDA5XMHZIHkJVwiOZi/nTPUTDTdgVWzuDwIBcrxwfBJcecXQzn1vGXeCQlgCN3Q7Ke+Yp5xI1y
 9hpUZ2W2htXY/TvElSOi5+UpXzGn5h5bFTsYJGTghEJCvAjsJnzFBhW95NzXNnY+/C0I=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x02bN-0006rF-BE for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 19:51:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E710C43BD8;
 Fri, 28 Aug 2026 19:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0C91F000E9;
 Fri, 28 Aug 2026 19:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787946655;
 bh=KrOkvvhJXdH71XnyI6lWrLUd1V39isxrCgjnW5vR5wk=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=WJnIG8aOP7ZMX4w7JxCw/3z4LTEdKWHtflow849HXixLWaTCMTZZK1NYtO2daGuNi
 KI3v+snomDgruFQ9It7qI+i3GYGBrdde5Y5DLen0VRiE9LiS+rOcuqezDUoajFPo0m
 4Tjy71NJqjQUcggHPP44zc/6Z/wswjC23q0/8g20cPk1ENCBPMv5NoE0BWLJ6HWeHE
 f5jZdzwK+hnFFjE4rPECmTz4ZIV1WbEeO6yfpsAZqyDQRHBm7dHx4y7zG9OAsUTm/4
 w1xdmTIhSeCLwa2HC7iaqW6jn05GIyEUhb0XmbJcbdbu5e7QDxJhnT9bgll8GFajEV
 nSqMNyubiY3sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0C07380AA69; Fri, 28 Aug 2026 19:50:01 +0000 (UTC)
In-Reply-To: <apGgtMJ4mB-XRBlO@google.com>
References: <apGgtMJ4mB-XRBlO@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <apGgtMJ4mB-XRBlO@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-7.3-rc1
X-PR-Tracked-Commit-Id: c966d29e01bbf829f8bb4a39a49811c56cdb49c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 115bd364ab20b2dbef22824ec80d15901847dbe2
Message-Id: <178794660048.2763027.3740237878635955646.pr-tracker-bot@kernel.org>
Date: Fri, 28 Aug 2026 19:50:00 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1x02bN-0006rF-BE
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 7.3-rc1
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

The pull request you sent on Fri, 28 Aug 2026 14:52:36 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/115bd364ab20b2dbef22824ec80d15901847dbe2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
