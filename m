From: Marc Lehmann <schmorp@schmorp.de>
Subject: assumptions and misconceptions about f2fs behaviour,
	please correct
Date: Sun, 4 Oct 2015 11:54:30 +0200
Message-ID: <20151004095429.GB3177@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1Zig06-0006Oh-Ti
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 Oct 2015 09:54:38 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zig05-0004yE-26
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 Oct 2015 09:54:38 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1Zifzy-0005x1-BC
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 Oct 2015 09:54:30 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1Zifzy-0003Hy-1t
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 Oct 2015 09:54:30 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1Zifzy-0000rv-1O
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 Oct 2015 11:54:30 +0200
Content-Disposition: inline
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

Hi!

In this mail I describe what I would expect of f2fs in general, and the gc
in particular. I already know my expectations or assumptions are partially
incorrect, and will note so when I know of it. The idea of this mail is
both to correct me in my understanding (if you would be so nice :), and
also explain my expectations and motivation in more detail.

General f2fs behaviour:

 Expectation: f2fs logs need not be consecutive, so it can GC sections
   relatively independently and, with suitable configuration, it
   will always free whole sections (e.g. 128MB at -s64) and reuse
   them for writing. This would mitigate the SMR problemxs, because,
   assuming continous writing to the fs, it would write whole sections
   consecutively, which would span multiple zones.

   Reality: quite obviously f2fs reuses space in roughly 2MB chunks, most
   likely on a segment basis.

(background) GC:

 Expectation/Blind Guessing: While there is nothing to GC, the GC will sleep
   for gc_no_gc_sleep_time intervals (it may be woken up for other reasons).

   When there is something to GC, then the GC will check if the filesystem
   is idle (by unknown means, e.g. by checking if there was activity within
   a certain time, or whether there is activity at the moment it checks).

   If the fs is idle, it would GC one section (or something similar), then
   sleep for gc_min_sleep_time.

   If the fs is busy, it would GC one section (or something similar), then
   sleep for gc_max_sleep_time.

   Ignoring slight variations, the expected behaviour would be for the GC
   to GC a bit every gc_min_sleep_time+time_it_takes_for_IO when idle, or
   longer when the fs is busy.

   As a result, ideal settings would be 0 for gc_min_sleep_time
   and something high (potentially very high, such as an hour) for
   gc_max_sleep_time.

 Reality: If I understood you correctly, the GC will just queue writes
   whether there are already outstanding writes or not, it has no notion
   of when one GC iteration is finished, so gc_min_sleep_time has to be
   long enough for the writes to finish. Since this is impossible (the
   time is obviously not fixed and gc_min_sleep_time is a constant), there
   is no way to run GC with maximum speed during fs idle times (unless one
   writes a separate program to force GC when idle time is detected by
   some means).

   Also, quite obviously, even when the fs is completely idle, the GC will
   typically sleep for gc_max_sleep_time, so it seems "idle fs" is not the
   concept that influences the time between gc activity.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
