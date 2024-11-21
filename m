Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BA8D78788
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 Nov 2024 16:20:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tE9vC-0008Tu-H2;
	Thu, 21 Nov 2024 16:20:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1tE9uv-0008Tc-Kb
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 Nov 2024 16:20:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UeePUssvUouxF51V0pP0R9mPuwgqD+AQ++4ydz0LC0c=; b=Q9pb1O3XW3QhnuE1cAYIrm7el0
 rFXfrzNmxVH44ViyEsVewh+uHhu83ecBLQY49vBTr5dS77uBAnzuQZ4VOIwz5HtU/Kp1brqix3nUn
 jTbVmdbruU9nTYom8s+1kBUNP0g6bSVcy0f6buSUq12zhveoT+E8t107rjqxZLyajH+4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UeePUssvUouxF51V0pP0R9mPuwgqD+AQ++4ydz0LC0c=; b=eZVdSvRYs6HxM1qWhYHCfyD5+b
 8FsvwHzEjBlA6y4/bUD5phkSo4kEgsUQvNEd/4KcMOgt7URP6b8T32YXdGy5FcbSzviJ2tAzRm1NH
 Kt53zaroQ5KbC8QCHENhpt0cJHs9cFgF0oaPo0jbs50qMDF08LpA3X7dB+nn6PDmjiX0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tE9uv-0003P5-NC for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 Nov 2024 16:20:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8529F5C48FC
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 21 Nov 2024 16:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DD8C4CECC;
 Thu, 21 Nov 2024 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732206019;
 bh=ZDtigLTDD88X3n5JZoGpSForIA9qoDETxrOoWIGrOVU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=QUL5YxwV5iRpmQvfcXy2B2xb0Z1bdyJLHjojcBFqLr7eMW6DXxy5VHfxfG8qhpu8R
 CIRoOoTwU4N1vh+5ecyddDNItuGwN9kynPoOP27YwomjQ95Q1v+3Smydxyo1cSPg2o
 Tbi1XDu/D7RAKEGya0yPJIYuTxOj4kB9N05kXQjCsP9PR331FIMSCYm/yhxoeb6mGY
 L55VxIFt0bbDDxci4uBNNz4fizQ3DNqOVESAo3OJr5Z52MyQ5KJUwRHbW6HmM3DKD+
 oX4gUp2vjVEsv2FTKZnZGgLghvK6udzglkPSuhtqRiSqTTZ/B4a6EuPvQD/KeS1/6e
 CSswbYCqybjTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33D023809A00; Thu, 21 Nov 2024 16:20:32 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173220603104.1977996.13915931436818539295.git-patchwork-notify@kernel.org>
Date: Thu, 21 Nov 2024 16:20:31 +0000
References: <20241108012557.572782-1-chao@kernel.org>
In-Reply-To: <20241108012557.572782-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1tE9uv-0003P5-NC
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: fix to do cast in
 F2FS_{BLK_TO_BYTES, BTYES_TO_BLK} to avoid overflow
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  8 Nov 2024 09:25:54 +0800 you wrote:
> It missed to cast variable to unsigned long long type before
> bit shift, which will cause overflow, fix it.
> 
> Fixes: f7ef9b83b583 ("f2fs: introduce macros to convert bytes and blocks in f2fs")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  include/linux/f2fs_fs.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/4] f2fs: fix to do cast in F2FS_{BLK_TO_BYTES, BTYES_TO_BLK} to avoid overflow
    (no matching commit)
  - [f2fs-dev,2/4] f2fs: clean up w/ F2FS_{BLK_TO_BYTES, BTYES_TO_BLK}
    https://git.kernel.org/jaegeuk/f2fs/c/7461f3709418
  - [f2fs-dev,3/4] f2fs: fix to adjust appropriate length for fiemap
    https://git.kernel.org/jaegeuk/f2fs/c/77569f785c86
  - [f2fs-dev,4/4] f2fs: fix to requery extent which cross boundary of inquiry
    https://git.kernel.org/jaegeuk/f2fs/c/6787a8224585

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
