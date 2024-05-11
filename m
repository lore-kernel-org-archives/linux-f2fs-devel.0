Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671E2C25B75
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 11 May 2024 00:50:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s5aws-0002OF-Sk;
	Sat, 11 May 2024 00:50:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1s5awo-0002NO-44
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 May 2024 00:50:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jyopC3G+MEJd86s+4zW0x7qm4kfRnwX0NrvEILiypbI=; b=enO4gvaK3n96wDfftA6pX1pzXy
 hXIn0oAgrjk3cfvJ/nKmdCYUXKUwF9cKr6LIAgfUvOeoqj6yGcdVWXTGDT3qZQcpi9JNtxkslxBP9
 0+uPPgkmkwkRS6ze2h4U6nHbe/bl7dSEA6XZO17fudEL0/QL7eu7pgq5T6lXbWrvODks=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jyopC3G+MEJd86s+4zW0x7qm4kfRnwX0NrvEILiypbI=; b=ZqN52+iWYmBIl4ZMfbG/WgGk8N
 JLu0fuMMvBKPoYgbmS1ZTK8oTZI+CBs5VbuhTCOJxMshjGrt/DZGuwPOGX0rl8EwW/kpEnesxKJhp
 HAGI6wQvN/a7FjuVxNsUuJ8zlOQ0cs9JRD//CzMvHlb62/4rgD84GS2rdDjpNAKYqgXg=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s5awp-0004zJ-Bp for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 May 2024 00:50:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D4C7BCE1F2F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 11 May 2024 00:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8EFDC32782;
 Sat, 11 May 2024 00:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715388633;
 bh=8Yop3smxewSROz7DAHuqzNJwUb8FvXPb5lUi3OGSIu8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=qaItr4cVfJp6WlyqcwFaD0BnCkFTkgScfqQp8CaRtpcdAH/29//J/LyJVc/LX6+gZ
 8IYtMVrqHFD+0MzUesF/5gRTpk/MyUQuOlHEg/6/k7J5exaoei8DMsLEkZ2TqP7F++
 RfahxO49CNmWumvP+23GlopBn7G8iXs1n4rBECKxj4UMKgNkrAdik+oiCFJEPjetf3
 Npp7L4AbtTq5In0XDieCtlngZ12hSYp4Ji2tfWgsRkEQVAYHmLNW/skz0Rj8yYxpip
 u2HfRMpLPh8Nm9VThxVNDpWxbdRXU/tsHrC8vuxxn7WzER+GpT1oUsTfiyi6vxufVq
 yFwin0Vhp27bQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 BBE27C54BA2; Sat, 11 May 2024 00:50:33 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171538863376.11229.7632095101337485351.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:33 +0000
References: <20240506104742.778789-1-chao@kernel.org>
In-Reply-To: <20240506104742.778789-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1s5awp-0004zJ-Bp
Subject: Re: [f2fs-dev] [PATCH] f2fs: use f2fs_{err,
 info}_ratelimited() for cleanup
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  6 May 2024 18:47:42 +0800 you wrote:
> Commit b1c9d3f833ba ("f2fs: support printk_ratelimited() in f2fs_printk()")
> missed some cases, cover all remains for cleanup.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/compress.c | 54 +++++++++++++++++++++-------------------------
>  fs/f2fs/segment.c  |  5 ++---
>  2 files changed, 26 insertions(+), 33 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: use f2fs_{err, info}_ratelimited() for cleanup
    https://git.kernel.org/jaegeuk/f2fs/c/a78118406d52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
