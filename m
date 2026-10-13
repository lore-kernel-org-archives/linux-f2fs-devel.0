Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA7ECC6B12
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9AsrDeZdAfJdWffYsbwKEVBHiq1JYWf2IdUfODLKFPE=; b=mdu00EJxR4r0KaUed3eVLqtl/7
	4Wr9AkepbF2UiGNyVeAziPXaHmvQwCAsdEQjzIBrpZnbdczWmLhbyisZjHgSBM2Pv7U5bFMH6uyZg
	vr2OJflrwP2VdbqFCMsi3LXTRUgO+l/ldp8al3/zxtmlyVybbk4WiJXnNsIwJISARhyw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGl15-0007Xi-JG;
	Tue, 13 Oct 2026 22:30:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xGl13-0007XT-Ji
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V6Fzv/xwZWojt+EWhgu275zfjc+Bzu1Q3i6IRSLhWJM=; b=NdDQcafyTDOUIl0++iFp4RcNfm
 aY+h/ULHYd1skA936/Oki2UAG7jNolmoqQHHDxHB1hKTm7lxG76tmlfwZa1ZNvNf9OsMgO6/IpvlH
 0+67t5oB6ZerzxSTy2ntdDj237Xcvelyi8S7cyRRSqNrYKffZ/yG7iJVNf3XJigx0bQo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V6Fzv/xwZWojt+EWhgu275zfjc+Bzu1Q3i6IRSLhWJM=; b=A5M4bFW5+p+BuxcGoS/keZ/VVC
 xYMiaMCtStKq34ATlxTfC+nuRg3woXGwQI2fCm+wOtPOsdsN4MjmqXxNrblJgF/UATfpuIIeqZgBW
 r2ZgOMGWYZ2F4Qt/Ke+wNCORON+V1V10j6IfIWVCuawUWQL76i2AgGt0CT7F5Gtjaq9o=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGl11-00064y-Tq for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A0A8B4376A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 22:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840331F00898;
 Tue, 13 Oct 2026 22:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791930630;
 bh=V6Fzv/xwZWojt+EWhgu275zfjc+Bzu1Q3i6IRSLhWJM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=GwH8nB/EZWv7fu6hE4XEjf+LGHLVoEeoyGgGQ9VD5sdxkr2B3WSq+nfiN6fa0Oa8S
 SzjvvVM2etKBOWr+Z5HrKg/ILeSSPbIiqQfvJS+5mAvsU/BImICKiz5rNkCuBjD5hV
 n8M1u9NB/9dqVrP1VzbU36OtPg7usUno5DZvaUy90P83aNebWYIN2Vn9RocHEsnzrU
 AGpfs4kLEYuTdUR86Y5UirVK1uiHxcw8ZfL4U5NMwXXKD9hjOHaFBdmhTniNleIOqP
 VbMag2Pmz3/mBg9yu2jILD+Urc4b7dvNVeDTQWKIi5JtSpNCkcoUmMBtlnmYqWjZfu
 vq/nByaXFPrSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7727D39E4DBA; Tue, 13 Oct 2026 22:30:30 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179193062901.1493834.12835445891823777379.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:29 +0000
References: <20261007114949.2428048-1-chao@kernel.org>
In-Reply-To: <20261007114949.2428048-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1xGl11-00064y-Tq
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: cache: introduce metadata_cache
 sysfs node
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

On Wed,  7 Oct 2026 11:49:45 +0000 you wrote:
> From: Chao Yu <chao@kernel.org>
> 
> This patch exposes a new sysfs node 'metadata_cache' under
> /sys/fs/f2fs/features/ to indicate runtime support for the in-kernel
> metadata cache infrastructure.
> 
> Userspace can check this feature entry to determine support before
> configuring metadata cache knobs (e.g., cache_wb_interval) or parsing
> per-cache memory statistics in debugfs.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/5] f2fs: cache: introduce metadata_cache sysfs node
    https://git.kernel.org/jaegeuk/f2fs/c/e881f4730f75
  - [f2fs-dev,2/5] f2fs: cache: shrink meta and node caches in f2fs_balance_fs_bg
    https://git.kernel.org/jaegeuk/f2fs/c/7f35dce566fb
  - [f2fs-dev,3/5] f2fs: cache: wake up f2fs_writeback when exceeding threshold
    (no matching commit)
  - [f2fs-dev,4/5] f2fs: cache: support asynchronous write_end_io
    https://git.kernel.org/jaegeuk/f2fs/c/bd09975045fb
  - [f2fs-dev,5/5] f2fs: introduce max_atc_write_bio_entry_cnt
    https://git.kernel.org/jaegeuk/f2fs/c/f32744a8b83d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
