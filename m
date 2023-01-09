Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC9AC678D6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Jan 2023 22:51:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pF0zI-0007JP-OZ;
	Mon, 09 Jan 2023 22:51:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pF0zF-0007J1-9C
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Jan 2023 22:51:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ovYt0rT87a7wO+3EkR4Aafwts8A/ldZdAxKO1x/BJAE=; b=XZ0Zli0svxgZugi6xPfBlqffaS
 5bG7B6VXFGX6GcJi2Xpz3Xd/AhoBdpdVjVxCyUJi64JQ21icUm5Y7bp6Vk3GVnFv/0CcuXPkoHBol
 knZ0dwPqOir3AqMhRDp9KC+KQejLXNyELpz1ekTjpnp9zrdODQNrLHDaW+xlxPqg+12E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ovYt0rT87a7wO+3EkR4Aafwts8A/ldZdAxKO1x/BJAE=; b=VTwrHowVwWec0c2VHXxGzDsvza
 n0YwSn6OnGnTttqz45IUQ3PbeQ47O7/nADTc+vrnkfBscxghqVayzR2dClAuWRu7cVj7ex+Jpgi37
 h7WOg4qz+XlrCha758PcXrScb+ailk3yiImeTpoQ44kFY5drbxss8Qu3T18ksRw1Vo4M=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pF0zE-00C4U2-K5 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Jan 2023 22:51:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DA09FB8109B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  9 Jan 2023 22:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85EF5C43396;
 Mon,  9 Jan 2023 22:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673304674;
 bh=H8fUG9NgMpPUeDtXFhknhCSc6TOtHhGyumR0hB97Oag=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Ofoj9Diy8+Xmc5Rnrtw9WgktGT2cR60RknNB/rmFRud7wCkXQAUc9oqGb41/4Yq5K
 Hm050Cs4AL3MXkIVRHeP9AFcqsoci6+yDYuA9AL8UPh254cuH9lkysHo51pt23yXW7
 nVAKtBqMtCHEaIYwStoujnbUwHEevcqBCxpvMUqrelNLa2w2bpyj57geyYp08uy9vM
 B6SJou3b8pyUbY8MId2mKJaxTeH3wp2NrVB4aB0rXdLlhqq1f1YsODJrmIV++1bXrP
 20E/PSJMp4sXjBSzE/n12emw2XO9LJ1PlOGVhxXnOCHAsf3dtIT3c+sKjdWBQE92Ck
 ON6aVHPqH8xbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 62689E50D62; Mon,  9 Jan 2023 22:51:14 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167330467440.13717.17416282995596170493.git-patchwork-notify@kernel.org>
Date: Mon, 09 Jan 2023 22:51:14 +0000
References: <20221221121445.14400-1-chao@kernel.org>
In-Reply-To: <20221221121445.14400-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1pF0zE-00C4U2-K5
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to support .migrate_folio for
 compressed inode
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

On Wed, 21 Dec 2022 20:14:45 +0800 you wrote:
> Add missed .migrate_folio for compressed inode, in order to support
> migration of compressed inode's page.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/compress.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to support .migrate_folio for compressed inode
    https://git.kernel.org/jaegeuk/f2fs/c/f35474ec0059

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
