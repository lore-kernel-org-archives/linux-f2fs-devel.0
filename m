From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: f2fs, mount -o sync, sync and cut-off power
Date: Fri, 31 Oct 2014 08:11:03 +0900
Message-ID: <20141030231103.GA19190@lcm>
References: <5451EA4C.2040304@mitrol.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1XjytK-0000yP-40
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 30 Oct 2014 23:12:30 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XjytH-0002i8-IB
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 30 Oct 2014 23:12:29 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0NEA00LU65SJR180@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Oct 2014 08:12:19 +0900 (KST)
Content-disposition: inline
In-reply-to: <5451EA4C.2040304@mitrol.it>
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

Hi,

When see the manpage of mount, it is written as 'the sync option has
effect only for ext2, ext3, fat, vfat and ufs.' and in case of media
with limited number of write cycles (e.g. some flash drivers) "sync" may
cause life-cycle shortening.

Anyway, you should use O_SYNC when you open a file or call fsync for not
losing your data. Nevertheless this way can not avoid recovery time as well.

Thanks

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
