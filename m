Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15154C3600B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Mar 2025 21:58:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1txvEj-0004AA-Sk;
	Thu, 27 Mar 2025 21:58:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1txvEh-00049t-QR
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Mar 2025 21:58:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9+KiLDhyKzmkYauqDvX9e0RcJkMoTYAJyBSZPbPJdEI=; b=etm5/2B+3aa8Jfn6krbTVx6bzM
 0Hx6TRz+E+ayqAABy6YwWtJJAH9jt3+K8H6rdvixneiB80N595MZMZqor+z4K1spngMXMNE8GuEb+
 klgBR2mm4F/f1ernMew00lfHmOFGbavLwBjkEWR6BR+9gJ9KoHNgqRE+d6RjwGx1pbm4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9+KiLDhyKzmkYauqDvX9e0RcJkMoTYAJyBSZPbPJdEI=; b=NZgAkjtKSfP4bA4BvvcjEdz1N0
 bvkExiafZ/mxKaq4ZvXUI9iOWZbbmMPsZfpb5puxAkFWsxS5ubSVAlOD4g377McKijkzKKsvAiIue
 8nVG7QW0VuMtpxoth3QnAXpAqEQnuLKZSCtrYcgJrbQVNcHiG6hJtcd6Hzk+AIa2ND08=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1txvEc-0008Ue-V1 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Mar 2025 21:58:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 50506A42F1C;
 Thu, 27 Mar 2025 21:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6409C4CEE4;
 Thu, 27 Mar 2025 21:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743112667;
 bh=vEC3nYe4sWrHn3kHC+aFv+04EDeh1WBI0+LQ94j77lg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=DB2RCX2cWhuHNyqWI6njfIZ13qrH8OLPGMhIK9YTjurF/mCuPF1AtrG/pZY5THO+0
 z+wy1grw7twTWqrvbmm5DixOeJm4of8v3oDe4IhaXAyBqCbt14nO14hV1QxNnxNX63
 6d9YHweyIAwUgo9AtKoCKVbFIUt2A5Jg7buhePHGtUNYEKWIAMOCCpDKGpSTzMXUX1
 r1nLWWUypagCcXAyRPvqiUVffDyw+4BXO30SxOowEAMie1OlQadFodsFb3ABj9SOfY
 uYgYCLQ48HTyK/iqeET2zZ5VrKqIsFL7JRXXoYUxQzRW5BjH+8INY3B66/GLqqTt1c
 tJ0hgNJdd9Lpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 70C9C380AAFD; Thu, 27 Mar 2025 21:58:25 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174311270426.2230226.11533981024198489963.git-patchwork-notify@kernel.org>
Date: Thu, 27 Mar 2025 21:58:24 +0000
References: <Z-GPopTYCOl0hjp3@google.com>
In-Reply-To: <Z-GPopTYCOl0hjp3@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1txvEc-0008Ue-V1
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 6.15-rc1
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
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This pull request was applied to jaegeuk/f2fs.git (dev)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Mon, 24 Mar 2025 17:00:18 +0000 you wrote:
> Hi Linus,
> 
> Could you please consider this pull request?
> 
> Thanks,
> 
> The following changes since commit f286757b644c226b6b31779da95a4fa7ab245ef5:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs update for 6.15-rc1
    https://git.kernel.org/jaegeuk/f2fs/c/81d8e5e21322

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
