Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADBBCD98E3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gkTb/VgQHJmCZTh5YG+SifBn84xSPS9ev6ZDmSUZq7o=; b=jrqx3Dvs361q/UlsGbEXQPXt5p
	oZa0FjmKmpca6ko4/4aeEIZ3nQ4W6LhhDq0c7lK1SJ/1p7IT+uF6dxNOD6936Eo8zWlH7eimE5NWe
	LZqGYSa0Aug2Yy7CDQKm7GCl6MCKKjcjp5QqN5mVzkKIVwpO9UE/00anqpa5TyUyYaSc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZJst-0004kI-Q0;
	Tue, 16 Jun 2026 02:50:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wZJss-0004jy-Ds
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 02:50:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=63DdxPTDlTIureSVrL3BjD/esMCviS3qv/hBCNWc70g=; b=nFlvcZM6Uz894kySqM25iGNpkp
 7CAwNVkQ/qEFYlZvR1AKSfCBHWk22FEkmbEhpVHPwkiTDL188c7yWq4FdGAMEmstrJrvuWAVQEyi4
 +xwk/bz1zkuaNyssMy4V/LePz9eJ+hbHNz5s1tVUs7S8FLJ68cwpWO7pASL07XxX4d/U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=63DdxPTDlTIureSVrL3BjD/esMCviS3qv/hBCNWc70g=; b=aVGn3Bpy8yQNeRpY1nPtg0h5g+
 7V4aQo5xqL+q/MD4BZsk0bFt+kjUUfhs2bbyhFwvXB4R27xZr0cgqg9eafvmn2BiIAu9TPSHjHogT
 +Dhmp6tqYDCIAMb5iIDu7l2+m11VLwxaSwe7sTviu84f40lw7WaBUM2P5v/rG3fWtUrI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZJse-0008Ph-C9 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 02:50:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8DA12408A4;
 Tue, 16 Jun 2026 02:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D011F000E9;
 Tue, 16 Jun 2026 02:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781578214;
 bh=63DdxPTDlTIureSVrL3BjD/esMCviS3qv/hBCNWc70g=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=TsHMoFwFEVMc1iWPRhHFT+27/6mMwBQN4rXgaqYBDa5f+VaIk993UN/J8cyrbAH4z
 D19xYJ4P6crGh6zKYODVuiHtNViBtoOpxw65ON2tB30Rb1ycn6HzVPxhcE9UFlNcT6
 dnbWA9Amx9UaD/J+1aZb3T7ykZE7WTi+D8lcBgBgkWZJLYqtimevDrISEfqYqoOuEi
 dufyw5/f6MzUm2s7B0LELI+dJJokt7chzp6f39ZEow/iB/7JqxS7aRxvcU8FueXrTr
 gGieRoEet2KuN7S+yovg2tyVDuG8May5oLGmOQeVvS9wavx7Y1FMpiKr1YeZ9T/tTJ
 dhSB8eXgwOZsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 939803839A26; Tue, 16 Jun 2026 02:50:10 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178157820913.407856.10230578246013477605.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 02:50:09 +0000
References: <20260611-b4-disp-155e8807-v1-1-5d14dcc72b15@proton.me>
In-Reply-To: <20260611-b4-disp-155e8807-v1-1-5d14dcc72b15@proton.me>
To: Bryam Vargas <hexlabsecurity@proton.me>
X-Headers-End: 1wZJse-0008Ph-C9
Subject: Re: [f2fs-dev] [PATCH] f2fs: bound i_inline_xattr_size for
 non-inline-xattr inodes
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
Cc: devnull+hexlabsecurity.proton.me@kernel.org, jaegeuk@kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 11 Jun 2026 23:00:36 -0500 you wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> When the flexible_inline_xattr feature is enabled, do_read_inode() loads
> the on-disk i_inline_xattr_size unconditionally:
> 
> 	if (f2fs_sb_has_flexible_inline_xattr(sbi))
> 		fi->i_inline_xattr_size = le16_to_cpu(ri->i_inline_xattr_size);
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: bound i_inline_xattr_size for non-inline-xattr inodes
    https://git.kernel.org/jaegeuk/f2fs/c/ca29fc0196bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
