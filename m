From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: SMR drive test 2; 128GB partition;
 no obvious corruption, much more sane behaviour, weird
 overprovisioning
Date: Fri, 25 Sep 2015 16:05:48 +0800
Message-ID: <01bc01d0f769$15c05f60$41411e20$@samsung.com>
References: <20150808205003.GA6546@schmorp.de>
	<20150810203106.GA4575@jaegeuk-mac02>
	<20150920235901.GA7017@schmorp.de>
	<20150921081748.GA5637@schmorp.de> <20150921081937.GA5718@schmorp.de>
	<20150921095806.GA6809@schmorp.de>
	<20150923011239.GA32520@jaegeuk-mac02.mot.com>
	<20150923041523.GB4946@schmorp.de> <20150923060037.GA6667@schmorp.de>
	<011201d0f5dd$c3a4f650$4aeee2f0$@samsung.com>
	<20150923233022.GD3463@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZfO1f-0006b8-PE
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Sep 2015 08:06:39 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZfO1d-0004iV-6f
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Sep 2015 08:06:39 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NV800YNU3UTRG40@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Sep 2015 17:06:29 +0900 (KST)
In-reply-to: <20150923233022.GD3463@schmorp.de>
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
Cc: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Marc Lehmann [mailto:schmorp@schmorp.de]
> Sent: Thursday, September 24, 2015 7:30 AM
> To: Chao Yu
> Cc: 'Jaegeuk Kim'; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] SMR drive test 2; 128GB partition; no obvious corruption, much more
> sane behaviour, weird overprovisioning
> 
> On Wed, Sep 23, 2015 at 04:55:57PM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> > >    echo 1 >gc_idle
> > >    echo 1000 >gc_max_sleep_time
> > >    echo 5000 >gc_no_gc_sleep_time
> >
> > One thing I note is that gc_min_sleep_time is not be set in your script,
> > so in some condition gc may still do the sleep with gc_min_sleep_time (30
> > seconds by default) instead of gc_max_sleep_time which we expect.
> 
> Ah, sorry, I actually set gc_min_sleep_time to 100, but forgot to include
> it.
> 
> > In 4.3 rc1 kernel, we have add a new ioctl to trigger in batches gc, maybe
> > we can use it as one option.
> 
> Yes, such an ioctl could be useful to me, although I do not intend to have
> background gc off.
> 
> I assume that the ioctl will block for the time it runs, and I can ask it
> to do up to 16 batches in one go (by default)? That sounds indeed very

Actually, we should set the value of 'count' parameter to indicate how many
times we want to do gc in one batch, at most 16 times in a loop for each
ioctl invoking:
        ioctl(fd, F2FS_IOC_GC, &count);
After ioctl retruned successfully, 'count' parameter will contain the count
of gces we did actually.

> useful to have.
> 
> What is "one batch" in terms of gc, one section?

One batch means a certain number of gces excuting serially.

We have foreground/background mode in gc procedure:
1) For forground gc mode, it will try to gc several sections until there are
enough free sections;
2) For background gc mode, it will try to gc one section.
So we will not know how many sections will be freed in one batch, because it
depends on a) which mode we will use (gc mode is dynamically depending on current
status of free section/dirty datas) and b) whether a victim exist or not.

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
