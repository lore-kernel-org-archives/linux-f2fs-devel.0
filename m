Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC513CC6B1A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LXXtcIQuHkO6sHMJtXNPdRnNA1ZFcexFgp2pQT2D3QA=; b=l4n+Ro2lsFIy3KjjdSdGXaAMu6
	gh6tk95Ew3Aq0xctS/Oyh41GWfCvzaeG+J7v45RG87cdbFfDGsZAc/df+tQvZdX7wS0/8yiSeYRNJ
	PXbOUt19Dn2X/MG4tnPokwC39h+oESW+a9Z6rtb3cHHmYXjRrh2N+StZv63SSGo0I2/w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xH1F8-000249-CS;
	Wed, 14 Oct 2026 15:50:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xH1F6-00023s-CQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 15:50:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pyl6fsjlALOtsNftcws3Dg1M1c+Tu/Aj6kAH2+RiKxk=; b=lNyYDtJR6zi3UKjGCbhU6iE77v
 RGNKoz6t4RJ0BQ4vNGvw414vz6MDWG4mwf49TiRQ3X//CaQc3hFfnmMAhmJ80qAzd+YCSH2E2yyPN
 XSO5+DZhrlNtg2NEn3+J8XcZC4wbfyf9K5+MvCGqnn6jiQxiiX6F026s/ybaWpF0opL8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pyl6fsjlALOtsNftcws3Dg1M1c+Tu/Aj6kAH2+RiKxk=; b=PnHtDHXtIFKNX10b0cuy+Aqilg
 7zClS14RIMHovagMAnemvzflRqJbNOV/Zx3ir7Niz5Ck9vsh4ilFUQcRCfZhPRg4sHb4F8TPMcT8a
 pNjHeH6eodVRtBxlRIAIo2eKRFZo6pd9YG6TSiEUBk4ZTBGvSnBKs2GEgXuMz6zxQoE0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xH1F5-0005l7-Nn for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 15:50:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6198B41345;
 Wed, 14 Oct 2026 15:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4330C1F000C4;
 Wed, 14 Oct 2026 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791993006;
 bh=pyl6fsjlALOtsNftcws3Dg1M1c+Tu/Aj6kAH2+RiKxk=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=ozD2Zc0ev8bDoszabx2g6KdltOxzlkP94jNgr2EhArBDPMeEnPnKmBZtE9Mc79v8d
 bj9fiekU/9mTTo9rXubaLhyRVcHI1olZBHABfyyhX9AYdmg9JQLffeDGYIMsRTNFH7
 cwZ/Xs6PdW+S/eB3rBHRCCNYPH0LLubo2GwqQlg68zXI7/ZodfX+JA2kyPdR8dIIqM
 mjP1uK2h6MUx8sE1XU8aqdP2EWrU1m8S4233vrs9d1zrxMip0ip6mN08qzTSz8v4Ur
 TLBzFuqGLsfhuGw1s7NlUm+HaPzt55oR88DJ712UMrLIPweQgb5fnh52nGZqbQy5tY
 ft8DOKvoskDJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3A46339EDE30; Wed, 14 Oct 2026 15:50:06 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179199300502.2827562.13039187494751093723.git-patchwork-notify@kernel.org>
Date: Wed, 14 Oct 2026 15:50:05 +0000
References: <20261002064853.37782-1-jsjlee1020@gmail.com>
In-Reply-To: <20261002064853.37782-1-jsjlee1020@gmail.com>
To: Seongjae Jeong <jsjlee1020@gmail.com>
X-Headers-End: 1xH1F5-0005l7-Nn
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid unnecessary reads in
 f2fs_update_meta_block()
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

On Fri,  2 Oct 2026 06:48:53 +0000 you wrote:
> When the packed SSA feature is enabled, f2fs_update_meta_block()
> uses f2fs_get_meta_cache_retry(), which reads the target block from
> disk if the cache entry is not uptodate.
> 
> However, f2fs_update_meta_block() overwrites the entire filesystem
> block with memcpy(), so the existing contents are not needed.
> Partial updates to packed SSA blocks are handled separately in
> write_sum_block().
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: avoid unnecessary reads in f2fs_update_meta_block()
    https://git.kernel.org/jaegeuk/f2fs/c/e8bc653c0d50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
