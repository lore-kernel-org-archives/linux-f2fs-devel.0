Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BC3C04AA7
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 Sep 2023 15:50:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qizTV-0001PP-9c;
	Wed, 20 Sep 2023 15:50:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qizTN-0001OO-OP
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 Sep 2023 15:50:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b+ZM3dfJe4wvoXx6thB40LBdatuHeQTQxSawHNecKIU=; b=GdpT66s2YP9BdvPv4rGZ6p0TiU
 PHwV6sdSzM7JNXvtB8q3kmqt0IVlOE0AapibDBuTg9a6iSUEiZPm1FrX7AMzI4Od/59Biic8R+BaN
 L67AWuIiUHca8HBnWOHmT+em2oQDP1Q7Wam+hxA6cDFezfaZvTKxUpR4SkQxrfCZMDtM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b+ZM3dfJe4wvoXx6thB40LBdatuHeQTQxSawHNecKIU=; b=Ycejdghssdo09fdWEXggMNci6I
 SfWoLnTm7bFJbV+va53v9tWtaKTkjVQuvsjkG0ABnD09CVY83UlOMWp2mzcvbsZbZeHKFWfNlZSiG
 O6h+IdOAu99dxERkpnOv0vgyElhgi83ZmFgISGEs/OLBt1CEeyy9q+VlTb4DQ/w4R6gk=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qizTG-0004cK-8M for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 Sep 2023 15:50:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2E2E4B81DE1;
 Wed, 20 Sep 2023 15:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DFC8C433CD;
 Wed, 20 Sep 2023 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695225025;
 bh=5E6/vgeNSXlsDaOqY3PRSrvn+uv7qLRwo9AGA/fIhnU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=OLSHdp+ogP4FIvjxhDedd5cpeI6W6XqV7Ur8CBSaTPOBYxESPvfAspV5crBvC4qiS
 1UjaZsW3INkiTdUJTZ/AqCZovpQFE7PkLlxEJPv1UuAibZSkAThZ1SXEHk4pYrFeIs
 rKsvR2qvY2h0ZCR1qlW6w+dLsbpQs0EdKxeRzrrmYk8mD9kKLuR0eGxDTtN5ddKTLr
 lfu8xe3DGtE8x/o0kyidlyxrFBv7GeFMbERZLCjcMAPYFVVLI9MuCMYAT4ZdV3cdEk
 mcUzDnjoCDHMHMbPnnpm9Pzihit8ZzV0VBPXolBlgp1FFf2dyX40JEq+1PPzegbYY9
 o0YtshVXQy4gQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 4A8DCE11F4A; Wed, 20 Sep 2023 15:50:25 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <169522502530.22557.11815726181069240505.git-patchwork-notify@kernel.org>
Date: Wed, 20 Sep 2023 15:50:25 +0000
References: <20230905045753.24964-1-chao@kernel.org>
In-Reply-To: <20230905045753.24964-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1qizTG-0004cK-8M
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to drop meta_inode's page cache in
 f2fs_put_super()
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org,
 syzbot+ebd7072191e2eddd7d6e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  5 Sep 2023 12:57:53 +0800 you wrote:
> syzbot reports a kernel bug as below:
> 
> F2FS-fs (loop1): detect filesystem reference count leak during umount, type: 10, count: 1
> kernel BUG at fs/f2fs/super.c:1639!
> CPU: 0 PID: 15451 Comm: syz-executor.1 Not tainted 6.5.0-syzkaller-09338-ge0152e7481c6 #0
> RIP: 0010:f2fs_put_super+0xce1/0xed0 fs/f2fs/super.c:1639
> Call Trace:
>  generic_shutdown_super+0x161/0x3c0 fs/super.c:693
>  kill_block_super+0x3b/0x70 fs/super.c:1646
>  kill_f2fs_super+0x2b7/0x3d0 fs/f2fs/super.c:4879
>  deactivate_locked_super+0x9a/0x170 fs/super.c:481
>  deactivate_super+0xde/0x100 fs/super.c:514
>  cleanup_mnt+0x222/0x3d0 fs/namespace.c:1254
>  task_work_run+0x14d/0x240 kernel/task_work.c:179
>  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
>  exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>  syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
>  do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to drop meta_inode's page cache in f2fs_put_super()
    https://git.kernel.org/jaegeuk/f2fs/c/a4639380bbe6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
