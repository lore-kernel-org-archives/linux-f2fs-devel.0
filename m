From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: SMR drive test 2; 128GB partition;
 no obvious corruption, much more sane behaviour, weird
 overprovisioning
Date: Wed, 23 Sep 2015 08:00:37 +0200
Message-ID: <20150923060037.GA6667@schmorp.de>
References: <20150808205003.GA6546@schmorp.de>
	<20150810203106.GA4575@jaegeuk-mac02>
	<20150920235901.GA7017@schmorp.de>
	<20150921081748.GA5637@schmorp.de>
	<20150921081937.GA5718@schmorp.de>
	<20150921095806.GA6809@schmorp.de>
	<20150923011239.GA32520@jaegeuk-mac02.mot.com>
	<20150923041523.GB4946@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1Zed6m-0001R2-0b
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 06:00:48 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zed6j-0008HL-BC
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 06:00:47 +0000
Content-Disposition: inline
In-Reply-To: <20150923041523.GB4946@schmorp.de>
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

On Wed, Sep 23, 2015 at 06:15:24AM +0200, Marc Lehmann <schmorp@schmorp.de> wrote:
> > However, when I tried to do mkfs.f2fs with the same options, I got about 18GB.
> > Could you share the mkfs.f2fs messages and fsck.f2fs -d3 as well?
> 
> When I re-ran the mkfs.f2fs, I got:

I get the feeling I did something idiotic, but for the life of it, I don't
know what. I see the mkfs.f2fs in my test log, I see it in my command
history, but for the life of it, I can't reproduce it.

So let's disregard this and go to the next test - I redid the 128G partitipn
test, with 6 active logs, no -o and -s64:

   mkfs.f2fs -lTEST -s64 -t0 -a0

This allowed me to arrive at this state, at which rsync stopped making
progress:

   root@shag:/sys/fs/f2fs/dm-1# df -H /mnt
   Filesystem                Size  Used Avail Use% Mounted on
   /dev/mapper/vg_test-test  138G  137G  803k 100% /mnt

This would be about perfect (I even got ENOSPC for the first
time!). However, when I do my "delete every nth file":

   /dev/mapper/vg_test-test  138G  135G  1.8G  99% /mnt

The disk still sits mostly idle. I did verify that "sync" indeed reduces
Pre-Free to 0, and I do see some activity every ~30s now, though:

http://ue.tst.eu/ac1ec447de214edc4e007623da2dda72.txt (see the dsk/sde
columns).

If I start writing, I guess I trigger the foreground gc:

http://ue.tst.eu/1dfbac9166552a95551855000d820ce9.txt

The first few lines there are some background gc activity (I guess), then I
started an rsync to write data - net/total shows the data rsync transfers.
After that, there is constant ~40mb read/write activity, but very little
actual write data gets to the disk (rsync makes progress at <100kb/s).

At some point I stop rsync (the single line line with 0/0 for sde read
write, after the second header), followed by sync a second later. Sync
does it's job, and then there is no activity for a bit, until I start
rsync again, which immediatelly triggers the 40/40 mode, and makes little
progress.

So little to no gc activity, even though the filesystem really needs some
GC activity at this point.

If I play around with gc_* like this:

   echo 1 >gc_idle
   echo 1000 >gc_max_sleep_time
   echo 5000 >gc_no_gc_sleep_time

Then I get a lot more activity:

http://ue.tst.eu/f05ee3ff52dc7814ee8352cc2d67f364.txt

But still, as you can see, a lot of the time the disk and the cpu are
idle.

In any case, I think I am getting somewhere - until now all my tests ended in
unusable filesystem sooner or later, this is the firts one which shows mostly
expected behaviour.

Maybe -s128 (or -s256) with which I did my previous tests are problematic?
Maybe the active_logs=2 caused problems (but I only used this option recently)?

And the previous problems can be explaioned by using inline_dentry and/or
extent_cache.

Anyway, this behaviour is what I would expect, mostly.

Now, I could go with -s64 (128MB segments still span 4-7 zones with this
disk). Or maybe something uneven, such as -s90, if that doesn't cause
problems.

Also, if it were possible to tune the gc to be more aggressive when idle
(and mostly off if the disk is free), and possibly, if the loss of space
by metadata could br reduced, I'd risk f2fs in production in one system
here.

Greetings,

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
