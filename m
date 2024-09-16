Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCECDC3ABB2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Sep 2024 21:30:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sqJIz-0007yv-1U;
	Mon, 16 Sep 2024 21:30:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sqJIx-0007yb-1p
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Sep 2024 21:30:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1k3CeuPySqe51GxTLwY4vOdYDoZHGrIh8/jtRqd+638=; b=DuN0wH9COBsWa6RkCC0nW5CJ29
 xLwinSbXy8P+yfwxw/ovM1KAkkzSwrK4kvLjgNW0FKdPUCef8v6if+QZRoaPIqwhhqf6aFDJnbsMu
 A6UpMajhoovewlFPqzZM2egYmT1tAfqSiHCcu1BT1WMMP3JWzxjNNsGwgV/memcvYNRQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1k3CeuPySqe51GxTLwY4vOdYDoZHGrIh8/jtRqd+638=; b=gNNw6GZnpjucoDO5PJ3MWFt0YI
 uBxFRcK6ecwkO416j0dE+fbIbcblppxxNeJay8CwAJ7UPGBpWkPveugsRj4OQvQP03dEAhxeCA5+n
 LJJ88K21dBaoYXLmixdIQLgrGF+evdCT5vOD46ttbbxYVgsF1VGsld2zuSz/7mcDrbMg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sqJIw-0000OE-FD for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Sep 2024 21:30:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 577C15C05F9;
 Mon, 16 Sep 2024 21:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA99C4CECF;
 Mon, 16 Sep 2024 21:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726522231;
 bh=f6cGudW8bpYB1h8dVvi/iSMGcZhutHcSIscuvvjHLEA=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=C47j5NIDmrzDc3lovwDrQdBL1QO4Nx3FaDGvG7rVGNTBZrMfIFVMip3Uv9kM/knkw
 0qcGEVvj9cFEC5exqZWJQiyzZyJJEAEZW3yj61EIm7D3o6bVqxstObxa7Qw8OuL4jJ
 wxqUvmupkGYa64lIzLFdpouQo9n6H2rR4k70qV5m2cY4NwPFQ807bwa1uON4rBP79v
 0zdE/umc3Eh6qwYQ8rLkHENLW45L3rc9gICSy3rLcZ5mPcBD3Jn4UPxWZjvuqhUkbn
 e8UIRKbkz3nnqcT5NunwS81eLpcPGZ7pA+wGzz0pW56TQxsWJwF5CP9OC6QuwPlQfc
 ekHCPJ34uVBhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 70C223806644; Mon, 16 Sep 2024 21:30:34 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <172652223303.3820990.12818974880515327403.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 21:30:33 +0000
References: <20240909221946.2004046-1-daeho43@gmail.com>
In-Reply-To: <20240909221946.2004046-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1sqJIw-0000OE-FD
Subject: Re: [f2fs-dev] [PATCH v2 1/7] f2fs: make BG GC more aggressive for
 zoned devices
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  9 Sep 2024 15:19:40 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Since we don't have any GC on device side for zoned devices, need more
> aggressive BG GC. So, tune the parameters for that.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/7] f2fs: make BG GC more aggressive for zoned devices
    https://git.kernel.org/jaegeuk/f2fs/c/5062b5bed432
  - [f2fs-dev,v2,2/7] f2fs: introduce migration_window_granularity
    (no matching commit)
  - [f2fs-dev,v2,3/7] f2fs: add reserved_segments sysfs node
    https://git.kernel.org/jaegeuk/f2fs/c/4cdca5a904b1
  - [f2fs-dev,v2,4/7] f2fs: increase BG GC migration window granularity when boosted for zoned devices
    https://git.kernel.org/jaegeuk/f2fs/c/2223fe652f75
  - [f2fs-dev,v2,5/7] f2fs: do FG_GC when GC boosting is required for zoned devices
    https://git.kernel.org/jaegeuk/f2fs/c/9748c2ddea4a
  - [f2fs-dev,v2,6/7] f2fs: create gc_no_zoned_gc_percent and gc_boost_zoned_gc_percent
    https://git.kernel.org/jaegeuk/f2fs/c/9a481a1c16f4
  - [f2fs-dev,v2,7/7] f2fs: add valid block ratio not to do excessive GC for one time GC
    https://git.kernel.org/jaegeuk/f2fs/c/e791d00bd06c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
