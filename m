Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93866CC6B15
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sDF61HZsQmM/p3/N23aRDdnyj+ZkKeYvt/kEMTJyPOs=; b=kQeCukSm9vvJ85rFFTtxSlHNz1
	AiCxbt5SoAodPBmv5Cm/fjgBAByHU/gwnGUwB3kdLf2NVXk8D87U9YMSgLL8h3ZzfYBaoiZJvQUYG
	5f5BpcwHU2WmtfOryTnBrpO02rxQKozRFlYu3GprZtUa49Lzn3lE4fBpJly1/7KVKyyc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGl11-00022s-1x;
	Tue, 13 Oct 2026 22:30:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xGl0q-00022U-Qz
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rj5wkGy6yTPAnHR68+j6OFWHSh6FtU7k2/bCjqeMRz8=; b=DrEEYnQRotkHl5RtLoxB7QmNQg
 rDM9w+pWhdkCL+GDAoF2TMFD42PkubD1YcUPz6ELxh/odc9XSWLBdBtgB8gidWizyTPY1DiMBtdgg
 2lgg4aE2NfpitCfVGn41rCIqQ+zWOBcj6QORkFMlLR2TeSCw0CGJLeRjGR2Lt4zYdLtA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rj5wkGy6yTPAnHR68+j6OFWHSh6FtU7k2/bCjqeMRz8=; b=Z25Z4C6UJJOqzhDHKXFuuYbK4S
 +utsvMh4m93og5SNxMnIaLo+v5QcmE2cxh+428g1LJ5kcm9rstIh6/MSwRI0VLhxZdmsJnioQAUgR
 254WzD5nSmIaxf0cEx0m2bjx/AxudD2edTEHW51ijXJMw0IjFb4xfdMtp4JmTGah4zIs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGl0m-0001cy-Vi for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6B3DB60235
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 22:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220CE1F00893;
 Tue, 13 Oct 2026 22:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791930615;
 bh=rj5wkGy6yTPAnHR68+j6OFWHSh6FtU7k2/bCjqeMRz8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=kWXBrKjtvxhi6YY0IvpdN2nyb9wWIQjsnphueYp2DK3ZPiFt52kCoC92WSV1S1bA6
 AzOnT0IBF9ADyvM7kbQpOG7Xm+MGZiWNdrBY9tKykPgwu4h4SZ2Y/uHOGnK3vxjTct
 KC77zu+quIJrzFPsQQgycLynqqsRLzMSNr3Q0N6PuVwcaYyhGDRaCL3U9ZJFSfmGwx
 NTyNuVY1Ya6ZKPHgX74F964bfbr+9N0etuMxRUgzwOWvc6ixT8Ci69yn/c2uBAaGin
 4RMMfLAVA2R45Qy3uDxhhlzyQ4ieOV+gQuCYFPn+q0R7T4G6EDeVush4aEfroF4s2B
 UVZy/GagqbrwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 183F639E4DBA; Tue, 13 Oct 2026 22:30:15 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179193061376.1493834.1008667944485140463.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:13 +0000
References: <20260930235435.3789910-1-chao@kernel.org>
In-Reply-To: <20260930235435.3789910-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1xGl0m-0001cy-Vi
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: cache: pin cached block in
 f2fs_end_cache_writeback()
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

On Wed, 30 Sep 2026 23:54:34 +0000 you wrote:
> From: Chao Yu <chao@kernel.org>
> 
> Like page cache folios, writeback does not hold an active reference on
> the cached block during I/O flight, relying instead on truncation or
> shrinker callers to wait on F2FS_BLOCK_WRITEBACK before releasing the entry.
> 
> However, in f2fs_end_cache_writeback(), clear_and_wake_up_bit() executes
> two distinct steps:
> 1. clear_bit_unlock(F2FS_BLOCK_WRITEBACK, &entry->state): clears the bit.
> 2. wake_up_bit(&entry->state, F2FS_BLOCK_WRITEBACK): hashes &entry->state
>    to look up the waitqueue and wakes waiting tasks.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: cache: pin cached block in f2fs_end_cache_writeback()
    https://git.kernel.org/jaegeuk/f2fs/c/6e392158cf54
  - [f2fs-dev,2/2] f2fs: cache: pin cached block in f2fs_unlock_cache()
    https://git.kernel.org/jaegeuk/f2fs/c/61ba87b33e87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
