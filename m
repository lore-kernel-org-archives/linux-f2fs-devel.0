Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D27C982FE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yx6I/egWyQnjoQZR7rB8HyRsFP3l1wjgkJ4XauxJBEk=; b=M1+ZOedLekar72DRlROJp3tNKC
	ep3KeVNdaPbekW75rP9tIsXP/EjsN+FQXqkYBo2jS0YbenaAPwK1QUfL7zmWi4oau8T5bVp3M/ZhM
	iwxbUFJCVY8Bt2d3n4DxYmjHsiwwAWuve9v9VE6lWINcGo4ca5ZzSKl8R9ogWF+2F7yY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x92Sy-0001yz-Hu;
	Tue, 22 Sep 2026 15:31:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x92Sw-0001yp-RF
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 15:31:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ii+FXWj2maJ1KVWfzU+rbs1qaenM7FRCrs6mK6PHqHQ=; b=hAxuaqCKZwadtd9qCOsOM+O5Fa
 9aTDEo9NLv6eww198tqh1D05cy9fKi7wTY85xLgPBZhc3TdmAW7rVBJeHxoDSj0S5U1OBK4M3JYij
 lypMy7FGGQpHmWfIUzmvxTu1fYvrAeLzbF5wGAJ0oXPsr1x6AXfmp3HTJN/8SXQdk5O4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ii+FXWj2maJ1KVWfzU+rbs1qaenM7FRCrs6mK6PHqHQ=; b=f8R0tJT4UXNk5dNny/vhgIoAeP
 TU6mJ+1LBGGQrpcRF9P3wxUCtMdcIrarkxY2Oj5C3hBCiHxXqFvkiojD/rPCFOeTpIx+ZPeUAzGJr
 taGeLO20/GxRtmd0mY4Ybr98urKD2IpYX2s+Jf0SS9DG4OTm17E/nar48kBMqPiPmwnY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x92Ss-00070G-VI for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 15:31:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B34960204
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 15:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72111F00893;
 Tue, 22 Sep 2026 15:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790091080;
 bh=ii+FXWj2maJ1KVWfzU+rbs1qaenM7FRCrs6mK6PHqHQ=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=geI/AhwQpa5ZoGGG3Z4RM74XkERwtMo6CQkvCGFSx3tbC14qaQSU9y20dqTaVNjam
 aH23kumN4tPwFu9XN1346HaMk2qaeIZBYQ/e//fL4eDta5vsUo1UlObnahS4XuxpIX
 E3mHVa1yiCFpLzsToGIUR21YTGtC/I2z7cUc6NclcviCjFQV+FhkEH/XgZLZK4Qxpy
 Sva6LZOPxWrLdIcW/aftctH500YI+K+LerimuPJmpD4o2RMfr7K63kyU86L9aVY6Wj
 ZOFEaDYwQWZiCW3jvTqKcR9Oqd8NrkaeiSMs+TsV7HvznwiDa0SggzKxEk8ja9DUOq
 tutKpF7wS941g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 198A63811A4B; Tue, 22 Sep 2026 15:30:13 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179009101165.4140645.13020875128862950856.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 15:30:11 +0000
References: <20260824134731.3704352-2-chao@kernel.org>
In-Reply-To: <20260824134731.3704352-2-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x92Ss-00070G-VI
Subject: Re: [f2fs-dev] [PATCH v2 01/12] f2fs: cache: implement metadata
 cache
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

On Mon, 24 Aug 2026 21:47:20 +0800 you wrote:
> This patch introduces the core metadata block caching infrastructure to
> manage f2fs metadata independently of the page cache.
> 
> It implements:
> - core cache APIs: get, create, put, drop, backed by a radix tree and
>   a single global LRU list.
> - support multiple status of cached block: LOCKED, UPTODATE, DIRTY,
>   WRITEBACK, INLINE.
> - internal bio based read/write helpers with adjacent block vector merging.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,01/12] f2fs: cache: implement metadata cache
    (no matching commit)
  - [f2fs-dev,v2,02/12] f2fs: cache: initialize meta cache
    (no matching commit)
  - [f2fs-dev,v2,03/12] f2fs: cache: introduce shrinker
    (no matching commit)
  - [f2fs-dev,v2,04/12] f2fs: cache: introduce writeback thread
    (no matching commit)
  - [f2fs-dev,v2,05/12] f2fs: cache: use meta cache
    (no matching commit)
  - [f2fs-dev,v2,06/12] f2fs: cache: initialize node cache
    (no matching commit)
  - [f2fs-dev,v2,07/12] f2fs: cache: use node cache
    (no matching commit)
  - [f2fs-dev,v2,08/12] f2fs: cache: initialize compress cache
    (no matching commit)
  - [f2fs-dev,v2,09/12] f2fs: cache: use compress cache
    (no matching commit)
  - [f2fs-dev,v2,10/12] f2fs: cache: support fault injection
    (no matching commit)
  - [f2fs-dev,v2,11/12] f2fs: cache: introduce tracepoints
    (no matching commit)
  - [f2fs-dev,v2,12/12] f2fs: cache: show per-cache usage in debugfs
    https://git.kernel.org/jaegeuk/f2fs/c/f17987c6219e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
