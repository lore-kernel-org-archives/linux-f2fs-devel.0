From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: write performance difference 3.18.21/git f2fs
Date: Sat, 26 Sep 2015 00:52:53 -0700
Message-ID: <20150926075253.GD13619@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <20150925182646.GB6998@jaegeuk-mac02>
	<20150925182646.GB6998@jaegeuk-mac02>
	<20150925182034.GA6998@jaegeuk-mac02>
	<20150925182034.GA6998@jaegeuk-mac02>
	<01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<20150926032218.GA4311@schmorp.de>
	<20150926052551.GA2243@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZfkI4-0004ET-BL
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 07:53:04 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZfkI3-0006aK-9O for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 07:53:04 +0000
Content-Disposition: inline
In-Reply-To: <20150926052551.GA2243@schmorp.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Marc Lehmann <schmorp@schmorp.de>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Sat, Sep 26, 2015 at 07:25:51AM +0200, Marc Lehmann wrote:
> Ok, before I tried the f2fs git I made another short test with the
> original 3.18.21 f2fs, and it was as fast as before. Then I used the
> faulty f2fs module,. which forced a reboot.
> 
> Now I started to redo the 3.18.21 test + git f2fs, with the same parameters
> (specifically, -s90), and while it didn't start out to be as slow as 4.2.1,
> it's similarly slow.
> 
> After 218GiB, I stopped the test, giving me an average of 50MiB/s.
> 
> Here is typical dstat output (again, dsk/sde):
> 
> http://ue.tst.eu/7a40644b3432e2932bdd8c1f6b6fc32d.txt
> 
> So less read behaviour than with 4.2.1, but also very slow writes.
> 
> That means the performance drop moves with f2fs, not the kernel version.
> 
> This is the resulting status:
> 
> http://ue.tst.eu/6d94e9bfad48a433bbc6f7daeaf5eb38.txt
> 
> Just for fun I'll start doing a -s64 run.

Okay, so before finding bad commits, if possible, can you get block traces?
It would be good to see block_rq_complete and block_bio_complete tracepoints.

Thanks,

> 
> -- 
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
