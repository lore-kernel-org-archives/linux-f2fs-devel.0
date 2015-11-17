From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: blog article about f2fs on smr drives
Date: Tue, 17 Nov 2015 19:35:49 +0800
Message-ID: <000601d1212c$2fe92060$8fbb6120$@samsung.com>
References: <008401d12027$b15cd700$14168500$@samsung.com>
	<20151116235247.GF8583@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZyeYr-0006bm-AJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Nov 2015 11:36:33 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZyeYo-0001Ik-Uw
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Nov 2015 11:36:33 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NXY001W7IWNA340@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Nov 2015 20:36:23 +0900 (KST)
In-reply-to: <20151116235247.GF8583@schmorp.de>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Marc Lehmann' <schmorp@schmorp.de>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Marc,

> -----Original Message-----
> From: Marc Lehmann [mailto:schmorp@schmorp.de]
> Sent: Tuesday, November 17, 2015 7:53 AM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] blog article about f2fs on smr drives
> 
> On Mon, Nov 16, 2015 at 12:31:06PM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> > I think you could get the change information in below link:
> >
> > http://sourceforge.net/p/linux-f2fs/mailman/message/34427519/
> 
> Right, I saw the merge requests, but I don't know if these have been accepted
> for 4.3. I assume they are, thanks for finding them again for me.
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

As Jaegeuk mentioned, the serious problem here is all node allocaters who may
generate more dirty data later will be blocked by it, so continuous write
stream will be broken, IOs in disk may drop after a while.

> 
> I was a bit confused by the use of SMR, as SMRs don't suffer more from
> random reads as othere rotational devices (in fact, they can suffer less,
> if the data is still in the journal).

You mean journal region in disk, right? Read IO still goes to that region on
disk. So why SMR suffers less than other rotations? Or readahead in that region
can do some help when most of random reads goes to the journal.

> 
> > > Sure, will be happy to do that, what should I tune how? And thanks for
> > > working on this!
> >
> > IMO, one way is to do the test with default value and then do geometrically
> > increasing with the value to see how it affects the IO.
> 
> I am not sure I can make a large number of tests, I will try to do smaller
> tests and see if I can make more of them and see a difference.

That's OK, one thing I should mention is that small file is preferred in our
test. :)

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


------------------------------------------------------------------------------
