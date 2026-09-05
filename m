Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A726DC624D6
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  5 Sep 2026 07:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:In-Reply-To:Date:MIME-Version:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=JYC3efbLxnPSbBLZ0UQGzJz+XxZZEYohXKj6UkcpF/I=; b=bRCdRyOi6H2F68kD5X9+Yt9m5Y
	esl+OfwPrd9mIbjT5y4wjsdAVyryXx5tVqjqJD8KhOzYU/xmCxqoTxserNZp8nEaNMgJKVu6IsYPI
	ZCIgUHPHyRABn2EZW+zVURyvxTcWw5cs98/tWZSNuZbKoljp4XP70VPW1JWVxn6HWyxs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2kUi-00005G-87;
	Sat, 05 Sep 2026 07:07:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3lL-bagkbAN0RXYJ9KKDQ9OOHC.FNNFKDTRDQBNMSDMS.BNL@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1x2kUU-000051-Eo for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 07:07:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 In-Reply-To:Date:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:References:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nnvwnS1OPKAjnbL2Ffg9wjdt+AOLqiiejT+aXhRtPlk=; b=MKeFNZ5tB/pIBgdD1Bvf7qrjzk
 ZGFBOmzhrC30dKxpNkWrRCkmDkwCBauGTHoQNnQzzDiq14mUdqxwzEDMstz3hVWvDkIqVxZ2A2lMp
 5k7LgaVZshWqpjKKpx5b8gwFVsRc9MvfpdL6Axosp5Kf560kP5LrFNNz1rR3IHV1dzfk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nnvwnS1OPKAjnbL2Ffg9wjdt+AOLqiiejT+aXhRtPlk=; b=T
 mw3wRt2HI6Cei469HxgFjX7rGz4TB59hFBfuXOm+1iqQedtCLz+rLwNc+bhdV4bMg4nQqzTJIjnxL
 2q0n5Uhcgaah7Uo+js9/bh3qH5mB+BzmtnKK52/Ng+021xLTHL67VG6WUojN6GHiKfTxEg/bZvQpT
 NSvGogVkZUDh3sgw=;
Received: from mail-oo1-f72.google.com ([209.85.161.72])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2kUT-0005q8-Pw for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 07:07:07 +0000
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-6b1ac969b92so1987679eaf.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 05 Sep 2026 00:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788592020; x=1789196820;
 h=content-type:cc:to:from:subject:message-id:in-reply-to:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nnvwnS1OPKAjnbL2Ffg9wjdt+AOLqiiejT+aXhRtPlk=;
 b=EzNIxt+GESLEK7WwgXpbEZeZ35MKIWUCmJlbBD+iUO25lW7UcE90nSdOEH9CqOxgVA
 Vq97yQ8zWmaEqNsJUF1ehg9xw0o6R3+CfLz09j5syfMPnY5klT23lv+y7S8Mg8jRUCSS
 sZK2hlpoaZcoC19GKlbpBXfuJGY85pd+ZtTLY8w9dy6CZ9xr5gP0zCTp0tGh28kXAWI2
 o+4eWiGiTyCtN6airiMcl0P41SLkITyBBQREmZucbM6+EYRdsx/sSIkma2JrwsK6v5TC
 Q9h8rHScJIF9Cc6kp4k7pl8RctY4QoUwj6vf2EJOk0l+5QDjf1FdbxB2hwygMj3Ti07d
 Q6Ag==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxKVPUTCNuob/vmpWutlIyz8YaAp7YEPFv8grCtyuZVi8ZgCm2pW27RxSYeLK0yv6mKlVtGBV9WCEeXpmj2kah@lists.sourceforge.net
X-Gm-Message-State: AFuF++kHzWeNs46ju8BRqxAnQndocgP0TcBfv2u9hfpBj+lEgupkh2IM
 rSMSc/aIrhAWc3mwhgSGHIgx1OtCb4tkKo2+djjbUfIYYRtE//9XJMC+awrvs2coyz0iCBamqrR
 w+SK6S/yz0RPt04I5+UgW6xOvj8Hs31r7xBK7vSnKLFhdwslGuu7hSBCxCCw=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4cca:b0:6b7:8415:d790 with SMTP id
 006d021491bc7-6b78415d8d8mr4693626eaf.59.1788592020180; Sat, 05 Sep 2026
 00:07:00 -0700 (PDT)
Date: Sat, 05 Sep 2026 00:07:00 -0700
In-Reply-To: <cover.1788438786.git.qiwenjie@xiaomi.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9bbf94.a5e650b3.26d8a.0006.GAE@google.com>
From: syzbot ci <syzbot+cid5582b8164122eda@syzkaller.appspotmail.com>
To: axboe@kernel.dk, baohua@kernel.org, chao@kernel.org, hch@lst.de, 
 jack@suse.cz, jaegeuk@kernel.org, linux-block@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, qiwenjie@xiaomi.com, 
 qwjhust@gmail.com, tz2294@columbia.edu
X-Headers-End: 1x2kUT-0005q8-Pw
Subject: [f2fs-dev] [syzbot ci] Re: f2fs: enable buffered RWF_DONTCACHE
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
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

syzbot ci has tested the following series

[v4] f2fs: enable buffered RWF_DONTCACHE
https://lore.kernel.org/all/cover.1788438786.git.qiwenjie@xiaomi.com
* [PATCH v4 1/2] f2fs: complete dropbehind write bios in task context
* [PATCH v4 2/2] f2fs: enable buffered RWF_DONTCACHE

and found the following issue:
general protection fault in f2fs_write_begin

Full report is available here:
https://ci.syzbot.org/series/cbb9ded8-1388-4a7b-bfa7-44082b04025b

***

general protection fault in f2fs_write_begin

tree:      mm-new
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akpm/mm.git
base:      e3fc12b08aadde9cec7b3799ac0e0c9a1aa245c4
arch:      amd64
compiler:  Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
config:    https://ci.syzbot.org/builds/e5903709-6ea2-4b1e-9dfc-f073e36367f7/config
syz repro: https://ci.syzbot.org/findings/d05a5d64-e9a3-4714-9b41-43042eaaa82c/syz_repro

loop0: detected capacity change from 0 to 40427
F2FS-fs (loop0): invalid crc value
F2FS-fs (loop0): f2fs_recover_fsync_data: recovery fsync data, check_only: 0
F2FS-fs (loop0): Mounted with checkpoint version = 48b305e5
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
CPU: 1 UID: 0 PID: 5791 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:f2fs_write_begin+0x181/0x28e0 fs/f2fs/data.c:3893
Code: e7 e8 23 21 d4 fd 49 8b 04 24 48 89 44 24 40 41 c6 45 2c 04 c7 84 24 a0 02 00 00 00 00 00 00 48 83 c3 20 48 89 d8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 0f 85 e9 23 00 00 41 be 80 00 00 00 44 23 33
RSP: 0018:ffffc900037af7a0 EFLAGS: 00010202
RAX: 0000000000000004 RBX: 0000000000000020 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffff8881b465c918 RDI: 0000000000000000
RBP: ffffc900037afad0 R08: ffffc900037afb80 R09: ffffc900037afba0
R10: dffffc0000000000 R11: ffffffff8463a450 R12: ffff88816b91e678
R13: fffff520006f5f1c R14: dffffc0000000000 R15: ffff8881b465c918
FS:  00007f65b5e096c0(0000) GS:ffff8882a8cd9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f65b4e70050 CR3: 000000016a860000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 page_symlink+0x27a/0x440 fs/namei.c:6556
 f2fs_symlink+0x5fc/0x970 fs/f2fs/namei.c:714
 vfs_symlink+0x18b/0x330 fs/namei.c:5794
 filename_symlinkat+0x1cd/0x410 fs/namei.c:5819
 __do_sys_symlinkat fs/namei.c:5839 [inline]
 __se_sys_symlinkat+0x4e/0x2b0 fs/namei.c:5834
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f65b4f9e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f65b5e09028 EFLAGS: 00000246 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 00007f65b5225fa0 RCX: 00007f65b4f9e159
RDX: 00002000000005c0 RSI: ffffffffffffff9c RDI: 0000200000000700
RBP: 00007f65b5035024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f65b5226038 R14: 00007f65b5225fa0 R15: 00007fffb6ecc0c8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_write_begin+0x181/0x28e0 fs/f2fs/data.c:3893
Code: e7 e8 23 21 d4 fd 49 8b 04 24 48 89 44 24 40 41 c6 45 2c 04 c7 84 24 a0 02 00 00 00 00 00 00 48 83 c3 20 48 89 d8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 0f 85 e9 23 00 00 41 be 80 00 00 00 44 23 33
RSP: 0018:ffffc900037af7a0 EFLAGS: 00010202
RAX: 0000000000000004 RBX: 0000000000000020 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffff8881b465c918 RDI: 0000000000000000
RBP: ffffc900037afad0 R08: ffffc900037afb80 R09: ffffc900037afba0
R10: dffffc0000000000 R11: ffffffff8463a450 R12: ffff88816b91e678
R13: fffff520006f5f1c R14: dffffc0000000000 R15: ffff8881b465c918
FS:  00007f65b5e096c0(0000) GS:ffff8882a8cd9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f65b4feb840 CR3: 000000016a860000 CR4: 00000000000006f0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	e8 23 21 d4 fd       	call   0xfdd42128
   5:	49 8b 04 24          	mov    (%r12),%rax
   9:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
   e:	41 c6 45 2c 04       	movb   $0x4,0x2c(%r13)
  13:	c7 84 24 a0 02 00 00 	movl   $0x0,0x2a0(%rsp)
  1a:	00 00 00 00
  1e:	48 83 c3 20          	add    $0x20,%rbx
  22:	48 89 d8             	mov    %rbx,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 e9 23 00 00    	jne    0x241f
  36:	41 be 80 00 00 00    	mov    $0x80,%r14d
  3c:	44 23 33             	and    (%rbx),%r14d


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a fix for this bug, please reply with `#syz test`
(on a separate line) and attach the patch to the email.

Notes:
- The patch will be applied on top of the tested series (as an
  incremental fix).
- To test a new version of the whole series, please send it directly
  to syzbot@lists.linux.dev.
- Arguments like custom git repos and branches are not supported.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
