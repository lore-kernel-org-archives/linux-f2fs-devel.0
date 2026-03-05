Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF12F47CB9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Mar 2026 19:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h/D5EzoUioDGUCUQkZgLqygqtCaeS0FbW71UdG8O0GQ=; b=NTp5FS39p3mvfP/jdQkDP9Bxuj
	50oh7cVlLbQBTOI/yEyJpge9An4F87rfbc7QwhtHbLnS6lFuJIYyr0DhTkndIjKCZvHuJvnbR70in
	Wj1TcR5eHFxgjYneQ19RsBgQ6B885gnnUn2L8k2GP332TxlsY294PwlT6wjWIAlrYvOk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vyEHd-0001hV-F6;
	Thu, 05 Mar 2026 19:22:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vyEHc-0001hE-1o
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Mar 2026 19:22:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wTJQKHW8A2VsxKG6xIPXzXKhzun8D62opZvaEumK+sA=; b=EE3+ta/vlncfdUHj8ZnqGggG0f
 POhJHwQsSZ7kyjq0F9PG4EGKkHZW/vcNkfe5QnDS45TXmcKX6c8iKOKsaZMIFXKue60cGMQ3ErxW5
 cWhj5gna81FMJhS72O6ZFVXygFztGr+82vK3WQ9ND95mr+j6eIN3VfUwNozdaypxnTzM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wTJQKHW8A2VsxKG6xIPXzXKhzun8D62opZvaEumK+sA=; b=Kv1BG3Okpa/RWfxrcr9RTfuRFk
 KTeDMUs2K9ncQN07Ztvi9KPaSO9tm8Ii3sJbEPG/eJzQiQYr2EY0wLeUOE2kjdArqpxJn9VoL1tDk
 BaEAMibBErnpqdbRGOZKkqISXNgMeWqWc2OP35mLM+bwquhn75k6eELCd9YtsKp+9w5o=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vyE5Z-0001v3-4N for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Mar 2026 19:10:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B1FB844576;
 Thu,  5 Mar 2026 19:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95399C2BC9E;
 Thu,  5 Mar 2026 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772737814;
 bh=sTtAmEsYD8SIEU/qEbBpKUIkBgc/87zAxqhtnY2MpIw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=VRlulZMLdOIPoZVbQYcClldRM9uy1DhMXkCm6dkC8PR0BkFPbj4Znho5zS3r9eMvh
 tPcHqusU8aWW1eUUXczUThK5hmOHJT9qUj0VZM+8Am2Z+JCCNUQlGgf7AbPIrkIERr
 x+IxEfRYYAli7Stq9FOpSkI2kT8spgoWsqMm3dpLG3NebkiUiPV+T8BkuoFrIzfMAY
 RNPbo13LOFzk+gGML9XXBu11SZKn1upKQ83hPdcCMCZTOQpYo25y2JnAeamd3lxfqF
 J15+1QQti7D7mPrpbenPKDLOfKdveL96CT8ieCfdc8OfOImO73eghR6BA7Cu9XjF1S
 xTR48DnAGNDXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B9E483808200; Thu,  5 Mar 2026 19:10:15 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177273781429.3248266.5417972090496758870.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 19:10:14 +0000
References: <20260304082231.599770-1-chao@kernel.org>
In-Reply-To: <20260304082231.599770-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1vyE5Z-0001v3-4N
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid memory leak in
 f2fs_rename()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, jaegeuk@kernel.org,
 syzbot+cf7946ab25b21abc4b66@syzkaller.appspotmail.com, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  4 Mar 2026 16:22:31 +0800 you wrote:
> syzbot reported a f2fs bug as below:
> 
> BUG: memory leak
> unreferenced object 0xffff888127f70830 (size 16):
>   comm "syz.0.23", pid 6144, jiffies 4294943712
>   hex dump (first 16 bytes):
>     3c af 57 72 5b e6 8f ad 6e 8e fd 33 42 39 03 ff  <.Wr[...n..3B9..
>   backtrace (crc 925f8a80):
>     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>     slab_post_alloc_hook mm/slub.c:4520 [inline]
>     slab_alloc_node mm/slub.c:4844 [inline]
>     __do_kmalloc_node mm/slub.c:5237 [inline]
>     __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5250
>     kmalloc_noprof include/linux/slab.h:954 [inline]
>     fscrypt_setup_filename+0x15e/0x3b0 fs/crypto/fname.c:364
>     f2fs_setup_filename+0x52/0xb0 fs/f2fs/dir.c:143
>     f2fs_rename+0x159/0xca0 fs/f2fs/namei.c:961
>     f2fs_rename2+0xd5/0xf20 fs/f2fs/namei.c:1308
>     vfs_rename+0x7ff/0x1250 fs/namei.c:6026
>     filename_renameat2+0x4f4/0x660 fs/namei.c:6144
>     __do_sys_renameat2 fs/namei.c:6173 [inline]
>     __se_sys_renameat2 fs/namei.c:6168 [inline]
>     __x64_sys_renameat2+0x59/0x80 fs/namei.c:6168
>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>     do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid memory leak in f2fs_rename()
    https://git.kernel.org/jaegeuk/f2fs/c/f1139c0b9a5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
