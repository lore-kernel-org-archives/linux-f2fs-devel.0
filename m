Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70748CA0EE4
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 Aug 2025 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mDJfBnjWxkIxwDDTXJJQvOxk9HVIqtsr4tEIxMoGNFs=; b=T7R9rWYLDSYyD5lmxHlErlZQGf
	5fTZOYjaiJYshdwfQ0y5w7VYfTnwRRCQh7EUvdJR8J2RWwEo5wSvgnBvKqrdjDY5WybVmShVyNGfH
	7aq5YOQFpN95h2wB3TrMaKbEPf8n0uWESKo7c7k6LWze/7R9sOgX/945DHNkbNzibMCE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1umxTU-0006Ue-4e;
	Fri, 15 Aug 2025 16:40:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1umxTS-0006US-VS
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 Aug 2025 16:40:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1flBvWd903OGEQO9jRffzRuHWTqoDkBRajRyuWQgbWM=; b=AS6gktUpJueBrZTlGQ+/Q4EeUf
 l5ZSeHmC0OQcj+xeMp0jIW2rEV3B3s3v1HHFTHFYbwpvwnE4K7siHFWwYoNR4aT0HyKfc3TOl++XF
 HoZ6ShODnrNfHsNk3YF0OaVmLrfQwxXokP2KO4mosCHvv5JcWRr93hcGWHUli+rb5ZM8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1flBvWd903OGEQO9jRffzRuHWTqoDkBRajRyuWQgbWM=; b=QizgRSEYuFKc+EvEAkRwbVNyFd
 TwqF/EtcgdwTt30Ui7U5mNKRJdenNCi7sNTvRYG3YrD3oe8dPyFiXMrrG5zJUHkKNFE+S2UMv+Ddj
 hxOQHJnO3u7yh/rGhA4nFnO/1uXI23wgvqk8jQDY+q7YoFil4OHbi1a02gpjFjvyywwA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1umxTR-00018U-Hp for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 Aug 2025 16:40:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 313535C54A8;
 Fri, 15 Aug 2025 16:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D461BC4CEF8;
 Fri, 15 Aug 2025 16:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755276002;
 bh=TaOMQeXhqcnT5V3o4OlTOg8H7abGaZNTtOBC7Bmmpm0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=gI2tN7MG5p29R+xH9tK4CkKGqZxVNt9k3RtD/MDPc1c9WPe1EQ/xXO78J+EBiWLgr
 E0yoWWbk9uaBmmJFrTpFvU2KA81Rry9kG+PZcE85bkJXqC2Po1Ka+bO+7EvsNgs9rt
 MWOQjN1FFh1Zof5pX3aQxXR4p1O1kjBH7y1LCcn7rLhd4nxhb6mlI2fcBFVKgiMRvi
 t0KW+xcI4oIqG1k6wgO0pqn3hpVH/MbnQ012zbxMv2zoOiOk6If8Rwild+/q1rUdSL
 Np9HKaGI5OpacvhJgCKXYirBvgYPtvxs/CZ9YZWNsT9d2hXXPqquNRBe1+aoyrD63H
 Oyio1IatdExuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33AF139D0C3D; Fri, 15 Aug 2025 16:40:15 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <175527601374.1161945.5893308622119407321.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 16:40:13 +0000
References: <20250806123236.4389-1-masonzhang.linuxer@gmail.com>
In-Reply-To: <20250806123236.4389-1-masonzhang.linuxer@gmail.com>
To: mason.zhang <masonzhang.linuxer@gmail.com>
X-Headers-End: 1umxTR-00018U-Hp
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix CURSEG_HOT_DATA left space check
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  6 Aug 2025 20:32:36 +0800 you wrote:
> This fix combines the space check for data_blocks and dent_blocks when
> verifying HOT_DATA segment capacity, preventing potential insufficient
> space issues during checkpoint.
> 
> Fixes: bf34c93d2645 ("f2fs: check curseg space before foreground GC")
> Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: fix CURSEG_HOT_DATA left space check
    https://git.kernel.org/jaegeuk/f2fs/c/066694aac462

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
