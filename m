Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6E8C43327
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AC0eMVRcGf90ssX6GOliiECHMC1WKLSuyPgm2r2DlTQ=; b=GzyHC3fGal8cM/GN8iwqxdso6R
	xBVdpnpUK2xIS/4OOKIMoo+CPCjvVcoQ8KmPonQb2CEoZ0HLunxzmKcCE2W+JLaG1XnG/xZ+jRTYL
	0n7+ZZ5R/tD7UBNU0hyXRQJmhuNJYVAIJx398jFBKSf1/p6v2H+dTwNHm2oMNo/SgSJ8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1weAR9-00022l-WC;
	Mon, 29 Jun 2026 11:46:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1weAR9-00022e-KH
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 11:46:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nPZ7ws+62VWM6nyBb5IbKFldU/KuuDHoy39BQf2Yi3w=; b=JK2wejXrX/tjCJkl6pdV85dkBk
 mBOzXDRxWqlHGi8D0Nc+vtzS+JwIyx1nfx/8AfBO4lmh1HHOw5dlgXf/2m47NAv+QHHeaDBTlRrdC
 VocnPl7+dnpvE/mWmpzDg0iVtBSDe8oPdSCI/E0ePbWArLxYeR4Zs/wve7CENub5B7fk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nPZ7ws+62VWM6nyBb5IbKFldU/KuuDHoy39BQf2Yi3w=; b=R9l7Y0INMOOMPqxcAz8iGplQTx
 DNwHM3khvcifG8hrEbKyIkGbYraLgqEKdlZ15OHr4omEt5xj6llEPxH/D/DxD6D1XVEu4kaeAxfvw
 lgrCo2apnD0+kazuY843VlBj3dQ5FqFBI5RBh8lyiSHc9dOhK2VnI+lhTAA/c7+2tWdQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weAR5-0008WC-UO for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 11:46:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C989C6001D;
 Mon, 29 Jun 2026 11:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B8E1F000E9;
 Mon, 29 Jun 2026 11:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782733549;
 bh=nPZ7ws+62VWM6nyBb5IbKFldU/KuuDHoy39BQf2Yi3w=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=iM/nSZ28Ljm38KlhloCU4xJ7VU25Nhmwp+dLqoe23lDLgTONh2O0MFkkwjnatjZjn
 mqlOl2wQIhQUswxRbTTEuC9qJfHvQm1mUQdon8ej5u5nPE4J2vxv5CFyJ8N9ATpFAL
 loHgq28mCdAEMj97ICsJ7nYRAw1kYjZekao/2l5TzsZC0VMoL7ct9ukNEMTrHhnLmC
 0GEb2I6v6/ON1cfHwwp1Me0HPwSijAiGOU304q0qnohfyp6AeS6og+kF38jtERvCJX
 RXpcxohlN5Gg3WX3JpJni33pDccbfVNpfAHp3nZiGjNOQ/b0aAd45sJyyPB1oqxHGd
 ekD8IKo1BS1jA==
Message-ID: <88af8af1-3eec-4e00-a829-24671f24c0ea@kernel.org>
Date: Mon, 29 Jun 2026 19:45:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: sanan.hasanou@gmail.com, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <6a3eeee8.516c2524.21c3a2.ac0d@mx.google.com>
Content-Language: en-US
In-Reply-To: <6a3eeee8.516c2524.21c3a2.ac0d@mx.google.com>
X-Headers-End: 1weAR5-0008WC-UO
Subject: Re: [f2fs-dev] general protection fault in f2fs_in_warm_node_list
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: contact@pgazz.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/27/26 05:28, sanan.hasanou@gmail.com wrote:
> Good day, dear maintainers,
> 
> We found a bug using a modified version of syzkaller.
> 
> Kernel Branch: 7.0-rc1
> Kernel Config: <https://drive.google.com/open?id=1SkS9U2y8MGrnaXhjJJI5n5SymSSMyYnS>
> Unfortunately, we don't have any reproducer for this bug yet.

Thanks for the report, I guess it should has been fix w/

2d9c4a4ed4ee ("f2fs: fix UAF caused by decrementing sbi->nr_pages[] in f2fs_write_end_io()")

Thanks,

> Thank you!
> 
> Best regards,
> Sanan Hasanov
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
> CPU: 0 UID: 0 PID: 3043 Comm: kworker/u8:10 Not tainted 7.0.0-rc1 #1 PREEMPT_{RT,(full)} 
> Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Workqueue: bat_events batadv_tt_purge
> RIP: 0010:NODE_MAPPING fs/f2fs/f2fs.h:2260 [inline]
> RIP: 0010:is_node_folio fs/f2fs/f2fs.h:2270 [inline]
> RIP: 0010:f2fs_in_warm_node_list+0xc5/0x2a0 fs/f2fs/node.c:330
> Code: 00 00 4d 03 3c 24 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 ff e8 19 09 07 fe 4d 8b 3f 49 83 c7 30 4c 89 f8 48 c1 e8 03 <42> 80 3c 28 00 74 08 4c 89 ff e8 fc 08 07 fe 4d 3b 37 74 14 e8 b2
> RSP: 0018:ffffc9000e9af568 EFLAGS: 00010216
> RAX: 0000000000000006 RBX: ffffea0000ed41c0 RCX: ffff88802cf2b980
> RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000100
> RBP: ffffc9000e9af590 R08: ffff8880224bd66b R09: 1ffff11004497acd
> R10: dffffc0000000000 R11: ffffed1004497ace R12: ffff888050544780
> R13: dffffc0000000000 R14: ffff88803e405010 R15: 0000000000000030
> FS:  0000000000000000(0000) GS:ffff8880dc0a8000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055a77139e428 CR3: 0000000033d4c000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  f2fs_write_end_io+0x785/0x1390 fs/f2fs/data.c:400
>  bio_endio+0x936/0x980 block/bio.c:1792
>  blk_update_request+0x5a5/0xe40 block/blk-mq.c:1016
>  blk_mq_end_request+0x4a/0x80 block/blk-mq.c:1178
>  blk_flush_complete_seq+0x667/0xd10 block/blk-flush.c:191
>  flush_end_io+0xc67/0xf40 block/blk-flush.c:251
>  __blk_mq_end_request+0x5bf/0x710 block/blk-mq.c:1168
>  blk_mq_end_request+0x5e/0x80 block/blk-mq.c:1180
>  lo_complete_rq+0xe3/0x260 drivers/block/loop.c:314
>  blk_complete_reqs block/blk-mq.c:1253 [inline]
>  blk_done_softirq+0x10e/0x160 block/blk-mq.c:1258
>  handle_softirqs+0x1c7/0x690 kernel/softirq.c:622
>  __do_softirq kernel/softirq.c:656 [inline]
>  __local_bh_enable_ip+0x16a/0x270 kernel/softirq.c:302
>  local_bh_enable include/linux/bottom_half.h:33 [inline]
>  spin_unlock_bh include/linux/spinlock_rt.h:116 [inline]
>  batadv_tt_global_purge net/batman-adv/translation-table.c:2250 [inline]
>  batadv_tt_purge+0x45c/0x9e0 net/batman-adv/translation-table.c:3510
>  process_one_work kernel/workqueue.c:3275 [inline]
>  process_scheduled_works+0xa5a/0x15e0 kernel/workqueue.c:3358
>  worker_thread+0xab9/0xff0 kernel/workqueue.c:3439
>  kthread+0x355/0x410 kernel/kthread.c:467
>  ret_from_fork+0x49c/0xa10 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:245
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:NODE_MAPPING fs/f2fs/f2fs.h:2260 [inline]
> RIP: 0010:is_node_folio fs/f2fs/f2fs.h:2270 [inline]
> RIP: 0010:f2fs_in_warm_node_list+0xc5/0x2a0 fs/f2fs/node.c:330
> Code: 00 00 4d 03 3c 24 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 ff e8 19 09 07 fe 4d 8b 3f 49 83 c7 30 4c 89 f8 48 c1 e8 03 <42> 80 3c 28 00 74 08 4c 89 ff e8 fc 08 07 fe 4d 3b 37 74 14 e8 b2
> RSP: 0018:ffffc9000e9af568 EFLAGS: 00010216
> RAX: 0000000000000006 RBX: ffffea0000ed41c0 RCX: ffff88802cf2b980
> RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000100
> RBP: ffffc9000e9af590 R08: ffff8880224bd66b R09: 1ffff11004497acd
> R10: dffffc0000000000 R11: ffffed1004497ace R12: ffff888050544780
> R13: dffffc0000000000 R14: ffff88803e405010 R15: 0000000000000030
> FS:  0000000000000000(0000) GS:ffff8880dc0a8000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055a77139e428 CR3: 0000000033d4c000 CR4: 00000000000006f0
> ----------------
> Code disassembly (best guess):
>    0:	00 00                	add    %al,(%rax)
>    2:	4d 03 3c 24          	add    (%r12),%r15
>    6:	4c 89 f8             	mov    %r15,%rax
>    9:	48 c1 e8 03          	shr    $0x3,%rax
>    d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
>   12:	74 08                	je     0x1c
>   14:	4c 89 ff             	mov    %r15,%rdi
>   17:	e8 19 09 07 fe       	call   0xfe070935
>   1c:	4d 8b 3f             	mov    (%r15),%r15
>   1f:	49 83 c7 30          	add    $0x30,%r15
>   23:	4c 89 f8             	mov    %r15,%rax
>   26:	48 c1 e8 03          	shr    $0x3,%rax
> * 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
>   2f:	74 08                	je     0x39
>   31:	4c 89 ff             	mov    %r15,%rdi
>   34:	e8 fc 08 07 fe       	call   0xfe070935
>   39:	4d 3b 37             	cmp    (%r15),%r14
>   3c:	74 14                	je     0x52
>   3e:	e8                   	.byte 0xe8
>   3f:	b2                   	.byte 0xb2
> 
> <<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
