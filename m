Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9FAC55ABF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sQBSRSYRuU2Ip6lNO1C+oFoVS8F6emSqFPC1A2P1XrQ=; b=E8OMws1P7JKkByTJfmRIxURNVk
	oOrEP11j3AgHWMQAkpP0Q1huYvSAOWQX5MM1Pq1W8omRbQqK/i3it0dEm5J9dpf9k0OnCx103jsiv
	fyuoAaS6YnczqBTyNeb9eQEQoWHQuFzzeLlC69wi++ThVfP/1IucbnVkrW7fUzgfzycs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrj3b-0002Dg-6L;
	Wed, 05 Aug 2026 21:21:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wrj3a-0002DT-8V
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2/fM709Pg/bgckhFhH76yMCJSmUBEznqcuKehwxt5lc=; b=WPq0yIsj1brBiLy3jvvg7MNJyW
 feIwO3mtFu7AaDOyCAJOkDE6fHjZyEbURFWjTdHgSbA+Uz5717jkA0b47uB/OZkg3H6nRct4zDAbC
 l0oVWeJefam1aWfx5/CrHjUgARXb9z7A3PHvu08jAR4uKemxeDRkt+AfLp8MZ6aRlQEg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2/fM709Pg/bgckhFhH76yMCJSmUBEznqcuKehwxt5lc=; b=OT3vvNAXQ/Eo34GUyJ1En8LQCw
 0gnLBRxzcCHZ2rDPNMUjQDSdaxci5V8GDGNHIiVD5CgjueEZLlJM32TDltgksojX76bIMKWcY9l0B
 2XR6IW7PqflCwAtVK3Y5JVpt+HRjC7BFUefOi50SlsBXYIcsO0/nI4ZfFTGdJo7jZiso=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrj3d-00044e-0I for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 32E9143CBE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  5 Aug 2026 21:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A201F00A3F;
 Wed,  5 Aug 2026 21:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964900;
 bh=2/fM709Pg/bgckhFhH76yMCJSmUBEznqcuKehwxt5lc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=PDPoF5iTExTBcD9oPc4sRE6CHEhDE9V/pnQd7ksRXdyiNUMneJNLLkn7Bui65pHvl
 ew1ofpjkF7a8GUjIiRT1AWBUBLE6OhcagcRz38srx5uNSDZZO8KfrALcHnR1Ki4ges
 HGACsEqYCXS0scX/d3PvTpJkfNyyD69CvvpwyHG8co4qGFP4F+O1vfAvO5CPHCuCj5
 YxgEiEEzBZQRF14i34FR53gLH0rLKVbhb0Znijeo5DOU+hWiA6E0aCbdVD1qnITH7h
 +PqtSqvV/XZnpWNV/BxB3iak4CLqol/PVL3JpH8eTcqFoyMvTZJ9dhRPDnd8+zDEKx
 He1mOuK9oTHyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 19864392FFD1; Wed,  5 Aug 2026 21:21:01 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178596485963.530543.15398154731593436736.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:20:59 +0000
References: <20260805122050.665256-1-chao@kernel.org>
In-Reply-To: <20260805122050.665256-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wrj3d-00044e-0I
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid unnecessary shrink in
 f2fs_shrink_scan()
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

On Wed,  5 Aug 2026 12:20:50 +0000 you wrote:
> In f2fs_shrink_scan(), let's check if we have already shrinked enough
> number of memory before calling f2fs_shrink_read_extent_tree().
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/shrinker.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: avoid unnecessary shrink in f2fs_shrink_scan()
    https://git.kernel.org/jaegeuk/f2fs/c/7173538c41d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
