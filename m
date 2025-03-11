Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7B0C28B2E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Mar 2025 03:30:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1trqJu-0001QW-6k;
	Tue, 11 Mar 2025 03:30:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1trqJm-0001QL-PI
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Mar 2025 03:30:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nhSAqr3tXweyI/7BvwYl1iD5EOah0UBstwXsJp/jlHw=; b=mAkLpW9ckIbXnk9vGeMUQmILQT
 GD8RA8cMkNkw7uu7LswsUqrQt1/sNpuzL6xFFsWsJrPlxjNP43rGChSIbth2PkeIaWXsGIbfys9wk
 /TQoWoxVWBUCXV9OdkU8HMzObHcLZnntRWsgzAGA59nxnDwbfxm+GYZ8sl9wcSK8JZ1A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nhSAqr3tXweyI/7BvwYl1iD5EOah0UBstwXsJp/jlHw=; b=X/5b00lBLKtQHpCis+7OIWInej
 nC1Kv4LuXBxKcfgPMeANdOrAT3s4r1AuuMVgrzwSrTY3t/tOFrryebU0gcCSW2TY4Ng2BdQo8eg0c
 Gh2h7gFIOqcvz6dCo7cF4pFQ+NGpGAFGEwudAMN8SQOoohPeHkWuinzUEbY7UVtXsO1Y=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1trqJk-00083K-Vf for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Mar 2025 03:30:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 29C18A467E1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Mar 2025 03:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B7FC4CEE9;
 Tue, 11 Mar 2025 03:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741663797;
 bh=WWxAhaRyLLk+xBVfpWcu3+Ywmw8Hlr2w5bUud1h5QkI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=dCYr6YphytjUHkJsvbhC+0GKywhOOmawkZvlN2HC0uOMsT7MTuzOEcTReh7kc5PoH
 ZJS9ngEBlSQ96imcw6uvqNpQcmuu15RddT68zlRsXkeIU6OnOsBp1evkU4cJ29A/BK
 SMqXut5iwgubL1/QfE+pfc/JBBBdMCOEWMxdZaSaT3EN86NWBT0JSYS41pJSeBF5uF
 1XKWx9GuE+xuMQsObOmcmt4jM0imdOlPLEG2VwmCGXkieEoKqibDnMOobYIVgFQspk
 1Y5nwZIPMHdI79Fmyn4gPMJLr8/zY89WVnrQc0W9dRCXr3Ag2vxf5Wmz/mDKlOVX5D
 EZ2GrdCIBvhTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33EC0380AAD1; Tue, 11 Mar 2025 03:30:33 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174166383201.3785903.5420256276801883297.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 03:30:32 +0000
References: <20250308051846.29079-1-chao@kernel.org>
In-Reply-To: <20250308051846.29079-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1trqJk-00083K-Vf
Subject: Re: [f2fs-dev] [PATCH] f2fs: control nat_bits feature via mount
 option
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat,  8 Mar 2025 13:18:46 +0800 you wrote:
> Introduce a new mount option "nat_bits" to control nat_bits feature,
> by default nat_bits feature is disabled.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  Documentation/filesystems/f2fs.rst |  2 ++
>  fs/f2fs/f2fs.h                     |  1 +
>  fs/f2fs/node.c                     |  3 +++
>  fs/f2fs/super.c                    | 15 +++++++++++++++
>  4 files changed, 21 insertions(+)

Here is the summary with links:
  - [f2fs-dev] f2fs: control nat_bits feature via mount option
    https://git.kernel.org/jaegeuk/f2fs/c/c2ecba026586

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
