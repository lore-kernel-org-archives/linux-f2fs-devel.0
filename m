Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691A7C5DF70
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Nw9duBFb7YhX7JH2NIEs/gyMh3oqOa7i/X/IUGbwwrk=; b=Zp6yiYwveGQ+X/P8Ql2wd3AY/a
	ZaroLDmoWJnE6rwyMx4IuDZnCci7+ReuW30tlbYnc+7x8I62dF8vkjzO1hV17Xw6ZWJJQEyuI6qy/
	sAhflMcbUfEUa8JeKeksBll+aSZTtEr3lxb+uyJBQ7ulhZvfL9Gevt6fc87LeppxGJEk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ww0yo-0001El-84;
	Mon, 17 Aug 2026 17:18:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3YkKDagkbAE89FG1r22v8r66zu.x55x2vB9v8t54Av4A.t53@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1ww0ym-0001EW-R5 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 17:18:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ld6FH4QpO5L065SRwsrRGyQwH2sHUvD5cM4LrAxxHZc=; b=d+AAyp1UILmU0E0XFtTCpVOMlr
 jn6JC5UCJ+WeEkPgt+siZxWzwmaztq8bpgOaKJpnXSSoiw/XBWDorC//dNhtlTwQhcbjlI1uVNH+0
 P19nSIpW/M330Yn6Ajbs6h3Z79sFyogts2j7A3tMWnYSfFdRKad+u7nWJGjGbT8YM5yw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ld6FH4QpO5L065SRwsrRGyQwH2sHUvD5cM4LrAxxHZc=; b=K
 h7veCzYqyqZCr/w0NUZFNjcPX4tucReFtP9h5iLpD5QmyKVg/RQfDphap7X5OUoWH1KFMG3ihaJpN
 /bFFZvYopqqWujdYNGUUtA9Zs7pvfxybz+WFHAKi8ddIwLLNaMushWA5yFtS/NMlL0jtaliaWX5io
 oHNK02lZq2ED4Gas=;
Received: from mail-oi1-f207.google.com ([209.85.167.207])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ww0yp-0001DF-O0 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 17:18:33 +0000
Received: by mail-oi1-f207.google.com with SMTP id
 5614622812f47-4af9bf0f53bso4348126b6e.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 10:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786987106; x=1787591906;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ld6FH4QpO5L065SRwsrRGyQwH2sHUvD5cM4LrAxxHZc=;
 b=GKxreoFMD9LtLwAPsdBZYYikCUuS4cjRYnAMtnKIuI6K1k+seudvCZ3cJbfLucAuZF
 b2JJXGIKyunIlgZXPB1HEP6N47lX3EpiBSe5pcyZ1TyMBQnDarvBAi/BEYBHc9XxVOBJ
 hb11CHMizhFPQQpKamAbZU79EuSbNzW1giYNrqwnfMmBpt7pgaky1FvFZ04q9TvILiBe
 YhhKtRA4mzzd8v/U0k7O5dtOvh/e9YwXaD2qCBGWHv2YKNuoCfWwicRo80S8GxKEHFWj
 uHwWR8JcgI7HfSDFnfev/UN/x+S2AzXaaSdut5iv/BZfoIrFYJe8kWdrAzooSq3rr+kV
 RoOA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rphb+bTabCLU2HSoQUci1rd17YU59EqAfx06Y9VPVlOHrwRkD5EUtEYUePfjHq3+FBKvzNbG//lVYOM2oAbNqvO@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz1EN2/GaGohiluwvH69oI6Kp5+fUXm6Ccw7ppZzo0dtX/k9w1X
 tyTNhAEeCDU3U8tRRKUXHJpYi/PpIj3tQy42qZsCkdKhksPsybNn4wkGl4WVN/M6M/9THL4IiaR
 K/ruTspl0FhNza2m3KpmMm9kxCbjz3vReybiz9u1xgJNBDJF7oDQYc4pNYVM=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c3ec:b0:4aa:cad:cb4c with SMTP id
 5614622812f47-4b240f875b2mr22702284b6e.1.1786987106545; Mon, 17 Aug 2026
 10:18:26 -0700 (PDT)
Date: Mon, 17 Aug 2026 10:18:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a834262.4d75e56a.c9a88.0002.GAE@google.com>
From: syzbot <syzbot+014a7b70788139e6196d@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1ww0yp-0001DF-O0
Subject: [f2fs-dev] [syzbot] [f2fs?] WARNING: suspicious RCU usage in
 __f2fs_add_ino_entry
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
console output: https://syzkaller.appspot.com/x/log.txt?x=150bea25580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9b32a36dd637b06f
dashboard link: https://syzkaller.appspot.com/bug?extid=014a7b70788139e6196d
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d3fa79580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/994c1c8c560e/disk-4477a783.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cd54543d69ae/vmlinux-4477a783.xz
kernel image: https://storage.googleapis.com/syzbot-assets/407cdf8f3fc2/bzImage-4477a783.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/12687adce9ef/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=171cd949580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+014a7b70788139e6196d@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
./include/linux/radix-tree.h:179 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
locks held by kworker/u9:3/5775: 4, last CPU#0:
 #0: ffff88807f597940 ((wq_completion)f2fs_evict_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88807f597940 ((wq_completion)f2fs_evict_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88807f597940 ((wq_completion)f2fs_evict_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
 #0: ffff88807f597940 ((wq_completion)f2fs_evict_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
 #1: ffffc90003fb7c40 ((work_completion)(&ew->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90003fb7c40 ((work_completion)(&ew->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90003fb7c40 ((work_completion)(&ew->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
 #1: ffffc90003fb7c40 ((work_completion)(&ew->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
 #2: ffff8880b863a820 (lock){+.+.}-{3:3}, at: local_lock_acquire include/linux/local_lock_internal.h:46 [inline]
 #2: ffff8880b863a820 (lock){+.+.}-{3:3}, at: __radix_tree_preload+0x82/0x870 lib/radix-tree.c:334
 #3: ffff8880338688c8 (&im->ino_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:347 [inline]
 #3: ffff8880338688c8 (&im->ino_lock){+.+.}-{3:3}, at: __set_ino_bitmap fs/f2fs/checkpoint.c:781 [inline]
 #3: ffff8880338688c8 (&im->ino_lock){+.+.}-{3:3}, at: __f2fs_add_ino_entry+0x14c/0x830 fs/f2fs/checkpoint.c:842

stack backtrace:
CPU: 0 UID: 0 PID: 5775 Comm: kworker/u9:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: f2fs_evict_wq f2fs_evict_inode_work
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6938
 radix_tree_deref_slot include/linux/radix-tree.h:179 [inline]
 __set_ino_bitmap fs/f2fs/checkpoint.c:784 [inline]
 __f2fs_add_ino_entry+0x782/0x830 fs/f2fs/checkpoint.c:842
 f2fs_record_inode_state fs/f2fs/inode.c:877 [inline]
 f2fs_evict_inode_work+0xa1/0x120 fs/f2fs/inode.c:887
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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
