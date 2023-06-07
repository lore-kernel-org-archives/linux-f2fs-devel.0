Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0C1C7EE25
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jun 2023 17:30:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q6wzX-0002eC-Qj;
	Wed, 07 Jun 2023 17:30:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1q6wzW-0002e0-3f
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 17:30:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y7wSewIHqOn038tfLr/C4EvYPj9vTiG+1ljbtXi9EVM=; b=aw8BeWpRYFUOyjj8rgjSLhStR0
 yDjTF+UbPg8LpzkjOmBdcRWMsQdudk51+omc83GgCk3MKqCelluIZWxexur73BBnrZLgUEoUvC57p
 D/B2La22JKmEY+olH21+WEWcBGTmyadevp9TvmYfDB1H7T36aQQ06a/yQKKnSMV9qpb0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y7wSewIHqOn038tfLr/C4EvYPj9vTiG+1ljbtXi9EVM=; b=d28X9AJiOS7Cbj3aHnq4mnXvHT
 8M4OBBH88NbqDuJ0tNJOPdwJqdIJTRaoRNVkyWWlibY0lJu8XX/ixDW8HpDU6fyNucJNJwppMhXJ1
 GlRawesbDsBXQDD7C2CbVOj0sumlMzR0mBT9CZZ6o3c//i8hClu0EqRuA7H6PRZtv6uA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q6wzV-00Dvre-EF for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jun 2023 17:30:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8B3A564214;
 Wed,  7 Jun 2023 17:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72737C433AC;
 Wed,  7 Jun 2023 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686159025;
 bh=DmAEGZ915kIQbX+lPFoH69b9X9/dsxFYI5AwYXW9k+s=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=QJXrvY/11bEUQMK5Tek6PN/u3d0h8IzhFQEy40ZpX5T8X4X3t1XTCY27nBtmLgK2M
 LxLWXyKrLhLaah/+ceLfW3LLgB+UblzXWLadXNVrsId/8y8mGNgjadbcrn1pEIGs8T
 1puDhPKGprnwusJun9rrrc/3ENvqxwzwHu61S51moxZulHl9sEddlSVyTW0a7yF7ca
 ijPxf8JugSNmXu3ENdKm6pbpVVy7VE6U6sVHAtf0y9aeXf8nGRD0Smdhkdw0lu4fij
 qtAXN/pjwPJ+j+og63bV2WHygVddnrFtxSlvKKmGVpYnbVyWUPJsItFXUHvgkwLgvY
 EnNT4Q8evOSUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 56A80E4F13B; Wed,  7 Jun 2023 17:30:25 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168615902535.7521.9662746473777436444.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jun 2023 17:30:25 +0000
References: <20230527170640.37930-1-guochunhai@vivo.com>
In-Reply-To: <20230527170640.37930-1-guochunhai@vivo.com>
To: Chunhai Guo <guochunhai@vivo.com>
X-Headers-End: 1q6wzV-00Dvre-EF
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: Detect looped node chain efficiently
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
Cc: jaegeuk@kernel.org, frank.li@vivo.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 28 May 2023 01:06:40 +0800 you wrote:
> find_fsync_dnodes() detect the looped node chain by comparing the loop
> counter with free blocks. While it may take tens of seconds to quit when
> the free blocks are large enough. We can use Floyd's cycle detection
> algorithm to make the detection more efficient.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: Detect looped node chain efficiently
    https://git.kernel.org/jaegeuk/f2fs/c/a97c229c68ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
