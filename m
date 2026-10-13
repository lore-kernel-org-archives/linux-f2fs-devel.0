Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771B6CC6B15
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=33GMx0o8ZQAW8pGR3dIwx1Cpv53qCHp84zGv7hjVMg4=; b=W0vvKYsNaSeVett2hH7HdE+k6W
	21tfXnkwvTUg+A44Uez+kzuRqaKCtl18k6yk8KmfhbnjhwZGoh8o0dcy637syJ7ZUUPWdNb98XPt9
	WaZcIe0UFj7t/ddT+9+JlYX3b6JDBrBuzpX+geyyPPFEdmZigKu2Ey542VhMZ5SBZ0kI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGl1H-0002Fq-LH;
	Tue, 13 Oct 2026 22:30:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xGl1G-0002Fc-DD
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Np9xnuu6XiKVbwBFAPp4t+RIdjq2sSckN1p0VTuLUy4=; b=Kuyn0BGre8MSsTbDGAQ8EWPBi1
 KkzKvIptftFfSJ1JOaK1Bet+dRtmgXh1JtVOSOc0uw3NoqgP7VHUTkc1/u8hGklqMXM86aRSa+URc
 cV8v4msjQJMU0F3EbBmRV5AUZPmW5dAPHxhAzV8fmHCe2gEexN9A9maYV/vx9fQv/BwQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Np9xnuu6XiKVbwBFAPp4t+RIdjq2sSckN1p0VTuLUy4=; b=d+Yz1YW24FKWj/t0oi08jwZcSh
 UEPnvyOoyEjdL072kYKB0DW9+oBnK4Lnynutz5QNczFuCI/LIRGmSawp6+ni7cN7qa1GytbmjBM8P
 Lokv885P+9pfZk/zovSw+Syh6g8SEPHeCTJRCeGXCudRunvF3HlgAWAkrV4CKVW/QSuc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGl1E-0001eB-C3 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA927601DB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 22:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D7C1F00893;
 Tue, 13 Oct 2026 22:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791930642;
 bh=Np9xnuu6XiKVbwBFAPp4t+RIdjq2sSckN1p0VTuLUy4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=F0x98hh7uT1ubqr+v607DM8Rr1PmR7VGfeYXqxvRC7tV9dIbNtW2y1s6DQ1v4Op6J
 2p28tYI8elZQsW2Ljm+Phd49zJujU+tbOo1ESV4T+bb9z9FXfRqUET09v9yFFy0Le/
 CJ5dBVK/mqbZRXqcnqHtVCQjrk2VEPxnh6fLzDlJI0P9fYMuQiGoHHTrNUBkAXiw0d
 HdGe8PQ0E7SshVeBxC8piArbmjJH/bxZtxnI9torn8jt+IQmo5ZdHi5V33KTxVLbGI
 FXRMI/3XAtm7mwtvsl1fKvxFs7owhgyNhTpVJ/dwxu5N4M20APnAr3knRiET6CuAPu
 /qjU9/Vdvelgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 773B639E4DBA; Tue, 13 Oct 2026 22:30:42 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179193064101.1493834.14246878856998575721.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:41 +0000
References: <20261007101812.2348510-1-chao@kernel.org>
In-Reply-To: <20261007101812.2348510-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1xGl1E-0001eB-C3
Subject: Re: [f2fs-dev] [PATCH] f2fs: zone: fix to avoid bio split on
 sequential zone
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  7 Oct 2026 10:18:12 +0000 you wrote:
> From: Chao Yu <chao@kernel.org>
> 
> In the block layer, bio_split_to_limits() splits a bio if it exceeds
> any underlying queue limits:
> 1. queue_max_sectors: Splits bios larger than the transfer limit. This
>    limit is set by the device driver/DMA controller (max_hw_sectors) and
>    device-mapper targets. When flushing dirty pages (governed by VFS
>    writeback_chunk_size() and f2fs nr_pages_to_skip()), f2fs merges
>    contiguous pages into bios up to 512KB (1024 sectors) or more without
>    checking queue_max_sectors, which will be split if the device or DM
>    target enforces a smaller limit.
> 2. queue_max_segments: Splits bios exceeding scatter-gather segment
>    limits. f2fs allocates bios with up to 256 pages, exceeding the
>    128-segment limit of DM targets (dm-default-key/dm-crypt) if pages
>    are discontiguous.
> 3. chunk_sectors: Splits bios crossing chunk/zone boundaries. In f2fs,
>    section_size strictly matches zone_size, and block allocation never
>    spans across section boundaries, so bios never cross chunk_sectors.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: zone: fix to avoid bio split on sequential zone
    https://git.kernel.org/jaegeuk/f2fs/c/b9b036bd1e2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
