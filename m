Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6368C77B6F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Apr 2023 16:20:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pmdCz-00064J-6R;
	Wed, 12 Apr 2023 16:20:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pmdCu-00064C-LT
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Apr 2023 16:20:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xvz7HMhCshXeRw3tCTe4ZoDFX/5ub3VU+G4cNdYHbIM=; b=UncbqDXBS7+Rh9wI75bUWWxWOD
 PAbo8n8VZyHUi8D6e+SEk8kg95ss8Ufcy4RfuKNnI3kOcmc0bE2Yhexb+7a0/IRUpK2aW+t8Fqbno
 wESLGZIS6yniQoLpswdWDiVN8Jrc5TRiakp3fDE1vz34AcgqisCXmdJ4dJ3aMlDFH6TM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xvz7HMhCshXeRw3tCTe4ZoDFX/5ub3VU+G4cNdYHbIM=; b=jkKYWm/bwZRVh+4Ma9ds222gUw
 Lr685/u5IxGNULrKoSyr2hAj1pO6N99jSKMGvu2ohNVEGQAoXZu0x78Bs6Ob3xk0ackX6FUkhJCZO
 Yg6xg+XRwEPg+44A8eyDHLQI4GdX46HQu+oXOqAa1mYH4sMbo1VSA9Lq9Ztnq1sWdaJY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pmdCr-0000Va-PK for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Apr 2023 16:20:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 597DB636F5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Apr 2023 16:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 473BCC4339C;
 Wed, 12 Apr 2023 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681316419;
 bh=VcYMUlalEo67BcQfGfo22Iw4VPxLqADA39fwd9YNUkQ=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=iV5EEBNBOCmXcMsQVF+4xczLZcWmuwKkYjiv4kSm5qesS+eCR+lOwQe4EoQSnpoJb
 MrMejLpfRFtj51qF0nzP6JSVKb+S9aWrlgGsSd5I7Or6pdlMkj7YiH1GexIWMX1Xwi
 E88v8eq37u9u3+P/AyvGCH28YFC060hkPwuzO7yhMLaAVQtVkhBkXXI+egacj1+JNA
 KbQn3dj+iAtv35qCe3AIgkD0cBlVHYOQ9ti6FDv42ec6GAzPBZ0HtDsgouawZ5xlQw
 BKODCp90T7GjKPaNVh0zhzrWHKD/MX9SN++06GxfAzhWBZEbHnCScRu3DPxp4JBmoJ
 VK2EFbPOB8HSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 1D09EE4508E; Wed, 12 Apr 2023 16:20:19 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168131641911.15557.3644141537765854955.git-patchwork-notify@kernel.org>
Date: Wed, 12 Apr 2023 16:20:19 +0000
References: <20230406195122.3917650-1-jaegeuk@kernel.org>
In-Reply-To: <20230406195122.3917650-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1pmdCr-0000Va-PK
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix potential corruption when moving a
 directory
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  6 Apr 2023 12:51:22 -0700 you wrote:
> F2FS has the same issue in ext4_rename causing crash revealed by
> xfstests/generic/707.
> 
> See also commit 0813299c586b ("ext4: Fix possible corruption when moving a directory")
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix potential corruption when moving a directory
    https://git.kernel.org/jaegeuk/f2fs/c/004620a236bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
