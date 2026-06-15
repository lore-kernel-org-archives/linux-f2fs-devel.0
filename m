Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30E3CD98E2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pExVCIvwspvKzjd5NdI1EXcnPcRDT2OHX29XngSr8Mw=; b=iWe7NgB9EbpNu2cxGNGtuhsTtF
	3xpfETRhqO6MVOf1SWZylY53CabKAcdeGY+QKD+iqfSr/SK+W2KA9af4lPRsQtzn/ljU3Z58xth2v
	DKglewXsu0WJYaHov7Hdw4/c1mtUccNWOkCARSJ+z7wV+DmMQHLEdu+eUqbyQWkdm7TE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZ9Gg-0000UZ-9x;
	Mon, 15 Jun 2026 15:30:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wZ9GZ-0000UP-Pp
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 15:30:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sly67JVIDACKK9mO4yFHlEGb1Iz+P71O/3WvM+c64AU=; b=gPqSiLGFagWcgaaU06/VSXb7V/
 2euX5d1o9lyVaAiw+25AOiihry3RPDOGJn5JG0K+KjrX1wGHg1T/99qEH3TqdwgXc4MCsufJ5Xu0+
 6YXwztV2lWRiEV1RPkHsTqf3UTvFIL3weLd1hnw0oozjnvsxqBKV0l35Kt+AfIWwg70c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sly67JVIDACKK9mO4yFHlEGb1Iz+P71O/3WvM+c64AU=; b=WtfMpLAtamSkuO82LQZyDM3UbQ
 rdmthcNspFYiZpaVbsqStMCUdN52IILW7uxrIBZ/ENE9maLvNlcmgCNn1+b0canIQe9bm+rAZUuwt
 dn3xrQTH5QK6rDuE4rD8LO3Y+oiOtnwW5KdV/h04IXF6G55J4C0qFv53MZT9geXMlcM0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZ9GX-0002us-Tk for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 15:30:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0FCA343A68;
 Mon, 15 Jun 2026 15:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C011F000E9;
 Mon, 15 Jun 2026 15:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781537411;
 bh=sly67JVIDACKK9mO4yFHlEGb1Iz+P71O/3WvM+c64AU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=hUIbyyvZOeaFNwZsOnrK9vsov7WVM5ygEn6gZ96faQ2g4HZnLDErg1cXyCE0t1bQY
 Zyp7BtXX0BsHhGZNFoHf8vi6aTkk6TAvUtJI2LxCriD+I/ndJZ26sytuRkl4zJWnhr
 xSmSsfac1QYEP0L8/hPpy/Pto6zO96wduaE9Jt4V9GUdBEXPnsvjvj6EktVSPILr5I
 RzFEs6lyG9N55YLnPg2t8bODaREIMEFIeJ0nQSRDHNBV0+fGLoml6UNbOaQ//Fd9k2
 yQ49rZ8RMxaRROML+Dr7fNKcM39kVxfnxeWuSSz7YBCdrezPpezE+dp9sPtYdBoF0f
 Br0KGADx9GrYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 567CF3811A64; Mon, 15 Jun 2026 15:30:08 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178153740688.3946007.6158881733258476113.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 15:30:06 +0000
References: <20260522065912.1756240-1-chao@kernel.org>
In-Reply-To: <20260522065912.1756240-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wZ9GX-0002us-Tk
Subject: Re: [f2fs-dev] [PATCH 1/2] Revert: "f2fs: check in-memory block
 bitmap"
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
 linux-kernel@vger.kernel.org, william.allentx@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 22 May 2026 14:59:11 +0800 you wrote:
> Commit 355e78913c0d ("f2fs: check in-memory block bitmap") added
> a mirror for valid block bitmap, it expects to detect in-memory
> corruption, however we never got any reports from the check points
> for almost decade, let's remove the code, it can help to save
> memories.
> 
> Cc: wallentx <william.allentx@gmail.com>
> Suggested-by: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] Revert: "f2fs: check in-memory block bitmap"
    https://git.kernel.org/jaegeuk/f2fs/c/b7e85aafc96b
  - [f2fs-dev,2/2] Revert: "f2fs: check in-memory sit version bitmap"
    https://git.kernel.org/jaegeuk/f2fs/c/902d57fc5b84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
