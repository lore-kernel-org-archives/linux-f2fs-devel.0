From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: more gc / gc script refinements
Date: Mon, 5 Oct 2015 09:25:49 +0200
Message-ID: <20151005072548.GA2504@schmorp.de>
References: <20151004124923.GC3697@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1Zj09l-0002AC-CF
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 07:25:57 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zj09j-0002WF-FC
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 07:25:57 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1Zj09d-0006Eg-7P
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 07:25:49 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1Zj09d-0001hU-2q
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 07:25:49 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1Zj09d-0000gh-25
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 09:25:49 +0200
Content-Disposition: inline
In-Reply-To: <20151004124923.GC3697@schmorp.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

After I successfully filled the disk, it was time to see hope f2fs recovers
from this bad situation, by deleting a lot of files and filling it again.

To ease the load on the gc, but still present a bit of a challenge, I
deleted the first 12000 files out of every 80000 files (directory order), in the hope
that this carves out comparatively big chunks.

I started with "Dirty: 30k" and "Free: 45k" and ended up with
"Dirty: 216k" and "Free: 968k", which to me seems to indicate it kind of
worked, although I am not suire how contiguous this free space really is
(I oriignally hoped this would be in the form of mostly free sections).

Then I worked on my GC script. Since the box became mostly unusable by just
calling the GC, I first tried this refinement:

http://ue.tst.eu/38809274b56fe9b161492f09b5411071.txt

(Used like "script </mountpoint" btw.)

Or in other words, only call the GC if there is less than 2GB of dirty
pages. For lower values than 2GB the GC often didn't run at all for 10-20
seconds.

This helped a lot, but the box was still noticably sluggish, and I
realised why the current GC I/O implementation is wrong - the purpose of
the cache is (among other uses, such as being the normal way to do I/O) to
cache recently-requested data in the hope that it will be reused.

However, in the case of the GC, unless the data was in the cache before,
chances that this data is required later are just as low as for the rest of
the device, and in general, much lower then the data that was in the cache
before f2fs evicted it.

Moreso, a lot of stress is put on the page cache because of the f2fs gc
treating it as normal data and leaving it in the cache and up to the
kernel to write out the pages.

What the GC should do is minimize the impact of the GC on the rest of the
system, by immediately flushing the data out and expiring the pages.

To improve the situaiton somewhat I decided to experiment with fdatasync
on the block device and/or a directory handle, but ended up calling syncfs
on the f2fs fs after every gc call, because fdatasync etc. seemed to be
the equivalent of syncfs anyway:

http://ue.tst.eu/325b6ba70b1abe814dc6a5cb6c02730e.txt

The effect of syncfs was to make I/O a lot more "chunky" - first everything
was read, then everything was written (dstat output, btw., this is 1 second
intervals as always, but I never mentioned it - sorry):

http://ue.tst.eu/9a552a4f41a4863133d3eceb90f1ec87.txt

Without it, read and write happen "at the same time" (when sampled with 1
second intervals).

This increased the average throughput considerably, from around 45MB
read+write/s to 66MB/s. Whether this actually increased the GC process at
all I don't know, because syncfs of course forces a sync on the fs, with
its own overhead.

So while this is a rather heavy-handed approach, the major result was that
the amount of dirty pages is notably reduced (it never reaches 1GB), and
the box is much more usable during this time.

Right now, after about 9 hours, I am at "Dirty: 44k", and will start
writing to the device soon.

In any case, it seems f2fs seems to hold up quite nicely near disk full
conditions, and does recover nicely as well.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
