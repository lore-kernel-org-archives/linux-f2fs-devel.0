Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43168C5DF66
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LwFZ97ZmFFProrUTyrQAlG1NdNUTmbJ0lKUlSYm6SOY=; b=Q6uSgjYd5xD1GAnAOjR1sWSOy5
	aJwbBlMhA5j3AOnEl+zxYT2R/iQMFfeBOEL8kf3lrkwnlI1KiHe2iUbrf7ug0iiUJaPEvzJnl0amp
	TyOEPm512yONtApHE3ShRozvmQTYegeWcM60CTzwX6O99vsQGzjLy93hTxZOtDTPiN44=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ww1L6-0003HZ-Uz;
	Mon, 17 Aug 2026 17:41:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3xkeDagkbAL0v12ndoohudsslg.jrrjohxvhufrqwhqw.frp@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1ww1L2-0003H6-Lg for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 17:41:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fPIj09CKOiIyPwKzk4p43ltnDz9Y4EvUkGwV6DzV3Fs=; b=WpZNpLxUrrcZhUMglC8Qt4Gwrc
 tb6G5BA13nUBAyJbQvC17O29+seA3sf2m75fQGzIoWQefzNrkmuUL99we4EKW9TYEb+bdbA5XF4W+
 iVqKtZ7YV+6eM7R03IHQ+rPCViIknJd7XSEjJU7uSoH6DNrVzxfPe7yyhfiYaFoqJpDA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fPIj09CKOiIyPwKzk4p43ltnDz9Y4EvUkGwV6DzV3Fs=; b=A
 pjwRJwkjF30yA3M34Ccu1M9xGkk+masgnCyhxU1W8x6jOYFiOt4Ar5sWsRQ2DpS8Hf7RPOmJAjWt+
 IX+py6ENc3s1qGPgq1pr4IYfgOwBSG/K50wQr8lkRmsaDOblntqfk2ekJpEy6YN+NqpEs8Zz+UaNI
 HkcEERUEuXdJzIVE=;
Received: from mail-oi1-f207.google.com ([209.85.167.207])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ww1L2-0005te-0l for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 17:41:33 +0000
Received: by mail-oi1-f207.google.com with SMTP id
 5614622812f47-4afa222912eso1930210b6e.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 10:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786988486; x=1787593286;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fPIj09CKOiIyPwKzk4p43ltnDz9Y4EvUkGwV6DzV3Fs=;
 b=MyxEcgAJvd4cYqfv4+cb1umyw7dezC+cku43+Br9K65I94LYsLimduxbgmdN92G00H
 1ml1NQEmDNHgVyhyFT3hjQaycIZPmXghWbxt9ytXvwnfefqfP9cPqXLVo8igPjP+cEWU
 zz5aTy39dmLGGiw7u0/s5rm8mCfw+ndD8DM383OKkZbK0wt7SRTttKaIVmszwHCrb7EO
 8Nr/DRc0tiINbRpgen7r0LqUheBW6l2Ak+CnXZy/DmWe+U81w3ltvvOUA+b5Ei3Ofvm4
 kkyvOxkIx9qH+TIs+4PRl9pSWaFS7q0uHUCXOE0I5uCL4FKdbKM5dNH88aUonsMjF7AD
 FCbw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrkc2qS2kjxop/UTUcD9uRcPUsCp/Dusgu4haLrI6zyEclHxQb8t0M7rStOeNV2+w8Lg3AaYZnA7t1Ec2Ghllfl@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwqCnulOs9aeo/UM2RtJ8F0YOwz//26ALx5vXp55Hhb6JNM5IM2
 R9+0NxAEJpEiE9iY+WREsNBS8E4Jdejtnz/fA8hsV4ByJgNGWU1CAyBwjI+dT1NxC47FmODuEwS
 ILL+LKn8KOysMEFGCMGmv5GnC/ijPvwM3TVq5jxzrR42y6PGbERpl+/GXgjM=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1506:b0:489:5d05:552c with SMTP id
 5614622812f47-4b241e3c0f7mr20916579b6e.18.1786988486332; Mon, 17 Aug 2026
 10:41:26 -0700 (PDT)
Date: Mon, 17 Aug 2026 10:41:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8347c6.4d75e56a.c9a88.0004.GAE@google.com>
From: syzbot <syzbot+e1fcebe01f24c6309792@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1ww1L2-0005te-0l
Subject: [f2fs-dev] [syzbot] [f2fs?] WARNING: suspicious RCU usage in
 f2fs_remove_ino_entry
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

HEAD commit:    4477a78374a5 Add linux-next specific files for 20260814
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14e5ea25580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9b32a36dd637b06f
dashboard link: https://syzkaller.appspot.com/bug?extid=e1fcebe01f24c6309792
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1320d949580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/994c1c8c560e/disk-4477a783.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cd54543d69ae/vmlinux-4477a783.xz
kernel image: https://storage.googleapis.com/syzbot-assets/407cdf8f3fc2/bzImage-4477a783.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8c65ba7adddd/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=16b9fa79580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e1fcebe01f24c6309792@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
./include/linux/radix-tree.h:179 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
locks held by syz-executor/5756: 2, last CPU#0:
 #0: ffff888079faa0e8 (&type->s_umount_key#56){+.+.}-{4:4}, at: __super_lock fs/super.c:60 [inline]
 #0: ffff888079faa0e8 (&type->s_umount_key#56){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:75 [inline]
 #0: ffff888079faa0e8 (&type->s_umount_key#56){+.+.}-{4:4}, at: deactivate_super+0xac/0xe0 fs/super.c:631
 #1: ffff88801cf908c8 (&im->ino_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:347 [inline]
 #1: ffff88801cf908c8 (&im->ino_lock){+.+.}-{3:3}, at: __clear_ino_bitmap fs/f2fs/checkpoint.c:809 [inline]
 #1: ffff88801cf908c8 (&im->ino_lock){+.+.}-{3:3}, at: f2fs_remove_ino_entry+0x18d/0x3f0 fs/f2fs/checkpoint.c:855

stack backtrace:
CPU: 0 UID: 0 PID: 5756 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6938
 radix_tree_deref_slot include/linux/radix-tree.h:179 [inline]
 __clear_ino_bitmap fs/f2fs/checkpoint.c:812 [inline]
 f2fs_remove_ino_entry+0x3ae/0x3f0 fs/f2fs/checkpoint.c:855
 f2fs_delete_inode fs/f2fs/inode.c:946 [inline]
 f2fs_evict_inode+0x83d/0x21f0 fs/f2fs/inode.c:1100
 evict+0x624/0xb50 fs/inode.c:822
 f2fs_pre_evict_inode fs/f2fs/inode.c:911 [inline]
 f2fs_evict_inode+0x20f/0x21f0 fs/f2fs/inode.c:1096
 evict+0x624/0xb50 fs/inode.c:822
 dispose_list fs/inode.c:864 [inline]
 evict_inodes+0x7e3/0x870 fs/inode.c:918
 generic_shutdown_super+0xaa/0x2d0 fs/super.c:755
 kill_block_super+0x44/0xa0 fs/super.c:1918
 kill_f2fs_super+0x3b3/0x700 fs/f2fs/super.c:5635
 deactivate_locked_super+0xbc/0x110 fs/super.c:603
 cleanup_mnt+0x3d3/0x460 fs/namespace.c:1317
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x204/0x770 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:336 [inline]
 do_syscall_64+0x328/0x520 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f896299f317
Code: a2 c7 05 dc 43 25 00 00 00 00 00 eb 96 e8 e1 12 00 00 90 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffc3257e798 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f8962a34474 RCX: 00007f896299f317
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffc3257e850
RBP: 00007ffc3257e850 R08: 00007ffc3257f850 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc3257f8e0
R13: 00007f8962a34474 R14: 0000000000016591 R15: 00007ffc3257f920
 </TASK>


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
