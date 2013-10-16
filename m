From: Jan Altenberg <jan@linutronix.de>
Subject: Re: BUG_ON in recovery.c after powercut
Date: Wed, 16 Oct 2013 22:47:43 +0200
Message-ID: <1381956463.3106.8.camel@moestavern>
References: <20131016162043.GA10000@wsf-1107.seri.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jan@linutronix.de>) id 1VWY0X-0006AE-0d
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Oct 2013 20:47:53 +0000
Received: from www.linutronix.de ([62.245.132.108] helo=Galois.linutronix.de)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps
	(TLSv1:AES256-SHA:256) (Exim 4.76) id 1VWY0V-0005Tv-2j
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Oct 2013 20:47:52 +0000
In-Reply-To: <20131016162043.GA10000@wsf-1107.seri.co.uk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jarkko Lavinen <j.lavinen@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Wed, 2013-10-16 at 19:20 +0300, Jarkko Lavinen wrote:
> > If possible, can you test the below scenario with the latest f2fs?
> 
> I would be also interested in studying such image, so could you
> please send it to me also?

Ok, no problem at all. As already mentioned, I can put it on our
webmachine. But the image is about 1 gig.
If one of you guys is planning to attend LCE or ELCE in Edinburgh, just
let me know! I can take that board with me!

I'm not sure if I can work on this topic before I leave for LCE, but I
will continue testing and upload the image when I'm back to the office.

> I am concerned or curious about F2FS tolerance against power
> cuts.
> 
> In my previous life at Nokia we did once power cut testing for
> ext3 and ext4 file systems on eMMC. There was an AC switch which
> cut the power off at random times. Ext3 didn't survive the test,
> ext4 did.

That's what we did with F2FS. That triggered the issue described in my
previous mail.

Cheers,
	Jan


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
