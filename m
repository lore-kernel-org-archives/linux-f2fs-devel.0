From: Jarkko Lavinen <j.lavinen@samsung.com>
Subject: Re: BUG_ON in recovery.c after powercut
Date: Wed, 16 Oct 2013 19:20:44 +0300
Message-ID: <20131016162043.GA10000@wsf-1107.seri.co.uk>
References: <1381812859.992.26.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <j.lavinen@samsung.com>) id 1VWTqE-0007yH-Bv
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Oct 2013 16:20:58 +0000
Received: from mailout3.w1.samsung.com ([210.118.77.13])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VWTqC-0008Cy-4d for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Oct 2013 16:20:58 +0000
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MUR00DDRS2DS4B0@mailout3.w1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Oct 2013 17:20:49 +0100 (BST)
Content-disposition: inline
In-reply-to: <1381812859.992.26.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jan Altenberg <jan@linutronix.de>
Cc: linux-f2fs-devel@lists.sourceforge.net

> If possible, can you test the below scenario with the latest f2fs?

I would be also interested in studying such image, so could you
please send it to me also?

I am concerned or curious about F2FS tolerance against power
cuts.

In my previous life at Nokia we did once power cut testing for
ext3 and ext4 file systems on eMMC. There was an AC switch which
cut the power off at random times. Ext3 didn't survive the test,
ext4 did.

Test script was doing various operations in a logged manner so
that data integrity could be verified and one could also see what
operations had been done just before the power went off.

Wit AC switch the voltage drops linearly and doesn't exactly
match the case of losing battery abruptly. DC power switching or
hard reseting the eMMC would be closer.

Perhaps using USB switch with external USB reader one could cut
the power sharply from the reader and again simulate sharp power
loss scenario giving no mercy for the FTL.

Cheers
Jarkko Lavinen

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
