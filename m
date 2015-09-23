From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: SMR drive test 2; 128GB partition;
 no obvious corruption, much more sane behaviour, weird
 overprovisioning
Date: Wed, 23 Sep 2015 06:15:24 +0200
Message-ID: <20150923041523.GB4946@schmorp.de>
References: <20150808205003.GA6546@schmorp.de>
	<20150810203106.GA4575@jaegeuk-mac02>
	<20150920235901.GA7017@schmorp.de>
	<20150921081748.GA5637@schmorp.de>
	<20150921081937.GA5718@schmorp.de>
	<20150921095806.GA6809@schmorp.de>
	<20150923011239.GA32520@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZebSv-0006o9-7Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 04:15:33 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZebSt-0002sn-IQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 04:15:33 +0000
Content-Disposition: inline
In-Reply-To: <20150923011239.GA32520@jaegeuk-mac02.mot.com>
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

On Tue, Sep 22, 2015 at 06:12:39PM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> Hmm. Is it necessary to reduce the number of active_logs?

I don't know, the documentation isn't very forthcoming with details :)

In any case, this is just for testing. My rationale was that multiple logs
probably means that there are multiple sequential write zones. Reducing those

Only two logs would help the disk. Probably. Maybe.

> increase the GC overheads significantly.

Can you elaborate? I do get a speed improvement with only two logs, but of
course, GC time is an impoprtant factor, so maybe more logs would be a
necessary trade-off.

> And, you can use inline_data in v4.2.

I think I did - the documentation says inline_data is the default.

> >     Filesystem                Size  Used Avail Use% Mounted on
> >     /dev/mapper/vg_test-test  128G  106G   22G  84% /mnt
> > 
> >     # du -skc /mnt
> >     51674268        /mnt
> >     51674268        total
> > 
> >     Utilization: 67% (13168028 valid blocks)
> 
> Ok. I could retrieve the on-disk layout from the below log.
> In the log, the overprovision area is set as about 54GB.
> However, when I tried to do mkfs.f2fs with the same options, I got about 18GB.
> Could you share the mkfs.f2fs messages and fsck.f2fs -d3 as well?

When I re-ran the mkfs.f2fs, I got:

   Filesystem                Size  Used Avail Use% Mounted on
   /dev/mapper/vg_test-test  138G   20G  118G  14% /mnt

I didn't note down the overhead in my test, the df I had was when the disk
was filled, so it possibly changed(?) at runtime?

(I tried debians mkfs.f2fs, but it gave identical results).

I'll redo the 128GiB test and see if I can get similar results.

> > However, when pausing rsync, f2fs immediatelly ceased doing anything again,
> > so even though clearly there is a need for clean up activities, f2fs doesn't
> > do them.
> 
> It seems that why f2fs didn't do gc was that all the sections were traversed
> by background gc. In order to reset that, it needs to trigger checkpoint, but 
> it couldn't meet the condition in background.
> 
> How about calling "sync" before leaving the system as idle?
> Or, you can check decreasing the number in /sys/fs/f2fs/xxx/reclaim_segments to
> 256 or 512?

Will try next time. I distinctly remember that sync didn't do anything to
pre-free and free, though.

> > 1. the overprovisioning values seems to be completely out of this world. I'm
> > prepared top give up maybe 50GB of my 8TB disk for this, but not more.
> 
> Maybe, it needs to check with other filesystems' *available* spaces.
> Since, many of them hide additional FS metadata initially.

I habitually do comparefree space between filesystems. While f2fs is better
than ext4 with default settings (and even with some tuning), ext4 is quite
known to have excessive preallocated metadata requirements.

As mentioned in my other mail, XFS for example has 100GB more free
space than f2fs on the full 8TB device, and from memory I expect other
filesystems without fixed inode numbers (practically all of them) to be
similar.

> > 3. why does f2fs sit idle on a highly fragmented filesystem, why does it not
> > do background garbage collect at maximum I/O speed, so the filesystem is
> > ready when the next writes come?
> 
> I suspect the section size is too large comparing to the whole partition size,
> which number is only 509. Each GC selects a victim in a unit of section and
> background GC would not select again for the previously visited ones.
> So, I think GC is easy to traverse whole sections, and go to bed since there
> is no new victims. So, I think checkpoint, "sync", resets whole history and
> makes background GC conduct its job again.

The large section size is of course the whole point of the exercise, as
hopefully this causes the GC to do larger sequential writes. It's clear
that this is not a perfect match for these SMR drives, but the goal is to
have acceptable performance, faster than a few megabytes/s. And indeed,
when the GC runs, it get quite good I/O performance in my test (deleteing
every nth file makes comparatively small holes, so the GC has to copy most
of the section).

Now, the other thing is that the GC, whgen it triggers, isn't very
aggressive - when I saw it, it was doing something every 10-15 seconds,
with the system being idle, when it should be more or less completely busy.

I am aware that "idle" is a difficult to inmpossible condition to detect
- maybe this could be made more tunable (I tried to play around with the
gc_*_time values, but probably due to lack of documentation. I didn't get
very far, and couldn't correlate the behaviour I saw with the settings I
made).

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
