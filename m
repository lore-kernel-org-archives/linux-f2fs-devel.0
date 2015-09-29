From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: SMR drive test 2; 128GB partition;
 no obvious corruption, much more sane behaviour, weird
 overprovisioning
Date: Tue, 29 Sep 2015 09:36:25 +0200
Message-ID: <20150929073625.GB6395@schmorp.de>
References: <20150923060037.GA6667@schmorp.de>
	<20150923220823.GE36564@jaegeuk-mac02.mot.com>
	<20150923233937.GE3463@schmorp.de>
	<20150924172749.GB40291@jaegeuk-mac02>
	<20150925054225.GB486@schmorp.de>
	<20150925174546.GA6269@jaegeuk-mac02.mot.com>
	<20150926033249.GB4311@schmorp.de>
	<20150926073655.GB13619@jaegeuk-mac02.hsd1.ca.comcast.net>
	<20150926135353.GA9860@schmorp.de>
	<20150928183352.GB16945@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZgpSl-0002Bo-Eo
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Sep 2015 07:36:35 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZgpSj-0007ZF-BV
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Sep 2015 07:36:35 +0000
Content-Disposition: inline
In-Reply-To: <20150928183352.GB16945@jaegeuk-mac02.mot.com>
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
Cc: linux-f2fs-devel@lists.sourceforge.net

On Mon, Sep 28, 2015 at 11:33:52AM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> Hmm. It seems that SMR has 20~25GB cache to absorb random writes with a big
> block map. Then, it uses a static allocation, which is a kind of very early
> stage of FTL shapes though.

Yes, very sucky. For my previous tests, though, the cache is essentially
irrelevant, and only makes it harder to diagnose problems (it is very
helpful under light load, though).

> Comparing to flash, it seems that SMR degrades the performance significantly
> due to internal cleaning overhead, so I could understand that it needs to
> control IO patterns very carefully.

Yes, basically every write that ends (in time) before the zone boundary
requires RMW. Even writes that cross the zone boundary might require RMW as
the disk can probably only overwrite the zone partially once before having to
rewrite it fully again.

Since basically every write ends within a zone, the only way to keep
performance is to have very large sequential writes crossing multiple
zones, in multiple chunks, quick enough so the disk doesn't consider the
write as finished. Large meaning 100MB+.

> So, how about testing -s20, which comes resasonble to me?

I can test with -s20, but I fail to see why that is reasonable: -s20 menas
40MB, which isn't even as large as a single large zone, so spells desaster
in my book, basically causing a RMW cycle for every single section.
(Hopefully I just don't understand f2fs well enough).

In any acse, if -s20 if reasonable, then I would assume -s1 would also
reasonable, as both cause sections to be not larger than a zone.

> > characteristics of 3.18.21, and the gc can ensure that reasonably big
> > areas spanning multiple zones will be reused, then f2fs will be the _ONLY_ fs
> > able to take care of drive managed smr disks efficiently.
> 
> Hmm. The f2fs has been deployed on smartphones for a couple of years so far.
> The main stuffs here would be about tuning it with SMR drives.

Well, I don't want to sound too negative, and honestly, now that I gathered
more experience with f2fs I do start to consider it for a lot more than
originally anticipated (I will try to replace ext4 with it for a database
partiton on an ssd, and I do think f2fs might be a possible replacement for
traditional fs's on rotationel media as well).

However, it's clearly far from stable - the amuount of data corruption I got
with documented options was enourmous, and the fact that causes sync to hang
and freeze the fs in 3.18.21 is a serious show-stopper.

You would expect that it doesn't work fine, out of the box, with SMR
drives, but the reality is that all my early tests showed that f2fs works
fine (compared to other filesystems even stellar!) on SMR drives, but
isn't stable itself, independ on the drive technology. Only the later
kernels fail to perform with SMR drives, and that might or might not be
fixable.

> It's the time for me to take a look at pretty big partitions. :)

I also have no issues when large partitions pose a problem for f2fs - I
am confident that this can be fixed. Can't wait to use it for some 40TB
partitions and see how it performs in practise :)

In fact, I think f2fs + dmcache (with google modifications) + traditional
rotational drives might deliver absolutely superior performance to XFS,
which is my current workhorse for such partitions.

(One would hope fsck times could be improved for this, though, although
they are not particularly bad at this time).

> Oh, anyway, have you tried just -s1 for fun?

Will also try and see how it performs with the first hundred GB or so.

Then I will get the traces.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
