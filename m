Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44234C77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 18 May 2023 01:50:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pzSml-0008Tg-C6;
	Thu, 18 May 2023 01:50:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pzSmj-0008TZ-DU
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 18 May 2023 01:50:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IZs0C0dY1X+5vp5XLuYvrwQM1J6boRs7WOj23Hsf9mI=; b=OLHxMy/m2Pl2ASSBepsWy4wdne
 lyV9x4XuH0mCbu29PhO6AzL/HZKSjzknagiWV3oz5CeQppsW9RKqNxJ36ZoT8uXzbHIQXTJRlaRUG
 SLlXyIN5L44m4GRiO/VxzRLZwwBbYxjbkK0orBFXj7aCpYQbcyyt9qHah8ceRracBVuo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IZs0C0dY1X+5vp5XLuYvrwQM1J6boRs7WOj23Hsf9mI=; b=GhzTRaTOsra253xfxoAQ+OlxIL
 1UMxZq4qywv1dfKm2PLaST48AmOP4pbgXET7HE/NAgyq+GRzWxcI5A496SGSljzklrJCwg0yGat3q
 vRfCd8sukWVuzGlkK9Lu//+8DVsCM7aK55ZkZW/F3fb+881g+LQvV7X3geOIm5C1v7aU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pzSmh-0007UI-TO for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 18 May 2023 01:50:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8712A64C27
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 18 May 2023 01:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E403C433A0;
 Thu, 18 May 2023 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684374621;
 bh=WWMJVyyhTnwh2cfx/KpW0I+0aNVVIvg8+5ecK0txWCI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=bFsZvK8I24yGU9vojBHCYURsGtkipDQWFDkBht4dgCIdnwcsFMmuooMlR0Ahd4yLw
 tqQI4reXI1igz8Ya9+PqfjPX6PIwg19KUlgZ/RzoxnJa1HLd1jYGccOcVNijugQ77u
 t5D6bkfjtBew6LY3Tx/2gpUL+nHj/s5tdl1NSP7Bl0pCMH8G1/3EVG/l6YXfcWOSWf
 cUAYAdPYaTv0lCRaoq84msZo82Gr4y9wZjT3JFdSSGQ/9xfBOa4Edav7WW5ciUTjjb
 ZoVpHc3hx+y4UU1TxQ1zl0K/oDRECfwLyTMnXqVDi8EjeYTUafSDmPuVgNSy0WS01c
 BM/8JOAv3Jj/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 63AB3E21EEC; Thu, 18 May 2023 01:50:21 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168437462140.19511.17183994837001574389.git-patchwork-notify@kernel.org>
Date: Thu, 18 May 2023 01:50:21 +0000
References: <20230516152346.190199-1-chao@kernel.org>
In-Reply-To: <20230516152346.190199-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1pzSmh-0007UI-TO
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to set noatime and immutable flag
 for quota file
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

On Tue, 16 May 2023 23:23:46 +0800 you wrote:
> We should set noatime bit for quota files, since no one cares about
> atime of quota file, and we should set immutalbe bit as well, due to
> nobody should write to the file through exported interfaces.
> 
> Meanwhile this patch use inode_lock to avoid race condition during
> inode->i_flags, f2fs_inode->i_flags update.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to set noatime and immutable flag for quota file
    https://git.kernel.org/jaegeuk/f2fs/c/3c125710454d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
