From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs data write ordering
Date: Thu, 23 Jul 2015 11:09:02 -0700
Message-ID: <20150723180902.GA23629@jaegeuk-mac02.mot.com>
References: <55B11E38.8090400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZIKvn-0002WE-Tq
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Jul 2015 18:09:19 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZIKvl-0003zJ-N7 for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Jul 2015 18:09:19 +0000
Content-Disposition: inline
In-Reply-To: <55B11E38.8090400@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jialin Li <nick.lijl@gmail.com>
Cc: Xi Wang <xi@cs.washington.edu>, linux-f2fs-devel@lists.sourceforge.net

Hi,

On Thu, Jul 23, 2015 at 10:02:48AM -0700, Jialin Li wrote:
> Hi,
> 
> When testing the crash consistency of f2fs, we saw in the documentation 
> that one of the mount option "nobarrier" states that "if this option is 
> set, no cache_flush commands are issued but f2fs still guarantees the 
> write ordering of all the data writes." Does it imply that both with and 
> without the "nobarrier" option set, the ordering of all data writes is 
> guaranteed? And this ordering applies to data writes to different files 
> too?
> 
> We wrote the following python test:
> 
> ---------
> import os
> 
> with open("a", "wb") as f:
>    f.write(b"hello\n")
> with open("b", "wb") as f:
>    f.write(b"world\n")
> os.sync()
> 
> fd0 = os.open("a", os.O_RDWR)
> fd1 = os.open("b", os.O_RDWR)
> os.pwrite(fd0, b'x', 1)
> os.pwrite(fd1, b'y', 1)
> os.fdatasync(fd1)

This guarantees file "b"'s contents, not "a".

> /* Crash here */
> ----------
> 
> However, after the crash, we were able to observe that file "b" on disk 
> contains "wyrld" while the content of file "a" is still "hello": the two 
> pwrites reached the disk out of order. This happened both when we set 
> and unset the "nobarrier" option. Maybe we misunderstood the 
> documentation regarding the ordering guarantee of f2fs, and it would be 
> much appreciated if you could provide some clarifications.

The write ordering means the order of block writes submitted to the storage
by filesystem internally, which is not related to the user-made write ordering.
(e.g., sequential writes or random writes)

And, you need to understand that the recovery is different from write ordering.
If you want to guarantee any data updates, fsync/fdatasync/sync should be
called likewise the above scenario.
Otherwise, no matter what it was flushed to disk already, f2fs would not recover
its data. That's the POSIX rule.

OTOH, we can think about an internal cache inside a storage.
If a storage has a volatile cache, we should issue cache_flush to the storage
in order to guarantee that its data is recoverable from the storage side.
Otherwise, even if filesystem received end_io for fsync/fdatasync, the data can
be lost by the storage.

If there is no cache inside the storage or storage is safe for written data, we
can use "nobarrier" to enhance the performance.

Thanks,

> 
> Thanks,
> Jialin
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
