From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: SMR drive test 2; 128GB partition;
 no obvious corruption, much more sane behaviour, weird
 overprovisioning
Date: Tue, 22 Sep 2015 18:12:39 -0700
Message-ID: <20150923011239.GA32520@jaegeuk-mac02.mot.com>
References: <20150808205003.GA6546@schmorp.de>
	<20150810203106.GA4575@jaegeuk-mac02>
	<20150920235901.GA7017@schmorp.de>
	<20150921081748.GA5637@schmorp.de>
	<20150921081937.GA5718@schmorp.de>
	<20150921095806.GA6809@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZeYc7-0002VE-JR
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 01:12:51 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZeYc5-0001xx-N8 for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 01:12:51 +0000
Content-Disposition: inline
In-Reply-To: <20150921095806.GA6809@schmorp.de>
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

On Mon, Sep 21, 2015 at 11:58:06AM +0200, Marc Lehmann wrote:
> Second test - we're getting there:
> 
> Summary: looks much better, no obvious corruption (but fsck still gives
> tens of thousands of [FIX] messages), performance somewhat as expected,
> but a 138GB partition can only store 71.5GB of data (avg filesize 2.2MB)
> and f2fs doesn't seem to do visible background GC.
> 
> For this test, changed a bunch of parameters:
> 
>     1. partition size
> 
>        128GiB instead of 512GiB (not ideal, but I wanted this test to be
>        quick)
> 
>     2. mkfs options
> 
>         mkfs.f2fs -lTEST -o5 -s128 -t0 -a0 # change: -o5 -a0

Please, check without -o5.

> 
>     3. mount options
> 
>         mount -t f2fs -onoatime,flush_merge,active_logs=2,no_heap
>         # change: no inline_* options, no extent_cache, but no_heap + active_logs=2

Hmm. Is it necessary to reduce the number of active_logs? Only two logs would
increase the GC overheads significantly.
And, you can use inline_data in v4.2.
In v4.3, I expect extent_cache will be stable and usable.

> 
> First of all, the discrepancy between utilization in the status file, du
> and df is quite large:
> 
>     Filesystem                Size  Used Avail Use% Mounted on
>     /dev/mapper/vg_test-test  128G  106G   22G  84% /mnt
> 
>     # du -skc /mnt
>     51674268        /mnt
>     51674268        total
> 
>     Utilization: 67% (13168028 valid blocks)

Ok. I could retrieve the on-disk layout from the below log.
In the log, the overprovision area is set as about 54GB.
However, when I tried to do mkfs.f2fs with the same options, I got about 18GB.
Could you share the mkfs.f2fs messages and fsck.f2fs -d3 as well?

> 
> So ~52GB of files take up ~106GB of the partition, which is 84% of the
> total size, yet it's only utilized by 67%.
> 
> Second, and subjectively, the filesystem was much more responsive during
> the test- find almost instantly give ssome output, instead of having to
> wait for half a minute, and find|rm is much faster as well. find also
> reads data at ~2mb/s, while in the previous test, it was 0.7MB/s (which
> can be good or bad, but it looks good).
> 
> At 6.7GB free (df: 95%, status: 91%, du: 70/128GiB) I paused rsync. The disk
> then did some heavy read/write for a short while, and the Dirty: count
> reduced:
> 
> http://ue.tst.eu/d61a7017786dc6ebf5be2f7e2d2006d7.txt
> 
> I continued, and the disk afterwards did almost the same amount of reading
> as it was writing, with short intzermittent write-only periods for a fe
> seconds each. Rsync itself was noticably slower, so I guess f2fs finally
> ran out of space and did garbage collect.
> 
> This is exactly the behaviour I did expect of f2fs, but this is the first
> time I actually saw it.
> 
> Pausing didn't result in any activity.
> 
> At 6.3GB free, disk write speed went down to 1MB/s with intermittent
> phases of 100MB/s write only, or 50MB/s read + 50MB/s write (but rsync was
> transferring about 100kb/s at this point only, so no real progress was
> made).
> 
> After about 10 minutes I paused rsync again, still at 6.3GB free (df
> reporting 96% in use, status 91% and du 52% (71.5GB))
> 
> I must admit I don't understand these ratios - df vs. status can easily
> be explained by overprovisioning, but the fact that a 138GB (128GiB)
> partition can only hold 72GB of data with very few small files is not
> looking good to me:
> 
>     # df -H /mnt
>     Filesystem                Size  Used Avail Use% Mounted on
>     /dev/mapper/vg_test-test  138G  130G  6.3G  96% /mnt
>     # du -skc /mnt
>     71572620        /mnt
> 
> I wonder what this means, too:
> 
>     MAIN: 65152(OverProv:27009 Resv:26624)

Yeah, that's the hint that overprovision area occupies 54GB abnormally.
I think there is something wrong on your mkfs.f2fs when calculating reserved
space. It needs to take a look at mkfs.f2fs log.

> 
> Surely this doesn't mean that 27009 of 65152 segments are for
> overprovisioning? That would explain the bad values for due, but then, I
> did specify -o5, not -o45 or so.
> 
> status at that point was:
> 
>     http://ue.tst.eu/f869dfb6ac7b4d52966e8eb012b81d2a.txt
> 
> Anyways, I did more thinning to regain free space by deleting every 10th
> file. That went reasonably slow, the disk was contantly reading + writing at
> high speed, so I guess it was busy garbage colelcting, as it should.
> 
> status after deleting, with completely idle disk:
> 
>     http://ue.tst.eu/1831202bc94d9cd521cfcefc938d2095.txt
> 
>     /dev/mapper/vg_test-test  138G  123G   15G  90% /mnt
> 
> I waited a few minutes, but there was no further activity. I then unpaused
> the rsync, which proceeded with good speed again.
> 
> At 11GB free, rsync effectively stopped, and the disk went to ~1MB/s wrtite
> mode aagin. Pausing rsync didn't cause I/O to stop this time, it continued
> for a few minutes.
> 
> I waited for 2 minutes with no disk I/O, unpaused rsync, and the disk
> immediately went into 1MB/s write mode againh, with rsync not really
> getting any data through though.
> 
> It's as if f2fs only tried to clean up when there is write data. I would
> expect a highly fragmented f2fs to be very busy garbage collecting, but
> apparently, not so, it just idles, and when a program wants to write,
> fails to perform. Maybe I need to give it more time than two minutes, but
> then, I wouldn't see a point in delaying to garbage collect if it has to
> be done anyways.
> 
> In any case, no progress possible, I deleted more files again, this time
> every 5th file, which went reasonably fast,
> 
> status after delete:
> 
>     http://ue.tst.eu/fb3287adf4cc109c88b89f6120c9e4a6.txt
> 
>     /dev/mapper/vg_test-test  138G  114G   23G  84% /mnt
> 
> rsync writing was reasonably fast down to 18GB, when rsync stopped making
> much profgress (<100kb/s), but the disk wasn't in "1MB/s mode" but instead in
> 40MB/s read+write, which looks reasonable to me, as the disk was probably
> quite fargmented at this point:
> 
>     http://ue.tst.eu/fb3287adf4cc109c88b89f6120c9e4a6.txt
> 
> However, when pausing rsync, f2fs immediatelly ceased doing anything again,
> so even though clearly there is a need for clean up activities, f2fs doesn't
> do them.

It seems that why f2fs didn't do gc was that all the sections were traversed
by background gc. In order to reset that, it needs to trigger checkpoint, but 
it couldn't meet the condition in background.

How about calling "sync" before leaving the system as idle?
Or, you can check decreasing the number in /sys/fs/f2fs/xxx/reclaim_segments to
256 or 512?

> 
> To state this more clearly: My expectation is that when f2fs runs out of
> immediatelly usable space for writing, it should do GC. That means that
> when rsync is very slow and the disk is very fragmented, even when I pause
> rsync, f2fs should GC at full speed until it has a reasonable amount of
> usable free space again. Instead, it apparently just sits idle until some
> program generates write data.
> 
> At this point, I unmounted the filesystem and "fsck.f2fs -f"'ed it. The
> report looked good:
> 
>     [FSCK] Unreachable nat entries                        [Ok..] [0x0]
>     [FSCK] SIT valid block bitmap checking                [Ok..]
>     [FSCK] Hard link checking for regular file            [Ok..] [0x0]
>     [FSCK] valid_block_count matching with CP             [Ok..] [0xe8b623]
>     [FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0xa58a]
>     [FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0xa58a]
>     [FSCK] valid_inode_count matched with CP              [Ok..] [0x7800]
>     [FSCK] free segment_count matched with CP             [Ok..] [0x8a17]
>     [FSCK] next block offset is free                      [Ok..]
>     [FSCK] fixing SIT types
> 
> However, there were about 30000 messages like these:
> 
>     [FIX] (check_sit_types:1056)  --> Wrong segment type [0xfdf6] 0 -> 1
>     [FIX] (check_sit_types:1056)  --> Wrong segment type [0xfdf7] 0 -> 1
>     [FIX] (check_sit_types:1056)  --> Wrong segment type [0xfdf8] 0 -> 1
>     [FIX] (check_sit_types:1056)  --> Wrong segment type [0xfdf9] 0 -> 1
>     [FIX] (check_sit_types:1056)  --> Wrong segment type [0xfdfa] 0 -> 1
>     [FIX] (check_sit_types:1056)  --> Wrong segment type [0xfdfb] 0 -> 1
>     [FIX] (check_sit_types:1056)  --> Wrong segment type [0xfdfc] 0 -> 1
>     [FIX] (check_sit_types:1056)  --> Wrong segment type [0xfdfd] 0 -> 1
>     [FIX] (check_sit_types:1056)  --> Wrong segment type [0xfdfe] 0 -> 1
>     [FIX] (check_sit_types:1056)  --> Wrong segment type [0xfdff] 0 -> 1
>     [FSCK] other corrupted bugs                           [Ok..]
> 
> That's not promising, why does it think it needs to fix anything?

I need to take a look at the fsck.f2fs when handling there are two active logs.
Anyway, this doesn't break the core FS consistency, so you can ignore them.

> 
> I mounted the partition again. Listing the files was very fast. I deleted all
> the files and ran rsync for a while. It seems the partition completely
> recovered. This is the empty state btw.:
> 
>    Filesystem                Size  Used Avail Use% Mounted on
>    /dev/mapper/vg_test-test  138G   57G   80G  42% /mnt
> 
> So, all the pathological behaviour is gone (no 20kb/s write speed blocking
> the disk for hours, more importantly, no obvious filesystem corruption,
> although the fsck messages need explanation).
> 
> Moreso, the behaviour, while still confusing (weird du vs. df, no background
> activity), at least seems to be in line with what I expect - fragmentation
> kills performance, but f2fs seems capable of recovering.
> 
> So here is my wishlist:
> 
> 1. the overprovisioning values seems to be completely out of this world. I'm
> prepared top give up maybe 50GB of my 8TB disk for this, but not more.

Maybe, it needs to check with other filesystems' *available* spaces.
Since, many of them hide additional FS metadata initially.

> 
> 2. even though ~40% of space is not used by file data, f2fs still becomes
> extremely slow. this can't be right.

I think it was due to the wrong overprovision space.
It needs to check that number first.

> 
> 3. why does f2fs sit idle on a highly fragmented filesystem, why does it not
> do background garbage collect at maximum I/O speed, so the filesystem is
> ready when the next writes come?

I suspect the section size is too large comparing to the whole partition size,
which number is only 509. Each GC selects a victim in a unit of section and
background GC would not select again for the previously visited ones.
So, I think GC is easy to traverse whole sections, and go to bed since there
is no new victims. So, I think checkpoint, "sync", resets whole history and
makes background GC conduct its job again.

Thank you, :)

> 
> Greetings, and good night :)
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
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
