Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50766C25B77
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 May 2024 21:16:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s9ANJ-0001l3-T1;
	Mon, 20 May 2024 21:16:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1s9ANJ-0001kv-27
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 May 2024 21:16:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y23JM2+vP/WnH9cnHRVZd4hdJ9zpxLEp5o0TSc4nu8E=; b=S9WohXFEdwUdVt/2psNNrWaa6h
 T7Pi6HDs+RLRsSqhjWN0/ExpmfgoltxVYAbYaT/cScbd6hJ83bfetD1mEytPaS99+zym3rqe27c5G
 M7KxAkMa/DsPUTbbHEaWPgAw0dHvAfKkewTRUSVWefOIQ7NTmbT96uj/3rhvwrEdQhkw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y23JM2+vP/WnH9cnHRVZd4hdJ9zpxLEp5o0TSc4nu8E=; b=TdVo1Lx+UeaSBotyAoyDugQQoC
 bNB0hPtc7uE6MYvvaKX+CVjGK0RIyF59NmvtncfQ8Z3V7orjT3bkXh92pDyAz2ytmBQd7kEcEcjTd
 gx2JmbKCAFd1bkoLCd2+OT6VptUwkzQSani7JzQ1DM8vhc0xQog16tE9uZ54kX9iydXQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s9ANJ-0005vs-1I for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 May 2024 21:16:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E216A61DED;
 Mon, 20 May 2024 21:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D011C4AF08;
 Mon, 20 May 2024 21:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716239806;
 bh=54hX8vPKop6i3pWXoGxSp4JmH6Mg6jeOTgisbEHYQv0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=E2WQhm58AqzZrWAiYKpT2/mhODonm7UeUACZ8sSVJYNiGsup+CqrZOEVgGVovEP5b
 B9+ls2rrS5gMnHfgg9mkBJY2HQOABVY5q6CExoV76M6xKg+P/7U6Llgrj1pneea9JT
 c2flWpduB8Om8QQQkw9XzCvvnjN4x8/+FTeMuwqN4HmfIQ9O3bpnd0hUFLxguKy9RI
 2Kp+mlLEZ9xMhMUggGmZyjrdJkZUkGDtdljdIvDcG0W0rl/Wtej4agGN5B7Qu9tFYU
 EIGW1k5wET4jWwLwMJe+l6cleneB0Il/C7vpyH1+av1Cx2iUx/cntUIWaBrMo+TabI
 k3JgSD9ioZdiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 7029FC54BD4; Mon, 20 May 2024 21:16:46 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171623980645.27511.8619360433381265549.git-patchwork-notify@kernel.org>
Date: Mon, 20 May 2024 21:16:46 +0000
References: <ZkumXs7POGImbr-k@google.com>
In-Reply-To: <ZkumXs7POGImbr-k@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1s9ANJ-0005vs-1I
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 6.10-rc1
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
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This pull request was applied to jaegeuk/f2fs.git (dev)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Mon, 20 May 2024 19:37:02 +0000 you wrote:
> Hi Linus,
> 
> Could you please consider this pull reuqest?
> 
> Thanks,
> 
> The following changes since commit 928a87efa42302a23bb9554be081a28058495f22:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs update for 6.10-rc1
    https://git.kernel.org/jaegeuk/f2fs/c/72ece20127a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
