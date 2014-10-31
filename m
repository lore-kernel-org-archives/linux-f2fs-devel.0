From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Subject: Re: f2fs, mount -o sync, sync and cut-off power
Date: Fri, 31 Oct 2014 10:17:02 +0100
Message-ID: <5453538E.3090505@mitrol.it>
References: <5451EA4C.2040304@mitrol.it>
	<20141031062221.GA13251@jaegeuk-mac02.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Paolo.Minazzi@mitrol.it>) id 1Xk8Kc-0001Z8-GP
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Oct 2014 09:17:18 +0000
Received: from mitrol.it ([82.188.252.170] helo=mail.mitrol.it)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xk8KV-00023v-KU for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Oct 2014 09:17:18 +0000
In-Reply-To: <20141031062221.GA13251@jaegeuk-mac02.hsd1.ca.comcast.net>
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

Il 31/10/2014 07:22, Jaegeuk Kim ha scritto:
> Hi Paolo,
>
> You can use -o sync,fastboot for the case.
> Please refer the patch that I sent.
>
> [PATCH 4/4] f2fs: introduce -o fastboot for reducing booting time only
>   
>    If a system wants to reduce the booting time as a top priority, now we can
>    use a mount option, -o fastboot.
>    With this option, f2fs conducts a little bit slow write_checkpoint, but
>    it can avoid the node page reads during the next mount time.
>
> Note that, from the performance viewpoint, it would be enough to use -o sync,
> which has no stability problem since it calls fsync.

Hi Kim, thanks for for answer.
To be precise I use a kernel 3.0.35.
I have found a backport of f2fsby arter 97. The backport should be new 
enough.

You have written:

	Note that, from the performance viewpoint, it would be enough to use -o sync,
	which has no stability problem since it calls fsync.

On this I see different behaviour.
I see that "-o sync" does not call fsync.
I have studied small tests with my version (3.0.35 with a f2fs backport) 
and mounting with "-o sync"

===== TEST1=====
touch /mnt/file
cut-off the power
In this case the file is not written. The recovery does not find 
/mnt/file. The checkpoint is not created.

===== TEST2 =====
echo > /mnt/file
cut-off the power
In this case the file is written, and the recovery sees the /mnt/file. 
The checkpoint is not created.
The data are written by the flush f2fs kernel_thread.

In both test TEST1 and TEST2 the checkpoint is not created. I added a 
printk in the function write_checkpoint to
see when it is executed. I added also a printk in the flush f2fs 
kernel_thread.

I understand that I do not use the latest version, so it is difficult 
for you help me.
I cannot port all the new f2fs in my code.I'm afraid to insert bugs.

So I have tried a simple solution, but I'm not sure if it is correct.

I create a simple kernel_thread

int sync_kernel_thread(void *)
{
     while(1)
     {
         f2fs_freeze(sb);
         wait_completion(&comp);
     }
}


Every operation that write, create file, create directory ..... and so 
on .... activate the thread using
complete(&comp);

So my filesystem is always synced. The boot is fast.

I do not think I will introduce race conditions ... What do you think 
about ?

Thanks again,
Paolo


------------------------------------------------------------------------------
