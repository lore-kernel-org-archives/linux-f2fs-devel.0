Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077DDC83F34
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Jul 2025 20:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VPrIWk1dtKDReKmf0w9DlZChHcAeFwSq//KBAN/oyDY=; b=cPkdJJh8SDBRe7x1EmjPmM4ch/
	2jepB06H0fHLLwEjycYdlPCd9G0+dJpaVtzmsBGW/J6AChi0V5MdChonkmJsaXvPUpDkzH9dDy30G
	e5BIZOCBG6wLA5Qd7D5OClft5heXp24MPwouHFvUEgF64emJrkvJlN7Eo0h2rtMwoEWo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ucrYf-0008D3-62;
	Fri, 18 Jul 2025 20:19:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1ucrYc-0008Co-Sy
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Jul 2025 20:19:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0cbpavY8y/5a5rmij+tXZ7nrBIEnecf+ybv4aWnVMpk=; b=Qc4DdAANBAbWzGOLTQMa8VRHm1
 Yr4nYXQvPGUfpxcyy7eGPAAOTAnDcZRjeL5aRsUiQMs3RgLeUoVhzkWd182uCm9ZwX91wAQD3nKAQ
 tDYvDsCU//9P6XehoUhUvEwwf4EwHo0nT+gWqBD6bSr7Co00Z5dJ8hzzhOHXW1jQMn5A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0cbpavY8y/5a5rmij+tXZ7nrBIEnecf+ybv4aWnVMpk=; b=F05jxV3tHXJuVac0LeaAu0l3wO
 nSu9rUq6V8MNRU+clvUXZTL6470jZieTzTmVdJhrwyypx3t0Fb7Q/Ui43ALPm6WuVCxIz4RYp0cUC
 WtEDrHQxadngDK6uOJ5tQcNcOJFlRZ6xTm+FRcfdNjL6V2W1sIWsPlvP9Xz+WgzyOKyw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ucrYd-0000NL-5d for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Jul 2025 20:19:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 44B794554A;
 Fri, 18 Jul 2025 20:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0A0C4CEEB;
 Fri, 18 Jul 2025 20:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752869985;
 bh=XWmDS6JXJ6Es21ByrYmiuMAoDYE5NCGc//PkQjiLRhg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=cwB9od/t5oWHuMhPz2qvea0NQZ/GHlnmBHeqzMXSkDBGWOS0W0zzMVDPQX2I6PN+P
 7yKb2h3IJqbucI7FU+UMpTUH9URFiE2Y48OUZY3vUxzP1LT26UujM1lxCdDGef7beL
 i33+PKHdDr9yc71Q7i27ukzGk/r/5Q8KGREefEqZfsadZ6MXudnjZiCmEG1Ao5Cuht
 jVa3GothQFPnEensyAgr02eOl29pufm0sg1M7bU0lHdWkOBibtpYV/caWB29ttlacq
 0X6izL2PZoH08SVV9GlUIrFnVf9bdcyVGl2og/tJY7fckXe6ky1WbTel5GknT0jndw
 ZFhTiRSFc4IFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 EAC05383BA3C; Fri, 18 Jul 2025 20:20:05 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <175287000476.2782346.18225378290339645502.git-patchwork-notify@kernel.org>
Date: Fri, 18 Jul 2025 20:20:04 +0000
References: <20250717132633.1339965-1-chao@kernel.org>
In-Reply-To: <20250717132633.1339965-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1ucrYd-0000NL-5d
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid out-of-boundary access in
 dnode page
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
Cc: r772577952@gmail.com, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, stable@kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 17 Jul 2025 21:26:33 +0800 you wrote:
> As Jiaming Zhang reported:
> 
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x1c1/0x2a0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0x17e/0x800 mm/kasan/report.c:480
>  kasan_report+0x147/0x180 mm/kasan/report.c:593
>  data_blkaddr fs/f2fs/f2fs.h:3053 [inline]
>  f2fs_data_blkaddr fs/f2fs/f2fs.h:3058 [inline]
>  f2fs_get_dnode_of_data+0x1a09/0x1c40 fs/f2fs/node.c:855
>  f2fs_reserve_block+0x53/0x310 fs/f2fs/data.c:1195
>  prepare_write_begin fs/f2fs/data.c:3395 [inline]
>  f2fs_write_begin+0xf39/0x2190 fs/f2fs/data.c:3594
>  generic_perform_write+0x2c7/0x910 mm/filemap.c:4112
>  f2fs_buffered_write_iter fs/f2fs/file.c:4988 [inline]
>  f2fs_file_write_iter+0x1ec8/0x2410 fs/f2fs/file.c:5216
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0x546/0xa90 fs/read_write.c:686
>  ksys_write+0x149/0x250 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf3/0x3d0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid out-of-boundary access in dnode page
    https://git.kernel.org/jaegeuk/f2fs/c/026e81230291

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
