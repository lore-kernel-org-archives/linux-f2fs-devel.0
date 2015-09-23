From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: write performance difference 3.18.21/4.2.1
Date: Thu, 24 Sep 2015 01:11:03 +0200
Message-ID: <20150923231103.GA3463@schmorp.de>
References: <20150923215850.GC2360@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZetBx-0001jo-3q
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 23:11:13 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZetBv-00059P-GF
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 23:11:13 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZetBo-0001UO-VI
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 23:11:05 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZetBn-0005JU-Ib
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 23:11:03 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1ZetBn-0000uy-I9
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Sep 2015 01:11:03 +0200
Content-Disposition: inline
In-Reply-To: <20150923215850.GC2360@schmorp.de>
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

I tried twice with the same options, on linux 3.8.21 and 4.2.1, and write
performance is very different on these kernels (I rebooted every time in
between).

On 3.18.21, the source raid is hardly able to keep up with the write
speed, f2fs basically writes at more or less full disk speed, for extended
periods of time. As mentiopned earlier, average write speed was 103MB/s
over the whole 2.1TB, with f2fs being idle a lot of that time, so actual
write speed would be higher.

On 4.2.1, same mkfs+mount options, performance is 5-10 times less, i.e.
<<100MB/s (and more like 20MB/s for extendesd stretches):

http://ue.tst.eu/43a8f7ae96ac770dc45ac8f1e3b0c479.txt
(see the dsk/sde columns)

First there is a "good" stretch with >100MB/s, then it starts to degrade.
Another difference is the frequent read activity, which is mostly absent on
3.18.21.

The log starts after only 20GB had been written. Here is the status output
at 25GB:

http://ue.tst.eu/734f7883107ee4dabff77602db92310b.txt

Any idea why 4.2.1 performs so much worse than 3.8.21?

(Note, if that is the difference between "filesystem works" (4.2.1?) and
"filesystem doesn't work" (3.18.21) then that might be it - still, that
would mean f2fs performs worse than traditional filesystems on these
disks).

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
