From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs_bug_on in init_dirty_segmap
Date: Thu, 9 Mar 2017 15:11:46 -0800
Message-ID: <20170309231146.GC4125@jaegeuk.local>
References: <20170308142432.GA31333@frolo.macqel>
	<20170308215203.GE5483@jaegeuk.local>
	<20170309084227.GA11085@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cm7Dv-0000jk-Mt
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 09 Mar 2017 23:11:55 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cm7Du-0001Vy-Hg
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 09 Mar 2017 23:11:55 +0000
Content-Disposition: inline
In-Reply-To: <20170309084227.GA11085@frolo.macqel>
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

On 03/09, Philippe De Muyter wrote:
> Hi,
> 
> thanks for your quick answer
> 
> On Wed, Mar 08, 2017 at 01:52:03PM -0800, Jaegeuk Kim wrote:
> > Hi,
> > 
> > On 03/08, Philippe De Muyter wrote:
> > > Hi f2fs developpers,
> > > 
> > > Please excuse my maybe dumb question.
> > > 
> > > I recently encountered a kernel panic at root mount time (thus making my
> > > system unusable, as my root partition is formatted as f2fs) due to the
> > > following segment in fs/f2fs/segment.c:init_dirty_segmap
> > > 
> > > 		if (valid_blocks > sbi->blocks_per_seg) {
> > >                         f2fs_bug_on(sbi, 1); <<<<<<<<<<<<<<<<<<<<
> > > 			continue;
> > > 		}
> > > 
> > > Is that really a condition requiring a kernel panic, or could a read-only
> > > mount be allowed ?
> > 
> > It would be helpful that you can remain your kernel and f2fs-tools version
> > information, as well as fsck.f2fs result.
> 
> It is actually a Freescale (now NXP) provided kernel tagged rel_imx_4.1.15_1.2.0_ga
> available at git://git.freescale.com/imx/linux-2.6-imx.git 
> 
> I surmise that the f2fs driver is the one from the linux-4.1 version.
> 
> > 
> > You can get the latest f2fs-tools from
> > http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git/log/?h=dev-test
> > 
> > Anyway, if you don't have time, you may have some options like:
> > 
> > 1. disable F2FS_CHECK_FS in Kconfig
> >  : bypass BUG_ON here, so mount-ro would be preferable.
> 
> Actually F2FS_CHECK_FS was disabled, but kernel panic'ed.

So, you got a warning message from there?

#ifdef CONFIG_F2FS_CHECK_FS
#define f2fs_bug_on(sbi, condition)	BUG_ON(condition)
#define f2fs_down_write(x, y)	down_write_nest_lock(x, y)
#else
#define f2fs_bug_on(sbi, condition)					\
	do {								\
		if (unlikely(condition)) {				\
			WARN_ON(1);					\
			set_sbi_flag(sbi, SBI_NEED_FSCK);		\
		}							\
	} while (0)
#define f2fs_down_write(x, y)	down_write(x)
#endif

> > 
> > 2. run fsck.f2fs
> >  : fix some inconsistency and let you mount your system again.
> > 
> > So, I think you'd better try #1 to retrieve your important data, and then
> > #2 to fix something wrong.
> 
> There wasn't a need to retrieve important data, as it is an unattended device
> in the wild.  The problem was that boot did not succeed anymore and the device
> needed a return to our aftersales department for reflashing.  Without the 'panic',
> and with a read-only mount we could probably fix it without reflashing
> and without return.

So, there is no fscking before mounting any filesystem during boot-up, right?
Most of distros and android do that and provide a recovery mode tho.

I think there is a way to mount with ro without loading in-memory structures
which results in potential panics. Will cosider about that. ;)

Note, there is a backported f2fs for v4.1 which I've been maintaining.

http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-stable.git/log/?h=linux-4.1.y

Thanks,

> 
> If that happens again, I'll try to provide more information.
> > 
> > > 
> > > Philippe
> 
> -- 
> Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
> 
> ------------------------------------------------------------------------------
> Announcing the Oxford Dictionaries API! The API offers world-renowned
> dictionary content that is easy and intuitive to access. Sign up for an
> account today to start using our lexical data to power your apps and
> projects. Get started today and enter our developer competition.
> http://sdm.link/oxford
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
