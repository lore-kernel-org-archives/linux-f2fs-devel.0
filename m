Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5194D78789
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 Nov 2024 16:20:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tE9vC-0003Uo-H2;
	Thu, 21 Nov 2024 16:20:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1tE9ux-0003UH-CR
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 Nov 2024 16:20:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k+vAnvNPjHShlSZb4qEK1REfyLy0P+ZN/blQuUf2YTo=; b=cs1FtCv+vPp+sI6SfCEAwR0Ozq
 iEP1XI3YSe8+vZP1LPABjd9+QHOvE785Z+jWkDXTFCI446OmRGeQsHghVKim0XyIGDKrKT3Dmmbtr
 CSn0Gleuf0oC1KJ64bmllt6dOCyLZ7CcGFmtIQ1/EwnBgSMGbyn85SdPUcAxDhQ+rmRU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k+vAnvNPjHShlSZb4qEK1REfyLy0P+ZN/blQuUf2YTo=; b=YiutWnVURhVUgiUMt3JUHwOyC5
 tBQjLoBVotfJqnNygiHWM+/7T35Hs+wVbKE8UGpMFNsEJOIiCF62i+GxyqFrBUEyW60lpJ4CzdGTo
 fDFhJwe42eYXhFe76mHggAdjqbpsOyk8NpCcWC6EHcFsT2eEmQJJplliPYAB96APq+IQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tE9uw-0003PC-Oi for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 21 Nov 2024 16:20:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 904955C5791;
 Thu, 21 Nov 2024 16:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22791C4CECC;
 Thu, 21 Nov 2024 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732206025;
 bh=OtjUEKdxpPtkGjUDo800ZhZe3Tku9TR+aClhix3hrJs=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=SfQcmagy+q9aQRJ5UO8QJ4nWbWUbXxdk/lfVWUjp+LvtAlJkFpQLgwkOisWPhy90I
 ilmQC4UDmszmh+6whecmLfpwJsMC1Nk/d4Q9qxmwvuypl5BuVPHVYjofXFMUXPJlni
 zWJOG56thbBGoOXuWFjr8Lw3mSwA9MexM0Eg5TxGYGC+Y/AuRL8Zo2OQS7ZcvUB+Qj
 e4/jsX9K9hErGneoCSKkh6hSoyQD1fA5nSHGzGNSzHTHJnWEMgTe69ORCRPAC7CA1V
 1WRIcAOU5RmRZgU6utiNOaFvV+cWxhkeSPJaIZw2+PRXl8w2qwp3U9aYXVvRJ/36y8
 9rfrLNLI4M0yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 387A13809A00; Thu, 21 Nov 2024 16:20:38 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173220603673.1977996.6285355196321029401.git-patchwork-notify@kernel.org>
Date: Thu, 21 Nov 2024 16:20:36 +0000
References: <20241118184535.1047327-1-daeho43@gmail.com>
In-Reply-To: <20241118184535.1047327-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1tE9uw-0003PC-Oi
Subject: Re: [f2fs-dev] [PATCH] f2fs: adjust unusable cap before
 checkpoint=disable mode
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

On Mon, 18 Nov 2024 10:45:35 -0800 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> The unusable cap value must be adjusted before checking whether
> checkpoint=disable is feasible.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: adjust unusable cap before checkpoint=disable mode
    https://git.kernel.org/jaegeuk/f2fs/c/a35749b1ed64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
