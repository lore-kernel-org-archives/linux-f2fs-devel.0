Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40527C5DF97
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lhFvGj6PS26qCx4UuxJNwDTV7AdetlHdsAyKes207H0=; b=HcUk8q49E/ImArOWMoxgyhuEEP
	kkXBXe20XqE5g13zO9JGFz0h5bSCTNYqTNmvOJqDs4BHqbWywymCJw3VlIAuWN9o1T5UA2EPS+3wL
	I5cJPTG5OI13WMd8ErAZ9hrkmhw1r0ZsSgthjeKwTVgJZhdSw41pkm1kRS1A+4ohEDg4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxRWU-0004M4-VH;
	Fri, 21 Aug 2026 15:51:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wxRWR-0004Lw-Cw
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:51:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SzzlytHaQ0pS69rS9YTCEfincFVOTh6HlXqA19sN3CE=; b=LsEAesaoGeIped88QDfh3UhfTz
 Gc42jm1qJgteddlZNFmCNL7Iyu0I1yEVzQeWRU8SE7jj7CUzUTSLbq4G98fA3nUqB5U3tAoUrY390
 eYpCcsa5IlbDVUA1JYC4ZfJZMbWlYzs87rHT6ZDeYPVIAffgRHR5HpYOkeV0OhMdGYMg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SzzlytHaQ0pS69rS9YTCEfincFVOTh6HlXqA19sN3CE=; b=Fb+BbLIYdaQLjmX+LlBceE5Hni
 L2jxsrKS2rDle7xEHzO09UBdbbz+KCOUcoFzia+qkFg7Tur5yk0DN7N+JlAZeHjjVX/7eP6wSDEnD
 6ILOuxEKDFQVKfQJ6bKqVvbNUWp0EmcT9pv/43AZ1Uk56/usSRV16q6M3HWo6gVXGKM4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxRWM-0005F9-4y for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:51:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3E2443F44;
 Fri, 21 Aug 2026 15:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65931F000E9;
 Fri, 21 Aug 2026 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787327460;
 bh=SzzlytHaQ0pS69rS9YTCEfincFVOTh6HlXqA19sN3CE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=VDooFEEm7hXM3fD8uLrhi+0iS2weKFQObnsndkfIk2TrG3X9p0RmyXWapfEsmtggi
 s+C1RrQaFmY1saBCYC8wjbBT+PW3abKdTuG+ShSfltIkuzGI2J9Nt6JZ7oJNgF9Wwg
 4V2tPWCi1DdsBkO0WZ0PV+hyl3F3jBvw1c6e1jSZtDOL6hFwtR7F4bitEeWOn8i3Ij
 cdGB2/nRrgXk2uzcuJMBPhfM5xq0DKTQOssxZ3Yzgtc4buG4abIYTgLoheyHp13w7F
 rcX3azBYQJ8vDF05oVY5N8QtDaFTdRMfM4NgjTAFiw0XpnKZKlYlJOqF64qYAe2I0D
 Aj90tB9qnYWdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93936380A979; Fri, 21 Aug 2026 15:50:11 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178732741013.1339488.5316909408452306238.git-patchwork-notify@kernel.org>
Date: Fri, 21 Aug 2026 15:50:10 +0000
References: <20260817023927.1066935-1-chao@kernel.org>
In-Reply-To: <20260817023927.1066935-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wxRWM-0005F9-4y
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to reset all pinned status during
 fggc
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@kernel.org, linux-kernel@vger.kernel.org, daehojeong@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 17 Aug 2026 02:39:27 +0000 you wrote:
> Otherwise, the pinned status may affect latter flow of fggc.
> 
> Cc: stable@kernel.org
> Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to reset all pinned status during fggc
    https://git.kernel.org/jaegeuk/f2fs/c/d2a70b3d2556

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
