Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014A9C3ABB2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Sep 2024 21:30:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sqJJ4-0006wU-7n;
	Mon, 16 Sep 2024 21:30:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sqJJ2-0006wG-3Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Sep 2024 21:30:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lbeRpiq3DxF3Exz/E5Db3BjKuRBbbIguUD0bazMc/6o=; b=cx0DQ8XGt6nT3XZfNkQMgkjYkm
 cZKtX7QWoFpOVdzNXNoWcAMv7Wlmt73QJLdJp4zEFtOfPGU4OFVwU8SFGFHABfZ/LiGppmhSQqglj
 lDl8uXZhRdSOK+zJu/yOWtYL93dQCETUzSMFubFSFV8PJSWJ+mXbxsGndgbeQGG9PYtU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lbeRpiq3DxF3Exz/E5Db3BjKuRBbbIguUD0bazMc/6o=; b=jsdpX76m6jOdeNl/ineFz/tMo6
 mFeIoltMk7rTc22oHrZYgALgDQBiDjCFTPfDlIJAqTdq3krlcwG/6EPIVm+sPzOqmhC//gbFOJDHQ
 2Qdj1tv5m20r2Kd7enMxUHIGXu0ksdDrLeIbYl6PyKSLIutvLikX7qXlRhs364IHCmrs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sqJJ0-0000Of-VY for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Sep 2024 21:30:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 039F55C0582;
 Mon, 16 Sep 2024 21:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CE7C4CEC4;
 Mon, 16 Sep 2024 21:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726522240;
 bh=3NTGL5Cin2LOXypSVr1CXsAKRF3Z9wMPuJj538dnpCc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=D/M6sjY1jAkPWst5/YqvqJwSg1grIKHAkQeFCo26GQN5pFtYqu/83QpJcea42Rnno
 SR7IhpIPz5N/rjNkv7xls+GmU3b8hogs7iSDbD7OO4e9T9SEJvBllvwxca3OTrZ9Z8
 YFQaEKtZMalJc6LR5gdJ0JBUxyo36ACB/nVtSYPp1ADNmgKL03PpInihfoI6Lf6ctK
 ZafwtpF3r2qy4J1uiUPkbYPT81ReETqliaCJSICJbpJtSYP91RteszDWmnBpH8QeCm
 1D5PxAncF1nZ7izjZwuFJVx5t6Cvtni6sPyugrkDtrdrl84yiXd80QffH73fZgJCJV
 JPol7If1CbdBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33F933806644; Mon, 16 Sep 2024 21:30:43 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <172652224174.3820990.5790897572991749927.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 21:30:41 +0000
References: <20240905052433epcms2p1dac78dff43776cc158bac5ae9d118160@epcms2p1>
In-Reply-To: <20240905052433epcms2p1dac78dff43776cc158bac5ae9d118160@epcms2p1>
To: Daejun Park <daejun7.park@samsung.com>
X-Headers-End: 1sqJJ0-0000Of-VY
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid unused block when dio write
 in LFS mode
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
Cc: nayeoni.kim@samsung.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, siu.jung@samsung.com,
 sukka.kim@samsung.com, jaegeuk@kernel.org, dongjin_.kim@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 05 Sep 2024 14:24:33 +0900 you wrote:
> This patch addresses the problem that when using LFS mode, unused blocks
> may occur in f2fs_map_blocks() during block allocation for dio writes.
> 
> If a new section is allocated during block allocation, it will not be
> included in the map struct by map_is_mergeable() if the LBA of the
> allocated block is not contiguous. However, the block already allocated
> in this process will remain unused due to the LFS mode.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: avoid unused block when dio write in LFS mode
    https://git.kernel.org/jaegeuk/f2fs/c/0638a3197c19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
