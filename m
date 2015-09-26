From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: SMR drive test 2; 128GB partition;
 no obvious corruption, much more sane behaviour, weird
 overprovisioning
Date: Sat, 26 Sep 2015 00:36:55 -0700
Message-ID: <20150926073655.GB13619@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <20150921095806.GA6809@schmorp.de>
	<20150923011239.GA32520@jaegeuk-mac02.mot.com>
	<20150923041523.GB4946@schmorp.de>
	<20150923060037.GA6667@schmorp.de>
	<20150923220823.GE36564@jaegeuk-mac02.mot.com>
	<20150923233937.GE3463@schmorp.de>
	<20150924172749.GB40291@jaegeuk-mac02>
	<20150925054225.GB486@schmorp.de>
	<20150925174546.GA6269@jaegeuk-mac02.mot.com>
	<20150926033249.GB4311@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Zfk2b-0005cy-SR
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 07:37:05 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Zfk2a-0005gO-Hv for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 07:37:05 +0000
Content-Disposition: inline
In-Reply-To: <20150926033249.GB4311@schmorp.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Marc Lehmann <schmorp@schmorp.de>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Sat, Sep 26, 2015 at 05:32:53AM +0200, Marc Lehmann wrote:
> On Fri, Sep 25, 2015 at 10:45:46AM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > > He :) It's a nothing-special number between 64 and 128, that's all.
> > 
> > Oh, then, I don't think that is a good magic number.
> 
> Care to share why? :)

Mostly, in the flash storages, it is multiple 2MB normally. :)

> 
> > It seems that you decided to use -s64, so it'd better to keep it to address
> > any perf results.
> 
> Is there anysthing specially good for numbers of two? Or do you just want top
> reduce the number of changed variables?

IMO, likewise flash storages, it needs to investigate the raw device
characteristics.

I think this can be used for SMR too.

https://github.com/bradfa/flashbench

I think there might be some hints for section size at first and performance
variation as well.

> I'f yes, should I do the 3.18.21 test with -s90 (as the 3.18.21 and 4.2.1
> tests before), or with -s64?
> 
> > > And just filling these 8TB disks takes days, so the question is, can I
> > > simulate near-full behaviour with smaller partitions.
> > 
> > Why not? :)
> > I think the behavior should be same. And, it'd good to set small sections
> > in order to see it more clearly.
> 
> The section size is a critical parameter for these drives. Also, the data
> mix is the same for 8TB and smaller partitions (in these tests, which were
> meantr to be the first round of tests only anyway).
> 
> So a smaller section size compared to the full partition test, I think,
> would result in very different behaviour. Likewise, if a small partition
> has comparatively more (or absolutely less) overprovision (and/or reserved
> space), this again might cause different behaviour.
> 
> At least to me, it's not obvious what a good comparable overprovision ratio
> is to test full device behaviour on a smaller partition.
> 
> Also, section sizes vary by a factor fo two over the device, so what might
> work fine with -s64 in the middle of the disk, might work badly at the end.
> 
> Likewise, since the files don't get larger, the GC might do a much better
> job at -s64 than at -s128 (almost certainly, actually).
> 
> As a thought experiment, what happens when I use -s8 or a similar small size?
> If the GC writes linearly, there won't be too many RMW cycles. But is that
> guaranteed even with an aging filesystem?
> 
> If yes, then the best -s number might be 1. Because all I rely on is
> mostly linear batched large writes, not so much large batched reads.
> 
> That is, unfortunately, not something I can easily test.
> 
> > Let me test this patch for a while, and then push into our git.
> 
> Thanks, will do so, then.
> 
> -- 
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
