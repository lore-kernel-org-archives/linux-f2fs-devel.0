Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CB9EB365D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Mar 2026 03:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:In-Reply-To:Date:MIME-Version:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=TKDqAxvnoNGoBWuiy97JQ4NciuKXqy20zXXVlYDAIVY=; b=YPPAZ2Pt0vKAzLHycogGtHlePz
	NgXksJAjjAF8EoZr0fn8LbSAgFxnJYvrgruVupOXpvWS9gbEbogGeIa89FKb/lQb4X2HfIDqvyXGL
	SXKbb4R7tPQIYdNwPpRnbItMv0cPR7ejYiHaTQ88g9MLHxDMd+4r3TcVwAFhJASuxTEo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxGMr-0003pF-2U;
	Tue, 03 Mar 2026 03:24:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3VFSmaQkbAOkdjkVLWWPcLaaTO.RZZRWPfdPcNZYePYe.NZX@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1vxGMp-0003p8-R6 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Mar 2026 03:24:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x4KqJxZolyPiVoCpexmfJoJmpnwPpleiz8xlaEzZb64=; b=I9DYbVJoXjsrOrnAsOmR8azI+e
 mfIyIAQqHdJpdi/X0fWQrBhBnXh1yQja1SJi8wGdTKNbQWzan1lRfQTjQGmFTFnAuigIUR3x+nhh1
 PeRk95W8z283PWftoL9fmtUgLkAoDFNiCdNXWbJZyM3mgqLN8fPzSuhluDeDbIxW+I9s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=x4KqJxZolyPiVoCpexmfJoJmpnwPpleiz8xlaEzZb64=; b=l
 4IHRzFEPHoOkcfEerNmPJ0yVI8s/7Rn+pMCJG5EJHZHoT/cQlLz+RrOUzC3eEHajtFLycC2HFePgg
 2k69uSuOmtuc0/J2OYMu2WcROGqGeIEIQlvmOyWE8y7DT2PZZj0hqOgEM0dQ6P6441BrpThe21CYi
 hO7XiG3DR8pKaV1w=;
Received: from mail-ot1-f69.google.com ([209.85.210.69])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vxGMo-0005B7-JX for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Mar 2026 03:24:15 +0000
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7d4be1dee67so55488305a34.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Mar 2026 19:24:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772508244; x=1773113044;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x4KqJxZolyPiVoCpexmfJoJmpnwPpleiz8xlaEzZb64=;
 b=YK3HxvfZcw54THR4uel2V7tkifq6XTIFc39DibGbhglj2lkOPHE+IFKvbcK7UgGQ8z
 77Pw6GrM8FmSQInxyPw9G2pmQOMUIPUGZXd0FJHdQbFtsNg6MBSCkgBKYe41MjuV3lbq
 wfJX2nKNa5zp2wzIQVeJbPiYKSPeBbT+kkRVkmvAf47MztnOlAeULvWi1hO0tjAHXXHg
 ggj2+Gf0XboxjqH21hZ8B3DYVhIDQzkzhFz0milqoAM4BkbXx6NvimSJ7inI1H9Llb4i
 s1zKgfvVpP/qjve0UnVqyB27fO1HcRY8oyTvTri9OL6s3uhiZpRjroyojuj1zB2sygXC
 talg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcADam0UIlqH5yvQF5kfbLXKzOVOcIVOxGkVxka6Fpb0dyykU+f2cELW+YyAL9W4IDfLW8Ls7UngdPAspBUe49@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yyq7kCFb9IgaM4mMteT6fqW3mxcrzNi/mvNXL6W0oWL/jGV9gbc
 yZKKuf69vdh666rzYv4O4wzsHewcM6pJAq8mXvwM8/CHWsIybBBkBB8CDEICvREBZ6GqTmFjjVq
 Gb3Y56Hm8YR2CyR4JvP14JiBy9dNFIIna17fVhHuo5F5jCN2s18pA9HHVP48=
MIME-Version: 1.0
X-Received: by 2002:a4a:e90a:0:b0:679:f00e:8213 with SMTP id
 006d021491bc7-679faf93124mr8308895eaf.75.1772508244036; Mon, 02 Mar 2026
 19:24:04 -0800 (PST)
Date: Mon, 02 Mar 2026 19:24:04 -0800
In-Reply-To: <20260303030121.3626665-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a65454.a70a0220.b118c.0008.GAE@google.com>
From: syzbot <syzbot+6e4cb1cac5efc96ea0ca@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com, wangqing7171@gmail.com
X-Headers-End: 1vxGMo-0005B7-JX
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] general protection fault in
 f2fs_in_warm_node_list
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in f2fs_in_warm_node_list

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:NODE_MAPPING fs/f2fs/f2fs.h:2260 [inline]
RIP: 0010:is_node_folio fs/f2fs/f2fs.h:2270 [inline]
RIP: 0010:f2fs_in_warm_node_list+0xbd/0x290 fs/f2fs/node.c:330
Code: 00 00 4d 03 3c 24 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 ff e8 71 a9 fd fd 4d 8b 3f 49 83 c7 30 4c 89 f8 48 c1 e8 03 <42> 80 3c 28 00 74 08 4c 89 ff e8 54 a9 fd fd 4d 3b 37 74 19 e8 da
RSP: 0018:ffffc900001479a8 EFLAGS: 00010206
RAX: 0000000000000006 RBX: ffffea0000aa0c80 RCX: ffff88801c6e9e80
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000100
RBP: dffffc0000000000 R08: ffffffff8f6a32b7 R09: 1ffffffff1ed4656
R10: dffffc0000000000 R11: fffffbfff1ed4657 R12: ffff8880394a8798
R13: dffffc0000000000 R14: ffff88805c522950 R15: 0000000000000030
FS:  0000000000000000(0000) GS:ffff888126340000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd37652e50 CR3: 0000000044d76000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 f2fs_write_end_io+0x691/0x1020 fs/f2fs/data.c:400
 blk_update_request+0x57e/0xe60 block/blk-mq.c:1016
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1178
 blk_flush_complete_seq+0x687/0xce0 block/blk-flush.c:191
 flush_end_io+0xc40/0xf30 block/blk-flush.c:251
 __blk_mq_end_request+0x4a9/0x680 block/blk-mq.c:1168
 blk_complete_reqs block/blk-mq.c:1253 [inline]
 blk_done_softirq+0x10a/0x160 block/blk-mq.c:1258
 handle_softirqs+0x1de/0x6f0 kernel/softirq.c:622
 run_ksoftirqd+0x52/0x180 kernel/softirq.c:1063
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:NODE_MAPPING fs/f2fs/f2fs.h:2260 [inline]
RIP: 0010:is_node_folio fs/f2fs/f2fs.h:2270 [inline]
RIP: 0010:f2fs_in_warm_node_list+0xbd/0x290 fs/f2fs/node.c:330
Code: 00 00 4d 03 3c 24 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 ff e8 71 a9 fd fd 4d 8b 3f 49 83 c7 30 4c 89 f8 48 c1 e8 03 <42> 80 3c 28 00 74 08 4c 89 ff e8 54 a9 fd fd 4d 3b 37 74 19 e8 da
RSP: 0018:ffffc900001479a8 EFLAGS: 00010206
RAX: 0000000000000006 RBX: ffffea0000aa0c80 RCX: ffff88801c6e9e80
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000100
RBP: dffffc0000000000 R08: ffffffff8f6a32b7 R09: 1ffffffff1ed4656
R10: dffffc0000000000 R11: fffffbfff1ed4657 R12: ffff8880394a8798
R13: dffffc0000000000 R14: ffff88805c522950 R15: 0000000000000030
FS:  0000000000000000(0000) GS:ffff888126340000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd37652e50 CR3: 0000000044d76000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	4d 03 3c 24          	add    (%r12),%r15
   6:	4c 89 f8             	mov    %r15,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  12:	74 08                	je     0x1c
  14:	4c 89 ff             	mov    %r15,%rdi
  17:	e8 71 a9 fd fd       	call   0xfdfda98d
  1c:	4d 8b 3f             	mov    (%r15),%r15
  1f:	49 83 c7 30          	add    $0x30,%r15
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ff             	mov    %r15,%rdi
  34:	e8 54 a9 fd fd       	call   0xfdfda98d
  39:	4d 3b 37             	cmp    (%r15),%r14
  3c:	74 19                	je     0x57
  3e:	e8                   	.byte 0xe8
  3f:	da                   	.byte 0xda


Tested on:

commit:         af4e9ef3 uaccess: Fix scoped_user_read_access() for 'p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129818d6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a019678b1a3a692
dashboard link: https://syzkaller.appspot.com/bug?extid=6e4cb1cac5efc96ea0ca
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11948d5a580000



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
