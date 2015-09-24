From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: write performance difference 3.18.21/4.2.1
Date: Thu, 24 Sep 2015 11:28:36 -0700
Message-ID: <20150924182836.GD40291@jaegeuk-mac02>
References: <20150923215850.GC2360@schmorp.de>
	<20150923231103.GA3463@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZfBGA-0003yW-0l
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Sep 2015 18:28:46 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZfBG9-0002kb-1G for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Sep 2015 18:28:46 +0000
Content-Disposition: inline
In-Reply-To: <20150923231103.GA3463@schmorp.de>
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

On Thu, Sep 24, 2015 at 01:11:03AM +0200, Marc Lehmann wrote:
> I tried twice with the same options, on linux 3.8.21 and 4.2.1, and write
> performance is very different on these kernels (I rebooted every time in
> between).
> 
> On 3.18.21, the source raid is hardly able to keep up with the write
> speed, f2fs basically writes at more or less full disk speed, for extended
> periods of time. As mentiopned earlier, average write speed was 103MB/s
> over the whole 2.1TB, with f2fs being idle a lot of that time, so actual
> write speed would be higher.
> 
> On 4.2.1, same mkfs+mount options, performance is 5-10 times less, i.e.
> <<100MB/s (and more like 20MB/s for extendesd stretches):
> 
> http://ue.tst.eu/43a8f7ae96ac770dc45ac8f1e3b0c479.txt
> (see the dsk/sde columns)
> 
> First there is a "good" stretch with >100MB/s, then it starts to degrade.
> Another difference is the frequent read activity, which is mostly absent on
> 3.18.21.
> 
> The log starts after only 20GB had been written. Here is the status output
> at 25GB:
> 
> http://ue.tst.eu/734f7883107ee4dabff77602db92310b.txt

It seems about 700MB were moved by background GC.

> 
> Any idea why 4.2.1 performs so much worse than 3.8.21?

One thing that we can try is to run the latest f2fs source in v3.18.
This branch supports f2fs for v3.18.

http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git/log/?h=linux-3.18

Could you check out this branch and then copy the following files into your
v3.18 kernel?

- fs/f2fs/*
- include/linux/f2fs_fs.h
- include/trace/event/f2fs.h

And, if possible, could you share the status output of both of v3.18 and v4.2?

Thanks,

> 
> (Note, if that is the difference between "filesystem works" (4.2.1?) and
> "filesystem doesn't work" (3.18.21) then that might be it - still, that
> would mean f2fs performs worse than traditional filesystems on these
> disks).
> 
> -- 
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\
> 
> ------------------------------------------------------------------------------
> Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
> Get real-time metrics from all of your servers, apps and tools
> in one place.
> SourceForge users - Click here to start your Free Trial of Datadog now!
> http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
