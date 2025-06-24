Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42500C7EE30
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Jun 2025 00:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QOa0HZTiv2J8EWJvq3dUWUg5PfTd64nXkdKq1aG+gjg=; b=bZJChtL2qACSd03K4EZ5zYv+1B
	HdmIwtl/3nk0XgA0ce3D8V/MtpsG0DtQt5j4LQKzfZzr+G/NW9kjrhBzAR/HTKPNtSnyOPbtPOc+W
	bfPlKtJfrYoDBKJsm2+KiKwXDglfpt9rb1N9HX0ft537moizLKcnNKLaSh7b0lLd6NHA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uTriY-0001dw-V6;
	Tue, 24 Jun 2025 00:40:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1uTriG-0001dA-UA
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Jun 2025 00:40:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KdVlMV9q7sRn9JjW4YkRQugjuqsr7nz381xw2zSqHI0=; b=TQb/VUz71dR+GN4HTlgYMl+Wf/
 lGUFmdrPmxy//cIyM60Q+7zTRlXriKU5HF1LQvF75wye0CkJqMS5GR8uEvFBnyRWjOjWlJKshP3bQ
 MKVLXiCysrBJciKtNCisPPdkcVFzn5FloX5aWuFc8vnxW2f15IRaA98mnDXd+UQxoc04=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KdVlMV9q7sRn9JjW4YkRQugjuqsr7nz381xw2zSqHI0=; b=Ppc/zNVQxE3qZzRZn/+cicEH7/
 VK4P9WhmR+YUVtAWzaaUoOWpq7AwKFN/dct8XIPT5FTBxgl2w2J5B7edaUiHdoFQ9027Skpf7WsG9
 Xn1FY1pUl9wfUSTVs8iPmBRehKgKSVhjSrgrfmM8dCBCW6/aWJc4Kj0bSwfhO65YtNNA=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uTriG-0006xs-Bu for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Jun 2025 00:40:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 96A4EA50AA8;
 Tue, 24 Jun 2025 00:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC59C4CEEA;
 Tue, 24 Jun 2025 00:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750725625;
 bh=HSdCQQWxVeeErIFv7WqAXQehp59S8Y03qaZKyPJC5qo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=PX8XEXhmPW7ftop/zlrGyZTLveBRA2KNT3sTc5BccH0hCz2cDcjCPfaJKhrNiCbqE
 agmX8X7CyECp3iIynflrqidvZSOrkM73rAoG7bcVu7i0RJtrmGHUHWlFtvMoG9OITo
 IVDUTL+cmKFjRm9x/DbKrU7C46DLUy+ZA8hTLX63wpaegzvSVeOEOtl3+vO080xkFc
 EBEZNb5Dlg4O6uF3CspZmobnlO1/kbW0u2tz2Qfd31BDoxfIFmNGRmipQz/Vswl8zx
 BTUyiV4dMZC5Axo4HglkkPDggFrthsZ1WfIdmFZkaSpUm0hIMdQNkyXaoj3+L3q913
 xbEEg9cuL0m+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 70DA539FEB7D; Tue, 24 Jun 2025 00:40:53 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <175072565225.3346761.9321054958830239968.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 00:40:52 +0000
References: <20250529222532.1088106-1-daeho43@gmail.com>
In-Reply-To: <20250529222532.1088106-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1uTriG-0006xs-Bu
Subject: Re: [f2fs-dev] [PATCH] f2fs: make sure zoned device GC to use FG_GC
 in shortage of free section
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
Cc: daehojeong@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 29 May 2025 15:25:32 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We already use FG_GC when we have free sections under
> gc_boost_zoned_gc_percent. So, let's make it consistent.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: make sure zoned device GC to use FG_GC in shortage of free section
    https://git.kernel.org/jaegeuk/f2fs/c/24bf3ee37fb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
