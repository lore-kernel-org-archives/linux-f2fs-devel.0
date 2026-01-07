Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9A5CF6BEA
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jan 2026 03:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hJATHbIz3s7xyGzC4o6LAp4hwAAIcVFpYzG454wi4qk=; b=EhBybkUvqn59U53sd/qVOW3DQ5
	emCi46m/X4gw821G5aXzwcbH5oTfiIT3yp+3XlY5uW4b2yjchKTOx+dEuaypWm8+dcGhR5twTVQTi
	ysYvawAa06ufj6Px+Tr4omj4Csn0jQ+Wa2A+mQBV/Q7wT4G4/4Bz8uNCc/iKLPtI95q8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vdKIz-0002PG-In;
	Wed, 07 Jan 2026 03:33:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vdKIx-0002P5-OM
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jan 2026 03:33:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/FIXmwEA2CISnw+n27dcc5PNzfJKv5zqRG+dX+vPkNA=; b=Go/jvIgvh6kjPByauVS70chOQR
 sKRN6PWqpKx8UZPmrSudrguIe79A6fujN29Su1A0Z7FReaUuHWFy2VHdlSRpOYpPn8mvt3Gm6GmHT
 PsgRvuvueD0O9JVhs9xx8hrT+FF0Pgu6nm8ROpY5IPHtpCiCV+gynz4FJyg5TaBNhJXU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/FIXmwEA2CISnw+n27dcc5PNzfJKv5zqRG+dX+vPkNA=; b=ObcOKSkPlFaJUy4gKfresU/NQk
 2Owl13uz3JgdyP+u7Ha9V4M00ni5YNBWeFjj1kqxiWOiZOkWA4/HMCicMiQh4lKIlZrjt/RgUS3Jr
 zdPLqxbnd6rONphjHJRdyW0iRAYMT0n7nhVs6Zd2wXjuFpnlBXCeYHQu2v/PGaPxmMH4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vdKIx-0004YQ-7r for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jan 2026 03:33:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EDBE3443B3;
 Wed,  7 Jan 2026 03:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC14AC19422;
 Wed,  7 Jan 2026 03:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767756820;
 bh=013O9vTaStSIw3Jpj//R8xTgQCWxq7bwIyJqJzbov5I=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=U6zhK9mT2u1VcJWonfE9uLGknoQ901S22rC7gZ062/6dWQ5ThW6uzueqrg8unvADj
 ZCryqYHT3jGavtDUZ1KsBXk0acqGXfsIjhyk6+hvegZl2so13dQ1xID7QXluYRuQGK
 7vIWjB4BZzbEbcvKEr0K37ZEDELhQRqoQPBKyFbE6j0arAI5TXJdlYELF6YRTRZTUI
 ixpClG6FfSF1//FD53JXBC1Fa6k+IC4xsUpNZ7QmptceJ+e4f76cp3kTUzutTR6B5n
 qQZb2x4U/mTPZKYi4AYKZlqc2vItD7WPrTOTlQXviPFQEfHDUtZ9RiWQBoaSMcY8tX
 QJmQbYxq+7fwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 796F7380CEF5; Wed,  7 Jan 2026 03:30:19 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176775661802.2218650.10192529700964265302.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 03:30:18 +0000
References: <20260106121210.2374783-2-monty_pavel@sina.com>
In-Reply-To: <20260106121210.2374783-2-monty_pavel@sina.com>
To: Yongpeng Yang <monty_pavel@sina.com>
X-Headers-End: 1vdKIx-0004YQ-7r
Subject: Re: [f2fs-dev] [PATCH v5 1/1] f2fs: fix IS_CHECKPOINTED flag
 inconsistency issue caused by concurrent atomic commit and checkpoint
 writes
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
Cc: jinbaoliu365@gmail.com, yangyongpeng@xiaomi.com, liujinbao1@xiaomi.com,
 shengyong1@xiaomi.com, linux-f2fs-devel@lists.sourceforge.net,
 jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  6 Jan 2026 20:12:11 +0800 you wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> During SPO tests, when mounting F2FS, an -EINVAL error was returned from
> f2fs_recover_inode_page. The issue occurred under the following scenario
> 
> Thread A                                     Thread B
> f2fs_ioc_commit_atomic_write
>  - f2fs_do_sync_file // atomic = true
>   - f2fs_fsync_node_pages
>     : last_folio = inode folio
>     : schedule before folio_lock(last_folio) f2fs_write_checkpoint
>                                               - block_operations// writeback last_folio
>                                               - schedule before f2fs_flush_nat_entries
>     : set_fsync_mark(last_folio, 1)
>     : set_dentry_mark(last_folio, 1)
>     : folio_mark_dirty(last_folio)
>     - __write_node_folio(last_folio)
>       : f2fs_down_read(&sbi->node_write)//block
>                                               - f2fs_flush_nat_entries
>                                                 : {struct nat_entry}->flag |= BIT(IS_CHECKPOINTED)
>                                               - unblock_operations
>                                                 : f2fs_up_write(&sbi->node_write)
>                                              f2fs_write_checkpoint//return
>       : f2fs_do_write_node_page()
> f2fs_ioc_commit_atomic_write//return
>                                              SPO
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v5,1/1] f2fs: fix IS_CHECKPOINTED flag inconsistency issue caused by concurrent atomic commit and checkpoint writes
    https://git.kernel.org/jaegeuk/f2fs/c/7633a7387eb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
