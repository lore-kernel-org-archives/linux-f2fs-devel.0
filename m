Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98633C3271F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Jul 2024 15:20:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sP1mn-00073m-UV;
	Wed, 03 Jul 2024 15:20:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sP1mm-00073c-CL
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Jul 2024 15:20:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uJ/34KdmbCuaC3UQ7G1EPF1GZhTHA1MgbIFpP9y+0d0=; b=ivF3P+o3aL7ahs/O6iuN1lSABO
 kezx3y1vum5qMKCC0OFQJvlpCbOy+LERFnA3BjHgI5qI5hquG8jULyNrSGJRJp9oO/Zing3RIz2US
 uLqN1VUBJrSadDvCqv/MLsxjT/eDTKlYTzqoOOYx82yDMpyRNZCTEIeHqmkjfdrywlMA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uJ/34KdmbCuaC3UQ7G1EPF1GZhTHA1MgbIFpP9y+0d0=; b=IwiK/GRXMi6RXP94eTcFeW5bsn
 mF2PqSrxovOhWcg7+NVUnsmLJ73Tbn+qqCDD+qYyhPsGw0ew6yuCM1ZpujyiaGG4iB18TopbZ4MMc
 vwtwhOklGIIMGhjuPTGal6StF+3zBsbi2jZRK9Ex5ztzRcNY7UIaWhGdAJSNla8Lnivw=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sP1mn-0000Y2-HA for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Jul 2024 15:20:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id BB40ACE2CCC
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  3 Jul 2024 15:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04CECC2BD10;
 Wed,  3 Jul 2024 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720020032;
 bh=xtGOv3aLPxhCFBBgjG8W2YL0406yrQb1O+g/7yh26xo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=E2ILu5na/wnXEIrEcGPXe5Sd/TA92rwP6CHMdGuSGJXoEM2ed1XSizW2GaQV7ZYV/
 imSUydgHNPonVKNwmygh9AQKCEzYkU0UXZmOn7izgNUQFqEINCnNOqD2THWdX0o2oT
 5AT4iek4EfYj0+4vSQ7JxfFJFDr6e23LyaRwOBgv/sSp29QHvfLNlEuH0IYR8aAXmo
 AecGG8K39Qoo5l4Ek4xMPmxBQcDnnFNJPpoVCeEy55iNKudN53kSFyX9ffjwwDhaYW
 BaAXOjOpmFZSoQY7qy2Fpk96mfhysTnwiB3sO8xzIhullmPyXRL4rKwEcTVFVAm0vc
 uK39T8C+yVWxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 E17BBC43446; Wed,  3 Jul 2024 15:20:31 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <172002003192.26849.9405957512997166573.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jul 2024 15:20:31 +0000
References: <20240606095551.4089055-1-chao@kernel.org>
In-Reply-To: <20240606095551.4089055-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1sP1mn-0000Y2-HA
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove redundant sanity check in
 sanity_check_inode()
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

On Thu,  6 Jun 2024 17:55:51 +0800 you wrote:
> Commit f240d3aaf5a1 ("f2fs: do more sanity check on inode") missed
> to remove redundant sanity check on flexible_inline_xattr flag, fix
> it.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/inode.c | 4 ----
>  1 file changed, 4 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: remove redundant sanity check in sanity_check_inode()
    https://git.kernel.org/jaegeuk/f2fs/c/388a2a0640e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
