From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: general stability of f2fs?
Date: Thu, 13 Aug 2015 02:26:41 +0200
Message-ID: <20150813002641.GA5551@schmorp.de>
References: <20150808205003.GA6546@schmorp.de>
	<20150810203106.GA4575@jaegeuk-mac02>
	<20150810205332.GA4911@schmorp.de>
	<20150810215806.GA5045@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZPgM8-0008H0-QP
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Aug 2015 00:26:52 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZPgM5-0005Nr-5O
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Aug 2015 00:26:52 +0000
Content-Disposition: inline
In-Reply-To: <20150810215806.GA5045@jaegeuk-mac02.mot.com>
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

On Mon, Aug 10, 2015 at 02:58:06PM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> IMO, it's similar to flash drives too. Indeed, I believe host-managed SMR/flash
> drives are likely to show much better performance than drive-managed ones.

If I had one, its performance would be abysmal, as filesystems (and
indeed, driver support) for that are far away... :)

> However, I think there are many HW constraints inside the storage not to move
> forward to it easily.

Exactly :)

> > Now, looking at the characteristics of f2fs, it could be a good match for
> > any rotational media, too, since it writes linearly and can defragment. At
> > least for desktop or similar loads (where files usually aren't randomly
> > written, but mostly replaced and rarely appended).
> 
> Possible, but not much different from other filesystems. :)

Hmm, I would strongly disagree - most other filesystems cannot defragment
effectively. For example, xfs_fsr is unstable under load and only
defragments files, but greatly increases external fragmentation over time.
Similarly for e4defrag. Most other filesystems do not even have a way to
defragment.

Files that are defragmented never move on other filesystems. This can be
true for f2fs as well, but as far as I can see, if formatted with e.g.
-s128, the external fragments will be 256mb in size, which is far more
acceptable than the millions of 4-100kb size fragments on some of my xfs
filesystems.

If I wouldn't copy my filesystems every 1.5 years or so, they would be
horrible degraded. It's very common to read directories with many medium
to small files at 10-20mb/s on an old xfs filesystem, but at 80mb/s on a
new one with exactly the same contents.

I don't think f2fs will intelligently defragment and relayout directories
anytime soon, either, but at least internal and external defragmentation
are being managed.

> Okay, so I think it'd be good to start with:
>  - noatime,inline_xattr,inline_data,flush_merge,extent_cache.

I still haven't found the right kernel for my main server, but I did some
preliminary experiments today, with 3.19.8-ckt5 (an ubuntu kernel).

After formatting a 128G partition with "mkfs.f2fs -o1 -s128 -t0", I got
this after mounting (kernel complained about missing extent_cache in my
kernel version):

   Filesystem                Size  Used Avail Use% Mounted on
   /dev/mapper/vg_test-test  128G   53G   75G  42% /mnt

which give sme another quetsion - on an 8TB disk, 5% overprovision is
400GB, which sounds a bit wasteful. Even 1% (80GB) sounds a bit much,
especially asI am prepared to wait for defragmentation, if defragmentation
works well. And lastly, the 53GB used on a 128GB partition looks way too
conservative.

I immediately configured the fs with these values:

   echo 500 >gc_max_sleep_time
   echo 100 >gc_min_sleep_time
   echo 800 >gc_no_gc_sleep_time

Anyways, I write it until disk was 99% utilizied according to
/sys/kernel/debug/f2fs/status, at which write speed crawled down to 1-2MB/s.

I deleted some "random" files till utilisation was at 38%, then waited
until there was no disk I/O (disk went into standby, which indicates that
it has flushed its internal transaction log as well).

When I then tried to write a file, the writer (rsync) stopped after ~4kb, and
the filesystem started reading at <2MB/s and wriitng at <2MB/s for a few
minutes. Since I didn't intend this to test very well (I was looking mainly
for a kernel that worked well with the hardware and drives), I didn't make
detailed notes, but basically, "LFS:" increased exactly with the writing
speed.

I then stopped writing, after which the fs wrote (but did not read) a bit
longer at this speed, then became idle, disk went into standby again.

The next day, I mounted it, and now I will take notes. Initial status was:

   http://ue.tst.eu/e2ea137a6b87fd0e43446b286a3d1b19.txt

The disk woke up and started reading and writing at <1MB/s:

   http://ue.tst.eu/a9dd48428b7b454f52590efeea636a27.txt

At some point, you can see that the disk stopped reading, that's when I
killed rsync. rsync also transfers over the net, and as you can see, it
didn't maange to transfer anything. The read I/O is probably due to rsync
reading the filetree info.

A status snapshot after killing rsync looks like this:

   http://ue.tst.eu/211fc87b0b43270e4b2ee0261d251818.txt

The disk did no other I/O afterwards and went into standby again.

I repeated the experiment a few minutes later with similar
results, with these differences:

1. There was absolutely no read I/O (maybe all inodes were still in the
   cache, but that would be surprising as rsync probably didn't read all
   of them in the previous run).

2. The disk didn't stay idle this time, but instead kept steadily writing
at ~1MB/s.

Status output at the end:

   http://ue.tst.eu/cbb4774b2f8e44ae68e635be5a414d1d.txt

Status output a bit later, disk still writing:

   http://ue.tst.eu/9fbdfe1e9051a65c1417bea7192ea182.txt

Much later, disk idle:

   http://ue.tst.eu/78a1614d867bfbfa115485e5fcf1a1a8.txt

At this point, my main problem is that I have no clue what is causing the
slow writes. Obviously the garbage collector doesn't think anything needs
to be done, it shouldn't be IPU writes either then, and even if they are,
I don't know what the ipu_policy's mean.

I tried the same with ipu_policy=8 and min_ipu_util=100, also separately
also gc_idle=1, with seemingly no difference.

Here is what I expect should happen:

When I write to a new disk, or append to a still-free-enough disk, writing
happens linearly (with that I mean appending to multiple of its logs
linearly, which is not optimal, but should be fine). This clearly happens,
and near perfectly so.

When the disk is near-full, bad things might happen, delays might be there
when some small areas are being garbage collected.

When I delete files, the disk should start garbage collecting at around
50mb/s read + 50mb/s write. If combined with writing, I should be able to
write at roughly 30MB/s while the garbage collector is cleaning up.

I would expect the gc to do its work by selecting a 256MB section, reading
everything it needs to, write this data linearly to some log poossibly
followed by some random update and a flush or somesuch, and thus achieve
about 50MB/s cleaning throughput. This clearly doesn't seem to happen,
possibly because the gc things nothing needs to be done.

I would expect the gc to do its work when the disk is idle, at least if
need to, so after coming back after a while, I can write at nearly full
speed again. This also dosn't happen - maybe the gc runs, but writing to
the disk is impossible even after it qwuited down.

> > Another thing that will seriously hamper adoption of these drives is the
> > 32000 limit on hardlinks - I am hard pressed to find any large file tree
> > here that doesn't have places with of 40000 subdirs somewhere, but I guess
> > on a 32GB phone flash storage, this was less of a concern.
> 
> Looking at a glance, it'll be no problme to increase as 64k.
> Let me check again.

I thought more like 2**31 or so links, but it so happens that all my
testcases (by pure chance) have between 57k and 64k links,. so thanks a
lot for that.

If you are reluctant, look at other filesystems. extX thought 16 bit is
enough. btrfs thought 16 bit is enough - even reiserfs thought 16 bit is
enough. Lots of filesystems thought 16 bits is enough, but all modern
incarnations of them do 31 or 32 bit link counts these days.

It's kind of rare to have 8+TB of storage where you are fine with 2**16
subdirectories everywhere.

> What kernel version do you prefer? I've been maintaining f2fs for v3.10 mainly.
> 
> http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git/log/?h=linux-3.10

I have a hard time finding kernels that work with these SMR drives. So
far, only the 3.18.x and the 3.19.x series works for me. the 3.17 and
3.16 kernels fail for various reasons, and the 4.1.x kernels still fail
miserably with these drives.

So, at this point, it needs to be either 3.18 or 3.19 for me. It seems
3.19 has everything but the extent_cache, which probably shouldn't make
such a big difference. Are there any big bugs in 3.8/3.19 which I would
have to look out for? Storage size isn't an issue right now, because I can
reproduce the performance characteristics just fine on a 128G partition.

I mainly asked because I thought newer kernel versions might have
important bugfixes.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
