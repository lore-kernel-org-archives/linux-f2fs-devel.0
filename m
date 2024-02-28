Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2177C54E55
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Feb 2024 22:50:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rfSlD-0000ae-Nl;
	Wed, 28 Feb 2024 22:50:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rfSlC-0000aR-Oe
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Feb 2024 22:50:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uYNWhU9rngHI2QcBSmBkF4wT+C4IA1AmuP6eskL5Jrw=; b=jRHEX7/gXz8GrqnfgbPAIj1LwJ
 ErdJxTHdkys/TGEc2jJfWUUxa1O7/MxvGVrgb/34u58llXYxVWj5iDUV8qBXTT/2c71SfLRmLASse
 UOMp2ougSEd56vQbslNrykeyQVBCJk5q3oiAk2jfADaLmwPtEVp7vkvaBercQ1GcH0j0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uYNWhU9rngHI2QcBSmBkF4wT+C4IA1AmuP6eskL5Jrw=; b=PLFv9Rf5K0NkdqgrywyGb8VMIu
 vJRr6e7qUcJDRz+FtuRTjh6kYAxhWeH43hcFZ2vAmP+5hU3LEetUnXShc7C64LrBvOJMcbHXNqEhj
 JtpyuW3Y5h8Uc5oMgnAX9sRWFcNo9YqfX5ypi1t4var+4lvCgSkhMRzSie5TYeEMc01k=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rfSl8-0001hf-M4 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Feb 2024 22:50:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 46DF661959
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Feb 2024 22:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7DEFC433F1;
 Wed, 28 Feb 2024 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709160631;
 bh=3Fd60MS/Vmnzo7x8IrSs/bDLfdZm3IDdQANbO/8Z0Lk=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=CtgZ12LccI/s+ShYcVRT3viuEpG/gy0XmcIlCDJG3TpnTHXXObh/Snre3FhGlhxiL
 SRFHCIE4vSRcGzyyw2agfXIurbMxVXXb9Hsfe6BaS1fZe/EWa44l7goiOFmjZsqO4j
 h0uVK0xQQheqr4x0DIqBuSAkucUwbb2RTKNgBogwjIrRAUcgzAenv4eqY0rdYnb5R3
 DsSM+vEh/0/6GPvzGCJFjy/umVgF3qHq5xkQP6cNh8rgqFC+9Xe8IhWpX1Y8yTKI6x
 LhVu8dOQnSTryLiF2IjR5cbUAACMjxcKZJZDf8HMkHO+Zm14YcNMdRIO08bkqcZSCf
 iaHRCcTyFf02w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 81E8ED990A7; Wed, 28 Feb 2024 22:50:31 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170916063152.28690.2631252489299295101.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 22:50:31 +0000
References: <20240219022844.3461390-1-chao@kernel.org>
In-Reply-To: <20240219022844.3461390-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1rfSl8-0001hf-M4
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: fix to check compress flag
 w/ .i_sem lock
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

On Mon, 19 Feb 2024 10:28:44 +0800 you wrote:
> It needs to check compress flag w/ .i_sem lock, otherwise, compressed
> inode may be disabled after the check condition, it's not needed to
> set compress option on non-compress inode.
> 
> Fixes: e1e8debec656 ("f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: compress: fix to check compress flag w/ .i_sem lock
    https://git.kernel.org/jaegeuk/f2fs/c/7493c07e31d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
