From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: SMR drive test 2; 128GB partition;
 no obvious corruption, much more sane behaviour, weird
 overprovisioning
Date: Wed, 23 Sep 2015 15:08:23 -0700
Message-ID: <20150923220823.GE36564@jaegeuk-mac02.mot.com>
References: <20150808205003.GA6546@schmorp.de>
	<20150810203106.GA4575@jaegeuk-mac02>
	<20150920235901.GA7017@schmorp.de>
	<20150921081748.GA5637@schmorp.de>
	<20150921081937.GA5718@schmorp.de>
	<20150921095806.GA6809@schmorp.de>
	<20150923011239.GA32520@jaegeuk-mac02.mot.com>
	<20150923041523.GB4946@schmorp.de>
	<20150923060037.GA6667@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZesDJ-0008Ro-Ur
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 22:08:33 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZesDI-0001tv-Es for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 22:08:33 +0000
Content-Disposition: inline
In-Reply-To: <20150923060037.GA6667@schmorp.de>
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

On Wed, Sep 23, 2015 at 08:00:37AM +0200, Marc Lehmann wrote:
> On Wed, Sep 23, 2015 at 06:15:24AM +0200, Marc Lehmann <schmorp@schmorp.de> wrote:
> > > However, when I tried to do mkfs.f2fs with the same options, I got about 18GB.
> > > Could you share the mkfs.f2fs messages and fsck.f2fs -d3 as well?
> > 
> > When I re-ran the mkfs.f2fs, I got:
> 
> I get the feeling I did something idiotic, but for the life of it, I don't
> know what. I see the mkfs.f2fs in my test log, I see it in my command
> history, but for the life of it, I can't reproduce it.
> 
> So let's disregard this and go to the next test - I redid the 128G partitipn
> test, with 6 active logs, no -o and -s64:
> 
>    mkfs.f2fs -lTEST -s64 -t0 -a0
> 
> This allowed me to arrive at this state, at which rsync stopped making
> progress:
> 
>    root@shag:/sys/fs/f2fs/dm-1# df -H /mnt
>    Filesystem                Size  Used Avail Use% Mounted on
>    /dev/mapper/vg_test-test  138G  137G  803k 100% /mnt

Could you please share /sys/kernel/debug/f2fs/status?

> 
> This would be about perfect (I even got ENOSPC for the first
> time!). However, when I do my "delete every nth file":
> 
>    /dev/mapper/vg_test-test  138G  135G  1.8G  99% /mnt
> 
> The disk still sits mostly idle. I did verify that "sync" indeed reduces
> Pre-Free to 0, and I do see some activity every ~30s now, though:
> 
> http://ue.tst.eu/ac1ec447de214edc4e007623da2dda72.txt (see the dsk/sde
> columns).
> 
> If I start writing, I guess I trigger the foreground gc:
> 
> http://ue.tst.eu/1dfbac9166552a95551855000d820ce9.txt
> 
> The first few lines there are some background gc activity (I guess), then I
> started an rsync to write data - net/total shows the data rsync transfers.
> After that, there is constant ~40mb read/write activity, but very little
> actual write data gets to the disk (rsync makes progress at <100kb/s).
> 
> At some point I stop rsync (the single line line with 0/0 for sde read
> write, after the second header), followed by sync a second later. Sync
> does it's job, and then there is no activity for a bit, until I start
> rsync again, which immediatelly triggers the 40/40 mode, and makes little
> progress.
> 
> So little to no gc activity, even though the filesystem really needs some
> GC activity at this point.
> 
> If I play around with gc_* like this:
> 
>    echo 1 >gc_idle
>    echo 1000 >gc_max_sleep_time
>    echo 5000 >gc_no_gc_sleep_time

As Chao mentioned, if the system is idle, f2fs starts to do GC with
gc_min_sleep_time.

> 
> Then I get a lot more activity:
> 
> http://ue.tst.eu/f05ee3ff52dc7814ee8352cc2d67f364.txt
> 
> But still, as you can see, a lot of the time the disk and the cpu are
> idle.
> 
> In any case, I think I am getting somewhere - until now all my tests ended in
> unusable filesystem sooner or later, this is the firts one which shows mostly
> expected behaviour.
> 
> Maybe -s128 (or -s256) with which I did my previous tests are problematic?
> Maybe the active_logs=2 caused problems (but I only used this option recently)?
> 
> And the previous problems can be explaioned by using inline_dentry and/or
> extent_cache.
> 
> Anyway, this behaviour is what I would expect, mostly.
> 
> Now, I could go with -s64 (128MB segments still span 4-7 zones with this
> disk). Or maybe something uneven, such as -s90, if that doesn't cause
> problems.
> 
> Also, if it were possible to tune the gc to be more aggressive when idle
> (and mostly off if the disk is free), and possibly, if the loss of space
> by metadata could br reduced, I'd risk f2fs in production in one system
> here.

When I did mkfs.f2fs on 128GB, I got the following numbers.

option                 overprovision area         reserved area
-o5 -s128              9094                       6144
-o5 -s64               6179                       3072
-o5 -s1                3309                       48
-o1 -s128              27009                      26624
-o1 -s64               13831                      13312
-o1 -s1                858                        208

-s1    (ovp:1%)        858                        208
-s64   (ovp:1%)        13831                      13312
-s128  (ovp:1%)        27009                      26624

So, I'm convinced that your inital test set "-o1 -s128", which was an unlucky
trial. :)
Anyway, I've found a bug in the case without -o, which is "-s64" should select
other overprovision ratio instead of "1%".

With the below patch, I could get:

-s1    (ovp:1%)        858                        208
-s64   (ovp:4%)        6172                       3712
-s128  (ovp:6%)        8721                       5120

>From 6e2b58dcaffc2d88291e07fa1f99773eca04a58f Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Wed, 23 Sep 2015 14:59:30 -0700
Subject: [PATCH] mkfs.f2fs: fix wrong ovp space calculation on large section

If a section consists of multiple segments, we should change the equation
to apply it on reserved space.

On 128GB,

option                 overprovision area         reserved area
-o5 -s128              9094                       6144
-o5 -s64               6179                       3072
-o5 -s1                3309                       48
-o1 -s128              27009                      26624
-o1 -s64               13831                      13312
-o1 -s1                858                        208

-s1                    858                        208
-s64   *               13831                      13312
-s128  *               27009                      26624
: * should be wrong.

After patch,

-s1    (ovp:1%)        858                        208
-s64   (ovp:4%)        6172                       3712
-s128  (ovp:6%)        8721                       5120

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 21e74fe..2d4ab09 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -171,7 +171,8 @@ static u_int32_t get_best_overprovision(void)
 	}
 
 	for (; candidate <= end; candidate += diff) {
-		reserved = 2 * (100 / candidate + 1) + 6;
+		reserved = (2 * (100 / candidate + 1) + 6) *
+						get_sb(segs_per_sec);
 		ovp = (get_sb(segment_count_main) - reserved) * candidate / 100;
 		space = get_sb(segment_count_main) - reserved - ovp;
 		if (max_space < space) {
-- 
2.1.1


------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
