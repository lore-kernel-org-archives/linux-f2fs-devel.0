Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859DAC001B1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Jun 2023 23:40:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qFNj8-00081H-Pr;
	Fri, 30 Jun 2023 23:40:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qFNj3-000814-SE
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Jun 2023 23:40:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xzdMbOc7/RwmHm7oM6LjgnOJg5UJV9EgLTmK0ZM7Q7Y=; b=PshEzfj0SFS/S47tp6jw8aeHQM
 h2XrFLFh5wIwzLZvmf4j0042Kr7d66rdmeyeAOf3Y9P97oBQC5wFur/9LXgCXXgR0b6sYc/2EOHho
 wK0Ow2PV3HXqo+PtTqAgACrBDi0DwJxFIhhWZUomy8d6MhnFwZalAL2vGl5oF7IXRAoY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xzdMbOc7/RwmHm7oM6LjgnOJg5UJV9EgLTmK0ZM7Q7Y=; b=OOH2Y+LInmK7kAuU5Ko9loKxEX
 J4iFBC5miw2By6PieIaN7XKvuddEVSsEZ484yuTfF2Tlp9hP1vsKVqdmH5cih5obZKfizJMeik/e9
 ppW8TaIU+a4F4zbFF5MLxvqnC8P25YQyL258fZ5lsYIE8mznvLWslsXPLxtcXCf5wB8w=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qFNj3-002Wki-GG for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Jun 2023 23:40:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 20B53617A2;
 Fri, 30 Jun 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82B7CC433C7;
 Fri, 30 Jun 2023 23:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1688168423;
 bh=bNCnDb33kESLzDYvWVvfK2jW6oK/8GxvCkD+l1MlPCw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=kj8g45vZw2bOu++ciGtfJT0qqJuV89ttr6ZELTJEmKVgBr8izuBxQ5ldNH1FJuXlx
 WWh3xvC955RuzpcnJKe1aeua754ibT6oWNMHMK9D0ncXW9b9lwxGKsEegcwV+zJ4s0
 6R53Ag4VJjionaK8A+VhBzExxm5LjYmlShs6bL4xpvKQRKPf1HhCubeknr29ZBOuYs
 yMCSnM/VtwxTlHuayo77D1jWa2/DFpzIji2ud5wNby4qGHDg83MhAbTS7P2aJZo4oD
 e5MJHc21Xx2xL7NuucQawt8mkEatqM2/rV2eFihq7kbEbELOxl4OfYbO9WQdsCKI7d
 p0n+T4fGF/bdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 57F2CC64458; Fri, 30 Jun 2023 23:40:23 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168816842335.31915.17270081956061195335.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jun 2023 23:40:23 +0000
References: <20230629111144.3582787-1-chao@kernel.org>
In-Reply-To: <20230629111144.3582787-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1qFNj3-002Wki-GG
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to do sanity check on direct node
 in truncate_dnode()
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 syzbot+12cb4425b22169b52036@syzkaller.appspotmail.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 29 Jun 2023 19:11:44 +0800 you wrote:
> syzbot reports below bug:
> 
> BUG: KASAN: slab-use-after-free in f2fs_truncate_data_blocks_range+0x122a/0x14c0 fs/f2fs/file.c:574
> Read of size 4 at addr ffff88802a25c000 by task syz-executor148/5000
> 
> CPU: 1 PID: 5000 Comm: syz-executor148 Not tainted 6.4.0-rc7-syzkaller-00041-ge660abd551f1 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>  print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
>  print_report mm/kasan/report.c:462 [inline]
>  kasan_report+0x11c/0x130 mm/kasan/report.c:572
>  f2fs_truncate_data_blocks_range+0x122a/0x14c0 fs/f2fs/file.c:574
>  truncate_dnode+0x229/0x2e0 fs/f2fs/node.c:944
>  f2fs_truncate_inode_blocks+0x64b/0xde0 fs/f2fs/node.c:1154
>  f2fs_do_truncate_blocks+0x4ac/0xf30 fs/f2fs/file.c:721
>  f2fs_truncate_blocks+0x7b/0x300 fs/f2fs/file.c:749
>  f2fs_truncate.part.0+0x4a5/0x630 fs/f2fs/file.c:799
>  f2fs_truncate include/linux/fs.h:825 [inline]
>  f2fs_setattr+0x1738/0x2090 fs/f2fs/file.c:1006
>  notify_change+0xb2c/0x1180 fs/attr.c:483
>  do_truncate+0x143/0x200 fs/open.c:66
>  handle_truncate fs/namei.c:3295 [inline]
>  do_open fs/namei.c:3640 [inline]
>  path_openat+0x2083/0x2750 fs/namei.c:3791
>  do_filp_open+0x1ba/0x410 fs/namei.c:3818
>  do_sys_openat2+0x16d/0x4c0 fs/open.c:1356
>  do_sys_open fs/open.c:1372 [inline]
>  __do_sys_creat fs/open.c:1448 [inline]
>  __se_sys_creat fs/open.c:1442 [inline]
>  __x64_sys_creat+0xcd/0x120 fs/open.c:1442
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to do sanity check on direct node in truncate_dnode()
    https://git.kernel.org/jaegeuk/f2fs/c/a6ec83786ab9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
