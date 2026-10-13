Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D67CC6B0F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WNvVtLWJ8aAZ9v0iWAGFdZ7uIycceH/oFgM+/1WP2oI=; b=gzFzinzYtOZh7ILElvDnCWeWUL
	zYyl+09ckRE2r1J7SB5dqQOhWGarFHylx4XPnCezlTAj/mswAvw4K5y/whHc1TyJ7l/vkl18yRdd3
	+p6RL06YnVhnreLDGtgXuSon8QcML2nAwCq5B98QAzxxPVGnNO1ghjuXkkfyu1/NlFCk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGl11-000231-D3;
	Tue, 13 Oct 2026 22:30:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xGl0v-00022d-IG
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z7koH2y0BTGH8zmggvnZ8uRcI1N0rUKHZJp7eUeYBVo=; b=ISjZcDn4HyXxRbqtPzBynSpxSM
 RlLgsECf+8+gLCpRzwStegottjw359qzzsLjcH+Dc3gZP/BGiqk4inN2ePk0FX9+LCMZqBcVCw8zD
 H18asdj+FlYJxO3KUXlEh20Fi/n6ZVip+O+T1w6ScjlPHh+Q+idSkGEdNVxof9QT2prY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z7koH2y0BTGH8zmggvnZ8uRcI1N0rUKHZJp7eUeYBVo=; b=YV3vaJeaGugD7UiMOmrvkXKkQu
 J6tSgMTCwNha1lLD+K0jVdvbKi5fI2Z3ITCo8e2JRiGnSibAm49v1XYlTpTrQTwy/fOmSj1gxlBaA
 A0YxvJqCaH1IZKILwJSCEIIi56Z9hqLH8r7QdJmuJSCoZWKtKlt7DLGe/+y0PziBEU+k=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGl0s-00064V-EU for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 290EC4376A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 22:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D241F00893;
 Tue, 13 Oct 2026 22:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791930621;
 bh=Z7koH2y0BTGH8zmggvnZ8uRcI1N0rUKHZJp7eUeYBVo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=Di+yxQHLzuhB2FlSKW1Qs30YUTePeMkcVUwDhVbngaMj8yMvjKoYDCKMzUQ3DFScH
 abibWO/XWKYvoDaY9aL0m8pikuBrclR5a4gVhUdQWssuuPxkcoK8vu8BIZs2xXg6fx
 Rnlxcepglv5Xx3CqFGAVROzBiK7ShPmnCAyR6YWbAYL5TlHGERXMUF4dB/y55n+a9Q
 ztSeMgOSs3ttlBI+njh9d3ipCU+vU+7zm/V/lmH53CEE/+gxl/XkH5HfoJxvCl6zmo
 cvx8Maxyw+LXuNTo2ceKW7OgjJgnLtI4zANAdZpqfJl4k/kGMTmcTtthSBfXpUq1KK
 Mb1qsgwIkYL8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 F14D239E4DBA; Tue, 13 Oct 2026 22:30:20 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179193061951.1493834.15484105620575468215.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:19 +0000
References: <20261007101738.2348038-1-chao@kernel.org>
In-Reply-To: <20261007101738.2348038-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1xGl0s-00064V-EU
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: skip node_change lock for
 inline data writes"
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

On Wed,  7 Oct 2026 10:17:38 +0000 you wrote:
> From: Chao Yu <chao@kernel.org>
> 
> This reverts commit 66eec36c2421383e5b32e9c1740f656474c80df8.
> 
> Fault injection + shutdown stress test reports inconsistent inline
> data after "f2fs_io shutdown 2" (mode=lfs, nonzone, segs=1):
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] Revert "f2fs: skip node_change lock for inline data writes"
    https://git.kernel.org/jaegeuk/f2fs/c/5edbb590dbd7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
