Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F52FD4F35
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Mar 2026 20:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=voZ4N+WsHkyZ/a3Gy00oaeNoGWuJOwCFH4Jc+VX3kuk=; b=cPBPDSRj2n5zfuY0WIx+n/OJoS
	jm7tzDIV64u5wBN4HisvvsE4lWWBKw004pX+12vcW9IzQEVzRBmxKWIjY5H9fQkOl0Pjcw4nluKNR
	eoONGpAIY/Pha6YQD4/8zOT1QkMC/R/pmz925xoZvv4GK2sGIGgV8hhv1ZK10J57XiRc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w03b6-0007Lq-Lw;
	Tue, 10 Mar 2026 20:22:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3fH2waQkbAI09FG1r22v8r66zu.x55x2vB9v8t54Av4A.t53@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1w03b5-0007Lj-FX for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Mar 2026 20:22:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bjBF6qoYBijr9UqZ/693jcBIL08PLtrpQB2lTanJAtc=; b=ASgW4kodtoqCEVTHJZNit/akmQ
 TgJWix+qFVipb8Pvuxm9uUthyIyBCdg6ZV1d1VW/F9xqfEnPVOGfQtFy/Ir2oWnF4zJW1pDbaq0Sf
 y57CgEUgJ9QQY25S1ZvI8kLrCcVJaKdlT0OUXJ+DhUu31ZynIof/hUghXdO3fne65l7I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bjBF6qoYBijr9UqZ/693jcBIL08PLtrpQB2lTanJAtc=; b=d
 9hrxl8tWZa+otOKKSvqADQ5XIQiuWtSdpI9NTcxQfZFEc9o3iNAz2kTDxQa9eoryTMfiaQlc5vuDr
 ZY2CGHDFPVckQGU1Jodrtn4U+2rJKcYpG3VlHuzqBG2lmHvrH5mk//oQizeX1TV7DPnCPCtV/tCZ2
 ju00vdb2+Yit++xA=;
Received: from mail-oo1-f69.google.com ([209.85.161.69])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1w03b4-0000te-MO for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Mar 2026 20:22:31 +0000
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-67bb6081a0dso32005792eaf.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 10 Mar 2026 13:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773174140; x=1773778940;
 h=to:from:subject:message-id:date:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bjBF6qoYBijr9UqZ/693jcBIL08PLtrpQB2lTanJAtc=;
 b=uLHAondIIsrrmU5R+J5yufQsnApHeqfzDukJF/fUCL6dxxFcbO2wphuyvcl3my43Mg
 /ggy4ev5yd/dUug6yvEnHgzDLx3Ttx0vq6KFs7YdSKUAWnPBRl3BKIz8BI+SsCTWUxdm
 g4Mfxbn4J99ngUD0GBIYDaAfHsnBq+8MimYLOH9anX2gDhBgiQhKq7gGwUDITIr7rR1o
 s7AhxZ+cvfELHUWxWc11Ir2eiCDvUhWDSjeN5yucEvGrFmwDbbyA53ZmckBcIV9Eb3YC
 Yow/qJ/B3jiVef4q2a6fVe5JfgI982a8SWPPWnMNx6XcISpVIMV9x1alJRdPaloCgw/E
 3Dzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtnVqFu5al47x/d2xgmT+7CxXe+YmklrN2BiAQ1bj2bNZ4lYs0l9m7boTMEr0Kt2r82ZzRc+61xiP7bffpUTbN@lists.sourceforge.net
X-Gm-Message-State: AOJu0YymzGHOsRKhdoq0gKlqvxIQ6wz3zmOlF5gA4Gdhi6fKSxfe+JiZ
 CRJJurQ/OyyNiXejjuSghTQMeTbx+hPDAMkDcHoaIB3LvcoG3MBpGyZYLjwty/HAMrbMpPrjjAu
 7p7U2a9g6ImJD/7ShO2uRtTjYjTRH1K9pnRCeCidNxMvvqGvA+8n9DBg2Y/Y=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3086:b0:67b:b45c:bd71 with SMTP id
 006d021491bc7-67bc8a8a653mr72541eaf.73.1773174140016; Tue, 10 Mar 2026
 13:22:20 -0700 (PDT)
Date: Tue, 10 Mar 2026 13:22:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b07d7c.050a0220.8df7.09a1.GAE@google.com>
From: syzbot <syzbot+62538b67389ee582837a@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1w03b4-0000te-MO
Subject: [f2fs-dev] [syzbot] [f2fs?] kernel BUG in f2fs_issue_discard_timeout
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

HEAD commit:    651690480a96 Merge tag 'spi-fix-v7.0-rc2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157f58d6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a019678b1a3a692
dashboard link: https://syzkaller.appspot.com/bug?extid=62538b67389ee582837a
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd03debd6a84/disk-65169048.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a72bd6fa116/vmlinux-65169048.xz
kernel image: https://storage.googleapis.com/syzbot-assets/251bc9642a29/bzImage-65169048.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62538b67389ee582837a@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/f2fs/segment.c:1900!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6527 Comm: syz.5.110 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:f2fs_issue_discard_timeout+0x59b/0x5a0 fs/f2fs/segment.c:1900
Code: d9 80 e1 07 80 c1 03 38 c1 0f 8c d6 fe ff ff 48 89 df e8 a8 5e fa fd e9 c9 fe ff ff e8 4e 46 94 fd 90 0f 0b e8 46 46 94 fd 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc9000494f940 EFLAGS: 00010283
RAX: ffffffff843009ca RBX: 0000000000000001 RCX: 0000000000080000
RDX: ffffc9001ca78000 RSI: 00000000000029f3 RDI: 00000000000029f4
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed100893a431 R12: 1ffff1100893a430
R13: 1ffff1100c2b702c R14: dffffc0000000000 R15: ffff8880449d2160
FS:  00007ffa35fed6c0(0000) GS:ffff88812643d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2b68634000 CR3: 0000000039f62000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __f2fs_remount fs/f2fs/super.c:2960 [inline]
 f2fs_reconfigure+0x108a/0x1710 fs/f2fs/super.c:5443
 reconfigure_super+0x227/0x8a0 fs/super.c:1080
 do_remount fs/namespace.c:3391 [inline]
 path_mount+0xdc5/0x10e0 fs/namespace.c:4151
 do_mount fs/namespace.c:4172 [inline]
 __do_sys_mount fs/namespace.c:4361 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4338
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffa37dbda0a
Code: 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffa35fece58 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffa35fecee0 RCX: 00007ffa37dbda0a
RDX: 0000200000000180 RSI: 0000200000000000 RDI: 0000000000000000
RBP: 0000200000000180 R08: 00007ffa35fecee0 R09: 00000000018424bc
R10: 00000000018424bc R11: 0000000000000246 R12: 0000200000000000
R13: 00007ffa35fecea0 R14: 0000000000000000 R15: 00002000000003c0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_issue_discard_timeout+0x59b/0x5a0 fs/f2fs/segment.c:1900
Code: d9 80 e1 07 80 c1 03 38 c1 0f 8c d6 fe ff ff 48 89 df e8 a8 5e fa fd e9 c9 fe ff ff e8 4e 46 94 fd 90 0f 0b e8 46 46 94 fd 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc9000494f940 EFLAGS: 00010283
RAX: ffffffff843009ca RBX: 0000000000000001 RCX: 0000000000080000
RDX: ffffc9001ca78000 RSI: 00000000000029f3 RDI: 00000000000029f4
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed100893a431 R12: 1ffff1100893a430
R13: 1ffff1100c2b702c R14: dffffc0000000000 R15: ffff8880449d2160
FS:  00007ffa35fed6c0(0000) GS:ffff88812643d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2b68634000 CR3: 0000000039f62000 CR4: 00000000003526f0


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
