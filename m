Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625C6C5AD5A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vmfJs4wvVFLZn7I9pI0SP818agHT6Yv8HAO24/As+IE=; b=P/qYwHGDzpHgHvMCXZme11YjqQ
	NjPcmaHumsv3UYZZr7tCehN1UyQiqNkfFiMb06PVucQZNJ3E0l/1w93kdoJDYOfAorwnayMXTopDY
	YV5yBq0/nnovWYic5D8Fhjnp3+gm7w+8bn9gkcoVXHpIq9ma9p9EN+oWdbiCGIGgsjy0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuFbP-0001e8-HB;
	Wed, 12 Aug 2026 20:31:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wuFbD-0001cv-Af
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 20:30:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EKEuyQ+hyhy3BWphVGV8OUrBXHT1DvT3dz+Fes0A89o=; b=KGqFgogKWo2jFJ+QRXVjT0TkgJ
 /Ef8XBGauPMC4aaL17iZxBN4w8waMxwivE20XHnH7YlVT7+AemtVyY7SFk1kZL4uryYGBT0QM7gy0
 CCYCbLs8QIiMrZp1viWvyK/SoC2lw3G+anVkZPfBCyYDTX4CUsWdFe7IgmeMuOXZ/hfc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EKEuyQ+hyhy3BWphVGV8OUrBXHT1DvT3dz+Fes0A89o=; b=ENri1sZaKO5uaiME2ktXVQttrw
 c/rYKh8/sl5YPMnns8nfHyrYqj7b6ma+woUUPIro8cH+ycQEC0MMGv3rto8bKxBcy1E+RBu9AV3ge
 jc8iSN1lCQp0lwA8yqSmEZjHZE14KCG3As+N1WS4tc+4dnuH1aw/+wbrxgdVm5Jql6Ow=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuFbD-0000qJ-Fm for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 20:30:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2FB204394A;
 Wed, 12 Aug 2026 20:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B281F000E9;
 Wed, 12 Aug 2026 20:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786566650;
 bh=EKEuyQ+hyhy3BWphVGV8OUrBXHT1DvT3dz+Fes0A89o=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=IAbk/w/lkLjqY0j7xaFKYPGnF5NGH0fiLGx/FVOtOPex5PiWVzaaTHuJOZQWhnL4P
 RhWHL10lKt86FBCdg7vYv34wIP4cieM3QRU0WyJp/2o8vmmXs1Bf1bkgnsi8671WKR
 qZus/GgCh+WxRFiMVwV0j/4klT1QkBtVQJB0dBgFEht+SqaeScMpvh3SKA2fbXCFqJ
 IYLFhEGeI9MLPJUkVjdBkYDXoeya3EVabPHhUq1p3DZiPo/HADosNE3irlZ6YfKH8Z
 PRGX0HuGuRaLmHAhBs3rLZSxW8Zo/v9bw7F9p/QeDRVKisploJ8gLEQ0TYpgd+/Txh
 6RCoAPLMwd+eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 9393D380CEC4; Wed, 12 Aug 2026 20:30:06 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178656660539.2090005.2292921508148782354.git-patchwork-notify@kernel.org>
Date: Wed, 12 Aug 2026 20:30:05 +0000
References: <20260810133832.3530016-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260810133832.3530016-1-qiwenjie@xiaomi.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1wuFbD-0000qJ-Fm
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: return symlink writeback errors
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 10 Aug 2026 21:38:32 +0800 you wrote:
> F2FS writes long symlink data with page_symlink() and then flushes the
> symlink mapping to reduce the chance of exposing a broken symlink.
> 
> That flush result is currently ignored. If the writeback fails, symlink()
> still returns success even though the symlink is not durable and the same
> operation can already surface -EIO through syncfs().
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: return symlink writeback errors
    https://git.kernel.org/jaegeuk/f2fs/c/5d6f08574082

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
