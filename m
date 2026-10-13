Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75504CC6B1D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mcjC7Izk/OkeBvIkK1Ax5wiVRKHhQv3nkDL9lK2sXZo=; b=cu/4LRmkcfnPu3P8AdkVS83NnL
	3vRfxXZaTTG5tLURxbatbA563Kw1GRV8YEcHLtr8wa6Gt2Gp4Plw3KiCmNb88jShh7NaIwpwSK0sI
	WnOWX8Ug9iN/Cr1djMYqQMqoEiDjFG43PQOkQ1vo4veHOyq9ulK4LDtFlxwwWIPmnwD0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGl1A-00024m-1u;
	Tue, 13 Oct 2026 22:30:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xGl17-00024P-TQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iL7Mf6jIc8YTauuGWv6Ut98w5FF51kZZTIY2cvT79XI=; b=KyHNmg7jWwPs42u8CHYtJbV1Ii
 da0N/1FCl2Y3/CKQ2t2/cu9o3e83HayPEtS5qHg7EhAhbwbm62HIbaurwUQZTgHjAJJ5LcAAXSp/g
 GiiP014i8XLA/BzJsx23eLbmcLfV6UW/3+oU1lBJMKFyfXoT2tr0YhJEG15L0jIorrtE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iL7Mf6jIc8YTauuGWv6Ut98w5FF51kZZTIY2cvT79XI=; b=GHJBOyTImhMpx97FiDD9Ups6jS
 y2Q6GJpTFvFd/1/ySn7AK5xAohGuBOGnT9ulWJ9z20vH1IEQOLGnLzuwwnYNFHJJT3tMtlW1oBI8c
 ZU4K0ksDBqQJhWvg1XJqevVk+Ix+jpIvOxnacpIwV2R8p/g4+et6C4dp48LztXslqVUk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGl13-00064z-S3 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F7906022B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 22:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0676D1F000FF;
 Tue, 13 Oct 2026 22:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791930632;
 bh=iL7Mf6jIc8YTauuGWv6Ut98w5FF51kZZTIY2cvT79XI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=DNpPozLZKc6pFvSsAg0QcucRF6uiPN9VJxr3LvufM9qKP/5BzoQ0Y63q3BJ7d38rr
 QOK3ZTgaEijosE7OXe/x8z5gFHsmtHTHYB35G2sV1u6ZedzLhEguKoBPUN17qnMSYU
 XRGrkQLBuBWK1WSsYF3zne0JufJkV0dFG88Dy+QN9F3EwoXBEB4pNZ7kOisTVxJNnb
 /V39V2Td4T/UQfjCBQYFTDzQS0bXy8vzSM2X0TEkxQyW4l1EJx8Gh82qeCGJDcBAyL
 gIxuttHNUzN2S7bmWlx0rNFNEgFIzfHMFLxAI8IrfnWa/pWACI4ClfrH6UUX2xqGqm
 Fi3V+7P29TA6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 F14AD39E4DBA; Tue, 13 Oct 2026 22:30:31 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179193063051.1493834.11557943978794677204.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:30 +0000
References: <20261010065946.1763794-1-chao@kernel.org>
In-Reply-To: <20261010065946.1763794-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1xGl13-00064z-S3
Subject: Re: [f2fs-dev] [PATCH] MAINTAINERS: f2fs: add dev branch to git
 tree entry
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat, 10 Oct 2026 14:59:46 +0800 you wrote:
> From: Chao Yu <chao@kernel.org>
> 
> The F2FS entry lists the git tree without a branch, so tools that
> derive a baseline from MAINTAINERS, e.g. sashiko, fall back to the
> remote HEAD, which points to master. master only moves at -rc1, so
> series developed against the dev branch fail to apply there.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] MAINTAINERS: f2fs: add dev branch to git tree entry
    https://git.kernel.org/jaegeuk/f2fs/c/beafa2721b63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
