Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7976BC3ABCE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Sep 2024 21:30:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sqJJ7-0004WI-Cd;
	Mon, 16 Sep 2024 21:30:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sqJJ6-0004W0-BB
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Sep 2024 21:30:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ckTPNe2iY4y46eWxjDO9lx6IeKlSAc3w5bEwhDytWhA=; b=E7wlQLHMCMZvSimupqiJbltsMM
 vGESOyCN8WvN+demBYLKF7TZDagVrGObI+uvwLKjXwRiap3BheGvZpRcYLON9w4a5ks8jl6mh+W+J
 JAiaI4k7in+41RtRW8/2/H/0datYSsV/6qY6xIsLpiB8KwPFW18YvDYGPktbTQS/X3oY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ckTPNe2iY4y46eWxjDO9lx6IeKlSAc3w5bEwhDytWhA=; b=W2xo9hFsvmFzoiyVTMb5ymjw39
 OO0UvWdjVnrTP8zv/rzKi/Awp6bepfvsEXEEzYCWOFOaPeQlxCC+qkbC7Xyk/XvZkLKfJU6rskmZJ
 3fUw2NYLdryLEPv0gQgmmGs/9OshaTVMXtOo6pWzjnY1hnq8di67nIcjKBA3jQwEb8yw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sqJJ6-0000PM-Dq for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Sep 2024 21:30:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5EC065C0652;
 Mon, 16 Sep 2024 21:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2678C4CECF;
 Mon, 16 Sep 2024 21:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726522241;
 bh=tSD8XJAuZN/iamujVj5Yupc0eKiuu2Cf1U7jWiweoN4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=m3eZyCaE3qsmseZJ+YPEJmlcxBLgn3LxeJuehfAvzApu50uYhurgbaVvPoOQ3Dg9M
 FKCsDNkfWXELYsPo/SsWDWWLkkLeuIesVWFPshhuWwDp75Wwd/YqnypJIaQH6MoJ86
 2KQEPqE56lwAOlYsUfyvQLz5jH4OcyOi14ypBNm8sxpI5pvjDsY3jHt3BLmKG21qKR
 ZwK32vmjkkvCM70stdaa6+suEsFR/5/MexNyIjIhGBpFoN5wCF+5iwoJHFErSXk6hm
 9h+UVdJUhHtz0JJIGKH8gnT/wL6lZun5ohEHwxnuoS87IG8f5+7JXxNp+FGazZrb0K
 RmPugBKisanng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 ADD123806644; Mon, 16 Sep 2024 21:30:44 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <172652224325.3820990.5977903925076414761.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 21:30:43 +0000
References: <20240910030713.3716318-1-chao@kernel.org>
In-Reply-To: <20240910030713.3716318-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1sqJJ6-0000PM-Dq
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to don't set SB_RDONLY in
 f2fs_handle_critical_error()
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
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
 syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 10 Sep 2024 11:07:13 +0800 you wrote:
> syzbot reports a f2fs bug as below:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 58 at kernel/rcu/sync.c:177 rcu_sync_dtor+0xcd/0x180 kernel/rcu/sync.c:177
> CPU: 1 UID: 0 PID: 58 Comm: kworker/1:2 Not tainted 6.10.0-syzkaller-12562-g1722389b0d86 #0
> Workqueue: events destroy_super_work
> RIP: 0010:rcu_sync_dtor+0xcd/0x180 kernel/rcu/sync.c:177
> Call Trace:
>  percpu_free_rwsem+0x41/0x80 kernel/locking/percpu-rwsem.c:42
>  destroy_super_work+0xec/0x130 fs/super.c:282
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
>  worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to don't set SB_RDONLY in f2fs_handle_critical_error()
    https://git.kernel.org/jaegeuk/f2fs/c/930c6ab93492

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
