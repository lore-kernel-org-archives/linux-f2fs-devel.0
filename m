Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A672C282EC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:50:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ts5cL-0004uA-MH;
	Tue, 11 Mar 2025 19:50:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1ts5cK-0004u4-VP
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Mar 2025 19:50:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=171KTPlkjOTPZ9TNAHZ/f/l6+G91fIvYqVdma1/uvVk=; b=Qmtgc6nJJguFSoLrHcXPWVRVR1
 UjknCTLPqZ8GgAZRjnC55dvZ8Zr1j/gbjKvDUO3VBfWrAhhv/k+t6Ht0quIUopryapTbA9DdBKChs
 rdNfFl2aMQ5zYZxF91r27rRt2yvympvZ7n79xFTz6bwnzXvOgdSffUo5WdkDxnMhZh9Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=171KTPlkjOTPZ9TNAHZ/f/l6+G91fIvYqVdma1/uvVk=; b=QtXK4a0cKbWlZb9HfarSslmFT2
 e9hziUXVUu0A/yfw+jgzWyimBEjr0UkakP0SjldTRWusO7aY8lgEhC1Qi1teeWk4dOXbjX9R1omtL
 hqkVFbuCqiHFsA51c6LEYKnmqEPzYbMchCwy3GEN06owA57jx2G4p2JeYz8GEGxB43fg=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ts5cF-0002kQ-By for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Mar 2025 19:50:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 9DE82A46613;
 Tue, 11 Mar 2025 19:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784FEC4CEEA;
 Tue, 11 Mar 2025 19:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741722604;
 bh=NWDF5ErT0ort93GZcRV87fUQSw4ceuLFCLbVehXWlFA=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=o4eq+9g+7C4lVLnkxDZUUJFposQw4rJ2pbCWtKfEmMWTCGwQbnTqLQIDbpBst1M8D
 le97bWIdZ5Q6ATlLwNhkUx3dTh1Ho4hVCF8BGPuBj56N6BC9hvuIPZ+BN++6BHhHPG
 bbILhBXndI/z35JuPwjHlPukt3E1CDV9WdzYGDGK/vr3M9d/oGhp6e/Bb8ysBL4LFr
 1bmMyf+UsLHaiKyt/1bg7wNCRZLFEBuww3/m9RxUUaUEHyFLdNFCxqvQBbxXCC1Cli
 OvnnRv3y1yE74jpqQQz3EVpyad1AANqVwaHlRU4+xRwtoc4pXLR56c0tWsU5wYb0kL
 aRITFCX4PbdPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 EADD2380AC1C; Tue, 11 Mar 2025 19:50:39 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174172263873.214029.5458881997469861795.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 19:50:38 +0000
References: <20250307182151.3397003-1-willy@infradead.org>
In-Reply-To: <20250307182151.3397003-1-willy@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Headers-End: 1ts5cF-0002kQ-By
Subject: Re: [f2fs-dev] [PATCH 0/4] f2fs: Remove uses of writepage
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
Cc: linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  7 Mar 2025 18:21:46 +0000 you wrote:
> I was planning on sending this next cycle, but maybe there's time to
> squeeze these patches into the upcoming merge window?
> 
> f2fs already implements writepages and migrate_folio for all three
> address_space_operations, so either ->writepage will never be called (by
> migration) or it will only be harmful (if called from pageout()).
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/4] f2fs: Remove check for ->writepage
    https://git.kernel.org/jaegeuk/f2fs/c/448a834f89ad
  - [f2fs-dev,2/4] f2fs: Remove f2fs_write_data_page()
    https://git.kernel.org/jaegeuk/f2fs/c/6ad3ddbee892
  - [f2fs-dev,3/4] f2fs: Remove f2fs_write_meta_page()
    https://git.kernel.org/jaegeuk/f2fs/c/3b47398d9861
  - [f2fs-dev,4/4] f2fs: Remove f2fs_write_node_page()
    https://git.kernel.org/jaegeuk/f2fs/c/7ff0104a8052

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
