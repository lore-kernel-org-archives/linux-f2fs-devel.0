Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832F9C5DF7E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=srZpcDZpXCbsenDuFMlliGXgNsLsSOlG9WtcGWXcJOM=; b=mSr69F+WIcQ0r70zT6Z1QBhuYC
	DawFnqQ4pbf1K2se6bG6t/m9V6IXKJRTti9LOAf56Ibe9lrvi+DSnhB5bg/pyG2Aow0gFGhUyvI6y
	R4j1VOUOfI7ZmxYWfLiQCPVi9AzFpZBIFE3uzAn5ivbJJreIV9JE8F7gvFg+A2TRRJak=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwILP-0006Mt-Pq;
	Tue, 18 Aug 2026 11:51:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wwILA-0006MY-52
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 11:50:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z9b5XXuybQ7GI+3Z2/bQurGayFuYmB1m5lZSagDKMcU=; b=nJ+l8Z3272L7712YGrE1Yz5PU9
 A0ww1v3lmbsE7dIBynlrej+mGOUF7W8fV+dQ768RvDbWv7kyFOwyuuXb65d/2q+2JWy2y7IzTk0so
 +GPiIZi7gVb9NVfsoZsnwv6h0GeeVoCYvqbkXs0hjDVAzrA9QuSZhqwq5qda8CJq7PFw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Z9b5XXuybQ7GI+3Z2/bQurGayFuYmB1m5lZSagDKMcU=; b=AUY0T1NqgVE8q+DUoDqkgZufy1
 xEkQyDkbTRoJhxZR56guLWTXksS7f1WVoQvW/mXV6Pvbd+DDTClCF1wADxYJ9PhStZJW+VDk+WXtQ
 cV9ctlkrprgEPvkt/uBXwH7t0zoL/WNhvDmINS/TZgp5Y5pQvUdKn2fsDJCi9QyD25Mk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwIL6-0006gn-Ry for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 11:50:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1FB1340B41;
 Tue, 18 Aug 2026 11:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4D11F000E9;
 Tue, 18 Aug 2026 11:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787053839;
 bh=Z9b5XXuybQ7GI+3Z2/bQurGayFuYmB1m5lZSagDKMcU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=U1xOEDh+QxbsjGPMT7UcyO02InVuQwtioOAzzUJMDx0QSMxkvB/Nz+57+0e9fBSCh
 HJJmgVUscYoditRDj9DG1KEUjc9qvkjQBo3+H6oyjLwvFqgjkA+Q2091eoy0ca/Gcd
 KjESm/9rOBu7xsBrbSabDGo5XuHSxll1NjkyZzFGvYspNki9hm48waTYQ5CevcP/2p
 S3gYdp3XUHRhxCdYNuOQg+mTUM6BxGAw1Ma4dK17fDI+k6OYsLoFOoGfgZKFK8JxnQ
 1phpE/jZyOuWanPJPzeewdv+9NBBW7De2R0H0pnMe1/70SXy9yBb7ZimHPmEACHM2p
 3RqzO7vQ8Zk4w==
Message-ID: <40fef665-0a29-4c44-9ce0-e02e6dc8d07b@kernel.org>
Date: Tue, 18 Aug 2026 19:50:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot <syzbot+014a7b70788139e6196d@syzkaller.appspotmail.com>,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <6a834262.4d75e56a.c9a88.0002.GAE@google.com>
Content-Language: en-US
In-Reply-To: <6a834262.4d75e56a.c9a88.0002.GAE@google.com>
X-Headers-End: 1wwIL6-0006gn-Ry
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] WARNING: suspicious RCU usage in
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/common

On 8/18/26 01:18, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4477a78374a5 Add linux-next specific files for 20260814
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=150bea25580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9b32a36dd637b06f
> dashboard link: https://syzkaller.appspot.com/bug?extid=014a7b70788139e6196d
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d3fa79580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/994c1c8c560e/disk-4477a783.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/cd54543d69ae/vmlinux-4477a783.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/407cdf8f3fc2/bzImage-4477a783.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/12687adce9ef/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=171cd949580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+014a7b70788139e6196d@syzkaller.appspotmail.com
> 
> =============================
> WARNING: suspicious RCU usage
> syzkaller #0 Not tainted
> -----------------------------
> ./include/linux/radix-tree.h:179 suspicious rcu_dereference_check() usage!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> locks held by kworker/u9:3/5775: 4, last CPU#0:
>  #0: ffff88807f597940 ((wq_completion)f2fs_evict_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
>  #0: ffff88807f597940 ((wq_completion)f2fs_evict_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>  #0: ffff88807f597940 ((wq_completion)f2fs_evict_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
>  #0: ffff88807f597940 ((wq_completion)f2fs_evict_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
>  #1: ffffc90003fb7c40 ((work_completion)(&ew->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
>  #1: ffffc90003fb7c40 ((work_completion)(&ew->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>  #1: ffffc90003fb7c40 ((work_completion)(&ew->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
>  #1: ffffc90003fb7c40 ((work_completion)(&ew->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
>  #2: ffff8880b863a820 (lock){+.+.}-{3:3}, at: local_lock_acquire include/linux/local_lock_internal.h:46 [inline]
>  #2: ffff8880b863a820 (lock){+.+.}-{3:3}, at: __radix_tree_preload+0x82/0x870 lib/radix-tree.c:334
>  #3: ffff8880338688c8 (&im->ino_lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:347 [inline]
>  #3: ffff8880338688c8 (&im->ino_lock){+.+.}-{3:3}, at: __set_ino_bitmap fs/f2fs/checkpoint.c:781 [inline]
>  #3: ffff8880338688c8 (&im->ino_lock){+.+.}-{3:3}, at: __f2fs_add_ino_entry+0x14c/0x830 fs/f2fs/checkpoint.c:842
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 5775 Comm: kworker/u9:3 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> Workqueue: f2fs_evict_wq f2fs_evict_inode_work
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6938
>  radix_tree_deref_slot include/linux/radix-tree.h:179 [inline]
>  __set_ino_bitmap fs/f2fs/checkpoint.c:784 [inline]
>  __f2fs_add_ino_entry+0x782/0x830 fs/f2fs/checkpoint.c:842
>  f2fs_record_inode_state fs/f2fs/inode.c:877 [inline]
>  f2fs_evict_inode_work+0xa1/0x120 fs/f2fs/inode.c:887
>  process_one_work kernel/workqueue.c:3387 [inline]
>  process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
>  worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
>  kthread+0x38b/0x480 kernel/kthread.c:436
>  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
