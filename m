Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BAAC54E58
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 18 Mar 2024 20:45:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rmJrd-0006Um-Vm;
	Mon, 18 Mar 2024 20:45:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rmJrc-0006UT-4J
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 18 Mar 2024 20:45:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q13nBugoKjyr9ZoypFV3Yjm3Mx3CjOgHidwT5pFaw/A=; b=F0XWDNIHO3rmcEFcvhgiz8odBs
 8k/J2Jmfc57LnreZHUSqYz6rDwrBD5sBxpTIHMcOVlh9pazE0Dw3hoqaCVdKiskIfDmCvIidngOKg
 7JbXnNxOdDJEimORTgwpSLcIEXP88XD/DQ9g05aJ2JMNLqeQ7EyJ3Wpvc8icoTBwmYGM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q13nBugoKjyr9ZoypFV3Yjm3Mx3CjOgHidwT5pFaw/A=; b=IYJh4hNjIZBf7XqQzh3ALeMlwv
 m8hvisBxtli5C3bnhML0Ni/due1zHCf+ZZAMlJQy2WZhbJqwWFPH9LhTZaRct04wZf6dJI59vT1Gz
 XJpL3kr1kuPVe/T5/DAfr2zNIPIxFZ10US5+OUwhkdrzfkwRnaDn1399UM1ST3nTpD0o=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rmJrU-0002JN-UO for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 18 Mar 2024 20:45:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D810060CF4;
 Mon, 18 Mar 2024 20:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48E0AC43390;
 Mon, 18 Mar 2024 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710794733;
 bh=RA7YG9SxvBNH0HzRjB4rflPOx+FpSXM4xEmiICNLvcY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=KyFjlQSNxf74Oqy7Vk41Z9wIUXqjnooZpsxTmo8JSxgThzYTCwHWls0FF4kzamlkc
 BlUnEdjGJSg5ibhkZUC8lt2Xeel4gl61vL89noc5We60f9m4H0aWRCbEggOM63FrzT
 U1A8ZyDACddoeXAkXK1+9VK8ib5U8ZT0jbstEuF+R64RXuhWsc0+MKGFuei8pq2JaP
 ExIXX0oF28y6mNxHposHwr0sC7JB71EKrozyr3MdNIBhBxgYeeV4gsGh6iS4aQxzwL
 2hQ0TTKB2vLUf8IIclhWDz0+927nPTxLVGQ3oVViWPszlA80Fb4s07T232h/EFw9uT
 NK7/pbaFd1cZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 2AE0D174C8D6; Mon, 18 Mar 2024 20:45:33 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171079473317.25373.4387818669796784248.git-patchwork-notify@kernel.org>
Date: Mon, 18 Mar 2024 20:45:33 +0000
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
In-Reply-To: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Headers-End: 1rmJrU-0002JN-UO
Subject: Re: [f2fs-dev] [PATCH v3 0/5] block: remove gfp_mask for
 blkdev_zone_mgmt()
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
Cc: linux-nvme@lists.infradead.org, clm@fb.com, hch@lst.de, agk@redhat.com,
 naohiro.aota@wdc.com, sagi@grimberg.me, dm-devel@lists.linux.dev,
 kch@nvidia.com, snitzer@kernel.org, josef@toxicpanda.com,
 linux-block@vger.kernel.org, dlemoal@kernel.org, mpatocka@redhat.com,
 dsterba@suse.com, jaegeuk@kernel.org, axboe@kernel.dk,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, jth@kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jens Axboe <axboe@kernel.dk>:

On Sun, 28 Jan 2024 23:52:15 -0800 you wrote:
> Fueled by the LSFMM discussion on removing GFP_NOFS initiated by Willy,
> I've looked into the sole GFP_NOFS allocation in zonefs. As it turned out,
> it is only done for zone management commands and can be removed.
> 
> After digging into more callers of blkdev_zone_mgmt() I came to the
> conclusion that the gfp_mask parameter can be removed alltogether.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,1/5] zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
    https://git.kernel.org/jaegeuk/f2fs/c/9105ce591b42
  - [f2fs-dev,v3,2/5] dm: dm-zoned: guard blkdev_zone_mgmt with noio scope
    https://git.kernel.org/jaegeuk/f2fs/c/218082010ace
  - [f2fs-dev,v3,3/5] btrfs: zoned: call blkdev_zone_mgmt in nofs scope
    https://git.kernel.org/jaegeuk/f2fs/c/d9d556755f16
  - [f2fs-dev,v3,4/5] f2fs: guard blkdev_zone_mgmt with nofs scope
    https://git.kernel.org/jaegeuk/f2fs/c/147ec1c60e32
  - [f2fs-dev,v3,5/5] block: remove gfp_flags from blkdev_zone_mgmt
    https://git.kernel.org/jaegeuk/f2fs/c/71f4ecdbb42a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
