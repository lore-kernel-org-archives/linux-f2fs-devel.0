Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A98EC3DA4A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jul 2024 14:40:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sTMse-0003jr-3H;
	Mon, 15 Jul 2024 14:40:44 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sTMsc-0003jh-Mc
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jul 2024 14:40:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AtrcROkOkxWsusCT5CKNDVEfkFn7CO4WtRNwvEPpKQk=; b=ONrT/luSAZfsVeltHXaNBBFQci
 kYaMYzNqXtBhZJFIQsv6U1Y9nRe7IoB+FATXlEknRMj0MV32M8kZrQa2tZQtFQ8VqXQT2s8BFqI/b
 2k/BN0u0veuh1GAXuSEyotZGmsA5nFMLtCbC8CCfMuRcCTP6FQnzIadm16xZjcTaADpY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AtrcROkOkxWsusCT5CKNDVEfkFn7CO4WtRNwvEPpKQk=; b=P6zaGvgSyMPUlB6bCOGGnkbsXm
 oKtiMOo2bq0AKfb8SESs+CNEGZsD7yTGXzYreFODF6546hsSS4FredZCMYF+twtq7kBu0xdOHbks9
 3e6yY0iEkfX+FHPf6pqxEoceuvBdUVvTtfzDEsBo53JIueDX4Vk3auB1vCov+CIOEW0U=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sTMsd-0003EH-Ip for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jul 2024 14:40:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 77BC7611C5;
 Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49D25C4AF0E;
 Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721054432;
 bh=vQbab53Kq/JDeM92ftMFSZ8LTcTos0iEWTuCkxnkP48=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=uAjBYiYQFWAwJdSGIvuxpLuQBvj0QNLWvydvPwK1IUto2v8zgktZeEhl5TAnjRD6X
 93YELIY8yDal+l0BcbGPL41W42V+gphF6VvmrP61x7XKLft+r2zUmlO2yASXlu37ob
 YFa+MDLyPBkgrhV0bpJHdl+DvT9eAvS90MqatCoEK2VmdfNdPuRgVThLNvb8ee3KuA
 PuVRI5Xx9iy+ZPaba+RVW20dBfivZR+3gD9toIbpp5MBvC0jq2ZFtLB5FKeEmv8x10
 m1eWDjXU2wLlBB1BOlFVgrLw3/DttirtsyZlfENdQuMWjPintYprAkWJ62UGz0iUxC
 9HzpJEtgfUrbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 3A3D8C433E9; Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <172105443223.17443.17786881448481283569.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 14:40:32 +0000
References: <20240708120407.2807639-1-shengyong@oppo.com>
In-Reply-To: <20240708120407.2807639-1-shengyong@oppo.com>
To: Sheng Yong <shengyong@oppo.com>
X-Headers-End: 1sTMsd-0003EH-Ip
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix start segno of large section
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

On Mon,  8 Jul 2024 20:04:07 +0800 you wrote:
> get_ckpt_valid_blocks() checks valid ckpt blocks in current section.
> It counts all vblocks from the first to the last segment in the
> large section. However, START_SEGNO() is used to get the first segno
> in an SIT block. This patch fixes that to get the correct start segno.
> 
> Fixes: 61461fc921b7 ("f2fs: fix to avoid touching checkpointed data in get_victim()")
> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix start segno of large section
    https://git.kernel.org/jaegeuk/f2fs/c/8c409989678e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
