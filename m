Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1AFFEC0EC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oWtwqVsvbnjGm6dgZnTIDyt96mhokTMBnoPKvX7D8Sw=; b=EX9n5sB5uspqAmGwQFNCQKhBxD
	H1RWaRYUj5ov8KVJT/HN8yeVHfBlPdjzpwUO7yt/vHVQCQJyMuOfyBb1CJrTIl06ht2n7Tq3n5zsd
	YjJoaetutK1zebsfuWJQzc6MNQInedpt5Qwru/X1tteCbDhBAZai0lwG25FAmIriaYLI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w55cR-0001vt-0M;
	Tue, 24 Mar 2026 17:32:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1w55cN-0001vb-Ei
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Mar 2026 17:32:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZB96hTRJYVHOjFuKYcVIqX2rPnz6Wiqe1JjWCS3WKAI=; b=UNNsgMZvHqJ1upmMAWjJJXsCSX
 bpqLNwKxmHNFHd3w4fil8npD45/Xw9NlnKyDSSheiQ/6A0iRUBJp5CSgAF/eVi80btLDL22wH2z72
 WvuOw4EyeYrTCZdF+IyFl6SgFHqIo5XjYiaT1vi9OLm0KYk7PZ8c5VkT9IPBC7d522ms=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZB96hTRJYVHOjFuKYcVIqX2rPnz6Wiqe1JjWCS3WKAI=; b=LyowKANe13rOK8/cyMx3mVdvPE
 YpzYNF6AUhkF+7KeONbElmjYfG3tUg0poCcmksm2BTGnronP0OXHleMPRpA1atFu1+5umB721k4/s
 fQIpsluIIyPb3d4wENrAxYjTuh/1dgNmmTuYlW5VYkWwzqT59gXnCM42CyWk6wCeDeic=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w55cM-0007qY-Ld for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Mar 2026 17:32:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0757660138;
 Tue, 24 Mar 2026 17:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DDFC19424;
 Tue, 24 Mar 2026 17:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774373552;
 bh=CoaT0xqdxLkMDFiA8o76my1m6Zes+eOkUmst9goG3P4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=JU/U827fU+Ks+o81PiIPln1W1bejm/CiRyQ3mqkkwjb2QsaD+GyhZ4Rds33Q2fnpo
 tN8fDfD+G01isJDA2d/LQAh8+GGOt5Ub6RN0DGPBcjuZ1Jz+doaVOri9BXl3fIbLjG
 JeN4HDPLTPiwwAElTQ8ez4fyN6jIdXanPhudv/06UGfIVIoi54EMbsYPxjDZ3HK8R1
 Y9wuDa8t/JZmROwfHjm1fqum+lvTqi7TO/zXDtCLCwonQ+AXqytZ6SUYGObfzov/Oy
 yl9fjiH56HGgJU4PVzLZSWyiF18Bz7/arxfLE23m2Cb3x78TxQQTADX5GXODXSQuDa
 MfeM6fkoPVEew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B9F943808203; Tue, 24 Mar 2026 17:32:21 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177437354028.1223048.9913948444381685454.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 17:32:20 +0000
References: <20260309022237.1680736-1-chao@kernel.org>
In-Reply-To: <20260309022237.1680736-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1w55cM-0007qY-Ld
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid uninit-value access in
 f2fs_sanity_check_node_footer
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
Cc: syzbot+9aac813cdc456cdd49f8@syzkaller.appspotmail.com, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, stable@kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  9 Mar 2026 02:22:37 +0000 you wrote:
> syzbot reported a f2fs bug as below:
> 
> BUG: KMSAN: uninit-value in f2fs_sanity_check_node_footer+0x374/0xa20 fs/f2fs/node.c:1520
>  f2fs_sanity_check_node_footer+0x374/0xa20 fs/f2fs/node.c:1520
>  f2fs_finish_read_bio+0xe1e/0x1d60 fs/f2fs/data.c:177
>  f2fs_read_end_io+0x6ab/0x2220 fs/f2fs/data.c:-1
>  bio_endio+0x1006/0x1160 block/bio.c:1792
>  submit_bio_noacct+0x533/0x2960 block/blk-core.c:891
>  submit_bio+0x57a/0x620 block/blk-core.c:926
>  blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
>  f2fs_submit_read_bio+0x12c/0x360 fs/f2fs/data.c:557
>  f2fs_submit_page_bio+0xee2/0x1450 fs/f2fs/data.c:775
>  read_node_folio+0x384/0x4b0 fs/f2fs/node.c:1481
>  __get_node_folio+0x5db/0x15d0 fs/f2fs/node.c:1576
>  f2fs_get_inode_folio+0x40/0x50 fs/f2fs/node.c:1623
>  do_read_inode fs/f2fs/inode.c:425 [inline]
>  f2fs_iget+0x1209/0x9380 fs/f2fs/inode.c:596
>  f2fs_fill_super+0x8f5a/0xb2e0 fs/f2fs/super.c:5184
>  get_tree_bdev_flags+0x6e6/0x920 fs/super.c:1694
>  get_tree_bdev+0x38/0x50 fs/super.c:1717
>  f2fs_get_tree+0x35/0x40 fs/f2fs/super.c:5436
>  vfs_get_tree+0xb3/0x5d0 fs/super.c:1754
>  fc_mount fs/namespace.c:1193 [inline]
>  do_new_mount_fc fs/namespace.c:3763 [inline]
>  do_new_mount+0x885/0x1dd0 fs/namespace.c:3839
>  path_mount+0x7a2/0x20b0 fs/namespace.c:4159
>  do_mount fs/namespace.c:4172 [inline]
>  __do_sys_mount fs/namespace.c:4361 [inline]
>  __se_sys_mount+0x704/0x7f0 fs/namespace.c:4338
>  __x64_sys_mount+0xe4/0x150 fs/namespace.c:4338
>  x64_sys_call+0x39f0/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:166
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x134/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid uninit-value access in f2fs_sanity_check_node_footer
    https://git.kernel.org/jaegeuk/f2fs/c/7e00e868a0db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
