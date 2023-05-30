Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8F1C7EE2E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 May 2023 23:40:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q48x8-0006QJ-Vs;
	Tue, 30 May 2023 23:40:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1q48x7-0006QD-JG
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 May 2023 23:40:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r05l6guammarAlZ9k/Y8Xf8kRDHYnfZVPArE1+wigG8=; b=QPooVus6mymClYWVOgJ6p8FVXa
 B2eh/zqrSqlU8zAaWECUsKZVwkdfERfrUliCLxgDFDh2ArWseKbZEsZjyjyzqf61UV5PIJdgILirt
 hf4VfrcxBoFq+i9dukuIWn/NbN2e3D0iZ6MbllUHATwPtnDooKP4JcR5dVol6t/RFChk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r05l6guammarAlZ9k/Y8Xf8kRDHYnfZVPArE1+wigG8=; b=L265mBFM+VBb6fggTunN1wBuHe
 VuOxlVhcThq+yIySwXcXpxoow0DbGFC2iy4IJw2XEg2DByBNf3L7UWRu1Q2qwWiUAYJxMDIP9dXwI
 hnB2Y/1nmwBE9bvvCYBggvirw5318zTzHhoQ9PcrsuI+1xtE9QebsveXB7kmUK3h74HU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q48x4-0000NL-4P for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 May 2023 23:40:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BBA0963538;
 Tue, 30 May 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DF72C4339B;
 Tue, 30 May 2023 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685490024;
 bh=NbVJnIWsVlIURPyBpA3Lby5LZNxGV0r+iqlqJl6ahYA=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Zr0kvzpeMIl43tHFAXn9pvEltKpVsacwIAhdfHRtLy15frJ6YZzKyA/CFbW51bgvV
 1MJc1wh6KoNZ/EgwJU61VZWTy4xjrxiD93akf+3SHfr00mdi2nOQc+9nvwGbOanIpa
 B5mKBcKyRc9syYeGKKXgU7ZkB/n8+1G8g6vRUYMPdtKHiMtcB2Jd3zJKJIwf5gSFLk
 uRbbVFu/P/gJPUXg4V0DGoBI1qUAaonDiwELCAklF+WGGNycxug1emElrKWqwu0cLG
 Gi+bvqm9+0KF1mhqrI1QNo9ga/qKFvQT6p4F4AMQp4GXuvSvh4qKqgy/Tt/kN6vQTx
 L37A0ngLiXESQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 0647AE52C03; Tue, 30 May 2023 23:40:24 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168549002402.8773.6116896933670248806.git-patchwork-notify@kernel.org>
Date: Tue, 30 May 2023 23:40:24 +0000
References: <20230523035822.578123-1-chao@kernel.org>
In-Reply-To: <20230523035822.578123-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1q48x4-0000NL-4P
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't reset unchangable mount option
 in f2fs_remount()
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
Cc: jaegeuk@kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+d015b6c2fbb5c383bf08@syzkaller.appspotmail.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 23 May 2023 11:58:22 +0800 you wrote:
> syzbot reports a bug as below:
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#1] PREEMPT SMP KASAN
> RIP: 0010:__lock_acquire+0x69/0x2000 kernel/locking/lockdep.c:4942
> Call Trace:
>  lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5691
>  __raw_write_lock include/linux/rwlock_api_smp.h:209 [inline]
>  _raw_write_lock+0x2e/0x40 kernel/locking/spinlock.c:300
>  __drop_extent_tree+0x3ac/0x660 fs/f2fs/extent_cache.c:1100
>  f2fs_drop_extent_tree+0x17/0x30 fs/f2fs/extent_cache.c:1116
>  f2fs_insert_range+0x2d5/0x3c0 fs/f2fs/file.c:1664
>  f2fs_fallocate+0x4e4/0x6d0 fs/f2fs/file.c:1838
>  vfs_fallocate+0x54b/0x6b0 fs/open.c:324
>  ksys_fallocate fs/open.c:347 [inline]
>  __do_sys_fallocate fs/open.c:355 [inline]
>  __se_sys_fallocate fs/open.c:353 [inline]
>  __x64_sys_fallocate+0xbd/0x100 fs/open.c:353
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: don't reset unchangable mount option in f2fs_remount()
    https://git.kernel.org/jaegeuk/f2fs/c/c12f1bf28196

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
