From: Hagbard Celine <hagbardcelin@gmail.com>
Subject: Re: [BUG] watchdog: BUG: soft lockup.. after heavy disk
 access
Date: Wed, 1 May 2019 00:35:19 +0200
Message-ID: <CADoWrG-OveE2b4GqeB_zj5+vmnbohnZKS1T5HF6oXMh2tt6quQ@mail.gmail.com>
References: <CADoWrG9nn0NZnEJRGKscWTUx02HOR_BqMAfqNHvdhNdTHdU5NQ@mail.gmail.com>
 <6fe67889-ba44-5102-7909-4f08448b13fd@huawei.com>
 <CADoWrG-9O07VeLb06i4zvrOtSxo6FbKmw4E=VjWb3=K4ji1bHw@mail.gmail.com>
 <85dac44f-5455-410f-7f22-cce9bd519c57@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <hagbardcelin@gmail.com>) id 1hLbLV-0002ma-W6
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 30 Apr 2019 22:35:30 +0000
Received: from mail-lj1-f194.google.com ([209.85.208.194])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hLbLT-003DTL-Or
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 30 Apr 2019 22:35:29 +0000
Received: by mail-lj1-f194.google.com with SMTP id b12so13104508lji.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 30 Apr 2019 15:35:27 -0700 (PDT)
In-Reply-To: <85dac44f-5455-410f-7f22-cce9bd519c57@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>

2019-04-30 8:25 GMT+02:00, Chao Yu <yuchao0@huawei.com>:
> On 2019/4/29 21:39, Hagbard Celine wrote:
>> 2019-04-29 9:36 GMT+02:00, Chao Yu <yuchao0@huawei.com>:
>>> Hi Hagbard,
>>>
>>> At a glance, may I ask what's your device size? Since I notice that you
>>> used
>>> -i
>>> option during mkfs, if size is large enough, checkpoint may crash
>>> nat/sit_bitmap
>>> online.
>>>
>>> mkfs-f2fs -a 1 -f -i -l NVME_Gentoo-alt -o7 /dev/nvme0n1p7
>>
>> Both partitions are 128GB.
>
> 128GB is safe. :)
>
>>
>>> On 2019/4/29 15:25, Hagbard Celine wrote:
>>>> First I must admit that I'm not 100% sure if this is
>>>> f2fs/NMI/something-else bug, but it only triggers after significant
>>>> disk access.
>>>>
>>>> I've hit this bug several times since kernel 5.0.7 (have not tried
>>>> earlier kernels) while compiling many packages in batch. But in those
>>>> occasions it would hang all cores and loose the latest changes to the
>>>> filesystem so I could not get any logs.
>>>> This time it triggered while I was in the process of moving two of my
>>>> installations to new partitions and locked only one core, so I was
>>>> able to get the log after rebooting.
>>>> The I did to trigger was make a new partition and run commands:
>>>> #mkfs-f2fs -a 1 -f -i -l NVME_Gentoo-alt -o7 /dev/nvme0n1p7
>>>> #mount -o
>>>> "rw,realtime,lazytime,background_gc=on,disable_ext_identity,discard,heap,user_xattr,inline_xattr,acl,inline_data,inline_dentry,flush_merge,extent_cache,data_flush,mode=adaptive,active_logs=6,whint_mode=fs-based,alloc_mode=default,fsync_mode=strict"
>
> Could you revert below commit to check whether the issue is caused by it?

This did not seem to help. I was not able to reproduce the bug by
copying partition contents to a newly made partition, but the again I
was not able to reproduce it that way on unpatched kernel either.

Goth with and without the mentioned patch reverted the only way I am
able to somewhat reliably reproduce is by compiling a big batch of
packages in Exherbo (using paludis/sydbox), if the batch contains one
of a handful big packages (util-linux is the most common to trigger)
and that big package is not first in the batch. In those cases it will
trigger one of the following ways in most runs:

-NMI watchdog: BUG: soft lockup.. on from 4- to 8-cores.

-NMI watchdog: Watchdog detected hard LOCKUP on cpu.. on 2- to 4-cores

-no error message at all, everything suddenly goes to a grinding halt.

Most of the time I also loose the ability to switch vt by alt+F-key
and it's not even responding to "magic sysreq key".

The few times I've been able to do vt-switch to the vt with output
from syslog there is usually nothing in the time-frame of crash but
one or two "kernel: perf: interrupt took too long..."
..or some random subsystem messaging because something timed out
(usually some message from i915). Just to be clear the i915 is not in
use during the tests, console is on amdgpudrmfb and X is not running,
I even tested with a kernel without i915 to completely rule it out.

> commit 50fa53eccf9f911a5b435248a2b0bd484fd82e5e
> Author: Chao Yu <yuchao0@huawei.com>
> Date:   Thu Aug 2 23:03:19 2018 +0800
>
>     f2fs: fix to avoid broken of dnode block list
>
> The only risk of reverting this patch is we may potentially lose fsynced
> data
> after sudden power-cut, although it's rare, anyway please backup your data
> before try it.
>
> Thanks,
>
>>>> /dev/nvme0n1p7 /mnt/gentoo-alt-new
>>>> #cd /mnt/gentoo-alt
>>>> #cp -a . /mnt/gentoo-alt-new
>>>> #umount /nmt/gentoo-alt
>>>> The bug triggers just after last command and last command was run
>>>> within 20 seconds ofter the second-last command returned.
>>>> "/mnt/gentoo-alt" was already mounted with same options as
>>>> "/mnt/gentoo-alt-new", and contained a Gentoo-rootfs of 64GB data
>>>> (according df -h).
>>>>
>>>> This was on kernel 5.0.10 with "[PATCH] f2fs: fix potential recursive
>>>> call when enabling data_flush" by Chao Yu
>>>>
>>>> Syslog for bug follows:
>>>>
>>>> Apr 29 07:02:52 40o2 kernel: watchdog: BUG: soft lockup - CPU#4 stuck
>>>> for 21s! [irq/61-nvme0q5:383]
>>>> Apr 29 07:02:52 40o2 kernel: Modules linked in: ipv6 crc_ccitt 8021q
>>>> garp stp llc nls_cp437 vfat fat sd_mod iTCO_wdt x86_pkg_temp_thermal
>>>> kvm_intel kvm irqbypass ghash_clmulni_intel serio_raw i2c_i801
>>>> firewire_ohci firewire_core igb crc_itu_t uas lpc_ich dca usb_storage
>>>> processor_thermal_device ahci intel_soc_dts_iosf int340x_thermal_zone
>>>> libahci pcc_cpufreq efivarfs
>>>> Apr 29 07:02:52 40o2 kernel: CPU: 4 PID: 383 Comm: irq/61-nvme0q5 Not
>>>> tainted 5.0.10-gentoo #1
>>>> Apr 29 07:02:52 40o2 kernel: Hardware name: To Be Filled By O.E.M. To
>>>> Be Filled By O.E.M./C226 WS, BIOS P3.40 06/25/2018
>>>> Apr 29 07:02:52 40o2 kernel: RIP:
>>>> 0010:_raw_spin_unlock_irqrestore+0x36/0x40
>>>> Apr 29 07:02:52 40o2 kernel: Code: f6 c7 02 75 1e 56 9d e8 38 a0 69 ff
>>>> bf 01 00 00 00 e8 ce 32 60 ff 65 8b 05 37 8a 70 5b 85 c0 74 0b 5b c3
>>>> e8 3c 9f 69 ff 53 9d <eb> e0 e8 bb 58 4f ff 5b c3 90 e8 6b 50 0f 00 b8
>>>> 00 fe ff ff f0 0f
>>>> Apr 29 07:02:52 40o2 kernel: RSP: 0018:ffff99a4003d7d58 EFLAGS:
>>>> 00000246 ORIG_RAX: ffffffffffffff13
>>>> Apr 29 07:02:52 40o2 kernel: RAX: 0000000000000202 RBX:
>>>> 0000000000000246 RCX: dead000000000200
>>>> Apr 29 07:02:52 40o2 kernel: RDX: ffff8ab7fd8852e0 RSI:
>>>> 0000000000000000 RDI: ffffffffa490c264
>>>> Apr 29 07:02:52 40o2 kernel: RBP: ffffbef2cc242db8 R08:
>>>> 0000000000000002 R09: 0000000000024688
>>>> Apr 29 07:02:52 40o2 kernel: R10: ffffffffffffffb8 R11:
>>>> ffffffffffffffb8 R12: ffff8ab7fd885000
>>>> Apr 29 07:02:52 40o2 kernel: R13: ffff8ab7fd8852d8 R14:
>>>> ffff8ab7fef42b40 R15: 6db6db6db6db6db7
>>>> Apr 29 07:02:52 40o2 kernel: FS:  0000000000000000(0000)
>>>> GS:ffff8ab81ed00000(0000) knlGS:0000000000000000
>>>> Apr 29 07:02:52 40o2 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>>>> 0000000080050033
>>>> Apr 29 07:02:52 40o2 kernel: CR2: 00007e6278ff9000 CR3:
>>>> 0000000792e0c004 CR4: 00000000003606e0
>>>> Apr 29 07:02:52 40o2 kernel: DR0: 0000000000000000 DR1:
>>>> 0000000000000000 DR2: 0000000000000000
>>>> Apr 29 07:02:52 40o2 kernel: DR3: 0000000000000000 DR6:
>>>> 00000000fffe0ff0 DR7: 0000000000000400
>>>> Apr 29 07:02:52 40o2 kernel: Call Trace:
>>>> Apr 29 07:02:52 40o2 kernel:  ? f2fs_del_fsync_node_entry+0x9f/0xd0
>>>> Apr 29 07:02:52 40o2 kernel:  ? f2fs_write_end_io+0xb6/0x1e0
>>>> Apr 29 07:02:52 40o2 kernel:  ? blk_update_request+0xc0/0x270
>>>> Apr 29 07:02:52 40o2 kernel:  ? blk_mq_end_request+0x1a/0x130
>>>> Apr 29 07:02:52 40o2 kernel:  ? blk_mq_complete_request+0x92/0x110
>>>> Apr 29 07:02:52 40o2 kernel:  ? irq_finalize_oneshot.part.46+0xe0/0xe0
>>>> Apr 29 07:02:52 40o2 kernel:  ? nvme_irq+0xf9/0x260
>>>> Apr 29 07:02:52 40o2 kernel:  ? irq_finalize_oneshot.part.46+0xe0/0xe0
>>>> Apr 29 07:02:52 40o2 kernel:  ? irq_forced_thread_fn+0x30/0x80
>>>> Apr 29 07:02:52 40o2 kernel:  ? irq_thread+0xe7/0x160
>>>> Apr 29 07:02:52 40o2 kernel:  ? wake_threads_waitq+0x30/0x30
>>>> Apr 29 07:02:52 40o2 kernel:  ? irq_thread_check_affinity+0x80/0x80
>>>> Apr 29 07:02:52 40o2 kernel:  ? kthread+0x116/0x130
>>>> Apr 29 07:02:52 40o2 kernel:  ? kthread_create_worker_on_cpu+0x70/0x70
>>>> Apr 29 07:02:52 40o2 kernel:  ? ret_from_fork+0x3a/0x50
>>>> Apr 29 07:02:55 40o2 kernel: rcu: INFO: rcu_preempt self-detected stall
>>>> on
>>>> CPU
>>>> Apr 29 07:02:55 40o2 kernel: rcu: \x095-....: (13949 ticks this GP)
>>>> idle=a26/1/0x4000000000000002 softirq=191162/191162 fqs=4843
>>>> Apr 29 07:02:55 40o2 kernel: rcu: \x09 (t=21000 jiffies g=184461 q=674)
>>>> Apr 29 07:02:55 40o2 kernel: Sending NMI from CPU 5 to CPUs 4:
>>>> Apr 29 07:02:55 40o2 kernel: NMI backtrace for cpu 4
>>>> Apr 29 07:02:55 40o2 kernel: CPU: 4 PID: 383 Comm: irq/61-nvme0q5
>>>> Tainted: G             L    5.0.10-gentoo #1
>>>> Apr 29 07:02:55 40o2 kernel: Hardware name: To Be Filled By O.E.M. To
>>>> Be Filled By O.E.M./C226 WS, BIOS P3.40 06/25/2018
>>>> Apr 29 07:02:55 40o2 kernel: RIP:
>>>> 0010:queued_spin_lock_slowpath+0x52/0x1b0
>>>> Apr 29 07:02:55 40o2 kernel: Code: 0f b6 c0 c1 e0 08 89 c2 8b 03 30 e4
>>>> 09 d0 a9 00 01 ff ff 75 1b 85 c0 75 0f b8 01 00 00 00 66 89 03 5b 5d
>>>> 41 5c c3 f3 90 8b 03 <84> c0 75 f8 eb e9 f6 c4 01 75 04 c6 43 01 00 e8
>>>> 3a fe 28 00 48 c7
>>>> Apr 29 07:02:55 40o2 kernel: RSP: 0018:ffff99a4003d7d30 EFLAGS:
>>>> 00000002
>>>> Apr 29 07:02:55 40o2 kernel: RAX: 0000000000200101 RBX:
>>>> ffff8ab7fd8852d8 RCX: 0000000000000000
>>>> Apr 29 07:02:55 40o2 kernel: RDX: 0000000000000000 RSI:
>>>> 0000000000000000 RDI: ffff8ab7fd8852d8
>>>> Apr 29 07:02:55 40o2 kernel: RBP: 0000000000000246 R08:
>>>> 0000000000000002 R09: 0000000000024688
>>>> Apr 29 07:02:55 40o2 kernel: R10: ffffffffffffffb8 R11:
>>>> ffffffffffffffb8 R12: ffff8ab7fd885000
>>>> Apr 29 07:02:55 40o2 kernel: R13: ffff8ab7fd8852d8 R14:
>>>> ffff8ab5ffdbd840 R15: 6db6db6db6db6db7
>>>> Apr 29 07:02:55 40o2 kernel: FS:  0000000000000000(0000)
>>>> GS:ffff8ab81ed00000(0000) knlGS:0000000000000000
>>>> Apr 29 07:02:55 40o2 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>>>> 0000000080050033
>>>> Apr 29 07:02:55 40o2 kernel: CR2: 00007e6278ff9000 CR3:
>>>> 0000000792e0c004 CR4: 00000000003606e0
>>>> Apr 29 07:02:55 40o2 kernel: DR0: 0000000000000000 DR1:
>>>> 0000000000000000 DR2: 0000000000000000
>>>> Apr 29 07:02:55 40o2 kernel: DR3: 0000000000000000 DR6:
>>>> 00000000fffe0ff0 DR7: 0000000000000400
>>>> Apr 29 07:02:55 40o2 kernel: Call Trace:
>>>> Apr 29 07:02:55 40o2 kernel:  ? _raw_spin_lock_irqsave+0x39/0x40
>>>> Apr 29 07:02:55 40o2 kernel:  ? f2fs_del_fsync_node_entry+0x20/0xd0
>>>> Apr 29 07:02:55 40o2 kernel:  ? f2fs_write_end_io+0xb6/0x1e0
>>>> Apr 29 07:02:55 40o2 kernel:  ? blk_update_request+0xc0/0x270
>>>> Apr 29 07:02:55 40o2 kernel:  ? blk_mq_end_request+0x1a/0x130
>>>> Apr 29 07:02:55 40o2 kernel:  ? blk_mq_complete_request+0x92/0x110
>>>> Apr 29 07:02:55 40o2 kernel:  ? irq_finalize_oneshot.part.46+0xe0/0xe0
>>>> Apr 29 07:02:55 40o2 kernel:  ? nvme_irq+0xf9/0x260
>>>> Apr 29 07:02:55 40o2 kernel:  ? irq_finalize_oneshot.part.46+0xe0/0xe0
>>>> Apr 29 07:02:55 40o2 kernel:  ? irq_forced_thread_fn+0x30/0x80
>>>> Apr 29 07:02:55 40o2 kernel:  ? irq_thread+0xe7/0x160
>>>> Apr 29 07:02:55 40o2 kernel:  ? wake_threads_waitq+0x30/0x30
>>>> Apr 29 07:02:55 40o2 kernel:  ? irq_thread_check_affinity+0x80/0x80
>>>> Apr 29 07:02:55 40o2 kernel:  ? kthread+0x116/0x130
>>>> Apr 29 07:02:55 40o2 kernel:  ? kthread_create_worker_on_cpu+0x70/0x70
>>>> Apr 29 07:02:55 40o2 kernel:  ? ret_from_fork+0x3a/0x50
>>>> Apr 29 07:02:55 40o2 kernel: NMI backtrace for cpu 5
>>>> Apr 29 07:02:55 40o2 kernel: CPU: 5 PID: 384 Comm: irq/62-nvme0q6
>>>> Tainted: G             L    5.0.10-gentoo #1
>>>> Apr 29 07:02:55 40o2 kernel: Hardware name: To Be Filled By O.E.M. To
>>>> Be Filled By O.E.M./C226 WS, BIOS P3.40 06/25/2018
>>>> Apr 29 07:02:55 40o2 kernel: Call Trace:
>>>> Apr 29 07:02:55 40o2 kernel:  <IRQ>
>>>> Apr 29 07:02:55 40o2 kernel:  ? dump_stack+0x67/0x90
>>>> Apr 29 07:02:55 40o2 kernel:  ? nmi_cpu_backtrace.cold.4+0x13/0x4e
>>>> Apr 29 07:02:55 40o2 kernel:  ? nmi_trigger_cpumask_backtrace+0xb1/0xc8
>>>> Apr 29 07:02:55 40o2 kernel:  ? rcu_dump_cpu_stacks+0x85/0xb1
>>>> Apr 29 07:02:55 40o2 kernel:  ? rcu_check_callbacks.cold.69+0x19a/0x459
>>>> Apr 29 07:02:55 40o2 kernel:  ? tick_sched_do_timer+0x60/0x60
>>>> Apr 29 07:02:55 40o2 kernel:  ? update_process_times+0x28/0x60
>>>> Apr 29 07:02:55 40o2 kernel:  ? tick_sched_handle+0x22/0x60
>>>> Apr 29 07:02:55 40o2 kernel:  ? tick_sched_timer+0x37/0x70
>>>> Apr 29 07:02:55 40o2 kernel:  ? __hrtimer_run_queues+0xfb/0x2c0
>>>> Apr 29 07:02:55 40o2 kernel:  ? hrtimer_interrupt+0xfd/0x210
>>>> Apr 29 07:02:55 40o2 kernel:  ? smp_apic_timer_interrupt+0x7d/0x180
>>>> Apr 29 07:02:55 40o2 kernel:  ? apic_timer_interrupt+0xf/0x20
>>>> Apr 29 07:02:55 40o2 kernel:  </IRQ>
>>>> Apr 29 07:02:55 40o2 kernel:  ? _raw_spin_unlock_irqrestore+0x34/0x40
>>>> Apr 29 07:02:55 40o2 kernel:  ? _raw_spin_unlock_irqrestore+0x36/0x40
>>>> Apr 29 07:02:55 40o2 kernel:  ? f2fs_del_fsync_node_entry+0x9f/0xd0
>>>> Apr 29 07:02:55 40o2 kernel:  ? f2fs_write_end_io+0xb6/0x1e0
>>>> Apr 29 07:02:55 40o2 kernel:  ? blk_update_request+0xc0/0x270
>>>> Apr 29 07:02:55 40o2 kernel:  ? blk_mq_end_request+0x1a/0x130
>>>> Apr 29 07:02:55 40o2 kernel:  ? blk_mq_complete_request+0x92/0x110
>>>> Apr 29 07:02:55 40o2 kernel:  ? irq_finalize_oneshot.part.46+0xe0/0xe0
>>>> Apr 29 07:02:55 40o2 kernel:  ? nvme_irq+0xf9/0x260
>>>> Apr 29 07:02:55 40o2 kernel:  ? irq_finalize_oneshot.part.46+0xe0/0xe0
>>>> Apr 29 07:02:55 40o2 kernel:  ? irq_forced_thread_fn+0x30/0x80
>>>> Apr 29 07:02:55 40o2 kernel:  ? irq_thread+0xe7/0x160
>>>> Apr 29 07:02:55 40o2 kernel:  ? wake_threads_waitq+0x30/0x30
>>>> Apr 29 07:02:55 40o2 kernel:  ? irq_thread_check_affinity+0x80/0x80
>>>> Apr 29 07:02:55 40o2 kernel:  ? kthread+0x116/0x130
>>>> Apr 29 07:02:55 40o2 kernel:  ? kthread_create_worker_on_cpu+0x70/0x70
>>>> Apr 29 07:02:55 40o2 kernel:  ? ret_from_fork+0x3a/0x50
>>>> Apr 29 07:03:02 40o2 kernel: nvme nvme0: I/O 310 QID 5 timeout,
>>>> aborting
>>>> Apr 29 07:03:02 40o2 kernel: nvme nvme0: I/O 210 QID 6 timeout,
>>>> aborting
>>>> Apr 29 07:03:02 40o2 kernel: nvme nvme0: Abort status: 0x0
>>>> Apr 29 07:03:02 40o2 kernel: nvme nvme0: Abort status: 0x0
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-f2fs-devel mailing list
>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>> .
>>>>
>>>
>> .
>>
>
