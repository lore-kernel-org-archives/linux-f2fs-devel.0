Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A7CCCA472
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Sep 2025 22:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rFkjPSy0NfXlDdGuslq6QUpgxwc4601207JKRTUrb4o=; b=cOtG6BZCPFWiYfjCLTcecRC8ym
	rhfsO+mxML6rVBo3gS7DNYGs1gjvCx5pLCYvAOQisJrd35yrzHyOd2wuPk3aOabTBFrCpr4puF4D2
	4yWIsvV0u8rKy3ABuEZ4unaWF0cSxJz8CXNTORAFDBcDrt30z4XrNvyCMdCdz9LYuCak=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v3MOR-00035G-5s;
	Mon, 29 Sep 2025 22:30:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1v3MOP-00034c-J0
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Sep 2025 22:30:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iXE90ky7Quftck/MUgbnvLodvVwqSvlZYFqKU6/8VBI=; b=jKMfezh0VeUmz2kCjxVIkf3g9H
 FRJZpw0SNb/5ATT9WqUUi9rEK4u28SYjWqbQOObMX0Wo1tjMd5f3ag4q4WBaDQ8dvzj+x8fNT2HSI
 7OekBB5FPd/iVKdVFWFk6O1dMjWq/CQ3207izMuWgPcuJSD/R0IYQkJAU7Lxy7vIty98=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iXE90ky7Quftck/MUgbnvLodvVwqSvlZYFqKU6/8VBI=; b=O5rM0ewqar9TaLUPeiSxOwCvfn
 ziKlLMeo6eX8HqD6h4dw82ULrCfLYN4G21JT2v8KLu9EWojOWmz8bDtQanAm8Gh1V3gp8xQiuU4gD
 tHtkiBhBNFm9sOa1H1zqiRAB+fTsB3id835mmrBHWwUtyOregnugx9IoyaTqck768tCQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v3MOP-0005Oa-SV for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Sep 2025 22:30:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B58648CC2;
 Mon, 29 Sep 2025 22:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702EEC113D0;
 Mon, 29 Sep 2025 22:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759185039;
 bh=AIcbCskBdQBLXM9s9cL/7RuDAW5V8Hs8aLASHQLwq+o=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=o5FcTmb+cydviXjCgSR4RNiD4Rjp/JAeXL4aLUCWYk/EM7g9O4Xr1Opmlral/azDO
 U9lsvpXCVctV1qtO6hZ2bFR0Dn9dkYU5xo/Aw6oy38jm+T8JpUKNDVjAqLquN/l5WW
 k4lCXAV1V+HdXOU9c10LfuS/gDzDrxJ+BWQw5//OMAReFJClux5GHPS5XZpzC/Mt0B
 JzCPn9xYoFFbaFDb9VzMGlqIY6n9bfic3N+on/NdQjV3/qCCGIPTtDb+dlwEfR57iG
 0eSVaa2wWx0Qhli7a3rfWkDEtzaAsm3oxmWBaS0h787I/w5FsSnu9RzuKpr1fXAzkl
 GWPZcxhNuhVUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33AF339D0C1A; Mon, 29 Sep 2025 22:30:34 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <175918503274.1733438.18125084752996627880.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 22:30:32 +0000
References: <20250928102422.300429-1-chao@kernel.org>
In-Reply-To: <20250928102422.300429-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1v3MOP-0005Oa-SV
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix UAF issue in f2fs_merge_page_bio()
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
Cc: jaegeuk@kernel.org, JY.Ho@mediatek.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 28 Sep 2025 18:24:22 +0800 you wrote:
> As JY reported in bugzilla [1],
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> pc : [0xffffffe51d249484] f2fs_is_cp_guaranteed+0x70/0x98
> lr : [0xffffffe51d24adbc] f2fs_merge_page_bio+0x520/0x6d4
> CPU: 3 UID: 0 PID: 6790 Comm: kworker/u16:3 Tainted: P    B   W  OE      6.12.30-android16-5-maybe-dirty-4k #1 5f7701c9cbf727d1eebe77c89bbbeb3371e895e5
> Tainted: [P]=PROPRIETARY_MODULE, [B]=BAD_PAGE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> Workqueue: writeback wb_workfn (flush-254:49)
> Call trace:
>  f2fs_is_cp_guaranteed+0x70/0x98
>  f2fs_inplace_write_data+0x174/0x2f4
>  f2fs_do_write_data_page+0x214/0x81c
>  f2fs_write_single_data_page+0x28c/0x764
>  f2fs_write_data_pages+0x78c/0xce4
>  do_writepages+0xe8/0x2fc
>  __writeback_single_inode+0x4c/0x4b4
>  writeback_sb_inodes+0x314/0x540
>  __writeback_inodes_wb+0xa4/0xf4
>  wb_writeback+0x160/0x448
>  wb_workfn+0x2f0/0x5dc
>  process_scheduled_works+0x1c8/0x458
>  worker_thread+0x334/0x3f0
>  kthread+0x118/0x1ac
>  ret_from_fork+0x10/0x20
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix UAF issue in f2fs_merge_page_bio()
    https://git.kernel.org/jaegeuk/f2fs/c/edf7e9040fc5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
