Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2923C0219B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:40:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tg6na-0003b1-TK;
	Thu, 06 Feb 2025 18:40:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1tg6nZ-0003av-D3
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Feb 2025 18:40:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xkebwybeZKXTBIMG9sknuMbXHp1lSzdqam2gGx2Zfo4=; b=AYjBo9OIByN7xT4yXUrpIQLGTC
 RSRlo4tHVz2+pTembITWm8ob3xR+wDiysQW4gWr6rnRczOycVa8WadefB/MsAMapU5yctMO9FupC4
 hwTjU/T4LG4yhGjPwcMpQYes4sr02OINkS/4Txa3f2xyuXvr0rNPqqVLIiGIOtpZwSxs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xkebwybeZKXTBIMG9sknuMbXHp1lSzdqam2gGx2Zfo4=; b=Dip+y94k8GuyfIcazg8ruUMbvM
 nLNsGqMKr5VyKbhost5gERvrfjtM2zOg5e8zlT7STuSyDWRIUUqQQm/gcM1VRVWEIr5lo5Ksdq4o3
 gUUYfzZsDdeLX8tF7wvDcXOchHv2Ztt++guPid25rkQbE0fHnDKYH7l+4hS5qVCTOFHo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tg6nY-0006Kj-6O for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Feb 2025 18:40:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1867E5C6F24
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  6 Feb 2025 18:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871EEC4CEDF;
 Thu,  6 Feb 2025 18:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738867213;
 bh=5dNM/i1ayUO1sOFr062gfytBTm1MvjWJ12CSMKal6t4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=eXqKADfoVs/244ewIszbcRJtNkvXHSqDoN1tiaFuoWJLPOl1y4UPp7CLHjwZs1bZA
 f5e0losDUiqycFzcnx/sk+ZEdAGhE34HQAdlkA/xLj4JlEhVnB9Uw3lPs5GfSmYjO4
 oruvCLfr2nKKw1LAHhLZ8yHq17Y/VU5XPlopCZMtJZ8sGWFXVv+ELZcvknw4e5cfaq
 v0H5FfKD0W6BmbtlLy7jxMFx7FmykjIH0WljJNWLIq0qmm1mJoABxhrlHfQnII3sOT
 ji411CW31FfRnFxUxrXH3fZPg01bxVEoVkochNPfV7st30KI1eZWpw4B1lqWlMLh2K
 jO4sbWuphAWhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 72771380AADE; Thu,  6 Feb 2025 18:40:42 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173886724100.1614734.4865548198435341327.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 18:40:41 +0000
References: <20250206064451.3088028-1-chao@kernel.org>
In-Reply-To: <20250206064451.3088028-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1tg6nY-0006Kj-6O
Subject: Re: [f2fs-dev] [PATCH] f2fs: quota: fix to avoid warning in
 dquot_writeback_dquots()
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

On Thu,  6 Feb 2025 14:44:51 +0800 you wrote:
> F2FS-fs (dm-59): checkpoint=enable has some unwritten data.
> 
> ------------[ cut here ]------------
> WARNING: CPU: 6 PID: 8013 at fs/quota/dquot.c:691 dquot_writeback_dquots+0x2fc/0x308
> pc : dquot_writeback_dquots+0x2fc/0x308
> lr : f2fs_quota_sync+0xcc/0x1c4
> Call trace:
> dquot_writeback_dquots+0x2fc/0x308
> f2fs_quota_sync+0xcc/0x1c4
> f2fs_write_checkpoint+0x3d4/0x9b0
> f2fs_issue_checkpoint+0x1bc/0x2c0
> f2fs_sync_fs+0x54/0x150
> f2fs_do_sync_file+0x2f8/0x814
> __f2fs_ioctl+0x1960/0x3244
> f2fs_ioctl+0x54/0xe0
> __arm64_sys_ioctl+0xa8/0xe4
> invoke_syscall+0x58/0x114
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: quota: fix to avoid warning in dquot_writeback_dquots()
    https://git.kernel.org/jaegeuk/f2fs/c/2c8ee306ad3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
