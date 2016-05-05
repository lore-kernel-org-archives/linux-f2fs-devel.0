From: Stephen Bates <stephen.bates@microsemi.com>
Subject: Re: Kernel panic in F2FS mount on NVMe SSD.
Date: Thu, 5 May 2016 02:35:42 +0000
Message-ID: <D87A37E7A4AA544D853031D9A919C70B168FC904@avsrvexchmbx2.microsemi.net>
References: <D87A37E7A4AA544D853031D9A919C70B168FC5E3@avsrvexchmbx2.microsemi.net>
	<20160505000958.GA72128@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stephen.bates@microsemi.com>) id 1ayAby-0005aW-1I
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 May 2016 04:10:02 +0000
Received: from mail-bn1on0072.outbound.protection.outlook.com ([157.56.110.72]
	helo=na01-bn1-obe.outbound.protection.outlook.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ayAbv-0003sc-U6
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 May 2016 04:10:02 +0000
In-Reply-To: <20160505000958.GA72128@jaegeuk.gateway>
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

> Hi Stephen,
> 
> On Wed, May 04, 2016 at 10:47:10PM +0000, Stephen Bates wrote:
> > Hi
> >
> > I have been experimenting with putting F2FS onto a NVMe block device. I
> have been hitting a kernel panic on mount and was wondering if anyone on
> the list had any ideas what might be causing this. I formatted the NVMe block
> device using the f2fs-tools version 1.2.0 with default format settings.  This is
> Ubuntu 14.04 running v2.6-rc6 (though I see a similar problem on older
> kernels).
> 
> I think f2fs-tools 1.2.0 is pretty old, since there've made a lot of bug fixes till
> 1.6.1 so far.
> 
> One suspicious thing like this.
> 
> commit 092e3d9da37796daf439e94141c57886d6fc6e50 "mkfs.f2fs: large
> volume support"
> 
> So could you build the latest one from here?
> http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git

Yes that fixed the mount panic issue, thanks!

> 
> And, do you mean kernel v4.6-rc6?

Yes ;-).

> 
> Thanks,
> 

One thing I did notice is that fallocate() seems slow (5-6 GB/s) compared to other file systems for a 3TiB fallocate() [ext4 performs the same operation in under a second on my system)]. Is this typical/expected for F2FS? Could it be because I have the IO_TRACE and/or _SECURITY set in .config?

CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
CONFIG_F2FS_CHECK_FS=y
# CONFIG_F2FS_FS_ENCRYPTION is not set
CONFIG_F2FS_IO_TRACE=y

Stephen

------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
