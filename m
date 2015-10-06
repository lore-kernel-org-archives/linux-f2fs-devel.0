From: Chao Yu <yuchaochina@hotmail.com>
Subject: Re: more gc / gc script refinements
Date: Wed, 7 Oct 2015 00:41:45 +0800
Message-ID: <COL402-EAS353392C7223EDEFCCE5A97FAB370@phx.gbl>
References: <20151004124923.GC3697@schmorp.de>
	<20151005072548.GA2504@schmorp.de>
	<COL402-EAS402AD3DF23BC5CB748EDBCFAB480@phx.gbl>
	<20151005231642.GC7635@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchaochina@hotmail.com>) id 1ZjVJO-0005cK-6K
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Oct 2015 16:41:58 +0000
Received: from col004-omc1s8.hotmail.com ([65.55.34.18])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZjVJM-0003Tc-MH
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Oct 2015 16:41:58 +0000
In-Reply-To: <20151005231642.GC7635@jaegeuk-mac02.mot.com>
Content-Language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: 'Marc Lehmann' <schmorp@schmorp.de>, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, October 06, 2015 7:17 AM
> To: Chao Yu
> Cc: 'Marc Lehmann'; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] more gc / gc script refinements
> 
> Thanks Chao,
> 
> On Mon, Oct 05, 2015 at 11:02:42PM +0800, Chao Yu wrote:
> > > -----Original Message-----
> > > From: Marc Lehmann [mailto:schmorp@schmorp.de]
> > > Sent: Monday, October 05, 2015 3:26 PM
> > > To: linux-f2fs-devel@lists.sourceforge.net; linux-f2fs-devel@lists.sourceforge.net
> > > Subject: Re: [f2fs-dev] more gc / gc script refinements
> > >
> > > After I successfully filled the disk, it was time to see hope f2fs recovers
> > > from this bad situation, by deleting a lot of files and filling it again.
> > >
> > > To ease the load on the gc, but still present a bit of a challenge, I
> > > deleted the first 12000 files out of every 80000 files (directory order), in the hope
> > > that this carves out comparatively big chunks.
> > >
> > > I started with "Dirty: 30k" and "Free: 45k" and ended up with
> > > "Dirty: 216k" and "Free: 968k", which to me seems to indicate it kind of
> > > worked, although I am not suire how contiguous this free space really is
> > > (I oriignally hoped this would be in the form of mostly free sections).
> > >
> > > Then I worked on my GC script. Since the box became mostly unusable by just
> > > calling the GC, I first tried this refinement:
> > >
> > > http://ue.tst.eu/38809274b56fe9b161492f09b5411071.txt
> > >
> > > (Used like "script </mountpoint" btw.)
> > >
> > > Or in other words, only call the GC if there is less than 2GB of dirty
> > > pages. For lower values than 2GB the GC often didn't run at all for 10-20
> > > seconds.
> > >
> > > This helped a lot, but the box was still noticably sluggish, and I
> > > realised why the current GC I/O implementation is wrong - the purpose of
> > > the cache is (among other uses, such as being the normal way to do I/O) to
> > > cache recently-requested data in the hope that it will be reused.
> > >
> > > However, in the case of the GC, unless the data was in the cache before,
> > > chances that this data is required later are just as low as for the rest of
> > > the device, and in general, much lower then the data that was in the cache
> > > before f2fs evicted it.
> > >
> > > Moreso, a lot of stress is put on the page cache because of the f2fs gc
> > > treating it as normal data and leaving it in the cache and up to the
> > > kernel to write out the pages.
> >
> > IMO, the reason of the behavior is a) keeping gced pages in cache as we look
> > forward further hits; b) as we know, kworker will flush all pages belong to
> > one inode together, we expect that inode's pages cached from multiple background
> > gc can be merged, and then be flushed with continuous block address, which
> > can improve the read performance afterward.
> 
> Agreed to this.
> 
> > >
> > > What the GC should do is minimize the impact of the GC on the rest of the
> > > system, by immediately flushing the data out and expiring the pages.
> >
> > I think f2fs should support us more flexible method of triggering gc, mostly
> > like supporting sync/async gc ioctl command.
> > 1) synchronous gc: all gced pages should be persistent in device after ioctl
> > returns successfully.
> > 2) asynchronous gc: we don't guarantee all gced pages will be persistent
> > after ioctl returns successfully.
> 
> Yeah, agreed.
> 
> I wrote some other patches on top of Chao's patches.
> We can do "background_gc=sync" and "/sys/fs/f2fs/dev/cp_interval".

Nice! The usage is more easy and convenient than the way of ioctl.
I think that can really be helpful for Marc.

> Currently, I'm not quite convincing that we need to flush use data periodically.

IMHO, I prefer to support data flush functionality in f2fs, the reason is that:
a) In order to keep the consistency and integrity of user data, kworker flush
and periodical checkpoint are hard to be controlled and cooperated because
kworker and checkpoint can't be aware of each other, on the contrary, configurable
inner periodical data flush + checkpoint can supply more flexible way to keep
persistent of user data (e.g. config period time as n second, so at least we will
lost the user data in recent n second).
b) User can choose more options in log level:
 - periodical data flush + checkpoint supply us with better integrity but worse
performance since in the period we can merge less dirty data for writebacking.
 - kworker flush + periodical checkpoint supply us with better performance as
dirty pages can merged well, but worse integrity of user data as data didn't
flushed before cp will be unrecoverable forever.
With this functionality, f2fs will become more configurable, and it should be
suitable for more workload (especially in strong demand on user data integrity).

So I hope we can add this feature in our pending list. How do you think?

Thanks,

> At least, I expect cp_interval could enhance user experiences quite well.
> 
> >
> > In your scenario, I think gc flow can easily be controlled with:
> >
> > while (n) {
> > 	ioctl gc with sync mode
> > }
> > syncfs or ioctl write_checkpoint
> >
> > I wrote and sent the patches for supporting synchronous gc and supporting
> > triggering checkpoint by ioctl, I hope that can be helpful once we get
> > Jaegeuk's Ack.
> 
> Thanks for the patches, :)

Thank you for the quick response! :)

Thanks,

> 
> >
> > Thanks,
> >
> > >
> > > To improve the situaiton somewhat I decided to experiment with fdatasync
> > > on the block device and/or a directory handle, but ended up calling syncfs
> > > on the f2fs fs after every gc call, because fdatasync etc. seemed to be
> > > the equivalent of syncfs anyway:
> > >
> > > http://ue.tst.eu/325b6ba70b1abe814dc6a5cb6c02730e.txt
> > >
> > > The effect of syncfs was to make I/O a lot more "chunky" - first everything
> > > was read, then everything was written (dstat output, btw., this is 1 second
> > > intervals as always, but I never mentioned it - sorry):
> > >
> > > http://ue.tst.eu/9a552a4f41a4863133d3eceb90f1ec87.txt
> > >
> > > Without it, read and write happen "at the same time" (when sampled with 1
> > > second intervals).
> > >
> > > This increased the average throughput considerably, from around 45MB
> > > read+write/s to 66MB/s. Whether this actually increased the GC process at
> > > all I don't know, because syncfs of course forces a sync on the fs, with
> > > its own overhead.
> > >
> > > So while this is a rather heavy-handed approach, the major result was that
> > > the amount of dirty pages is notably reduced (it never reaches 1GB), and
> > > the box is much more usable during this time.
> > >
> > > Right now, after about 9 hours, I am at "Dirty: 44k", and will start
> > > writing to the device soon.
> > >
> > > In any case, it seems f2fs seems to hold up quite nicely near disk full
> > > conditions, and does recover nicely as well.
> > >
> > > --
> > >                 The choice of a       Deliantra, the free code+content MORPG
> > >       -----==-     _GNU_              http://www.deliantra.net
> > >       ----==-- _       generation
> > >       ---==---(_)__  __ ____  __      Marc Lehmann
> > >       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
> > >       -=====/_/_//_/\_,_/ /_/\_\
> > >
> > > ------------------------------------------------------------------------------
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >
> > ------------------------------------------------------------------------------
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
