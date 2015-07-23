From: Jialin Li <nick.lijl@gmail.com>
Subject: f2fs data write ordering
Date: Thu, 23 Jul 2015 10:02:48 -0700
Message-ID: <55B11E38.8090400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <nick.lijl@gmail.com>) id 1ZIJtk-0004Cs-H2
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Jul 2015 17:03:08 +0000
Received: from mail-pa0-f52.google.com ([209.85.220.52])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZIJtj-0006H3-L4
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Jul 2015 17:03:08 +0000
Received: by pabkd10 with SMTP id kd10so88579281pab.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 23 Jul 2015 10:02:55 -0700 (PDT)
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
Cc: Xi Wang <xi@cs.washington.edu>

Hi,

When testing the crash consistency of f2fs, we saw in the documentation 
that one of the mount option "nobarrier" states that "if this option is 
set, no cache_flush commands are issued but f2fs still guarantees the 
write ordering of all the data writes." Does it imply that both with and 
without the "nobarrier" option set, the ordering of all data writes is 
guaranteed? And this ordering applies to data writes to different files 
too?

We wrote the following python test:

---------
import os

with open("a", "wb") as f:
   f.write(b"hello\n")
with open("b", "wb") as f:
   f.write(b"world\n")
os.sync()

fd0 = os.open("a", os.O_RDWR)
fd1 = os.open("b", os.O_RDWR)
os.pwrite(fd0, b'x', 1)
os.pwrite(fd1, b'y', 1)
os.fdatasync(fd1)
/* Crash here */
----------

However, after the crash, we were able to observe that file "b" on disk 
contains "wyrld" while the content of file "a" is still "hello": the two 
pwrites reached the disk out of order. This happened both when we set 
and unset the "nobarrier" option. Maybe we misunderstood the 
documentation regarding the ordering guarantee of f2fs, and it would be 
much appreciated if you could provide some clarifications.

Thanks,
Jialin

------------------------------------------------------------------------------
