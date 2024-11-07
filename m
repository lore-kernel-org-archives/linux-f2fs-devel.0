Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D46D5D68A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 Nov 2024 20:30:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t999Y-0000EG-Q7;
	Thu, 07 Nov 2024 20:30:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1t999V-0000Dt-RX
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 Nov 2024 20:30:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=huWsZthXaTXt/fCcf5KlZbXn8sBf5guy5POqzjzVWHo=; b=H6DrTkg5Wu4PV7BjlPU4SRiAqL
 hbkepLut5EgW5ICkS66KkSmeSLQ/Qx1eTGsUbJuw+7lxfFzz3t0WLRiPlUPdaJAcefd6n+JCBEl1K
 W0nWGaxlbaZGjfvWFRstsXngqLO0Mfwo+QfpIvDdjV894EkRXUNfKSMOQzQqYfTh3c6g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=huWsZthXaTXt/fCcf5KlZbXn8sBf5guy5POqzjzVWHo=; b=KEdhqJ7uVQgzi7OrztDGriDv2C
 FfSkYOm03fqUYCneAnjr2Kn51eAbhF7zDrSwVV5ygWxGtbDEY1/FydcaT/LQ7QDbomD546VxhWTfz
 rZbevLkSYI1YxaSkEEzMRQxRUcywJEsIu/8XDOYnR5W4zWO4rhwobxJ+3T7lw/T7zlW0=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t999V-0003uk-9C for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 Nov 2024 20:30:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D03C4A44ADE;
 Thu,  7 Nov 2024 20:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74068C4CECC;
 Thu,  7 Nov 2024 20:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1731011438;
 bh=6LF8apqu37tZ/vIkjEyn73lKkMP5tjDYnlJPBlAL/JY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=K4+H1YOuwRo8vOUQfqpa7F5GU+110ragLWqwhQBwoLPpdWeGhoAS9P7A8C03k99+Y
 mIvy7dfGa29CTQc6B0uDh/HuCpS6/Du080QLoqtdHrAeNgmuWiujB0XAyxal5tpnUi
 QWnwiz/9s+MzDSs1Y3OJLziRPYzo/j9MwTk/j3buTodQzNY0w83k/QovNnUHNYCTAE
 grUwoNlgqZ/S53jOLI5v7EwKpvQs8CGdpb0kDd5TxSkI/ovwhN48ioZeVM0k8sNYwz
 pDME0htS8doJRBTV1QcmRzkg/Q+9IYeuuVmbsUK3bMh9K36KoLOS+K9gztZAwk3YYM
 3fu1YbJGFfMeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 EB3993809A80; Thu,  7 Nov 2024 20:30:48 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173101144749.2084993.7190591063897866454.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 20:30:47 +0000
References: <20241027140623.24802-1-algonell@gmail.com>
In-Reply-To: <20241027140623.24802-1-algonell@gmail.com>
To: Andrew Kreimer <algonell@gmail.com>
X-Headers-End: 1t999V-0003uk-9C
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix typos
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

On Sun, 27 Oct 2024 16:06:08 +0200 you wrote:
> Fix typos: datas -> data.
> 
> Via codespell.
> 
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  fs/f2fs/debug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix typos
    https://git.kernel.org/jaegeuk/f2fs/c/e63ce120b41a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
