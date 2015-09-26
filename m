From: Marc Lehmann <schmorp@schmorp.de>
Subject: write performance difference 3.18.21/git f2fs
Date: Sat, 26 Sep 2015 07:25:51 +0200
Message-ID: <20150926052551.GA2243@schmorp.de>
References: <20150925182646.GB6998@jaegeuk-mac02>
	<20150925182646.GB6998@jaegeuk-mac02>
	<20150925182034.GA6998@jaegeuk-mac02>
	<20150925182034.GA6998@jaegeuk-mac02>
	<01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<20150926032218.GA4311@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1Zfhzj-0002LN-Pq
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 05:25:59 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zfhzh-0006X0-US
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 05:25:59 +0000
Received: from [10.0.0.5] (helo=doom.schmorp.de)
	by mail.nethype.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1Zfhzb-0006jk-NC
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 05:25:51 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
	by doom.schmorp.de with esmtp (Exim 4.84)
	(envelope-from <schmorp@schmorp.de>) id 1Zfhzb-0004GE-Iq
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 05:25:51 +0000
Received: from root by cerebro.laendle with local (Exim 4.84)
	(envelope-from <root@schmorp.de>) id 1Zfhzb-0000b5-IK
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 07:25:51 +0200
Content-Disposition: inline
In-Reply-To: <20150926032218.GA4311@schmorp.de>
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

Ok, before I tried the f2fs git I made another short test with the
original 3.18.21 f2fs, and it was as fast as before. Then I used the
faulty f2fs module,. which forced a reboot.

Now I started to redo the 3.18.21 test + git f2fs, with the same parameters
(specifically, -s90), and while it didn't start out to be as slow as 4.2.1,
it's similarly slow.

After 218GiB, I stopped the test, giving me an average of 50MiB/s.

Here is typical dstat output (again, dsk/sde):

http://ue.tst.eu/7a40644b3432e2932bdd8c1f6b6fc32d.txt

So less read behaviour than with 4.2.1, but also very slow writes.

That means the performance drop moves with f2fs, not the kernel version.

This is the resulting status:

http://ue.tst.eu/6d94e9bfad48a433bbc6f7daeaf5eb38.txt

Just for fun I'll start doing a -s64 run.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
