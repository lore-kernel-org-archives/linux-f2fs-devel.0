From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: sync/umount hang on 3.18.21, 1.4TB gone after crash
Date: Fri, 25 Sep 2015 08:00:19 +0200
Message-ID: <20150925060018.GC486@schmorp.de>
References: <20150923215850.GC2360@schmorp.de>
	<20150924185023.GE40291@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZfM3Z-0006mJ-Q3
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Sep 2015 06:00:29 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZfM3X-000413-BO
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Sep 2015 06:00:29 +0000
Content-Disposition: inline
In-Reply-To: <20150924185023.GE40291@jaegeuk-mac02>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Thu, Sep 24, 2015 at 11:50:23AM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > When I came back after ~10 hours, I found a number of hung task messages
> > in syslog, and when I entered sync, sync was consuming 100% system time.
> 
> Hmm, at this time, it would be good to check what process is stuck through
> sysrq.

It was only intermittently, but here they are. The first one is almost
certainly the sync that I originally didn't have a backtrace for, the
second one is one that came up frequently during the f2fs test.

   INFO: task sync:10577 blocked for more than 120 seconds.
         Tainted: G        W  OE   4.2.1-040201-generic #201509211431
   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
   sync            D ffff88082ec964c0     0 10577  10549 0x00000000
    ffff88000210fdc8 0000000000000082 ffff88062ef2a940 ffff88010337e040
    0000000000000246 ffff880002110000 ffff8806294915f8 ffff8805c939b800
    ffff88000210fe54 ffffffff8121a910 ffff88000210fde8 ffffffff817a5a37
   Call Trace:
    [<ffffffff8121a910>] ? SyS_tee+0x360/0x360
    [<ffffffff817a5a37>] schedule+0x37/0x80
    [<ffffffff81211f09>] wb_wait_for_completion+0x49/0x80
    [<ffffffff810b6f90>] ? prepare_to_wait_event+0xf0/0xf0
    [<ffffffff81213134>] sync_inodes_sb+0x94/0x1b0
    [<ffffffff8121a910>] ? SyS_tee+0x360/0x360
    [<ffffffff8121a925>] sync_inodes_one_sb+0x15/0x20
    [<ffffffff811ed1b9>] iterate_supers+0xb9/0x110
    [<ffffffff8121ac65>] sys_sync+0x35/0x90
    [<ffffffff817a9272>] entry_SYSCALL_64_fastpath+0x16/0x75

   INFO: task watchdog/1:14743 blocked for more than 120 seconds.
         Tainted: P           OE  3.18.21-031821-generic #201509020527
   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
   watchdog/1      D ffff88082ec93300     0 14743      2 0x00000000
    ffff8801a2383c48 0000000000000046 ffff880273a50000 0000000000013300
    ffff8801a2383fd8 0000000000013300 ffff8802e642a800 ffff880273a50000
    0000000000001000 ffffffff81c23d80 ffffffff81c23d84 ffff880273a50000
   Call Trace:
    [<ffffffff817847f9>] schedule_preempt_disabled+0x29/0x70
    [<ffffffff81786435>] __mutex_lock_slowpath+0x95/0x100
    [<ffffffff810a8ac9>] ? enqueue_entity+0x289/0xb20
    [<ffffffff817864c3>] mutex_lock+0x23/0x37
    [<ffffffff81029823>] x86_pmu_event_init+0x343/0x430
    [<ffffffff811680db>] perf_init_event+0xcb/0x130
    [<ffffffff811684d8>] perf_event_alloc+0x398/0x440
    [<ffffffff810a8431>] ? put_prev_entity+0x31/0x3f0
    [<ffffffff811249b0>] ? restart_watchdog_hrtimer+0x60/0x60
    [<ffffffff81169156>] perf_event_create_kernel_counter+0x26/0x100
    [<ffffffff8112477d>] watchdog_nmi_enable+0xcd/0x170
    [<ffffffff81124865>] watchdog_enable+0x45/0xa0
    [<ffffffff81093f09>] smpboot_thread_fn+0xb9/0x1a0
    [<ffffffff8108ff9c>] ? __kthread_parkme+0x4c/0x80
    [<ffffffff81093e50>] ? SyS_setgroups+0x180/0x180
    [<ffffffff81090219>] kthread+0xc9/0xe0
    [<ffffffff81090150>] ? kthread_create_on_node+0x180/0x180
    [<ffffffff81788618>] ret_from_fork+0x58/0x90
    [<ffffffff81090150>] ? kthread_create_on_node+0x180/0x180

The watchdog might or might not be unrelated, but it is either a 4.2.1
thing (new kernel) or f2fs related. I only had them during the f2fs test,
and often, not before or after.

(I don't know what that kernel thread does, but the system was somewhat
sluggish during the test, and other, unrelated servcies, were negatively
affected).

> It seems there was no fsync after sync at all. That's why f2fs recovered back to
> the latest checkpoint. Anyway, I'm thinking that it's worth to add a kind of
> periodic checkpoints.

Well, would it sync more often if this problem hadn't occured? Most
filesystems (or rather, the filesystems I use, btrfs, xfs, ext* and zfs)
seem to have their own regular commit interval, or otherwise commit
frequently if it is cheap enough.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
