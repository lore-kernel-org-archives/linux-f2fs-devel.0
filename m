Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD582C77B6E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 13 Apr 2023 23:40:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pn6YN-0007mt-1w;
	Thu, 13 Apr 2023 23:40:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pn6YK-0007mV-Qa
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Apr 2023 23:40:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vL/80rbqW1MiaNbJyd6RmbqNI7drkpnby40HFmfoBEg=; b=kANsyCXUdcMyn7qVr2JDAtoEsB
 6yQ6nNta6PrR7ogRNrMSwWtIWHsOpBhJ/Apz8AWS4WaI5ZVISxaQpfwVavE8LgBEqfb36hPquW0E7
 pm2yy6C53aXL8G07gk4xFTV8ZjNlvh6pxxy9/FlgEuNG9Xat7MrBvuTt9zUmh7a8bBIY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vL/80rbqW1MiaNbJyd6RmbqNI7drkpnby40HFmfoBEg=; b=TTwMI8nc4LxuhJxCJVOskWhe78
 VOruTBuynvZie3aGG3chnaLcPa/QIWThxvTgZBbwKd2fuSrg+HZVnbjkqVOxQBUj0yPvEvqy96Hdc
 2lzfKtNoKdBNtNJdMMZbYYwH6bPVuD2ffyZbX599AB1J0hYCwVDZOfuZn+H9cBgYYJY4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pn6YJ-006ztU-A7 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Apr 2023 23:40:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 614436429C;
 Thu, 13 Apr 2023 23:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3324C433A0;
 Thu, 13 Apr 2023 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681429219;
 bh=y1tsCDiR9PB0QaZqwPHvaqN4LWmaz9Wyb/y9A7Tkf5Q=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=ZE0jiYJYP3cQM56F74mfHvqsS8Bkl2etzHgJ+mhyvwgEFuNYXzWCXxabfjm8Up+tu
 amXve31PQc2ZY+SKmEDoaDyRkR+MkD8lqU4+WTNTC6GXiOhUNTn+VPmtpNr+Y1UEaW
 2yeipsDYoiTcpA10S2vkDWsubTSGQK3euLBKDn+6CVG4//QNhRCApbsLmaf/Dy7k2i
 swIRPhPMKGAJ2VXrcu6FdFwJEPP+Hf/WOjFyWXXDN1zBBhp2+ztgODOWDUPzICGTYl
 4OPGgAMJSyqsejovCPxp5PrYhddY16ob788ybkaUKzBNEiAQH7RPcIOYxyaATYqqES
 y9QuQUC7AlEmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 D0646E52505; Thu, 13 Apr 2023 23:40:18 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168142921884.31957.17494916129948763212.git-patchwork-notify@kernel.org>
Date: Thu, 13 Apr 2023 23:40:18 +0000
References: <20230405144536.930370-1-chao@kernel.org>
In-Reply-To: <20230405144536.930370-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1pn6YJ-006ztU-A7
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to check return value of
 inc_valid_block_count()
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
 daehojeong@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  5 Apr 2023 22:45:36 +0800 you wrote:
> In __replace_atomic_write_block(), we missed to check return value
> of inc_valid_block_count(), for extreme testcase that f2fs image is
> run out of space, it may cause inconsistent status in between SIT
> table and total valid block count.
> 
> Cc: Daeho Jeong <daehojeong@google.com>
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to check return value of inc_valid_block_count()
    https://git.kernel.org/jaegeuk/f2fs/c/935fc6fa6466

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
