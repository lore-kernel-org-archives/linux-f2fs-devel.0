From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 2/3] f2fs crypto: use bounce pages from mempool first
Date: Thu, 28 May 2015 14:18:11 -0400
Message-ID: <20150528181811.GC18540@thunk.org>
References: <1432255225-76792-1-git-send-email-jaegeuk@kernel.org>
 <1432255225-76792-2-git-send-email-jaegeuk@kernel.org>
 <20150525195551.GB16402@thunk.org>
 <20150527211641.GA1397@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150527211641.GA1397@jaegeuk-mac02.mot.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, May 27, 2015 at 02:18:54PM -0700, Jaegeuk Kim wrote:
> The problem that I'd like to address here is to reduce the call counts of
> allocating and freeing a number of pages in pairs.
> 
> When I conduct xfstests/224 under 1GB DRAM, I've seen triggering several oom
> killers, and in that moment, a huge number of inactive anonymous pages are
> registered in the page cache. Not sure why those pages are not reclaimed
> seamlessly though.

If the system is running 8 fio processes, each one writing 1 meg
(BIO_MAX pages) at a time, one of the things that is going on is that
we need to grab 256 4k paegs before the submitting the bio, and then
if there are a large number of bio's queued, we can have potentially a
very large number of pages allocated until the I/O has been completed.

So the problem is it's extremely difficult to determine ahead of time
how many pages that need to be reserved in a mempool.  Simply
increasing the number of in the mempool from 32 to 256 is no guarantee
that it will be enough.  We originally only reserved 32 pages so that
in the case of an extreme memory crunch, we could make at least some
amount of forward progress.

I can imagine a number of different solutions (and these are not
mutally exclusive):

1) Try to dynamically adjust the number of pages we keep in the
mempool so that we ramp up under I/O load and then gradually ramp down
when the I/O pressure decreases.

2) Keep track of how many temporary encryption outstanding bounce
pages are outstanding, if we exceed some number, push back in
writepages for encrypted inode.  That way we can make it be a tunable
so that we don't end up using a huge number of pages, and can start
throttling encrypted writeback even before we start getting allocation
failures.

I'm currently leaning towards #2, myself.  I haven't tried doing some
kernel performance measurements to see how much CPU time we're
spending in alloc_page() and free_page() when under a very heavy
memory load.  I assume you've done some measurements and this has been
very heavy.  Can you give more details about how much CPU time is
getting burned by alloc_page() and free_page()?  I had been assuming
that if we're I/O bound, the extra CPU time to allocate and free the
pages wouldn't be really onerous.  If you're seeing something
different, I'd love to see some data (perf traces, etc.) to correct my
impressions.

Cheers,

					- Ted
