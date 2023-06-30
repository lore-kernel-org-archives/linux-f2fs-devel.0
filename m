Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB08EB64DD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Jun 2023 23:40:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qFNj8-0000Pj-QP;
	Fri, 30 Jun 2023 23:40:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qFNj4-0000PM-Ma
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Jun 2023 23:40:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4itiz/ViXqxYZsYbLQV0MtlFad9WSdQrFWFOOQBKdss=; b=cWn1IrlN1oImAIXazf9q2h21DE
 fI0m6bzpy8uTAPXwgLppxRyJvlrurvgRlYZuD/v+IwdWEKygn43VxMqVWBhosYVpGvrv1bKskvvtI
 Ybj1WP5X80a5KmHmolfZKDiTyjz47eUkXpkgp+PlOnNGD9LUbz5myxm5ZQOIw/SllbGs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4itiz/ViXqxYZsYbLQV0MtlFad9WSdQrFWFOOQBKdss=; b=f0fkungYb5FUd//QtLyckEHUJx
 OEHLJhoc1TNUmD3eXA7k/KMOSCiJzHbeEjhiEna60hwd6gBm21DOCFa76Gd7iPsiDc+gU1mhxorTx
 +dALGElJ2MzpngLETPdeKOGsA+mYY/BCa6j262oFnMhI3iH2ui9VBtRzkxUNR5u/N+jE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qFNj3-0000xD-W4 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Jun 2023 23:40:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 94F4C61839
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 30 Jun 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94705C433CB;
 Fri, 30 Jun 2023 23:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1688168423;
 bh=W0fQjv0ep+Qe26cn8QnkVVT2df49/M4iytcJ2vTwNJU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=mzkw6nJ+d4pb2/B1TPMpQ6h4tzqE7rbdjUM8YmEMOCnT01IeUxM4Hzk4mHAazSVGF
 cDKMjj3DMu2lQKK+D2VOQt/quQidghPReFENu3uCnym7rzvE1Iaf/6aSwLbMvjjIsv
 DZ56aHE7KwZ+UFHgSvkRcReVomyqN60vPoJcUNIAgKLUSwWNEZSF+cckY85vzdJKJN
 yIMYAEFWK341koYhVON+sG5eHw2xXqd4KB3LV8xLOnbCGxxjupiW1khvAXfUV456pm
 LR+d6XSTP28wDd9FOWquCxf3RNIL5MG5lUn+zTRoZPdz6CWmKomdx7kSahLug/rCcj
 z/UEHbDpu7p9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 61669C395D8; Fri, 30 Jun 2023 23:40:23 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168816842339.31915.12136963256323192911.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jun 2023 23:40:23 +0000
References: <20230629014102.3057853-1-chao@kernel.org>
In-Reply-To: <20230629014102.3057853-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1qFNj3-0000xD-W4
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix error path handling in
 truncate_dnode()
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

On Thu, 29 Jun 2023 09:41:02 +0800 you wrote:
> If truncate_node() fails in truncate_dnode(), it missed to call
> f2fs_put_page(), fix it.
> 
> Fixes: 7735730d39d7 ("f2fs: fix to propagate error from __get_meta_page()")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/node.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix error path handling in truncate_dnode()
    https://git.kernel.org/jaegeuk/f2fs/c/0135c482fa97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
