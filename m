Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02ECFCA5FCB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DOQk0x9ABVkjCKtoGncQIiEUqBP7h6gV7dHArlAmloE=; b=GPuLkZtrd83galwMCqfxt+7Bf1
	sMRdLdF59KEZHUo5pS//vP5HZ58xEThrA+CrSl7eN/WnI8Y27qg4TWvsSOCdhAbh07IaYFP1CQ2H7
	JyplD8M0gHGTMjc2RUOOSZymMzaaGkKr2Urrb/Mffia9QavO1GdD0ta+Ow/jNbBTmsG4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xBxyl-0006rN-1f;
	Wed, 30 Sep 2026 17:20:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xBxyZ-0006q6-TQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 17:20:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tuVOnxNWCgPPQeO5g01VIr/PzkqI2Sr+czEJMlodnZg=; b=Bn4QmTIKvL137IA39UdzOteZu/
 qWodgh2onC2okdXvYRTVc/ItT6w3PvEk5z9JQnwrNyxnqghygzKwpPdqMwd/MhFH+ACjrY+bI7Ie9
 c2RQ1Cq1R3MbFIyAIwSXjEqXHESc0IVpsoL3Is/rUTz2weVpEndMN/Gmr6jpJJkC2yz4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tuVOnxNWCgPPQeO5g01VIr/PzkqI2Sr+czEJMlodnZg=; b=DvoayDDCRBsO/VcqNYQSZbfoD1
 vJr8Zv5+2mpBPM0AB+vFaQt+P5Wm7a8BXQe+JIthidXR9+oTqtWEynOVn2uIuhtCsne1NQ5GCKgff
 2I49Rj4VilabSR2Z5AkQc0HSQLaJuakj7azEJuF9S8+I9sxwsqU0kGsoUtXWWuI4zYA0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xBxyX-0002XW-MB for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 17:20:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6267C43685;
 Wed, 30 Sep 2026 17:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F4F1F00898;
 Wed, 30 Sep 2026 17:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790788808;
 bh=tuVOnxNWCgPPQeO5g01VIr/PzkqI2Sr+czEJMlodnZg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=JEHQ4Pl16XgadK8EliWwRtgnSpzQOnB+YQmtbYd2E5feJmujXQQrlO5aj8AaYcbJe
 T0h75ZYuUY7QEwMTXGGsxzdIu4ToNJVCjS8A5DekzvpdtCF0hoN19NfmPmgrk+6BE9
 tZ/9zxhJU2N0NhgEB2mC/qqhiE8CL0CD3B1MdKVHsFqy1WPweDJIaJa66KU6kSsZUs
 TSWuvZjKcmxRC8O5PXiNClOT9Q5FtfTXKZdzoMU8Jrk31AVVwCPC/uvacB94DCoyA7
 69TlJgFF1+2H39mo520QV/Qjq987C1wduBbaoR7XN4sGBp1LnT5+Abu638d9d5y6vn
 ZwPa2WvJgBqrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3A36F3A566F2; Wed, 30 Sep 2026 17:20:08 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179078880677.2027760.7016145024100060677.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 17:20:06 +0000
References: <20260917142222.1591270-1-arnd@kernel.org>
In-Reply-To: <20260917142222.1591270-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
X-Headers-End: 1xBxyX-0002XW-MB
Subject: Re: [f2fs-dev] [PATCH] f2fs: quota: fix unused-label warning
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
Cc: zhangxp1998@gmail.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
 jnhuang95@gmail.com, ebiggers@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, daehojeong@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 17 Sep 2026 16:21:42 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added label causes a warning when QUOTA is turned off:
> 
> fs/f2fs/super.c: In function '__f2fs_remount':
> fs/f2fs/super.c:3142:1: error: label 'restore_holder' defined but not used [-Werror=unused-label]
>  3142 | restore_holder:
>       | ^~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: quota: fix unused-label warning
    https://git.kernel.org/jaegeuk/f2fs/c/4faeea625cf7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
