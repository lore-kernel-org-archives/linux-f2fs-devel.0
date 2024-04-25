Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D91C41513
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Apr 2024 15:40:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s01DJ-0001yN-1f;
	Thu, 25 Apr 2024 15:40:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1s01DH-0001yF-FJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Apr 2024 15:40:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gXsODb58rJVvK+pZo5djHwYN9kYCmNljDGczO+HnTqQ=; b=cChsv3Z2B6ysQ9kb1P8vn7GOF6
 +cajrrV6sYHJHTN7wAjoCZsDBJbFTrF8EPcniTvanTPkYnUva47By+M8QF/BFgIsKSo9ZEzDR+o8V
 V5gFvRtrWZc9/sV2eM6KXks2QDMdGxhzL6wQfhHhcG/Ij7gtcXNs7at8/1mFi01XjZP4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gXsODb58rJVvK+pZo5djHwYN9kYCmNljDGczO+HnTqQ=; b=WQS1snt3Iz3ymithBv+hQbyEyd
 Zc4qR90y7gcxY9f1Hl39sB+7TeY5zLjwYcaCiVFOY4u+VI6rv38f++OJjtytYkYeJRO2VPgLm4T3M
 jFAddIyewmVmMSwudgKlLCLxnP+8BkFCw9/70h/xu8C3DTVuzVuOWfRm//hfdcp6JUp4=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s01DG-0005gy-KC for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Apr 2024 15:40:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5206ECE1ADE;
 Thu, 25 Apr 2024 15:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D476DC4AF0C;
 Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714059630;
 bh=+J9HVSfkiiiwIOMHIiD69N9uDI01zWrTSRF943HQCRM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=CDQBt/RnL+hCvvecUUxLvjOWHEDFZtqpVeAA/GtJzqsA9z+gI5rVbVSm60OywPEAY
 KrYOHF2eB4FFGhSDEqS+FGeZGPFijTYDf+CbNA4RT1ITOE8QO3Pgk868icottoNcIc
 9M8540txYpY2D2DteERQYNPYJq1yhlQFX86IVeD5rIOSRuszDHZgFR+xh8f+/939HH
 k3MRBvvnyiKHcwFx/P1b2lG0LnV7E+t1vcIjJhtQAd4fjPjDFZEzUk4Ru/kntk2a93
 Mp6cput4H2azdK64RGx/7y+OMTnyZp6IwF8WgWjinEs9P9RJjcxiqXVSJhOJeMzOzG
 1I4dVLO1pihlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 C9556CF21C2; Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171405963082.10966.9576807283536776270.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 15:40:30 +0000
References: <20240423112759.4081008-1-bo.wu@vivo.com>
In-Reply-To: <20240423112759.4081008-1-bo.wu@vivo.com>
To: Wu Bo <bo.wu@vivo.com>
X-Headers-End: 1s01DG-0005gy-KC
Subject: Re: [f2fs-dev] [PATCH] f2fs: use helper to print zone condition
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
Cc: wubo.oduw@gmail.com, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 23 Apr 2024 05:27:59 -0600 you wrote:
> To make code clean, use blk_zone_cond_str() to print debug information.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  fs/f2fs/segment.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: use helper to print zone condition
    https://git.kernel.org/jaegeuk/f2fs/c/3763f9effcdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
