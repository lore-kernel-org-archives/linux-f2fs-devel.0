Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936F8C004C0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Oct 2023 15:30:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1quwtA-0008Bo-81;
	Mon, 23 Oct 2023 15:30:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1quwt5-0008Bd-FG
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Oct 2023 15:30:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kzYx2bS3zOShhujBKTlSVoDYT8AWuhWkkMexuXmSISM=; b=gc3XWTU133CkYnE5RxaTULPPK3
 UYSl+Tbc8ISsVsEjV/X46xN3IprND2aUVsFRA59iB5XMJdwLxkokwwJjxqa61FvzenXKbJmHpJy7e
 mM5u/xLzYO43XzyLkcW1J2xjzSnfLjjxeVBLj9SQP2pPT+EPXkWoEuKt9heKkKk8sJ0Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kzYx2bS3zOShhujBKTlSVoDYT8AWuhWkkMexuXmSISM=; b=cr9RJ/XzOBoNrR631l0bS9i34N
 BUbhiA91mTZTWsacuZAYL2jqfk6Wm02te6XvdcSfeyFDO5OcXwWynXRVTVIj7ZoggOXYRI1t5VBM7
 FrEAv/EBnlNnbiZBBBicTfMbJQXI0r/d9nLHMkMTP9TcPUVWhyku5NhX/woTHMt9ED7w=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1quwt3-0002HY-La for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Oct 2023 15:30:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 87AC6CE25E3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Oct 2023 15:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 415E7C43391;
 Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698075025;
 bh=Qde5lD2H9pgYacxOPvWGUoIweuMUBvcPozp5suB9kJI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=atOJP2NaWlB+bkSZfHdWNKdLZ2W2rKacrDJXUjL2ffderZs6lmRxWwo3/R+zukcaS
 KmBFgd9Q7UeKnwjeBoOh9CmUCVlDELjpOGpzrqMr3iTSxT5RNHm+SKJBcQAtbs4Rqc
 M4PtUXo+L5fTv047Xy75ZubyJqlJULEnQTmK0tAl+QYWq9CbK9k3QC7fk77EXnbFZT
 thLma4AHKdB/StGwIjIPjlvsYK5M9gLqPMLXKl41oArLTzhlebyNyEL1n4U1JAddzP
 Anga6cH/HefM+r3T8LlIG8ixiwAnEGlNSLAfYree4srg1YOBwZgp1m2yNU0wY0IMi/
 CQH8kryxtOfzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 187B8C595C5; Mon, 23 Oct 2023 15:30:25 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <169807502509.26537.10000141345816003464.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 15:30:25 +0000
References: <20231003225208.1936359-1-jaegeuk@kernel.org>
In-Reply-To: <20231003225208.1936359-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1quwt3-0002HY-La
Subject: Re: [f2fs-dev] [PATCH] f2fs: stop iterating f2fs_map_block if hole
 exists
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  3 Oct 2023 15:52:08 -0700 you wrote:
> Let's avoid unnecessary f2fs_map_block calls to load extents.
> 
>  # f2fs_io fadvise willneed 0 4096 /data/local/tmp/test
> 
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 386, start blkaddr = 0x34ac00, len = 0x1400, flags = 2,
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 5506, start blkaddr = 0x34c200, len = 0x1000, flags = 2,
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 9602, start blkaddr = 0x34d600, len = 0x1200, flags = 2,
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 14210, start blkaddr = 0x34ec00, len = 0x400, flags = 2,
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 15235, start blkaddr = 0x34f401, len = 0xbff, flags = 2,
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 18306, start blkaddr = 0x350200, len = 0x1200, flags = 2
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 22915, start blkaddr = 0x351601, len = 0xa7d, flags = 2
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 25600, start blkaddr = 0x351601, len = 0x0, flags = 0
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 25601, start blkaddr = 0x351601, len = 0x0, flags = 0
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 25602, start blkaddr = 0x351601, len = 0x0, flags = 0
>   ...
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 1037188, start blkaddr = 0x351601, len = 0x0, flags = 0
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 1038206, start blkaddr = 0x351601, len = 0x0, flags = 0
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 1039224, start blkaddr = 0x351601, len = 0x0, flags = 0
>   f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 2075548, start blkaddr = 0x351601, len = 0x0, flags = 0
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: stop iterating f2fs_map_block if hole exists
    https://git.kernel.org/jaegeuk/f2fs/c/4ed33e69e136

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
