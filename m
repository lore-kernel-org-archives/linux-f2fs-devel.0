Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E74ECDB466
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jun 2026 20:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EftU6hJlrU7qTjy7TTM8h7xKDbDS5S6K7ObfqT390rQ=; b=RsEpZpapt/NxUijEBTOFIuizFF
	Ff7e+nA+09/Ctlw0Q9ILJfcwVIO0qBZuNVxBXm1AxygHlUVyolHw7szkyo2tyRjY7N0oQsAOCMTBF
	goMqicT6u6/DkvXQ0iYl12ME9ZrEKVRG0Iy2k9sPDQPkK5YsUrSI9kCYja9zxk6rBd7I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wbkp6-00053M-G4;
	Mon, 22 Jun 2026 20:00:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wbkp4-00053E-RA
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 20:00:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qEjW2ja5zsHriXbhJAmzEId+JHa0NC2ygo5J6xWZCq4=; b=C7Vpnj/mxlTwGu0GBKp6GbcXbJ
 NIhhgCV6syMcsLo7ZKuqAWFpFAa34ZS58RsUkneSrT5f+RMeynoIHSGoLu6mZCxbs4BYQZkKeaQak
 CrfU8Ymi3UXfTzAyEvuqta0HRKonqIhlpJ7a7a5UwY+/ZcD4UjtckcO1xw7Z94Txic5o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qEjW2ja5zsHriXbhJAmzEId+JHa0NC2ygo5J6xWZCq4=; b=C
 /I93vJN54JQzXiBCjYVHEZumNcrSX0SBvL1HPzBA0nrzwpupDgxLeJt/m3RE1cdGfDVqk0BGomr2u
 jMRevo5hgYawI6lyrZEcW1UGZ0bYdzEdHWBajY25jn3nnNoa9uT+cRJYSKYqn7O/1dyGxy9Bmm0WI
 NBKTbT/3U9Iog9Hs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbkp2-0004Nc-Ku for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 20:00:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7253C601F3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 20:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0851F000E9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 20:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782158434;
 bh=qEjW2ja5zsHriXbhJAmzEId+JHa0NC2ygo5J6xWZCq4=;
 h=Subject:From:Date:To;
 b=NfPgYdg2GrsVtNuglRmo3q54QNuHutEWiVqVvZnqsXnjCulv97kdE4WXBTKdzDTvc
 S/A0QW5mQHM0ng3t9jGNO8bWqwOlir7xa0Qf/ONjjop/2QMRPBG4Rd8LseZE256nRQ
 PN4GQ2TBJn6lH+K9P2/jTHpw7VTvdfOTyL5g1873B6ZgKwYHDVjjzrSNYq5dz+KgMB
 Ze9SYXvVv7AHjgv8/0RUJE07IapWrHmn2xE0paAApjz9CwCIXr1TpV2+82fSjgPsw0
 zBYRKoSxKLwVvMTwT0//zNI1gnpuRFhDxzlG7h5C9RlEl482ehToNm1IjNdiKTkWdW
 wNEEUG21xcdRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D11B73930922 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 20:00:25 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178215842444.1396481.2249149402288597739.git-patchwork-summary@kernel.org>
Date: Mon, 22 Jun 2026 20:00:24 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wbkp2-0004Nc-Ku
Subject: [f2fs-dev] Patchwork summary for: f2fs
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
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Patch: [f2fs-dev,v2] f2fs: fix to round down start offset of fallocate for pin file
  Submitter: Sunmin Jeong <s_min.jeong@samsung.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1114514
  Lore link: https://lore.kernel.org/r/20260622052817.3972188-1-s_min.jeong@samsung.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
