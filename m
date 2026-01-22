Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD85ED6CFAB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jan 2026 23:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lFV366ppb2vXCSLW3zQu+rIEwyLZbua2SiiffexZ30Y=; b=hkvXk7BAtowdXhugB7ZrH7KGs8
	eEYXkP/Ns0zhYLW3hYI4r+64mtsnJRV8NdbWlKUlyY5W0FBH+rFYGcEF7+tj0s42rAwRvKjoe7jgt
	kqaMv5bntl1HssT+Kwz93HBmkZlHSCaoYjTS8c4mHIvLfVKeTQW6MczlX720RIcmvzlQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vj4RW-0000pj-J3;
	Thu, 22 Jan 2026 23:50:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vj4RV-0000pb-DN
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 23:50:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dp03hqE5Encwtvkkhb2YKz9Ir93vOW0PgABSw0xcV0s=; b=AD4faByuROq2VSoVW8sDkw4slU
 c1frHM01ZLDuTf+HAPsNCG5q7BdNUZLFvYVaO/XmP2z7pmMz7lLrVzKcuWnxOEXKpBp+lsKIdoVr8
 IJcned9iViHQE/skL6i0nRW8CdksR6O0LQzQH8hJ4a9XBNG16ap1njwjkWL6QwVq+eno=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dp03hqE5Encwtvkkhb2YKz9Ir93vOW0PgABSw0xcV0s=; b=k1/W85SereO9/eG5Xg7IMMOMo1
 f84dRtL0TVIAuFbT5eq2Vcd0tKGIMGwc1VNDmtJ4LMUG/NIA15k7LBMtGYRxwE0WYOM04Eg+KIoy2
 bDq9TxudfTDmj8Y9N2KnGBZaAyRcd8LP7DEU3lVOe7iHRgrIJoebx2T0Z/XFaUklo43k=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vj4RU-0002OA-SO for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 23:50:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 96CB743E7E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Jan 2026 23:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B72DC19422;
 Thu, 22 Jan 2026 23:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769125814;
 bh=h3U7S415TWN9cHPNK3WhR07SWvd2IguAX23TdTNyXC8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=gYpo662v4FYEOa+bVl8UO53BDhCg64/JupIDguJl2Yn4szkTlo2dkQ2LfaMgU7ayB
 Rqrh/4BSkbI/vH6NxgKdvMx/Ajm2t/1/FY+CDPq1cVl4PBAZs0+VPQ6TUUVEPJlt+e
 T8BFHLHmFd+7ooeFdT2SZpj5TZy0gxBHEjWF2uhSH2+4sUAUnFU+8Y53763KQeqiUK
 fJZmou+52NOBfZs0TzSBt2Af/rSZ+zQRr98x4P74EFC8kDsBh06bViAnl8FXwFVYdO
 kv5+8ggi8J9r7kAZr9O2D3KBawowgOlYqWM5/aNdMJoECWpTQDjRc+gt5h4pJx6UMj
 CCsQOCsDhWWVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 11BEF3808200; Thu, 22 Jan 2026 23:50:12 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176912581084.2327822.4005455517064960638.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 23:50:10 +0000
References: <20260121051404.2056730-1-chao@kernel.org>
In-Reply-To: <20260121051404.2056730-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1vj4RU-0002OA-SO
Subject: Re: [f2fs-dev] [PATCH] f2fs: decrease maximum flush retry count in
 f2fs_enable_checkpoint()
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

On Wed, 21 Jan 2026 05:14:04 +0000 you wrote:
> It's rare case that sync_inodes_sb() always skips to flush some drity
> datas, so it's enough to give extra three more chances to flush data.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h  | 2 ++
>  fs/f2fs/super.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: decrease maximum flush retry count in f2fs_enable_checkpoint()
    https://git.kernel.org/jaegeuk/f2fs/c/6ca0ae2d1e32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
