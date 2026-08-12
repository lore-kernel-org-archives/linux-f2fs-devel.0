Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC19C5CFEB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OpiGdrjAY/uuxxSrYLSthZTTm60x85/yw4ZaFIpwrpE=; b=hLsnGV9AEeSrJjyhVGm7cUp+St
	QcfWzN9UQcOzwy/cTDmCIuT0RMnG593WrwzpctXQz9WR+AFIeNqjTpFzZLuqyjD0XG0BZma0dbzj9
	gAgnZ0Gjqsagw4Q4BICsk+P2XV84uft2T54Y9h32iPayhIIjifjj+D1ZVmF4IzFMPu6w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuFbS-0004st-Aw;
	Wed, 12 Aug 2026 20:31:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wuFbP-0004sY-0R
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 20:31:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0KsMbcIsQ6Onf+LFvw3bMprRVz8+BKo+sixC1zIUR2I=; b=LfirSQjirvRqz45ROHT5mQ5nty
 J1M4BNZiBdqdqGYwV0Rqt6S4Eu8VVI66OM/az56T7Z9oSX8o+5Kt8OHeYhMw+1O2gXk4Ki+nSE+78
 jNJw9sOgh0VXpBvBYrYjvVTIHLcTWfXxCyCmoGx1tPmRlgqCJi+lwVlN29K1R2XT75VE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0KsMbcIsQ6Onf+LFvw3bMprRVz8+BKo+sixC1zIUR2I=; b=TtEdhLUG4Qf1anNrDkSB9OeWAC
 ABPuXrx296d7yKeigOJ7uL/sxfcTt0/oamGVvSArZBSXc2/4S5yaw3uEkh40Jm9p0CXzjC3lz91zq
 eztQrAauouRRt/yyINmHqjlJt8sa3/GOpBioadrWH1XXHEv2uDfi7Pu5YiFArEQw39ks=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuFbI-0004xW-G6 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 20:30:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A9DB240279
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Aug 2026 20:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1141F00A3A;
 Wed, 12 Aug 2026 20:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786566651;
 bh=0KsMbcIsQ6Onf+LFvw3bMprRVz8+BKo+sixC1zIUR2I=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=o2ABs0WrZzyCEo1sjEIXFlsJ7SbluyN0FdUPY6I1OMDPzBuhn6fyoiCu/ltRucqdh
 DHai023EoUhaSlnAT6YelcpeFp6m6REEakm4j9SGwGQK/SdXQKWMg+j85jmSSlCUFt
 bWQCQZ/rgg0QyXkTkwc5JbrZuG4ToGuxpCbC88RYxcxCIhRmxL2Fg3Y/nNebTmD89x
 p3tzZ9kIF2rjE1AflPOWXBzIM52JY543CGDPkU45eqVSYR77ji+9RmbqkobfT/i1nQ
 LNwXVLAoCxML1poW+7RVSf86PTzN9OM/HlsEEwvimiGQwfKc+iXlUQ1QJg1VDJm06v
 FkW2GTd9HPUGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 196D6380CEC4; Wed, 12 Aug 2026 20:30:08 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178656660663.2090005.4601812465227179093.git-patchwork-notify@kernel.org>
Date: Wed, 12 Aug 2026 20:30:06 +0000
References: <20260811071637.4176024-1-chao@kernel.org>
In-Reply-To: <20260811071637.4176024-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wuFbI-0004xW-G6
Subject: Re: [f2fs-dev] [PATCH v5 1/2] f2fs: fix to off-by-one issue in
 f2fs_zero_post_eof_page()
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
 stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 11 Aug 2026 15:16:36 +0800 you wrote:
> Otherwise, it will drop one more page after new_size which is not
> necessary.
> 
> Cc: stable@kernel.org
> Fixes: ba8dac350faf ("f2fs: fix to zero post-eof page")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v5,1/2] f2fs: fix to off-by-one issue in f2fs_zero_post_eof_page()
    https://git.kernel.org/jaegeuk/f2fs/c/b2205d3cfd6c
  - [f2fs-dev,v5,2/2] f2fs: fix to zero post-EOF data when extending file size
    https://git.kernel.org/jaegeuk/f2fs/c/5eced87b7d19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
