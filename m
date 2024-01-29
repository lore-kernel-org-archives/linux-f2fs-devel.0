Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1673FC47DA9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jan 2024 20:29:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rUYGI-0006qH-4C;
	Mon, 29 Jan 2024 20:29:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rUYGG-0006q8-8D
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jan 2024 20:29:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yJRGUw/XjHZeKoq0Kxf5GPK2ldKVsJRisiUrUIA701M=; b=bQk0a4ENvCI5M95PGfbVJPpIOp
 DZam19Pp8ivMvBzgjhkGrjm2Q5jeV9Lu10pMqWEuNGgPM+vww6OI6yQe+BEnLTL7w7sRedANsoMK8
 mOLu87tiRqFr+ATEIRUowh0fFSm7WjqCBbUKXZVKRv9iNggGjJuN3jBkYqa7vZEP8OxU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yJRGUw/XjHZeKoq0Kxf5GPK2ldKVsJRisiUrUIA701M=; b=c9oJd3heo7pMq/8xgNk72h7aQ7
 h5gZ84hAL0T3ZCxOkv5B+OIOMAbbRGckPL+iOQJvZ65BM8hbvf3K45VYWXH3xus8q3xx8J043XAbE
 oSRAXz1CIEd/4eB9TGIhn+Scz0RETEG07qev6AfE4HrjSpZogNU9IPZpjhK7u3Gsg6ic=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rUYGF-0008Pr-9U for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jan 2024 20:29:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 09293CE170E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 29 Jan 2024 20:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A49FC433A6;
 Mon, 29 Jan 2024 20:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706560171;
 bh=SQvwe0KRiHiPwuYKPEiT60vxLx2ZZ9hEflej5w8CJWo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Iqi35FLedO3/mPZyzKC1IpFcnB3HyeDKbRD2jD09jwyQeVmUDSJ5bGiYoHZGbo1Pm
 Vn0oaRl1tbg9XA2oADo5Ng+7927oXzy6iet/aKGSIsOh2UViuJ558ixlgLRv0slyXu
 YOU0p16d29j+HtGg2Ph+rvJgFOWZUEwcX1NqhSPanyQvnAYRUIgHxl7fg2ZydGZMSk
 rwYK/GEKzBa7nPRvXiZ7BuiJGqVLhs4eyvohzSelrLzQCraZTcI9rGqJvO7okuNVH0
 hraEmI8+P07vdIBkDVVdddmo+NO4c/rTQoQ+fLAcuzPbpO1vA9n8p7epsTJ15J9ZoC
 1fChSamkIYTdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 DBBC4C595C3; Mon, 29 Jan 2024 20:29:30 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170656017089.16041.14974521466482956589.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 20:29:30 +0000
References: <20240126151917.837565-1-chao@kernel.org>
In-Reply-To: <20240126151917.837565-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1rUYGF-0008Pr-9U
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: support printk_ratelimited() in
 f2fs_printk()
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 26 Jan 2024 23:19:16 +0800 you wrote:
> This patch supports using printk_ratelimited() in f2fs_printk(), and
> wrap ratelimited f2fs_printk() into f2fs_{err,warn,info}_ratelimited(),
> then, use these new helps to clean up codes.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/compress.c | 10 +++++-----
>  fs/f2fs/dir.c      |  5 ++---
>  fs/f2fs/f2fs.h     | 40 +++++++++++++++++++++++-----------------
>  fs/f2fs/super.c    | 11 ++++++++---
>  4 files changed, 38 insertions(+), 28 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: support printk_ratelimited() in f2fs_printk()
    https://git.kernel.org/jaegeuk/f2fs/c/83253fc066b9
  - [f2fs-dev,2/2] f2fs: use f2fs_err_ratelimited() to avoid redundant logs
    https://git.kernel.org/jaegeuk/f2fs/c/9a63d6e6382a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
