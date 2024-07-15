Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCEAC3DA59
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jul 2024 14:40:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sTMsf-0002qu-OQ;
	Mon, 15 Jul 2024 14:40:45 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1sTMsd-0002qd-JT
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jul 2024 14:40:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=shOeOJ0FPgrJr1pN15pwSEEgOEzAde7oKPp/F0fTVYo=; b=M077l4tJIm7MNl9EnkO5ehLFtJ
 Su4iaGRSP/WJbZvH5RU70yO1eM91YfivWyzPstOxGkuW4AHoCGJPuEn0KbyKd2eT0a3z1EqCb/lrZ
 39xeG7i2x/FJS8sg8qiFosher2SieAZAf91sohbm5yQ1qN8QuZfaUdH0f9nxuMUd2t9Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=shOeOJ0FPgrJr1pN15pwSEEgOEzAde7oKPp/F0fTVYo=; b=Mr4OP1l2+I1iIbsYpK5bexRQan
 D6zaGK8PzIBdNANBPbK3C/D58bHnWj47g5iQ550E/ttuAjze9NCNPHYQlB/SbHex93WDVSBEOYMta
 Khz+R3xDMGAMwMuOnoijIbiDbt/3UvenS+KYX6OpeIglyMDxsc+nJ0hbenvpDI/M/nxQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sTMsd-0003EK-O3 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jul 2024 14:40:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8FE15611CD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CB04C4AF0A;
 Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721054432;
 bh=D7KLOLWbUbbroj6+z4K7TzPFfauIf/C6xHVDOk3MrHw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=NrnhEkTNXzaAnGctM4AI/f2A8k+GiZS+G6qg9V3ba77TgQXn21WmO88m1u2mQXukN
 RQCrNajaCYYLa5JG1aNCwURSL/JE5bVKjXDl0xj9E8YSgULaoDbeXALclhru5QOICQ
 BDitDC/f+9OLFnh+WH9U8H9+L025CI+W0wI415xH/xC/yelkDdVRTPSdHfdUyDf0Ye
 PmgMzDLwFVeKa+qjtq9nclqFTIwt6kf8OetpKBeLz4+pLpRXykHG/SoM/uIzxnHDqN
 j430u1VR0qpI07o1B57UsgCJc7RYSrYRy+3L8sobjq8d38+hXc6sUNqmr0EqCxh5Bb
 BTuNudWH6d5gQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 4CD90C43443; Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <172105443231.17443.11007255777614226894.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 14:40:32 +0000
References: <20240625023239.3534605-1-chao@kernel.org>
In-Reply-To: <20240625023239.3534605-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1sTMsd-0003EK-O3
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to update user block counts in
 block_operations()
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 25 Jun 2024 10:32:39 +0800 you wrote:
> Commit 59c9081bc86e ("f2fs: allow write page cache when writting cp")
> allows write() to write data to page cache during checkpoint, so block
> count fields like .total_valid_block_count, .alloc_valid_block_count
> and .rf_node_block_count may encounter race condition as below:
> 
> CP				Thread A
> - write_checkpoint
>  - block_operations
>   - f2fs_down_write(&sbi->node_change)
>   - __prepare_cp_block
>   : ckpt->valid_block_count = .total_valid_block_count
>   - f2fs_up_write(&sbi->node_change)
> 				- write
> 				 - f2fs_preallocate_blocks
> 				  - f2fs_map_blocks(,F2FS_GET_BLOCK_PRE_AIO)
> 				   - f2fs_map_lock
> 				    - f2fs_down_read(&sbi->node_change)
> 				   - f2fs_reserve_new_blocks
> 				    - inc_valid_block_count
> 				    : percpu_counter_add(&sbi->alloc_valid_block_count, count)
> 				    : sbi->total_valid_block_count += count
> 				    - f2fs_up_read(&sbi->node_change)
>  - do_checkpoint
>  : sbi->last_valid_block_count = sbi->total_valid_block_count
>  : percpu_counter_set(&sbi->alloc_valid_block_count, 0)
>  : percpu_counter_set(&sbi->rf_node_block_count, 0)
> 				- fsync
> 				 - need_do_checkpoint
> 				  - f2fs_space_for_roll_forward
> 				  : alloc_valid_block_count was reset to zero,
> 				    so, it may missed last data during checkpoint
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to update user block counts in block_operations()
    https://git.kernel.org/jaegeuk/f2fs/c/f06c0f82e38b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
