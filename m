Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CE3C7619A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Apr 2023 16:20:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pk5sH-0006nY-AE;
	Wed, 05 Apr 2023 16:20:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pk5sG-0006nS-DI
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 16:20:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3tNtwNdm1EeC/GYCSj5NVc1RVMytJda9za2BVKihOx4=; b=CxfTGnDe7sUuOgN0d5CMgvhAkt
 aSm6lQAgy0/DZb6UoGBqVQy7zpGjazxHCZQNjFklFZu5Z4KoKA0Vxd9feXTvWk1e0IF2BnGJu+mlD
 n0vf9seS8Gj5Rtj0617YKGbQJ7Gjpw6zYqYSmwzJN+yMvRKW8muy1AjXKS01hzZ4a0D4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3tNtwNdm1EeC/GYCSj5NVc1RVMytJda9za2BVKihOx4=; b=QQW4zRiztsKngW7kUlLC9jr/Nt
 d8nkf3aVws1RYkRco6jWF1gqt2CL4aK3BwEwUMg7EfH9rhNd3Pq8vbPv9Ma5B5+z2uOJmLmqw2oMe
 ADonPQC0pmcR1OSOagSYq/8EpuEPpXgMKeU9KkaOSAt9/Q//GpmdLPeqZut63SrupIsE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pk5s1-0002lS-Dl for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 16:20:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0B4A263F9C;
 Wed,  5 Apr 2023 16:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9905DC4339C;
 Wed,  5 Apr 2023 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680711619;
 bh=ThyosfilBVVjyHk4WXighduYLbTynjL9s58cnCVHZVM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=aJxoVoYNYyjmabttpuVoKnHjZJnLOT+c4qNTPL9xUw7d3Te7eCdz2Jk+ffek9nnyj
 zppWZ8q28i0qFeNwPZx4HqODtv9Id/8xng7fm1QJdc6tDLLUGMvbR5mdYliOm30ldw
 DsuuXZImfhbznFjtuVdXljBn7oOrmhLD4wRh+80Bz5NHItnDnL6juOPCOhYVhWc9TJ
 XjFmF4QIJUoY1fugdlJ+QVE0BN68W+3F2jjieae1XINEUfxQZGJmjxO7uA0PbV4luf
 Yfo9H14B/yXZ8gQDRccygjqfOyBjAAxu1lvPfYhxqpzENJW26CfGo3Qy+qEbWQ9v3F
 +nl2AmhrvszaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 798E4C41670; Wed,  5 Apr 2023 16:20:19 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168071161948.13885.219294727113368599.git-patchwork-notify@kernel.org>
Date: Wed, 05 Apr 2023 16:20:19 +0000
References: <20230330165648.33907-1-frank.li@vivo.com>
In-Reply-To: <20230330165648.33907-1-frank.li@vivo.com>
To: Yangtao Li <frank.li@vivo.com>
X-Headers-End: 1pk5s1-0002lS-Dl
Subject: Re: [f2fs-dev] [RESEND] f2fs: set default compress option only when
 sb_has_compression
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 31 Mar 2023 00:56:48 +0800 you wrote:
> If the compress feature is not enabled, there is no need to set
> compress-related parameters.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/super.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [f2fs-dev,RESEND] f2fs: set default compress option only when sb_has_compression
    https://git.kernel.org/jaegeuk/f2fs/c/338abb312bb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
