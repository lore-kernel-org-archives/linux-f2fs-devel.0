Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93138EB64DD
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Aug 2023 20:50:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qVeWN-0002GH-8i;
	Mon, 14 Aug 2023 20:50:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qVeWL-0002Fy-3W
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Aug 2023 20:50:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B9SljpoJloG5KifDGD8/4KU+F0IAof7pSFfMCY3ytlk=; b=NFhtgIDp83jtS8CImqoXqvkrVo
 mEPYHhzdLuHIVEXEg8XtrQrmBPAGKeGv3XNfCzkmWnLCrJHlYfFe5CzJq4DpXzbvR3jvneKT6hWvJ
 aNyM837O+tOBW5F0VcBY/J0Td/pvDs0YezMx9o7XmiYvvhaKsy20y/+yRfTDsHJH6Gws=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B9SljpoJloG5KifDGD8/4KU+F0IAof7pSFfMCY3ytlk=; b=aSS0P6Z1sB4bEzkiSlgM4i8j0p
 EkzJ360+1r5/ujALLHKQztP+EtqpCxTJdo89k+/WoOxoaIEUH10/rqADb5u+bEyIXBXUBgbKw/6rR
 R+FDblANcZ2cRvqJbS1WjxqW9ceJ1uyCzHIjC/R+uPhNaImt0pmnK1o3/bJZpO/DHjfo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qVeWJ-0007WK-F9 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Aug 2023 20:50:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 927846481A;
 Mon, 14 Aug 2023 20:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7157AC433CA;
 Mon, 14 Aug 2023 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692046222;
 bh=cFZPQo5ttQavTF3LVxiGZwW00ViXQY/i8Ui5n58JYcg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Bh99qSODMspbWTo3pZrlR8CCZQ1MsCP/AvTD2FWmz6Rsguwh2sdunDDiZqweod/sl
 jOIqF8MgYgD8wxwZbc0rQwdgjDW2nStBtda4lVEgCFFgyZBdBGQNZXdn/MVBhiFVjr
 7nQTiAh3kyErLb9QVRm0OLOZejm9X5bjaTaU11T76BRFupPW2WMaSJnEJrI4W67RUE
 ppXz0lLTapJ8BwKRGlak5taPFNmWcdemYiMTgGkX+02MxNzjw7DZT4wpHf0i6mJI2k
 27355fza7LpeDFQ2DO3oS2zaUsWmnur+ILo+dHQ3u6+6+uDj83GgGDNeDAwI994y+j
 J/d0OPx41Z06g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 55C34E93B32; Mon, 14 Aug 2023 20:50:22 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <169204622234.5033.2138397345398066048.git-patchwork-notify@kernel.org>
Date: Mon, 14 Aug 2023 20:50:22 +0000
References: <1691656800-21616-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1691656800-21616-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
X-Headers-End: 1qVeWJ-0007WK-F9
Subject: Re: [f2fs-dev] [PATCH] f2fs: should update REQ_TIME for direct write
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
Cc: jaegeuk@kernel.org, niuzhiguo84@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 10 Aug 2023 16:40:00 +0800 you wrote:
> The sending interval of discard and GC should also
> consider direct write requests; filesystem is not
> idle if there is direct write.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  fs/f2fs/file.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [f2fs-dev] f2fs: should update REQ_TIME for direct write
    https://git.kernel.org/jaegeuk/f2fs/c/0cc81b1ad512

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
