Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53EFC27C77
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:56:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sHQKo-0005Sx-Ik;
	Wed, 12 Jun 2024 15:56:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sHQKW-0005SD-Vk
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Jun 2024 15:56:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8vcY0dfwQHcxcTGBYQE6PMl0818Ln+QuzRx00poqgLg=; b=Q4qw8mXKTZ1mG76jiJlr43Fdk8
 6Dlof1i627KIM+gLC9UlMKb4c3JN8RxiXqIghWP9CYibo1b9+sq/BjScTZw9c8MGZVK6aW7ou2GQh
 ro2h00TdndqxuekLV1ezS7ykBvy91leblJrHfyUJ5dUJsLTCtL0vD83jU44wAwBgG+LM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8vcY0dfwQHcxcTGBYQE6PMl0818Ln+QuzRx00poqgLg=; b=gc3LkkOccec76AY7MJZrfp9c1G
 qq+uhKynEW/ijKFxN3G/z4nIWONznFGf9ltJJIlc3rgkUBY/81wC6+A19zdeto96C3aCuxJM5Blz7
 hLK+lL9RWYNArTMcl4rJ8q67enQkORqcwEpb+r86/Uhi695CnlzXwG/O8W6Z6TdXnkWc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sHQKX-0007SD-GK for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Jun 2024 15:56:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6307C614E2;
 Wed, 12 Jun 2024 15:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DAE8C4AF55;
 Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718207757;
 bh=9xEyt5u+0FV1WdcJW4h5qgOf/lShmIROJbiYfAkCp2U=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=tqjqf/CaZet/Ag6j0poWxHb7HiKEaaK5YcB+GOgaujeGm/CTqmmR7Dpwe85nwoQwx
 c+V3kMPqdBP5Myz+65pVxE9oMiIsFN+BmWMtmf5VxY3oM8ksEzKlEKW+DmWNbZ/ku2
 fRhru4Rg96vBywd/pCW4BzWif/u0wRSZeSnfWgdUxLunAclTnW6cs75Go5DXZcAw2Q
 g7YKYNh1qexFpttb3MBCSKwtSuupJSXB6BfjE+gPOUhLGtj6l+dWeCfIVQ3z3mNFcv
 XYN2CjEu7HC5eZuPCf3f7G3R1emFMsBGz9nJm11Ps9Q3llkAWvIl0kTwNfVqd5AdBU
 sDaj/b6+rK7QQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 3FEEEC43616; Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171820775725.32393.9431930880169031046.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 15:55:57 +0000
References: <20240603010745.2246488-1-chao@kernel.org>
In-Reply-To: <20240603010745.2246488-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1sHQKX-0007SD-GK
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix return value of
 f2fs_convert_inline_inode()
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
 syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  3 Jun 2024 09:07:45 +0800 you wrote:
> If device is readonly, make f2fs_convert_inline_inode()
> return EROFS instead of zero, otherwise it may trigger
> panic during writeback of inline inode's dirty page as
> below:
> 
>  f2fs_write_single_data_page+0xbb6/0x1e90 fs/f2fs/data.c:2888
>  f2fs_write_cache_pages fs/f2fs/data.c:3187 [inline]
>  __f2fs_write_data_pages fs/f2fs/data.c:3342 [inline]
>  f2fs_write_data_pages+0x1efe/0x3a90 fs/f2fs/data.c:3369
>  do_writepages+0x359/0x870 mm/page-writeback.c:2634
>  filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
>  __filemap_fdatawrite_range mm/filemap.c:430 [inline]
>  file_write_and_wait_range+0x1aa/0x290 mm/filemap.c:788
>  f2fs_do_sync_file+0x68a/0x1ae0 fs/f2fs/file.c:276
>  generic_write_sync include/linux/fs.h:2806 [inline]
>  f2fs_file_write_iter+0x7bd/0x24e0 fs/f2fs/file.c:4977
>  call_write_iter include/linux/fs.h:2114 [inline]
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0xa72/0xc90 fs/read_write.c:590
>  ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix return value of f2fs_convert_inline_inode()
    https://git.kernel.org/jaegeuk/f2fs/c/a8eb3de28e7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
