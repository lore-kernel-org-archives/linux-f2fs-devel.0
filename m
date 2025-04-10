Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA40FC3601E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Apr 2025 04:10:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u2jFC-0004S0-JU;
	Thu, 10 Apr 2025 04:10:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1u2jFA-0004Rt-Hp
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Apr 2025 04:10:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GOY5tdMJAPbseT3Hk1w8rFUb6Y7rkFvxjb5g8TjYm6Y=; b=ijXm2AasLQeZaSPS5Vwqr6fO0C
 +XmpoLiSifHufpj9w3v8Umgpeypi3mVjtpsU+8PU2szl4u9a8yVZWZcjYpBxxN2Y8i8HvPb4A0sgG
 2+2X+f6M/qUoA7ggP4bHJAQvnC/hHDFtIb17OC3rDN5gchPJ5uIBUXM2HOHkqrNXBzHs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GOY5tdMJAPbseT3Hk1w8rFUb6Y7rkFvxjb5g8TjYm6Y=; b=iFh6fLkzRjRakGcNUtcnRn59uq
 NDz1m3FFhT7ktVsET73PcWsombgbPGJlxlTPIHO6bF4XgE9ECnoSNzjhmqrB+YUE3maeCJpF7HsQT
 8ZnUiYrjS/crZ+9m4MMEWIOGcKzWeBBQJaFhcDi1fI5HB41eFToU5gW4i7uOjB3LSsQE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u2jEu-0001Aa-Tj for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Apr 2025 04:10:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C35E94A3D1;
 Thu, 10 Apr 2025 04:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734B1C4CEDD;
 Thu, 10 Apr 2025 04:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744258198;
 bh=tEYKdeRfcTul1MXSng5Vi4LchF3VJtYyaCoLzaI3JlQ=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=DDx89Fo7xPntr3qDjxYlXciVCvbp6GioM+KiN9FtVMx0V6STJ1Iv9ICXlkWeteMah
 RNgnt2imnCKxAPXjCDPLCVywVy6iim7IA7IrY4krL+fG3VNnUAsoXNbYl5FuG+yLQb
 QsrUyYApr9dUkJiq6eBzLxBhprXvj1CgCPS97EV8QpnYNCzl0UIONuEWHy3EnPqjhc
 ie228EpCqVK00TCnXjNd3wTS4t4nLlrFHiQsiUWvPXNcnsFnS//g2K6fj34xstQBFI
 1HDiohBEodhYFcrB/8eNBaxAtQoqk7QxLtlkufiKfH1V7LZt1dRHT7DZsNfozmbrpE
 5Xi17LciWhFsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 30925380CEF9; Thu, 10 Apr 2025 04:10:37 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174425823600.3146257.11616360860207146898.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 04:10:36 +0000
References: <20250401035800.51504-1-chao@kernel.org>
In-Reply-To: <20250401035800.51504-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1u2jEu-0001Aa-Tj
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: support to disable linear lookup
 fallback
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, krisman@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  1 Apr 2025 11:58:00 +0800 you wrote:
> After commit 91b587ba79e1 ("f2fs: Introduce linear search for
> dentries"), f2fs forced to use linear lookup whenever a hash-based
> lookup fails on casefolded directory, it may affect performance
> for scenarios: a) create a new file w/ filename it doesn't exist
> in directory, b) lookup a file which may be removed.
> 
> This patch supports to disable linear lookup fallback, so, once there
> is a solution for commit 5c26d2f1d3f5 ("unicode: Don't special case
> ignorable code points") to fix red heart unicode issue, then we can
> set an encodeing flag to disable the fallback for performance recovery.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: support to disable linear lookup fallback
    https://git.kernel.org/jaegeuk/f2fs/c/51dc491a0855

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
