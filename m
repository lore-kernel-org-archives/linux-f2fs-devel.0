From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: SMR drive test 2; 128GB partition;
 no obvious corruption, much more sane behaviour, weird
 overprovisioning
Date: Thu, 24 Sep 2015 10:21:01 -0700
Message-ID: <20150924172100.GA40291@jaegeuk-mac02>
References: <20150920235901.GA7017@schmorp.de>
	<20150921081748.GA5637@schmorp.de>
	<20150921081937.GA5718@schmorp.de>
	<20150921095806.GA6809@schmorp.de>
	<20150923011239.GA32520@jaegeuk-mac02.mot.com>
	<20150923041523.GB4946@schmorp.de>
	<20150923060037.GA6667@schmorp.de>
	<011201d0f5dd$c3a4f650$4aeee2f0$@samsung.com>
	<20150923233022.GD3463@schmorp.de>
	<20150923234323.GF3463@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZfACn-0001YA-2t
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Sep 2015 17:21:13 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZfACl-0007OD-Bu for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Sep 2015 17:21:13 +0000
Content-Disposition: inline
In-Reply-To: <20150923234323.GF3463@schmorp.de>
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

On Thu, Sep 24, 2015 at 01:43:24AM +0200, Marc Lehmann wrote:
> On Thu, Sep 24, 2015 at 01:30:22AM +0200, Marc Lehmann <schmorp@schmorp.de> wrote:
> > > One thing I note is that gc_min_sleep_time is not be set in your script,
> > > so in some condition gc may still do the sleep with gc_min_sleep_time (30
> > > seconds by default) instead of gc_max_sleep_time which we expect.
> > 
> > Ah, sorry, I actually set gc_min_sleep_time to 100, but forgot to include
> > it.
> 
> Sorry, that sounded confusing - I set it to 100 in previous tests, and forgot
> to include it, so it was running with 30000. When experimenting, I actually
> do get the gc to do more frequent operations now.
> 
> Is there any obvious harm setting it to a very low value (such as 100 or 10)?
> 
> I assume all it does is have less time buffer between the last operation
> and the gc starting. When I write in batches, or when I know the fs will be
> idle, there shouldn't be any harm, performance wise, of letting it work all
> the time.

Yeah, I don't think it does matter with very small time periods, since the timer
is set after background GC is done.
But, we use msecs_to_jiffies(), so hope not to use something like 10 ms, since
each backgroudn GC conducts reading victim blocks into page cache and then just
sets them as dirty.
That indicates, after a while, we hope flusher will write them all to disk and
finally we got a free section.
So, IMO, we need to give some time slots to flusher as well.

For example, if write bandwidth is 30MB/s and section size is 128MB, it needs
about 4secs to write one section.
So, how about setting
 - gc_min_time to 1~2 secs,
 - gc_max_time to 3~4 secs,
 - gc_idle_time to 10 secs,
 - reclaim_segments to 64 (sync when 1 section becomes prefree)

Thanks,

> 
> -- 
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
