Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CFCC636CD
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 30 Jan 2023 23:00:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pMd8d-0001lZ-Dk;
	Mon, 30 Jan 2023 23:00:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pMd8Z-0001kv-Vb
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 30 Jan 2023 23:00:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u5ski6DgZGOjrIRYBjHLjJZAn75Jv2QAkQhvrW0+Ygg=; b=bXKDihgiSxHTVmPOze1yX7U8nU
 mNC2T4mPX4sGL7YcStr2O0YRVHjFZseL4/Bd/m8Ali11ILfzeVUST0mEzbKyJxFQIHEJG2dK8hMfr
 K7MYqNCJI/Z2Y+DDmkN9M7qzl/tDnZw8eYQeHHbqhLMWScp2eVKgNDsqj+O1VBWQ1R/g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u5ski6DgZGOjrIRYBjHLjJZAn75Jv2QAkQhvrW0+Ygg=; b=hcZsdC01DP6aqEqGW2vg/t7XPN
 iIJarkmi8Wjm2hZ/xmK9FPhdPbvzLwtu4ct8yDut6UPScGsWvjOZG99ufyy5HNg1wLSXKZtB+6XkR
 c+YcCt9SVeY+QMYIDyMcCBAKe+YuvFrB8HZLP5Qz2aRAyLbOGxw6i23GbXXHKaqJKgR4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pMd8X-0002fk-8V for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 30 Jan 2023 23:00:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 71ECE61309;
 Mon, 30 Jan 2023 23:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 590B1C43445;
 Mon, 30 Jan 2023 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675119618;
 bh=VQfPTgOSrENSs6GXZMHzN6Pub/gJTtD/bPFw5A74qKg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=ccp/gDfbo3m+Z0A2407sCUnbNnoziYMPlai7HPaO4tnbborNjbknIIeNDScwbsLHK
 KvmNn/n7ehALHEBacUy/+fFKugprp9wzbDU4f7AM7VgIp8Hnn5PZAVmizCh8xzirrR
 Mj7JP2X+Qsw9hWzpdjz6DkxvCKEp1zO2X9ioHuRnqk1ce9wC6E0dDflHdocph2RyzZ
 AFNWkMZ06r2wmQrJb8ubgoJDOs8Dp9etwJ0cr/yhQLlhLE0/2rmPXv6ERi5p1t3l8m
 Hu/PYIMGpYBT1CgrP+aAYqw+C5lI3SlYnqGKzxUToWX9uoxk+Hacmn8sn/UkprsgxO
 DXFIfnCONji+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 111D0E52560; Mon, 30 Jan 2023 23:00:18 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167511961806.12751.12383846430084360473.git-patchwork-notify@kernel.org>
Date: Mon, 30 Jan 2023 23:00:18 +0000
References: <20230116141228.43239-1-frank.li@vivo.com>
In-Reply-To: <20230116141228.43239-1-frank.li@vivo.com>
To: Yangtao Li <frank.li@vivo.com>
X-Headers-End: 1pMd8X-0002fk-8V
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to show discard_unit mount opt
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

On Mon, 16 Jan 2023 22:12:28 +0800 you wrote:
> Convert to show discard_unit only when has DISCARD opt.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/super.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to show discard_unit mount opt
    https://git.kernel.org/jaegeuk/f2fs/c/d6a19f963267

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
