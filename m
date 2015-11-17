From: Marc Lehmann <schmorp@schmorp.de>
Subject: f2fs stability problems keep me from testing
Date: Tue, 17 Nov 2015 18:24:31 +0100
Message-ID: <20151117172430.GA6945@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1Zyjzk-00039f-Fp
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Nov 2015 17:24:40 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zyjzi-0003Rd-KW
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Nov 2015 17:24:40 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1Zyjzc-0001aQ-0o
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Nov 2015 17:24:32 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1Zyjzb-0002z4-S9
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Nov 2015 17:24:31 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1Zyjzb-0001pq-RI
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Nov 2015 18:24:31 +0100
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

I have trouble executing the tests I wanted to run with the current 3.18
checkout. This morning, the box was completely unresponsive - I had to
reboot, not knowing the cause (the only difference is that f2fs is in more
or less production use for a few days).

An hour ago, I was awake when similar problems started - interactive
login was impossible, but I was able to execute a few commands in an open
shell, which make me suspect f2fs to be the culprit. Both times, the
f2fs filesystem was streaming video at low speed (<1mb/s) with no other
activity.

Anyway, here are the four experiments I did, after finding out that the
problem seems to the the f2fs fs (the other 4 filesystems on the box were
responsive, as was the underlying disk itself).

1. ls /cold1, find /cold1 (/cold1 is the f2fs mountpoint) gave empty results
   here is an strace of find /cold1:

   openat(AT_FDCWD, "/cold1", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 5
   fchdir(5)                               = 0
   getdents(5, /* 0 entries */, 32768)     = 0
   close(5)                                = 0

   so /cold1 is an empty directory. not good.

2. so no files in /cold1, let's see what happens when I list /cold1/var, a
   directory known to exist:

   openat(AT_FDCWD, "/cold1/var", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 5
   fchdir(5)                               = 0
   getdents(5, /* 0 entries */, 32768)     = 0
   close(5)                                = 0

   so f2fs knowsn that /cold1/var exists, but readdir gives no results. very
   troubling.

3. "sync&" - this did hang, with no apparent activity

4. cat /proc/<sync-pid>/task/*stack:

   [<ffffffff8121d4d8>] sync_inodes_sb+0xa8/0x1c0
   [<ffffffff81224249>] sync_inodes_one_sb+0x19/0x20
   [<ffffffff811f6192>] iterate_supers+0xb2/0x110
   [<ffffffff812244d5>] sys_sync+0x35/0x90
   [<ffffffff817a684d>] system_call_fastpath+0x16/0x1b
   [<ffffffffffffffff>] 0xffffffffffffffff

5. dmesg showed no related messages whatsoever - it still had the kernel
   messages generated from boot, and nothing else.

6. at this point I lost my shell and control over the box completely, and had to be rebooted

So something in the current f2fs tree (I checked that
/sys/fs/f2fs/dm-17/ra_nid_pages exists, so it is a more or less current
shapshot) is still locking up and/or returning corrupt data. If it was
a simple locking failure, though, I would expect readdir and other
operations to also block, not return bad data.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
