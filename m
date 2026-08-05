Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747D6C561E6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U3xAyrPHusHQOBW7ytJBgoX3NaLMbWgS/V7RPvWPZ0s=; b=h6vzp2y+F/OQDlUGRNwPy0KzlU
	0hZzM3JzIR66yEpCE+NSGx9Ml9atwLVldU9UdjYvAiOJAOwU62r6PnKJ8OPFcZtnK8Rf7netXwjaA
	hZyx7TSIpvuJ/FZ+mkPnefBLuJx5NCGEdAaQWoixJdHBkat1jUnIWGz4EQ6odtPTh1ZA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrj3j-0008Cb-TX;
	Wed, 05 Aug 2026 21:21:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wrj3f-0008BQ-N2
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3TiEDM3rITJS3DYbxzsBjxRYZAPJ+Vp00smibT0G+7U=; b=WOpZDmJMBuq5h/T5cRkTiXZM7X
 Uhdh8fklSWBqhhXubHhpcszqkRmIXa4Hw11m2qfvTujN4F/p6DMCqlypFg3U02NvszaJFA0zcHLZM
 RQ8aUeBiKDcO2hpDr1y8IUON+0c//UrKNrnNk2mH+05MZXUf3q5icIvDrtGSJmE4TPmc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3TiEDM3rITJS3DYbxzsBjxRYZAPJ+Vp00smibT0G+7U=; b=EA/JArHiEsQU5QIZcGUM0f6+Bn
 iz+1zlYjsUJS+GLTE63COhfc7pLeWN+9FJKHMF3KYHsZLNE1O9faMmA9faPqahXdsx2e5XUp779iI
 p686VO0XIvNHj0ywam6/5WY6xwRSzBgw8gSvqdYs3NVx7L3LFQkDg1KgeXiKi8lpe8wY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrj3b-0007BY-Dc for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D7FB360A6A;
 Wed,  5 Aug 2026 21:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1761F00A3D;
 Wed,  5 Aug 2026 21:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964901;
 bh=3TiEDM3rITJS3DYbxzsBjxRYZAPJ+Vp00smibT0G+7U=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=NnpqjIRdHWqvxtx1JlTrfmIOZCoIncqsDI6FHuDxK4vaoB/BYqi7gmuWGFFa2zwp7
 rHeHFc2HXMndeqFtzrXuaNoVnE1jXHwhmL0kr7E6Bf1zLU7myIDJ7E48c3Wyc3J2zY
 aMVEU/uUjbcVrfPW1Ji2zUNQDBtIipGkRhrSSYNPQwSkD1KJFhlMy0+BmZP6QBMa3e
 6NNpI/tbhclH+GKbTwJAb0AIBtLl6IdjCr/Gcl8yEaiqhvFrHAzABFib/qETEGQopf
 BbSrytgaZDSgcKSgrFLBKlx7r0FN9m0y6itNk7BU63iSxAfeixYJJnJSGipaymEwNF
 tQ3dTMa/k/L/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93897392FFD1; Wed,  5 Aug 2026 21:21:02 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178596486113.530543.3878662692562337563.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:21:01 +0000
References: <20260803114153.1499527-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260803114153.1499527-1-qiwenjie@xiaomi.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1wrj3b-0007BY-Dc
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: reject invalid recovered filename
 lengths
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
 qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  3 Aug 2026 19:41:53 +0800 you wrote:
> Recovery uses raw_inode->i_namelen directly when rebuilding fsynced
> dentries. A zero-length name uses no dentry slots, so recovery can
> report success without recreating the dentry.
> 
> Treat zero-length and oversized recovered names as corruption, mark
> NEED_FSCK, and stop recovery with -EFSCORRUPTED.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: reject invalid recovered filename lengths
    https://git.kernel.org/jaegeuk/f2fs/c/6dc2b804a042

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
