Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BEECD98DE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x5vjyJ19UTY8z59pn8CQK6Twyk/nkEuMUrmEbTcNEV4=; b=OsxriHspOVkmlYFHbWRDy4W0mM
	zL+Y0S9v8xKRc6o3UjP2jKdiX2RIzeVHA+0cpGRlzkbBQ5LDz4b2+8cxDAxbdEB5OapAM4NyJ1DMZ
	lMpAoa+YX7aPDRv4sIj4XUmryPJ/SHOBvXEBIvXtYmjYxkSFlaqDYYiqPYdPynPtbNik=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZJss-0004Ev-6F;
	Tue, 16 Jun 2026 02:50:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wZJsc-0004Ea-GK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 02:50:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uYHXw9s2G03tp7BHPHlk59AgvjQ7NSMtGPMB/Lk+1Yg=; b=DvQ6kNMGO4ulD0e1mNRR12diQQ
 VlGspCM1S2Lgs2dzJM5BAN1XRCbughOVIOLynCH2j2d6pNoJ+In+0C02ax8gwgVs+UXt/+FFhI9I8
 dPuOzZz1qSX49RN+h50m7TQQ4XDnnkqg528S9TbttYpZ32JdW8yQedaZRc2pnGqVfV4Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uYHXw9s2G03tp7BHPHlk59AgvjQ7NSMtGPMB/Lk+1Yg=; b=Ze529zNnccuotFqvxtqxc37ZIe
 C9fM0tMlRiG1QI86ZNePOJLq3kyyuhHncVM7cKGpb8TgwE/C/WC5GyWRcSbCsVHNRbsNH/z/vqi2Q
 aI0JDC5RBlIXNqdWieXIPw0mZ6sh8vB6ZGF+siUoCa4C0BpR3vQ3bU2/K9WYe3u2h9O8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZJsb-0008PD-Bc for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 02:50:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D77F4065A;
 Tue, 16 Jun 2026 02:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724081F000E9;
 Tue, 16 Jun 2026 02:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781578211;
 bh=uYHXw9s2G03tp7BHPHlk59AgvjQ7NSMtGPMB/Lk+1Yg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=jgvPQcSN6AACN63Ha0a7jlWmL522AGc2J34NqZBlcT3aF0OSLhFbva2nmCAuLjLXN
 vxEyTVGY0aeqsjXqxcxMUWtjolfFC5VtNyoGxHHbhyNMweZ3cPJH0Nj8hokZijwU3s
 KjUV+PntsgHjMO6jAGXAUhemZVp6AGaB2WAQCQFC0MpNP7i70FiXZ/ri4C1spQZSgc
 nW85Kqorr8e7cVU0p0pjykZBzuci0TYOuefvAj5Csb/pU/gp3E6FaMpep6nufCVo8O
 pRGPoHCFD/Gx0r4X/5BKRSkLzoc00r6LH8N02gVgiO0TqTIj3AstaczyGW5eJVsZNw
 OibQQrNylD/Tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93BCB3839A26; Tue, 16 Jun 2026 02:50:07 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178157820614.407856.1733629854453320542.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 02:50:06 +0000
References: <20260603161127.17464-1-sam.moelius@trailofbits.com>
In-Reply-To: <20260603161127.17464-1-sam.moelius@trailofbits.com>
To: Samuel Moelius <sam.moelius@trailofbits.com>
X-Headers-End: 1wZJsb-0008PD-Bc
Subject: Re: [f2fs-dev] [PATCH] f2fs: validate dentry name length before
 lookup compares it
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

On Wed,  3 Jun 2026 16:11:26 +0000 you wrote:
> The f2fs dentry lookup path can use the on-disk name length before
> checking that the name fits in the dentry filename area.  A corrupted
> dentry can then make lookup read beyond the filename slots.
> 
> The bounds check needs to happen before any comparison that consumes
> the name length from disk.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: validate dentry name length before lookup compares it
    https://git.kernel.org/jaegeuk/f2fs/c/d6d43742e65d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
