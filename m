From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: sync/umount hang on 3.18.21, 1.4TB gone after crash
Date: Sat, 26 Sep 2015 05:08:33 +0200
Message-ID: <20150926030833.GC3669@schmorp.de>
References: <20150923215850.GC2360@schmorp.de>
	<20150924185023.GE40291@jaegeuk-mac02>
	<20150925060018.GC486@schmorp.de>
	<20150925184202.GD6998@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1Zffqt-0006xD-KA
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 03:08:43 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zffqr-00055J-G8
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 03:08:43 +0000
Content-Disposition: inline
In-Reply-To: <20150925184202.GD6998@jaegeuk-mac02>
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

On Fri, Sep 25, 2015 at 11:42:02AM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> AFAIK, there-in *commit* means syncing metadata, not userdata. Doesn't it?

In general, no, they commit userdata, even if not necessarily at the same
time. ext* for example has three modes, and the default commits userdata
before the corresponding metadata (data=ordered).

But even when you relax this (data=writeback), a few minutes after a file is
written, both userdata and metadata are there (usually after 30s). Data that
was just being wirtten is generally mixed, but that's an easy to handle
trade-off.

(and then there is data=journal, which should get perfectly ordered
behaviour for both, at high cost, and flushoncommit).

Early (linux) versions of XFS were more like a brutal version of writeback
- files recently written before a crash were frequently filled with zero
bytes (something I haven't seen with irix, which frequently crashed :).
But they somehow made it work - I was a frequent victim of zero-filled
files, but for many years it didn't happen for me. So while I don't know
if it's a guarantee, in practise, file data is there together with the
metadata, and usually within the writeback period configured in the kernel
(+ whatever time it takes to write out the data, which cna be substantial,
but can also be limited in /proc/sys/vm, especially dirty_bytes and
dirty_background_bytes).

Note also that filesystems often special case write + rename over old
file, and carious other cases, to give a good user experience.

So for traditional filesystems, /proc/sys/vm/dirty_bytes + dirty_expire
gives a pretty good way of defining a) how much data is lost and b) within
which timeframe. Such filesystems also have their own setting for metadata
commit, but they are generally within the timeframe of a few seconds to
half a minute.

It does not have the nice "exact version of a point in time" qualities you
can get from log-based file system, but they give quite nice guarantees in
practise - if a file was half-written, it does not have it's full length
but corrupted data inside for example.

For things like database files, this could be an issue, as indeed you
don't control the order of things written, but programs *know* about this
problem and fsync accordingly (and the kernel has extra support for these
things, as in sync_page_range and so on).

So, in general, filesystems only commit metadata, but the kernel commits
userdata on its own, and as extra feature, "good" filesystems such
as xfs or ext* have extra logic to commit userdata before committing
corresponding metadata (or after).

Note also that with most journal-based filesystems, commit just forces the
issue, both metadata and userdata usually hit the disk much earlier.

In addition, the issue at hand is f2fs losing metadata, not userdata,
as all data had been written to the device hours before tghe crash. The
userdata was all there, but the filesystem forgot to how to access it.

> So, even if you saw no data loss, filesystem doesn't guarantee all the data were
> completely recovered, since sync or fsync was not called for that file.

No, but I feel fairly confident that a file written over a minutes ago
on a box that is sitting idle for a minute is still there after a crash,
barring hardware faults.

Now, I am not neecessarily criticing f2fs here, after all, the problem at
hand is f2fs _hanging_, which is clearly a bug. I don't know how well f2fs
performs with this bug fixed, regarding data loss.

Also, f2fs is a different beast - syncs can take a veeery long time on f2fs
compared to xfs or ext4, and maybe that is due to the design of f2fs (I
suppose so, but you can correct me). In which case it might not be such a
good idea to commit every 30s. Maybe my performance problem was because
f2fs committed every 30s.

> I think you need to tune the system-wide parameters related to flusher mentioned
> by Chao for your workloads.

I already do configure these extensively, according to my workload. On the
box I did my recent tests:

   vm.dirty_ratio = 80
   vm.dirty_background_ratio = 4
   vm.dirty_writeback_centisecs = 100
   vm.dirty_expire_centisecs = 100

These are pretty aggressive. The reason is that the box has 32GB of ram, and
with default values it is not uncommon to get 10-20gb of dirty data before a
writeback, which then more or less freezes everything and can take a long
time. So the above values don't wait long to write userdata, and make sure a
process generating lots of dirty blocks can't freeze the system.

Speciifcally, in the case of tar writing files, tar will start blocking after
only ~1.3GB of dirty data.

That means with a "conventional" filesystem, I lose at most 1.3GB of data
+ less than 30s, on a crash.

> And, we need to expect periodic checkpoints are able to recover the previously
> flushed data.

Yes, I would consider this a must, however, again, I can accept if f2fs
needs much higher "commit" intervals than other filesystems (say, 10
minutes), if that is needed to make it performant.

But some form of fixed timeframe is needed, I tzhink, whether it's seconds
or minutes.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
