Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F285FD461F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Feb 2026 06:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QlCwu9+9W8JAb1jSi+vKCJI4vAENWgMa7Rq4I33xmjw=; b=B7/BygSa0VpCtz4/s34tbBFcbs
	uhdiWu88ExMsSAmvVUunf0IEMOswPVZTrxzxhV89VRu2Kgwu/qJ6lJWVWnpLmWMbn4OZpbzKfagdC
	VsMdgvWUv7MWKlbl5WKxkXqyN26dIfoEWUIMgRBGdirtypF3asUOWzyB3VaHJGMH3XcY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vvUhl-0006Au-PB;
	Thu, 26 Feb 2026 06:18:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3rOWfaQkbAEs5BCxnyyr4n22vq.t11tyr75r4p106r06.p1z@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1vvUhf-0006Ak-J0 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 06:18:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pfEp6IXCKbLOFmkdSl5qd6w1nd5cyXI9rCt5gVdNXws=; b=L6PP6EPfqVaN8yM11bB3Oj4R9N
 NtqujqftqP5S0BE1rOIIkZycfNIC6M3NxdoiYxXvdtSDl/yr040XxZmm69azdSAJM9Kvq8kTp4cGW
 mxztaTK/e+g1pqR/gvU8R28hHoPSOa3MRCwKEhnW/bw33mCKo8XJLEiSNCDpDMvKkI2A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pfEp6IXCKbLOFmkdSl5qd6w1nd5cyXI9rCt5gVdNXws=; b=h
 CthKLlg8bxmrdyXwOd6vO6HGolPrVnjWZOhC+EBXwGsR9Lw8ro0TOFeTkqtF0Hzy5RjiGnVF4f2E/
 B+oSmtPIc6u5FPBZMlJVinI0aotOMpIsTjcBW+dNCz/3x2CQ4Jc1q2FN/bsdxPFYN3mv1mslWkF+A
 HRFex3oG/K5yqGz4=;
Received: from mail-oo1-f71.google.com ([209.85.161.71])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vvUhe-0007fX-BI for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 06:18:27 +0000
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-679c51b2d6cso9569417eaf.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 25 Feb 2026 22:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772086700; x=1772691500;
 h=to:from:subject:message-id:date:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pfEp6IXCKbLOFmkdSl5qd6w1nd5cyXI9rCt5gVdNXws=;
 b=mmISvJhdJwtXvxF8mqVhTHsaQEpXPxA21tKwRAdvv2xL9wiR6n78PBiFxYfiXH1C8X
 Bztxb7ZUuP113EUBD386kHcwGnyNk+4vo6Kdty/tEURT3CdwF6wemE0hGAQCqf4AtFZq
 Yvd5vFmsXRGtIPnCiezUuVIQOqqY0BULq5omS9/6gdKJGEicXAMbHtUhiOqZwz6IqXqX
 BOCiieqy5tUN6kn4Ydn0NdaK+8PFXqUeUYYUEC7YypEbAMVsp/PmiIfwPNavM36AtebE
 4z6qO8Dx/tT61hLwLxev6iTkHo0D7413kGYOZjyL4MPO/H03H92WCpifqNreCs0fK9ax
 +LBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhx1ggWIaqEQcT+jM6gdmSVvt4gApBAY9y5rbZj0oirLXU3CNbeKPZYGcwUa2bh1vdzwoXYOxTrp5NlhEPM9Eq@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwuQ9kV5JfdUdReJwJwDo4V54vx3sZFtuVHFIy7Z8DYAlbzZhoU
 qbLN85KGSPv2K9CZklkNagRYmi23UFxv3G2RpTzJAi0fPQTPnp9qqlEYwCPkRyJh1nr1eiX3Lb7
 Rx1U0l+svmQol70Vm7GEQs6gUO7j4e43VNzIr/cncdAaeKB5+7Dqf+P4wR1Q=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:622:b0:679:e7b2:9fc8 with SMTP id
 006d021491bc7-679e7b2a0c2mr2993612eaf.1.1772086700739; Wed, 25 Feb 2026
 22:18:20 -0800 (PST)
Date: Wed, 25 Feb 2026 22:18:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699fe5ac.050a0220.2fcbed.0003.GAE@google.com>
From: syzbot <syzbot+73d18077a2323a1fdb5e@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1vvUhe-0007fX-BI
Subject: [f2fs-dev] [syzbot] [f2fs?] INFO: task hung in f2fs_fallocate (6)
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

HEAD commit:    d4906ae14a5f Add linux-next specific files for 20260220
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13f24006580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cdf9388b212a2b28
dashboard link: https://syzkaller.appspot.com/bug?extid=73d18077a2323a1fdb5e
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1312395a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a4855a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1537e9684d19/disk-d4906ae1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dd6c9977a9cf/vmlinux-d4906ae1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f1d85a2d6c78/bzImage-d4906ae1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2471b6f6a299/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=149a0202580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+73d18077a2323a1fdb5e@syzkaller.appspotmail.com

INFO: task syz.1.18:6046 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.18        state:D stack:28832 pid:6046  tgid:6042  ppid:6019   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x1585/0x5340 kernel/sched/core.c:6907
 __schedule_loop kernel/sched/core.c:6989 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7004
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7061
 rwsem_down_write_slowpath+0x899/0x1040 kernel/locking/rwsem.c:1185
 __down_write_common kernel/locking/rwsem.c:1317 [inline]
 __down_write kernel/locking/rwsem.c:1326 [inline]
 down_write+0x1bc/0x200 kernel/locking/rwsem.c:1591
 inode_lock include/linux/fs.h:1028 [inline]
 f2fs_fallocate+0x24e/0x9b0 fs/f2fs/file.c:2013
 vfs_fallocate+0x669/0x7e0 fs/open.c:340
 ksys_fallocate fs/open.c:364 [inline]
 __do_sys_fallocate fs/open.c:369 [inline]
 __se_sys_fallocate fs/open.c:367 [inline]
 __x64_sys_fallocate+0xc0/0x110 fs/open.c:367
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa61c59c629
RSP: 002b:00007fa61d448028 EFLAGS: 00000246
 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007fa61c816090 RCX: 00007fa61c59c629
RDX: 0000000000004000 RSI: 0000000000000008 RDI: 0000000000000004
RBP: 00007fa61c632b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000010000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa61c816128 R14: 00007fa61c816090 R15: 00007ffcfdb9b178
 </TASK>

Showing all locks held in the system:


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

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
