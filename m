Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1875DCA1005
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  2 Sep 2025 20:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=grHsB18i8SAzWT5HGvzuuME1qVsPu8J4NMerhKOSKOQ=; b=hcXJXYkROXO5aZsbgVnQGqP5n9
	07C6e+OHYVMg1vvmwNc/nJD7HuzCmy6qJcd1XbN6vso0ZdhktkHM6WcZykt3ewOeCTBpyZDfYhY+2
	bCNmjEW+ZdtedM5Lm5ff2ToEHcwc1/OGGgPT6IHyDTu08GwnYBYpZ2/7vpslEvzwFvP4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1utXUB-0006ak-1l;
	Tue, 02 Sep 2025 20:20:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1utXU9-0006ae-Tu
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 02 Sep 2025 20:20:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G8rGqZyU324u76ItPG+i6tY/U/lJxJRVxTWjmIn1sNk=; b=UTtLWnmKCAgudbqPUfFyaiLiN2
 Ok/6Za20vVU6a57AKU3Jc0SP6/ykeZzN0arS1o+MC4QflFWpY2+uHCPBZZBL5C7dWURxnGJapHSHu
 jjRHyXi0M+ZMECsrlcDPeGJ3ihiQbdmstVYMQrI0166P7EAorC8sChI6JX4o98esNeHo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G8rGqZyU324u76ItPG+i6tY/U/lJxJRVxTWjmIn1sNk=; b=N8xbyLOo1MiC+6FsNmXfX4dw/7
 AiFxdWDULJEJzOV/D43CKsO5SU4NEObRc5JLv4gR0daNehdUGV++hGt3ERNhD94NqvSJn2MAD1EZE
 IY++hFTwb613sY1AtgEBQ7iT68cSEzGbsYbDEnPLmDpCUvEGJRHsHfGM6dSvT2YqGCPU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1utXU8-0004AW-LU for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 02 Sep 2025 20:20:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 53D2244B5C;
 Tue,  2 Sep 2025 20:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB3EC4CEED;
 Tue,  2 Sep 2025 20:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1756844403;
 bh=RQup03V63i7JEJuwQszfY9xKRSyVG3eKOhMwJxz9NC0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=XKJDGi4aRNKN8F3wJFCxTbqydOZbTXfKRa747xXMRHo6j+qAMKYMFbvOtfJjCsvAe
 6qou6xouMp9nCNhuhwDgEIToRpjDzR/oVfpvcBbsAnW4+F6VzGATvASG6li5ivqzj9
 prUjAZG3TGnkPpPXNUUoDhFJOUHSY/9FbBbPFQTe6G8D5lgqJ6fsFrnrPk3Y46HNak
 CUK7yxXp11CKlBdnhzEATEa1730nHHSOfM3+nK85kdxxPSpXZrTMGAvPPEmsqBUy/U
 4pSf93w5i3D6SOtnUyUzzueyzTGomNcmw5tce5PdDqAGiJOKGfskTMD7ppvxRKX70v
 4m56yqS+e9HLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 AE6CF383BF64; Tue,  2 Sep 2025 20:20:09 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <175684440854.425353.17772733460715458985.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 20:20:08 +0000
References: <20250823054534.41037-1-chao@kernel.org>
In-Reply-To: <20250823054534.41037-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1utXU8-0004AW-LU
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to do sanity check on node footer
 for non inode dnode
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
Cc: syzbot+b9c7ffd609c3f09416ab@syzkaller.appspotmail.com, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, stable@kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat, 23 Aug 2025 13:45:34 +0800 you wrote:
> As syzbot reported below:
> 
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/file.c:1243!
> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 5354 Comm: syz.0.0 Not tainted 6.17.0-rc1-syzkaller-00211-g90d970cade8e #0 PREEMPT(full)
> RIP: 0010:f2fs_truncate_hole+0x69e/0x6c0 fs/f2fs/file.c:1243
> Call Trace:
>  <TASK>
>  f2fs_punch_hole+0x2db/0x330 fs/f2fs/file.c:1306
>  f2fs_fallocate+0x546/0x990 fs/f2fs/file.c:2018
>  vfs_fallocate+0x666/0x7e0 fs/open.c:342
>  ksys_fallocate fs/open.c:366 [inline]
>  __do_sys_fallocate fs/open.c:371 [inline]
>  __se_sys_fallocate fs/open.c:369 [inline]
>  __x64_sys_fallocate+0xc0/0x110 fs/open.c:369
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f1e65f8ebe9
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to do sanity check on node footer for non inode dnode
    https://git.kernel.org/jaegeuk/f2fs/c/c18ecd99e0c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
