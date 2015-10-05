From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: assumptions and misconceptions about f2fs behaviour,
 please correct
Date: Mon, 5 Oct 2015 15:44:19 -0700
Message-ID: <20151005224419.GA7635@jaegeuk-mac02.mot.com>
References: <20151004095429.GB3177@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZjEUf-0005aP-An
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 22:44:29 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZjEUe-0004VD-6x for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 22:44:29 +0000
Content-Disposition: inline
In-Reply-To: <20151004095429.GB3177@schmorp.de>
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

Hello,

On Sun, Oct 04, 2015 at 11:54:30AM +0200, Marc Lehmann wrote:
> Hi!
> 
> In this mail I describe what I would expect of f2fs in general, and the gc
> in particular. I already know my expectations or assumptions are partially
> incorrect, and will note so when I know of it. The idea of this mail is
> both to correct me in my understanding (if you would be so nice :), and
> also explain my expectations and motivation in more detail.
> 
> General f2fs behaviour:
> 
>  Expectation: f2fs logs need not be consecutive, so it can GC sections
>    relatively independently and, with suitable configuration, it
>    will always free whole sections (e.g. 128MB at -s64) and reuse
>    them for writing. This would mitigate the SMR problemxs, because,
>    assuming continous writing to the fs, it would write whole sections
>    consecutively, which would span multiple zones.
> 
>    Reality: quite obviously f2fs reuses space in roughly 2MB chunks, most
>    likely on a segment basis.

When there are not enough empty sections, f2fs starts to reuse the obsolete
segments, which is called as SSR. The victims are selected on a segment basis,
but we can expect the next victim would be inside the same section, since
searching is done in an increasing order.

> 
> (background) GC:
> 
>  Expectation/Blind Guessing: While there is nothing to GC, the GC will sleep
>    for gc_no_gc_sleep_time intervals (it may be woken up for other reasons).
> 
>    When there is something to GC, then the GC will check if the filesystem
>    is idle (by unknown means, e.g. by checking if there was activity within
>    a certain time, or whether there is activity at the moment it checks).
> 
>    If the fs is idle, it would GC one section (or something similar), then
>    sleep for gc_min_sleep_time.
> 
>    If the fs is busy, it would GC one section (or something similar), then
>    sleep for gc_max_sleep_time.
> 
>    Ignoring slight variations, the expected behaviour would be for the GC
>    to GC a bit every gc_min_sleep_time+time_it_takes_for_IO when idle, or
>    longer when the fs is busy.
> 
>    As a result, ideal settings would be 0 for gc_min_sleep_time
>    and something high (potentially very high, such as an hour) for
>    gc_max_sleep_time.
> 
>  Reality: If I understood you correctly, the GC will just queue writes
>    whether there are already outstanding writes or not, it has no notion
>    of when one GC iteration is finished, so gc_min_sleep_time has to be
>    long enough for the writes to finish. Since this is impossible (the
>    time is obviously not fixed and gc_min_sleep_time is a constant), there
>    is no way to run GC with maximum speed during fs idle times (unless one
>    writes a separate program to force GC when idle time is detected by
>    some means).
> 
>    Also, quite obviously, even when the fs is completely idle, the GC will
>    typically sleep for gc_max_sleep_time, so it seems "idle fs" is not the
>    concept that influences the time between gc activity.

Urg, indeed, I missed one condition for this behavior.
In f2fs_gc, originally I added a condition not to conduct GC too aggressively,
which is, in fs/f2fs/gc.c,

	if (has_enough_invalid_blocks())
		decrease_sleep_time()
	else
		increase_sleep_time()

By default, only if the partition is filled with data over 40% and free
segments are remained less than 40% of data amount that user can do sequential
wrties, f2fs decreases the waiting time.

1. For your intention, accordingly, it needs to decrease the gc_max_sleep_time
dramatically.

2. In order to disable ipu, setting 0 is enough, IMO.

echo 0 > ipu_policy

3. I added a patch to issue checkpoint with the following configurable interval:

echo 30 > sync_interval    # checkpoint at every 30secs as a best effort

4. I submitted a couple of patches to do GC synchronously in background, could
you try out "background_gc=sync" in your mount options?

5. Another patch also introduces for users to monitor GC behaviors by:

echo 1 > /sys/fs/f2fs/dev/events/f2fs/f2fs_background_gc/enable
echo 1 > /sys/fs/f2fs/dev/events/f2fs/f2fs_get_victim/enable

Thank,

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
