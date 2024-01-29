Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D724AC48286
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jan 2024 20:29:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rUYGE-00025V-Tg;
	Mon, 29 Jan 2024 20:29:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rUYGD-00025O-OO
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jan 2024 20:29:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yBiGqKN7FNDE0aCdLcBlKgGkvYpRNNI2ZSTgMd2KVqE=; b=cPBeyz0gFx34f0ASlxUzx8+1G9
 eR/YSQHaCxBkUYkTFf+6IA4gvhrpAF93g+VQjYOfod69X5GoB+aJcjuom9JHc3U0UMdJCB7xxv3ns
 Hbk+bWQZQNWOmy/RsusMrYayCQVCB0ZvxJyZ51kJfG7yq+3xcmIO8eog8sBu958+zqJM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yBiGqKN7FNDE0aCdLcBlKgGkvYpRNNI2ZSTgMd2KVqE=; b=QsFv1Ym4layLWovC6qblBS4m9B
 0NjNLvxpj5CbmnRKhx0LO/HOY7ItQNoMs6m1Lv/EZVS4nMAHQ8EVn8WoAWrdNkWM2QBBzhVQlshRz
 UfuHqYD2JOhus+b5ef6U4PO93Au2xXWWiQIYwWs0Njz//zMBPza80ur8hTtnjIQw2v+U=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rUYGD-0008Pk-2p for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jan 2024 20:29:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 48EA5624A6;
 Mon, 29 Jan 2024 20:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E81C0C433C7;
 Mon, 29 Jan 2024 20:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706560171;
 bh=Q2PS2lZlOGrrB/bPRS9SVGx50bnEePqslt7qVPvTqkk=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=DLlFbQRueLvaM92KSa8aniBK5Gv7KaHB5WWk1W1L+ucr6y4bLJ32QLa1xxHezm3Nt
 2MjVcET8vyhIkNcCRozyl3VJRhN3qp5wG9JRHUE9XTG/+cTVB760pYFj2KE02A3MWx
 cb/p0xvOhAk5Kjlb2fYzwGcx/m/WaVigu1JlYTtWmY9RpMKeJyHenmAcI6mhxEYBhy
 Xd63Bf5sfsotMyg4MYgSRrIUz0CWFugghUrXAf7sWcLQWwSEhe2ccOMdjlTdq+dPBf
 ErEyvkXQEcBcVn7OENzLPjK208UZ/hCtXRQdz7yRImDV3y6LqVemBocaJ3BNTLgRSZ
 2LdtlMhv7lZSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 D27C9C4166F; Mon, 29 Jan 2024 20:29:30 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170656017085.16041.11567801546674226632.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 20:29:30 +0000
References: <20231229032507.2016012-1-bo.wu@vivo.com>
In-Reply-To: <20231229032507.2016012-1-bo.wu@vivo.com>
To: Wu Bo <bo.wu@vivo.com>
X-Headers-End: 1rUYGD-0008Pk-2p
Subject: Re: [f2fs-dev] [PATCH] f2fs: check free sections before disable
 checkpoint
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
Cc: wubo.oduw@gmail.com, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 28 Dec 2023 20:25:07 -0700 you wrote:
> 'f2fs_is_checkpoint_ready()' checks free sections. If there is not
> enough free sections, most f2fs operations will return -ENOSPC when
> checkpoint is disabled.
> 
> It would be better to check free sections before disable checkpoint.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: check free sections before disable checkpoint
    https://git.kernel.org/jaegeuk/f2fs/c/e2f29120ff1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
