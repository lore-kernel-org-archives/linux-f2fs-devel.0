Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBD6D5D689
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 Nov 2024 20:30:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t999P-0000DC-7W;
	Thu, 07 Nov 2024 20:30:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1t999N-0000D5-AF
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 Nov 2024 20:30:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6En+GSC1lt8iGr11dvwM6elCHLbf8w9RJC8Yk/l1phE=; b=QiEC1k4j+fPX4wx8iHLsxK8CaG
 hYgMEGhzfaUaa2OIuOfTDbIPDaXCtCW3Rb8bE8VB3Wf2fuGHpgWIXPTYl4Q3A+Q3fVNpIabDW4s5i
 fBrYCP6UmHHVKprwp1iSodnJuHi+9wCanSygvRfDCSSeiosViSLX1GTPPvMuntr9GHeg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6En+GSC1lt8iGr11dvwM6elCHLbf8w9RJC8Yk/l1phE=; b=mLwQ5Q8M5kOhsrkIIFK8JgMj2j
 p1/ICdnwchRsvpoO+QBpg+RkuKxxL9MGQNGvCwcvZbO4vIyLkYkFFRI7WPiZZrxqDbHTevMtj2h1P
 svgklsGgynRapEgJZU9Vh135UyCv0Hihw1dmxLffZZuKnr2fDLxG7/kl0oBJuBGpce70=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t999M-0003tt-LZ for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 Nov 2024 20:30:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A6B705C4DAC;
 Thu,  7 Nov 2024 20:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CCDC4CECE;
 Thu,  7 Nov 2024 20:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1731011430;
 bh=XxyYH8l/Y7eByhFzcGMgEQOD9yhri/88JH4DpmxXwYk=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=LUarq3AKb8jlnULjdtYqmyie90C1OW/7a5JUaMkj3O8gAg3op3tuLVnz6r987YAGp
 baF8o//7Q2s+A+tNsA+0lmp9B1WrYwyPBdUk+lrN+Vhnljk+JWi4G54Pf9Q7mbwfPJ
 r2Sysk3eazw6blZFNC0I0vnogbWvme4gf8QdGuioe9/wjLiv13c1UIbFX56TnqMtbg
 dDg22UaaLk18qCuaLyVio0hmHPQtaJAgGUu5R2wZoekzH/yq0pVbKf83+A5L0yyeTC
 S+tEf15RmRi+4CnvVNU9Ll2/wqTY+YzQH0RQKhSSDw3jr0Hgy/Pei/Rb53RPGdqWXI
 KFfZFR1h9s4QQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 719773809A80; Thu,  7 Nov 2024 20:30:40 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173101143905.2084993.15250919555869983751.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 20:30:39 +0000
References: <20241025091823.2467074-1-hanqi@vivo.com>
In-Reply-To: <20241025091823.2467074-1-hanqi@vivo.com>
To: Qi Han <hanqi@vivo.com>
X-Headers-End: 1t999M-0003tt-LZ
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: modify f2fs_is_checkpoint_ready
 logic to allow more data to be written with the CP disable
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

On Fri, 25 Oct 2024 03:18:23 -0600 you wrote:
> When the free segment is used up during CP disable, many write or
> ioctl operations will get ENOSPC error codes, even if there are
> still many blocks available. We can reproduce it in the following
> steps:
> 
> dd if=/dev/zero of=f2fs.img bs=1M count=65
> mkfs.f2fs -f f2fs.img
> mount f2fs.img f2fs_dir -o checkpoint=disable:10%
> cd f2fs_dir
> i=1 ; while [[ $i -lt 50 ]] ; do (file_name=./2M_file$i ; dd \
> if=/dev/random of=$file_name bs=1M count=2); i=$((i+1)); done
> sync
> i=1 ; while [[ $i -lt 50 ]] ; do (file_name=./2M_file$i ; truncate \
> -s 1K $file_name); i=$((i+1)); done
> sync
> dd if=/dev/zero of=./file bs=1M count=20
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4] f2fs: modify f2fs_is_checkpoint_ready logic to allow more data to be written with the CP disable
    https://git.kernel.org/jaegeuk/f2fs/c/84b5bb8bf0f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
