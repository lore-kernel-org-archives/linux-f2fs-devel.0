From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: write performance difference 3.18.21/git f2fs
Date: Mon, 28 Sep 2015 10:59:44 -0700
Message-ID: <20150928175944.GA16945@jaegeuk-mac02.mot.com>
References: <20150925182646.GB6998@jaegeuk-mac02>
	<20150925182646.GB6998@jaegeuk-mac02>
	<20150925182034.GA6998@jaegeuk-mac02>
	<20150925182034.GA6998@jaegeuk-mac02>
	<01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<01bf01d0f777$45df5ee0$d19e1ca0$@samsung.com>
	<20150926032218.GA4311@schmorp.de>
	<20150926052551.GA2243@schmorp.de>
	<20150926075253.GD13619@jaegeuk-mac02.hsd1.ca.comcast.net>
	<20150926135957.GB9860@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZgciO-0006uC-5r
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Sep 2015 17:59:52 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZgciM-0004qk-Tr for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Sep 2015 17:59:52 +0000
Content-Disposition: inline
In-Reply-To: <20150926135957.GB9860@schmorp.de>
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

On Sat, Sep 26, 2015 at 03:59:57PM +0200, Marc Lehmann wrote:
> On Sat, Sep 26, 2015 at 12:52:53AM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > > Just for fun I'll start doing a -s64 run.
> 
> (which had the same result).
> 
> > Okay, so before finding bad commits, if possible, can you get block traces?
> 
> If you can teach me how to, sure!
> 
> In the meantime, maybe what happened is that f2fs leaves some gaps (e.g.
> for alignment) when writing now, and didn't in 3.18? That would somehow
> explain what I see.
> 
> Except that with the 3.18 code, there is virtually no read access while
> writing to the disk for hours. With f2fs git, there is a small 16kb read
> every half a minute or so, and after a while, a lot of "reading a few
> mb/s, while writing a few mb/s".

In order to verify this also, could you retrieve the following logs?

# echo 1 > /sys/kernel/debug/tracing/tracing_on
# echo 1 > /sys/kernel/debug/tracing/events/f2fs/f2fs_submit_read_bio/enable
# echo 1 > /sys/kernel/debug/tracing/events/f2fs/f2fs_submit_write_bio/enable
# cat /sys/kernel/debug/tracing/trace_pipe

Thanks,

> 
> -- 
>                 The choice of a       Deliantra, the free code+content MORPG
>       -----==-     _GNU_              http://www.deliantra.net
>       ----==-- _       generation
>       ---==---(_)__  __ ____  __      Marc Lehmann
>       --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
>       -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
