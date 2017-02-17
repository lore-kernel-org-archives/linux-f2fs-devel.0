From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: documentation for atomic writes,
 encryption and other features
Date: Thu, 16 Feb 2017 17:50:43 -0800
Message-ID: <20170217015043.GA71774@jaegeuk.local>
References: <05f5a35f-0176-b9ff-77c9-268466e19750@au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ceXhG-0005OV-Dr
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Feb 2017 01:50:54 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ceXhF-0008Lm-3o
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Feb 2017 01:50:54 +0000
Content-Disposition: inline
In-Reply-To: <05f5a35f-0176-b9ff-77c9-268466e19750@au.ibm.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Daniel Black <daniel.black@au1.ibm.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Daniel,

On 02/17, Daniel Black wrote:
> I was looking at Documentation/filesystems/f2fs.txt trying to work out
> how to do atomic writes.
> 
> I did find https://www.spinics.net/lists/kernel/msg1839691.html which
> contains some elements.
> 
> It seems F2FS_IOC_DB_OPEN might been replaced by
> F2FS_IOC_START_ATOMIC_WRITE looking at fs/f2fs/f2fs.h
> 
> I'd really like some documentation to be written in filesystems/f2fs.txt
> to aid the use of features that have been so diligently developed.

Agreed that we need to describe it in f2fs.txt, and let me add the work in our
TODO list.

> I'd also like to know what happens when the atomic write size gets too big.

I didn't test large atomic writes a lot, since we enabled and have tested it in
sqlite under Android products, which triggers small atomic writes across lots of
different db files. In current design, there is no limit on the size of atomic
writes. And it handles basic errors like ENOMEM or EIO during commit.

> After that perhaps it can be used in application like other storage
> systems e.g. https://jira.mariadb.org/browse/MDEV-11417

Quite interesting!
Yup, I thought that there would be many use-cases of this feature. But I've not
been able to dive into other scenarios seriously, since application needs to be
modified; sqlite was quite easy for me to change tho.

Thanks,

> 
> Keep up the good work.
> 
> Cheers,
> 
> Daniel Black
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
