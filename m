From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: write performance difference 3.18.21/git f2fs
Date: Tue, 29 Sep 2015 13:02:04 +0200
Message-ID: <20150929110204.GA7608@schmorp.de>
References: <20150925182646.GB6998@jaegeuk-mac02>
	<20150925182034.GA6998@jaegeuk-mac02>
	<20150925182034.GA6998@jaegeuk-mac02>
	<01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<20150926032218.GA4311@schmorp.de>
	<20150926052551.GA2243@schmorp.de>
	<20150926075253.GD13619@jaegeuk-mac02.hsd1.ca.comcast.net>
	<20150926135957.GB9860@schmorp.de>
	<20150928175944.GA16945@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1Zgsfo-0002rv-LR
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Sep 2015 11:02:16 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zgsfk-0002bG-Na
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Sep 2015 11:02:16 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1Zgsfd-0001PZ-Bp
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Sep 2015 11:02:05 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1Zgsfc-0008Jp-Vu
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Sep 2015 11:02:04 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1Zgsfc-000246-VL
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Sep 2015 13:02:04 +0200
Content-Disposition: inline
In-Reply-To: <20150928175944.GA16945@jaegeuk-mac02.mot.com>
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

On Mon, Sep 28, 2015 at 10:59:44AM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> In order to verify this also, could you retrieve the following logs?

First thing, the allocation-failure-on-mount is still in the backported 3.18
f2fs module. If it's supposed to be gone in that version, it's not working:

http://ue.tst.eu/a1bc4796012bd7191ab2ada566d4cd22.txt

And here are traces and descriptions. The traces all start directly after
mount, my test script is http://data.plan9.de/f2fstest

(event tracing is cool btw., thanks for showing me :)

################ -s1, f2fs git ##############################################

   /opt/f2fs-tools/sbin/mkfs.f2fs -lTEST -s1 -t0 -a0 /dev/vg_test/test
   mount -t f2fs -onoatime,flush_merge,no_heap /dev/vg_test/test /mnt

For the fist ~120GB, performance was solid (100MB/s+), but much worse than
stock 3.18.21 (with -s64!).

3.1.8.21 regularly reached >190MB/s regularly (at least near the beginning
of the disk) then was idle in between writes, as the source wasn't fast
enough to keep up. With the backport, tar was almost never idle, and if,
then not for long, so it could just keep up. (Just keeping up with the
read speed of a 6-disk raid is very good, but I know f2fs can do much
better :)

At the 122GB mark, it started to slow down, being consistently <100MB/s

At 127GB, it was <<20MB/s, and I stopped.

Most of the time, the test was write-I/O-bound.

http://data.plan9.de/f2fs.s1.trace.xz

################ -s64, f2fs 3.18.21 #########################################

As contrast I then did a test with the original f2fs module, and -s64.
Throughput was up to 202MB/s, almost continously. At the 100GB mark, it
slowed down to maybe 170MB/s peak, which might well be the speed of the
platters.

I stopped at 217GB.

I have a 12GB mbuffer between the read-tar and the write-tar, configured to
write minimum bursts of ~120MB. At no time was the buffer filled at >2%,
while with the -s1, f2fs git case, it was basically always >2%.

The trace includes a few minutes after tar was stopped.

http://data.plan9.de/f2fs.s64.3.18.trace.xz

################ -s64, f2fs git #############################################

The direct equivalent of the previous test, but with f2fs git.

Almost from the very beginning, it was often write-bound, but could still
keep up.

At around 70GB, it mostly stopped being able to keep up, and the read
tar overtook the write tar. At 139GB, performance degraded to <2MB/s. I
stopped at 147GB.

So mostly, behaviour was the same as with -s1, excedpt it took longer to
slow down.

http://data.plan9.de/f2fs.s64.trace.xz

################ -s20, f2fs git #############################################

By special request, here is the test with -s20.

Surprisingly, this stopped being able to cope at the 40GB mark, but I didn't
wait very long after the previous test, maybe that influenced it. I stopped
at 63GB.

http://data.plan9.de/f2fs.s20.trace.xz

#############################################################################

I hope to find time to look at these traces myself later this day.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
