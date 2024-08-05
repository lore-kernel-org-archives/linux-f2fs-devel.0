Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C044C52D73
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Aug 2024 23:31:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sb7AR-0001GB-1j;
	Mon, 05 Aug 2024 23:31:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sb7AN-0001Fm-Fa
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Aug 2024 23:31:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wydRsgqzR6FKHnCwG2kfMFB5Ci64rQDzp8dwyf9kxrQ=; b=JWrQRt/z+xc+A+Qc/DG0NtjpmE
 8y1Ufd0xE80R3tl7tCKBAvxmgr2xKJBw6EwmBPxLc7OG8obPX1xQjm4yupx2MrauHtTV+Tne0OllI
 JvyfIMwGGmIUB/8bLP8Qx931OpysakCGZLx4kqv0rzILu5YKT2d85zkDIhJ3Mupl8ggc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wydRsgqzR6FKHnCwG2kfMFB5Ci64rQDzp8dwyf9kxrQ=; b=eiqxggSSA5ZIbOY8Faj0qUTToE
 b+KBBqo1B9Ey2Kv+kBA55WSvPhKzv0e/zDLuF2J6agjcgobw3vNK/VVSWf9whIC51U/zPCKS7Rh4C
 zJTjRT1yqpA+QRe1BDWYQLO22B34neKdrO6Xxr4fE1yddL10xnbegubdjWnfhvvRv1Z4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sb7AM-0005AN-St for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Aug 2024 23:31:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 83A9F60C55
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F030AC4AF15;
 Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722900652;
 bh=kGm5LA15IuGcTFdaGxlr/xX0h027GMbeDIqGZRv/szI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=pNCsYQGdTv20TztN7Ki6TaV9wrW4JDW20yNtwQ7eGyriZwmo1kOCI6tRETgYqm0Xk
 2uu61mVWp1ABXiGwWu9wMb3ex+r7A+RR7W28qW/I5Kzv9MYDH6ly53MJaiEGQj7uTM
 kAILh2L4EOhU3R6Yz7wRX7mFXcwTgMLnTeGoJzF8a+otiNJkbUiNlhMgUT6kBdCgIZ
 nI5zxOcRuixs/M1IN1WyHFArFPLWUIzki6z2xlVVs3KDr2SHaSS58rO+cEBJ3u2Dmo
 0MttebndKHJyTWsqSvRi0PwTlD6DIipiHVUM+j6cOfheogUO0alnUPQbndYz9e09WZ
 3giJcq+hGeJ8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 DF85EC43337; Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <172290065191.2803.3335621723887091762.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:51 +0000
References: <20240627071711.1563420-1-chao@kernel.org>
In-Reply-To: <20240627071711.1563420-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1sb7AM-0005AN-St
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to wait dio completion
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 27 Jun 2024 15:17:11 +0800 you wrote:
> It should wait all existing dio write IOs before block removal,
> otherwise, previous direct write IO may overwrite data in the
> block which may be reused by other inode.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to wait dio completion
    https://git.kernel.org/jaegeuk/f2fs/c/e60776860678

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
