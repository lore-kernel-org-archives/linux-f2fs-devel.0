Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAB7C77B61
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Mar 2023 16:00:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pgpGu-0006PH-0p;
	Mon, 27 Mar 2023 16:00:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pgpGn-0006Oj-3W
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Mar 2023 16:00:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GcL+gp5yKZmYOSEpciBb0UtRfiB1oNhVm0xUGrUGl6s=; b=VJ2ctHiRlxaERw2XLZS3qyVMNd
 q21uQ2rEBU+rq4Uuj/oWscvHqqrk5GVjQHzdF95PHs23tnjWqbiQxUOXbCj/AaJ9XDvaGSIuuaj9m
 dHbE5LpChgzfaqLyZnuKb5CbWuaKfG0eepfThyJmgDQoLf8UgiRrrkOdSRhq4O3BwenQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GcL+gp5yKZmYOSEpciBb0UtRfiB1oNhVm0xUGrUGl6s=; b=VikPp6SiSbj1wXHvHZ4pboQeiS
 I11cN9EJ/kO3hcwDbkJ80yP6T/PQKEvegGEM9VtmGoSQ5vqTkbcHN2wUt97uLE1+fMxvOc3Rx/Nei
 Jhpi6Pb4eJQRF9hzdhuiTC/gcb7q1ecahB7DsQ77Zp9c8YYknMnI42YWN/ALRMeAAads=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pgpGk-005vG4-FR for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Mar 2023 16:00:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1B5336135E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 27 Mar 2023 16:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 184B5C4339E;
 Mon, 27 Mar 2023 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679932820;
 bh=3jeLI4LTsYCp3kwhcKY9IHXINDekO/ssj9j+z4zwTcM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=AOFGrERiZ5++Mmzzv1/b7Xrf8RFXCR6ji+7TXxR1hCG1tgVEbhTJ2PjnZyasg8R/T
 iNj9N7e5W61tE5wUPuoesNCa2QkBWpN9DA1kpdGNeR2MTFjbmNs0zgNGxD6GmXsac8
 g5jPWNbxAQCrkYHdMYVHjQT5XJJQRz3sSEhY4SjZNbRi0nCzoTUU5qGAtp+hXEos6T
 jW2neyw9s/9OndPyCLHTnPBmCQ/Ur+blSqT4gtUujlUsmysf7Hz93rcJfCVLs1l7OP
 suZccaQGIp1PJbebSVtmv76pim2KRp3IEzuf94HFepFJGwCs4iRDhG3KTBhLcniMYw
 jt+c48TiZdsag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 E3951E4F0D0; Mon, 27 Mar 2023 16:00:19 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167993281992.32120.15689550099953516838.git-patchwork-notify@kernel.org>
Date: Mon, 27 Mar 2023 16:00:19 +0000
References: <20230321231157.963598-1-jaegeuk@kernel.org>
In-Reply-To: <20230321231157.963598-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1pgpGk-005vG4-FR
Subject: Re: [f2fs-dev] [PATCH] f2fs: apply zone capacity to all zone type
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 21 Mar 2023 16:11:57 -0700 you wrote:
> If we manage the zone capacity per zone type, it'll break the GC assumption.
> And, the current logic complains valid block count mismatch.
> Let's apply zone capacity to all zone type, if specified.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/segment.c | 65 +++--------------------------------------------
>  fs/f2fs/segment.h |  3 +++
>  2 files changed, 7 insertions(+), 61 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: apply zone capacity to all zone type
    https://git.kernel.org/jaegeuk/f2fs/c/0b7d8adb1ba1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
