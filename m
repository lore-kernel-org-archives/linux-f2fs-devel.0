Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6F4D3B985
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  9 Dec 2025 17:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A630GwVYtnkcpDZBuhzunIo8B+/vxV3mttNh9uHlWBo=; b=GfdR0L/Ya5hEDeGCktvqA3DSC3
	SMGI5PVvmlAPqMVoCSuC57i/zFWa37fVTqpzP4qMtauZXJpKJECFeCV8gmPafCLEGOwjVD0uN8vQm
	3zgTvkSbJlAelGhIHC8X56ze0qgbnmgWDqazditAskyOxmvGdQhQXD5HM1NfuPbzNi1Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vT1Pl-0003Z4-Ux;
	Tue, 09 Dec 2025 17:22:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vT1PY-0003YX-FR
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 09 Dec 2025 17:22:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3z9G3lTRcxZ+IB1QoPmw4T1KLdARSXgqL4TaBex+T4w=; b=JCWo8inTvBFeMWGRq/1UI5kUM0
 SLy54+NSU9uIQxvDezUJ9sb2TmtzobTJia9kb9Rm7MYVha2rESOdVHfmcTwvpjYAphYzuLE8WMs60
 E4qTW7cbhKUvVSwPGBsa9xx33FuMNVbs4hXfizIss1KqUpM9UHzrscZ/E9j7cc4+gOko=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3z9G3lTRcxZ+IB1QoPmw4T1KLdARSXgqL4TaBex+T4w=; b=LVIXbnTGEzxIuE2h3+XdyJCA13
 jpxOaRxI/EB6lxDuwdY35upop2CMqLjaYcnrKVrSarVUUT6wOT77doAXMPE5H8KSIfZFdzmcqQBfQ
 yqN7Q5xHJz3MGnUI5g268SbWDvsh8EMQ+bNpQOE4pvHVUcapmfkzBtTHgPCEb8QsS/7E=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vT1PT-0000zv-Ij for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 09 Dec 2025 17:21:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4E41D444C7;
 Tue,  9 Dec 2025 17:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31953C4CEF5;
 Tue,  9 Dec 2025 17:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765300914;
 bh=myGVRalgrsbtvRWYKHHOrkm0sXCxbKG58e5Al9NBxgY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=OrEbx/X4K6wBSSKwU0WbMdK8zz6f2QVZ2bc/SDpB7azF59Mv1wmjhDUxlHoxviwFf
 YPffS438MwrcZBTso9ikk/QUa2hLyE/W4cZ9W2IHTsEwpujcI4Z4n4r6XlLDMCZDAS
 QqnTpY1QLIbdF+snSu2TCFpDGpXzyqXQu/PYIODcU2BR7O8j3PXIglGcnSZNTbsVWR
 FXpPxX4L4ceGKssMw4ZJ0gk4MNgLAqclRe8zQE5yRjjfnC5n/VA6icIIU4lMLmeotH
 aZfpkEXFS1W8J8mnQxAeOmNc5h6BQ73MzjFUg5UYUeTXyxStazYK9+m7r+oliu9VnC
 vHfAnSPG5yxjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 788153808200; Tue,  9 Dec 2025 17:18:50 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176530072903.4018985.4925454806084370297.git-patchwork-notify@kernel.org>
Date: Tue, 09 Dec 2025 17:18:49 +0000
References: <20251024170822.1427218-6-willy@infradead.org>
In-Reply-To: <20251024170822.1427218-6-willy@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Headers-End: 1vT1PT-0000zv-Ij
Subject: Re: [f2fs-dev] [PATCH 05/10] f2fs: Use folio_next_pos()
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
Cc: linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, brauner@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Fri, 24 Oct 2025 18:08:13 +0100 you wrote:
> This is one instruction more efficient than open-coding folio_pos() +
> folio_size().  It's the equivalent of (x + y) << z rather than
> x << z + y << z.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,05/10] f2fs: Use folio_next_pos()
    https://git.kernel.org/jaegeuk/f2fs/c/4fcafa30b70a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
