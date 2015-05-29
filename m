From: nick <xerofoify@gmail.com>
Subject: Re: [PATCH 2/3] f2fs crypto: use bounce pages from
 mempool first
Date: Fri, 29 May 2015 15:10:34 -0400
Message-ID: <5568B9AA.40900@gmail.com>
References: <1432255225-76792-1-git-send-email-jaegeuk@kernel.org>	<1432255225-76792-2-git-send-email-jaegeuk@kernel.org>	<20150525195551.GB16402@thunk.org>	<20150527211641.GA1397@jaegeuk-mac02.mot.com>
	<20150528181811.GC18540@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xerofoify@gmail.com>) id 1YyPg6-0003CB-Er
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 29 May 2015 19:10:46 +0000
Received: from mail-ig0-f173.google.com ([209.85.213.173])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YyPg2-000242-57
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 29 May 2015 19:10:46 +0000
Received: by igbyr2 with SMTP id yr2so21733427igb.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 29 May 2015 12:10:36 -0700 (PDT)
In-Reply-To: <20150528181811.GC18540@thunk.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net



On 2015-05-28 02:18 PM, Theodore Ts'o wrote:
> On Wed, May 27, 2015 at 02:18:54PM -0700, Jaegeuk Kim wrote:
>> The problem that I'd like to address here is to reduce the call counts of
>> allocating and freeing a number of pages in pairs.
>>
>> When I conduct xfstests/224 under 1GB DRAM, I've seen triggering several oom
>> killers, and in that moment, a huge number of inactive anonymous pages are
>> registered in the page cache. Not sure why those pages are not reclaimed
>> seamlessly though.
> 
> If the system is running 8 fio processes, each one writing 1 meg
> (BIO_MAX pages) at a time, one of the things that is going on is that
> we need to grab 256 4k paegs before the submitting the bio, and then
> if there are a large number of bio's queued, we can have potentially a
> very large number of pages allocated until the I/O has been completed.
> 
> So the problem is it's extremely difficult to determine ahead of time
> how many pages that need to be reserved in a mempool.  Simply
> increasing the number of in the mempool from 32 to 256 is no guarantee
> that it will be enough.  We originally only reserved 32 pages so that
> in the case of an extreme memory crunch, we could make at least some
> amount of forward progress.
> 
> I can imagine a number of different solutions (and these are not
> mutally exclusive):
> 
> 1) Try to dynamically adjust the number of pages we keep in the
> mempool so that we ramp up under I/O load and then gradually ramp down
> when the I/O pressure decreases.
> 
> 2) Keep track of how many temporary encryption outstanding bounce
> pages are outstanding, if we exceed some number, push back in
> writepages for encrypted inode.  That way we can make it be a tunable
> so that we don't end up using a huge number of pages, and can start
> throttling encrypted writeback even before we start getting allocation
> failures.
> 
> I'm currently leaning towards #2, myself.  I haven't tried doing some
> kernel performance measurements to see how much CPU time we're
> spending in alloc_page() and free_page() when under a very heavy
> memory load.  I assume you've done some measurements and this has been
> very heavy.  Can you give more details about how much CPU time is
> getting burned by alloc_page() and free_page()?  I had been assuming
> that if we're I/O bound, the extra CPU time to allocate and free the
> pages wouldn't be really onerous.  If you're seeing something
> different, I'd love to see some data (perf traces, etc.) to correct my
> impressions.
> 
> Cheers,
> 
> 					- Ted
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
Ted,
After reading this and thinking over the last few days you seem to have a correct idea
at least from my understanding of cache write back in the Linux kernel. However this
really needs to be bench marked first. I would be glad to benchmark this with perf 
on my system if you can give me the run down of what needs to be bench marked, I
have am a idea but would like a little more clarity.
Cheers,
Nick

------------------------------------------------------------------------------
