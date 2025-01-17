Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B43C02185
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Jan 2025 21:10:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tYtbe-0000ZP-W2;
	Fri, 17 Jan 2025 21:10:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1tYtbd-0000ZJ-Kc
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Jan 2025 21:10:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5fHOSrH5OguLb8cmFJ81KcHVyxx1hGVRD9saASxsg7E=; b=hvLqwuvfkYKF2x792Big+JlrER
 p1LCSd/HeNtdNR00Evdkd+Yx+K7bMF1Vmbo89XAoeLaf8/iHGswXyBeyqyvli311ImVIdn7ELZFm2
 nubMaxho0TXvYOCYz77S8Nq1x+RT+RRhvMktmO83urWijN/qeSrk26mOIiGXUB1qeor8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5fHOSrH5OguLb8cmFJ81KcHVyxx1hGVRD9saASxsg7E=; b=GVAAGM071xow4QyL3403TXUIDJ
 K/WrE0H1fLGBP2/X902dsFDCFeXbAB3pqdnQIq0FNQMGW+9RJ+caylm94eVnI8IgbF2oeGeSTwySc
 TJYSrkqEfhdMC1b/XXzSHkisBeM7etUDHRXTupUN2Gg4aya63Z6vAGMULzb46JmpSHAI=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tYtbd-0006mW-Nu for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Jan 2025 21:10:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 20A34A43427;
 Fri, 17 Jan 2025 21:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCDCC4CEDD;
 Fri, 17 Jan 2025 21:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737148211;
 bh=C6a6LEFV+AholhV1FPHPf9QZ/XeFsJVONzerDAAY07U=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=McqDeQWp0865xiI/3FsqnusCVnnYDRXuBykZ+wEz31husp6lLThdjbjVhAhObEgOd
 WkL1iumDEvnWHc/L5hKvkl8QnaHAgsa4NI0MfGyUgLX832zVSlLa4ue0g+74aA9oCk
 t9tmI6/Zv3+lMk/NowGgs8An6F/b2GX5iDEf04zzWt575tVlApLEndLsOMAR+hC4rM
 TdbkHwZBIB2Bw2mgGUwdV3kwFAe9X7w9PbMylHYxbLcpcdJrvDoQXCKNxAo3iINb9Z
 nIqW+RiRzvTz8/G3kXcjXiOcwjLMMlsn+ayFUwnE0dY5gd8wSpOw6qxAzETDVGlJBa
 zj7UryOBbql6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 34E17380AA62; Fri, 17 Jan 2025 21:10:36 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173714823473.2259050.10213293686484817138.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jan 2025 21:10:34 +0000
References: <20250115053943.2450661-1-yi.sun@unisoc.com>
In-Reply-To: <20250115053943.2450661-1-yi.sun@unisoc.com>
To: Yi Sun <yi.sun@unisoc.com>
X-Headers-End: 1tYtbd-0006mW-Nu
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: Optimize
 f2fs_truncate_data_blocks_range()
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
Cc: Ke.Wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, zhiguo.niu@unisoc.com,
 jaegeuk@kernel.org, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 15 Jan 2025 13:39:43 +0800 you wrote:
> Function f2fs_invalidate_blocks() can process consecutive
> blocks at a time, so f2fs_truncate_data_blocks_range() is
> optimized to use the new functionality of
> f2fs_invalidate_blocks().
> 
> Add two variables @blkstart and @blklen, @blkstart records
> the first address of the consecutive blocks, and @blkstart
> records the number of consecutive blocks.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v5] f2fs: Optimize f2fs_truncate_data_blocks_range()
    https://git.kernel.org/jaegeuk/f2fs/c/120ac1dc322f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
