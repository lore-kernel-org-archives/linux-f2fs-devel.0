From: Jan Altenberg <jan@linutronix.de>
Subject: Re: BUG_ON in recovery.c after powercut
Date: Wed, 16 Oct 2013 10:51:27 +0200
Message-ID: <1381913487.2431.17.camel@bender.lan>
References: <1381415008.3138.32.camel@moestavern>
	<1381812859.992.26.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jan@linutronix.de>) id 1VWMpO-0002XT-1c
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Oct 2013 08:51:38 +0000
Received: from www.linutronix.de ([62.245.132.108] helo=Galois.linutronix.de)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps
	(TLSv1:AES256-SHA:256) (Exim 4.76) id 1VWMpM-0002m5-9d
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Oct 2013 08:51:38 +0000
In-Reply-To: <1381812859.992.26.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi,

thanks a lot for the feedback.

> If possible, can you test the below scenario with the latest f2fs?

I will see, what I can do. I'll need to merge a couple of patches to get
the eMMC stuff working. I'll check that ASAP, but I'm afraid, I can't do
this, before I leave vor LCE and ELCE.

> The latest f2fs is available from:
> http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git/log/?h=dev
> 
> Otherwise, could you send the broken image to me?

For sure, but the image is pretty big (round about 1 gig). But I can put
it on our web machine (just let me know).
Unfortunately, I was just able to trigger that issue with that full
blown Angstrom image.

Cheers,
	Jan


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
