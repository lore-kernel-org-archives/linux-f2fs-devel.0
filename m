Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCB9CF6BE2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jan 2026 03:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+cQuU++zuiWi5cRtlbVo/Ht/ioOez6WB0N5wENbrwb0=; b=OKPujdJP10SD1ldOxiXZtJaz5A
	gRC4bj/OFwp+g1HQziFTyVRuejmA2g6MPrKhMYoEVvgU4LsgIsZEKUcNmP3DhAwbE6cfO1sBSZAxd
	Otv8Kvod5W+5LRH7tVUzm1/Bw+yn3VGR77sINEwlXX+e0IiYZkseyNYw+VbcIkLGQEvQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vdKJA-0006sJ-47;
	Wed, 07 Jan 2026 03:34:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vdKJ8-0006s5-DG
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jan 2026 03:34:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s4FLrqLD36gGVO5I7Gd58lTB32mSmr7GfA3BfOotIt4=; b=Npm1aVx0FlpB9kDqv3m7RZX5yJ
 By8r/cK+yrsezgKSEYjBvAFTmPpkBLqvMIZ+qsNjwqt0hT6aDRZfB+lLzRgsmHmJCCehc8zQl2rwM
 jDYDmsT4v8EzbbI7tn4ofjf6FoBR0a/YdGzlu6eiippKVGy30uGmSFoqWQrJB0+D1abE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s4FLrqLD36gGVO5I7Gd58lTB32mSmr7GfA3BfOotIt4=; b=JFVRT2uM6dn/WOx5kgVecPM0El
 6xSH4BP4NdQm0rEeGY89I3PkaotIB6UpfCtrTP9FNkLmumflLbtsPCmLUfs/nZpjxomQJs6C/ljeF
 Dk0rrXvXnHaYe7Rirdz6Gbp6GZ08HzOwWBM2qXD40GuCJY4SdiYBE41whoF56LrxG0pQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vdKJ7-0004Z8-S0 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jan 2026 03:34:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 489AC6014E;
 Wed,  7 Jan 2026 03:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1A7C19424;
 Wed,  7 Jan 2026 03:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767756831;
 bh=8qoYRR2Dl+JFcj5SLDRnMcHenZl1M4IermettvMHiS4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Rz3YOUZnXPltzHVzmcfQgND1ImpehmskJCnnn6ta1SDWvQ0BiuyIgpzDgec5SeRzA
 edX5LezK1xh9G+mpXeDPHpfQT4j8tjEs5RAY8U/mEcjB9f680Hw/3m4rdZSSpNIiwF
 Co3f8WNPQdP5GGRumCw1S9VZinZOSDnYqtG1kzeK0upkPYuE2ntCcSYsopKRiljBll
 /zQ51WJsy9SFrqlmtbK0gbdGzrKY+CdIJzFWDsli6P0oLvpKyPJW4MOr41tG/XcnjH
 RRYz1wYdhv6DImO8FyGYLAqxl4fd3c/oD5Z422NvuYruDe2e84OHU8yijuO5X4bf2g
 r/i1l8MjiXWxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B578D380CEF5; Wed,  7 Jan 2026 03:30:29 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176775662827.2218650.4842974959758200918.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 03:30:28 +0000
References: <1765957529-4285-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1765957529-4285-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
X-Headers-End: 1vdKJ7-0004Z8-S0
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove some redundant codes in
 f2fs_quota_enable
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

On Wed, 17 Dec 2025 15:45:29 +0800 you wrote:
> 1. qf_inum has been got and checked in its caller f2fs_enable_quotas
> 2. f2fs_sb_has_quota_ino has bee checked in its all callers
> 3. use sbi cleanup F2FS_SB(sb)
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  fs/f2fs/super.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: remove some redundant codes in f2fs_quota_enable
    https://git.kernel.org/jaegeuk/f2fs/c/3250bd41d95c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
