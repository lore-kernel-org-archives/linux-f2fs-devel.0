Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF17D339AB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Oct 2024 17:40:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t5Tjc-0005Vu-G1;
	Mon, 28 Oct 2024 17:40:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1t5Tjb-0005VY-BT
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Oct 2024 17:40:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tic3UHisuh8y4cF26AdL65Tsj2puwqtNnvOFAki07d4=; b=lal3Kr8jMuPPNL1JMmZ8AsH2VN
 6jMtgKANmLtPxyg/r5yOpO4X6SoLpc6E0j5+00DHj0jyC3sqiWeEE2PE97FakDBq2G5VEvZv3rbLb
 VGNk/TVGBmKgUCl0Hyzh6OKROWNsfOI30A1mGiFAHLnbDYuWglmcTZUBKguFNWc72+b8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tic3UHisuh8y4cF26AdL65Tsj2puwqtNnvOFAki07d4=; b=Z7Ri+UuObdJBLtkPR3Z6yTtgSg
 IGtNF0+mcIsIFpHEmJ/x2WAIEX6hJH9rNR785kby39466WB9yM02eacg3XjGZo6D1UoL/hHjAnOe0
 cLVPStDSJkigX6qM4q5XnLrgjIgYWiacUz8b25chkgg4w3XAgpGhSZGuxv5m/lxsvsPs=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t5Tja-0005IX-Ni for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Oct 2024 17:40:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id F08A7A42A31;
 Mon, 28 Oct 2024 17:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D0CC4CEC3;
 Mon, 28 Oct 2024 17:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730137243;
 bh=0e6mh1pPRvBQrevYXf0NwQRU0jj/QaQLKxi7HwBRBSQ=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=UM6aALquUPYQTkzoE6ENq9nFPI5r+s2F2rXv1hfX6H/tzAMFKHj7FPsRWp1AeLZ3C
 qfw6M+MIo2tLrfa+PNj4A65XX0XmV4Zj5Ad+nKCcUDxzqIynDZCXcabcgZJiXFG/gv
 QFqWwJS5z6KmhTWVlSEigeKqdqSOiVixrG9d5OFj3zUntW01DF+fyHNu80AkfLn57c
 8QjHSC81FibQke8MAG7as3io5/ApKpAG9MAswWeWv3PahSYzNhRBeLCsFsEcgUCoiE
 AMEuwaNkfi43H2HvwrvuNLeq58qvePIrlW/vqnEIOc0lbe08sAOps4xjyEOC8R2V4y
 qsp0a3L7yeh9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 EAC6D380AC1C; Mon, 28 Oct 2024 17:40:51 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173013725051.126843.7852092128381308948.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 17:40:50 +0000
References: <20241015034339.3244676-1-chao@kernel.org>
In-Reply-To: <20241015034339.3244676-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1t5Tja-0005IX-Ni
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to account dirty data in
 __get_secs_required()
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, drosen@google.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 15 Oct 2024 11:43:39 +0800 you wrote:
> It will trigger system panic w/ testcase in [1]:
> 
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/segment.c:2752!
> RIP: 0010:new_curseg+0xc81/0x2110
> Call Trace:
>  f2fs_allocate_data_block+0x1c91/0x4540
>  do_write_page+0x163/0xdf0
>  f2fs_outplace_write_data+0x1aa/0x340
>  f2fs_do_write_data_page+0x797/0x2280
>  f2fs_write_single_data_page+0x16cd/0x2190
>  f2fs_write_cache_pages+0x994/0x1c80
>  f2fs_write_data_pages+0x9cc/0xea0
>  do_writepages+0x194/0x7a0
>  filemap_fdatawrite_wbc+0x12b/0x1a0
>  __filemap_fdatawrite_range+0xbb/0xf0
>  file_write_and_wait_range+0xa1/0x110
>  f2fs_do_sync_file+0x26f/0x1c50
>  f2fs_sync_file+0x12b/0x1d0
>  vfs_fsync_range+0xfa/0x230
>  do_fsync+0x3d/0x80
>  __x64_sys_fsync+0x37/0x50
>  x64_sys_call+0x1e88/0x20d0
>  do_syscall_64+0x4b/0x110
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to account dirty data in __get_secs_required()
    https://git.kernel.org/jaegeuk/f2fs/c/1acd73edbbfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
