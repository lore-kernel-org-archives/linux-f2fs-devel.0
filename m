Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B98EB64DC
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jun 2023 07:11:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qCETL-0003Hq-4e;
	Thu, 22 Jun 2023 07:11:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qCETK-0003Hk-4T
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jun 2023 07:11:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+QAphcqL8p7Bcm3ZcIgK4NuupT7+P6wmy6VI9fMBWZo=; b=fXnJquLUisu40L+uzNLpPefson
 90amGYUtV+0yMis9kUmVA5pZajdSZ6O/Tc11XtR6BA+/CET+NMR+XsBj+rcZRfm8Ena+wW3tIQEDd
 KoImFFFV4ybvifMIGAwaA67nTEW14ph1NTSY3xs2hmDMs7DrMusyKpE+AWv32ovcVOP0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+QAphcqL8p7Bcm3ZcIgK4NuupT7+P6wmy6VI9fMBWZo=; b=PfgmeosUdJBXcarXNXlE9HzDxo
 j5Cvz7IMCxVYdNjMxW99JNSMg4RxEHyBuYM+ZFdlwEZeNCYeRXGGzfe8Lfy6hOjkEatWqwp83eZdO
 imfKEBY674+7xb3EqK9Ps3aDikSJ/mDeQr/7TpCP4JGxrgBTOQpDDsVXs3opVw47vHWE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qCETH-00BGOp-Am for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jun 2023 07:11:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E7AE66177C;
 Thu, 22 Jun 2023 07:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53330C433C8;
 Thu, 22 Jun 2023 07:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687417865;
 bh=vrXHtyphIJe+SKj81IvX0Y99BnNTATMm/NijGQ1EtTg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=PUtViafET0AZXl4/NXmnOZfAwAEeAN9/I5Jqn/cHkbz7v/TZUtW+nKMcOakPrO+pH
 ikj2SzC/BolmNIRhZ9zf+iY1DDKDbPIP2C128fwF71dxElBciBBNrJDmjEwXZHDpU9
 osLECYS7rkLCWgC6Clc1B6eXOGV1g2gjO/fhTWEwi8boz6EhVM4iD8l67UzhpO+vHJ
 iQexp6O45ZJCeoGVy++5Ryladbng1wOMLCJOxO7r6PtYmtnh4jYjC1+wVzTQW62MKp
 ewzJysmp33FRhaiQXvK/Y3GHFSZzN7WCNUT/Kk1/kqMe8PkAB+hCOEIRVpPP9PTOZp
 ry7lBoB1xWMTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 31431C395FF; Thu, 22 Jun 2023 07:11:05 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168741786519.21692.7476718026354315817.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jun 2023 07:11:05 +0000
References: <20230509095706.17844-1-frank.li@vivo.com>
In-Reply-To: <20230509095706.17844-1-frank.li@vivo.com>
To: Yangtao Li <frank.li@vivo.com>
X-Headers-End: 1qCETH-00BGOp-Am
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: convert to use sbi directly
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  9 May 2023 17:57:03 +0800 you wrote:
> F2FS_I_SB(inode) is redundant.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/file.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/4] f2fs: convert to use sbi directly
    https://git.kernel.org/jaegeuk/f2fs/c/08f83cb23a3e
  - [f2fs-dev,2/4] f2fs: move the conditional statement to hold the inode lock in f2fs_ioc_decompress_file() and f2fs_ioc_compress_file()
    (no matching commit)
  - [f2fs-dev,3/4] f2fs: move the conditional statement to hold the inode lock in f2fs_release_compress_blocks()
    (no matching commit)
  - [f2fs-dev,4/4] f2fs: move the conditional statement to hold the inode lock in f2fs_reserve_compress_blocks()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
