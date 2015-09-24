From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: sync/umount hang on 3.18.21, 1.4TB gone after crash
Date: Thu, 24 Sep 2015 11:50:23 -0700
Message-ID: <20150924185023.GE40291@jaegeuk-mac02>
References: <20150923215850.GC2360@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZfBbG-0004cr-Ko
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Sep 2015 18:50:34 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZfBbF-000739-9L for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Sep 2015 18:50:34 +0000
Content-Disposition: inline
In-Reply-To: <20150923215850.GC2360@schmorp.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Marc Lehmann <schmorp@schmorp.de>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Wed, Sep 23, 2015 at 11:58:51PM +0200, Marc Lehmann wrote:
> Hi!
> 
> I moved one of the SMR disks to another box with a 3.18.21 kernel.
> 
> I formatted and mounted like this:
> 
>    /opt/f2fs-tools/sbin/mkfs.f2fs -lTEST -s90 -t0 -a0 /dev/vg_test/test
>    mount -t f2fs -onoatime,flush_merge,no_heap /dev/vg_test/test /mnt
> 
> I then copied (tar | tar) 2.1TB of data to the disk, which took about 6
> hours, which is about the read speed of this data set (so the speed was very
> good).
> 
> When I came back after ~10 hours, I found a number of hung task messages
> in syslog, and when I entered sync, sync was consuming 100% system time.

Hmm, at this time, it would be good to check what process is stuck through
sysrq.

> I took a snapshot of /sys/kernel/debug/f2fs/status before sync, and the
> values arfe "frozen", i.e. they didn't change.
> 
> I was able to read from the mounted filesystem normally, and I was able to
> read and write the block device itself, so the disk is responsive.
> 
> After ~1h in this state, I tried to umount, which made the filesystem
> mountpoint go away, but umount hangs, and /sys/kernel/debug/f2fs/status still
> doesn't change.
> 
> This is the output of /sys/kernel/debug/f2fs/status:
> 
> http://ue.tst.eu/d88ce0e21a7ca0fb74b1ecadfa475df0.txt
> 
> I then deleted the device, but the echo 1 >/sys/block/sde/device/delete was
> also hanging.
> 
> Here are /proc/.../stack outputs of sync, umount and bash(echo):
> 
>    sync:
>    [<ffffffffffffffff>] 0xffffffffffffffff
> 
>    umount:
>    [<ffffffff8139ba03>] call_rwsem_down_write_failed+0x13/0x20
>    [<ffffffff811e7ee6>] deactivate_super+0x46/0x70
>    [<ffffffff81204733>] cleanup_mnt+0x43/0x90
>    [<ffffffff812047d2>] __cleanup_mnt+0x12/0x20
>    [<ffffffff8108e8a4>] task_work_run+0xc4/0xe0
>    [<ffffffff81012fa7>] do_notify_resume+0x97/0xb0
>    [<ffffffff8178896f>] int_signal+0x12/0x17
>    [<ffffffffffffffff>] 0xffffffffffffffff
> 
>    bash (delete):
>    [<ffffffff810d8917>] msleep+0x37/0x50
>    [<ffffffff8135d686>] __blk_drain_queue+0xa6/0x1a0
>    [<ffffffff8135da05>] blk_cleanup_queue+0x1b5/0x1c0
>    [<ffffffff8152082a>] __scsi_remove_device+0x5a/0xe0
>    [<ffffffff815208d6>] scsi_remove_device+0x26/0x40
>    [<ffffffff81520917>] sdev_store_delete+0x27/0x30
>    [<ffffffff814bf748>] dev_attr_store+0x18/0x30
>    [<ffffffff8125bc4d>] sysfs_kf_write+0x3d/0x50
>    [<ffffffff8125b154>] kernfs_fop_write+0xe4/0x160
>    [<ffffffff811e51a7>] vfs_write+0xb7/0x1f0
>    [<ffffffff811e5c26>] SyS_write+0x46/0xb0
>    [<ffffffff817886cd>] system_call_fastpath+0x16/0x1b
>    [<ffffffffffffffff>] 0xffffffffffffffff
> 
> After a forced reboot, I did a fsck, and got this, which looks good except
> for the "Wrong segment type" message, which hopefully is harmless.
> 
> http://ue.tst.eu/4c750d2301a581cb07249d607aa0e6d0.txt
> 
> After mounting, status was this (and was changing):
> 
> http://ue.tst.eu/6462606ac3aa85bde0d6674365c86318.txt
> 
> Note that 1.4TB of data are missing(!)
> 
> This large amount of missing data was certainly unexpected. I assume f2fs
> stopped checkpointing earlier, and only after a checkpoint the data is
> safe, but being able to write 1.4TB of data without it ever reaching the
> disk is very unexpected behaviour for a filesystem (which normally loses
> about half a minute of data at most).

It seems there was no fsync after sync at all. That's why f2fs recovered back to
the latest checkpoint. Anyway, I'm thinking that it's worth to add a kind of
periodic checkpoints.

> 
> Minor question, since the disk actually has 4K physical sectors, and fsck
> says sector size = 512, is there a way to teach f2fs that the physical
> sector size is actually 4k, or does this not matter because f2fs will do
> page-sized writes anyways?

No problem. The fsck just reads the sector size from the block device, which
is used when calculating the total partition size.

> 
> In any case, any insights would be appreciated. I will attwmpt to upgrade
> this box to linux 4.2.1 to see if that helps, but 3.18.x is the onl
> kernel known to work with smr drives without any issues.
> 
> -- 
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\
> 
> ------------------------------------------------------------------------------
> Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
> Get real-time metrics from all of your servers, apps and tools
> in one place.
> SourceForge users - Click here to start your Free Trial of Datadog now!
> http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
