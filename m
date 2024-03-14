Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A94C54E5D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 14 Mar 2024 16:20:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rknp2-0002qf-Tx;
	Thu, 14 Mar 2024 16:20:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rknp2-0002qZ-CY
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 14 Mar 2024 16:20:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YfF+tAL/p+thewa7FFaMIgSeQKQ3b/CR7sKOD0k1WPk=; b=UzFL9xW/XRJDvfYI6Q+QRuQXyO
 RAjJNzU3kTJIN//XWcSZBrBlFTTS3FJQVpINxulHtpUakX26qJnZjfKiNhKlZIB9V/9pZtqDEJkNY
 FMIN4+v2HFyXFOVqEEX0SITX4EKe7jtgQS2Tat/XwkfU1IK1JO5qmOkWHqbFOk8HeAUc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YfF+tAL/p+thewa7FFaMIgSeQKQ3b/CR7sKOD0k1WPk=; b=QldB8CwoTRVQJwHZl4uSvyOn/r
 DAfhDtx0m3Bx5Q2Es43rNkRusb5RW7AX7Xn00MqUDXoHMRA/ZrIInzezAe6RAB0P+1fetVfk5xQi8
 8PerOHUnEcyU7XcJLti0lXB1H0az2ZNyWEy54fbO6hHLNRwEWx9q5TCn5QFqtQO55mPo=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rknor-0001sZ-QK for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 14 Mar 2024 16:20:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 2F4CFCE1DD0;
 Thu, 14 Mar 2024 16:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 691D8C433C7;
 Thu, 14 Mar 2024 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710433231;
 bh=7+09w1oE97rDTiXYwrzXL4LqGid17J4YBQSF+zZK/30=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=q2h/Tn7SJ1Z6TURl9ZfaYEeCvSR+2ZpQbTUHRgzIzNga9f8h2nfOqcGVKrI53z7iP
 1ZrbkD1XirVCgitqPQNlCIpPPRFc78wiqhBKw9BTu0ux/l5f6NofvdBXhkkESHVtXu
 c4A2nCRMxw59HtDxHNC64kbktzV4c3fvSq/upv2E8CvawZwiryVUbls0FakW/GZqLr
 lcv3+afq/QQun/4s7hyVjlZrk+adq0zE3T/C452+nxzHVyVe0RQpPfIDhCbmaXAeJH
 fY8tzQIWxMMExfNzoD07Y/peL59SgjRH3xhjaWXPLNBcXiHA78a6FmkJJjfy76kxPc
 BfQPOoPiwNAFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 57438C595C3; Thu, 14 Mar 2024 16:20:31 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171043323135.13516.13152557202790425298.git-patchwork-notify@kernel.org>
Date: Thu, 14 Mar 2024 16:20:31 +0000
References: <20240313112620.1061463-1-s_min.jeong@samsung.com>
In-Reply-To: <20240313112620.1061463-1-s_min.jeong@samsung.com>
To: Sunmin Jeong <s_min.jeong@samsung.com>
X-Headers-End: 1rknor-0001sZ-QK
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: mark inode dirty for
 FI_ATOMIC_COMMITTED flag
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
Cc: daehojeong@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
 sj1557.seo@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 13 Mar 2024 20:26:19 +0900 you wrote:
> In f2fs_update_inode, i_size of the atomic file isn't updated until
> FI_ATOMIC_COMMITTED flag is set. When committing atomic write right
> after the writeback of the inode, i_size of the raw inode will not be
> updated. It can cause the atomicity corruption due to a mismatch between
> old file size and new data.
> 
> To prevent the problem, let's mark inode dirty for FI_ATOMIC_COMMITTED
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: mark inode dirty for FI_ATOMIC_COMMITTED flag
    https://git.kernel.org/jaegeuk/f2fs/c/4bf78322346f
  - [f2fs-dev,2/2] f2fs: truncate page cache before clearing flags when aborting atomic write
    https://git.kernel.org/jaegeuk/f2fs/c/74b0ebcbdde4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
