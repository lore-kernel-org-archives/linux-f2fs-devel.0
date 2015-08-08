From: Marc Lehmann <schmorp@schmorp.de>
Subject: general stability of f2fs?
Date: Sat, 8 Aug 2015 22:50:03 +0200
Message-ID: <20150808205003.GA6546@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZOB4G-0007GV-1t
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Aug 2015 20:50:12 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZOB4D-0000MM-SG
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Aug 2015 20:50:12 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZOB47-0005H2-Bd
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Aug 2015 20:50:03 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1ZOB47-0004tZ-70
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Aug 2015 20:50:03 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1ZOB47-0001iJ-6R
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Aug 2015 22:50:03 +0200
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

I did some more experiments, and wonder about the general stabiulity of f2fs.
I have not managed to keep an f2fs filesystem that worked for longer than a
few days.

For example, a few days ago I created an 8TB volume and copied 2TB of data to
it, which worked until I hot the (very low...) 32k limit on the number of
subdirectories.

I moved some directoriesd into a single subdirectory, and continued.
Everything seemed fine.

Today I ran fsck.f2fs on the fs, which found 4 inodes with wrong link counts
(generally higher than fsck counted). It asked me whether to fix this, which
I did.

I then did another fsck run, and was greeted with tens of thousands of
errors:

http://ue.tst.eu/f692bac9abbe4e910787adee18ec52be.txt

Mounting made the box unusable for multiple minutes, probably due to the
amount of backtraces:

http://ue.tst.eu/6243cc344a943d95a20907ecbc37061f.txt

The data is toast (which is fine, I am still experimenting only), but this,
the weird write behaviour, the fact that you don#t get signalled on ENOSPC
make me wonder what the general status of f2fs is.

It *seems* to be in actual use for a number of years now, and I would expect
small hiccups and problems, so backups would be advised, but this level of
brokenness (I only tested linux 3.18.14 and 4.1.4) is not something I didn#t
expect from a fs that is in development for so long.

So I wonder what the general stability epxectation for f2fs is - is it just
meant to be an experimental fs not used for any data, or am I just unlucky
and hit so many disastrous bugs by chance?

(It's really too bad, it's the only fs in linux that has stable write
performance on SMR drives at this time).

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
