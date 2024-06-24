Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B269FC2D0D1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Jun 2024 17:40:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sLngG-0006da-JR;
	Mon, 24 Jun 2024 17:40:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sLngE-0006dU-Va
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Jun 2024 17:40:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L8BQezq0EC6ATDNDerd7jDO6Gh5mXqDRiDobnHvCPDM=; b=IR398dFXUekfsMWoNMxd3jWTRk
 jvDF4dFhVMZDtEJzwxiuJ2nazOM801XcpfNK4GbgiuxAMikFTRMaln+yMPB3VCvK1p19pjZLdNIS2
 EPXfw+qO+rWHU8t/aLe7v2jR5TGTq641hJsAdbs+pp2QnMdXf/5Kd4U1RKqn3zUbbdcM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L8BQezq0EC6ATDNDerd7jDO6Gh5mXqDRiDobnHvCPDM=; b=OpnFTjWrcBbi7M4PTnx6+qHB7S
 EBLt/N+3mD9LB4t1s9K5jKpe3PO2jnDk2yBe9r7/+o5z8+pmaXYpvYJlEvbsVTP2soFUFFIELoXDC
 gnlhTvPFOT0WsxC+NB+p0fSCFLcJfNBe9167GYITRTsYGzspqZ2VxfUCkKbXosUSZgYw=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sLngF-000240-Dt for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Jun 2024 17:40:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id EDC7FCE1367
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Jun 2024 17:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27101C4AF0C;
 Mon, 24 Jun 2024 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719250831;
 bh=yZJMLWqazJ2QSZSlbJ0fJBz37N1160tDc8KHGpb0W6s=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=WUOYVnPP0ZW5NF0ER3QjMMCft4dA7JqbSVKFKJAyis27MUpaAVo3zpqh5R57k6RAl
 qaqAqiaRQhBPYM5vRsJ0/+cQjJCe4cTFXTf/Gsr0+B9qsIz9Z2IDCcap/8rVEf/Pc0
 CxhIiYTJFtdpCXK0RBkV1oBoWl6qQZrMZMtiP/2W0q015QiDtOclVbkZLOD/oeBPqD
 e8f3FPrNTWS5obhEwyzkhG9ZKctXotrnssRijrX8M3OtGj6/Khimm9uD39EQB4N9s+
 DBtLzW1ef812iOMpUTVQQbozhiirfpoAzTpkud0jti8rGpojAqDELQET6ENLa2R519
 XyW0+kpwhLl/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 056F9C43168; Mon, 24 Jun 2024 17:40:31 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171925083101.4247.13790083235420551794.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jun 2024 17:40:31 +0000
References: <20240612193831.106524-1-jaegeuk@kernel.org>
In-Reply-To: <20240612193831.106524-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1sLngF-000240-Dt
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up set REQ_RAHEAD given rac
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 12 Jun 2024 19:38:31 +0000 you wrote:
> Let's set REQ_RAHEAD per rac by single source.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/compress.c |  2 +-
>  fs/f2fs/data.c     | 17 +++++++++++------
>  fs/f2fs/f2fs.h     |  2 +-
>  3 files changed, 13 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: clean up set REQ_RAHEAD given rac
    https://git.kernel.org/jaegeuk/f2fs/c/6aeb084fa0b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
