Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C3DC98324
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CR3V3XvaMqXiHtSS2XzA1h6Ts9Oy99hJpB2zkPePm6s=; b=dW9H2z0bH25GPS5/mO1b4J4giX
	8WkGK7OmFgWkeShzTBAWzdrnmZjPS6WePUNPc5cZDwfBaHHvK6BHFHTVNVJRGJYjop9k6Ktog8OF8
	tafWYa8H3gDwI06K03osatAh1/oZvRaHR8PaUtGIgPh233Rl8Wz9kAU6Ac8f7OySK0B4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xAisL-0000Uy-1D;
	Sun, 27 Sep 2026 07:00:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3Dr-4agkbAMs9FG1r22v8r66zu.x55x2vB9v8t54Av4A.t53@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1xAisJ-0000Uq-JE for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 27 Sep 2026 07:00:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yUswOB5ysKHOA7slc8X+DxW5CuxTPJYetOfkipRfRMc=; b=Ps1Rm+gNamfOCKTkJkmsBNFfgK
 dpA60ho4SFpinTyWdrqPyNc7XTeG5eLQkWOoGSDbq2W7MH7S7BBqaUteVzq+MaK+pBCRYlG2K+08G
 CQ1kj4RCGFC1/wXEXmdecG6N5TTZb3h+9oCi2wyFJA1c4j0PiD/djCPQUSNaz5n0na4U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yUswOB5ysKHOA7slc8X+DxW5CuxTPJYetOfkipRfRMc=; b=Q
 jL1UByeBwJcDF42dRFNB7m896T3lGA+EGt/4o8pBgWSrEbcopL4SsITSgRTUvwR78gIw5RDM27OHH
 RuedUNAiSJvAJn+0KZu6Xjhq7/IFWRRzwrZE+xvnklko6TFglTBiSJVCuygayADuodW+CDVYFx+9j
 5XGNOeqnBdY9uEzM=;
Received: from mail-oi1-f198.google.com ([209.85.167.198])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xAisG-0000zX-Dy for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 27 Sep 2026 07:00:37 +0000
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4cbf700ddccso2420090b6e.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 27 Sep 2026 00:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790492431; x=1791097231;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yUswOB5ysKHOA7slc8X+DxW5CuxTPJYetOfkipRfRMc=;
 b=NXAvfixjRCDMldXU/shNWCFzmi/60LbO761KgzOAckiY6DpEL98nw3AmwvzChAVFxD
 DFvsDuac4bkidSwvgLUQKGn9oguSKSnklmTicAXJdnaDXDkKEZ36Bh8RHywbkYq42WJv
 rYkQOz4pIGBhTyu+5K10LxffmgU9tn/TearcG7B6gcsqeHanEKPGGtdyUV1pZJgOBMTL
 R2Gmv6ZTWU5CsfRGKJ9Svu6qDFDieHIdIhzA3sl/DlO9df8CmXHRkxBhQallvmJlNhuX
 tfPz4SS48PrT4FdKcIbJl8Lk/vSlD23bpXdPUEDUv2/cbbABT7JLjnSsh9ZS1GhCk8Zx
 JyVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyDbjEmeEWQFEe0DFYRCs6sKnaI2QQ3x5hiQSUB9hNECNEKd9I9l89dBdcmbsf592CLNuBWBODhV1qZUsstyAc@lists.sourceforge.net
X-Gm-Message-State: AFuF++n/YyfydaTpeD2/xZHA9yylq34Zp54CUipggnwHfKJgvvJ0YM8W
 uVnYiqj9fg2ALf7A9r2Uf7rVUSiG+Um4aW+B9xB407ZAHld8ULoXziT55QXYSYtIEdONJHLDxn3
 w94gvo9/eTjVw8+I1/8tFtbG2Q2nFLBR0VWHlwUhF4cGR+eJbTUAuuJHSCi4=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1599:b0:4cb:d056:b14f with SMTP id
 5614622812f47-4dc57e2b419mr6325207b6e.1.1790492430728; Sun, 27 Sep 2026
 00:00:30 -0700 (PDT)
Date: Sun, 27 Sep 2026 00:00:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab8bf0e.80e1c6cc.1e8e5f.0053.GAE@google.com>
From: syzbot <syzbot+eae639926b1c1ac725d5@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1xAisG-0000zX-Dy
Subject: [f2fs-dev] [syzbot] [f2fs?] kernel BUG in f2fs_write_end_bio
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

syzbot found the following issue on:

HEAD commit:    fe2ec83746e5 Merge tag 'hid-for-linus-2026092202' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ba8d25580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b924f079099ba6e
dashboard link: https://syzkaller.appspot.com/bug?extid=eae639926b1c1ac725d5
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-fe2ec837.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/64158d6729cc/vmlinux-fe2ec837.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4e2043b7fc3f/bzImage-fe2ec837.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eae639926b1c1ac725d5@syzkaller.appspotmail.com

F2FS-fs (loop0): inconsistent node block, node_type:0, nid:3, node_footer[nid:0,ino:0,ofs:0,cpver:0,blkaddr:0]
------------[ cut here ]------------
kernel BUG at fs/f2fs/data.c:365!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 1055 Comm: kworker/u4:9 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: loop0 loop_workfn
RIP: 0010:f2fs_write_end_bio+0x167d/0x16e0 fs/f2fs/data.c:365
Code: 67 5f 8c e8 75 15 c1 fc 90 0f 0b e8 1d e0 60 fd 48 8b 7c 24 08 48 c7 c6 20 67 5f 8c e8 5c 15 c1 fc 90 0f 0b e8 04 e0 60 fd 90 <0f> 0b e8 fc df 60 fd 48 8b 7c 24 08 48 c7 c6 20 67 5f 8c e8 3b 15
RSP: 0018:ffffc9000527f490 EFLAGS: 00010293
RAX: ffffffff84670d0c RBX: 0000000000000003 RCX: ffff888036980000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: ffffea00010bb900 R08: ffffffff907a767f R09: 1ffffffff20f4ecf
R10: dffffc0000000000 R11: fffffbfff20f4ed0 R12: ffffea00010bb8c0
R13: dffffc0000000000 R14: 0000000000001000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88808c2c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcdf33c4d10 CR3: 000000003b2bb000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 blk_update_request+0x57b/0xe50 block/blk-mq.c:1016
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1147
 lo_rw_aio_complete drivers/block/loop.c:338 [inline]
 lo_rw_aio+0xcd4/0xf20 drivers/block/loop.c:406
 do_req_filebacked drivers/block/loop.c:430 [inline]
 loop_handle_cmd drivers/block/loop.c:1949 [inline]
 loop_process_work+0x621/0x11c0 drivers/block/loop.c:1984
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_write_end_bio+0x167d/0x16e0 fs/f2fs/data.c:365
Code: 67 5f 8c e8 75 15 c1 fc 90 0f 0b e8 1d e0 60 fd 48 8b 7c 24 08 48 c7 c6 20 67 5f 8c e8 5c 15 c1 fc 90 0f 0b e8 04 e0 60 fd 90 <0f> 0b e8 fc df 60 fd 48 8b 7c 24 08 48 c7 c6 20 67 5f 8c e8 3b 15
RSP: 0018:ffffc9000527f490 EFLAGS: 00010293
RAX: ffffffff84670d0c RBX: 0000000000000003 RCX: ffff888036980000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: ffffea00010bb900 R08: ffffffff907a767f R09: 1ffffffff20f4ecf
R10: dffffc0000000000 R11: fffffbfff20f4ed0 R12: ffffea00010bb8c0
R13: dffffc0000000000 R14: 0000000000001000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88808c2c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcdf33c4d10 CR3: 000000001f6d9000 CR4: 0000000000352ef0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
