From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: 100% system time hang with git f2fs
Date: Fri, 2 Oct 2015 09:51:24 -0700
Message-ID: <20151002165124.GA2586@jaegeuk-mac02>
References: <20150926032218.GA4311@schmorp.de>
	<20150926052551.GA2243@schmorp.de>
	<20150926075253.GD13619@jaegeuk-mac02.hsd1.ca.comcast.net>
	<20150926135957.GB9860@schmorp.de>
	<20150928175944.GA16945@jaegeuk-mac02.mot.com>
	<20150929110204.GA7608@schmorp.de>
	<20150929231310.GA6010@jaegeuk-mac02.mot.com>
	<20151001121120.GA7340@schmorp.de>
	<20151001185124.GA9803@schmorp.de>
	<20151002085340.GA3105@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Zi3YS-0004qD-3u
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 02 Oct 2015 16:51:32 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Zi3YR-0007BO-6w for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 02 Oct 2015 16:51:32 +0000
Content-Disposition: inline
In-Reply-To: <20151002085340.GA3105@schmorp.de>
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

On Fri, Oct 02, 2015 at 10:53:40AM +0200, Marc Lehmann wrote:
> On Thu, Oct 01, 2015 at 08:51:24PM +0200, Marc Lehmann <schmorp@schmorp.de> wrote:
> > Ok, for completeness, here is the full log and a description of what was
> > going on.
> 
> Ok, so I did a fsck, which took one hour, which is not very good, but I
> don't use fsck very often. It didn't find any problems (everything Ok).
> 
> However, I have a freeze. When I mount the volume, start a du on it, and after
> a while do:

How was your scenario?
Did you delete device before, or just plain mount and umount?

>    echo 3 >/proc/sys/vm/drop_caches
> 
> Then this process hangs with 100% sys time. /proc/../stack gives no usable
> backtrace.

This should be shrinker is stuck on mutex. I suspect a deadlock.
Can you do this, if you meet this again?

# echo l > /proc/sysrq-trigger
# echo w > /proc/sysrq-trigger
# demsg

Thanks,

> 
> umount on the f2fs volume also hangs:
> 
>    [<ffffffff8139ba03>] call_rwsem_down_write_failed+0x13/0x20
>    [<ffffffff8118086d>] unregister_shrinker+0x1d/0x70
>    [<ffffffff811e7911>] deactivate_locked_super+0x41/0x60
>    [<ffffffff811e7eee>] deactivate_super+0x4e/0x70
>    [<ffffffff81204733>] cleanup_mnt+0x43/0x90
>    [<ffffffff812047d2>] __cleanup_mnt+0x12/0x20
>    [<ffffffff8108e8a4>] task_work_run+0xc4/0xe0
>    [<ffffffff81012fa7>] do_notify_resume+0x97/0xb0
>    [<ffffffff8178896f>] int_signal+0x12/0x17
>    [<ffffffffffffffff>] 0xffffffffffffffff
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
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
