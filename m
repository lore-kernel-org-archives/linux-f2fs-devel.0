Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BB6C61DFD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wckbvauA4n76wny4c6b5Ojjmsv9kEP/gfTofs0D8myY=; b=JjKXpXEolseZap5FiQatOa0mN9
	XUGtw6cD2DUOWn2nGfyVQKAZyNCvTSDud4AQ72lWKL17kTcQ5CEIzICk7S7pNJmgUx7KSO3C4J9Qj
	bpYSR4+f2WVO80OPe42wPUwj6MGufBMPqc5lg2AppxrYWIONU28Bz4MdPw/zyKRZ3TBw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1cGy-0006hy-7n;
	Wed, 02 Sep 2026 04:08:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <39ZqXagkbAOQYefQGRRKXGVVOJ.MUUMRKaYKXIUTZKTZ.IUS@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1x1cGw-0006hj-Jx for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 04:08:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WknVe6YbEwHTjQ8SnS3LNO11L5BkxkkKwGa2maUHawk=; b=mnRVVwl3llSo9SQTHDNkbGobKp
 t2rCBL9E77wSY62Aj4APDv7cgN+0jwgkGp/hZnEg3MICccnWV+qyEmJ/oecNrqf+DVElPPzfvL4Y9
 EJgWrK1us25k7fdyfCKM2uZidyXMWllW7LPREjc5BVXnQre9EHEHfGchQJyWpYIm7DsY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WknVe6YbEwHTjQ8SnS3LNO11L5BkxkkKwGa2maUHawk=; b=I
 GKf27uVLDX3oQMd6rWtiljPYV1H7XzveTu6/Dvwt/CU0Qr0SJwxdK/ddCLcXpItNklFlWc42OTsnA
 q3GJXC3RF7ymefOrh/VWSGdte3pgWloGt0ATdswVxDOQG9OW4PENZhdy9Xwhxcd1SE62qlwRlvl7f
 f5m3/wrrviGJa5wc=;
Received: from mail-qk2-f4.google.com ([74.125.230.196])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1cGw-0006bp-Lt for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 04:08:27 +0000
Received: by mail-qk2-f4.google.com with SMTP id
 d75a77b69052e-51c26eb5e81so2637251cf.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 21:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788322101; x=1788926901;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WknVe6YbEwHTjQ8SnS3LNO11L5BkxkkKwGa2maUHawk=;
 b=JAJLZUIC5H1inT7bF+4/Xq9gLgFwojMAX9YtSDISTWof4ja7blMpHPCBvg+9jEOcXC
 1F5L73RferStL6AzKy6D6e82uVq7ZSEZJFI/2yDFms8aKSW1pub+Wo4SNDRfYMpiriVx
 aMZsPAYiu6S9Rj0fTB3fJZfkctmmCfsP1ZF4fbJoDbA/k8Z5dWu0BHpC2I7rAwb+oYsm
 ZsyX/wamvTtW1+YmkfToMuPyw1lNGLmmnjViqxzTpHbTFFL25xk6RbHtkvY9dij8/ywH
 jbt2RUbuTAwNzLm0iQLYlPCnBOPkIaiUmqTpDKvqJdmIo4emmoCYEEW+hoyHohcLf3sk
 Z/Cg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrlGEyDjvM3dFcbYKBv78giDEkMv/+IPc8sWZJglr8Oi6AIPCh9/pwyQzmTF6bJ0GHXHoZPY425xj31oZXYDocH@lists.sourceforge.net
X-Gm-Message-State: AFuF++mH5ld7d3+6SU0J0yE5o+s25DnixitYvX1fnbablFnDiNg+Z2ik
 f1rfvlAimsoPDDi8GgRcSNUUrqu9/t67a0O1cq+eEyZ5YhAbxMoiJ3KL4Mf1Cx09JMiKyrPd7kb
 eZ4wnLoL5PjLtGbfAcZ6Ch4sF84ZOLGEyR5VJ74i9GFR97hAcmtJrTcGlDtY=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c84:b0:6b1:6136:956a with SMTP id
 006d021491bc7-6b47fc2dfa3mr1688847eaf.15.1788320501447; Tue, 01 Sep 2026
 20:41:41 -0700 (PDT)
Date: Tue, 01 Sep 2026 20:41:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a979af5.e163c37b.143a1.0004.GAE@google.com>
From: syzbot <syzbot+ae5b8eb92ed40411ce16@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1x1cGw-0006bp-Lt
Subject: [f2fs-dev] [syzbot] [f2fs?] general protection fault in new_curseg
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

HEAD commit:    89a312991dc6 Merge tag 'cifs-fixes-7.3-rc2' of https://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1075e779580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e909ffe6b35dddb7
dashboard link: https://syzkaller.appspot.com/bug?extid=ae5b8eb92ed40411ce16
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-89a31299.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/114a4744ab8e/vmlinux-89a31299.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c65021627f2c/bzImage-89a31299.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ae5b8eb92ed40411ce16@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
CPU: 0 UID: 0 PID: 12 Comm: kworker/u4:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: writeback wb_workfn (flush-7:0)
RIP: 0010:f2fs_dev_is_alloc_blocked fs/f2fs/segment.h:956 [inline]
RIP: 0010:get_new_segment fs/f2fs/segment.c:2964 [inline]
RIP: 0010:new_curseg+0x1134/0x3580 fs/f2fs/segment.c:3110
Code: e8 21 ab ce fd 48 8b 7c 24 30 48 8b 07 49 6b cf 70 4c 8d 34 08 49 83 c6 61 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 0f 85 73 11 00 00 41 80 3e 00 0f 84 e6 00 00 00
RSP: 0018:ffffc9000025e628 EFLAGS: 00010206
RAX: 000000000000000c RBX: 0000000000008000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000008000 RDI: ffff888012125a88
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff5200004bcb4 R12: ffff888052be0000
R13: 0000000000000004 R14: 0000000000000061 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88808c2cf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200001000000 CR3: 000000004fe72000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 f2fs_allocate_data_block+0x229c/0x43c0 fs/f2fs/segment.c:3979
 do_write_page+0x13f/0x880 fs/f2fs/segment.c:4099
 f2fs_outplace_write_data+0x11a/0x220 fs/f2fs/segment.c:4175
 f2fs_write_compressed_pages fs/f2fs/compress.c:1403 [inline]
 f2fs_write_multi_pages+0x43bb/0x6370 fs/f2fs/compress.c:1602
 f2fs_write_cache_pages fs/f2fs/data.c:3351 [inline]
 __f2fs_write_data_pages fs/f2fs/data.c:3603 [inline]
 f2fs_write_data_pages+0x19bb/0x36f0 fs/f2fs/data.c:3641
 do_writepages+0x338/0x560 mm/page-writeback.c:2560
 __writeback_single_inode+0x136/0x1220 fs/fs-writeback.c:1788
 writeback_sb_inodes+0x9de/0x1b00 fs/fs-writeback.c:2099
 __writeback_inodes_wb+0x114/0x240 fs/fs-writeback.c:2175
 wb_writeback+0x42f/0xad0 fs/fs-writeback.c:2286
 wb_check_start_all fs/fs-writeback.c:2412 [inline]
 wb_do_writeback fs/fs-writeback.c:2459 [inline]
 wb_workfn+0x980/0x10f0 fs/fs-writeback.c:2497
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_dev_is_alloc_blocked fs/f2fs/segment.h:956 [inline]
RIP: 0010:get_new_segment fs/f2fs/segment.c:2964 [inline]
RIP: 0010:new_curseg+0x1134/0x3580 fs/f2fs/segment.c:3110
Code: e8 21 ab ce fd 48 8b 7c 24 30 48 8b 07 49 6b cf 70 4c 8d 34 08 49 83 c6 61 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 0f 85 73 11 00 00 41 80 3e 00 0f 84 e6 00 00 00
RSP: 0018:ffffc9000025e628 EFLAGS: 00010206
RAX: 000000000000000c RBX: 0000000000008000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000008000 RDI: ffff888012125a88
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff5200004bcb4 R12: ffff888052be0000
R13: 0000000000000004 R14: 0000000000000061 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88808c2cf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200001000000 CR3: 000000004fe72000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	e8 21 ab ce fd       	call   0xfdceab26
   5:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
   a:	48 8b 07             	mov    (%rdi),%rax
   d:	49 6b cf 70          	imul   $0x70,%r15,%rcx
  11:	4c 8d 34 08          	lea    (%rax,%rcx,1),%r14
  15:	49 83 c6 61          	add    $0x61,%r14
  19:	4c 89 f0             	mov    %r14,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 73 11 00 00    	jne    0x11a9
  36:	41 80 3e 00          	cmpb   $0x0,(%r14)
  3a:	0f 84 e6 00 00 00    	je     0x126


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
