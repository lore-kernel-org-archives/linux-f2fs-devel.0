From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add cleancache support
Date: Sun, 23 Nov 2014 23:18:00 -0800
Message-ID: <20141124071800.GA25852@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1415856890-2455-1-git-send-email-cm224.lee@samsung.com>
 <20141114012751.GB49179@jaegeuk-mac02.mot.com>
 <20141114055302.GD16657@lcm>
 <20141120043851.GA3117@lcm>
 <20141124054212.GA22699@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20141124061943.GC4740@lcm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141124061943.GC4740@lcm>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Changman Lee <cm224.lee@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, dan.magenheimer@oracle.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Mon, Nov 24, 2014 at 03:19:43PM +0900, Changman Lee wrote:
> On Sun, Nov 23, 2014 at 09:42:12PM -0800, Jaegeuk Kim wrote:
> > On Thu, Nov 20, 2014 at 01:38:51PM +0900, Changman Lee wrote:
> > > On Fri, Nov 14, 2014 at 02:53:02PM +0900, Changman Lee wrote:
> > > > On Thu, Nov 13, 2014 at 05:27:51PM -0800, Jaegeuk Kim wrote:
> > > > > Hi Changman,
> > > > > 
> > > > > On Thu, Nov 13, 2014 at 02:34:50PM +0900, Changman Lee wrote:
> > > > > > To use cleancache, fs must explicitly enable cleancache by calling
> > > > > > cleancache_init_fs.
> > > > > 
> > > > > Good catch!
> > > > > 
> > > > > Prior to merge this patch, can you share any testing results or performance
> > > > > numbers?
> > > > > 
> > > > Not yet, I'll try to get numbers.
> > > > 
> > > 
> > > Hi,
> > > 
> > > This is the result of kernel compile on xen-4.4 enabled tmem
> > > : cleancache and frontswap.
> > > I'm afraid that there is little difference by cleancache.
> > > The cleancache shows a few cache hits but the effect through it doesn't
> > > show. I don't know best benchmark to testify it yet.
> > > Finally, I couldn't discover any bug during test.
> > > 
> > > [before patch]
> > > 		1		2		3
> > > Elapsed time	25:00.67	25:07.09	25:00.38
> > > Major fault	31100		31410		31333
> > > Minor fault	276869398	276869318	276871144
> > > 
> > > [after patch]
> > > 		1		2		3
> > > Elapsed time	25:12.34	25:13.29	25:11.99
> > > Major fault	31559		32069		31801
> > > Minor fault	276870283	276868046	276869251
> > > 
> > > [cleancache] - diff between start and end
> > > 		1		2		3
> > > failed_gets	1277980		1296355		1300368
> > > invalidates	2588227		2651722		2655285
> > > puts		1289970		1323685		1320623
> > > *succ_gets*	111111		121299		114310
> > 
> > Hi Changman,
> > 
> > So, what is your suggestion?
> > IMO, we first need to find a way exploiting cleancache over f2fs, so that
> > we can introduce some guide for users.
> > Until then, how about keeping this patch for a while?
> > 
> 
> The performance of cleancache depends on workload but ext4 and btrfs
> support it already. So how about allowing to enable cleancache on f2fs?
> If backend of cleancache doesn't exists, there is no effect for f2fs.
> I think negative effectness of cleancache is little.
> Anyway, a final decision lies in your hand.

I'm not sure, but it seems that nobody uses the cleancache.
https://www.google.co.kr/trends/explore#q=cleancache

And, as you've shown even worse performance under a simple workload, I don't
understand why you want to add this.

Let me know, if I'm missing any rationale.

> 
> Thanks
> 
> > Thanks,
> > 
> > > 
> > > Thanks,
> > > Changman
> > > 
> > > > > What condition will be the best way to exploit f2fs and cleancache?
> > > > > 
> > > > Not clear.
> > > > I think we can make a cleancache client for f2fs so that can compenstate
> > > > a penalty of node pages which are read mostly.
> > > > 
> > > > > Can we confirm that f2fs satisfies most of requirements described by
> > > > > cleancache.txt below?
> > > > 
> > > > Good point.
> > > > At a quick glance, F2FS seems to satisfy most of requirements.
> > > > Through a experimental, I'll try to check side effect.
> > > > 
> > > > > 
> > > > > Some points for a filesystem to consider:
> > > > > 
> > > > > - The FS should be block-device-based (e.g. a ram-based FS such
> > > > >   as tmpfs should not enable cleancache)
> > > > > - To ensure coherency/correctness, the FS must ensure that all
> > > > >   file removal or truncation operations either go through VFS or
> > > > >   add hooks to do the equivalent cleancache "invalidate" operations
> > > > > - To ensure coherency/correctness, either inode numbers must
> > > > >   be unique across the lifetime of the on-disk file OR the
> > > > >   FS must provide an "encode_fh" function.
> > > > > - The FS must call the VFS superblock alloc and deactivate routines
> > > > >   or add hooks to do the equivalent cleancache calls done there.
> > > > > - To maximize performance, all pages fetched from the FS should
> > > > >   go through the do_mpag_readpage routine or the FS should add
> > > > >   hooks to do the equivalent (cf. btrfs)
> > > > > - Currently, the FS blocksize must be the same as PAGESIZE.  This
> > > > >   is not an architectural restriction, but no backends currently
> > > > >   support anything different.
> > > > > - A clustered FS should invoke the "shared_init_fs" cleancache
> > > > >   hook to get best performance for some backends.
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > > 
> > > > > > Signed-off-by: Changman Lee <cm224.lee@samsung.com>
> > > > > > ---
> > > > > >  fs/f2fs/super.c | 3 +++
> > > > > >  1 file changed, 3 insertions(+)
> > > > > > 
> > > > > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > > > > index 512ffd8..2ebb960 100644
> > > > > > --- a/fs/f2fs/super.c
> > > > > > +++ b/fs/f2fs/super.c
> > > > > > @@ -24,6 +24,7 @@
> > > > > >  #include <linux/blkdev.h>
> > > > > >  #include <linux/f2fs_fs.h>
> > > > > >  #include <linux/sysfs.h>
> > > > > > +#include <linux/cleancache.h>
> > > > > >  
> > > > > >  #include "f2fs.h"
> > > > > >  #include "node.h"
> > > > > > @@ -1144,6 +1145,8 @@ try_onemore:
> > > > > >  		if (err)
> > > > > >  			goto free_kobj;
> > > > > >  	}
> > > > > > +
> > > > > > +	cleancache_init_fs(sb);
> > > > > >  	return 0;
> > > > > >  
> > > > > >  free_kobj:
> > > > > > -- 
> > > > > > 1.9.1
> > > > > > 
> > > > > > 
> > > > > > ------------------------------------------------------------------------------
> > > > > > Comprehensive Server Monitoring with Site24x7.
> > > > > > Monitor 10 servers for $9/Month.
> > > > > > Get alerted through email, SMS, voice calls or mobile push notifications.
> > > > > > Take corrective actions from your mobile device.
> > > > > > http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
> > > > > > _______________________________________________
> > > > > > Linux-f2fs-devel mailing list
> > > > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > > > 
> > > > ------------------------------------------------------------------------------
> > > > Comprehensive Server Monitoring with Site24x7.
> > > > Monitor 10 servers for $9/Month.
> > > > Get alerted through email, SMS, voice calls or mobile push notifications.
> > > > Take corrective actions from your mobile device.
> > > > http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
> > > > _______________________________________________
> > > > Linux-f2fs-devel mailing list
> > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
