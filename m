Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1638C47DDB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jan 2024 20:29:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rUYGI-00010a-FO;
	Mon, 29 Jan 2024 20:29:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rUYGG-00010L-Is
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jan 2024 20:29:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NQcU0NtyBULjs8a0+E7hz0v4Vzx5KbyLo/fJlTkU7Uo=; b=LsIhITL4w96RxQFhRm5OBgJtUA
 2CpHF0QDThLOiOzYw+wleDNDRaU8eUC7SOBPys4Z7lMsrex63CiaDU5ZK/NddKDyIgTCdzPlXi5Ll
 zkrTxv+E6vZNsuQxaj3gRFOhY8czgAT4ZCT+ef76DHPYsidkdVdQURsYagaIcuXg5UjI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NQcU0NtyBULjs8a0+E7hz0v4Vzx5KbyLo/fJlTkU7Uo=; b=UtD71oNRpxWc5TK5dqwOC/45Ir
 vXVWOXIZOOrK6bQSGw6bxULPjKitM6+bNn05iqeubEfn2E3p9acdjJRQw6M5h7wzNn3tL3r+bTLff
 FgDnxajn9NT9k7p8bHb0iptu+71K/A+8fcMX4IGWDJCIrA3DkyiI5d8N5i6ZslPzbiyw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rUYGD-0008Pl-NO for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jan 2024 20:29:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EC3FD624BF;
 Mon, 29 Jan 2024 20:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A1C7C43601;
 Mon, 29 Jan 2024 20:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706560171;
 bh=Ws3GNmP4bZcIK/lP0Akxr8I4gT6THkXk2sw+6WQGXT8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=ORysDXHDDYmGkBUYZUTEl8Hemjt+5THmch4CTAgEY8eJRp7eGCeO+eFWB91+va9ac
 iWvGRYStOf9f/0ueiOQUgMZxeskdQ1wA9ns+ley9af8EHFJ6Q8Zyh8Atn2uInZwAgW
 2VKES9l/KdLm82V7syjUE6DfVz2m9XMxfqtDS9idpi0lZ/kHLGtqaAdr1NqIa1vSJD
 tpklRvsl7bzDuE5yoIDLJ7Bc27CjNdFCGJNSXGrHT0j7hcAyGTEVN3Z+hS45RAWoi1
 /m1avBtUDpTQjWjCTrhD0xPRhguNsdxoj3JrxrpokpeP6eUh6xa2bxVvZltC6PGlXz
 TQ6EWJWG93bvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 F37EFC595D1; Mon, 29 Jan 2024 20:29:30 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170656017099.16041.13561924152211194606.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 20:29:30 +0000
References: <20240116141138.1245-1-qwjhust@gmail.com>
In-Reply-To: <20240116141138.1245-1-qwjhust@gmail.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1rUYGD-0008Pl-NO
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: fix NULL pointer dereference in
 f2fs_submit_page_write()
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, hustqwj@hust.edu.cn,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 16 Jan 2024 22:11:38 +0800 you wrote:
> BUG: kernel NULL pointer dereference, address: 0000000000000014
> RIP: 0010:f2fs_submit_page_write+0x6cf/0x780 [f2fs]
> Call Trace:
> <TASK>
> ? show_regs+0x6e/0x80
> ? __die+0x29/0x70
> ? page_fault_oops+0x154/0x4a0
> ? prb_read_valid+0x20/0x30
> ? __irq_work_queue_local+0x39/0xd0
> ? irq_work_queue+0x36/0x70
> ? do_user_addr_fault+0x314/0x6c0
> ? exc_page_fault+0x7d/0x190
> ? asm_exc_page_fault+0x2b/0x30
> ? f2fs_submit_page_write+0x6cf/0x780 [f2fs]
> ? f2fs_submit_page_write+0x736/0x780 [f2fs]
> do_write_page+0x50/0x170 [f2fs]
> f2fs_outplace_write_data+0x61/0xb0 [f2fs]
> f2fs_do_write_data_page+0x3f8/0x660 [f2fs]
> f2fs_write_single_data_page+0x5bb/0x7a0 [f2fs]
> f2fs_write_cache_pages+0x3da/0xbe0 [f2fs]
> ...
> It is possible that other threads have added this fio to io->bio
> and submitted the io->bio before entering f2fs_submit_page_write().
> At this point io->bio = NULL.
> If is_end_zone_blkaddr(sbi, fio->new_blkaddr) of this fio is true,
> then an NULL pointer dereference error occurs at bio_get(io->bio).
> The original code for determining zone end was after "out:",
> which would have missed some fio who is zone end. I've moved
>  this code before "skip:" to make sure it's done for each fio.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v1] f2fs: fix NULL pointer dereference in f2fs_submit_page_write()
    https://git.kernel.org/jaegeuk/f2fs/c/52434fdc4f86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
