Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590F2CA0EF3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Aug 2024 20:52:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sk8bN-0001WA-0m;
	Fri, 30 Aug 2024 20:52:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sk8bL-0001Vn-08
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Aug 2024 20:52:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kZburCYcKO9yVQDlUNXoVdJ/BHp5oIRdAGMjJ507TQ4=; b=JzkItDWPpr6gvmW4yyq811PwC8
 cc6o4LE0I9DvyOnllzGK+0aWu485WzxbIbvNrAuMsSM4w6pvI9rDNGVQjnH9jaqJdNjKSjqqSF910
 XvHiFDw2m9uGdN5LX9NE8LgHGd/vPQ+xmpw59dbAJqXTUh8VRJmH+H3Ao0LqbN0odBtg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kZburCYcKO9yVQDlUNXoVdJ/BHp5oIRdAGMjJ507TQ4=; b=KrdjiRXnWZqf3wPrlKqW4xuq19
 Dm/1mB0YU/SpgRquLWTTM2TuDj2xBg+7JDGs0T+7YHuYM/HDqJBs1OJAojkbJKzXz5jKOSKS2/nDX
 uOazxdIZgZuxAMWDQW7uyK5aF35VtM7EXMXy/s9AclqnbUivMVMM6KsF2qVm14XbHZ3Q=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sk8bK-0005oa-CI for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Aug 2024 20:52:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AF3BF5C1025;
 Fri, 30 Aug 2024 20:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3080C4CEC2;
 Fri, 30 Aug 2024 20:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725051119;
 bh=L39tLmzteaMlelknO4XtntQrZCNbukWTk4YH9v898y0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=nCq0ruzJbOdNfxGId2egEJhy6keNoNaQU9/UpoUuHKkRE52mCANKeLWQnooXCX5hH
 21If42pgjCu9e+oV9sp5C9y4sWmoJQOiFrMSUcEJ/exy57gvynV4CDnq2iM1SUncRx
 f8s7XehBmN3Iid/NDmbbDiUeOj7dJWePgFi86aLiY4jJZ+RdEvCdpPWqS9zKBrZIa9
 ce+EaoEweRF/MVlhxhoC0zgptpWbHJX8R7wvncjfCbYMccBT3mEKSAKyqur1P2XRyU
 qpIFYJ/6VTr4WsRciQN75c3eSas6rOFAdln3qUT7j0pAY7p+Ww4Gh1vUEY3rvwnMX8
 18qdSLJ7JtVbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 718813809A80; Fri, 30 Aug 2024 20:52:01 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <172505112026.2712133.17685334156318477673.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 20:52:00 +0000
References: <20240730010855.2942132-1-chao@kernel.org>
In-Reply-To: <20240730010855.2942132-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1sk8bK-0005oa-CI
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to avoid use-after-free in
 f2fs_stop_gc_thread()
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org,
 syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 30 Jul 2024 09:08:55 +0800 you wrote:
> syzbot reports a f2fs bug as below:
> 
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  print_report+0xe8/0x550 mm/kasan/report.c:491
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>  instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>  atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
>  __refcount_add include/linux/refcount.h:184 [inline]
>  __refcount_inc include/linux/refcount.h:241 [inline]
>  refcount_inc include/linux/refcount.h:258 [inline]
>  get_task_struct include/linux/sched/task.h:118 [inline]
>  kthread_stop+0xca/0x630 kernel/kthread.c:704
>  f2fs_stop_gc_thread+0x65/0xb0 fs/f2fs/gc.c:210
>  f2fs_do_shutdown+0x192/0x540 fs/f2fs/file.c:2283
>  f2fs_ioc_shutdown fs/f2fs/file.c:2325 [inline]
>  __f2fs_ioctl+0x443a/0xbe60 fs/f2fs/file.c:4325
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to avoid use-after-free in f2fs_stop_gc_thread()
    https://git.kernel.org/jaegeuk/f2fs/c/c7f114d864ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
