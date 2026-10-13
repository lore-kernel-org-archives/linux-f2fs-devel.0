Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7F2CC6B0F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2wrPI2C3hnOU6JY8pHaUZaVUtCuE5ClM2V2NFR8vDLU=; b=gb6o1dY4mkT/vVYyT2zJWad5y1
	YhYlPUR75kOwBVVydNu3FoaGNJ96OUFP7537342PgXqAQQRM5nMnY1hfeKmICEyLamxf+dVaAABmk
	K4IxIi/9wOV7wiktA7I7nysVmjs+Tev2L2UVxh1dnt9md+uETxfSUfmh2T6yfabFdrow=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGl1H-0007aN-Mq;
	Tue, 13 Oct 2026 22:30:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xGl1G-0007aD-D8
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gK5BiDEntrKD0+Dzj/T26h4UrOX6cmNMvMNJ/Y4XJ/U=; b=lMqkRSgLrn5WL35+kXYNkLTRY8
 p1jLfZBPU0AAa8dd386J+Oe4Czr+5Jc9RsCsGI8o3n7OmGrWQwneTtGzIDQAnGdRnICR1VCEscJ2D
 jY5v8uQOl0PviI7QmidQMHpAJUsAnDGi96rR4bbW1NXmd05FjDQLTflKH6Utqntp/QR4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gK5BiDEntrKD0+Dzj/T26h4UrOX6cmNMvMNJ/Y4XJ/U=; b=Tv1Nr9QcyYF81FiHK6FQquBLRT
 8ymlWJSYCwHz2WADK4OWz8RGeojCxODMPvPEN74Q4+qomGPJAnKyef3ZYxblmHm5YSB+lctsPilIT
 rjJLYs8Ue9TuvNdwm9UuUxK2zuYzsboUYLtRaQbiM/RjE6S3t4aq3AET+ZQakhNMCvv8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGl1B-0001e3-CC for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 22:30:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CB2BE6022B;
 Tue, 13 Oct 2026 22:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818751F0089C;
 Tue, 13 Oct 2026 22:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791930639;
 bh=gK5BiDEntrKD0+Dzj/T26h4UrOX6cmNMvMNJ/Y4XJ/U=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=KYHqO+/dLQiNrBW0pAQsNxN2fCoI/LLOrf+wGTzkk6b0kDzNVaAwGvJOCaoGLTRXM
 VCfhYnIE6mUE4BeLIffje9RTnf3CYdJclPJfbfOX06Hgxh/h4NSKMbh8ieeJjrtaMc
 KjxEvopPb/bYA5sTH3ZcnD1YUxp3sDyldEUr3qSXuxiJXkxsFy0QdPjzkNA9SgJAp+
 W+isKQrFIWVH2Gc2VybDBqD8GnD/DBCb6hUQvpkFYMk0aqka9QLmY12euzg57NFdVf
 yP6YnSeOMtL9RHoOlyM2AWrKHsgwdo4fND/eVjNT2CU2VixPIajx7ymn20iHFx5rVM
 x1M7b92rAp7sQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7732739E4DBA; Tue, 13 Oct 2026 22:30:39 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <179193063801.1493834.11114382446696553394.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 22:30:38 +0000
References: <20261012091737.308136-1-chao@kernel.org>
In-Reply-To: <20261012091737.308136-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1xGl1B-0001e3-CC
Subject: Re: [f2fs-dev] [PATCH v3 3/5] f2fs: cache: wake up f2fs_writeback
 when exceeding threshold
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
Cc: jaegeuk@kernel.org, qiwenjie@xiaomi.com,
 linux-f2fs-devel@lists.sourceforge.net, daehojeong@google.com,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 12 Oct 2026 09:17:37 +0000 you wrote:
> From: Chao Yu <chao@kernel.org>
> 
> This patch introduces cache_wb_dirty_threshold and cache_wb_total_threshold
> sysfs nodes under /sys/fs/f2fs/<disk>/, and wakes up the f2fs_writeback
> kthread when dirty meta/node caches exceed cache_wb_dirty_threshold and
> total cached entries exceed cache_wb_total_threshold; a zero threshold
> disables the corresponding check. By default, cache_wb_dirty_threshold is
> 8192 and cache_wb_total_threshold is 0.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,3/5] f2fs: cache: wake up f2fs_writeback when exceeding threshold
    https://git.kernel.org/jaegeuk/f2fs/c/eeadc4807c95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
