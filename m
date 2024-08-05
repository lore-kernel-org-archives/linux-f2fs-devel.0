Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3505C52D71
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Aug 2024 23:31:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sb7AR-0001GL-Eh;
	Mon, 05 Aug 2024 23:31:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sb7AP-0001Fw-K2
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Aug 2024 23:31:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x1ZGWxDwsGhW1duW7ZOcWmi1pTdSxtNupZl9+GGQvIY=; b=G1jYyvRDx6lWG3sRv2VfP0oFB2
 yvXrohcYScwhpTrask75zHzR3kgHh+k/sfW1IbNzrhnZq3CeWmhYtW0frX0EpCjDiqGRA01akebt2
 JLohNtf7erit0AQPrmhmf+BPn1K2oILYhe/rkCO34mRURvdmxpqeq9kZhHYQFpYQOs0Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x1ZGWxDwsGhW1duW7ZOcWmi1pTdSxtNupZl9+GGQvIY=; b=mvGaSYkTOB+bA0wgJFnR42+8S9
 Il++zsdBkeanUQ4fMEY5xuwatvLaOFiK9w9xlNMZn3jnB29ZfrFfrTFo81IiWoB904d0IiN0lsKsa
 8jW4i/qHGiCg/yHUj6e9wLJvU/PGleM/FlWgUp9F+Q/ahA+QlwyzncjEXuhWEZ7GnjJQ=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sb7AO-0005AW-PI for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Aug 2024 23:31:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 1D032CE0BBC
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  5 Aug 2024 23:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F033CC4AF16;
 Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722900652;
 bh=xzNGl89zVvIazdPP5LBpjcHh0SLwpBHsnybbnibfu74=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=rmu3QSVQnu7Vp0NYxILPTbOw1JPAkVnDXFY2R35Y2pF/7B4JhTz3N84CaUzGK2D02
 0f26cWdQzkHFGxPa44wEZ9YSd+fQG6kXt4G97h/KsQXsODn9KqY7S6mB911VTzXMqI
 9FA+6l5gCdNmKpQrlV11uWTFQaA1E6sHHUPMFJ9AlteiZ4vCJFcL++lc3DwxZEZ5Xu
 VA3K3kBS/hDT2vDTdqvx+1HNHENl+mPEFEsEETXO9OCMklMU8XJD7SA8IqFv6iP/9l
 uIniQlrccXMl/MyOHLnDQ5pXsqA6Pym9HzXewE2t8HBkJqL8fx4VZerg4Kqv+BDySc
 SrRprRFyIlODQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 D789AC3274C; Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <172290065187.2803.6622795747544995557.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:51 +0000
References: <20240711014632.3927676-1-chao@kernel.org>
In-Reply-To: <20240711014632.3927676-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1sb7AO-0005AW-PI
Subject: Re: [f2fs-dev] [PATCH v2 3/3] f2fs: clean up data_blkaddr() and
 get_dnode_addr()
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

On Thu, 11 Jul 2024 09:46:32 +0800 you wrote:
> Introudce a new help get_dnode_base() to wrap common code from
> get_dnode_addr() and data_blkaddr() for cleanup.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - clean up get_dnode_base() and remove redundant declaration suggested
> by Jaegeuk.
>  fs/f2fs/f2fs.h | 46 +++++++++++++++++-----------------------------
>  1 file changed, 17 insertions(+), 29 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v2,3/3] f2fs: clean up data_blkaddr() and get_dnode_addr()
    https://git.kernel.org/jaegeuk/f2fs/c/2cf66b9de406

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
