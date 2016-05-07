From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: Kernel panic in F2FS mount on NVMe SSD.
Date: Sat, 7 May 2016 10:49:52 -0700
Message-ID: <20160507174952.GB92790@jaegeuk.gateway>
References: <D87A37E7A4AA544D853031D9A919C70B168FC5E3@avsrvexchmbx2.microsemi.net>
	<20160505000958.GA72128@jaegeuk.gateway>
	<D87A37E7A4AA544D853031D9A919C70B168FC904@avsrvexchmbx2.microsemi.net>
	<20160505034815.GA73673@jaegeuk.gateway>
	<D87A37E7A4AA544D853031D9A919C70B168FD685@avsrvexchmbx2.microsemi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1az6Ma-0002YH-Pd
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 May 2016 17:50:00 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1az6MZ-0005tS-Vx
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 07 May 2016 17:50:00 +0000
Content-Disposition: inline
In-Reply-To: <D87A37E7A4AA544D853031D9A919C70B168FD685@avsrvexchmbx2.microsemi.net>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Stephen Bates <stephen.bates@microsemi.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

On Thu, May 05, 2016 at 05:53:14PM +0000, Stephen Bates wrote:
> > >
> > > One thing I did notice is that fallocate() seems slow (5-6 GB/s) compared to
> > other file systems for a 3TiB fallocate() [ext4 performs the same operation in
> > under a second on my system)]. Is this typical/expected for F2FS? Could it be
> > because I have the IO_TRACE and/or _SECURITY set in .config?
> > 
> > Which fallocate did you test among expand, punch_hole, or something else?
> > Let me check that especially.
> > Actually, I have not tested its speed considerably, but more focused on
> > functionality and stability.
> 
> I just issued a 
> 
> fallocate -l 3TiB /mnt/f2fs/tst
> 
> right after the mkfs.f2fs call. I am not sure what fallocate() path that excites in the FS. I also (for fun) timed the removal of that file via the rm command and it is also very slow. iostat implies the drive is being read at about 4MB/s while this removal is being performed.  
> 
> $ sudo time rm /mnt/f2fs/tst
> 0.00user 307.62system 6:01.75elapsed 85%CPU (0avgtext+0avgdata 1852maxresident)k
> 2978552inputs+6332168outputs (1major+80minor)pagefaults 0swaps

We could figure out how to improve them. :)

I've been preparing two patches under testing right now.
 - f2fs: fallocate data blocks in single locked node page
 - f2fs: read node blocks ahead when truncating blocks

Thanks,

------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
