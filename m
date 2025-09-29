Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F62CAC5B9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Sep 2025 22:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D5/T5Bx8D2b+YfJ9D489OVy/zaJGfU3RXHB7b7L0WDQ=; b=ZDLQyaLAA4vXvR5yI5Iasi6+MU
	15eLgEApegY3WFQilExQERLXKq56sBh4kjt7B6UsAdEB+yOSnrOueT45hdTdnQi3syApYGpvzn9ks
	MFM6J/l6exu0f89Dihu35dqkCm9gGNzremlhqMYK+C4FJn3Me5jxFM4VCZtT8N/hYajU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v3MOQ-0001nM-GS;
	Mon, 29 Sep 2025 22:30:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1v3MOM-0001n0-Qd
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Sep 2025 22:30:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PI8DM56r/Qb5QPQAVFFruR/tiQ97RJ1KmJN/Kdw6nms=; b=f/C/LlUlal6U6/WQDjUeaFTwUJ
 V7i0zs0dFpoPtTpxqLpXHsMxegXQ01D7CN1zfDlcxPilWow/szbqQFps2KXQsvQD51w45fs5ZsC8B
 8Ph6EgN97ZRQhFvGi0bHqRO3madQqjtql9BedJnIrk1KkZX/Dv1jNPuhbBYnlyEt4MDg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PI8DM56r/Qb5QPQAVFFruR/tiQ97RJ1KmJN/Kdw6nms=; b=jv9FJnpPWPMSGoizlchEOGpZ43
 ScSfp55v/KBarVjnSpRn1+O3uztQa62iZD0oZ8e9U7uxRCIRvKknkIzsFpz2hlA0+MEqRiI5xuSl7
 SHegv16kNAIlMSwpMM8RlUxgU47HlZn91zRK0CIekch/gkayDhlt2Cxupc+z1+gdCHKo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v3MOM-0005OC-C3 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Sep 2025 22:30:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D8DC43693;
 Mon, 29 Sep 2025 22:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF04C4CEF4;
 Mon, 29 Sep 2025 22:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759185034;
 bh=aR5kD0w1ADceK2J3Vt1M+GkVQaDpv+0TaN6cruVL9zI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=YM2iwRwmxKBBe3IvGmyG0pGF9+FZa7bAsGGtuJOugOoELb5wO02mFWY3xdf7HexOL
 IbSwcGAZk7b1vzX/TMV8zk2dw8ayNBVy/8C6w3hPrJoIWX3Jax1CfXfBOnK2++bERO
 rsA0nIyKNAOsotZ9LExVmgsALcaDVe9IQm3pqb9fecaP2wwUkkqGhgJrI0OEXEkxyH
 AzTYU19M+ioiT23k1tUBXrBUP3XLm6t1ScWjojsTByMaMQgqM367t9b7Mhh4u1SVdk
 W1kGDLEGPAxRaJBaLA2oSRjFPZ9qpxv3zLUwgUW5Fe9Se770aJmElNnQKm+VELfKY7
 VPsoJf3/Hc3tA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 EB31239D0C1A; Mon, 29 Sep 2025 22:30:28 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <175918502773.1733438.7019947072233601645.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 22:30:27 +0000
References: <20250924074358.253759-1-yunji0.kang@samsung.com>
In-Reply-To: <20250924074358.253759-1-yunji0.kang@samsung.com>
To: Yunji Kang <yunji0.kang@samsung.com>
X-Headers-End: 1v3MOM-0005OC-C3
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: readahead node blocks in
 F2FS_GET_BLOCK_PRECACHE mode
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, sj1557.seo@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 24 Sep 2025 16:43:58 +0900 you wrote:
> In f2fs_precache_extents(), For large files, It requires reading many
> node blocks. Instead of reading each node block with synchronous I/O,
> this patch applies readahead so that node blocks can be fetched in
> advance.
> 
> It reduces the overhead of repeated sync reads and improves efficiency
> when precaching extents of large files.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4] f2fs: readahead node blocks in F2FS_GET_BLOCK_PRECACHE mode
    https://git.kernel.org/jaegeuk/f2fs/c/72bdca6231a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
