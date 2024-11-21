Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29212D7878A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 Nov 2024 16:20:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tE9vF-00054s-DM;
	Thu, 21 Nov 2024 16:20:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1tE9v0-000549-Ka
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 Nov 2024 16:20:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w7f+fNxAj9u/p6i0vnOJvFwvQhgUNYEJ0m+ri+yrtsw=; b=PHSGojJNLxF0j9EdWkIXnd0O8a
 fsJvAlgATf9XO/+amL+9BTBEcQhWkU8Xyn1YRy1Ksr3mZkF0dAS6KoSyiDVEsg6gOHqLLi084Tmo+
 vJOLdkLPCxKM7rQCsAIu5jV5RrQSeOjk7bhXmBsgLUPZYPuaK2DYUBCljTzSwHJn2boI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w7f+fNxAj9u/p6i0vnOJvFwvQhgUNYEJ0m+ri+yrtsw=; b=Nm0bD2u+llmapdT3Wr4GQDv4X3
 cTa0ICoq0rTxyMFfVL6PjQobpJs97Sk+pDy+kiZKrWbf01GWC0HIVTQoApsiq5Pv9XmbQ1pHXY7dA
 ANDj3I2CTr7VCAXThwXSlwGGm5HdkNj7NK4No+E7WsBkLvNcDXu3ZhgHe7S/rKRLYdy4=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tE9uz-0003PJ-Ct for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 Nov 2024 16:20:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 520DFA40BB4;
 Thu, 21 Nov 2024 16:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68908C4CED0;
 Thu, 21 Nov 2024 16:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732206022;
 bh=bqQu65G8MNYzGEWaILMmzSkE2BHBOXHFe+2FM8Ac2Lk=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=VJ21L8STxb2sOSlkApjiy8GbFnZWaURh7A5znII9VA98j+rVJi0HDmaxuITmT9hXp
 /pjJtGIHuCni9jnfzks3LFilw9Nmz8owrF4R6fNxv9xmsDP8+OT0WIoNqV7y7T6cDq
 WQrZBsoLZC3zwFs+k0FkRbI55vJshMovT/anZubx8gGOrsNUQSnIIgxHf6KAjEbZ1a
 sevappncB8G+O/ZjfeEqmPnZsIFLR1ZgTmAezU3XqWMvWW2OtAWdpwZ5G9pGDbkKCO
 8iOIeFarRi8db4wjBvktKn5jYSccrT66vPl3l6shgU1SauYscfceFWx3sPG5MSBoZN
 vm2aKE12w7UZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 71D2F3809A00; Thu, 21 Nov 2024 16:20:35 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173220603426.1977996.11909007532583634351.git-patchwork-notify@kernel.org>
Date: Thu, 21 Nov 2024 16:20:34 +0000
References: <20241121082657.2644346-1-shengyong@oppo.com>
In-Reply-To: <20241121082657.2644346-1-shengyong@oppo.com>
To: Sheng Yong <shengyong@oppo.com>
X-Headers-End: 1tE9uz-0003PJ-Ct
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: fix changing cursegs if
 recovery fails on zoned device
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 21 Nov 2024 16:26:56 +0800 you wrote:
> Fsync data recovery attempts to check and fix write pointer consistency
> of cursegs and all other zones. If the write pointers of cursegs are
> unaligned, cursegs are changed to new sections.
> 
> If recovery fails, zone write pointers are still checked and fixed,
> but the latest checkpoint cannot be written back. Additionally, retry-
> mount skips recovery and rolls back to reuse the old cursegs whose
> zones are already finished. This can lead to unaligned write later.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,1/2] f2fs: fix changing cursegs if recovery fails on zoned device
    https://git.kernel.org/jaegeuk/f2fs/c/1015035609e4
  - [f2fs-dev,v3,2/2] f2fs: clear SBI_POR_DOING before initing inmem curseg
    https://git.kernel.org/jaegeuk/f2fs/c/f88c7904b5c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
