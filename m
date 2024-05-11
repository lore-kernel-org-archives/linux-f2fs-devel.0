Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273A7C25B75
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 11 May 2024 00:50:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s5awo-0002NX-Ic;
	Sat, 11 May 2024 00:50:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1s5awm-0002NB-Nh
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 May 2024 00:50:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fOTCva+rvlDMae+sSGuwnRQFCXhlzfSFWrnUZWX2rg8=; b=TgVFJLwtAOGrTM91xLJojpQ3Ou
 Ntgt5gmJQ0xx3FGt0obGlDy05IfxcqgXL9hq9NpHCmSpOx4p/x8R4rEtnCF+ll74XvznNzsyWeCIH
 UErv9odojOavg0kimIStvRxt6r46qEo587LASau+TOXuXzE9dlXi+VaA9z46Lk8Tcg5o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fOTCva+rvlDMae+sSGuwnRQFCXhlzfSFWrnUZWX2rg8=; b=PkbnJXMKwegtoeGPD9D49rHs5b
 R1ruKVewB9Mrzrzhk0gycaHcY/kUYNzJXI4e8qLLXSax3IRvgJtdQPGLAFzm7A4CIMzxSLzcyTJwL
 Ibv4z09AhbkE5B3CXyeccE8rUMQd5m1Xyqbr4d694pv+4w9MLN+UcBBWeYHP34YCWUfA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s5awo-0004zE-18 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 May 2024 00:50:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E722E6203D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 11 May 2024 00:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07B39C4AF13;
 Sat, 11 May 2024 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715388634;
 bh=k29d+zi6/5QyA5Jm8QI53vH7XuREqf3q+JGSX44Smb8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=kEXTyCqtxWo0DoOBtCJTgiCAp7eOe2Sw/KBO7/mhD4y/vvU4I1tY+wxyw+gy6kO+D
 rua40dk5oN3iy0OvAoYGDQ4Z5C62LD/xkYmz8mHS2uJXC3NlgF96p/TNpiY4RL553X
 TDlBSoWqHiSMTQHfrf/xlA7qJFl8ei2sORBMXq4g1T89KWUqSljfvxjoNn2Czg2xUK
 CHzByCtiDvlwqxbcLVS2cotIGuqxP9mQUefV8dwMZd/dYMunC0CNwlDu9HictqVaMz
 Qbma/HCc5Yvxx1vEomDJH5rl7wgZAKSwmaJo87p6wo/ipssy9sP9ha0Oyrd/TCq8ya
 FAH5jToxPEevg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 F02BFC54BA2; Sat, 11 May 2024 00:50:33 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171538863398.11229.15562636520334285373.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:33 +0000
References: <20240507033847.1047251-1-chao@kernel.org>
In-Reply-To: <20240507033847.1047251-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1s5awo-0004zE-18
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: check validation of fault attrs in
 f2fs_build_fault_attr()
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

On Tue,  7 May 2024 11:38:47 +0800 you wrote:
> - It missed to check validation of fault attrs in parse_options(),
> let's fix to add check condition in f2fs_build_fault_attr().
> - Use f2fs_build_fault_attr() in __sbi_store() to clean up code.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - add static for f2fs_build_fault_attr().
>  fs/f2fs/f2fs.h  | 12 ++++++++----
>  fs/f2fs/super.c | 27 ++++++++++++++++++++-------
>  fs/f2fs/sysfs.c | 14 ++++++++++----
>  3 files changed, 38 insertions(+), 15 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: check validation of fault attrs in f2fs_build_fault_attr()
    https://git.kernel.org/jaegeuk/f2fs/c/4ed886b187f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
