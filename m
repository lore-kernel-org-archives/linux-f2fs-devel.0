Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F08C55174
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bj8roUbk/fMubyfgHxq+C5M2FdbzPr3zgS7HrPWkmaw=; b=hpjF6R3nFy4ymRDcMBzTcDRC2B
	UxoQTd6RUheai/vKztVcU0mDKWzDjcwkHBr2WTidKYihqUCGUjWJK+6a++70J7LAcEfPSxkxWuMlR
	cPiE/UpJiL8hf3KzymsZIm3FWhAxZQG+OP2cPYucb6UUn4qoncxZMAristME8VrKiuTI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrj3V-0001gD-OS;
	Wed, 05 Aug 2026 21:21:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wrj3S-0001fp-PH
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JoIn2woWP4yvg4R5//bLnyYh8omIezrzh5bc4PqgSbM=; b=K+1P/RB4uZ4dir1Rkqj+tBY5vY
 TZM3mcZJxJNq05WB01bd9aI1oGMB9z3/ckzoSYxMcq/7V0S7gWVyuwRpTbr+dQWLDXnwHcJm22wxB
 ECDOcc0QLeNdMQEBymZQSuRvER13O75S0Xb54idBrHBoz67MxT90p49nDqHtbFtbR97s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JoIn2woWP4yvg4R5//bLnyYh8omIezrzh5bc4PqgSbM=; b=i35qji4N0/JW6PYOzP5OajdIFm
 tCYupRjMJ++hjUaXtDqaC+foIXedFHRtPbGgHsVeh6mW3uCYDwETxcuQa1paWATs5hUsCJkLO0a9T
 oU8GIDrAprKg8+vUJt+UwL8fPR43fMDsYTHkmfo2Xu+b+RzLmUPOHfqWqyYg1Xqsrh+M=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrj3V-000447-3N for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6065A60A64;
 Wed,  5 Aug 2026 21:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1596B1F00ACF;
 Wed,  5 Aug 2026 21:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964897;
 bh=JoIn2woWP4yvg4R5//bLnyYh8omIezrzh5bc4PqgSbM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=WFmXjPo2ixpiFbTBSvZMqOT/j3gD2rhOsULGAvWISLMWBTiCn1hSCO6Cww/9CR8vU
 JfNgpKS/dWbUaM551DNLHRYNzL3u90r4s3kjevdtyRN8OGhnnZwjw2WCRSvF4E7kwZ
 0O6CFTXTWQIdy/3hcVThmtm/cIwuQIu8SKN+Nt2UxW6olHith1SRZzEe9H0lbQlELU
 Uov35Fd9uUTxd7/4mIPekGMGvuOlf4H7vbGp8t5pwow1PYL/HfB7HddeFUhUm8aLWS
 JFDG7U47DaMovtAqldbeZ12ZVyYZ977oLdVNEfdrwBTctABiWj3yO/rOyEsW2PR9an
 bgtCh44RQqekg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 198A3392FFD1; Wed,  5 Aug 2026 21:20:58 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178596485663.530543.6106799937167752297.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:20:56 +0000
References: <20260727130430.2109181-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260727130430.2109181-1-qiwenjie@xiaomi.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1wrj3V-000447-3N
Subject: Re: [f2fs-dev] [PATCH] f2fs: only redirty pinned folios in
 redirty_blocks
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 27 Jul 2026 21:04:29 +0800 you wrote:
> redirty_blocks() pins folios with read_cache_folio() and then walks the
> same range again with filemap_lock_folio() to redirty them and drop the
> references it took.
> 
> Commit 5951fee46bef ("f2fs: Use a folio in redirty_blocks()") changed
> the second pass to a do/while loop. If read_cache_folio() fails before
> anything is pinned, page_idx does not advance but the cleanup loop still
> runs once.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: only redirty pinned folios in redirty_blocks
    https://git.kernel.org/jaegeuk/f2fs/c/85171332742e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
