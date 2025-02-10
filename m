Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D0DC0219B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Feb 2025 17:30:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1thXbw-0002NA-8R;
	Mon, 10 Feb 2025 17:30:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1thXbu-0002Mx-SR
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Feb 2025 17:30:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VtOBtpWpXL1G88rz26gKAlSoFKBQQ4AVk07VKGAXRmU=; b=ilWYGz09M2+PDtrOIP+l8mitPa
 EOGaGXSVI2TdVfDGZoMYuzeqdWgcA1/O7amaFZd6zaiapz1DwigEOQeKObvWIKRbcb89/h3M7zYNr
 3L24mviEd4X2CJRJTeB8RirMIwNOsP7vghAlgN7jpRZHftfkbjdPOyFJOZOySGIrVnRM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VtOBtpWpXL1G88rz26gKAlSoFKBQQ4AVk07VKGAXRmU=; b=F9RKPO1U2A/iRoQKebptaaChZn
 udFmN+mdMAvG6q/7+2xs0CkQ2XKc1FFhbZRd6nGO6NDn23pOj/T7yr77I5NwsFSSx/ZhbNLLnD1Gx
 8mnsgQv4Igmd30OAdSNXb0gxbjJnnn24jS1BC5INsIpY5BxYmg59O5lpJWKqZlgfsMgo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1thXbt-0005Qm-U0 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Feb 2025 17:30:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E11BE5C5CFE;
 Mon, 10 Feb 2025 17:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379CDC4CED1;
 Mon, 10 Feb 2025 17:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739208612;
 bh=bPe9LIG/drrnqprJKulv02oVjfrWQtDlPp/JMf9iM/I=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=UbhqunpiUj4T0dAHLKpFT4aonN16xuIIlkoRlE4BJ5Q2UK5D8l5w8fVZJRZ20TqfF
 ODmg7nFDnfJbUmXrZCL/DCiC/qAhzNbww7kaziTjbE8/yFgeiDEEzTO8p7+ppMsVVR
 9JtQgBLvhDMqHAKe9m3XWLDqDbpuqGbZfKPoCQpV5v06JlDbi3HK8W0S8e3i8FuHYw
 NhuauKMgm4XixzmGv8/XSn+C6ja46olg1UBe59uB9EjboAJoZ2+lXOAkJ/2V0OSweg
 q8TMHjiIDa+lNvZkeRwgK7gjYgtIkUA/4ZbQz23fOpeR6ofl7Fkd+icxkzXCNwjsVC
 HtLDXOTHkaVCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 EAE27380AA66; Mon, 10 Feb 2025 17:30:41 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173920864074.3835961.7030694610964519057.git-patchwork-notify@kernel.org>
Date: Mon, 10 Feb 2025 17:30:40 +0000
References: <1739150649-31850-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1739150649-31850-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
X-Headers-End: 1thXbt-0005Qm-U0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to return SHRINK_EMPTY if no
 objects to free
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
 Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 10 Feb 2025 09:24:09 +0800 you wrote:
> Quoted from include/linux/shrinker.h
> "count_objects should return the number of freeable items in the cache. If
>  there are no objects to free, it should return SHRINK_EMPTY, while 0 is
>  returned in cases of the number of freeable items cannot be determined
>  or shrinker should skip this cache for this time (e.g., their number
>  is below shrinkable limit)."
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to return SHRINK_EMPTY if no objects to free
    https://git.kernel.org/jaegeuk/f2fs/c/bd409934c061

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
