Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71934C2BD09
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Jun 2024 17:40:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sLngE-0003Eo-2W;
	Mon, 24 Jun 2024 17:40:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sLngD-0003Ed-3a
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Jun 2024 17:40:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3ZI0bDNvgnIynanqouddiAy9fDn3gCWPdgY3h/nIA6g=; b=NFK1Yc6YOXJcpT5DOe82lXZfa/
 9aI40O/l8H+8SK9ySlzDJ8DwOdkPB/BiCoj6t9psO7B/8CXw5rNClZOYR2/8gghQX/7Sfzu8O0wND
 Ssh0rcD+CiGiaPj0AwcBfwSNMV7kIhH9Lx8W1G4b2B87Z7PUVCk3zBV/wMC4NioBAEPI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3ZI0bDNvgnIynanqouddiAy9fDn3gCWPdgY3h/nIA6g=; b=fbn0t5vSoeyYDhq04IgBj1J0P7
 ShrNKFIxIxopeje4jjYteWgwJQ/3vJLh+Xj7sttiSwlmJGY1T1Y8f/cfw7C6vSmdlmZAm6QvL3sN4
 Jrk7sJlDI4biN0jp5n5jGkk2LJlu3VWWwNhygWpeVWbJISpQ2epcSMTDse3IJ7XDmZN0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sLngD-00023i-Ia for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Jun 2024 17:40:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 72D8A60DD0;
 Mon, 24 Jun 2024 17:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F5EAC4AF0B;
 Mon, 24 Jun 2024 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719250831;
 bh=y+3HBYbLlNGdn/StePP7MdTMbYY+NAYSYK1c+0uNZTc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=jAoOntiPcsQXOh41dcTZrzJwHDLIccPkc442vDJm6/PQYfu/nXmMAN/CJxTBfZC5J
 7bQy/+pGcFzN+tH6IZlX/jnhYi/+bMtyJK/u+qG0DIJOdSvRphlqX+aB0Lk8BSl8Q9
 DP2T7F46I6GKkQ9P38868EtWy2ovPzia1l1gfWb+aExNDNw3JqdwCb6IT4aU8iMkTO
 hjgRXqsY4zyV/CpkJBpa/ZhrpQPMdJHCcZRch9z05lhaNc5smaOP5YRlJdAPX5BGyJ
 emxSkRK+bLzT2L9ctHJbYgzlk5jA12dZrqtH6OFJ/slQctABZdBKmYLft330iYWvQN
 lSzrpDG/Xr9+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 EF3AAC43613; Mon, 24 Jun 2024 17:40:30 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171925083097.4247.3362095080701103412.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jun 2024 17:40:30 +0000
References: <1718271333-32179-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1718271333-32179-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
X-Headers-End: 1sLngD-00023i-Ia
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to use mnt_{want,
 drop}_write_file replace file_{start, end}_wrtie
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
 Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 13 Jun 2024 17:35:33 +0800 you wrote:
> mnt_{want,drop}_write_file is more suitable than
> file_{start,end}_wrtie and also is consistent with
> other ioctl operations.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  fs/f2fs/file.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to use mnt_{want, drop}_write_file replace file_{start, end}_wrtie
    https://git.kernel.org/jaegeuk/f2fs/c/1efb7c8fd8bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
