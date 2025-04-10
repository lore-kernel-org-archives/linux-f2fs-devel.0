Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA12C3601E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Apr 2025 04:10:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u2jF8-0003cc-00;
	Thu, 10 Apr 2025 04:10:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1u2jF7-0003cH-95
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Apr 2025 04:10:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pMcN2wjBwpxaYaX2kAGSg2MonrUtDCWPuEzBOzSiMmY=; b=AnBPA3heG+Sgu40PMX7iaIHt5n
 2QoY6WuzsnnBccgkYv68SjQEZiugCW9wgXRKjCyIjbJ835ZeJDwBXubJG5K3tX73vNDxaeHZX+3ss
 TCVCPch1qg/+PJ4tZPoZ+lU/uJnOM5MjyQ1luLwJLwZ7566IOldoa/exEXXuxz86VDfg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pMcN2wjBwpxaYaX2kAGSg2MonrUtDCWPuEzBOzSiMmY=; b=imPPE3TxsKBVc06cIrFQYpNEYd
 /3yLhgyuul1xlcLtPAR0ieinYzDfinQzAx+XUa0JZOHJh1R1y6o5UPHfF/s8s5w43Gj4x61iddOTL
 Zw7ot9ycuQoZLeNGGDK69jIzMb6szOyycgOQvzcFkejn8H4BG4qTEn2fcvRMYS9HL69M=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u2jEs-0001AB-3R for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Apr 2025 04:10:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A7286115F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 10 Apr 2025 04:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0375BC4AF0B;
 Thu, 10 Apr 2025 04:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744258200;
 bh=T+U+qmU+ht71n/z0NiUcLMkLIvyNxHhppQD+pF/QSVo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=k/BG67wmdggqTbf4xJ4EiTiDWcTqjazHgrXRmqPzf/U1ct1DrCUiUYJwVgygxB9S9
 xxSLG7SJKOzTWm6UkZEWQSkG7jnJY5VzhpJd5k+H00fRbGG7I+ySzjzm4wcYDDIC8C
 KztsSZA9LmhTkzO0EOqDKL0D2Wa2qC5tA3KsqNGw61efdeOcG26RqC+wEa3DIWgHlM
 23Kjum0TBm66gkfu7qSLcRkqqu9gBQsjuZIpEDSBZSVraGbIPIpt+b3hyg95NXmhck
 CI1b5o9iou7Jbagwptc7eF/sLVZmLa3ITG+JIJP9eTNLN4F10kQOVLY9Ag94P2pBjU
 AuzWnxoS0WzjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 ADE0A380CEF9; Thu, 10 Apr 2025 04:10:38 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174425823723.3146257.13694783010566710853.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 04:10:37 +0000
References: <20250325081321.3296714-1-chao@kernel.org>
In-Reply-To: <20250325081321.3296714-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1u2jEs-0001AB-3R
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add a fast path in
 finish_preallocate_blocks()
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

On Tue, 25 Mar 2025 16:13:21 +0800 you wrote:
> This patch uses i_sem to protect access/update on f2fs_inode_info.flag
> in finish_preallocate_blocks(), it avoids grabbing inode_lock() in
> each open().
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - get rid of read lock during querying FI_OPENED_FILE once we held
> inode lock.
>  fs/f2fs/file.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: add a fast path in finish_preallocate_blocks()
    https://git.kernel.org/jaegeuk/f2fs/c/ecf68ffee7be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
