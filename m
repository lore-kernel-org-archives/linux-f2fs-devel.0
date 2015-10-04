From: Marc Lehmann <schmorp@schmorp.de>
Subject: more gc experiences
Date: Sun, 4 Oct 2015 14:49:24 +0200
Message-ID: <20151004124923.GC3697@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZiijM-0008Sz-60
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 Oct 2015 12:49:32 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZiijK-0001SP-KA
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 Oct 2015 12:49:32 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZiijE-0002kz-Ar
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 Oct 2015 12:49:24 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZiijE-0002el-1o
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 Oct 2015 12:49:24 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1ZiijE-000149-18
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 Oct 2015 14:49:24 +0200
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

Still working on my nearly full volume.

After stopping at ~180GB free due to low performance, I reconfigured the GC
so it runs more often and let it run for less than two hours.

   echo   500 >gc_min_sleep_time
   echo   500 >gc_max_sleep_time
   echo   500 >gc_no_gc_sleep_time

status before/after:
http://ue.tst.eu/dc80b74b69bbb431f51d731d8b075324.txt
http://ue.tst.eu/821be8e5c227653a90596c1503b84567.txt

During GC I had a steady 45MB/read + 45MB/write. The number of Dirty segments
didn't reduce very much, but that is likely due to the structure of the data:

Apart from fs metadata, I also did rsync without -H, followed by rsync with
-H. The latter replaces physical file copies that rsync created by hardlinks,
if they were hardlinks in the source. The source had a moderate anmount of
hardlinked files.

Since this probably created nicely spread holes all over the data, it's
expected that the GC has to copy a lot of data (at -s64), so overall, during
this time, the GC seemed to work very fine.

After that, I "stopped" the GC again and started the rsync, which then
proceeded to copy another 110GB (ending up at 70GB free), where the
performance again became unusably slow.

I then decided to give F2FS_IOC_GARBAGE_COLLECT a try with the following
script, and found some issues:

http://ue.tst.eu/9723851c87bb35e5899534123a5af497.txt

The first problem is that the ioctl seems to return instantly and
successfully when the bg garbage collect thread runs. Or at leats, thats my
theory: the sympton was that most of the time calls took 1-4 seconds, but
regularly (presumably when the kernel gc runs), the call returned within
microseconds.

This causes unnecessary high CPU usage - I think the call should just wait
for the GC lock in that case, or (less preferably) somehow signal this
third condition so the user code can do something else.

Which brings us to the next problem - calling the GC ioctl in a loop quickly
generated 23GB of dirty pages, which then more or less locked up the box - no
login was possible for 6 minutes after I killed the GC script, no nfs
operations took place.

While this is a shortcoming with linux in general, it highlights the
principal problem of not having any rate control in f2fs's gc - basically,
the user has to guess when the GC is done, and when the next round can
start, which is, in general, impossible, as only the fs knows the real I/O
load. Or in other words, here, again, the script would have to contain a
magic delay, just like gc_min_sleep_time, after each round.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
