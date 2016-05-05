From: Stephen Bates <stephen.bates@microsemi.com>
Subject: Re: Kernel panic in F2FS mount on NVMe SSD.
Date: Thu, 5 May 2016 17:53:14 +0000
Message-ID: <D87A37E7A4AA544D853031D9A919C70B168FD685@avsrvexchmbx2.microsemi.net>
References: <D87A37E7A4AA544D853031D9A919C70B168FC5E3@avsrvexchmbx2.microsemi.net>
	<20160505000958.GA72128@jaegeuk.gateway>
	<D87A37E7A4AA544D853031D9A919C70B168FC904@avsrvexchmbx2.microsemi.net>
	<20160505034815.GA73673@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stephen.bates@microsemi.com>) id 1ayNT1-0004Xu-HV
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 May 2016 17:53:39 +0000
Received: from mail-bn1on0072.outbound.protection.outlook.com ([157.56.110.72]
	helo=na01-bn1-obe.outbound.protection.outlook.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ayNT0-0003Hp-4Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 May 2016 17:53:39 +0000
In-Reply-To: <20160505034815.GA73673@jaegeuk.gateway>
Content-Language: en-US
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
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

> >
> > One thing I did notice is that fallocate() seems slow (5-6 GB/s) compared to
> other file systems for a 3TiB fallocate() [ext4 performs the same operation in
> under a second on my system)]. Is this typical/expected for F2FS? Could it be
> because I have the IO_TRACE and/or _SECURITY set in .config?
> 
> Which fallocate did you test among expand, punch_hole, or something else?
> Let me check that especially.
> Actually, I have not tested its speed considerably, but more focused on
> functionality and stability.

I just issued a 

fallocate -l 3TiB /mnt/f2fs/tst

right after the mkfs.f2fs call. I am not sure what fallocate() path that excites in the FS. I also (for fun) timed the removal of that file via the rm command and it is also very slow. iostat implies the drive is being read at about 4MB/s while this removal is being performed.  

$ sudo time rm /mnt/f2fs/tst
0.00user 307.62system 6:01.75elapsed 85%CPU (0avgtext+0avgdata 1852maxresident)k
2978552inputs+6332168outputs (1major+80minor)pagefaults 0swaps

> 
> If you're trying to measure FS performance, please turn off:
> - most of Lock Debugging configs (e.g., mutex, spinlock and rw-lock)
> - CONFIG_F2FS_CHECK_FS
> - CONFIG_F2FS_IO_TRACE

OK. I will try some more testing with those config options...

Stephen

------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
