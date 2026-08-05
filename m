Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C1DC561E6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bdStgugn8TtI/kJJAn7PKxHOnhWHYwR7xUxdx1DzMKM=; b=LOYWVkCD1XhQphMuHEJd0jIta3
	UD+4WYJDAF4CiREAPpBAL47qlcSBHJo+y0lfApn1DosB+bPx6dFoKf9UiR2xrVnrZvPbvOtiZ+JgX
	qN2q9hKz4cxGhNCzqcQc+5/L9bluLpaSO6w0seb4TI9EMfkI6R3ktN5c7Tud41y1gs8g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrj3T-000887-VW;
	Wed, 05 Aug 2026 21:21:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wrj3S-00087t-Hc
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SwePjaVLbFYbaEqytLvqvghBaG+QqjlAawQwJa0aXoo=; b=HkZ3h8f2NE0cvRneeIVRcnuu5N
 rrAIIVzVaa52Hds5DrCpUQv6BK7D2Q3fbAFnfv9wWmUg0iNmgELwnST0Z+dPw4TlTweJGCS84il3N
 RlDTtTiqGdkKi45kgjJpOvEBDuNyKKTig0Es1JZX1qjaGkY62ahgFy1Ot5pSLh9mxP3U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SwePjaVLbFYbaEqytLvqvghBaG+QqjlAawQwJa0aXoo=; b=gpwJaT1R7r7qja4uwFdr5stcJD
 6UmReupYnCkGtRdm+dPf12IpVHpueCzYNHOJTye0T5dT29p1uZiDv39KPZH2sN9zXjhUURE6iYZkT
 dTAdjT8/E8ectey2ZCgTUAJt0Z9RiPeNt/9TRkWLENoX4BCI8bCZi7PfS8xoVsh0BGek=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrj3S-000447-Va for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D8E6660A8C;
 Wed,  5 Aug 2026 21:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAF81F000E9;
 Wed,  5 Aug 2026 21:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964889;
 bh=SwePjaVLbFYbaEqytLvqvghBaG+QqjlAawQwJa0aXoo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=NKrPIolgdsfSmBSKaRJPqFuCzL3EdETQVvmGo2Us7V59CpV/7L0l0hp375GCO9rnD
 EhwpBBwefM8TKXjMTBMTlfgYbCx+qqqQ54RAg90cVWp01wohXriqwHndX7Uo0uklGf
 hhYSo+PFUmlXEqcQyuREbyJ0pQmC9Lj5swvVcpMjvRaz8x+YivpVDeYrRkqeOq64z0
 IXKLNakDXwC9oq6ck6/A4tfx9FdBzE20Sh+zt2/GzrtEpkpisaARr1Z4KxPz14G05M
 iepIPk9/43r4qWzaO8jwdGg9kFlf83qnKdHWvTUBXp/k+ZZc+vb+McdT1TG0f0MuCy
 wE1mPwawbHq0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93989392FFD1; Wed,  5 Aug 2026 21:20:50 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178596484913.530543.1573788529936238876.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:20:49 +0000
References: <20260708065439.1139937-1-alvinhuang0603@gmail.com>
In-Reply-To: <20260708065439.1139937-1-alvinhuang0603@gmail.com>
To: Hao-Qun Huang <alvinhuang0603@gmail.com>
X-Headers-End: 1wrj3S-000447-Va
Subject: Re: [f2fs-dev] [PATCH] f2fs: reject overlapping move range after
 len expansion
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  8 Jul 2026 14:54:39 +0800 you wrote:
> F2FS_IOC_MOVE_RANGE treats a zero length as a request to move data
> from pos_in to EOF. However, the same-file overlap check runs before
> that expansion, so a request with len == 0 bypasses the overlap
> rejection added for same-file moves.
> 
> For example, with a four-block file, moving from block 0 to block 1
> with len == 0 is accepted by the old check because pos_in + len is
> still pos_in at that point. The code then expands len to cover the
> rest of the file and calls __exchange_data_block() on overlapping
> source and destination ranges in the same inode, which is the
> data-corruption case the overlap check was meant to reject.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: reject overlapping move range after len expansion
    https://git.kernel.org/jaegeuk/f2fs/c/28c1ef094e7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
