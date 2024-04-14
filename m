Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7E2C4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 14 Apr 2024 15:33:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rw1qm-0005r4-SP;
	Sun, 14 Apr 2024 15:33:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rw1qi-0005qg-45
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 14 Apr 2024 15:32:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nbtp4JGcHjBmeLmleqXkz7BYsg0ajmoqJEsHOIte6Sk=; b=Ktpp0Q1SePBE/X3YTkuLtr9nYF
 F3XGVhe4MHwXDL0G7ftYkBtSiAkO88PVBHPH14cG0E0yHDeo5M9uWKslQYjklDrjH74qSrC4GvwZL
 9AYBhT/Ob12XBTc4v/YOfY9CbFMv5eWWRKjUU1xplCxNyNqRDlDGO93hWKPDPaijsUCA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nbtp4JGcHjBmeLmleqXkz7BYsg0ajmoqJEsHOIte6Sk=; b=bhnZ7PCKLb48IHVYSRZUyNbvhC
 Mr5eNISZ6ka7zjkj/nTmAlQVNn1LNnBw0krf0vxzJ8l4ml0UbZ7gzFTRGiuWN0nf6ugPlU3jHUBZy
 oiHZu8gQqmJw9zlRWXF5UM399AAxZSIyKp0mwzbyUXiXHzQwV1tnfMO/YA5/8W8swG1A=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rw1qh-0003WL-LI for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 14 Apr 2024 15:32:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8F99A60B7A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3616CC2BD11;
 Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713108765;
 bh=1+MvVzHCjdnOAPGRAAgFhpSlsBWkDBjSaeiuc9GYhWY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=qyfkZo1lvO/Sw6BNSwNPPGo6RDIhkLY3sKZqEgvB8DLak/Vf4P0mK9BHYuh8xVTz7
 R5FS22TpIW+mwN72PC6o4VMch9MbC2AUwIuPIT+jXjrfrWvyg3jsQ9cgGhkoiB/hep
 pe8bjVtBBSzJYQJgAYsNwcIHVdEujFA3BXsIn0Sqs4w47+iV6/KKUnnOgJTxOl/qSz
 PCwADCAJRewhwMoSO+HzEHtyVzUrrrxuMmIEyWEQM0zqWaptydeohUCy2w9ip3G0oe
 OYVJ/kjvqt8rzvobbwGRtDD/rkI50T2uvSM6vvZrLepc4Cao6Hf22WxqMTCls7PnV+
 SzX00aNligYkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 24C74DF7857; Sun, 14 Apr 2024 15:32:45 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171310876514.3156.10934685583605806738.git-patchwork-notify@kernel.org>
Date: Sun, 14 Apr 2024 15:32:45 +0000
References: <20240325152726.797423-1-chao@kernel.org>
In-Reply-To: <20240325152726.797423-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1rw1qh-0003WL-LI
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: introduce map_is_mergeable() for
 cleanup
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

On Mon, 25 Mar 2024 23:27:25 +0800 you wrote:
> No logic changes.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: introduce map_is_mergeable() for cleanup
    (no matching commit)
  - [f2fs-dev,2/2] f2fs: support to map continuous holes or preallocated address
    https://git.kernel.org/jaegeuk/f2fs/c/9f0f6bf42714

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
