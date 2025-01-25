Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45259C02181
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Jan 2025 01:20:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tbUqR-0005OK-NY;
	Sat, 25 Jan 2025 01:20:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1tbUqO-0005OE-Gd
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jan 2025 01:20:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ywfWVCRmBuzI9/CFzvLEtqTwD5TNAFqAJPpYA35lIyk=; b=gUQYTO3d4mG580tNg9NdjxQSe8
 K8j5sNVHAwnQM3bvTm8B6pdQYLiE5QkmRv+IsgyQzkrkAgdIFE1qttD4LD/Z7Tvctr/yCMSkQYVn1
 +Rah7EH3l/7OdjmLw5wWFj3e+kzqjgs1o9Eds2tjh5Exv/v8XjkzucvzK8rSPCT1mdoA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ywfWVCRmBuzI9/CFzvLEtqTwD5TNAFqAJPpYA35lIyk=; b=QxniZQId5CbLBHIhbaSM3a93s2
 rmEUIyqamgYQy3JFpPUT6t164OHup5ZlJaEsf04rmxnLVDXZkgQj9b5DEhiHgC6VnT6vSqyveC+fu
 SxV3zz0Y1aFC1QlZoqGdw+N0miVhSrhECIWyJgaK54IZ3JecOzKmGacBXVGOe3BfwNkw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tbUqN-0001lm-9m for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jan 2025 01:20:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A4B195C5ADB;
 Sat, 25 Jan 2025 01:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89524C4CEE1;
 Sat, 25 Jan 2025 01:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737768004;
 bh=nutvGNIkKEz4gbsW7HF0bd5iw8lyBvTI3VbocdOzGFo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=gsoere13jSFyZ0Ep2YyPcV5lFnzVlNYlW0Ag2tmtOe6lz8crgoDxdKFh1uWDihtYO
 W2LovnW3W6PFDNdbBxhEO1ASzQINwHSBbAM+ahttqqtVFyG3EZ+a6ryN530C6kYEWD
 pKBNMp7MbJcIRSlKG0pJh3Yx/DkP/lanS0lFmI4Zq5g2QeuyLBK35IJllRpJ99w2/w
 lTEX/7nBspZv9zJRoEVaqsHjMHHRnWpyAFXNE3pct3z1CmMrdOA5afj3hyAmjdeCTu
 358hPuqHJry4RL61nTOGHWszBZNCgMVff18YfN0g4OAKM2Zx++imfClIEuZPt8KH5E
 L/T8rGRY+G3Ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 AE0F9380AA79; Sat, 25 Jan 2025 01:20:30 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <173776802950.2231594.13552564580598358004.git-patchwork-notify@kernel.org>
Date: Sat, 25 Jan 2025 01:20:29 +0000
References: <20250124055751.283198-1-huangjianan@xiaomi.com>
In-Reply-To: <20250124055751.283198-1-huangjianan@xiaomi.com>
To: Jianan Huang <huangjianan@xiaomi.com>
X-Headers-End: 1tbUqN-0001lm-9m
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix inconsistent dirty state of
 atomic file
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
Cc: daehojeong@google.com, jnhuang95@gmail.com, linux-kernel@vger.kernel.org,
 yudongbin@xiaomi.com, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, wanghui33@xiaomi.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 24 Jan 2025 13:57:51 +0800 you wrote:
> When testing the atomic write fix patches, the f2fs_bug_on was
> triggered as below:
> 
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/inode.c:935!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
> CPU: 3 UID: 0 PID: 257 Comm: bash Not tainted 6.13.0-rc1-00033-gc283a70d3497 #5
> RIP: 0010:f2fs_evict_inode+0x50f/0x520
> Call Trace:
>  <TASK>
>  ? __die_body+0x65/0xb0
>  ? die+0x9f/0xc0
>  ? do_trap+0xa1/0x170
>  ? f2fs_evict_inode+0x50f/0x520
>  ? f2fs_evict_inode+0x50f/0x520
>  ? handle_invalid_op+0x65/0x80
>  ? f2fs_evict_inode+0x50f/0x520
>  ? exc_invalid_op+0x39/0x50
>  ? asm_exc_invalid_op+0x1a/0x20
>  ? __pfx_f2fs_get_dquots+0x10/0x10
>  ? f2fs_evict_inode+0x50f/0x520
>  ? f2fs_evict_inode+0x2e5/0x520
>  evict+0x186/0x2f0
>  prune_icache_sb+0x75/0xb0
>  super_cache_scan+0x1a8/0x200
>  do_shrink_slab+0x163/0x320
>  shrink_slab+0x2fc/0x470
>  drop_slab+0x82/0xf0
>  drop_caches_sysctl_handler+0x4e/0xb0
>  proc_sys_call_handler+0x183/0x280
>  vfs_write+0x36d/0x450
>  ksys_write+0x68/0xd0
>  do_syscall_64+0xc8/0x1a0
>  ? arch_exit_to_user_mode_prepare+0x11/0x60
>  ? irqentry_exit_to_user_mode+0x7e/0xa0
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: fix inconsistent dirty state of atomic file
    https://git.kernel.org/jaegeuk/f2fs/c/03511e936916

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
