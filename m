Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40226C3ABCB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Sep 2024 21:30:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sqJJ6-0002l8-Ti;
	Mon, 16 Sep 2024 21:30:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sqJJ5-0002ku-HP
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Sep 2024 21:30:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V+tT1AJ/9RGmjHH8HVhDbaVOZIwqixtSDvQa79z6sUo=; b=TPRVLfkEZNJOxhWR93yE9bDCnk
 z9+Ok8hlneFPqq1sA81XtiDfdyKqe3gFe1Y0e1NtBO3XG5eeizORVGLGYTULG14xl52yW2nhkby8+
 AlfU4M8TpAZWDXOjm9+uejeBdlD6a7gfKHShwwWFDoUXKxaa53JFjU/a2WyZ9gl5b0ro=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V+tT1AJ/9RGmjHH8HVhDbaVOZIwqixtSDvQa79z6sUo=; b=Hrs848AP8dMX9hsvgewCjtiJlg
 XgO8+qjhirHwWF8rxjy+POindn58MPVyhmntdvBIEDb/J+swHQYBMZGIg9/MRPoOwZLM5HI+N6BcB
 V043MZiIglouLW9Li/+RYXmyDofmi9IT1I9Rgeg0/sGPhmcqlbyCYeiTZquDezrWYpjU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sqJJ4-0000P8-Ui for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Sep 2024 21:30:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DAA245C0628;
 Mon, 16 Sep 2024 21:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E42DC4CEC4;
 Mon, 16 Sep 2024 21:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726522237;
 bh=DA/pGYkMc6X5k091k31gZIzgOwklfjJsQjPwiEsd4/w=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=tobJscG3wXitGqhxu+Nj01wjVddRJRRXzwrOpjDO/iKKsVlu8nfAB5hMpVhtAvllN
 n7fYQsRfO8crdbxxenB2RzTMWFDqjuoP/hJnZDbQ0EUmrONuF2Otad2R6nf/7REZp2
 Yvd5WVE8ZyFByUDkB03ySDvevUZT8whGnvHEtgr8I7/28YWcmEWqvuenzCSqJioIae
 32//jaDlbyJlJns2ARtjs70W5zCNYPSiW6kCpWj0szRi2szO3g38fVpob61+/2vpTM
 a2BqpbCChiE/5olkjX26MxIM5zfBH/awJnpY9hiPG84wyz6D6yPP6xcHrOodGjTeBc
 KXryEi/FtVqFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33BE73806644; Mon, 16 Sep 2024 21:30:40 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <172652223875.3820990.5151598286635393871.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 21:30:38 +0000
References: <20240906062724.3569496-1-chao@kernel.org>
In-Reply-To: <20240906062724.3569496-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1sqJJ4-0000P8-Ui
Subject: Re: [f2fs-dev] [PATCH] f2fs: get rid of online repaire on corrupted
 directory
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
Cc: jaegeuk@kernel.org, syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  6 Sep 2024 14:27:24 +0800 you wrote:
> syzbot reports a f2fs bug as below:
> 
> kernel BUG at fs/f2fs/inode.c:896!
> RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:896
> Call Trace:
>  evict+0x532/0x950 fs/inode.c:704
>  dispose_list fs/inode.c:747 [inline]
>  evict_inodes+0x5f9/0x690 fs/inode.c:797
>  generic_shutdown_super+0x9d/0x2d0 fs/super.c:627
>  kill_block_super+0x44/0x90 fs/super.c:1696
>  kill_f2fs_super+0x344/0x690 fs/f2fs/super.c:4898
>  deactivate_locked_super+0xc4/0x130 fs/super.c:473
>  cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
>  task_work_run+0x24f/0x310 kernel/task_work.c:228
>  ptrace_notify+0x2d2/0x380 kernel/signal.c:2402
>  ptrace_report_syscall include/linux/ptrace.h:415 [inline]
>  ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
>  syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
>  syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
>  syscall_exit_to_user_mode+0x279/0x370 kernel/entry/common.c:218
>  do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:896
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: get rid of online repaire on corrupted directory
    https://git.kernel.org/jaegeuk/f2fs/c/884ee6dc85b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
