Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB73CF6BE2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jan 2026 03:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sf+iKhDQDM2DnZM+1VIwU4Jfh3YV63kgeKUa3Gb2emg=; b=AChTiAPklG50kvynaAYyKMtkuY
	kN579orkyx2iRsFQqQ/um2Kjpv6uN5tlFVLWoyhyg3Y1b05r33JDGb0VISuMbMC4zMSfTnHt+DPRo
	w9deXJjQG4zcq/vE/JR3ZVDpnbqXyrMMKup5XgsC56bLY/D1NPoXc8h4dWDQZ5HbRoV8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vdKJ0-0001eW-I7;
	Wed, 07 Jan 2026 03:33:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vdKIz-0001eL-65
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jan 2026 03:33:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t7V7W/64OiaD+bY9szCFCDL0se09gP8rGP0c8iUAYQY=; b=KkC8bxSlM4bbF0D+ul3Mcr+HEV
 L3ZJRc1uVzBJzXR5r4zu93GBPFcyVpdKBxuQS/5YaVGGTuAu7kPBsnxTc6B2jxMgbbzoajR/X4IJE
 r06WoJd445aQ0afO8ZwV4IrG9pph4AC6ilycF/yQy02zbf24gSiseLVbPiSdjvRhR6G0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t7V7W/64OiaD+bY9szCFCDL0se09gP8rGP0c8iUAYQY=; b=k1BrZlvQqvkQLgwo4Kz93uGh5r
 3aUdyjKfOfq5qnhY/YMpxHzbPyDsy3XLdsbo2g7tLPIEJzAWraFtyYEmeELjOdsUP2nW9lTCvDdD8
 xVhUtfdU/FoDmXvSfWPkDcUvXiCUoJgM0jCfL0XSiqT5jVc+uIG74g8X93NtWxKzWXiA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vdKIy-0004YU-OR for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jan 2026 03:33:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7458F443A4;
 Wed,  7 Jan 2026 03:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535C2C4CEF7;
 Wed,  7 Jan 2026 03:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767756822;
 bh=/QOI9bL5NNjdrOAxYYc4ASxk6UAbxTdtppcFpe98WQU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=X58gOhOLQ5rV3NRM0fROydp/WHZUEy5y8Ywy2SNfsQjy70lkXtIKWk5Unilu6i6Rw
 Rb36Rm9wTDjMR64AkGluoqsWVAhHZxARwjJXaMlRpWiGljmbOTNkAvgHH63iQgNTJq
 p6P2GZh7T4ibmnU1iLIRoB0dYeP3CTzQa5HuC61EzncmF2L/oVYxZ3H59CxVHGjYHZ
 Tvxfh2y9zY6wH2GbHtfrKaPC9RZfcdak7DXw2BECQEHVZI8KAnCGzD/1EKTvP6IUd9
 AC1F9iplEIe32y6xXIom9zMqAMki0wGnOKnTw7FiglekrM5ZChUx83wPpv9E89C5Pp
 gKksUyVdtOvPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 F2910380CEF5; Wed,  7 Jan 2026 03:30:20 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176775661953.2218650.2344944706146017885.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 03:30:19 +0000
References: <20251227091906.216322-2-yangyongpeng.storage@gmail.com>
In-Reply-To: <20251227091906.216322-2-yangyongpeng.storage@gmail.com>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
X-Headers-End: 1vdKIy-0004YU-OR
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: clean up the force parameter in
 __submit_merged_write_cond()
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
Cc: jaegeuk@kernel.org, yangyongpeng.storage@outlook.com,
 yangyongpeng@xiaomi.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat, 27 Dec 2025 17:19:06 +0800 you wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> The force parameter in __submit_merged_write_cond is redundant, where
> `force == true` implies `inode == NULL && folio == NULL && ino == 0` is
> true, and `force == false` implies `inode != NULL || folio != NULL ||
> ino != 0` is true. Thus, this patch replaces the force parameter with
> a stack variable force.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/2] f2fs: clean up the force parameter in __submit_merged_write_cond()
    https://git.kernel.org/jaegeuk/f2fs/c/86c1cf0578c5
  - [f2fs-dev,v2,2/2] f2fs: return immediately after submitting the specified folio in __submit_merged_write_cond
    https://git.kernel.org/jaegeuk/f2fs/c/db1a8a7813f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
