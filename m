From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: write performance difference 3.18.21/git f2fs
Date: Wed, 30 Sep 2015 17:02:20 +0800
Message-ID: <00f101d0fb5e$ce70c920$6b525b60$@samsung.com>
References: <20150925182034.GA6998@jaegeuk-mac02>
	<20150925182034.GA6998@jaegeuk-mac02>
	<01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<20150926032218.GA4311@schmorp.de> <20150926052551.GA2243@schmorp.de>
	<20150926075253.GD13619@jaegeuk-mac02.hsd1.ca.comcast.net>
	<20150926135957.GB9860@schmorp.de>
	<20150928175944.GA16945@jaegeuk-mac02.mot.com>
	<20150929110204.GA7608@schmorp.de>
	<20150929231310.GA6010@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZhDI6-0003oD-EY
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Sep 2015 09:03:10 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZhDI3-0004Hv-UK
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Sep 2015 09:03:10 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NVH01AH6FT0HP50@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Sep 2015 18:03:00 +0900 (KST)
In-reply-to: <20150929231310.GA6010@jaegeuk-mac02.mot.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Marc Lehmann' <schmorp@schmorp.de>
Cc: linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, September 30, 2015 7:13 AM
> To: Marc Lehmann
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] write performance difference 3.18.21/git f2fs
> 
> On Tue, Sep 29, 2015 at 01:02:04PM +0200, Marc Lehmann wrote:
> > On Mon, Sep 28, 2015 at 10:59:44AM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > > In order to verify this also, could you retrieve the following logs?
> >
> > First thing, the allocation-failure-on-mount is still in the backported 3.18
> > f2fs module. If it's supposed to be gone in that version, it's not working:
> >
> > http://ue.tst.eu/a1bc4796012bd7191ab2ada566d4cd22.txt
> 
> Oops, it seems I missed some other allocations too.
> Could you pull the v3.18 again? I changed the patch.
> 
> >
> > And here are traces and descriptions. The traces all start directly after
> > mount, my test script is http://data.plan9.de/f2fstest
> >
> > (event tracing is cool btw., thanks for showing me :)
> 
> Thank you for the below traces.
> I have two suspicious things from the traces where:
> 
> 1. several inline_data conversion of existing files

Good catch, :)

This evidence is that the following trace message appear repeatedly for thousand
times, spreads in the whole trace log, and it should be outputted by inline
conversion here only.
"f2fs_submit_write_bio: dev = (252,9), WRITE_SYNC(P), DATA, sector = xxx, size = 4096"

It not only delay the tar about 50 ms for each time since inline conversion is
completely synchronous, but also use WRITE_SYNC request break mering of between IO
requests both in the f2fs bio cache and io scheduler of block layer, resulting in
falling in RMW mode io for SMR driver.

So I guess in this scenario noinline_data may be a good choice.

> Could you test -o noinline_data and share its trace too?
> 
> 2. running out of free node ids along with its shrinker
> The latest f2fs registers a shrinker to release cached free ids which will
> be used for inode numbers when creating files. If there is no id, it needs
> to read some meta blocks to fill up the empty lists.

Right, IMO, by compare with flash device, rotational device have worse random read
performance since its expensive seeking cost. So optimization should be applied
to building flow of free nid cache too. What I think is maybe in SMR_MODE we can
check whether our free nid number is lower than threshold value, if it is true, we
can readahead more (32?) nat blocks with low priority READA instead of READ_SYNC,
so this can prevent overmuch rotation cost and long latency cause by synchronous
cache building in alloc_nid.

Thanks,

> 
> I think its threshold does not consider enough for this use cases.
> Let me think about this in more details.
> 
> Thanks,
> 
> >
> > ################ -s1, f2fs git ##############################################
> >
> >    /opt/f2fs-tools/sbin/mkfs.f2fs -lTEST -s1 -t0 -a0 /dev/vg_test/test
> >    mount -t f2fs -onoatime,flush_merge,no_heap /dev/vg_test/test /mnt
> >
> > For the fist ~120GB, performance was solid (100MB/s+), but much worse than
> > stock 3.18.21 (with -s64!).
> >
> > 3.1.8.21 regularly reached >190MB/s regularly (at least near the beginning
> > of the disk) then was idle in between writes, as the source wasn't fast
> > enough to keep up. With the backport, tar was almost never idle, and if,
> > then not for long, so it could just keep up. (Just keeping up with the
> > read speed of a 6-disk raid is very good, but I know f2fs can do much
> > better :)
> >
> > At the 122GB mark, it started to slow down, being consistently <100MB/s
> >
> > At 127GB, it was <<20MB/s, and I stopped.
> >
> > Most of the time, the test was write-I/O-bound.
> >
> > http://data.plan9.de/f2fs.s1.trace.xz
> >
> > ################ -s64, f2fs 3.18.21 #########################################
> >
> > As contrast I then did a test with the original f2fs module, and -s64.
> > Throughput was up to 202MB/s, almost continously. At the 100GB mark, it
> > slowed down to maybe 170MB/s peak, which might well be the speed of the
> > platters.
> >
> > I stopped at 217GB.
> >
> > I have a 12GB mbuffer between the read-tar and the write-tar, configured to
> > write minimum bursts of ~120MB. At no time was the buffer filled at >2%,
> > while with the -s1, f2fs git case, it was basically always >2%.
> >
> > The trace includes a few minutes after tar was stopped.
> >
> > http://data.plan9.de/f2fs.s64.3.18.trace.xz
> >
> > ################ -s64, f2fs git #############################################
> >
> > The direct equivalent of the previous test, but with f2fs git.
> >
> > Almost from the very beginning, it was often write-bound, but could still
> > keep up.
> >
> > At around 70GB, it mostly stopped being able to keep up, and the read
> > tar overtook the write tar. At 139GB, performance degraded to <2MB/s. I
> > stopped at 147GB.
> >
> > So mostly, behaviour was the same as with -s1, excedpt it took longer to
> > slow down.
> >
> > http://data.plan9.de/f2fs.s64.trace.xz
> >
> > ################ -s20, f2fs git #############################################
> >
> > By special request, here is the test with -s20.
> >
> > Surprisingly, this stopped being able to cope at the 40GB mark, but I didn't
> > wait very long after the previous test, maybe that influenced it. I stopped
> > at 63GB.
> >
> > http://data.plan9.de/f2fs.s20.trace.xz
> >
> > #############################################################################
> >
> > I hope to find time to look at these traces myself later this day.
> >
> > --
> >                 The choice of a       Deliantra, the free code+content MORPG
> >       -----==-     _GNU_              http://www.deliantra.net
> >       ----==-- _       generation
> >       ---==---(_)__  __ ____  __      Marc Lehmann
> >       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
> >       -=====/_/_//_/\_,_/ /_/\_\
> >
> > ------------------------------------------------------------------------------
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
