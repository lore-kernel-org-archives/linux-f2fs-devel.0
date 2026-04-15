Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA83AF43858
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Apr 2026 16:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PtvEe9LXVTDGeVHrLh/3bTG1aRtEaxbOUa86Isbm3R4=; b=A2SyKPDyxcpPprHcdUD1qtyV2H
	nC2YT07u21hKkr79C8wR5b5P1wsqIdl0qAzWu10e41Te+lRroewDc30rzCJnduRES2xaHrls+SAm7
	Fz82ZyWvRPPquWpab3DvG5f8j+qE5Cq4B/PBrHXJcD5UCTNRbmH39geg2ItyHqMvvw8U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wD3SU-0008MZ-Pw;
	Wed, 15 Apr 2026 16:51:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wD3SQ-0008M0-DW
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Apr 2026 16:51:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dECF9jUFOaDaYmpSERQK6QrusNE1rB+z8F4gg3FzMbc=; b=S137akELptoXJmvWp+9kP4HAvV
 9Pbm0qL++rz8oomOeSV9/RxKJVq3aTgblZUDUoIk0k0BSj42ArMDRef+OmAl1aaOLu407C4fiqOyN
 9h82ud0EQbn0q+1DOL96dabPvO7aCUb3mWnCYOFHp01w6F/FyV0ezPiK5OQa8tOM4oIo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dECF9jUFOaDaYmpSERQK6QrusNE1rB+z8F4gg3FzMbc=; b=Dj1fuiJq0aoYj5w0YBrcrPuui1
 nids9uotRFbDmjrc8zcMvCc4LDv32nA0sIX04yV8sLRms6yjBiyZwMdZruvKl9/wzPfLMVLX8bWGo
 IHA6Ct6UXyMqmw+dxTA9db2Zkf8Xpe7n48jauWQAwQiZUlbCfoPr/E7Voo/BaHUAosyI=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wD3SK-00018L-AB for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Apr 2026 16:51:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B719B60120;
 Wed, 15 Apr 2026 16:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFB5C2BCB4;
 Wed, 15 Apr 2026 16:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776271866;
 bh=35miVx0G08ePpBXqcA0ayzPFY+95aTgCfrayDKUEhOg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=dg04ZZiE+IcRk7+Q0cNZdKuJqq+CykO9VLGKxQBxvIOrwKuomWoiWDvLN5ai/Vzvb
 MRxAvo3AL2vqJ8vpL7hw/t/wFe0FFeNbmoFD4ysMQMKSXMwHO5cA3sBUMjC7fRu+H9
 ztOTINdok80i3hAjmnPuNSwJtMW4yy5S0sN192+sz+FoYmSIXiYR+QRwrO/0BSgwIk
 9eRWuwvgF+/3rm0D28JwJSxN9nXHw2NNm+Csz5IFGjL93pLgK+VfzaZQMZoJ4beb/q
 ESyx+pPhl2V0e8CJz0ae10Zofd6Ce7G07xz1gslw3pjNKbs/ba0y7iS/f4q2B8K6CP
 wIbi5xER7+9sA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 34AF8380A964; Wed, 15 Apr 2026 16:50:37 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177627183604.2303073.17250011751833572964.git-patchwork-notify@kernel.org>
Date: Wed, 15 Apr 2026 16:50:36 +0000
References: <20260403144015.221811-3-monty_pavel@sina.com>
In-Reply-To: <20260403144015.221811-3-monty_pavel@sina.com>
To: Yongpeng Yang <monty_pavel@sina.com>
X-Headers-End: 1wD3SK-00018L-AB
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix node_cnt race between extent node
 destroy and writeback
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
Cc: jaegeuk@kernel.org, yangyongpeng@xiaomi.com, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  3 Apr 2026 22:40:17 +0800 you wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> f2fs_destroy_extent_node() does not set FI_NO_EXTENT before clearing
> extent nodes. When called from f2fs_drop_inode() with I_SYNC set,
> concurrent kworker writeback can insert new extent nodes into the same
> extent tree, racing with the destroy and triggering f2fs_bug_on() in
> __destroy_extent_node(). The scenario is as follows:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix node_cnt race between extent node destroy and writeback
    https://git.kernel.org/jaegeuk/f2fs/c/ed78aeebef05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
