Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF50C25B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 11 May 2024 00:50:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s5awt-0006Rz-SK;
	Sat, 11 May 2024 00:50:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1s5awp-0006RT-Ak
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 May 2024 00:50:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bnQfjBZGSfG0C0v1eUE64KMdxHzAhgWX8+RLzmK8ZOk=; b=cPXhkw+2y2xoEw0iQ1B5ogRfmz
 3pi21c1NpwFUlTfGm44o/QDiPQ7aSP2SiKPJ6jfsHBccMnfrguXia1zzLeMIpw29LajglPtiUicHK
 8fWkTEyNY59n2NGuFlT/fLVHmz6ypRQpHbK4LuiAOu68qfY6zRJQgQ5MMTpXg5sxxXR4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bnQfjBZGSfG0C0v1eUE64KMdxHzAhgWX8+RLzmK8ZOk=; b=X7WNh/n+cF8D9WLBKPK9iJu5+o
 aqWgGmSxY4OzMjkMk6itxQj7VATLNE+ON1/35VZB+ogQ1jxmmaM21ItdhMpsaWIM9FK/nh3nAMcR6
 GdlwcmuTzc4xx4FqW6jMXA1sTMxOVv2xiAepvWqFyVyPxRkGeN3AUtjVoHg9thuPDJHo=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s5awp-0004zM-JE for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 May 2024 00:50:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 17FF4CE1F36
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 11 May 2024 00:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBE1AC4AF0A;
 Sat, 11 May 2024 00:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715388634;
 bh=BAOZth3SU5C4Yq4fzloslWpuCb5bnkV+Xuow5ptNvfs=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=UnHBiKIcNQrduUaq4FqQqop2hd+dUmvJD98PB/VHAf1LIe4GOKLfZ9w0WIM1No08B
 gntPOwQo761cVRQOGX2uUaaa2X63QXnJqh/1Oog6Z3DDb2+qqY8t7gJLsatdlzK3Bv
 IIk/hgXZQ1FvbG7LEUX1I95fepYUzJDiPP4HBxiJ+cD6UIn5BTB+ygQrJ/NWCBbA7F
 VsqiUPqeeMtRBBe39YFKpZ5XAS+jjFvnX+cYrmndWzaFgJS7p/n5MazieUsn4+2LsL
 I9TV53CXaV0RWpafig3C5tRgIf9DuzEJ7nl9AR52HhYH6WaR5hwWJLOEjPwExZdiKo
 nT1FYUKY0WH5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 DE94CC54BA4; Sat, 11 May 2024 00:50:33 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171538863390.11229.16051294251093639392.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:33 +0000
References: <20240510034333.358653-1-chao@kernel.org>
In-Reply-To: <20240510034333.358653-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1s5awp-0004zM-JE
Subject: Re: [f2fs-dev] [PATCH v2 2/3] f2fs: fix to add missing iput() in
 gc_data_segment()
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

On Fri, 10 May 2024 11:43:33 +0800 you wrote:
> During gc_data_segment(), if inode state is abnormal, it missed to call
> iput(), fix it.
> 
> Fixes: b73e52824c89 ("f2fs: reposition unlock_new_inode to prevent accessing invalid inode")
> Fixes: 9056d6489f5a ("f2fs: fix to do sanity check on inode type during garbage collection")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,2/3] f2fs: fix to add missing iput() in gc_data_segment()
    https://git.kernel.org/jaegeuk/f2fs/c/a798ff17cd2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
