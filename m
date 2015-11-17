From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: blog article about f2fs on smr drives
Date: Mon, 16 Nov 2015 16:05:13 -0800
Message-ID: <20151117000513.GB67331@jaegeuk.local>
References: <008401d12027$b15cd700$14168500$@samsung.com>
	<20151116235247.GF8583@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZyTly-00059J-V5
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Nov 2015 00:05:22 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZyTlx-0000mg-Hp for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Nov 2015 00:05:22 +0000
Content-Disposition: inline
In-Reply-To: <20151116235247.GF8583@schmorp.de>
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

On Tue, Nov 17, 2015 at 12:52:47AM +0100, Marc Lehmann wrote:
> On Mon, Nov 16, 2015 at 12:31:06PM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> > I think you could get the change information in below link:
> > 
> > http://sourceforge.net/p/linux-f2fs/mailman/message/34427519/
> 
> Right, I saw the merge requests, but I don't know if these have been accepted
> for 4.3. I assume they are, thanks for finding them again for me.

Of course, those were merged.

> 
> > > While there are stretches at >>100MB/s, most of the time, this is at less,
> > > and often for long stretches at ~10MB/s, which is the reason the end
> > > result is (relatively) bad.
> > 
> > Could you please share us IO trace log?
> 
> I am already working on it, I just didn't expect it to be a problem. Also,
> I did it without your patch.
> 
> > > And lastly, is there a document describing the implementation of
> > > encryption in the fs, and the goals (privacy? integrity? both?)
> > 
> > The feature was ported from ext4, please refer following article:
> > 
> > https://lwn.net/Articles/639427/
> 
> I see, so it inherits all the security issues of that design.
> 
> > Actually, as I test in flash device, it does help to improve performance in
> > workload of creating nodes aggressively, this is because we add asynchronous
> > readahead to mitigate small synchronous random read which may block all APPs
> > sometime. Considering rotational device has worse random synchronous read
> > performance, I expect better result in SMR.
> 
> Ok, that could help, as even a relatively small number of random reads could
> cause performance regressions (did the original 3.18 code not yet do this?)
> 
> I was a bit confused by the use of SMR, as SMRs don't suffer more from
> random reads as othere rotational devices (in fact, they can suffer less,
> if the data is still in the journal).

The important point here is that such the read operations to build free nids
hurts the concurrency of filesystem operations.

> 
> > > Sure, will be happy to do that, what should I tune how? And thanks for
> > > working on this!
> > 
> > IMO, one way is to do the test with default value and then do geometrically
> > increasing with the value to see how it affects the IO.
> 
> I am not sure I can make a large number of tests, I will try to do smaller
> tests and see if I can make more of them and see a difference.

Thanks,

> 
> Thanks again!
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
> Presto, an open source distributed SQL query engine for big data, initially
> developed by Facebook, enables you to easily query your data on Hadoop in a 
> more interactive manner. Teradata is also now providing full enterprise
> support for Presto. Download a free open source copy now.
> http://pubads.g.doubleclick.net/gampad/clk?id=250295911&iu=/4140
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
