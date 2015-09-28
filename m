From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: SMR drive test 2; 128GB partition;
 no obvious corruption, much more sane behaviour, weird
 overprovisioning
Date: Mon, 28 Sep 2015 11:33:52 -0700
Message-ID: <20150928183352.GB16945@jaegeuk-mac02.mot.com>
References: <20150923041523.GB4946@schmorp.de>
	<20150923060037.GA6667@schmorp.de>
	<20150923220823.GE36564@jaegeuk-mac02.mot.com>
	<20150923233937.GE3463@schmorp.de>
	<20150924172749.GB40291@jaegeuk-mac02>
	<20150925054225.GB486@schmorp.de>
	<20150925174546.GA6269@jaegeuk-mac02.mot.com>
	<20150926033249.GB4311@schmorp.de>
	<20150926073655.GB13619@jaegeuk-mac02.hsd1.ca.comcast.net>
	<20150926135353.GA9860@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZgdFU-00087j-7x
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Sep 2015 18:34:04 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZgdFS-0000FI-9c for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Sep 2015 18:34:04 +0000
Content-Disposition: inline
In-Reply-To: <20150926135353.GA9860@schmorp.de>
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

On Sat, Sep 26, 2015 at 03:53:53PM +0200, Marc Lehmann wrote:
> On Sat, Sep 26, 2015 at 12:36:55AM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > > Care to share why? :)
> > 
> > Mostly, in the flash storages, it is multiple 2MB normally. :)
> 
> Well, any value of -s gives me a multiple of 2MB, no? :)
> 
> > > Is there anysthing specially good for numbers of two? Or do you just want top
> > > reduce the number of changed variables?
> > 
> > IMO, likewise flash storages, it needs to investigate the raw device
> > characteristics.
> 
> Keep in mind that I don't use it for flash, but smr drives.
> 
> We already know the raw device characteristics, basically, the zones are
> between 15 and 40 or so MB in size (on the seagate 8tb drive), and they
> likely don't have "even" sizes at all.
> 
> It's also by far not easy to benchmark these things, the disks can
> buffer up to 25GB of random writes (and then might need several hours of
> cleanup). Failing a linear write incurs a 0.6-1.6s penalty, to be paid
> much later. It's a shame that none of the drive companies actually release
> any usable info on their drives.
> 
> These guys made a hole into the disk and devised a lot of benchmarks to
> find out the characteristics of these drives.
> 
> https://www.usenix.org/system/files/conference/fast15/fast15-paper-aghayev.pdf
> 
> So, the strategy for a fs would be to write linearly, most of the time,
> without any gaps. f2fs (at least in 3.18.x) manages to do that very
> nicely, which is why I really try to get it working.
> 
> But for writing once, any value of -s would probably suffice. There are
> two problems when the disk gets full:
> 
> a) ipu writes. the drive can't do, so gc might be cheaper.
> b) reuse of sections - if sections are reasonably large, if one gets freed
> and reused, it should be large to guarantee large linear writes again.
> 
> b) is the reason behind me trying large values of -s.

Hmm. It seems that SMR has 20~25GB cache to absorb random writes with a big
block map. Then, it uses a static allocation, which is a kind of very early
stage of FTL shapes though.
Comparing to flash, it seems that SMR degrades the performance significantly
due to internal cleaning overhead, so I could understand that it needs to
control IO patterns very carefully.

So, how about testing -s20, which comes resasonble to me?

+ direct IO can break the alignment too.

> Since I know that f2fs is the only fs that I tested that can have a sustained
> write performance on these drives that is near the physical drive
> characteristics, all that needs to be done is to see how f2fs performs after
> it starts gc'ing.
> 
> That's why I am so interested in disk full conditions - writing the disk
> linearly once is easy, I can just write a tar to the device. Ensuring that
> writes are large linear after deleting and cleaning up is harder.
> 
> nilfs is a good example - it should fit smr drives perfectly, until they
> are nearly full, after which nilfs still matches smr drives perfectly,
> but waiting for 8TB to be shuffled around to delete some files can take
> days.  More surprising is that nilfs phenomenally fails with these drives,
> performance wise, for reaosns I haven't investigated (my guess is that
> nilfs leaves gaps).
> 
> > I think this can be used for SMR too.
> 
> You can run any blockdevice operation on these drives, but the results
> from flashbench will be close to meaningless for them. For example, you
> can't distinguish betwene a nonaligned write causing a read-modify write
> from an aligned large write, or a partial write, by access time, as they
> will probably all have similar access times.
> 
> > I think there might be some hints for section size at first and performance
> > variation as well.
> 
> I think you confuse these drives with flash drives - while they share some
> characteristics, they are completely unlike flash. There is no translation
> layer, there is no need for wear leveling, zones have widely varying
> sizes, appending can be expensive or cheap, depending on the write size.
> 
> What these drives need is primarily large linear writes without gaps, and
> secondarily any optimisations for rotational media apply. (And for that, f2fs
> performs unexpectedly good, given it wasn't meant for rotational media).
> 
> Now, if f2fs can be made to (mostly) work bug-free, but with the
> characteristics of 3.18.21, and the gc can ensure that reasonably big
> areas spanning multiple zones will be reused, then f2fs will be the _ONLY_ fs
> able to take care of drive managed smr disks efficiently.

Hmm. The f2fs has been deployed on smartphones for a couple of years so far.
The main stuffs here would be about tuning it with SMR drives.
It's the time for me to take a look at pretty big partitions. :)

Oh, anyway, have you tried just -s1 for fun?

Thanks,

> 
> Specifically, these filesystems do NOT work well with these drives:
> 
> nilfs, zfs, btrfs, ext4, xfs
> 
> And modifications for these filesystems are either far away in the
> future, or not targetted at drive managed disks (ext4 already has some
> modifications, but they are clearly not very suitable for actual drives,
> assuming these drives have a fast area near the start of the disk, which
> isn't the case). But these disks are not uncommon (seagate is shipping by
> the millions), and will stay with us for quite a while.
> 
> -- 
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
