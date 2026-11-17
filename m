Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92CD606A32F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=G2BaAHCq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HBVPyEQF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=C6nfn9mE;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Apt6Xdsf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ZRaxld4r+uYJwGVJdurIrlxYWE7cLXblRthA+WsfSn0=; b=G2BaAHCqPhG8cQ
	piTxRGT4iCZkk3UKixLvo27Y9GYTaOEYhP7WOcWjvRqAY9uepJbyYhlZwholtQ0njI2ZVRH04TDvh
	cGBceN4ZNN0V/Vyqxy0qKxTC40Xb9lGlJ1x/MDHdJMA8wN72FJziBXS/ifcd/0fRqD1Kq7PAMQEom
	sbE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTMNv-000000000C9-2XQH;
	Tue, 17 Nov 2026 16:50:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <patchwork-bot+f2fs@kernel.org>)
 id 1xTMNu-000000000C1-02Tl
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 16:50:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y1tk3kCxl+bAfIY0WHKT9XLzFrGBaV3u+SQyhSnfIjM=; b=HBVPyEQFCkXOoDjJI3M0FSDVtW
 bxWXJ4MHpHVXQYE8l8NkGklZd84Hw20Nf80f6nsishYMAHMuXE6h1bxz8m0W17yVgisaJvKnL4Mkr
 slOsN389tJ8ayb0uY3Lm1JGfmtev0mFngwoNTl5mvW0QvsuP2EUDK78gtjuigk3w44XA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y1tk3kCxl+bAfIY0WHKT9XLzFrGBaV3u+SQyhSnfIjM=; b=C6nfn9mEqSxMeae7BTWbdLfl5E
 CDctE9fHQlrPBZYJ1GCr6t1izG+ySydXlA2feZV5vWziSPGA2Ur7IfX1MgO7Wl8Bho9dvK8ADJD8G
 VElUcJkKuSn+e+gq/cAMoNOqO6aRlwjtSOuMwu8EuCvM/Ca5sH+WFbgIrCmUz85FMrOU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTMNt-000000003W0-0abm
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 16:50:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8F7F96193F;
 Tue, 17 Nov 2026 16:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469EB1F000C5;
 Tue, 17 Nov 2026 16:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794934211;
 bh=Y1tk3kCxl+bAfIY0WHKT9XLzFrGBaV3u+SQyhSnfIjM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=Apt6XdsfhFdWMX0+YNkyhrfAuGlZKIAJJtuqnlsZlWPuzxc3EIOazLHNvjGQ0Q4vj
 vpLTG72JDTXccYMj++QIR++kpuopvwyXolaS4CkoGkhpR2LLILow0xb1hqmquTFMt6
 CV0WSLzl+N1BxSrCe+C70JXoRdtpMCKPxbHBLEHZ2L3tdldFvdc4bxzG7d32WT3G09
 QA8WggkpWt2glHw0IGS/Zj29BgiPKd1dCFVHpUIiyZtgwexW4Oqt6DlLCkYSNIzZeE
 dvdwp6yhy9f32QW7R9JmFlXgqT74+rrfLMf8nUgPDSEqQPTPpKDbpoWgtaC/EBXuQF
 +GqjYVxrdZvBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3A322392706F; Tue, 17 Nov 2026 16:50:11 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179493421003.698822.10872235579816868645.git-patchwork-notify@kernel.org>
Date: Tue, 17 Nov 2026 16:50:10 +0000
References: <20261116040851.2849696-1-daeho43@gmail.com>
In-Reply-To: <20261116040851.2849696-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTMNt-000000003W0-0abm
Subject: Re: [f2fs-dev] [PATCH v2 00/20] f2fs: support block size smaller
 than PAGE_SIZE
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 15 Nov 2026 20:08:31 -0800 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> F2FS has required the filesystem block size to equal PAGE_SIZE. On a
> kernel with 16KB pages, this means an existing F2FS image with 4KB
> blocks cannot be mounted, e.g. the userdata partition of an Android
> device that moves from a 4KB page kernel to a 16KB page kernel.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,01/20] f2fs: use block-based index and size calculations in more paths
    https://git.kernel.org/jaegeuk/f2fs/c/7985ae4403bd
  - [f2fs-dev,v2,02/20] f2fs: support subpage block size superblock and mount
    https://git.kernel.org/jaegeuk/f2fs/c/4677715aecb4
  - [f2fs-dev,v2,03/20] f2fs: extend f2fs_folio_state for subpage blocks
    https://git.kernel.org/jaegeuk/f2fs/c/6dad9aa2be5b
  - [f2fs-dev,v2,04/20] f2fs: support subpage blocks in directory operations
    https://git.kernel.org/jaegeuk/f2fs/c/5cf7185bf5d4
  - [f2fs-dev,v2,05/20] f2fs: convert inode dirty page counters to dirty block counters
    https://git.kernel.org/jaegeuk/f2fs/c/85d94a798481
  - [f2fs-dev,v2,06/20] f2fs: support subpage blocks in data read path and GC
    https://git.kernel.org/jaegeuk/f2fs/c/1f3fb065c53b
  - [f2fs-dev,v2,07/20] f2fs: support subpage blocks in data write path and writeback
    https://git.kernel.org/jaegeuk/f2fs/c/075eb224620a
  - [f2fs-dev,v2,08/20] f2fs: adapt range operations and mmap for subpage blocks
    https://git.kernel.org/jaegeuk/f2fs/c/b59ad45de360
  - [f2fs-dev,v2,09/20] f2fs: support subpage blocks in pinned files
    https://git.kernel.org/jaegeuk/f2fs/c/1fca7e80ab81
  - [f2fs-dev,v2,10/20] f2fs: support subpage blocks in collapse and insert range
    https://git.kernel.org/jaegeuk/f2fs/c/804fc9fc11a5
  - [f2fs-dev,v2,11/20] f2fs: support subpage blocks in move range
    https://git.kernel.org/jaegeuk/f2fs/c/b012b16ed8ad
  - [f2fs-dev,v2,12/20] f2fs: support subpage blocks in defragmentation
    https://git.kernel.org/jaegeuk/f2fs/c/a200065e07d6
  - [f2fs-dev,v2,13/20] f2fs: support subpage blocks in swapfile activation
    https://git.kernel.org/jaegeuk/f2fs/c/0ef07ef01bb5
  - [f2fs-dev,v2,14/20] f2fs: support subpage blocks in fs-verity enablement
    https://git.kernel.org/jaegeuk/f2fs/c/780f86c0f2ed
  - [f2fs-dev,v2,15/20] f2fs: support subpage blocks in atomic writes
    https://git.kernel.org/jaegeuk/f2fs/c/d848dac0ab70
  - [f2fs-dev,v2,16/20] f2fs: preserve inline data in subpage block mode
    https://git.kernel.org/jaegeuk/f2fs/c/50af3450d3b6
  - [f2fs-dev,v2,17/20] f2fs: support subpage blocks in online resize
    https://git.kernel.org/jaegeuk/f2fs/c/fa57651dbe6f
  - [f2fs-dev,v2,18/20] f2fs: support subpage blocks in compression
    https://git.kernel.org/jaegeuk/f2fs/c/b5c77585f32c
  - [f2fs-dev,v2,19/20] f2fs: count compress cache entries in pages for its memory limit
    https://git.kernel.org/jaegeuk/f2fs/c/c86146d870b3
  - [f2fs-dev,v2,20/20] f2fs: enable subpage block size support
    https://git.kernel.org/jaegeuk/f2fs/c/5d4c8a45517f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
