Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91762C636D3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 30 Jan 2023 23:00:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pMd8W-0001kK-Kz;
	Mon, 30 Jan 2023 23:00:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pMd8U-0001k1-Qv
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 30 Jan 2023 23:00:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4SQLkTKxzLH3BSKdy3EbbnX/DuzmlPwF5xyCxUYpu4I=; b=A9I5P71IqTpTKWUr1M2sWiNdQ3
 rVCH3ePxiGdQZMf98IKImBxel1X4zND+4WpLyfakf16+uhk55YVgtsUnEVOffOmX/pJYUalP0JCpk
 jNj7QxsGB/P5vQ+AIzpJbLYKR6VPjh6n3f8YQ4A5HYxU8r9C2+cBeniXZZlAnQbKyBRQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4SQLkTKxzLH3BSKdy3EbbnX/DuzmlPwF5xyCxUYpu4I=; b=hu18Mgv9Q019L2CuMIv+DoMm/c
 Vo5jDZbA+PDksWxOGkMbSHe0lnmNBxDCbUfpH/ovKxqUAQDq2vE66kzzjeO/UfZo5uya3T3InfxXe
 X/CLCDIZSKbkf2hrOfJkaYtR4ij56Vlq6/FPn0Fh/KhUosf9SAwiJ4zqUW6fUPlQe318=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pMd8S-004OGV-Kt for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 30 Jan 2023 23:00:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 43CD6612F1;
 Mon, 30 Jan 2023 23:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41BC3C433B0;
 Mon, 30 Jan 2023 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675119618;
 bh=xc/KvQ4qE0zaYQjdK4Tv1DHZUeHVYvXu8EZbsocIWMI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=dGpGBnSMfW8ed69u0Uf/Jclr2hr47Yn9jb4pQPEFKNbbRpQGGYAiFfvcaCXk6NNZ7
 1lU4LBBOupaNXs8O8cFCMzXsyUIZQFKCTcftkCg5Ulru6ffLLiqnCCvaV91K8l/LEO
 awZcyX/x6wz2S8N5H3v0ldnmzLOMLu+kJyjgBIOkEds1mzpVOzRXcTMXwNcZAYdu82
 opqGaeee5mJjjtQ7okuYJFpgoFrQxLjb13OdBGoXQGxwbosicx9EfPJZSzX5MryoTm
 r09zs4g57gIuUtkbxLJlAoRNHtHy1S2/0Hw2miEHVN8Mi0kz9uzMRoVOOWeiYqA0QM
 Zw54fyIIL1GCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 F006FC16ABD; Mon, 30 Jan 2023 23:00:17 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167511961798.12751.8349285057815304075.git-patchwork-notify@kernel.org>
Date: Mon, 30 Jan 2023 23:00:17 +0000
References: <20221222081855.81553-1-frank.li@vivo.com>
In-Reply-To: <20221222081855.81553-1-frank.li@vivo.com>
To: Yangtao Li <frank.li@vivo.com>
X-Headers-End: 1pMd8S-004OGV-Kt
Subject: Re: [f2fs-dev] [PATCH] f2fs: drop useless initializer and unneeded
 local variable
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

On Thu, 22 Dec 2022 16:18:55 +0800 you wrote:
> No need to initialize idx twice. BTW, remove the unnecessary cnt variable.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/iostat.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: drop useless initializer and unneeded local variable
    https://git.kernel.org/jaegeuk/f2fs/c/c5f9db2548d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
