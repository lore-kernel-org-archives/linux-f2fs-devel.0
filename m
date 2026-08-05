Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81835C56205
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k105tyXXSmx7tySEZgaSideXBGX5Qx+E/vq9W+XeoiY=; b=frXLEUJ/HgwQlGxOvzbX+hg8jN
	G57E8iVBlTQhaTJnetZ3OHEGYB2NM6+09YrYk2zrSD5rVmvOilx+X6Xcg+zSHw42qYImPH65toPLZ
	cNwPM8bhS1S1s5TW1MkjGiByQtQIMHNyoPldthEhCSjHt4WAGbMo8vb8ctkYIX6iuRrY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrj3b-0008A1-Ld;
	Wed, 05 Aug 2026 21:21:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wrj3Y-00088z-HX
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G9U1HE81KZ6a+jxiScImsXODUeojzms6OMRktiL1Sqo=; b=O/43Znv0PYToUcW+RLLts2xUzK
 pquFx6/w0yx6sQkGWXACqVoZWMp0pLncYmVmV/dqYQV+3qIhxjxUt1qigZr1K+5C3Bos+SJosOFvF
 rlVCJEdr4VC/2uGFGg7ve2LpbhYpXVbP88Vfo8BlbxGGhfnlbTXHiZzmmqAw/VAh61NU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G9U1HE81KZ6a+jxiScImsXODUeojzms6OMRktiL1Sqo=; b=h6nZFlmjScvHk884zzNph7E6Y/
 HmPeJ8N/SN5fmK6RYwDed/Dlf8VLcWKHzaABHDDmyriQc6TqWCOW2FKlsxaOWT4CJXyguXa4Xao7L
 dFJazTPi2p8q+P7Gj97/T8BXerEQOAVcy2N7SFKgt3+SdVwjsm4HbJbQzPXn8aVh6cfc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrj3Y-00044H-GU for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC7FF43C76;
 Wed,  5 Aug 2026 21:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F37A1F00AC4;
 Wed,  5 Aug 2026 21:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964895;
 bh=G9U1HE81KZ6a+jxiScImsXODUeojzms6OMRktiL1Sqo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=eERTbIKHJdfG0omSmgcBRpkN/E0lZMZ6s4Zh9vNEz4BQK25xDixa3/khbin7efUzF
 +U3OrNT4NPACrl3u8mo7+ZecpABXmkNWuXZv5REExi+6mdfDx1adtqHYZ2Dpss7msT
 rNbcDsrRZbLHBPgx9DrAA9iOc+8xEOr6zS2mcFNR1rP2mLgeuZ6r2yPATJz6ZggFGr
 WVvZmZpv35BqBtCi7C1TiWJnAfXcKcml1qO81Td0U4NcQtWmt0ZQAE2SFmh1leovuX
 /WMoeJsSKNf6XEAoakycJRER7mer31Q5qsNaVEvCbIeq6bFEMBn9v6nCKVH4kAZJyz
 DSdOk+JmAkN9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 938DB392FFD1; Wed,  5 Aug 2026 21:20:56 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178596485513.530543.3113469231109008901.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:20:55 +0000
References: <20260626030728.1364795-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260626030728.1364795-1-zhanxusheng@xiaomi.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Headers-End: 1wrj3Y-00044H-GU
Subject: Re: [f2fs-dev] [PATCH] f2fs: Remove unused curseg_segno() and
 curseg_alloc_type()
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
Cc: jaegeuk@kernel.org, zhanxusheng@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 26 Jun 2026 11:07:28 +0800 you wrote:
> The only callers of curseg_segno() and curseg_alloc_type() were removed by
> commit 5a4fed7cd97a ("f2fs: simplify do_checkpoint"); both helpers have
> been unused since then.
> 
> Being static inline functions they do not trigger -Wunused-function, so
> the dead code has gone unnoticed.  Remove them.  No functional change.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: Remove unused curseg_segno() and curseg_alloc_type()
    https://git.kernel.org/jaegeuk/f2fs/c/0f046e45afb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
