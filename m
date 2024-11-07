Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA95D5D68A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 Nov 2024 20:30:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t999M-0000DP-Ja;
	Thu, 07 Nov 2024 20:30:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1t999L-0000DH-TR
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 Nov 2024 20:30:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yjwakgd+tMOE9EJbmyPQOq/Fs9qWbks+VaetIzYQoQY=; b=WLiNCNKLZE3Mhc8v8B2sHemI+2
 whv3daRiB1B2X/brZ3oWGB1ILIXTKH8DvZfSv9ecbdefepRAWzGerW2an8/NSROidzsPBM3ZSzVeA
 pXvH/wdByEukvH6Ejk8f2Kf18fHmsiodJhOtDdWwniw1D20TbT4vaBum4s2vS0vpm4lo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yjwakgd+tMOE9EJbmyPQOq/Fs9qWbks+VaetIzYQoQY=; b=jNVzL+5T9HaqVayT6slaXr6UZo
 kWa1w+nSHXOvh4b76Pr8xXJSrTxNUrEV3UolWxE6iFemdae5JfHJhsLqkbFHxFgMNuCM+yH1Dv2ib
 kj1XiD2ybYk2NW3bW3CvyYnalUcQwM7nY+dZlH/6gX2N7i71hL6UbVxpgRhsXfezXHuU=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t999K-0003tl-Pg for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 Nov 2024 20:30:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 5248BA44AE0;
 Thu,  7 Nov 2024 20:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCA6C4CED4;
 Thu,  7 Nov 2024 20:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1731011432;
 bh=xEvgzfMCXK4MGPVSxFiRyAR8pYmis6wmboUMDxUIL44=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=q6U5i98NdBfp1ExymiB7UqlO/79xEnGtFcz/n6U7n0f2dXzmEQ1OikjHIXo66atR3
 t1+RO9lNbfXv7gQK0SI6eAXpPFGPWP+u1e+kDfQOHs0JD7gOZBW8UK+wD1miurPYqy
 6PacAqiMj/KbS2tff2ELE8p7sIqO+4AO61KmcX26Gjr/FU3wgU0hQ+dxOzbzOgqGzM
 OEyEFHl+ut5lnG+WmrTw7RmdRRPrm0kMdYFZnECxaSjX99sHtDRek9JZHj424n8phI
 Sgyfv3OY4RJPMZ6KygZ4ij1MjfajZ6Sw0bsXUuwrabiRrVXliqWbjHfCmmkG4biVnd
 A1TBpyMtbXg0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 344053809A80; Thu,  7 Nov 2024 20:30:43 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173101144199.2084993.6672876155571562205.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 20:30:41 +0000
References: <20241029061535.2676673-1-xiuhong.wang@unisoc.com>
In-Reply-To: <20241029061535.2676673-1-xiuhong.wang@unisoc.com>
To: Xiuhong Wang <xiuhong.wang@unisoc.com>
X-Headers-End: 1t999K-0003tl-Pg
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix fiemap failure issue when page
 size is 16KB
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, xiuhong.wang.cn@gmail.com,
 jaegeuk@kernel.org, hao_hao.wang@unisoc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 29 Oct 2024 14:15:35 +0800 you wrote:
> After enable 16K page size, an infinite loop may occur in
> fiemap (fm_length=UINT64_MAX) on a file, such as the 16KB
> scratch.img during the remount operation in Android.
> 
> The condition for whether fiemap continues to map is to check
> whether the number of bytes corresponding to the next map.m_lblk
> exceeds blks_to_bytes(inode,max_inode_blocks(inode)) if there are HOLE.
> The latter does not take into account the maximum size of a file with 16KB
> page size, so the loop cannot be jumped out.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix fiemap failure issue when page size is 16KB
    https://git.kernel.org/jaegeuk/f2fs/c/a7a7c1d423a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
