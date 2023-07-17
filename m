Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23E1C001DF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Jul 2023 17:34:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qLS7F-0003jV-4T;
	Mon, 17 Jul 2023 17:34:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qLS7B-0003jI-7Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Jul 2023 17:34:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EaIUUArNndxw22B9CYfbVBEQNs1aVPnk2w4Zcu3R/44=; b=XfICRbwvM72jbhWAFVps+oxJXJ
 IDQwouKZsEUZDjkDCcrMfKH2bpMMlWRJgOIWTzJBIhleEdi0T8WcH6pUo35vZl5r/4Y60sR0LEU2o
 lIy9slIONepULcnJbLzuPmQwDwU7rGqerYaG0/389wiUv0cdYLVoA54CGIz9bc+UjW1Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EaIUUArNndxw22B9CYfbVBEQNs1aVPnk2w4Zcu3R/44=; b=NCHKYR4KCda3o39LOe0U2ox919
 kFFzMUi+MUOp/derZJLzo0kSdc0ZdeAK86N9nHiK0b1syLgfi82pGUrUxcHPR4HgnBjH+f2cyI7gT
 esz0Wkc1ovWkPoWAPDZkefXY0BNuKizLtx8/fBoNzrFO7QY3JbAWlri5wqWdA+8dUZFc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qLS7A-00AvFI-L6 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Jul 2023 17:34:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1D5EF611AB;
 Mon, 17 Jul 2023 17:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08AF9C433CB;
 Mon, 17 Jul 2023 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689615262;
 bh=H4YvqdwXcs9eWwYRBHtp/bsnkn4MD/1phpJSu1I1qso=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=iMCRy6Piwp7fJc2J5aqFnZYSidIGFYUyZ5PRUUV5uDT/is62H9cFM4TQDnP+lvs0y
 +w/5GH4Zxz8bLmd13kzbamExWkL1QDyG+/b1s8tSCXdICFFBxhBoMWI74iju5wmR3l
 PJN6ifUw6p5AhI5kXLNAx65wCL6niHBbpWzgpOYPkwq3BkrvgJBC3wQvr1kPjeIp8X
 LqAPvlRjKZ9gDy90GlIByfhaNCwP/oHt5/xLYTdmsKn+l+bsejyATYLzCL3a3uzYDV
 Sv0Q14UTacYpem5dziUAZL1U+1c8h92+zYlASPxNrQDHZn7rhVYRVe+oKnzHWHrvWA
 +h1656MyBgkKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 D99CBE29F33; Mon, 17 Jul 2023 17:34:21 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168961526188.4078.2630269781392789426.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jul 2023 17:34:21 +0000
References: <20230707141142.2276510-1-jaegeuk@kernel.org>
In-Reply-To: <20230707141142.2276510-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1qLS7A-00AvFI-L6
Subject: Re: [f2fs-dev] [PATCH] f2fs: flush inode if atomic file is aborted
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
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+e1246909d526a9d470fa@syzkaller.appspotmail.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  7 Jul 2023 07:11:42 -0700 you wrote:
> Let's flush the inode being aborted atomic operation to avoid stale dirty
> inode during eviction in this call stack:
> 
>   f2fs_mark_inode_dirty_sync+0x22/0x40 [f2fs]
>   f2fs_abort_atomic_write+0xc4/0xf0 [f2fs]
>   f2fs_evict_inode+0x3f/0x690 [f2fs]
>   ? sugov_start+0x140/0x140
>   evict+0xc3/0x1c0
>   evict_inodes+0x17b/0x210
>   generic_shutdown_super+0x32/0x120
>   kill_block_super+0x21/0x50
>   deactivate_locked_super+0x31/0x90
>   cleanup_mnt+0x100/0x160
>   task_work_run+0x59/0x90
>   do_exit+0x33b/0xa50
>   do_group_exit+0x2d/0x80
>   __x64_sys_exit_group+0x14/0x20
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: flush inode if atomic file is aborted
    https://git.kernel.org/jaegeuk/f2fs/c/eb4ebfac51db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
