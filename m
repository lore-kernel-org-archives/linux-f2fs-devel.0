From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: write performance difference 3.18.21/git f2fs
Date: Thu, 1 Oct 2015 20:51:24 +0200
Message-ID: <20151001185124.GA9803@schmorp.de>
References: <01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<20150926032218.GA4311@schmorp.de>
	<20150926052551.GA2243@schmorp.de>
	<20150926075253.GD13619@jaegeuk-mac02.hsd1.ca.comcast.net>
	<20150926135957.GB9860@schmorp.de>
	<20150928175944.GA16945@jaegeuk-mac02.mot.com>
	<20150929110204.GA7608@schmorp.de>
	<20150929231310.GA6010@jaegeuk-mac02.mot.com>
	<20151001121120.GA7340@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1Zhix3-00055b-TT
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Oct 2015 18:51:33 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zhix1-0000Ej-JY
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Oct 2015 18:51:33 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1Zhiwu-00005O-Fr
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Oct 2015 18:51:24 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1Zhiwu-0002Hu-6Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Oct 2015 18:51:24 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1Zhiwu-0002ay-61
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Oct 2015 20:51:24 +0200
Content-Disposition: inline
In-Reply-To: <20151001121120.GA7340@schmorp.de>
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

On Thu, Oct 01, 2015 at 02:11:20PM +0200, Marc Lehmann <schmorp@schmorp.de> wrote:
> WOW, THAT HELPED A LOT. While the peak throughput seems quite a bit lower

Ok, for completeness, here is the full log and a description of what was
going on.

http://data.plan9.de/f2fs.s64.noinline.full.trace.xz

status at the end + some idle time
http://ue.tst.eu/d16cf98c72fe9ecbac178ded47a21396.txt

It was faster than the reader till roughtly the 1.2TB mark, after
which it acquired longish episodes of being <<50MB/s (for example,
around 481842.363964), and also periods of ~20kb/s, due to many small
WRITE_SYNC's in a row (e.g. at 482329.101222 and 490189.681438,
http://ue.tst.eu/cc94978eafc736422437a4ab35862c12.txt). The small
WRITE_SYNCs did not always result in this behaviour by the disk, though.

After that, it was generally write-I/O bound.

Also, the gc seemed to have kicked in at around that time, which is kind
of counterproductive. I increased the gc_* values in /sys, but don't know
if that had any effect.

Most importantly, f2fs always recovered and had periods of much faster
writes (>= 120MB/s), so it's not the case that f2fs somehow saturates the
internal cache and then becomes slow forever.

Overall, the throughput was 83MB/s, which is 20% worse than stock 3.18, but
still way beyond what any other filesystem could do.

Also, writing 1TB in a single session, with somewhat reduced speed
afterwards, would be enough for my purposes, i.e. I can live with that
(still, gigabit speeds would be nice of course, as that is the data rate I
often deal with).

Notwithstanding any other improvements you might implement, f2fs has now
officially become my choice for SMR drives, the only remaining thing
needed is to convince me of its stability - it seems getting a kernel
with truly stable f2fs is a bit of a game of chance still, but I guess
confidence will come with more tests and actualy using it in production,
which I will do soon.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
