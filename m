From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs, mount -o sync, sync and cut-off power
Date: Thu, 30 Oct 2014 23:22:21 -0700
Message-ID: <20141031062221.GA13251@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <5451EA4C.2040304@mitrol.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Xk5bM-00041N-8w
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Oct 2014 06:22:24 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xk5bL-0004rG-2s for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Oct 2014 06:22:24 +0000
Content-Disposition: inline
In-Reply-To: <5451EA4C.2040304@mitrol.it>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Paolo,

You can use -o sync,fastboot for the case.
Please refer the patch that I sent.

[PATCH 4/4] f2fs: introduce -o fastboot for reducing booting time only
 
  If a system wants to reduce the booting time as a top priority, now we can
  use a mount option, -o fastboot.
  With this option, f2fs conducts a little bit slow write_checkpoint, but
  it can avoid the node page reads during the next mount time.

Note that, from the performance viewpoint, it would be enough to use -o sync,
which has no stability problem since it calls fsync.
But, if you are concerned about booting time rather than sacrificing the
performance, it would be ok to use -o sync,fastboot.

Thanks,

On Thu, Oct 30, 2014 at 08:35:40AM +0100, Paolo Minazzi wrote:
> I'm Paolo.
> I'm integrating f2fs on an ARM board.
> I do not have the power-off button.
> The normal way to power-off is to cut-off the power.
> 
> I tried to mount in sync mode
>      mount -t f2fs -o sync /dev/mmcblk0 /data
>      echo Hello > /data/Hello.txt
> I realize that if I cut-off the power after "echo" finishes, at the new 
> boot I see that f2fs execute the recovery that can be also very long.
> 
> If I add the "sync" command
>      mount -t f2fs -o sync /dev/mmcblk0 /data
>      echo Hello > /data/Hello.txt
>      sync
> I realize that if I cut-off the power after "sync" finishes, at the new 
> boot I do not see the f2fs
> recovery and the boot process is very fast.
> 
> This means that -o sync is different that execute a sync command after 
> each write.
> I study deeper the problem reading the source code and I realize that 
> "sync" produce a checkpoint.
> I tried to add the code to make a checkpoint every n writes. It works 
> but is not a clean solution.
> I read and tried ipu-policy but I do not think it is realted to my needs.
> 
> Is there a solution to force a checkpoint automatically after each write ?
> I need
> - not lose data on cut-off
> - fast boot (I would like to avoid different mount time)
> For me the spped of write is not so important.
> 
> I would like avoid the following ...
> while true
> do
>      sync
>      sleep 1
> done
> 
> Thanks for your time and for this great project
> Paolo Minazzi
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
