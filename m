From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs_bug_on in init_dirty_segmap
Date: Fri, 10 Mar 2017 10:20:34 -0800
Message-ID: <20170310182034.GA22979@jaegeuk.local>
References: <20170308142432.GA31333@frolo.macqel>
	<20170308215203.GE5483@jaegeuk.local>
	<20170309084227.GA11085@frolo.macqel>
	<20170309231146.GC4125@jaegeuk.local>
	<20170310092810.GA28970@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cmP9g-0005h1-HO
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 18:20:44 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cmP9f-0000pE-6X
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 18:20:44 +0000
Content-Disposition: inline
In-Reply-To: <20170310092810.GA28970@frolo.macqel>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Philippe De Muyter <phdm@macq.eu>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 03/10, Philippe De Muyter wrote:
...
> > > It is actually a Freescale (now NXP) provided kernel tagged rel_imx_4.1.15_1.2.0_ga
> > > available at git://git.freescale.com/imx/linux-2.6-imx.git 
> > > 
> > > I surmise that the f2fs driver is the one from the linux-4.1 version.
> > > 
> > > > 
> > > > You can get the latest f2fs-tools from
> > > > http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git/log/?h=dev-test
> > > > 
> > > > Anyway, if you don't have time, you may have some options like:
> > > > 
> > > > 1. disable F2FS_CHECK_FS in Kconfig
> > > >  : bypass BUG_ON here, so mount-ro would be preferable.
> > > 
> > > Actually F2FS_CHECK_FS was disabled, but kernel panic'ed.
> > 
> > So, you got a warning message from there?
> > 
> > #ifdef CONFIG_F2FS_CHECK_FS
> > #define f2fs_bug_on(sbi, condition)	BUG_ON(condition)
> > #define f2fs_down_write(x, y)	down_write_nest_lock(x, y)
> > #else
> > #define f2fs_bug_on(sbi, condition)					\
> > 	do {								\
> > 		if (unlikely(condition)) {				\
> > 			WARN_ON(1);					\
> > 			set_sbi_flag(sbi, SBI_NEED_FSCK);		\
> > 		}							\
> > 	} while (0)
> > #define f2fs_down_write(x, y)	down_write(x)
> > #endif
> 
> Yes, I got a 'panic'.  I'll look deeper into that and let you know.

Okay, thank you. ;)

> > > > 2. run fsck.f2fs
> > > >  : fix some inconsistency and let you mount your system again.
> > > > 
> > > > So, I think you'd better try #1 to retrieve your important data, and then
> > > > #2 to fix something wrong.
> > > 
> > > There wasn't a need to retrieve important data, as it is an unattended device
> > > in the wild.  The problem was that boot did not succeed anymore and the device
> > > needed a return to our aftersales department for reflashing.  Without the 'panic',
> > > and with a read-only mount we could probably fix it without reflashing
> > > and without return.
> > 
> > So, there is no fscking before mounting any filesystem during boot-up, right?
> > Most of distros and android do that and provide a recovery mode tho.
> 
> No, there is no fsck before mounting the root filesystem during boot-up.
> But I do my best to avoid writing in the root partition.  It's not read-only,
> but all log, lock, run, cache and tmp files are in tmpfs partitions.  I have
> just noticed though that the partition is mounted with 'relatime', not 'noatime'
> as I would like, but I do not know where this 'relatime' option comes from.
> Is 'relatime' a default mount option for f2fs ?

Not specific from f2fs. It's default given by vfs, and you need to mount with
noatime explicitly, if you want. BTW, once you got a panic during boot-up, how
can you change mount option?

Thanks,

> 
> > 
> > I think there is a way to mount with ro without loading in-memory structures
> > which results in potential panics. Will cosider about that. ;)
> > 
> > Note, there is a backported f2fs for v4.1 which I've been maintaining.
> > 
> > http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-stable.git/log/?h=linux-4.1.y
> 
> Thank you. I will apply it
> 
> Philippe
> 
> -- 
> Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles

------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
