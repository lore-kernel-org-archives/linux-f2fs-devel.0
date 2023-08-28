Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA56C71153
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Aug 2023 17:20:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qaful-0000yy-G6;
	Mon, 28 Aug 2023 17:20:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qafug-0000yr-DL
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Aug 2023 17:20:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WcWJhjtmzI97rP1vCj8QW5KObQruUQSaDOFYDdjjvGQ=; b=a3LpDE+dmhi4wUVrT1HiHNcg/t
 ItrfBcdjMiYqD8OBLz7bAwpGR8kT+unOeW2mQdntV1sSEi3V1v1w/OgY8Vw07fowRm811jyBxClro
 WSuira4828p9xJE5v8rQ45a5OqM93MWOVq5EAf30AQKcm2OrAnnx8d/twznGTubAWbao=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WcWJhjtmzI97rP1vCj8QW5KObQruUQSaDOFYDdjjvGQ=; b=fJtxhAtmEXx7d38A3ggWn4na1E
 3P7+hbujjmMzPawlXQOfj9c/tOIA6idIEExc12ZZ/Dq+0bafkm1Xq+an02Zz4F46ycsKqB9Yvj8q9
 c2kb8pL/Jb9xwVmxLNPDK8XBn9BTp2Ok7PyhbE2TxezLJNKjgS3JOjBDSuJRCmLZGXbM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qafuf-0003sL-4i for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Aug 2023 17:20:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6EC0964E11;
 Mon, 28 Aug 2023 17:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D49B1C433C9;
 Mon, 28 Aug 2023 17:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693243222;
 bh=FQYXoInQBlr/f4+an2RbMCBOGFxOn2Mjxfz/Bo5FuFA=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Ca1KH7F9oT0N8788aWwh71ULUQciMywnLtvl90psB/ZuZjnXklvA/9yWsjexwouFS
 yGOFqakHhBN0qJszeI1PNz1cw0p2Xu2NJWuTIRG3k8nhyTNUkDdGLp1cWUVD60GxYP
 9YEYitBK2YdUU+J5D5QiYpMvKagfYy2m6HavF18FZyw1rfatYVPNeIotfW6ek9N00s
 7HeiMO4DqHl7aObkuiCig4Fl0vU/YIBwPVxgDj6iuqiPm3iBAaxlqIyEqf5DTbo88x
 vGGYb+vkq0Xocu1DB5FOtAB77zblnzpbECbWOwYoXY/dap0VhOo4vQhLoZJE5BbT74
 y0O2Vr4dgqVNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 B89AFE301F2; Mon, 28 Aug 2023 17:20:22 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <169324322274.341.6890205068394202418.git-patchwork-notify@kernel.org>
Date: Mon, 28 Aug 2023 17:20:22 +0000
References: <20230824160832.3195155-1-daeho43@gmail.com>
In-Reply-To: <20230824160832.3195155-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1qafuf-0003sL-4i
Subject: Re: [f2fs-dev] [PATCH] f2fs: use finish zone command when closing a
 zone
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
Cc: daehojeong@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 24 Aug 2023 09:08:31 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Use the finish zone command first when a zone should be closed.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/segment.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: use finish zone command when closing a zone
    https://git.kernel.org/jaegeuk/f2fs/c/3b7166121402

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
