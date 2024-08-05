Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A98DC52D6D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Aug 2024 23:31:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sb7AW-000139-8X;
	Mon, 05 Aug 2024 23:31:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sb7AN-00012e-LM
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Aug 2024 23:31:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BjESVd92Wk0lZwQtf+AN+zv2dLsILl7kyBNSPYSyDVU=; b=A22q1vtNrnHQaZhhbE4PlS/8MY
 K/2f665rnEnhbX+2wkA7vFylMX4Cv55ypMGEbZUiQ0+3EuHzZ+vlsEi+of/2sfHnGAxzixZNYfFyU
 DOZgserXd0CqzJTkY7apB4GxE8gEuOh/DufxMPETnvfVbCgdE8yUu35iVC1HC4Lu72DE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BjESVd92Wk0lZwQtf+AN+zv2dLsILl7kyBNSPYSyDVU=; b=BJKhQXYVeb0r+/bOtvQO/j5+Ox
 IvFXzM0FT7p2Gl77U6pWfgEKwzKfiARckL3lNMQPdIb69/rMp9Ck400019d2IrUqLDAUqxEjpO8Ft
 pFejnzGAVNGhoF55s0sW3LFpJ+/KsYr+HCrxJvf6DTX+sud+kGsT4C6svyTXMB424PL4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sb7AN-0005AV-N9 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Aug 2024 23:31:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DA19360EC6;
 Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 059C2C4AF1A;
 Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722900652;
 bh=7GzAc4yLKdaVMivmKdQlEXCBG8tMPkeo9h1szBEqHWc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=BPCDXwNQxqFO1HhY3m5wos9DjHcQVnIzwUgAO1Vbx6Y5vqcSD/oYFVXAt4crYEHB3
 0iSFEXebaF3KH4K/Wr5MSJnqsO3Jon9lXEqYJ+lqZ3qCdKvJ4Ux5UlQmbRR9NV5Zio
 YJ9TjJMXhKlB1nlCI2tXGmMJsQUJ64ChmYoF47L32T/K6d6iwBT9Nue4OcKKhxGBm5
 2LIrLENKyt8HxdjTYoDk8/uLBuZpEPGt+e8PkpLLOkPMuppuc6Rny0KS4a3n1X5MPT
 HBAcg4LDvF41Gbg9VO/3+HVqfWsyscox+scLauJZ4mEuCSkIfIKD9ldb2FkI4xMUU9
 GbYTKtdCGUxug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 EFA5DC433E9; Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <172290065197.2803.6155410196213496459.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:51 +0000
References: <2073e8995f5444aeaf7133b87ec07de8@honor.com>
In-Reply-To: <2073e8995f5444aeaf7133b87ec07de8@honor.com>
To: wangzijie <wangzijie1@honor.com>
X-Headers-End: 1sb7AN-0005AV-N9
Subject: Re: [f2fs-dev] [PATCH] f2fs: use f2fs_get_node_page when write
 inline data
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 1 Apr 2024 13:48:20 +0000 you wrote:
> From: Zijie Wang <wangzijie1@honor.com>
> Date: Mon, 1 Apr 2024 21:24:08 +0800
> Subject: [PATCH] [f2fs-dev] f2fs: use f2fs_get_node_page when write inline data
> 
> We just need inode page when write inline data, use
> f2fs_get_node_page() to get it instead of using dnode_of_data,
> which can eliminate unnecessary struct use.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: use f2fs_get_node_page when write inline data
    https://git.kernel.org/jaegeuk/f2fs/c/aac0828ab000

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
