From: folkert <folkert@vanheusden.com>
Subject: Re: f2fs using tons of cpu
Date: Sat, 9 Nov 2013 18:29:57 +0100
Message-ID: <20131109172957.GA18570@belle.intranet.vanheusden.com>
References: <20131008112534.GA24963@belle.intranet.vanheusden.com>
	<1381364920.992.15.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <folkert@vanheusden.com>) id 1VfCMI-0000w1-0l
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Nov 2013 17:30:06 +0000
Received: from keetweej.vanheusden.com ([80.101.105.103])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VfCMG-0003VH-CO
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Nov 2013 17:30:05 +0000
Content-Disposition: inline
In-Reply-To: <1381364920.992.15.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: udovdh@xs4all.nl, linux-f2fs-devel@lists.sourceforge.net

[ garbage collector ]

> You'd better keep track on /sys/kernel/debug/f2fs/status, and I think
> you can find many dirty segments across the partition.
> In the status file, you can also see the f2fs_gc behavior.

Ok but if the gc runs, the system completely locks up. That is: it is
100% unresponsive. And since it is a 120GB volume on a raspberry pi it
is practically down for _days_ (maybe even weeks - I rebooted the device
after a day).


Folkert van Heusden

-- 
www.vanheusden.com/multitail - win een vlaai van multivlaai! zorg
ervoor dat multitail opgenomen wordt in Fedora Core, AIX, Solaris of
HP/UX en win een vlaai naar keuze
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
