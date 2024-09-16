Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B2BC3ABCE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Sep 2024 21:30:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sqJIz-0004Uj-G7;
	Mon, 16 Sep 2024 21:30:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sqJIu-0004UZ-Px
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Sep 2024 21:30:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cyGdQso8aDIUfqDNqbMFHtdVYngykJZQ7+4EIAhWnW8=; b=REaxMIAWHlis59SB7O613tNKpa
 9HBHFBrqM0APuJxOj5SXchymF5y7LR5j9ORBqSNaPapzlChPGeiSDwNbiN1W2ZGl3GJ9kSc8Cf76A
 FfgI9T93K2wp9eO247ztAgJjh3JbFZZAspioPbsd+QvubnQLmAReBVKGizpm+2fODDxg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cyGdQso8aDIUfqDNqbMFHtdVYngykJZQ7+4EIAhWnW8=; b=ga9IdEv8u5tG9yuyCxqq+JknEH
 ZzEuAwp6nzc3zYt5da7fQ9FX/ydHTu4vKpdQFP5FO2YLByy1BJEBuS6F8mlwtqkFTJRMoZXu5Rhrt
 A9I00qJd8XK1Hw1RqfnSJaDJfGyt8Qy3vhKfwVdu1L7P0Yf9/ID41cncKjIAl647x7Yc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sqJIu-0000O6-V7 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Sep 2024 21:30:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C807E5C05F6;
 Mon, 16 Sep 2024 21:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E51C4CEC4;
 Mon, 16 Sep 2024 21:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726522230;
 bh=anl4DpoqqD9fIJF2b3yEUbmX6bTmHXeEKVEwgC0wq3o=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Z5REh09/c6QIhhYABIZhNRBLxGuekL9ILzwCRKqqWabrx/lYD4CDG9gpZKnecCFoV
 K0CvBQidTUAj2VD1jtxECKNPEPTzMbMP2vM2tE2XWqHveB2rdBwhwiWKrH0xLTCVjZ
 YnXA87pAgDmyaIrgPPqmXS/3pGgpZwpbY7uSX8iXWJn2inUtQ2Yl+HsvKZ4i/2Fk4l
 AhSqUaX2GGpbTxNn4OVxfYzsuEDOJ4KQT3j5tz9we+utXc5GmhFNV3LGPgE/QanIjf
 oe4Oi/M9aR/Wi9oC0rJA1Mq8TG8b4eXs4v/yVGUqLKqttupj9kzmH3mAgUACnvpj9o
 CmE64cki7pWEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 EAE0D3806644; Mon, 16 Sep 2024 21:30:32 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <172652223176.3820990.6988007191062882745.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 21:30:31 +0000
References: <20240912165958.386947-1-daeho43@gmail.com>
In-Reply-To: <20240912165958.386947-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1sqJIu-0000O6-V7
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: forcibly migrate to secure space
 for zoned device file pinning
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
Cc: daehojeong@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 12 Sep 2024 09:59:58 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We need to migrate data blocks even though it is full to secure space
> for zoned device file pinning.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: forcibly migrate to secure space for zoned device file pinning
    https://git.kernel.org/jaegeuk/f2fs/c/5cc69a27abfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
