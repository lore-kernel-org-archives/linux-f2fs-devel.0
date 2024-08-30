Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F5CCA101D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Aug 2024 20:51:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sk8b5-000535-5f;
	Fri, 30 Aug 2024 20:51:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sk8b2-00052t-Bp
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Aug 2024 20:51:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4E8fpKBBTrEmRBiMPCCejsqJ1zM1hnseFDIdIbeFXRo=; b=ELNEJscPsQCkGKWizUkVuCrjsN
 su6iMkFI++/eoUzcsCXfsxwd4+Kwd8cHEfyZthp8zY21dyNMUJwlJMXoZ9A5T9jzoXPQsggl5xtE2
 bxVwi3LB0kqSNLg5vTLo9m/7DDwSB1n+uOZ0T1Dk5VKYXxf8XXqnvwHtd9LAw0918xtg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4E8fpKBBTrEmRBiMPCCejsqJ1zM1hnseFDIdIbeFXRo=; b=hnrz9d1898IwWD3S7BNqwNFQV3
 C+QsxumMNVhzfWDgtNTXtdlldGbXZbqKcHuD0bulu0VBAJZZjTt58aAQaoKcYw2nGyBPjaqat6Edl
 dtbJ1xqcV+G7wqEcj498BOLkAn+2t0gUdLZKXgSNgzFygJYtRp1oVcdh3NfxPfEvGfnI=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sk8b1-0005mp-3m for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Aug 2024 20:51:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 6B918A41AE0;
 Fri, 30 Aug 2024 20:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF52C4CEC2;
 Fri, 30 Aug 2024 20:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725051105;
 bh=tQRa7q0D+LkWLy/OI2DyVMxkZHU1QU8d28Z3XzOwl90=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=KF6V+2LUggpoxduIVgSjPBj9ABhgGMXDEoPRaogn0sAWI+CGGYjfuuZhHGf1r5hW2
 TfgaB+e1PFbZROMBvLetywx1IXyGfwBMtA1NBM0BOkJySLwUu9mmhGA53/lHeUD/Ae
 xiT3yxk/uIicALyS4A/udF9W7fOCpS3wfkI6SGxz1wQ1Q8y8uX/kNLewAqkkPYjH6z
 rRmjmwf2Jo9rVPn5Sanbf54gRIOkCObjU8QTeK+G3u1z9Cpxynx4PpX5bfWcAdhOeO
 XgazP+c4L2iJNsmSURTTpb+adhPkLsTuOzSPH7hw7dxQchFHZ+Pz8VtLghPcOSJXV1
 P2czZgwDsal2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 EAE223809A80; Fri, 30 Aug 2024 20:51:46 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <172505110550.2712133.8948730888225333311.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 20:51:45 +0000
References: <0afb817e75a84859e1a86e1a7ba2041a9b852b6e.1723117820.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <0afb817e75a84859e1a86e1a7ba2041a9b852b6e.1723117820.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
X-Headers-End: 1sk8b1-0005mp-3m
Subject: Re: [f2fs-dev] [PATCH] f2fs: Use sysfs_emit_at() to simplify code
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
Cc: jaegeuk@kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  8 Aug 2024 13:50:46 +0200 you wrote:
> This file already uses sysfs_emit(). So be consistent and also use
> sysfs_emit_at().
> 
> This slightly simplifies the code and makes it more readable.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: Use sysfs_emit_at() to simplify code
    https://git.kernel.org/jaegeuk/f2fs/c/f7a678bbe5a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
